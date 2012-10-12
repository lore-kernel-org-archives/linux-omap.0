From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP4: Fix twd_local_timer_register regression
Date: Fri, 12 Oct 2012 09:51:49 -0700
Message-ID: <20121012165149.GE30339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56644 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932548Ab2JLQvy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 12:51:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal)
changed the interrupts to allow enabling sparse IRQ, but
accidentally added the omap3 INTC base to the local IRQ.
This causes the following:

twd: can't register interrupt 45 (-22)
twd_local_timer_register failed -22

The right fix is to not add any base, as it is a local
timer. For the OMAP44XX_IRQ_LOCALWDT we had defined earlier
there are no users, so no need to fix that.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -467,7 +467,7 @@ OMAP_SYS_TIMER(3_am33xx)
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      OMAP44XX_LOCAL_TWD_BASE, 29 + OMAP_INTC_START);
+			      OMAP44XX_LOCAL_TWD_BASE, 29);
 #endif
 
 static void __init omap4_timer_init(void)
