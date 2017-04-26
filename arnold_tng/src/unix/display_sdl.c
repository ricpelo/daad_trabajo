/*
 *  Arnold emulator (c) Copyright, Kevin Thacker 1995-2001
 *
 *  This file is part of the Arnold emulator source code distribution.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */
/* display_sdl */
#ifdef HAVE_SDL
#include "display.h"
#include "sound.h"
#include <string.h>
#include <stdlib.h>
#include "../cpc/messages.h"

//#define USE_ASM 1

SDL_Surface *screen;
BOOL fullscreen = FALSE;	//FIXME
BOOL toggleFullscreenLater = FALSE;
int scale = 1;
//int mode = SDL_SWSURFACE;
int mode = SDL_HWSURFACE|SDL_DOUBLEBUF;

static INLINE void debug(char *s) {
	fprintf(stderr,"%s\n",s);
}

void sdl_InitialiseKeyboardMapping(int);
void sdl_InitialiseJoysticks(void);

#include <SDL/SDL_syswm.h>
#include <X11/X.h>

#define CPC_WARPFACTORMAX 16 /* Maximum allowed warp speed factor */
int cpc_warpfactor=1;        /* Current CPC warp speed factor */

#ifdef HAVE_GL
#include <GL/gl.h>
#define SDL_SCRLENX 384     /* Width and height of the CPC screen drawn by Arnold */
#define SDL_SCRLENY 272
#define SDL_TEXLENX 512     /* Width and height of the corresponding texture, must be a power of 2 */
#define SDL_TEXLENY 512
#define SDL_TEXSCALE 5      /* Scaling factor for CPC screen texture to allow zooming in */
#define SDL_CLIPZ 100000    /* Distance of the far Z-clipping plane */
#ifdef MACOS
  /* IN MACOSX, THIS IS MUCH FASTER */
  #define GL_BGRAFORMAT GL_UNSIGNED_INT_8_8_8_8_REV
#else
  /* IN LINUX (ATI RADEON) THIS IS MUCH FASTER */
  #define GL_BGRAFORMAT GL_UNSIGNED_BYTE
#endif
int sdl_eyedis;             /* Distance between eye and viewplane */
int sdl_scrposz;            /* The screen Z-position (zoom) */
int sdl_zoomspeed;          /* Current speed of window zooming with Ctrl+Cursor Up/Down */
int sdl_warpfacdisptime;    /* Number of screen updates left until the warp factor is no longer displayed */
GLuint sdl_texture;         /* Texture with CPC screen */
SDL_Surface *sdl_texbuffer; /* Buffer to store texture data before upload */
#endif

void sdl_SetDisplay(int Width, int Height, int Depth, BOOL wantfullscreen) {

	int i,accepted,format;
	SDL_SysWMinfo wm;

	fullscreen = wantfullscreen;
	fprintf(stderr, Messages[106], Width, Height, Depth);
	if ( !fullscreen ) {
		mode &= ~SDL_OPENGL;
		mode &= ~SDL_FULLSCREEN;
	} else {
		/* Fullscreen requested */
		mode |= SDL_FULLSCREEN;
#ifdef HAVE_GL
		if (sdl_texbuffer) {
			/* Delete previous texture */
			glDeleteTextures(1,&sdl_texture);
			SDL_FreeSurface(sdl_texbuffer);
			sdl_texbuffer=NULL;
		}
		mode |= SDL_OPENGL;
		SDL_GL_SetAttribute(SDL_GL_RED_SIZE,8);
		SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE,8);
		SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE,8);
		SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE,8);
		SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE,0);
		SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER,1);
		/* SYNC TO VERTICAL RETRACE */
		/* 16 = SDL_GL_SWAP_CONTROL, WHICH IS NOT IN THE OLD WINDOWS SDL HEADERS */
		SDL_GL_SetAttribute(16,1);
		/* Get native screen resolution */
		SDL_VERSION(&wm.version);
		if (SDL_GetWMInfo(&wm)>0) {
			Width=DisplayWidth(wm.info.x11.display,DefaultScreen(wm.info.x11.display));
			Height=DisplayHeight(wm.info.x11.display,DefaultScreen(wm.info.x11.display));
			fprintf(stderr,"Using native fullscreen resolution %dx%d.\n",Width,Height);
		}
#endif
	}
	screen = SDL_SetVideoMode(Width, Height, Depth, mode);
	if ( screen == NULL ) {
		fprintf(stderr, Messages[107],
			Width, Height, Depth, SDL_GetError());
		exit(1);
	}
