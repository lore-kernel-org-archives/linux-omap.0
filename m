From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Mon, 1 Oct 2012 11:50:26 -0500
Message-ID: <CAOCHtYh4nCU0nBSk2XtbH3ZW4-J2EQoG61f4fOKsz66981ud6w@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
	<CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
	<5064A173.5000909@johnea.net>
	<CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
	<CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com>
	<5064B41D.9030709@johnea.net>
	<CAOCHtYjjczpQ0oJ4zgrExdF7C-OAsfzMLwAEfdExkFG2uiUKgw@mail.gmail.com>
	<5065F13E.8070306@johnea.net>
	<CAOCHtYg3zrqO+3Rk6P8K7iit7uO9g4_YHQ870TXbmuEPZEyQ0Q@mail.gmail.com>
	<5065FE7C.9070503@johnea.net>
	<5069AF54.3000001@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56253 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab2JAQu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 12:50:27 -0400
Received: by vcbfo13 with SMTP id fo13so5847789vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Oct 2012 09:50:27 -0700 (PDT)
In-Reply-To: <5069AF54.3000001@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: johnea <me@johnea.net>
Cc: linux-omap@vger.kernel.org

> Good morning,
>
> We opted for the "Stay with omapfb", and disabled CONFIG_DRM_OMAP.
>
> Now the dev tree is showing all 3 fb devices, but still no video out 8-(
>
> Boot messages include:
>
> [root@apm002 johnea]# dmesg | grep omapfb
> [    0.000000] Kernel command line: console=ttyO2,115200n8 mpurate=auto
> buddy=spidev camera=none vram=18MB omapfb.mode=dvi
> omapfb.vram=0:6M,1:6M,2:6M omapdss.def_disp=dvi root=/dev/mmcblk0p2
> rootfstype=ext2 rootwait
> [    3.165069] omapfb omapfb: no driver for display: dvi
> [    3.165130] omapfb omapfb: no driver for display: lcd
> [    3.165161] omapfb omapfb: cannot parse default modes
>
> The "cannot parse default modes" message was eliminated by removing
> "omapfb.vram=0:6M,1:6M,2:6M" from the boot params.
>
> This made me wonder if the omapfb boot params expected by 3.5.4 had changed.
> So I tried a bunch of different permutations of boot params, with no effect
> other than eliminating the "default modes" message mentioned above.
>
> I tried digging into the source to determine currently accepted omapfb boot
> params, but had no success.
>
> It seems like we're really close. The latest config.gz and tar'd dmesg from
> the running system are attached.
>
> Thank You again! for any advise on config, boot param, or other changes that
> could make beagle DVI video work with 3.5.4...

You guys are very close... Your "config-3.5.4-archarm-3" config just
needed one more change:

CONFIG_PANEL_TFP410=m -> CONFIG_PANEL_TFP410=y

Tested on my Beagle xM...

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
