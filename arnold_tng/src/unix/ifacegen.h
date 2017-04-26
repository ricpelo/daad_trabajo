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
#ifndef __GENERIC_INTERFACE_HEADER_INCLUDED__
#define __GENERIC_INTERFACE_HEADER_INCLUDED__

#include "../cpc/cpcglob.h"

#include "../cpc/multface.h"

BOOL Multiface_LoadRomFromFile(const MULTIFACE_ROM_TYPE RomType, const char *pFilename);


/* insert a snapshot */
BOOL	GenericInterface_LoadSnapshot(const char *FilenameBuffer);
/* insert a tape-image or sample file */
BOOL	GenericInterface_InsertTape(const char *FilenameBuffer);

/* insert a cartridge */BOOL	GenericInterface_InsertCartridge(const char *FilenameBuffer);

/* restore settings */
void	GenericInterface_RestoreSettings(void);
/* store settings */
void	GenericInterface_StoreSettings(void);

BOOL	GenericInterface_SaveScreenSnapshot(const char *FilenameBuffer);
BOOL	GenericInterface_WavOutputStartRecording(const char *FilenameBuffer);

BOOL	GenericInterface_LoadRom(int RomIndex, const char *FilenameBuffer);

BOOL	GenericInterface_SnapshotSave(const char *FilenameBuffer, int nSnapshotVersion, int nSnapshotSize);

BOOL	GenericInterface_InsertDiskImage(int DriveIndex, const char *pFilename);

/* start recording a sound file for StSound */
void	GenericInterface_AYStartRecording(const char *FilenameBuffer);

#include "../cpc/multface.h"

int Multiface_LoadRomFromFile(const MULTIFACE_ROM_TYPE RomType, const char *pFilename);



#endif