#ifdef HAVE_GL
	if (fullscreen) {
		/* Setup OpenGL parameters */
		glShadeModel(GL_SMOOTH);
		glDisable(GL_CULL_FACE);
		glPixelStorei(GL_UNPACK_ALIGNMENT,1);
		/* The three OpenGL transformations */
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		/* Set distance between eye and viewplane, simply the width of the screen */
		sdl_eyedis=Width;
		/* The CPC screen is drawn at five times this depth by default, so that it can zoom
		   in closer before being clipped. sdl_eyedis-1 is for nVIDIA cards which clip too soon */
		sdl_scrposz=sdl_eyedis*SDL_TEXSCALE;
		glFrustum(-Width*0.5,Width*0.5,-Height*0.5,Height*0.5,sdl_eyedis-1,sdl_eyedis+SDL_CLIPZ);
		//printf("Frustum=%f,%f,%f,%f,%d,%d\n",-Width*0.5,Width*0.5,-Height*0.5,Height*0.5,sdl_eyedis,sdl_eyedis+SDL_CLIPZ);
		glViewport(0,0,(GLsizei)Width,(GLsizei)Height);
		glClearColor(0,0,0,0);
		glDrawBuffer(GL_FRONT);
		glClear(GL_COLOR_BUFFER_BIT);
		glDrawBuffer(GL_BACK);
		glClear(GL_COLOR_BUFFER_BIT);
		/* Define texture which will contain the CPC screen */
		/* Warning: The order of the RGB components is flipped to BGR to match texture upload */
		sdl_texbuffer=SDL_CreateRGBSurface(SDL_SWSURFACE,SDL_TEXLENX,SDL_TEXLENY,32,0x00ff0000,0x0000ff00,0x000000ff,0xff000000);
		glGenTextures(1,&sdl_texture);
		glBindTexture(GL_TEXTURE_2D,sdl_texture);
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
		/* Determine best format for textures and upload */
		format=GL_RGBA8;
		do {
  		glTexImage2D(GL_PROXY_TEXTURE_2D,0,format,SDL_TEXLENX,SDL_TEXLENY,0,GL_RGBA,GL_UNSIGNED_BYTE,NULL);
			glGetTexLevelParameteriv(GL_PROXY_TEXTURE_2D,0,GL_TEXTURE_INTERNAL_FORMAT,&accepted);
			if (!accepted) {
				if (format==GL_RGBA8) format=GL_RGB5_A1;
				else {
					fprintf(stderr,"Cannot allocate OpenGL texture");
					exit(1);
				}
			}
		} while (!accepted);
		glTexImage2D(GL_TEXTURE_2D,0,format,SDL_TEXLENX,SDL_TEXLENY,0,GL_RGBA,GL_UNSIGNED_BYTE,sdl_texbuffer->pixels);
	}
#endif
}

void sdl_SetDisplayWindowed(int Width, int Height, int Depth) {

	sdl_SetDisplay(Width, Height, Depth, FALSE);
	SDL_ShowCursor(SDL_ENABLE);

}

void sdl_SetDisplayFullscreen(int Width, int Height, int Depth) {

	sdl_SetDisplay(Width, Height, Depth, TRUE);
	SDL_ShowCursor(SDL_DISABLE);

}

void sdl_toggleDisplayFullscreen() {
	fullscreen = !fullscreen;
	if (fullscreen) {
		sdl_SetDisplayFullscreen(screen->w,screen->h,
				screen->format->BitsPerPixel);
	} else {
#ifndef HAVE_GL
		sdl_SetDisplayWindowed(screen->w,screen->h,
				screen->format->BitsPerPixel);
#else
		/* In OpenGL mode, we work with the native screen resolution,
		   which we don't want in window mode */
		sdl_SetDisplayWindowed(SDL_SCRLENX*scale,SDL_SCRLENY*scale,screen->format->BitsPerPixel);
#endif
	}
}

void sdl_SetDoubled( BOOL doubled ) {

	int w, h;

	scale = doubled ? 2 : 1;
	if ( doubled ) {
		w = screen->w * 2;
		h = screen->h * 2;
	} else {
		w = screen->w / 2;
		h = screen->h / 2;
	}
	sdl_SetDisplay( w, h, screen->format->BitsPerPixel, fullscreen);

}

static INLINE unsigned long CalcBPPFromMask(unsigned long Mask)
{
	unsigned long LocalShift = 0;
	unsigned long LocalBPP = 0;
	unsigned long LocalMask = Mask;

	if (LocalMask!=0)
	{
		do
		{
			if ((LocalMask & 0x01)!=0)
				break;

			LocalMask = LocalMask >>1;
			LocalShift++;
		}
		while (1==1);

		do
		{
			if ((LocalMask & 0x01)!=1)
				break;

			LocalMask = LocalMask>>1;
			LocalBPP++;
		}
		while (1==1);
	}

	return LocalBPP;
}

