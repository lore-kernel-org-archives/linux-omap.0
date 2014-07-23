From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900 FB regression?
Date: Wed, 23 Jul 2014 00:37:06 -0700
Message-ID: <20140723073706.GH18374@atomide.com>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58967 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753061AbaGWHib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 03:38:31 -0400
Content-Disposition: inline
In-Reply-To: <20140722212318.GC2615@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

* Aaro Koskinen <aaro.koskinen@iki.fi> [140722 14:25]:
> Hi,
> 
> Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
> the framebuffer stopped working on N900 (nothing on screen).
> 
> I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
> Enable twl4030 off-idle configuration for selected omaps).
> With this commit reverted, I can see the Tux again with 3.16-rc6.
> 
> Any ideas?

Hmm, OK yeah that enables the deeper idle states. I have tested
this on n900, but only have remote access to it so could not see
the framebuffer.

Sounds like there's some twl regulator that we cannot idle
by default on n900. Here are the steps to narrow it down:

1. Try ti,twl4030-power-idle in omap3-n900.dts instead of
   ti,twl4030-power-idle-osc-off. This probably won't help
   unless you're enabling off-idle though, so if it does not
   help, just keep on using ti,twl4030-power-idle-osc-off.

2. Try commenting out one or more of the TWL_REMAP_SLEEP or
   TWL_REMAP_OFF lines in omap3_idle_rconfig in file
   drivers/mfd/twl4030-power.c. That's the recommended init
   sequence like the comments in the code mention. Chances
   are we're missing a regulator_get somewhere but finding
   out which one in omap3_idle_rconfig will help narrow it
   down :)

3. If it looks like a more complicated fix, we can just use
   compatible = "ti,twl4030-power-n900" to disable the twl
   features for v3.16 and re-enable it for v3.17.

Regards,

Tony
