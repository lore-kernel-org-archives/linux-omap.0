From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Thu, 15 May 2014 17:13:06 -0700
Message-ID: <20140516001306.GA6580@atomide.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
 <5373C78E.7040301@linaro.org>
 <5373C8E8.6040208@ti.com>
 <5373CBB9.40506@linaro.org>
 <20140514205649.GC27426@atomide.com>
 <20140514233119.GA31594@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55194 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752039AbaEPANM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 20:13:12 -0400
Content-Disposition: inline
In-Reply-To: <20140514233119.GA31594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [140514 16:32]:
> * Tony Lindgren <tony@atomide.com> [140514 13:57]:
> > * Daniel Lezcano <daniel.lezcano@linaro.org> [140514 13:02]:
> > > 
> > > So the broadcast timer does not operate with this revert. Moreover, I am not
> > > sure reverting this patch is the right solution.
> > 
> > OK I'll hold on sending anything until there's some conclusion.
> > 
> > Are you able to reproduce the problem with current Linux next?
> 
> BTW, I'm also noticing now hangs on omap3 with my PM patches
> on v3.15-rc4 that seem similar to the panda cpuidle hang.
> 
> The hangs on omap3 do not happen on my v3.14 based branch, so
> I'm wondering if there are some recent cpuidle regressions too
> in play?

Looks like the omap3 idle hang is caused by commit 6ddeb6d84459
(dmaengine: omap-dma: move IRQ handling to omap-dma). This may
not be related to omap4 cpu_idle hang, but it might.

I'm trying to figure out if it's related to something like
omap_dma_global_context_save and omap_dma_global_context_restore.

Meanwhile, to test the DMA changes have an effect on the omap4
cpu_idle issue, you can try reverting the following two patches:

aa4c5b962a7a dmaengine: omap-dma: more consolidation of CCR register setup
6ddeb6d84459 dmaengine: omap-dma: move IRQ handling to omap-dma

Regards,

Tony