void sdl_GetGraphicsBufferColourFormat(GRAPHICS_BUFFER_COLOUR_FORMAT *pFormat) {
	SDL_PixelFormat *format = screen->format;

	pFormat->Red.Mask = format->Rmask;
	pFormat->Red.BPP = CalcBPPFromMask(format->Rmask);
	pFormat->Red.Shift = format->Rshift;

	pFormat->Green.Mask = format->Gmask;
	pFormat->Green.BPP = CalcBPPFromMask(format->Gmask);
	pFormat->Green.Shift = format->Gshift;

	pFormat->Blue.Mask = format->Bmask;
	pFormat->Blue.BPP = CalcBPPFromMask(format->Bmask);
	pFormat->Blue.Shift = format->Bshift;

	pFormat->BPP = format->BitsPerPixel;

	printf("BPP: %d\r\n",pFormat->BPP);
	printf("Red: M: %08x B: %d S: %d\r\n",pFormat->Red.Mask, pFormat->Red.BPP, pFormat->Red.Shift);
	printf("Green: M: %08x B: %d S: %d\r\n", pFormat->Green.Mask, pFormat->Green.BPP, pFormat->Green.Shift);
	printf("Blue: M: %08x B: %d S: %d\r\n",pFormat->Blue.Mask, pFormat->Blue.BPP, pFormat->Blue.Shift);
}

int sdl_CheckDisplay(void) {
	return 0;
}


void sdl_GetGraphicsBufferInfo(GRAPHICS_BUFFER_INFO *pBufferInfo) {
	SDL_Surface *buffer;

	buffer=screen;
#ifdef HAVE_GL
	if (fullscreen) buffer=sdl_texbuffer;
#endif
	pBufferInfo->pSurface = buffer->pixels;
	pBufferInfo->Width = buffer->w;
	pBufferInfo->Height = buffer->h;
	pBufferInfo->Pitch = buffer->pitch;
	//printf("get buffer info\r\n");
	//printf("W: %d H: %d P: %d\r\n",pBufferInfo->Width, pBufferInfo->Height,
		//pBufferInfo->Pitch);
}

BOOL sdl_LockGraphicsBuffer(void) {
#ifdef HAVE_GL
	if (fullscreen) return TRUE;
#endif
	if (SDL_LockSurface(screen) == 0) return TRUE;
	else return FALSE;
}

