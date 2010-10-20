From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP: UART: use atomic idle notifiers
Date: Wed, 20 Oct 2010 16:31:23 -0700
Message-ID: <1287617483-24170-3-git-send-email-khilman@deeprootsystems.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41797 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0JTXba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 19:31:30 -0400
Received: by pwj9 with SMTP id 9so98437pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 16:31:30 -0700 (PDT)
In-Reply-To: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Convert UART idle management routines from custom hooks in the core
idle path to use new idle notifiers.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm24xx.c             |    9 +---
 arch/arm/mach-omap2/pm34xx.c             |    8 ---
 arch/arm/mach-omap2/serial.c             |   71 +++++++++++++++++++----------
 arch/arm/plat-omap/include/plat/serial.h |    2 -
 4 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index cb1b333..47644d2 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -40,6 +40,7 @@
 #include <plat/sram.h>
 #include <plat/dma.h>
 #include <plat/board.h>
+#include <plat/common.h>
 
 #include "prm.h"
 #include "prm-regbits-24xx.h"
@@ -120,19 +121,11 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
-
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
-	omap_uart_resume_idle(2);
-	omap_uart_resume_idle(1);
-	omap_uart_resume_idle(0);
-
 no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4674748..eaed95d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -390,8 +390,6 @@ void omap_sram_idle(void)
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -399,8 +397,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
@@ -445,8 +441,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -459,8 +453,6 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index becf0e3..8a619ff 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,6 +73,7 @@ struct omap_uart_state {
 	u32 padconf;
 	u32 dma_enabled;
 
+	struct powerdomain *pwrdm;
 	struct clk *ick;
 	struct clk *fck;
 	int clocked;
@@ -389,39 +390,31 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
-void omap_uart_prepare_idle(int num)
+static void omap_uart_prepare_idle(struct omap_uart_state *uart)
 {
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
-			return;
-		}
-	}
+	if (uart->can_sleep &&
+	    pwrdm_read_next_pwrst(uart->pwrdm) < PWRDM_POWER_ON)
+		omap_uart_disable_clocks(uart);
 }
 
-void omap_uart_resume_idle(int num)
+static void omap_uart_resume_idle(struct omap_uart_state *uart)
 {
-	struct omap_uart_state *uart;
+	if (uart->can_sleep &&
+	    pwrdm_read_next_pwrst(uart->pwrdm) < PWRDM_POWER_ON) {
+		omap_uart_enable_clocks(uart);
 
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num) {
-			omap_uart_enable_clocks(uart);
-
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
-
-				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
-			}
+		/* Check for IO pad wakeup */
+		if (cpu_is_omap34xx() && uart->padconf) {
+			u16 p = omap_ctrl_readw(uart->padconf);
 
-			/* Check for normal UART wakeup */
-			if (__raw_readl(uart->wk_st) & uart->wk_mask)
+			if (p & OMAP3_PADCONF_WAKEUPEVENT0)
 				omap_uart_block_sleep(uart);
-			return;
 		}
+
+		/* Check for normal UART wakeup */
+		if (__raw_readl(uart->wk_st) & uart->wk_mask)
+			omap_uart_block_sleep(uart);
+		return;
 	}
 }
 
@@ -474,6 +467,27 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static int omap_uart_idle_notifier(struct notifier_block *n,
+				   unsigned long val,
+				   void *p)
+{
+	struct omap_uart_state *uart;
+
+	if (val == OMAP_IDLE_START)
+		list_for_each_entry(uart, &uart_list, node)
+			omap_uart_prepare_idle(uart);
+	else
+		list_for_each_entry(uart, &uart_list, node)
+			omap_uart_resume_idle(uart);
+
+	return 0;
+}
+
+static bool omap_uart_notifier_enabled;
+static struct notifier_block omap_uart_notifier = {
+	.notifier_call = omap_uart_idle_notifier,
+};
+
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
 	int ret;
@@ -549,6 +563,11 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
 				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
+
+	if (!omap_uart_notifier_enabled) {
+		omap_idle_notifier_register(&omap_uart_notifier);
+		omap_uart_notifier_enabled = true;
+	}
 }
 
 void omap_uart_enable_irqs(int enable)
@@ -731,6 +750,8 @@ void __init omap_serial_init_port(int port)
 			break;
 
 	oh = uart->oh;
+	uart->pwrdm = omap_hwmod_get_pwrdm(oh);
+	WARN_ON(!uart->pwrdm);
 	uart->dma_enabled = 0;
 #ifndef CONFIG_SERIAL_OMAP
 	name = "serial8250";
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 19145f5..d3ee47b 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -99,8 +99,6 @@ extern void omap_serial_init_port(int port);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
-extern void omap_uart_resume_idle(int num);
 extern void omap_uart_enable_irqs(int enable);
 #endif
 
-- 
1.7.2.1

