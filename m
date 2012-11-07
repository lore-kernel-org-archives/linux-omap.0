From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 10/14] ARM: OMAP: Don't restore DMTIMER interrupt status register
Date: Wed, 7 Nov 2012 13:01:26 -0600
Message-ID: <1352314890-22224-11-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab2KGTBu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:50 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Restoring the timer interrupt status is not possible because writing a 1 to any
bit in the register clears that bit if set and writing a 0 has no affect.
Furthermore, if an interrupt is pending when someone attempts to disable a
timer, the timer will fail to transition to the idle state and hence it's
context will not be lost. Users should take care to service all interrupts
before disabling the timer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |    5 +----
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a350f12..76553fd5 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -86,7 +86,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	__raw_writel(timer->context.tisr, timer->irq_stat);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
 				timer->context.twer);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
@@ -495,7 +494,6 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	 */
 	timer->context.tclr =
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	timer->context.tisr = __raw_readl(timer->irq_stat);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -738,8 +736,7 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
-	/* Save the context */
-	timer->context.tisr = value;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 36b71a5..af145a9 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -85,7 +85,6 @@ struct omap_dm_timer;
 
 struct timer_regs {
 	u32 tidr;
-	u32 tisr;
 	u32 tier;
 	u32 twer;
 	u32 tclr;
-- 
1.7.9.5

