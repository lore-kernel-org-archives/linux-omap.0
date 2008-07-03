From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/3] CPU-idle trial fix + PM debug expansion
Date: Thu,  3 Jul 2008 18:59:16 +0300
Message-ID: <1215100756-31445-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
 <1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
 <1215100756-31445-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53852 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761587AbYGCOAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 10:00:05 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m63DxnNl018085
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 17:00:01 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m63Dxh3g018829
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 16:59:47 +0300
In-Reply-To: <1215100756-31445-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

CPU-idle has a possibility of working now, also added full PRCM register dump
into pm-debug.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   30 -------------------------
 arch/arm/mach-omap2/pm-debug.c    |   17 ++++++++++----
 arch/arm/mach-omap2/pm34xx.c      |   43 +++++++++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 46 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/pm-debug.c

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 7af8653..9e65631 100755
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -461,10 +461,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	per_pwrst = pwrdm_read_pwrst(per_pd);
 	neon_pwrst = pwrdm_read_pwrst(neon_pd);
 
-	/* Do this before any changes to PRCM registers */
-	if (cx->core_state == PWRDM_POWER_OFF)
-		omap3_save_prcm_ctx();
-
 	/* Program MPU to target state */
 	if (cx->mpu_state < PWRDM_POWER_ON) {
 		if (neon_pwrst == PWRDM_POWER_ON) {
@@ -478,17 +474,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
 	/* Program CORE and PER to target state */
 	if (cx->core_state < PWRDM_POWER_ON) {
-		if (per_pwrst == PWRDM_POWER_ON) {
-			omap2_gpio_prepare_for_retention();
-			if (clocks_off_while_idle) {
-				omap3_save_per_ctx();
-				per_gpio_clk_disable();
-				omap_save_uart_ctx(2);
-				omap_serial_enable_clocks(0, 2);
-			}
-		}
-		if (cx->core_state == PWRDM_POWER_OFF)
-			omap3_save_core_ctx();
 		pwrdm_set_next_pwrst(core_pd, cx->core_state);
 	}
 
@@ -510,22 +495,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 	if (cx->core_state < PWRDM_POWER_ON) {
-		if ((cx->core_state == PWRDM_POWER_OFF)
-		&& (pwrdm_read_prev_pwrst(core_pd) == PWRDM_POWER_OFF)) {
-			omap3_restore_core_ctx();
-			omap3_restore_prcm_ctx();
-			omap3_restore_sram_ctx();
-		}
 		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
-		if (per_pwrst == PWRDM_POWER_ON) {
-			if (clocks_off_while_idle) {
-				omap_serial_enable_clocks(1, 2);
-				omap_restore_uart_ctx(2);
-				per_gpio_clk_enable();
-				omap3_restore_per_ctx();
-			}
-			omap2_gpio_resume_after_retention();
-		}
 	}
 
 	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
old mode 100644
new mode 100755
index b6f8621..f35b082
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -182,26 +182,33 @@ struct pm_module_def {
 #define MOD_PRM 1
 
 static const struct pm_module_def pm_dbg_reg_modules[] = {
+	{ "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0, 0x4c },
 	{ "OCP", MOD_CM, OCP_MOD, 0, 0x10 },
 	{ "MPU", MOD_CM, MPU_MOD, 4, 0x4c },
 	{ "CORE", MOD_CM, CORE_MOD, 0, 0x4c },
-	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
+	{ "SGX", MOD_CM, OMAP3430ES2_SGX_MOD, 0, 0x4c },
 	{ "WKUP", MOD_CM, WKUP_MOD, 0, 0x40 },
-	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
 	{ "CCR", MOD_CM, PLL_MOD, 0, 0x70 },
 	{ "DSS", MOD_CM, OMAP3430_DSS_MOD, 0, 0x4c },
+	{ "CAM", MOD_CM, OMAP3430_CAM_MOD, 0, 0x4c },
 	{ "PER", MOD_CM, OMAP3430_PER_MOD, 0, 0x4c },
+	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
+	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
 	{ "USB", MOD_CM, OMAP3430ES2_USBHOST_MOD, 0, 0x4c },
 
-	{ "OCP", MOD_PRM, OCP_MOD, 0x1c },
+	{ "IVA2", MOD_PRM, OMAP3430_IVA2_MOD, 0x50, 0xfc },
+	{ "OCP", MOD_PRM, OCP_MOD, 4, 0x1c },
 	{ "MPU", MOD_PRM, MPU_MOD, 0x58, 0xe8 },
 	{ "CORE", MOD_PRM, CORE_MOD, 0x58, 0xf8 },
-	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
+	{ "SGX", MOD_PRM, OMAP3430ES2_SGX_MOD, 0x58, 0xe8 },
 	{ "WKUP", MOD_PRM, WKUP_MOD, 0xa0, 0xb0 },
-	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
 	{ "CCR", MOD_PRM, PLL_MOD, 0x40, 0x70 },
 	{ "DSS", MOD_PRM, OMAP3430_DSS_MOD, 0x58, 0xe8 },
+	{ "CAM", MOD_PRM, OMAP3430_CAM_MOD, 0x58, 0xe8 },
 	{ "PER", MOD_PRM, OMAP3430_PER_MOD, 0x58, 0xe8 },
+	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
+	{ "GLBL", MOD_PRM, OMAP3430_GR_MOD, 0x20, 0xe4 },
+	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
 	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
 	{ "", 0, 0, 0, 0 },
 };
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c4afa7d..3c62b68 100755
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -75,6 +75,8 @@ void (*_omap_sram_idle)(u32 *addr, int save_state);
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *core_pwrdm;
+static struct powerdomain *per_pwrdm;
 
 /* XXX This is for gpio fclk hack. Will be removed as gpio driver
  * handles fcks correctly */
@@ -235,6 +237,8 @@ void omap_sram_idle(void)
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
 	int save_state = 0, mpu_next_state;
+	int save_core;
+	int save_per;
 
 	if (!_omap_sram_idle)
 		return;
@@ -255,17 +259,26 @@ void omap_sram_idle(void)
 		return;
 	}
 
-	omap3_save_core_ctx();
-	omap3_save_prcm_ctx();
+	save_core = (pwrdm_read_next_pwrst(core_pwrdm) == PWRDM_POWER_OFF);
+	save_per = (pwrdm_read_next_pwrst(per_pwrdm) == PWRDM_POWER_OFF);
+
+	if (save_core) {
+		omap3_save_core_ctx();
+		omap3_save_prcm_ctx();
+	}
+
+	if (save_per)
+		omap3_save_per_ctx();
 
-	omap3_save_per_ctx();
 	omap2_gpio_prepare_for_retention();
 
 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
 	 * handles fcks correctly */
 	per_gpio_clk_disable();
 
-	omap_save_uart_ctx();
+	if (save_per)
+		omap_save_uart_ctx();
+
 	omap_serial_enable_clocks(0);
 
 	*(scratchpad_restore_addr) = restore_pointer_address;
@@ -277,19 +290,24 @@ void omap_sram_idle(void)
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
 		restore_table_entry();
 
-	omap3_restore_prcm_ctx();
-	omap3_restore_sram_ctx();
-	omap3_restore_core_ctx();
+	if (save_core) {
+		omap3_restore_prcm_ctx();
+		omap3_restore_sram_ctx();
+		omap3_restore_core_ctx();
+	}
 
 	omap_serial_enable_clocks(1); /* Causes crash with CORE off */
 
-	omap_restore_uart_ctx();
+	if (save_per)
+		omap_restore_uart_ctx();
 
 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
 	 * handles fcks correctly */
 
 	per_gpio_clk_enable();
-	omap3_restore_per_ctx();
+
+	if (save_per)
+		omap3_restore_per_ctx();
 
 	omap2_gpio_resume_after_retention();
 }
@@ -718,10 +736,13 @@ int __init omap3_pm_init(void)
 	}
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 
-	if (mpu_pwrdm == NULL || neon_pwrdm == NULL) {
-		printk(KERN_ERR "Failed to get mpu_pwrdm or neon_pwrdm\n");
+	if (mpu_pwrdm == NULL || neon_pwrdm == NULL || per_pwrdm == NULL ||
+			core_pwrdm == NULL) {
+		printk(KERN_ERR "Failed to get pwrdm pointers\n");
 		goto err2;
 	}
 
-- 
1.5.4.3

