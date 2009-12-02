From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Wed, 02 Dec 2009 12:02:51 -0800
Message-ID: <4B16C7EB.4020200@stanford.edu>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com> <4B14544D.5040204@stanford.edu> <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080502050000060903040907"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.Stanford.EDU ([171.67.219.84]:59208 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752402AbZLBUCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 15:02:34 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080502050000060903040907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<snip>
>> The xorg boot log appears reasonably sane until a crash - 640x480 is
>> what the xf86 omapfb driver picks up, so I assume something 
>> else is the
>> problem.  I'll try to poke at the omapfb source some to see 
>> if something
>> is being passed around wrong - I'd appreciate any suggestions on where
>> to look.
>>
>> ===
>> ...
>> (II) LoadModule: "omapfb"
>> (II) Loading /usr/lib/xorg/modules/drivers//omapfb_drv.so
>> (II) Module omapfb: vendor="X.Org Foundation"
>>         compiled for 1.6.1, module version = 0.1.1
>>         ABI class: X.Org Video Driver, version 5.0
>> (II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD
>> controllers:
>>         omap1/2/3, S1D13745, HWA742
>> (WW) Falling back to old probe method for OMAPFB
>> (II) Running in FRAMEBUFFER Mode
>> (WW) Error opening /sys/devices/platform/omapfb/ctrl/name: No 
>> such file
>> or direc
>> tory
>> (WW) Can't autodetect LCD controller, assuming internal
>> (II) LCD controller: internal
>> (II) omapfb(0): VideoRAM: 1920KiB (SDRAM)
>> (--) omapfb(0): Depth 16, (==) framebuffer bpp 16
>> (==) omapfb(0): RGB weight 565
>> (==) omapfb(0): Default visual is TrueColor
>> (--) omapfb(0): Virtual size is 640x480 (pitch 640)
>> (**) omapfb(0):  Built-in mode "current"
>> (==) omapfb(0): DPI set to (96, 96)
>> (II) Loading sub module "fb"
>> (II) LoadModule: "fb"
>> (II) Loading /usr/lib/xorg/modules//libfb.so
>> (II) Module fb: vendor="X.Org Foundation"
>>         compiled for 1.6.1, module version = 1.0.0
>>         ABI class: X.Org ANSI C Emulation, version 0.4
>> (II) omapfb(0): DPMS enabled
>> (II) omapfb(0): Video plane capabilities:
>> (II) omapfb(0): Video plane supports the following image formats:
>> (II) omapfb(0): XVideo extension initialized
>> (==) RandR enabled
>> (II) Initializing built-in extension Generic Event Extension
>> (II) Initializing built-in extension SHAPE
>> (II) Initializing built-in extension MIT-SHM
>> (II) Initializing built-in extension XInputExtension
>> (II) Initializing built-in extension XTEST
>> (II) Initializing built-in extension BIG-REQUESTS
>> (II) Initializing built-in extension SYNC
>> (II) Initializing built-in extension XKEYBOARD
>> (II) Initializing built-in extension XC-MISC
>> (II) Initializing built-in extension XINERAMA
>> (II) Initializing built-in extension XFIXES
>> (II) Initializing built-in extension RENDER
>> (II) Initializing built-in extension RANDR
>> (II) Initializing built-in extension COMPOSITE
>> (II) Initializing built-in extension DAMAGE
>>
>> Backtrace:
>> 0: Xorg(xorg_backtrace+0x28) [0xd2540]
>>
>> Fatal server error:
>> Caught signal 11.  Server aborting
>> ===
>>     
> Does your xorg.conf enable GLX? You may want to try disabling it.
>
> ~sanjeev
>
>   

Thanks for all the suggestions, but nothing seems to have worked so far.

It looks like X picks up all sorts of configuration settings
automatically, since xorg.conf is essentially full of 'default internal
device' options.  What I can't figure out is how it decides on the
requested resolution.

The defaults, with omapfb.rotate=1 in bootargs, result in omapfb
selecting a virtual resolution of 640x480, but Xorg on boot still tries,
based on dmesg, to get a 480x640 overlay somehow (at least that's what
my interpretation of the situation is).  I've tried adding a screen
subsection to xorg.confg, with virtual 640 480 - no effect.  I've tried
adding in a modeline for 640x480, no effect.  I tried rebuilding
Angstrom with a few extra lines in /conf/machine/omap3evm.conf
(MACHINE_DISPLAY_WIDTH_PIXELS=640, etc), with no effect.

Does anyone know exactly how Xorg autoconfigures the default panel in
this sort of a situation?  My current guess is that it's getting 480x640
from some panel driver somewhere, but I haven't been able to find the
source.

For compleness, I've attached the Xorg log, xorg.conf, and the kernel
log when I try to boot up Xorg (just Xorg, no gpe anything).

Thanks,

Eino-Ville Talvala
Stanford University

dmesg:
omapdss OVERLAY: check_overlay 0: (0,0 480x640 -> 640x480) disp (480x640)
omapdss MANAGER: omap_dss_mgr_apply(lcd)
omapdss OVERLAY: check_overlay 0: (0,0 480x640 -> 640x480) disp (480x640)
omapdss MANAGER: configure_overlay(0)
omapdss DISPC: dispc_setup_plane 0, pa 71000000, sw 2048, 0,0, 480x640
-> 640x48
0, ilace 0, cmode 40, rot 1, mir 0
omapdss MANAGER error: dispc_setup_plane failed for ovl 0
omapdss DISPC: dispc_enable_plane 0, 0
omapdss MANAGER error: configure_overlay 0 failed
omapdss DISPC: GO LCD
omapdss MANAGER: omap_dss_mgr_apply(lcd)



--------------080502050000060903040907
Content-Type: text/plain;
 name="Xorg.0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Xorg.0.log"

_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/omap3evm:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6
(WW) Failed to open protocol names file /usr/lib/xorg/protocol.txt
X.Org X Server 1.6.1
Release Date: 2009-4-14
X Protocol Version 11, Revision 0
Build Operating System: Linux 2.6.24-24-generic i686 
Current Operating System: Linux omap3evm 2.6.32-rc7-07318-g8979e82 #320 Wed Nov 25 15:02:04 PST 2009 armv7l
Build Date: 02 December 2009  02:23:08AM
 
	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Dec  2 20:00:15 2009
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Builtin Default Layout"
(**) |-->Screen "Builtin Default fbdev Screen 0" (0)
(**) |   |-->Monitor "Builtin Default Monitor"
(**) |   |-->Device "Builtin Default fbdev Device 0"
(==) Automatically adding devices
(==) Automatically enabling devices
(==) FontPath set to:
	/usr/share/fonts/X11/misc,
	built-ins
(==) ModulePath set to "/usr/lib/xorg/modules"
(II) Cannot locate a core pointer device.
(II) Cannot locate a core keyboard device.
(II) The server relies on HAL to provide the list of input devices.
	If no devices become available, reconfigure HAL or disable AllowEmptyInput.
(II) Loader magic: 0x1fd84
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.4
	X.Org Video Driver: 5.0
	X.Org XInput driver : 4.0
	X.Org Server Extension : 2.0
(II) Loader running on linux
(--) using VT number 3

(II) System resource ranges:
(II) "extmod" will be loaded by default.
(II) "dbe" will be loaded by default.
(II) "glx" will be loaded by default.
(II) "dri" will be loaded by default.
(II) "dri2" will be loaded by default.
(II) LoadModule: "extmod"
(II) Loading /usr/lib/xorg/modules/extensions//libextmod.so
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 1.6.1, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "dbe"
(II) Loading /usr/lib/xorg/modules/extensions//libdbe.so
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 1.6.1, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "glx"
(WW) Warning, couldn't open module glx
(II) UnloadModule: "glx"
(EE) Failed to load module "glx" (module does not exist, 0)
(II) LoadModule: "dri"
(WW) Warning, couldn't open module dri
(II) UnloadModule: "dri"
(EE) Failed to load module "dri" (module does not exist, 0)
(II) LoadModule: "dri2"
(II) Loading /usr/lib/xorg/modules/extensions//libdri2.so
(II) Module dri2: vendor="X.Org Foundation"
	compiled for 1.6.1, module version = 1.0.0
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension DRI2
(II) LoadModule: "omapfb"
(II) Loading /usr/lib/xorg/modules/drivers//omapfb_drv.so
(II) Module omapfb: vendor="X.Org Foundation"
	compiled for 1.6.1, module version = 0.1.1
	ABI class: X.Org Video Driver, version 5.0
(II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD controllers:
	omap1/2/3, S1D13745, HWA742
(WW) Falling back to old probe method for OMAPFB
(II) Running in FRAMEBUFFER Mode
(WW) Error opening /sys/devices/platform/omapfb/ctrl/name: No such file or directory
(WW) Can't autodetect LCD controller, assuming internal
(II) LCD controller: internal
(II) omapfb(0): VideoRAM: 1920KiB (SDRAM)
(II) omapfb(0): Creating default Display subsection in Screen section
	"Builtin Default fbdev Screen 0" for depth/fbbpp 16/16
(--) omapfb(0): Depth 16, (==) framebuffer bpp 16
(==) omapfb(0): RGB weight 565
(==) omapfb(0): Default visual is TrueColor
(--) omapfb(0): Virtual size is 640x480 (pitch 640)
(**) omapfb(0):  Built-in mode "current"
(==) omapfb(0): DPI set to (96, 96)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/lib/xorg/modules//libfb.so
(II) Module fb: vendor="X.Org Foundation"
	compiled for 1.6.1, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.4
(II) omapfb(0): DPMS enabled
(II) omapfb(0): Video plane capabilities:
(II) omapfb(0): Video plane supports the following image formats:
(II) omapfb(0): XVideo extension initialized
(==) RandR enabled
(II) Initializing built-in extension Generic Event Extension
(II) Initializing built-in extension SHAPE
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension BIG-REQUESTS
(II) Initializing built-in extension SYNC
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension XC-MISC
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE

Backtrace:
0: Xorg(xorg_backtrace+0x28) [0xe0b18]

Fatal server error:
Caught signal 11.  Server aborting


Please consult the The X.Org Foundation support 
	 at http://wiki.x.org
 for help. 
Please also check the log file at "/var/log/Xorg.0.log" for additional information.

(NI) OMAPFBLeaveVT

--------------080502050000060903040907
Content-Type: text/plain;
 name="xorg.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xorg.conf"

Section "Module"                                       
#        Load    "extmod"                                
#        Load    "dbe"                           
#        Load    "glx"                                           
#        Load    "freetype"                             
#        Load    "type1"                        
#        Load    "record"                    
#        Load    "dri"                       
EndSection                            

Section "Monitor"
        Identifier      "Builtin Default Monitor"
EndSection                                       

Section "Device"                                  
        Identifier      "Builtin Default fbdev Device 0"
        Driver  "omapfb"
EndSection                                                
Section "Screen"                                        
        Identifier      "Builtin Default fbdev Screen 0"     
        Device  "Builtin Default fbdev Device 0"            
        Monitor "Builtin Default Monitor"               
EndSection                                              

Section "ServerLayout"                                 
        Identifier      "Builtin Default Layout"                                     
        Screen  "Builtin Default fbdev Screen 0"        
EndSection                                              

--------------080502050000060903040907--
