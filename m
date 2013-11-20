From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 17/31] arm: omap: irq: drop .handle_irq and .init_irq fields
Date: Wed, 20 Nov 2013 12:09:04 -0600
Message-ID: <1384970958-4118-18-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39944 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab3KTSKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:35 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

now we can safely drop those fields from our machine_desc.

While at that, also drop the now unused omap_intc_of_init()
definition.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 12 ------------
 arch/arm/mach-omap2/common.h        |  1 -
 arch/arm/mach-omap2/irq.c           |  5 -----
 3 files changed, 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 19f1652..d63bf99 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -48,8 +48,6 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_time	= omap2_sync32k_timer_init,
 	.dt_compat	= omap242x_boards_compat,
@@ -67,8 +65,6 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_time	= omap2_sync32k_timer_init,
 	.dt_compat	= omap243x_boards_compat,
@@ -86,8 +82,6 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
 	.init_time	= omap3_sync32k_timer_init,
@@ -104,8 +98,6 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3630_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
 	.init_time	= omap3_sync32k_timer_init,
@@ -123,8 +115,6 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
 	.init_time	= omap3_secure_sync32k_timer_init,
@@ -143,8 +133,6 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
-	.init_irq	= omap_intc_of_init,
-	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= am33xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 89e73fe..4df64c36 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -201,7 +201,6 @@ void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
 void omap3_intc_handle_irq(struct pt_regs *regs);
-void omap_intc_of_init(void);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 5c3ab05..8104f85 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -325,11 +325,6 @@ static int __init intc_of_init(struct device_node *node,
 
 IRQCHIP_DECLARE(omap_intc, "ti,omap2-intc", intc_of_init);
 
-void __init omap_intc_of_init(void)
-{
-	of_irq_init(&irqchip_of_match_omap_intc);
-}
-
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
 	omap_intc_handle_irq(regs);
-- 
1.8.4.GIT

