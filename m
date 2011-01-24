From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 11:11:15 +0000
Message-ID: <20110124111114.GA19409@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60045 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1AXLLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 06:11:55 -0500
Content-Disposition: inline
In-Reply-To: <20110124110609.GJ16202@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 11:06:09AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> > In CPU low power state, local timer looses its register context. This
> > patch adds context save restore hooks which can be used by platforms
> > appropriately.
> 
> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the generic
> timer stuff wouldn't rely on it being kept alive?
> 
> Hmm, it looks like we bypass the clockevents code by only setting the
> TWD load value at initialization time, not when we switch to periodic
> mode.  We really ought to rewrite it whenever we switch back to periodic
> mode.
> 
> I suspect fixing that means you won't need this save/restore support.

Untested, but should do what's required.

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fd91566..60636f4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode mode,
 		/* timer load already set up */
 		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
+		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* period set, and timer enabled in 'next_event' hook */
@@ -81,7 +82,7 @@ int twd_timer_ack(void)
 
 static void __cpuinit twd_calibrate_rate(void)
 {
-	unsigned long load, count;
+	unsigned long count;
 	u64 waitjiffies;
 
 	/*
@@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 1000000) % 100);
 	}
-
-	load = twd_timer_rate / HZ;
-
-	__raw_writel(load, twd_base + TWD_TIMER_LOAD);
 }
 
 /*
