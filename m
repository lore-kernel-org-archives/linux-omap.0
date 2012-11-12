From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 09/13] ARM: OMAP: Don't restore DMTIMER interrupt status register
Date: Mon, 12 Nov 2012 12:20:40 -0600
Message-ID: <1352744444-2633-10-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33319 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab2KLSVE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 13:21:04 -0500
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Restoring the timer interrupt status is not possible because writing a 1 to any
bit in the register clears that bit if set and writing a 0 has no affect.
Furthermore, if an interrupt is pending when someone attempts to disable a
timer, the timer will fail to transition to the idle state and hence it's
context will not be lost. Users should take care to service all interrupts
before disabling the timer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |    5 +----
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 320d103..f0a3c4c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -83,7 +83,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	__raw_writel(timer->context.tisr, timer->irq_stat);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
 				timer->context.twer);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
@@ -440,7 +439,6 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	 */
 	timer->context.tclr =
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	timer->context.tisr = __raw_readl(timer->irq_stat);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -684,8 +682,7 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
-	/* Save the context */
-	timer->context.tisr = value;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 2f9fd1d..0c07e37 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -84,7 +84,6 @@ struct omap_dm_timer;
 
 struct timer_regs {
 	u32 tidr;
-	u32 tisr;
 	u32 tier;
 	u32 twer;
 	u32 tclr;
-- 
1.7.9.5

