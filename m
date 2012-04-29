From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Sun, 29 Apr 2012 13:32:50 +0200
Message-ID: <5062087.MRndu11OX4@vclass>
References: <1335515951-6907-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36849 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab2D2Lg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 Apr 2012 07:36:59 -0400
In-Reply-To: <1335515951-6907-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Friday 27 of April 2012 14:09:11 Tarun Kanti DebBarma wrote:
> Breaking commit: ab985f0f7c2c0ef90b7c832f0c04f470dda0593d
> 
> Initialization of irqenable, irqstatus registers is the common
> operation done in this function for all OMAP platforms, viz.
> OMAP1, OMAP2+. The latter _gpio_rmw()'s to irqenable register
> was overwriting the correctly programmed OMAP1 value at the
> beginning. As a result, even though it worked on OMAP2+
> platforms it was breaking OMAP1 functionality. On close
> observation it is found that the first _gpio_rmw() which is
> supposedly done to take care of OMAP1 platform is generic enough
> and takes care of OMAP2+ platform as well. Therefore remove the
> latter _gpio_rmw() to irqenable as they are redundant now.
> 
> Writing to ctrl and debounce_en registers for OMAP2+ platforms
> are modified to match the original(pre-cleanup) code where the
> registers are initialized with 0. In the cleanup series since
> we are using _gpio_rmw(reg, 0, 1), instead of __raw_writel(),
> we are just reading and writing the same values to ctrl and
> debounce_en. This is not an issue for debounce_en register
> because it has 0x0 as the default value. But in the case of
> ctrl register the default value is 0x2 (GATINGRATIO = 0x1)
> so that we end up writing 0x2 instead of intended 0 value.
> Therefore correcting it to _gpio_rmw(reg, l, 0), where
> l = 0xffffffff so that registers are initialized to 0.
> 
> Also, changing the sequence and logic of initializing the irqstatus.

Hi,
Sorry for not responding in 2 days, as I promissed. The reason is that 
there are still more issues with GPIO on my Amstrad Delta, for example 
those introduced with commit 384ebe1c2849160d040df3e68634ec506f13d9ff, 
and I'm still trying to understand and fix them. Than, it's hard for me 
to provide you with my Tested-by: before I'm confident those other issues 
are not related.

Anyway, and with respect to Kevin's comments, reverting the irqstatus 
vs. irqenable initialization order doesn't seem to break anything for 
me, and changes to debounce_en and ctrl register handling seem not 
relevant to my test machine.

Thanks,
Janusz
