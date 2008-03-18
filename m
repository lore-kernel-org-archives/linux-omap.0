From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/12] ARM: OMAP2: Remove old 24xx PM code
Date: Tue, 18 Mar 2008 12:39:53 +0200
Message-ID: <1205836800-31737-6-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-123926
 <1205836800-31737-1-git-send-email-tony@atomide.com>
 <1205836800-31737-2-git-send-email-tony@atomide.com>
 <1205836800-31737-3-git-send-email-tony@atomide.com>
 <1205836800-31737-4-git-send-email-tony@atomide.com>
 <1205836800-31737-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51701 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYCRKk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 06:40:56 -0400
In-Reply-To: <1205836800-31737-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This patch removes old 24xx PM code that does not really work for sleep
states, and uses old power management register access. Working PM code
will be added later.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm.c |  270 +---------------------------------------------
 1 files changed, 1 insertions(+), 269 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index baf7d82..aad781d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -23,6 +23,7 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -36,8 +37,6 @@
 #include <asm/arch/sram.h>
 #include <asm/arch/pm.h>
 
-#include "prcm-regs.h"
-
 static struct clk *vclk;
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(int dllctrl, int cpu_rev);
@@ -78,251 +77,8 @@ static int omap2_pm_prepare(void)
 	return 0;
 }
 