void sdl_UnlockGraphicsBuffer(void) {
#ifdef HAVE_GL
	unsigned char coltab[4];
	int i,j,sign;
	Uint32 color;
	Uint32 *pixels;
	float posx,posy,startx,starty,endx,endy,nativeratio,cpcratio,f;
	SDL_PixelFormat *format;

	if (fullscreen) {
		/* Calculate new Z-position of CPC window (can be zoomed with Ctrl+cursor keys) */
		sdl_scrposz+=sdl_zoomspeed*5*SDL_TEXSCALE;
		if (sdl_scrposz<sdl_eyedis) sdl_scrposz=sdl_eyedis;
		if (sdl_scrposz>sdl_eyedis*2*SDL_TEXSCALE) sdl_scrposz=sdl_eyedis*2*SDL_TEXSCALE;
		/* Determine position of CPC screen */
		nativeratio=(float)screen->w/screen->h;
		cpcratio=(float)SDL_SCRLENX/SDL_SCRLENY;
		if (nativeratio>cpcratio) {
			/* Native screen is wider than CPC screen */
			posy=screen->h*SDL_TEXSCALE*0.5;
			posx=posy*cpcratio;
		} else {
			/* Native screen is higher than CPC screen */
			posx=screen->w*SDL_TEXSCALE*0.5;
			posy=posx/cpcratio;
		}
		/* Determine background color: See if three pixel columns at the left and right
		   side of the CPC screen all have the same color (no overscan) */
		color=*(Uint32*)sdl_texbuffer->pixels;
		for (i=0;i<2;i++) {
			for (j=0;j<SDL_SCRLENY;j++) {
				pixels=(Uint32*)((char*)sdl_texbuffer->pixels+j*sdl_texbuffer->pitch)+i*(SDL_SCRLENX-3);
				if (pixels[0]!=color||pixels[1]!=color||pixels[2]!=color) {
					/* Color differs */
					color=0;
					break;
				}
			}
		}
		printf("Color=%x\n",color);
		/* Clear screen */
		glBegin(GL_QUADS);
		SDL_GetRGBA(color,sdl_texbuffer->format,coltab,coltab+1,coltab+2,coltab+3);
		glColor3f(coltab[0]/255.,coltab[1]/255.,coltab[2]/255.);
		glVertex3f(screen->w,screen->h,-sdl_eyedis);
		glVertex3f(-screen->w,screen->h,-sdl_eyedis);
		glVertex3f(-screen->w,-screen->h,-sdl_eyedis);
		glVertex3f(screen->w,-screen->h,-sdl_eyedis);
		glEnd();
		/* Upload texture */
		//printf("TexSubImage %d...\n",sdl_texture);
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D,sdl_texture);
		glPixelStorei(GL_UNPACK_ROW_LENGTH,SDL_TEXLENX);
		glTexSubImage2D(GL_TEXTURE_2D,0,0,0,SDL_SCRLENX,SDL_SCRLENY,GL_BGRA,GL_BGRAFORMAT,sdl_texbuffer->pixels);
		/* Draw texture, clipping 1 pixel on each side to prevent the linear texture filter
		   from accessing pixels outside the CPC screen */
		startx=1./SDL_TEXLENX;
		starty=1./SDL_TEXLENY;
		endx=(float)(SDL_SCRLENX-1)/SDL_TEXLENX;
		endy=(float)(SDL_SCRLENY-1)/SDL_TEXLENY;
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE);
		glBegin(GL_QUADS);
		glTexCoord2f(endx,starty);
		glVertex3f(posx,posy,-sdl_scrposz);
		glTexCoord2f(startx,starty);
		glVertex3f(-posx,posy,-sdl_scrposz);
		glTexCoord2f(startx,endy);
		glVertex3f(-posx,-posy,-sdl_scrposz);
		glTexCoord2f(endx,endy);
		glVertex3f(posx,-posy,-sdl_scrposz);
		glEnd();
		glDisable(GL_TEXTURE_2D);
		if (sdl_warpfacdisptime>0) {
			/* The warp factor should be displayed on screen */
			sdl_warpfacdisptime--;
			glBegin(GL_QUADS);
			startx=screen->w*0.45;
			endx=screen->w*0.48;
			for (i=0;i<cpc_warpfactor;i++) {
				starty=screen->h*(-0.45+i*0.05);
				endy=screen->h*(-0.45+i*0.05-0.03);
				f=(float)i/CPC_WARPFACTORMAX;
				glColor3f(1.0*f,1.0*(1-f),0);
				glVertex3f(endx,starty,-sdl_eyedis);
				glVertex3f(startx,starty,-sdl_eyedis);
				glVertex3f(startx,endy,-sdl_eyedis);
				glVertex3f(endx,endy,-sdl_eyedis);
			}
			glEnd();
		}
	}
#endif
	SDL_UnlockSurface(screen);
}

void scale32_array_fw_memcpy(Uint16 pitch, Uint32 *pixels32, int w, int h, int bpp) {
	int x, y, x2, y2;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, pel, *srcstop;
	int i;

	y2 = h-1;
	for ( y = h/2-1; y >= 0; y-- ) {
		x2 = 0;
		for (x = 0; x < w/2; x ++) {
			pixels32[y2*ll+x2] = pixels32[y*ll+x];
			x2++;
			pixels32[y2*ll+x2] = pixels32[y*ll+x];
			x2++;
		}
		memcpy(pixels32+(y2-1)*ll, pixels32+y2*ll, pitch);
		y2-=2;
	}
}

#ifdef USE_ASM
void scale32_asm(Uint16 pitch, Uint32 *pixels32, int w, int h, int bpp) {
	int x, y;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, *srcstop;
	int i;

	for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-1;
		dst2 = pixels32+(y-1)*ll+w-1;
		src = pixels32+y/2*ll+w/2-1;
		srcstop = src - (w/2);
		printf("begin asm: y: %i\np32: %p s: %p sst: %p dst: %p dst2: %p\n", y, pixels32, src, srcstop, dst, dst2);
		__asm__ __volatile__(
			"\n.LOOPASM:\n\t"
			//pel = *src--;
			"movl	(%%ebx), %%eax\n\t"
			"subl	$4, %%ebx\n\t"
			// *dst-- = pel;
			// *dst-- = pel;
			"movl	%%eax, (%%ecx)\n\t"
			"movl	%%eax, -4(%%ecx)\n\t"
			"subl	$8, %%ecx\n\t"
			// *dst2-- = pel;
			// *dst2-- = pel;
			"movl	%%eax, (%%edx)\n\t"
			"movl	%%eax, -4(%%edx)\n\t"
			"subl	$8, %%edx\n\t"
			"cmpl	%%ebx, %%esi\n\t"
			"jb	.LOOPASM\n\t"
			:
			: "b"(src), "c"(dst), "d"(dst2), "S"(srcstop)
			: "%eax"
		);
#if 0
		__asm__ __volatile__(
			"\n.LOOPASM:\n\t"
			//pel = *src--;
			"movl	(%0), %%eax\n\t"
			"subl	$4, %0\n\t"
			// *dst-- = pel;
			// *dst-- = pel;
			"movl	%%eax, (%1)\n\t"
			"movl	%%eax, -4(%1)\n\t"
			"subl	$8, %1\n\t"
			// *dst2-- = pel;
			// *dst2-- = pel;
			"movl	%%eax, (%2)\n\t"
			"movl	%%eax, -4(%2)\n\t"
			"subl	$8, %2\n\t"
			"cmpl	%0, %3\n\t"
			"jb	.LOOPASM\n\t"
			:
			: "r"(src), "r"(dst), "r"(dst2), "r"(srcstop)
			: "%eax"
		);
#endif
		//printf("end asm\n");
		//if (y < 2) break;
	}
}

