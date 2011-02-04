From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pandaboard boot problem
Date: Thu, 3 Feb 2011 17:53:01 -0800
Message-ID: <20110204015301.GQ3322@atomide.com>
References: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56686 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1BDBxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:53:17 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [110201 10:29]:
> Hi!
> 
> I have a problem with a Pandaboard hanging a few seconds after the
> kernel boot, likely due to the watchdog firing.
> The kernel boots fine, mounts the root FS (initramfs) and the shell
> prompt works OK.
> 
> Board details: Panda A1, OMAP4430 ES2
> Kernel details: l-o tree master, using the omap2plus_defconfig +
> initramfs. WDOG is enabled in the config.
> 
> From some investigation I can see that PM runtime disables the wdog
> (omap_device_idle). Is that intented?
> 
> Any thought?

Does it power down after few tens of seconds?

If so, I've seen this same issue few times after having my panda
powered off for a while, for example over the weekend.

What I've noticed is that leaving just u-boot prompt running
for a few minutes cures the problem somehow.. After that the
kernel will boot just fine.

Regards,

Tony
