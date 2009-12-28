From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Sun, 27 Dec 2009 21:58:29 -0800
Message-ID: <4B384905.7050402@stanford.edu>
References: <4B0C76E2.1070804@stanford.edu> <1259245214.2438.460.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com> <4B14544D.5040204@stanford.edu> <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB9@dbde02.ent.ti.com> <4B16C7EB.4020200@stanford.edu> <9F27D2AF-BC28-4A2B-99C1-BC108E5F0C80@student.utwente.nl> <4B16E34B.7040904@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:44345 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751363AbZL1F61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 00:58:27 -0500
In-Reply-To: <4B16E34B.7040904@stanford.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On 12/2/2009 1:59 PM, Eino-Ville Talvala wrote:
<snip>
>>>
>>> Thanks for all the suggestions, but nothing seems to have worked so far.
>>>
>>> It looks like X picks up all sorts of configuration settings
>>> automatically, since xorg.conf is essentially full of 'default internal
>>> device' options.  What I can't figure out is how it decides on the
>>> requested resolution.
>>>
>>> The defaults, with omapfb.rotate=1 in bootargs, result in omapfb
>>> selecting a virtual resolution of 640x480, but Xorg on boot still tries,
>>> based on dmesg, to get a 480x640 overlay somehow (at least that's what
>>> my interpretation of the situation is).  I've tried adding a screen
>>> subsection to xorg.confg, with virtual 640 480 - no effect.  I've tried
>>> adding in a modeline for 640x480, no effect.  I tried rebuilding
>>> Angstrom with a few extra lines in /conf/machine/omap3evm.conf
>>> (MACHINE_DISPLAY_WIDTH_PIXELS=640, etc), with no effect.
>>>
>>> Does anyone know exactly how Xorg autoconfigures the default panel in
>>> this sort of a situation?  My current guess is that it's getting 480x640
>>> from some panel driver somewhere, but I haven't been able to find the
>>> source.
>>>
>>> For compleness, I've attached the Xorg log, xorg.conf, and the kernel
>>> log when I try to boot up Xorg (just Xorg, no gpe anything).
>>>     
>>>       
>> check the settings for fb0, fb1 and fb2 with fbset.
>>
>> regards,
>>
>> Koen
>>   
>>     
> root@omap3evm:~# fbset -fb /dev/fb0
>
> mode "640x480-59"
>         # D: 19.200 MHz, H: 28.614 kHz, V: 59.243 Hz
>         geometry 640 480 640 480 16
>         timings 52083 1 28 1 1 2 1
>         accel false
>         rgba 5/11,6/5,5/0,0/0
> endmode
>
> root@omap3evm:~# fbset -fb /dev/fb1
>
> mode "640x480-59"
>         # D: 19.200 MHz, H: 28.614 kHz, V: 59.243 Hz
>         geometry 640 480 640 480 16
>         timings 52083 1 28 1 1 2 1
>         accel false
>         rgba 5/11,6/5,5/0,0/0
> endmode
>
> root@omap3evm:~# fbset -fb /dev/fb2
>
> mode "0x0-0"
>         # D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
>         geometry 0 0 0 0 0
>         timings 0 0 0 0 0 0 0
>         accel false
>         rgba 0/0,0/0,0/0,0/0
> endmode
>
> FB2 is suspicious, since that's what Xorg uses, I believe.  Attempting
> to set it to something like fb0 and fb1 with:
>     fbset -fb /dev/fb2 -g 640 480 640 480 16 -t 52083 1 28 1 1 2 1
> made no difference to Xorg, however.  I tried upping the amount of
> memory allocated to fb2 (I'd forgotten to give it any on the bootargs),
> with no luck.  So fb0 and fb1 are getting defaults from somewhere, but
> fb2 isn't.
>
> Bootargs currently:
>     mem=128M console=ttyS0,115200n8 noinitrd rw root=/dev/mmcblk0p2
> rootfstype=ext2 rootwait omapfb.rotate=1 omapfb.vrfb=y omapfb.debug=y
> omapdss.debug=y vram=32M omapfb.vram=0:8M,1:8M,2:8M
>
> Thanks for the suggestion!
>   

Just in case it would be of use to others later, I did finally find a
resolution to this problem.  The short story is that the current
xf86-video-omafb driver can't handle VRFB rotation, even if it's defined
on the kernel command line, because the driver assumes that the output
framebuffer is contiguous, which is very much not true with VRFB. 
There's also a problem with the order in which it reads and writes
framebuffer parameters, because with the omapfb driver, the frame buffer
fixed info will have to be reread after changing rotation settings or
pixel type, as the stride can change. 

I've hacked up enough of the xf86-video-omapfb driver to get X running
in the proper orientation with VRFB and rotation defined on the kernel
command line, on the OMAP3 EVM (so X runs at 640x480 on the built-in
480x640 LCD).  I haven't gotten the XV extension part of the driver
working right yet.  If anyone wants the ugly results, I'm happy to
share, but I doubt I'll have time to clean them up anytime soon.

Thanks,

Eino-Ville Talvala
Computer Graphics Lab
Stanford University