void scale32_mmx_murks(Uint16 pitch, Uint32 *pixels32, int w, int h, int bpp) {
	int x, y;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, *srcstop;
	int i;

	for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-2;
		dst2 = pixels32+(y-1)*ll+w-2;
		src = pixels32+y/2*ll+w/2-2;
		srcstop = src - (w/2);
		__asm__ __volatile__(
			"\n.p2align 4\n"
			".LOOPMMX:\n\t"
			//pel = *src--;
			"movq	(%0), %%mm0\n\t"	// move 2 pels at once
			"subl	$8, %0\n\t"		// step 2 pels
			"movq	%%mm0, %%mm1\n\t"	// make a copy
			"punpckldq	%%mm0, %%mm0\n\t"	// duplicate 1st pel
			"punpckldq	%%mm1, %%mm1\n\t"	// duplicate 2nd pel
			// *dst-- = pel;
			// *dst-- = pel;
			"movq	%%mm0, (%1)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%1)\n\t"	// 2nd pel x2
			"subl	$16, %1\n\t"		// step 2x2 pels
			// *dst2-- = pel;
			// *dst2-- = pel;
			"movq	%%mm0, (%2)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%2)\n\t"	// 2nd pel x2
			"subl	$16, %2\n\t"		// step 2x2 pels
			"cmpl	%0, %3\n\t"
			"jb	.LOOPMMX\n\t"
			"emms\n\t"
			:
			: "r"(src), "r"(dst), "r"(dst2), "r"(srcstop)
			: "%eax"
		);
	}
}

void scale32_mmx_unreg(Uint16 pitch, Uint32 *pixels32, int w, int h, int bpp) {
	int x, y;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, *srcstop;
	int i;

	for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-2;
		dst2 = pixels32+(y-1)*ll+w-2;
		src = pixels32+y/2*ll+w/2-2;
		srcstop = src - (w/2);
		printf("begin asm: y: %i\np32: %p s: %p sst: %p dst: %p dst2: %p\n", y, pixels32, src, srcstop, dst, dst2);
		__asm__ __volatile__(
			"\n.p2align 4\n"
			".LOOP:\n\t"
			//pel = *src--;
			"movq	(%0), %%mm0\n\t"	// move 2 pels at once
			"movq	%%mm0, %%mm1\n\t"	// make a copy
			"punpckldq	%%mm0, %%mm0\n\t" // duplicate 1st pel
			"punpckldq	%%mm1, %%mm1\n\t" // duplicate 2nd pel

			"movq	-8(%0), %%mm2\n\t"	// move 2 pels at once
			"movq	%%mm2, %%mm3\n\t"	// make a copy
			"punpckldq	%%mm2, %%mm2\n\t" // duplicate 1st pel
			"punpckldq	%%mm3, %%mm3\n\t" // duplicate 2nd pel

			"movq	-16(%0), %%mm4\n\t"	// move 2 pels at once
			"movq	%%mm4, %%mm5\n\t"	// make a copy
			"punpckldq	%%mm4, %%mm4\n\t" // duplicate 1st pel
			"punpckldq	%%mm5, %%mm5\n\t" // duplicate 2nd pel

			"movq	-24(%0), %%mm6\n\t"	// move 2 pels at once
			"movq	%%mm6, %%mm7\n\t"	// make a copy
			"punpckldq	%%mm6, %%mm6\n\t" // duplicate 1st pel
			"punpckldq	%%mm7, %%mm7\n\t" // duplicate 2nd pel

			"subl	$32, %0\n\t"		// step 8 pels

			// *dst-- = pel;
			// *dst-- = pel;
			"movq	%%mm0, (%1)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%1)\n\t"	// 2nd pel x2
			"movq	%%mm2, -16(%1)\n\t"	// 2nd pel x2
			"movq	%%mm3, -24(%1)\n\t"	// 2nd pel x2
			"movq	%%mm4, -32(%1)\n\t"	// 2nd pel x2
			"movq	%%mm5, -40(%1)\n\t"	// 2nd pel x2
			"movq	%%mm6, -48(%1)\n\t"	// 2nd pel x2
			"movq	%%mm7, -56(%1)\n\t"	// 2nd pel x2
			"subl	$32, %1\n\t"		// step 8x2 pels
			// *dst2-- = pel;
			// *dst2-- = pel;
			"movq	%%mm0, (%2)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%2)\n\t"	// 2nd pel x2
			"movq	%%mm2, -16(%2)\n\t"	// 2nd pel x2
			"movq	%%mm3, -24(%2)\n\t"	// 2nd pel x2
			"movq	%%mm4, -32(%2)\n\t"	// 2nd pel x2
			"movq	%%mm5, -40(%2)\n\t"	// 2nd pel x2
			"movq	%%mm6, -48(%2)\n\t"	// 2nd pel x2
			"movq	%%mm7, -56(%2)\n\t"	// 2nd pel x2
			"subl	$32, %1\n\t"		// step 8x2 pels
			"cmpl	%0, %3\n\t"
			"jb	.LOOP\n\t"
			"emms\n\t"
			//:
			: "+r"(src), "+r"(dst), "+r"(dst2), "+r"(srcstop)
			//: "r"(src), "r"(dst), "r"(dst2), "r"(srcstop)
			:
			: "%mm0", "%mm1", "%mm2", "%mm3", "%mm4", "%mm5", "%mm6", "%mm7"
		);
		//printf("end asm\n")
	}
}

