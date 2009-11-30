From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Mon, 30 Nov 2009 15:25:01 -0800
Message-ID: <4B14544D.5040204@stanford.edu>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:48322 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752628AbZK3XfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 18:35:24 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/29/2009 9:47 PM, Hiremath, Vaibhav wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
>> Sent: Thursday, November 26, 2009 7:50 PM
>> To: ext Eino-Ville Talvala
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with
>> rotation
>>
>> Hi,
>>
>> On Wed, 2009-11-25 at 01:14 +0100, ext Eino-Ville Talvala wrote:
>>     
>>> Hi,
>>>
>>> I'm trying to get Xorg running on an Angstrom distro image on the
>>>       
>> OMAP3
>>     
>>> EVM, with a rotated framebuffer.  The default screen orientation
>>>       
>> on the
>>     
>>> EVM is portrait, and I'm trying to change this to landscape.
>>>       
>> Without
>>     
>>> any tweaking, using a kernel with your latest v5 DSS patches added
>>>       
>> on
>>     
>>> top (and Vaibhav's OMAP3 EVM DSS patches), DSS works and Angstrom
>>> happily displays both its initial bootup screen, and then the X
>>>       
>> server
>>     
>>> starts successfully.
>>>
>>> Using the omapfb.rotate=1 kernel command-line option, the initial
>>>       
>> bootup
>>     
>>> screen still works, but as soon as the X server tries to start up,
>>>       
>> I get
>>     
>>> the following error on the console:
>>>
>>> Starting GPE display manager: gpe-dm
>>> omapdss MANAGER error: dispc_setup_plane failed for ovl 0
>>> omapdss MANAGER error: configure_overlay 0 failed
>>>       
>> It sounds to me that gpe-dm (or something running after that) is
>> trying
>> to configure the overlay to 480x640 mode, and failing. If the
>> initial
>>     
> [Hiremath, Vaibhav] I think this is the issue, I have seen many peoples doing same mistakes, and it ends up to the application, which doesn't care about rotation and tries to set 480x640 in all rotation angles.
>
>   

The xorg boot log appears reasonably sane until a crash - 640x480 is
what the xf86 omapfb driver picks up, so I assume something else is the
problem.  I'll try to poke at the omapfb source some to see if something
is being passed around wrong - I'd appreciate any suggestions on where
to look.

===
...
(II) LoadModule: "omapfb"
(II) Loading /usr/lib/xorg/modules/drivers//omapfb_drv.so
(II) Module omapfb: vendor="X.Org Foundation"
        compiled for 1.6.1, module version = 0.1.1
        ABI class: X.Org Video Driver, version 5.0
(II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD
controllers:
        omap1/2/3, S1D13745, HWA742
(WW) Falling back to old probe method for OMAPFB
(II) Running in FRAMEBUFFER Mode
(WW) Error opening /sys/devices/platform/omapfb/ctrl/name: No such file
or direc
tory
(WW) Can't autodetect LCD controller, assuming internal
(II) LCD controller: internal
(II) omapfb(0): VideoRAM: 1920KiB (SDRAM)
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
0: Xorg(xorg_backtrace+0x28) [0xd2540]

Fatal server error:
Caught signal 11.  Server aborting
===

Thanks,

Eino-Ville Talvala
Stanford University
