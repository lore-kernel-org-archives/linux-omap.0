From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 14/16] OMAP3: CORE Off support
Date: Fri, 26 Sep 2008 17:50:07 +0530
Message-ID: <01ff01c91fd2$36b19250$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYIZMUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:20:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch updates omap_sram_idle with CORE OFF support

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   79 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 77 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-26 16:38:37.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-26 16:39:18.000000000 +0530
@@ -7,6 +7,9 @@
  * Tony Lindgren <tony@atomide.com>
  * Jouni Hogander
  *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
  * Copyright (C) 2005 Texas Instruments, Inc.
  * Richard Woodruff <r-woodruff2@ti.com>
  *
@@ -27,11 +30,15 @@
 #include <mach/gpio.h>
 #include <mach/sram.h>
 #include <mach/pm.h>
+#include <mach/prcm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/common.h>
 #include <mach/control.h>
+#include <mach/serial.h>
+#include <mach/gpio.h>
 #include <mach/sdrc.h>
+#include <mach/gpmc.h>
 #include <asm/tlbflush.h>
 
 #include "cm.h"
@@ -59,6 +66,46 @@ static struct powerdomain *mpu_pwrdm, *n
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 
 int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+void omap3_sram_restore_context(void);
+
+void omap3_per_save_context(void)
+{
+	omap3_gpio_save_context();
+}
+
+void omap3_per_restore_context(void)
+{
+	omap3_gpio_restore_context();
+}
+
+void omap3_core_save_context(void)
+{
+	u32 control_padconf_off;
+	/* Save the padconf registers */
+	control_padconf_off =
+	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
+	control_padconf_off |= START_PADCONF_SAVE;
+	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
+	/* wait for the save to complete */
+	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+			& PADCONF_SAVE_DONE);
+	/* Save the Interrupt controller context */
+	omap3_intc_save_context();
+	/* Save the GPMC context */
+	omap3_gpmc_save_context();
+	/* Save the system control module context, padconf already save above*/
+	omap3_control_save_context();
+}
+
+void omap3_core_restore_context(void)
+{
+	/* Restore the control module context, padconf restored by h/w */
+	omap3_control_restore_context();
+	/* Restore the GPMC context */
+	omap3_gpmc_restore_context();
+	/* Restore the interrupt controller context */
+	omap3_intc_restore_context();
+}
 
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
@@ -191,6 +238,7 @@ static void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
+	int core_prev_state, per_prev_state;
 
 	if (!_omap_sram_idle)
 		return;
@@ -232,8 +280,19 @@ static void omap_sram_idle(void)
 		/* PER changes only with core */
 		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 		if (clocks_off_while_idle) {
-			if (per_next_state < PWRDM_POWER_ON)
+			if (per_next_state < PWRDM_POWER_ON) {
+				if (per_next_state == PWRDM_POWER_OFF) {
+					omap3_per_save_context();
+					omap3_uart_save_context(2);
+				}
 				omap_serial_enable_clocks(0, 2);
+			}
+			if (core_next_state == PWRDM_POWER_OFF) {
+				omap3_core_save_context();
+				omap3_prcm_save_context();
+				omap3_uart_save_context(0);
+				omap3_uart_save_context(1);
+			}
 			omap_serial_enable_clocks(0, 0);
 			omap_serial_enable_clocks(0, 1);
 		}
@@ -258,8 +317,23 @@ static void omap_sram_idle(void)
 		if (clocks_off_while_idle) {
 			omap_serial_enable_clocks(1, 0);
 			omap_serial_enable_clocks(1, 1);
-			if (per_next_state < PWRDM_POWER_ON)
+			core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
+			if (core_prev_state == PWRDM_POWER_OFF) {
+				omap3_core_restore_context();
+				omap3_prcm_restore_context();
+				omap3_sram_restore_context();
+				omap3_uart_restore_context(0);
+				omap3_uart_restore_context(1);
+			}
+			if (per_next_state < PWRDM_POWER_ON) {
 				omap_serial_enable_clocks(1, 2);
+				per_prev_state =
+					pwrdm_read_prev_pwrst(per_pwrdm);
+				if (per_prev_state == PWRDM_POWER_OFF) {
+					omap3_per_restore_context();
+					omap3_uart_restore_context(2);
+				}
+			}
 		}
 		omap2_gpio_resume_after_retention();
 	}
@@ -648,6 +722,7 @@ int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
+	omap3_save_scratchpad_contents();
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,

