From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 27/31] arm: omap: irq: drop omap_pending_irq()
Date: Wed, 20 Nov 2013 12:09:14 -0600
Message-ID: <1384970958-4118-28-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48487 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707Ab3KTSKw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:52 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

We already ack pending IRQs during suspend,
which renders the check for pending IRQs
quite unnecessary.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h      |  1 -
 arch/arm/mach-omap2/cpuidle34xx.c |  2 +-
 arch/arm/mach-omap2/irq.c         | 11 -----------
 arch/arm/mach-omap2/pm24xx.c      | 11 -----------
 arch/arm/mach-omap2/pm34xx.c      |  3 ---
 5 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 427160b..f44a410 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -198,7 +198,6 @@ extern struct device *omap4_get_dsp_device(void);
 void omap2_init_irq(void);
 void omap3_init_irq(void);
 void ti81xx_init_irq(void);
-extern int omap_irq_pending(void);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e18709d..96cced3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -112,7 +112,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 
-	if (omap_irq_pending() || need_resched())
+	if (need_resched())
 		goto return_sleep_time;
 
 	/* Deny idle for C1 */
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 5425258..397157a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -186,17 +186,6 @@ static void __init omap_irq_soft_reset(void)
 	intc_writel(INTC_SYSCONFIG, 1 << 0);
 }
 
-int omap_irq_pending(void)
-{
-	int irq;
-
-	for (irq = 0; irq < omap_nr_irqs; irq += 32)
-		if (intc_readl(INTC_PENDING_IRQ0 +
-					((irq >> 5) << 5)))
-			return 1;
-	return 0;
-}
-
 static __init void
 omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 {
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 8c07594..33ea27c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -88,17 +88,11 @@ static int omap2_enter_full_retention(void)
 
 	omap2_gpio_prepare_for_idle(0);
 
-	/* One last check for pending IRQs to avoid extra latency due
-	 * to sleeping unnecessarily. */
-	if (omap_irq_pending())
-		goto no_sleep;
-
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
-no_sleep:
 	omap2_gpio_resume_after_idle();
 
 	clk_enable(osc_ck);
@@ -181,15 +175,10 @@ static int omap2_can_sleep(void)
 static void omap2_pm_idle(void)
 {
 	if (!omap2_can_sleep()) {
-		if (omap_irq_pending())
-			return;
 		omap2_enter_mpu_retention();
 		return;
 	}
 
-	if (omap_irq_pending())
-		return;
-
 	omap2_enter_full_retention();
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2764796..7c43fa0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -338,9 +338,6 @@ void omap_sram_idle(void)
 
 static void omap3_pm_idle(void)
 {
-	if (omap_irq_pending())
-		return;
-
 	trace_cpu_idle(1, smp_processor_id());
 
 	omap_sram_idle();
-- 
1.8.4.GIT