void scale32_mmx(Uint16 pitch, Uint32 *pixels32, int w, int h, int bpp) {
	int x, y;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, *srcstop;
	int i;

	for ( y = h-1; y >= 272; y-=2 ) {
		dst = pixels32+y*ll+w-2;
		dst2 = pixels32+(y-1)*ll+w-2;
		src = pixels32+y/2*ll+w/2-2;
		srcstop = src - (w/2);
		printf("begin asm: y: %i\np32: %p s: %p sst: %p dst: %p dst2: %p\n", y, pixels32, src, srcstop, dst, dst2);
		__asm__ __volatile__(
			"\n.p2align 4\n"
			".LOOP1:\n\t"
			//pel = *src--;
			"movq	(%%ebx), %%mm0\n\t"	// move 2 pels at once
			"movq	%%mm0, %%mm1\n\t"	// make a copy
			"punpckldq	%%mm0, %%mm0\n\t" // duplicate 1st pel
			"punpckldq	%%mm1, %%mm1\n\t" // duplicate 2nd pel

			"movq	-8(%%ebx), %%mm2\n\t"	// move 2 pels at once
			"movq	%%mm2, %%mm3\n\t"	// make a copy
			"punpckldq	%%mm2, %%mm2\n\t" // duplicate 1st pel
			"punpckldq	%%mm3, %%mm3\n\t" // duplicate 2nd pel

			"movq	-16(%%ebx), %%mm4\n\t"	// move 2 pels at once
			"movq	%%mm4, %%mm5\n\t"	// make a copy
			"punpckldq	%%mm4, %%mm4\n\t" // duplicate 1st pel
			"punpckldq	%%mm5, %%mm5\n\t" // duplicate 2nd pel

			"movq	-24(%%ebx), %%mm6\n\t"	// move 2 pels at once
			"movq	%%mm6, %%mm7\n\t"	// make a copy
			"punpckldq	%%mm6, %%mm6\n\t" // duplicate 1st pel
			"punpckldq	%%mm7, %%mm7\n\t" // duplicate 2nd pel

			"subl	$32, %%ebx\n\t"		// step 8 pels

			// *dst-- = pel;
			// *dst-- = pel;
			"movq	%%mm0, (%%ecx)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm2, -16(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm3, -24(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm4, -32(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm5, -40(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm6, -48(%%ecx)\n\t"	// 2nd pel x2
			"movq	%%mm7, -56(%%ecx)\n\t"	// 2nd pel x2
			"subl	$32, %%ecx\n\t"		// step 8x2 pels
			// *dst2-- = pel;
			// *dst2-- = pel;
			"movq	%%mm0, (%%edx)\n\t"	// 1st pel x2
			"movq	%%mm1, -8(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm2, -16(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm3, -24(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm4, -32(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm5, -40(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm6, -48(%%edx)\n\t"	// 2nd pel x2
			"movq	%%mm7, -56(%%edx)\n\t"	// 2nd pel x2
			"subl	$32, %%ecx\n\t"		// step 8x2 pels
			"cmpl	%%ebx, %%esi\n\t"
			"jb	.LOOP1\n\t"
			"emms\n\t"
			:
			: "b"(src), "c"(dst), "d"(dst2), "S"(srcstop)
			: "%mm0", "%mm1", "%mm2", "%mm3", "%mm4", "%mm5", "%mm6", "%mm7"
		);
		//printf("end asm\n")
	}
}
#endif

