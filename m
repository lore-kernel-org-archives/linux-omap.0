From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Wed, 2 Dec 2009 21:52:46 +0100
Message-ID: <9F27D2AF-BC28-4A2B-99C1-BC108E5F0C80@student.utwente.nl>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com> <4B14544D.5040204@stanford.edu> <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB9@dbde02.ent.ti.com> <4B16C7EB.4020200@stanford.edu>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:33197 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755316AbZLBUw4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Dec 2009 15:52:56 -0500
In-Reply-To: <4B16C7EB.4020200@stanford.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eino-Ville Talvala <talvala@stanford.edu>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 2 dec 2009, om 21:02 heeft Eino-Ville Talvala het volgende geschreven:

> <snip>
>>> The xorg boot log appears reasonably sane until a crash - 640x480 is
>>> what the xf86 omapfb driver picks up, so I assume something 
>>> else is the
>>> problem.  I'll try to poke at the omapfb source some to see 
>>> if something
>>> is being passed around wrong - I'd appreciate any suggestions on where
>>> to look.
>>> 
>>> ===
>>> ...
>>> (II) LoadModule: "omapfb"
>>> (II) Loading /usr/lib/xorg/modules/drivers//omapfb_drv.so
>>> (II) Module omapfb: vendor="X.Org Foundation"
>>>        compiled for 1.6.1, module version = 0.1.1
>>>        ABI class: X.Org Video Driver, version 5.0
>>> (II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD
>>> controllers:
>>>        omap1/2/3, S1D13745, HWA742
>>> (WW) Falling back to old probe method for OMAPFB
>>> (II) Running in FRAMEBUFFER Mode
>>> (WW) Error opening /sys/devices/platform/omapfb/ctrl/name: No 
>>> such file
>>> or direc
>>> tory
>>> (WW) Can't autodetect LCD controller, assuming internal
>>> (II) LCD controller: internal
>>> (II) omapfb(0): VideoRAM: 1920KiB (SDRAM)
>>> (--) omapfb(0): Depth 16, (==) framebuffer bpp 16
>>> (==) omapfb(0): RGB weight 565
>>> (==) omapfb(0): Default visual is TrueColor
>>> (--) omapfb(0): Virtual size is 640x480 (pitch 640)
>>> (**) omapfb(0):  Built-in mode "current"
>>> (==) omapfb(0): DPI set to (96, 96)
>>> (II) Loading sub module "fb"
>>> (II) LoadModule: "fb"
>>> (II) Loading /usr/lib/xorg/modules//libfb.so
>>> (II) Module fb: vendor="X.Org Foundation"
>>>        compiled for 1.6.1, module version = 1.0.0
>>>        ABI class: X.Org ANSI C Emulation, version 0.4
>>> (II) omapfb(0): DPMS enabled
>>> (II) omapfb(0): Video plane capabilities:
>>> (II) omapfb(0): Video plane supports the following image formats:
>>> (II) omapfb(0): XVideo extension initialized
>>> (==) RandR enabled
>>> (II) Initializing built-in extension Generic Event Extension
>>> (II) Initializing built-in extension SHAPE
>>> (II) Initializing built-in extension MIT-SHM
>>> (II) Initializing built-in extension XInputExtension
>>> (II) Initializing built-in extension XTEST
>>> (II) Initializing built-in extension BIG-REQUESTS
>>> (II) Initializing built-in extension SYNC
>>> (II) Initializing built-in extension XKEYBOARD
>>> (II) Initializing built-in extension XC-MISC
>>> (II) Initializing built-in extension XINERAMA
>>> (II) Initializing built-in extension XFIXES
>>> (II) Initializing built-in extension RENDER
>>> (II) Initializing built-in extension RANDR
>>> (II) Initializing built-in extension COMPOSITE
>>> (II) Initializing built-in extension DAMAGE
>>> 
>>> Backtrace:
>>> 0: Xorg(xorg_backtrace+0x28) [0xd2540]
>>> 
>>> Fatal server error:
>>> Caught signal 11.  Server aborting
>>> ===
>>> 
>> Does your xorg.conf enable GLX? You may want to try disabling it.
>> 
>> ~sanjeev
>> 
>> 
> 
> Thanks for all the suggestions, but nothing seems to have worked so far.
> 
> It looks like X picks up all sorts of configuration settings
> automatically, since xorg.conf is essentially full of 'default internal
> device' options.  What I can't figure out is how it decides on the
> requested resolution.
> 
> The defaults, with omapfb.rotate=1 in bootargs, result in omapfb
> selecting a virtual resolution of 640x480, but Xorg on boot still tries,
> based on dmesg, to get a 480x640 overlay somehow (at least that's what
> my interpretation of the situation is).  I've tried adding a screen
> subsection to xorg.confg, with virtual 640 480 - no effect.  I've tried
> adding in a modeline for 640x480, no effect.  I tried rebuilding
> Angstrom with a few extra lines in /conf/machine/omap3evm.conf
> (MACHINE_DISPLAY_WIDTH_PIXELS=640, etc), with no effect.
> 
> Does anyone know exactly how Xorg autoconfigures the default panel in
> this sort of a situation?  My current guess is that it's getting 480x640
> from some panel driver somewhere, but I haven't been able to find the
> source.
> 
> For compleness, I've attached the Xorg log, xorg.conf, and the kernel
> log when I try to boot up Xorg (just Xorg, no gpe anything).

check the settings for fb0, fb1 and fb2 with fbset.

regards,

Koen
