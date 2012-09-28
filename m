From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Fri, 28 Sep 2012 14:18:01 -0500
Message-ID: <CAOCHtYg3zrqO+3Rk6P8K7iit7uO9g4_YHQ870TXbmuEPZEyQ0Q@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
	<CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
	<5064A173.5000909@johnea.net>
	<CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
	<CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
	<5064B41D.9030709@johnea.net>
	<CAOCHtYjjczpQ0oJ4zgrExdF7C-OAsfzMLwAEfdExkFG2uiUKgw@mail.gmail.com>
	<5065F13E.8070306@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44609 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030704Ab2I1TSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 15:18:03 -0400
Received: by vbbff1 with SMTP id ff1so3529776vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 12:18:02 -0700 (PDT)
In-Reply-To: <5065F13E.8070306@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org

On Fri, Sep 28, 2012 at 1:49 PM,  <linux@johnea.net> wrote:
> On 09/27/2012 01:41 PM, Robert Nelson wrote:
>>
>> On Thu, Sep 27, 2012 at 3:16 PM,<linux@johnea.net>  wrote:
>>>
>>> On 09/27/2012 12:39 PM, Robert Nelson wrote:
>>>
>>>>>
>>>>> So, i would first look at the config (zcat /proc/config.gz) between
>>>>> those two releases, and if the arch developers added any more patches
>>>>> to it..
>>>>
>>>>
>
>>>>
>>>> It looks like they disabled CONFIG_OMAP_RESET_CLOCKS
>>>>
>>>> I'm pretty sure that would force you to be stuck with what ever u-boot
>>>> sets up for those pins...
>
>
> Corrected, now: CONFIG_OMAP_RESET_CLOCKS=y
>
>
>>>
>>> "beagle: video works now, had to drop the hi-speed pll divider, as the
>>> infastructure for it looks to have been removed"
>>>
>>>
>>> https://github.com/RobertCNelson/stable-kernel/commit/e7c8d9e8894997ae6a1ad9c83292ed75c5ac32c5
>>>
>
>>
>> Correct, dropping that specific patch (1), got 3.5.x working on my
>> beagle again. .( i was distracted with an another project, so i was a
>> little late in testing/stabilizing 3.5.x when porting the v3.4.x
>> patchset ;) ..)
>>
>
> 3.5.4 is booting on beagle xM with the patchset:
>
> http://rcn-ee.net/deb/sid-armhf/v3.5.4-x6/patch-3.5.4-x6.diff.gz
>
> buddy=spidev is working again (Thank You)
>
> However I'm still not seeing DVI console 8-(
>
> These messages appear during boot:
>
> [    0.000000] Kernel command line: console= mpurate=auto buddy=spidev
> camera=none vram=18MB omapfb.mode=dvi:800x480MR-24@60
> omapfb.vram=0:6M,1:6M,2:6M omapdss.def_disp=dvi root=/dev/mmcblk0p2
> rootfstype=ext2 rootwait
>
> [    0.190155] Could not look up dss_hdmi hw_mod
>
> [   10.605987] omapdrm: module is from the staging directory, the quality is
> unknown, you have been warned.
> [   10.682647] omapdrm omapdrm.0: DMM not available, disable DMM support
> [   10.682739] omapdrm omapdrm.0: dvi has no driver.. skipping it
> [   10.682769] omapdrm omapdrm.0: lcd has no driver.. skipping it
> [   10.815246] fb0: omapdrm frame buffer device
> [   10.815338] [drm] Initialized omapdrm 1.0.0 20110917 on minor 0
>
>
> Once booted, /dev/fb0 is present, but no fb1 or fb2.
>
> The display never even blinks during reboot. No console output appears when
> I use "console=" and a login prompt is never presented.

Ah, so looking at the config, ARCH switched to omapdrm... It kinda
works in v3.5.x, but i'd wait till a few more releases...

So, based on that config, they have both "CONFIG_FB_OMAP2" and
"CONFIG_DRM_OMAP" enabled.. That's a no-no...

CONFIG_DRM_OMAP
http://cateee.net/lkddb/web-lkddb/DRM_OMAP.html
depends on: ( CONFIG_DRM && ! CONFIG_CONFIG_FB_OMAP2 ) && (
CONFIG_ARCH_OMAP2PLUS )

Option 1: Stay with omapfb

CONFIG_FB_OMAP2=m -> CONFIG_FB_OMAP2=y
disable: CONFIG_DRM_OMAP

Option 2: Go Experimental route with omapdrm

CONFIG_DRM_OMAP=m
CONFIG_DRM_OMAP_NUM_CRTCS=1

disable: CONFIG_FB_OMAP2

> Attached are config.gz from running system and gz'd complete dmesg output
> (hope attachments are OK on the list).
>
> There's another 3.5.4 build scheduled on the panda build farm this
> afternoon. If you have any config modification suggestions, they'd be very
> gratefully received.

Also, if your running that config on pre-es (omap4430) panda's..
CONFIG_OMAP4_ERRATA_I688=y  &  CONFIG_ARCH_HAS_BARRIERS=y

and save your self some debugging time... ;)

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