void sdl_DoubleGraphicsBuffer32(void) {
	int x, y;
	Uint16 pitch = screen->pitch;
	Uint32 *pixels32 = (Uint32 *) screen->pixels;
	int w = screen->w;
	int h = screen->h;
	int bpp = screen->format->BytesPerPixel;
	int ll = pitch/bpp;
	Uint32 *src, *dst, *dst2, pel, *srcstop;
	int i;

	SDL_LockSurface(screen);
	scale32_array_fw_memcpy(pitch, pixels32, w, h, bpp);
	//scale32_mmx(pitch, pixels32, w, h, bpp);
	// works, but VERY slow
	/*for ( y = h-1; y >= 0; y-- ) {
		for ( x = w-1; x >= 0; x-- ) {
			*(pixels32+y*ll+x) = *(pixels32+y/2*ll+x/2);
		}
	}*/
	// Faster? Probably, but only a bit.
	/*for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-1;
		dst2 = pixels32+(y-1)*ll+w-1;
		src = pixels32+y/2*ll+w/2-1;
		for ( x = w/2-1; x >= 0; x-- ) {
			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;
		}
	}*/
	// Take 3
	/*for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-1;
		dst2 = pixels32+(y-1)*ll+w-1;
		src = pixels32+y/2*ll+w/2-1;
		x = w/2;
		do {
			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;
		} while (--x > 0);
	}*/
	// Take 4
	/*for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels32+y*ll+w-1;
		dst2 = pixels32+(y-1)*ll+w-1;
		src = pixels32+y/2*ll+w/2-1;
		srcstop = src - (w/2);
		do {
			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;

			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;

			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;

			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;
		} while (src > srcstop);
	}*/
	SDL_UnlockSurface(screen);
}

void sdl_DoubleGraphicsBuffer16(void) {
	int x, y;
	Uint16 pitch = screen->pitch;
	Uint16 *pixels16 = (Uint16 *) screen->pixels;
	int w = screen->w;
	int h = screen->h;
	int bpp = screen->format->BytesPerPixel;
	int ll = pitch/bpp;
	Uint16 *src, *dst, *dst2, pel;
	int i;

	SDL_LockSurface(screen);
	for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels16+y*ll+w-1;
		dst2 = pixels16+(y-1)*ll+w-1;
		src = pixels16+y/2*ll+w/2-1;
		for ( x = w/2-1; x >= 0; x-- ) {
			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;
		}
	}
	SDL_UnlockSurface(screen);
}

void sdl_DoubleGraphicsBuffer8(void) {
	int x, y;
	Uint16 pitch = screen->pitch;
	Uint8 *pixels8 = (Uint8 *) screen->pixels;
	int w = screen->w;
	int h = screen->h;
	int bpp = screen->format->BytesPerPixel;
	int ll = pitch/bpp;
	Uint8 *src, *dst, *dst2, pel;
	int i;

	SDL_LockSurface(screen);
	for ( y = h-1; y >= 0; y-=2 ) {
		dst = pixels8+y*ll+w-1;
		dst2 = pixels8+(y-1)*ll+w-1;
		src = pixels8+y/2*ll+w/2-1;
		for ( x = w/2-1; x >= 0; x-- ) {
			pel = *src--;
			*dst-- = pel;
			*dst-- = pel;
			*dst2-- = pel;
			*dst2-- = pel;
		}
	}
	SDL_UnlockSurface(screen);
}

void sdl_DoubleGraphicsBuffer(void) {

	int bpp = screen->format->BytesPerPixel;
	switch( bpp ) {
		case 1:
			sdl_DoubleGraphicsBuffer8();
			break;
		case 2:
			sdl_DoubleGraphicsBuffer16();
			break;
		case 4:
			sdl_DoubleGraphicsBuffer32();
			break;
		default:	/* unsupported */
			break;
	}
}

