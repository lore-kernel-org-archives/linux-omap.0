From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 11/16] OMAP3: PER/NEON/CORE control in idle
Date: Fri, 26 Sep 2008 17:49:22 +0530
Message-ID: <01fc01c91fd2$1bc9c110$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52966 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbYIZMTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:19:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds handling of PER/NEON and CORE domain in idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c             |   69 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/serial.c             |   19 +++-----
 arch/arm/plat-omap/include/mach/common.h |    2 
 3 files changed, 66 insertions(+), 24 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:17.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:17.000000000 +0530
@@ -52,7 +52,10 @@ static void (*_omap_sram_idle)(u32 *addr
 
 static void (*saved_idle)(void);
 
-static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
+static struct powerdomain *core_pwrdm, *per_pwrdm;
+
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
@@ -154,13 +157,22 @@ static void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0;
+	int mpu_next_state = PWRDM_POWER_ON;
+	int per_next_state = PWRDM_POWER_ON;
+	int core_next_state = PWRDM_POWER_ON;
 
 	if (!_omap_sram_idle)
 		return;
 
+	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
+	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
+	pwrdm_clear_all_prev_pwrst(core_pwrdm);
+	pwrdm_clear_all_prev_pwrst(per_pwrdm);
+
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
+	case PWRDM_POWER_ON:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -176,19 +188,39 @@ static void omap_sram_idle(void)
 
 	pm_dbg_pre_suspend();
 
-	omap2_gpio_prepare_for_retention();
-
-	/* Disable UART clocks */
-	if (clocks_off_while_idle)
-		omap_serial_enable_clocks(0);
+	/* NEON control */
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+		set_pwrdm_state(neon_pwrdm, mpu_next_state);
+
+	/* CORE & PER */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		/* PER changes only with core */
+		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+		if (clocks_off_while_idle) {
+			if (per_next_state < PWRDM_POWER_ON)
+				omap_serial_enable_clocks(0, 2);
+			omap_serial_enable_clocks(0, 0);
+			omap_serial_enable_clocks(0, 1);
+		}
+		/* Enable IO-PAD wakeup */
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+	}
 
 	_omap_sram_idle(NULL, save_state);
 
-	/* Enable UART clocks */
-	if (clocks_off_while_idle)
-		omap_serial_enable_clocks(1);
-
-	omap2_gpio_resume_after_retention();
+	if (core_next_state < PWRDM_POWER_ON) {
+		/* Disable IO-PAD wakeup */
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		if (clocks_off_while_idle) {
+			omap_serial_enable_clocks(1, 0);
+			omap_serial_enable_clocks(1, 1);
+			if (per_next_state < PWRDM_POWER_ON)
+				omap_serial_enable_clocks(1, 2);
+		}
+		omap2_gpio_resume_after_retention();
+	}
 
 	pm_dbg_post_suspend();
 
@@ -598,11 +630,24 @@ int __init omap3_pm_init(void)
 		goto err2;
 	}
 
+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+
 	omap_push_sram_idle();
 	suspend_set_ops(&omap_pm_ops);
 
 	pm_idle = omap3_pm_idle;
 
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	/*
+	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
+	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
+	 * waking up PER with every CORE wakeup - see
+	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
+	*/
+	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+
 err1:
 	return ret;
 err2:
Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c	2008-09-25 16:27:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/serial.c	2008-09-25 16:27:17.000000000 +0530
@@ -162,19 +162,16 @@ static void omap_serial_kick(void)
 		NSEC_PER_MSEC);
 }
 
-void omap_serial_enable_clocks(int enable)
+void omap_serial_enable_clocks(int enable, int unum)
 {
 	int i;
-
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		if (uart_ick[i] && uart_fck[i]) {
-			if (enable) {
-				clk_enable(uart_ick[i]);
-				clk_enable(uart_fck[i]);
-			} else {
-				clk_disable(uart_ick[i]);
-				clk_disable(uart_fck[i]);
-			}
+	if (uart_ick[unum] && uart_fck[unum]) {
+		if (enable) {
+			clk_enable(uart_ick[unum]);
+			clk_enable(uart_fck[unum]);
+		} else {
+			clk_disable(uart_ick[unum]);
+			clk_disable(uart_fck[unum]);
 		}
 	}
 }
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/common.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/common.h	2008-09-25 16:27:11.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/common.h	2008-09-25 16:27:17.000000000 +0530
@@ -34,7 +34,7 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
-extern void omap_serial_enable_clocks(int enable);
+extern void omap_serial_enable_clocks(int enable, int unum);
 extern int omap_serial_can_sleep(void);
 extern void omap_serial_fclk_mask(u32 *f1, u32 *f2);
 void omap_serial_check_wakeup(void);

