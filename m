From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Wed, 02 Dec 2009 13:59:39 -0800
Message-ID: <4B16E34B.7040904@stanford.edu>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com> <4B14544D.5040204@stanford.edu> <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB9@dbde02.ent.ti.com> <4B16C7EB.4020200@stanford.edu> <9F27D2AF-BC28-4A2B-99C1-BC108E5F0C80@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:38016 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbZLBV7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 16:59:23 -0500
In-Reply-To: <9F27D2AF-BC28-4A2B-99C1-BC108E5F0C80@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On 12/2/2009 12:52 PM, Koen Kooi wrote:
> Op 2 dec 2009, om 21:02 heeft Eino-Ville Talvala het volgende geschreven:
>
>   
>> <snip>
>>     
>>>> The xorg boot log appears reasonably sane until a crash - 640x480 is
>>>> what the xf86 omapfb driver picks up, so I assume something 
>>>> else is the
>>>> problem.  I'll try to poke at the omapfb source some to see 
>>>> if something
>>>> is being passed around wrong - I'd appreciate any suggestions on where
>>>> to look.
>>>>
>>>> ===
>>>> ...
>>>> (II) LoadModule: "omapfb"
>>>> (II) Loading /usr/lib/xorg/modules/drivers//omapfb_drv.so
>>>> (II) Module omapfb: vendor="X.Org Foundation"
>>>>        compiled for 1.6.1, module version = 0.1.1
>>>>        ABI class: X.Org Video Driver, version 5.0
>>>> (II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD
>>>> controllers:
>>>>        omap1/2/3, S1D13745, HWA742
>>>> (WW) Falling back to old probe method for OMAPFB
>>>> (II) Running in FRAMEBUFFER Mode
>>>> (WW) Error opening /sys/devices/platform/omapfb/ctrl/name: No 
>>>> such file
>>>> or direc
>>>> tory
>>>> (WW) Can't autodetect LCD controller, assuming internal
>>>> (II) LCD controller: internal
>>>> (II) omapfb(0): VideoRAM: 1920KiB (SDRAM)
>>>> (--) omapfb(0): Depth 16, (==) framebuffer bpp 16
>>>> (==) omapfb(0): RGB weight 565
>>>> (==) omapfb(0): Default visual is TrueColor
>>>> (--) omapfb(0): Virtual size is 640x480 (pitch 640)
>>>> (**) omapfb(0):  Built-in mode "current"
>>>> (==) omapfb(0): DPI set to (96, 96)
>>>> (II) Loading sub module "fb"
>>>> (II) LoadModule: "fb"
>>>> (II) Loading /usr/lib/xorg/modules//libfb.so
>>>> (II) Module fb: vendor="X.Org Foundation"
>>>>        compiled for 1.6.1, module version = 1.0.0
>>>>        ABI class: X.Org ANSI C Emulation, version 0.4
>>>> (II) omapfb(0): DPMS enabled
>>>> (II) omapfb(0): Video plane capabilities:
>>>> (II) omapfb(0): Video plane supports the following image formats:
>>>> (II) omapfb(0): XVideo extension initialized
>>>> (==) RandR enabled
>>>> (II) Initializing built-in extension Generic Event Extension
>>>> (II) Initializing built-in extension SHAPE
>>>> (II) Initializing built-in extension MIT-SHM
>>>> (II) Initializing built-in extension XInputExtension
>>>> (II) Initializing built-in extension XTEST
>>>> (II) Initializing built-in extension BIG-REQUESTS
>>>> (II) Initializing built-in extension SYNC
>>>> (II) Initializing built-in extension XKEYBOARD
>>>> (II) Initializing built-in extension XC-MISC
>>>> (II) Initializing built-in extension XINERAMA
>>>> (II) Initializing built-in extension XFIXES
>>>> (II) Initializing built-in extension RENDER
>>>> (II) Initializing built-in extension RANDR
>>>> (II) Initializing built-in extension COMPOSITE
>>>> (II) Initializing built-in extension DAMAGE
>>>>
>>>> Backtrace:
>>>> 0: Xorg(xorg_backtrace+0x28) [0xd2540]
>>>>
>>>> Fatal server error:
>>>> Caught signal 11.  Server aborting
>>>> ===
>>>>
>>>>         
>>> Does your xorg.conf enable GLX? You may want to try disabling it.
>>>
>>> ~sanjeev
>>>
>>>
>>>       
>> Thanks for all the suggestions, but nothing seems to have worked so far.
>>
>> It looks like X picks up all sorts of configuration settings
>> automatically, since xorg.conf is essentially full of 'default internal
>> device' options.  What I can't figure out is how it decides on the
>> requested resolution.
>>
>> The defaults, with omapfb.rotate=1 in bootargs, result in omapfb
>> selecting a virtual resolution of 640x480, but Xorg on boot still tries,
>> based on dmesg, to get a 480x640 overlay somehow (at least that's what
>> my interpretation of the situation is).  I've tried adding a screen
>> subsection to xorg.confg, with virtual 640 480 - no effect.  I've tried
>> adding in a modeline for 640x480, no effect.  I tried rebuilding
>> Angstrom with a few extra lines in /conf/machine/omap3evm.conf
>> (MACHINE_DISPLAY_WIDTH_PIXELS=640, etc), with no effect.
>>
>> Does anyone know exactly how Xorg autoconfigures the default panel in
>> this sort of a situation?  My current guess is that it's getting 480x640
>> from some panel driver somewhere, but I haven't been able to find the
>> source.
>>
>> For compleness, I've attached the Xorg log, xorg.conf, and the kernel
>> log when I try to boot up Xorg (just Xorg, no gpe anything).
>>     
> check the settings for fb0, fb1 and fb2 with fbset.
>
> regards,
>
> Koen
>   

root@omap3evm:~# fbset -fb /dev/fb0

mode "640x480-59"
        # D: 19.200 MHz, H: 28.614 kHz, V: 59.243 Hz
        geometry 640 480 640 480 16
        timings 52083 1 28 1 1 2 1
        accel false
        rgba 5/11,6/5,5/0,0/0
endmode

root@omap3evm:~# fbset -fb /dev/fb1

mode "640x480-59"
        # D: 19.200 MHz, H: 28.614 kHz, V: 59.243 Hz
        geometry 640 480 640 480 16
        timings 52083 1 28 1 1 2 1
        accel false
        rgba 5/11,6/5,5/0,0/0
endmode

root@omap3evm:~# fbset -fb /dev/fb2

mode "0x0-0"
        # D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
        geometry 0 0 0 0 0
        timings 0 0 0 0 0 0 0
        accel false
        rgba 0/0,0/0,0/0,0/0
endmode

FB2 is suspicious, since that's what Xorg uses, I believe.  Attempting
to set it to something like fb0 and fb1 with:
    fbset -fb /dev/fb2 -g 640 480 640 480 16 -t 52083 1 28 1 1 2 1
made no difference to Xorg, however.  I tried upping the amount of
memory allocated to fb2 (I'd forgotten to give it any on the bootargs),
with no luck.  So fb0 and fb1 are getting defaults from somewhere, but
fb2 isn't.

Bootargs currently:
    mem=128M console=ttyS0,115200n8 noinitrd rw root=/dev/mmcblk0p2
rootfstype=ext2 rootwait omapfb.rotate=1 omapfb.vrfb=y omapfb.debug=y
omapdss.debug=y vram=32M omapfb.vram=0:8M,1:8M,2:8M

Thanks for the suggestion!