void sdl_SwapGraphicsBuffers(void) {
#ifdef HAVE_GL
	if (fullscreen) {
		SDL_GL_SwapBuffers();
		return;
	}
#endif
	if ( scale == 2 ) sdl_DoubleGraphicsBuffer();
	//SDL_UpdateRects(screen,1,&screen->clip_rect);
	SDL_Flip( screen );
}

/* Some comments about throttling on Linux/Unix:
 * Originally I used the nice and portable SDL_GetTicks() and SDL_Delay()
 * functions. Unfortunately the resolution is bad and the result is very
 * dodgy. Therefore I used the gettimeofday() and usleep() functions. This is
 * POSIX, but not SDL and therefore not directly portable to non-POSIX SDL
 * Targets.
 * I left in the SDL in case someone wants to try.
 * FIXME: Maybe we can get rid of floating point here?
 */
/* Get elapsed time in microseconds
   Works correctly for time intervals up to ~4000 seconds */
unsigned long sdl_GetMicrosecondsDelta()
{
	static struct timeval t1, t2;
	unsigned long dt;

	gettimeofday(&t1,NULL);
	dt=(t1.tv_sec - t2.tv_sec)*1000000+(t1.tv_usec - t2.tv_usec); /* 1000000 microseconds in a second... */
	//printf("\ntime: %i %i %i %i delta: %f\n",t1.tv_sec, t2.tv_sec, t1.tv_usec, t2.tv_usec, dt);
	memcpy( &t2, &t1, sizeof(t2) );
	return dt;
}
/*
unsigned long long sdl_GetMicroseconds() {
	struct timeval t1;

	gettimeofday(&t1,NULL);
	return (t1.tv_sec*1000000+t1.tv_usec);
}
*/

#define SDL_REFRESHMAX 200

/* Determine current screen refresh rate
   This only works if the video driver has sync to vblank enabled.
   Returns 0 if unsuccessful. */
int sdl_RefreshRate(void) {
	int i,refresh;
	int refreshguess[SDL_REFRESHMAX];

	memset(refreshguess,0,sizeof(refreshguess));
	sdl_GetMicrosecondsDelta();
	/* We need ~70 tries */
	for (i=0;i<70;i++) {
		SDL_Flip( screen );
		refresh=1e6/sdl_GetMicrosecondsDelta();
		//printf("Got refresh rate %d\n",refresh);
		if (refresh<SDL_REFRESHMAX) {
			/* Valid refresh rate */
			refreshguess[refresh]++;
			if (refreshguess[refresh]==10) {
				/* Yep, got 10 times the same result */
				if (refresh<45) {
					/* Unfortunately no screen is soo slow, so this is unsynchronized */
					return(0);
				}
				return(refresh);
			}
		}
	}
	/* No luck, inconsistent results */
	return(0);
}

int sdl_fps = 50;

/* Set SDL frames per second */
void sdl_SetFPS(int fps) {
	sdl_fps=fps;
}
int sdl_LockSpeed = TRUE;
//#ifdef BUSYWAIT
//static unsigned long PreviousTime=0;
//unsigned long TimeError = 0;
//#endif

void sdl_Throttle(void) {
	if (toggleFullscreenLater) {
		toggleFullscreenLater = FALSE;
		sdl_toggleDisplayFullscreen();
	}
	if (sdl_LockSpeed)
	{
		static Uint32 next_tick = 0;
		Uint32 this_tick;

		if (!sound_throttle()) {
			/* Wait for the next frame */
			this_tick = SDL_GetTicks();
			if ( this_tick < next_tick ) {
				SDL_Delay(next_tick-this_tick);
				next_tick = next_tick + (1000/sdl_fps);
			} else {
				next_tick = this_tick + (1000/sdl_fps);
			}
		}
		//fprintf(stderr,"(%i %i) ",this_tick,next_tick);
#if 0
#ifndef BUSYWAIT
		long delay;
		delay = 10000/FRAMES_PER_SEC - delta_time();
		if (delay>0 && audio_waterlevel > AUDIO_WATERMARK )
			usleep(delay);	// FIXME*/
#else
		/* use this to throttle speed */
		unsigned long	TimeDifference;
		unsigned long	Time;

		do
		{
			/* get current time */
			Time = timeGetTime();

			/* calc time difference */
			TimeDifference = Time - (PreviousTime-TimeError);
		}
		while (TimeDifference<(1000/50));

		TimeError = (TimeDifference - (1000/50)) % (1000/50);

		PreviousTime = Time;
#endif
#endif

	}

	CPC_UpdateAudio();
	sdl_HandleMouse(NULL);
}

#include "keyboard_sdl.c"
#endif		/* HAVE_SDL */

