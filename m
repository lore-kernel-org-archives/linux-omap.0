From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
 fix
Date: Mon, 30 Nov 2009 17:20:45 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC19DB@dbde02.ent.ti.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
 	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
 	<2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
 	<200911200951.13181.peter.ujfalusi@nokia.com>
 <20091120155343.baf0b9d3.jhnikula@gmail.com>
 	<1258726156.6157.11.camel@eenurkka-desktop>
 <2ee9e08d0911200647o33a57e45j1bb4de6d9604d29a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50217 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbZK3Luv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 06:50:51 -0500
In-Reply-To: <2ee9e08d0911200647o33a57e45j1bb4de6d9604d29a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang, Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Looking at the very original patch, I don't know how things could get
> > into deep sleep by disabling the fclk only... need to disable the iclk
> > also. In threshold mode, HW autogates the iclk, so you may be just
> > "lucky".
> [Anuj] No, I am not :(. I had to modify the original patch to include
> the disable part for the ICLK too. Without that, I was not able to hit
> retention.
> I will try to do some further regression on OMAP3 EVM and post my
> findings. As of now, audio is working fine with these patches + ICLK
> modification.
[Aggarwal, Anuj] After further testing, I found that there is some
problem in the capture path. While capturing in background, if I tried 
to do suspend, capture fails after a few seconds giving;
arecord: pcm_read:1617: read error: Input/output error
This I was discussing in another thread (*) for AIC23/AM3517 on NFS but now
I realized after finishing my tests that this behavior is common for 
both omap3530/twl4030 and am3517/aic23. Moreover, the problem doesn't 
depend on the underlying file system - both NFS and ramdisk produce the
same error. 
To make matter worse, if suspend/resume is tried while audio
loopback is running, system just hangs. Even telnet to the evm doesn't work.
So the audio capture path, from suspend/resume point of view, definitely
needs some more time.
I will continue debugging at my end. But pointers are always welcome.

*) http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19845.html
> >
> > One may want to be aware of this also:
> >
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commitdiff;h=72cc6d715d5b018e2cff4adb68966855850d4e77
> >
> > I think it's an undocumented feature.
> >
