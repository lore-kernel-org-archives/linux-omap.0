From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/28] OMAP3: PM: CORE domain off-mode support
Date: Thu,  1 Oct 2009 16:58:41 -0700
Message-ID: <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZJAX7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:15 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:19 -0700 (PDT)
In-Reply-To: <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   73 +++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/sram.h |    1 +
 2 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b0b2413..1f238c3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -5,6 +5,9 @@
  * Tony Lindgren <tony@atomide.com>
  * Jouni Hogander
  *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
  * Copyright (C) 2005 Texas Instruments, Inc.
  * Richard Woodruff <r-woodruff2@ti.com>
  *
@@ -24,11 +27,13 @@
 #include <linux/gpio.h>
 
 #include <mach/sram.h>
+#include <mach/prcm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/control.h>
 #include <mach/serial.h>
 #include <mach/sdrc.h>
+#include <mach/gpmc.h>
 
 #include <asm/tlbflush.h>
 
@@ -39,6 +44,11 @@
 #include "prm.h"
 #include "pm.h"
 
+/* Scratchpad offsets */
+#define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
+#define OMAP343X_TABLE_VALUE_OFFSET	   0x30
+#define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -57,6 +67,46 @@ static struct powerdomain *core_pwrdm, *per_pwrdm;
 
 static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
+static inline void omap3_per_save_context(void)
+{
+	omap3_gpio_save_context();
+}
+
+static inline void omap3_per_restore_context(void)
+{
+	omap3_gpio_restore_context();
+}
+
+static void omap3_core_save_context(void)
+{
+	u32 control_padconf_off;
+	/* Save the padconf registers */
+	control_padconf_off =
+	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
+	control_padconf_off |= START_PADCONF_SAVE;
+	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
+	/* wait for the save to complete */
+	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+			& PADCONF_SAVE_DONE)
+		;
+	/* Save the Interrupt controller context */
+	omap3_intc_save_context();
+	/* Save the GPMC context */
+	omap3_gpmc_save_context();
+	/* Save the system control module context, padconf already save above*/
+	omap3_control_save_context();
+}
+
+static void omap3_core_restore_context(void)
+{
+	/* Restore the control module context, padconf restored by h/w */
+	omap3_control_restore_context();
+	/* Restore the GPMC context */
+	omap3_gpmc_restore_context();
+	/* Restore the interrupt controller context */
+	omap3_intc_restore_context();
+}
+
 /*
  * PRCM Interrupt Handler Helper Function
  *
@@ -206,6 +256,7 @@ static void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
+	int core_prev_state, per_prev_state;
 
 	if (!_omap_sram_idle)
 		return;
@@ -244,8 +295,15 @@ static void omap_sram_idle(void)
 		omap_uart_prepare_idle(1);
 		/* PER changes only with core */
 		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-		if (per_next_state < PWRDM_POWER_ON)
+		if (per_next_state < PWRDM_POWER_ON) {
 			omap_uart_prepare_idle(2);
+			if (per_next_state == PWRDM_POWER_OFF)
+				omap3_per_save_context();
+		}
+		if (core_next_state == PWRDM_POWER_OFF) {
+			omap3_core_save_context();
+			omap3_prcm_save_context();
+		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}
@@ -270,6 +328,18 @@ static void omap_sram_idle(void)
 
 		/* Disable IO-PAD wakeup */
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
+		if (core_prev_state == PWRDM_POWER_OFF) {
+			omap3_core_restore_context();
+			omap3_prcm_restore_context();
+			omap3_sram_restore_context();
+		}
+		if (per_next_state < PWRDM_POWER_ON) {
+			per_prev_state =
+				pwrdm_read_prev_pwrst(per_pwrdm);
+			if (per_prev_state == PWRDM_POWER_OFF)
+				omap3_per_restore_context();
+		}
 		omap2_gpio_resume_after_retention();
 	}
 
@@ -840,6 +910,7 @@ static int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
+	omap3_save_scratchpad_contents();
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index a943014..22f04f8 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -27,6 +27,7 @@ extern u32 omap3_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
 			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
 extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-- 
1.6.4.3