-#define INT0_WAKE_MASK	(OMAP_IRQ_BIT(INT_24XX_GPIO_BANK1) |	\
-			OMAP_IRQ_BIT(INT_24XX_GPIO_BANK2) |	\
-			OMAP_IRQ_BIT(INT_24XX_GPIO_BANK3))
-
-#define INT1_WAKE_MASK	(OMAP_IRQ_BIT(INT_24XX_GPIO_BANK4))
-
-#define INT2_WAKE_MASK	(OMAP_IRQ_BIT(INT_24XX_UART1_IRQ) |	\
-			OMAP_IRQ_BIT(INT_24XX_UART2_IRQ) |	\
-			OMAP_IRQ_BIT(INT_24XX_UART3_IRQ))
-
-#define preg(reg)	printk("%s\t(0x%p):\t0x%08x\n", #reg, &reg, reg);
-
-static void omap2_pm_debug(char * desc)
-{
-	printk("%s:\n", desc);
-
-	preg(CM_CLKSTCTRL_MPU);
-	preg(CM_CLKSTCTRL_CORE);
-	preg(CM_CLKSTCTRL_GFX);
-	preg(CM_CLKSTCTRL_DSP);
-	preg(CM_CLKSTCTRL_MDM);
-
-	preg(PM_PWSTCTRL_MPU);
-	preg(PM_PWSTCTRL_CORE);
-	preg(PM_PWSTCTRL_GFX);
-	preg(PM_PWSTCTRL_DSP);
-	preg(PM_PWSTCTRL_MDM);
-
-	preg(PM_PWSTST_MPU);
-	preg(PM_PWSTST_CORE);
-	preg(PM_PWSTST_GFX);
-	preg(PM_PWSTST_DSP);
-	preg(PM_PWSTST_MDM);
-
-	preg(CM_AUTOIDLE1_CORE);
-	preg(CM_AUTOIDLE2_CORE);
-	preg(CM_AUTOIDLE3_CORE);
-	preg(CM_AUTOIDLE4_CORE);
-	preg(CM_AUTOIDLE_WKUP);
-	preg(CM_AUTOIDLE_PLL);
-	preg(CM_AUTOIDLE_DSP);
-	preg(CM_AUTOIDLE_MDM);
-
-	preg(CM_ICLKEN1_CORE);
-	preg(CM_ICLKEN2_CORE);
-	preg(CM_ICLKEN3_CORE);
-	preg(CM_ICLKEN4_CORE);
-	preg(CM_ICLKEN_GFX);
-	preg(CM_ICLKEN_WKUP);
-	preg(CM_ICLKEN_DSP);
-	preg(CM_ICLKEN_MDM);
-
-	preg(CM_IDLEST1_CORE);
-	preg(CM_IDLEST2_CORE);
-	preg(CM_IDLEST3_CORE);
-	preg(CM_IDLEST4_CORE);
-	preg(CM_IDLEST_GFX);
-	preg(CM_IDLEST_WKUP);
-	preg(CM_IDLEST_CKGEN);
-	preg(CM_IDLEST_DSP);
-	preg(CM_IDLEST_MDM);
-
-	preg(RM_RSTST_MPU);
-	preg(RM_RSTST_GFX);
-	preg(RM_RSTST_WKUP);
-	preg(RM_RSTST_DSP);
-	preg(RM_RSTST_MDM);
-
-	preg(PM_WKDEP_MPU);
-	preg(PM_WKDEP_CORE);
-	preg(PM_WKDEP_GFX);
-	preg(PM_WKDEP_DSP);
-	preg(PM_WKDEP_MDM);
-
-	preg(CM_FCLKEN_WKUP);
-	preg(CM_ICLKEN_WKUP);
-	preg(CM_IDLEST_WKUP);
-	preg(CM_AUTOIDLE_WKUP);
-	preg(CM_CLKSEL_WKUP);
-
-	preg(PM_WKEN_WKUP);
-	preg(PM_WKST_WKUP);
-}
-
-static inline void omap2_pm_save_registers(void)
-{
-	/* Save interrupt registers */
-	OMAP24XX_SAVE(INTC_MIR0);
-	OMAP24XX_SAVE(INTC_MIR1);
-	OMAP24XX_SAVE(INTC_MIR2);
-
-	/* Save power control registers */
-	OMAP24XX_SAVE(CM_CLKSTCTRL_MPU);
-	OMAP24XX_SAVE(CM_CLKSTCTRL_CORE);
-	OMAP24XX_SAVE(CM_CLKSTCTRL_GFX);
-	OMAP24XX_SAVE(CM_CLKSTCTRL_DSP);
-	OMAP24XX_SAVE(CM_CLKSTCTRL_MDM);
-
-	/* Save power state registers */
-	OMAP24XX_SAVE(PM_PWSTCTRL_MPU);
-	OMAP24XX_SAVE(PM_PWSTCTRL_CORE);
-	OMAP24XX_SAVE(PM_PWSTCTRL_GFX);
-	OMAP24XX_SAVE(PM_PWSTCTRL_DSP);
-	OMAP24XX_SAVE(PM_PWSTCTRL_MDM);
-
-	/* Save autoidle registers */
-	OMAP24XX_SAVE(CM_AUTOIDLE1_CORE);
-	OMAP24XX_SAVE(CM_AUTOIDLE2_CORE);
-	OMAP24XX_SAVE(CM_AUTOIDLE3_CORE);
-	OMAP24XX_SAVE(CM_AUTOIDLE4_CORE);
-	OMAP24XX_SAVE(CM_AUTOIDLE_WKUP);
-	OMAP24XX_SAVE(CM_AUTOIDLE_PLL);
-	OMAP24XX_SAVE(CM_AUTOIDLE_DSP);
-	OMAP24XX_SAVE(CM_AUTOIDLE_MDM);
-
-	/* Save idle state registers */
-	OMAP24XX_SAVE(CM_IDLEST1_CORE);
-	OMAP24XX_SAVE(CM_IDLEST2_CORE);
-	OMAP24XX_SAVE(CM_IDLEST3_CORE);
-	OMAP24XX_SAVE(CM_IDLEST4_CORE);
-	OMAP24XX_SAVE(CM_IDLEST_GFX);
-	OMAP24XX_SAVE(CM_IDLEST_WKUP);
-	OMAP24XX_SAVE(CM_IDLEST_CKGEN);
-	OMAP24XX_SAVE(CM_IDLEST_DSP);
-	OMAP24XX_SAVE(CM_IDLEST_MDM);
-
-	/* Save clock registers */
-	OMAP24XX_SAVE(CM_FCLKEN1_CORE);
-	OMAP24XX_SAVE(CM_FCLKEN2_CORE);
-	OMAP24XX_SAVE(CM_ICLKEN1_CORE);
-	OMAP24XX_SAVE(CM_ICLKEN2_CORE);
-	OMAP24XX_SAVE(CM_ICLKEN3_CORE);
-	OMAP24XX_SAVE(CM_ICLKEN4_CORE);
-}
-
-static inline void omap2_pm_restore_registers(void)
-{
-	/* Restore clock state registers */
-	OMAP24XX_RESTORE(CM_CLKSTCTRL_MPU);
-	OMAP24XX_RESTORE(CM_CLKSTCTRL_CORE);
-	OMAP24XX_RESTORE(CM_CLKSTCTRL_GFX);
-	OMAP24XX_RESTORE(CM_CLKSTCTRL_DSP);
-	OMAP24XX_RESTORE(CM_CLKSTCTRL_MDM);
-
-	/* Restore power state registers */
-	OMAP24XX_RESTORE(PM_PWSTCTRL_MPU);
-	OMAP24XX_RESTORE(PM_PWSTCTRL_CORE);
-	OMAP24XX_RESTORE(PM_PWSTCTRL_GFX);
-	OMAP24XX_RESTORE(PM_PWSTCTRL_DSP);
-	OMAP24XX_RESTORE(PM_PWSTCTRL_MDM);
-
-	/* Restore idle state registers */
-	OMAP24XX_RESTORE(CM_IDLEST1_CORE);
-	OMAP24XX_RESTORE(CM_IDLEST2_CORE);
-	OMAP24XX_RESTORE(CM_IDLEST3_CORE);
-	OMAP24XX_RESTORE(CM_IDLEST4_CORE);
-	OMAP24XX_RESTORE(CM_IDLEST_GFX);
-	OMAP24XX_RESTORE(CM_IDLEST_WKUP);
-	OMAP24XX_RESTORE(CM_IDLEST_CKGEN);
-	OMAP24XX_RESTORE(CM_IDLEST_DSP);
-	OMAP24XX_RESTORE(CM_IDLEST_MDM);
-
-	/* Restore autoidle registers */
-	OMAP24XX_RESTORE(CM_AUTOIDLE1_CORE);
-	OMAP24XX_RESTORE(CM_AUTOIDLE2_CORE);
-	OMAP24XX_RESTORE(CM_AUTOIDLE3_CORE);
-	OMAP24XX_RESTORE(CM_AUTOIDLE4_CORE);
-	OMAP24XX_RESTORE(CM_AUTOIDLE_WKUP);
-	OMAP24XX_RESTORE(CM_AUTOIDLE_PLL);
-	OMAP24XX_RESTORE(CM_AUTOIDLE_DSP);
-	OMAP24XX_RESTORE(CM_AUTOIDLE_MDM);
-
-	/* Restore clock registers */
-	OMAP24XX_RESTORE(CM_FCLKEN1_CORE);
-	OMAP24XX_RESTORE(CM_FCLKEN2_CORE);
-	OMAP24XX_RESTORE(CM_ICLKEN1_CORE);
-	OMAP24XX_RESTORE(CM_ICLKEN2_CORE);
-	OMAP24XX_RESTORE(CM_ICLKEN3_CORE);
-	OMAP24XX_RESTORE(CM_ICLKEN4_CORE);
-
-	/* REVISIT: Clear interrupts here */
-
-	/* Restore interrupt registers */
-	OMAP24XX_RESTORE(INTC_MIR0);
-	OMAP24XX_RESTORE(INTC_MIR1);
-	OMAP24XX_RESTORE(INTC_MIR2);
-}
-
 static int omap2_pm_suspend(void)
 {
-	int processor_type = 0;
-
-	/* REVISIT: 0x21 or 0x26? */
-	if (cpu_is_omap2420())
-		processor_type = 0x21;
-
-	if (!processor_type)
-		return -ENOTSUPP;
-
-	local_irq_disable();
-	local_fiq_disable();
-
-	omap2_pm_save_registers();
-
-	/* Disable interrupts except for the wake events */
-	INTC_MIR_SET0 = 0xffffffff & ~INT0_WAKE_MASK;
-	INTC_MIR_SET1 = 0xffffffff & ~INT1_WAKE_MASK;
-	INTC_MIR_SET2 = 0xffffffff & ~INT2_WAKE_MASK;
-
-	pmdomain_set_autoidle();
-
-	/* Clear old wake-up events */
-	PM_WKST1_CORE = 0;
-	PM_WKST2_CORE = 0;
-	PM_WKST_WKUP = 0;
-
-	/* Enable wake-up events */
-	PM_WKEN1_CORE = (1 << 22) | (1 << 21);	/* UART1 & 2 */
-	PM_WKEN2_CORE = (1 << 2);		/* UART3 */
-	PM_WKEN_WKUP = (1 << 2) | (1 << 0);	/* GPIO & GPT1 */
-
-	/* Disable clocks except for CM_ICLKEN2_CORE. It gets disabled
-	 * in the SRAM suspend code */
-	CM_FCLKEN1_CORE = 0;
-	CM_FCLKEN2_CORE = 0;
-	CM_ICLKEN1_CORE = 0;
-	CM_ICLKEN3_CORE = 0;
-	CM_ICLKEN4_CORE = 0;
-
-	omap2_pm_debug("Status before suspend");
-
-	/* Must wait for serial buffers to clear */
-	mdelay(200);
-
-	/* Jump to SRAM suspend code
-	 * REVISIT: When is this SDRC_DLLB_CTRL?
-	 */
-	omap2_sram_suspend(SDRC_DLLA_CTRL, processor_type);
-
-	/* Back from sleep */
-	omap2_pm_restore_registers();
-
-	local_fiq_enable();
-	local_irq_enable();
-
 	return 0;
 }
 
@@ -357,30 +113,6 @@ static struct platform_suspend_ops omap_pm_ops = {
 
 int __init omap2_pm_init(void)
 {
-	printk("Power Management for TI OMAP.\n");
-
-	vclk = clk_get(NULL, "virt_prcm_set");
-	if (IS_ERR(vclk)) {
-		printk(KERN_ERR "Could not get PM vclk\n");
-		return -ENODEV;
-	}
-
-	/*
-	 * We copy the assembler sleep/wakeup routines to SRAM.
-	 * These routines need to be in SRAM as that's the only
-	 * memory the MPU can see when it wakes up.
-	 */
-	omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
-					 omap24xx_idle_loop_suspend_sz);
-
-	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
-					    omap24xx_cpu_suspend_sz);
-
-	suspend_set_ops(&omap_pm_ops);
-	pm_idle = omap2_pm_idle;
-
-	pmdomain_init();
-
 	return 0;
 }
 
-- 
1.5.3.6

