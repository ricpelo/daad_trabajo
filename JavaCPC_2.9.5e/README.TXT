Update from v2.9.5d to 2.9.5e changelog:
- Important bugfix in ROM handling (JavaCPC was not able to recognize the selected OS, which is important for some apps to work properly)
- Bugfix in JavaCPC Paint
- Bugfix in ModeXPaint GUI

Update from v2.9.5b to v 2.9.5d changelog:

New features:
- ModeX Paint added (Available from Menu, experimental)
- Ability to store and read 4MB SNApshots (SNA V2 compatible)

Update from v2.9.4 to v2.9.5b changelog:

New features:
- Assembler understands command "define"
Syntax:
define .myfile = "MYFILE.BIN"
define .mycode = "MYCODE.ASM"
INCBIN .myfile
READ .mycode
this works with INCBIN, INCLUDE and READ (READ is similar to INCLUDE)
When you use INCBIN / INCLUDE / READ instructions, make sure, the additional files are in the same folder than your assembly code.

- Assembler: added IFDEF check
IFDEF does not check the value given to a label, just checks if this label has been defined.
Syntax:
ifdef mylabel
<asm code here>
else
<asm code there>
endif
- Fixed LD IXH,x and related instructions

Updates:
- RasterPaint is improved. You can now select every single zone/line to disable autogeneration for palette. (last palette is used then)
This is VERY useful to remove some unwanted stripes.
Use right mouse button into preview window:
1x clicked: rastermode 1: zones are selectable. (You can see them) Click one to toggle as active (default) or inactive
2x clicked: rastermode 2: lines are selectable. Click them to toggle, too
3x clicked: rastermode 3: zones AND lines are visible and toggle on click
You need to play around with that. But it really can improve the result.
- RasterPaint: Image can be opened in a 3x zoomed frame. It has the same rastermodes to select zones and lines like the main window. Makes it easier to find / hit the correct zones.
- RasterPaint: Image, which is vertically higher than 320x200 pixel ratio can be scrolled up/down now.
- An emulator has been added :P (You can only use it with a special cheat command from console...) (Hint: It's not a toaster but may have to do with bread)

Many more things fixed, which I forgot now to list were made, too.
And, as usual: Many new bugs added for your pleasure ;-)

Update from v2.9.3 to v2.9.4 changelog:

- Fixed the raster code for RasterPaint. Old code caused bad behavior in FDC and PPI ports.
- Reimplemented port-behavior problems for FDC emulation. (I once disabled them, for internal testings)
- RasterPaint: Function added to export the raster screens directly as executable binaries.
- RasterPaint: Raster table and screen pixeldata are simply crunched now (When export binaries)
- Removed "New CPC / Old CPC" setting. For CPC Plus / New CPC you need the source file. By default it renders for old CPC.
- Added: RasterScreen.asm for developers (To assemble for New generation CPCs, too)

Update from v2.9.20 to 2.9.3 changelog:

- Added application "RasterPaint". Convert pictures to rasterized MODE 1 screens.
- Fixed "READ" , "INCLUDE" instructions in Z80 assembler
- Added "REPEAT", "REND" instructions in Z80 assembler
- Fixed GateArray raster change positions (More or less)
- Fixed a crash in CRTC / GA emulation
- Added several new bugs and problems :-P

Update from v2.9m to 2.9.20 changelog:

- Fixed FDC emulation (For some reason, games like Fres Fighter Turbo did not work)
- Bugfix in Assembler: READ "filename.asm" / INCLUDE "filename.asm" fixed.
- Minor bugfixes in GUI
- Added amstrad.eu chat
- Several minor fixes / improvements
- CPC display is now zoomable when you use your mousewheel

Update from v2.9l to 2.9m changelog:

- Fixed Roland Radio player application
- Removed (unnecessary) check for Update.jar, added it as manual menu entry: Help - Check JavaCPC
- Fixed some things in CRTC emulation (And probably added new bugs)
- Added CNGSoft's compacted games to Amstrad BDD
- Some minor fixes in CPC emulation (Nothing noticeable for the user)

Update from v2.9j to 2.9l changelog:

- Bugfixes in Amstrad BDD Gui, CPC-Power should work now, list is stored locally

Update from v2.9h to 2.9j changelog:

- Bugfixes in Amstrad BDD Gui, CPC-Power should work now in testmode
- RolandRadio added to Desktop (Listen and enjoy the music from rolandradio.net)
- Triple size option for display size added (Fuckings to GreatXerox :-P )
- Minor bugfix in FDC emulation

Update from v2.9e to 2.9h changelog:

- GUI improvements for BDD databases, CPC-Power added, but no database is available yet!
- RAM-Management rewritten and 4MB RAM expansion added
- Fixed faulty start of JavaCPC on non-Windows OS (Hopefully)
- Internal samples will not playback when non-Windows OS is detected

Update from v2.9 to 2.9e changelog:

- Hotfix in tape emulation, removed a bug, which caused a division by zero in some cases.
- RAM-ROM management rewritten. The emulator doesnt define a new CPC after each ROM change. Just changes the roms, and thats it.
- Added a nice startmenu to "AMSTRAD" logo, when used as Desktop.
- Small resetbutton added to emulator window.
- few GUI improvements for BDD databases. (You now can also search for a game)

Update from v2.8 to v2.9 changelog:

- BDD CPC file databases added: JavaCPC Games and JavaCPC Demos
- Z80 turbo mode integrated (Accessible in System configuration)
- Internal ROM font editor improved (Access: ALT + F11)

Update from v2.7 to v2.8 changelog:

- Amstrad.eu BDD added (Play games directly from <a href="http://www.amstrad.eu" rel="external">www.amstrad.eu</a> database)
- Bugfix in BASIC autotype and autoboot
- Some GUI changes
- Some parts are partially translated into German, French or Spanish (Translation is still in progress)