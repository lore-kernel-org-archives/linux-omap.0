From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 06/17] OMAP3: PM: Added next state check for IVA2, USB and PER into idle loop
Date: Fri, 16 Oct 2009 13:48:59 +0300
Message-ID: <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32267 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbZJPLEW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:22 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2f4Y011809
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:54 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa0022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:49 +0300
In-Reply-To: <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This is needed to prevent core from entering off mode if one of the IVA2,
USB or PER powerdomains are going to stay at least in retention state.
If this is not done, a powerdomain waking from RET may access core
domain which has just been reset.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 588ab79..3e5ae14 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -85,6 +85,13 @@ u32 voltage_off_while_idle;
 		OMAP3430_ST_DES1_MASK)
 #define CORE_IDLEST3_ALL		(\
 		OMAP3430ES2_ST_USBTLL_MASK|OMAP3430ES2_ST_CPEFUSE_MASK)
+#define PER_IDLEST_ALL			(\
+		OMAP3430_ST_WDT3_MASK|OMAP3430_ST_MCBSP4_MASK|\
+		OMAP3430_ST_MCBSP3_MASK|OMAP3430_ST_MCBSP2_MASK|\
+		OMAP3430_ST_GPT9_MASK|OMAP3430_ST_GPT8_MASK|\
+		OMAP3430_ST_GPT7_MASK|OMAP3430_ST_GPT6_MASK|\
+		OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
+		OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -103,7 +110,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm, *iva2_pwrdm, *dss_pwrdm;
+static struct powerdomain *cam_pwrdm, *iva2_pwrdm, *dss_pwrdm, *usb_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
@@ -428,6 +435,8 @@ void omap_sram_idle(void)
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int dss_state = PWRDM_POWER_ON;
+	int iva2_state = PWRDM_POWER_ON;
+	int usb_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
@@ -463,14 +472,28 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
+	/* Get powerdomain state data */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	dss_state = pwrdm_read_pwrst(dss_pwrdm);
+	iva2_state = pwrdm_read_pwrst(iva2_pwrdm);
+	usb_state = pwrdm_read_pwrst(usb_pwrdm);
+	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+
+	/* Check if PER domain can enter OFF or not */
+	if (per_next_state == PWRDM_POWER_OFF) {
+		if ((cm_read_mod_reg(OMAP3430_PER_MOD, CM_IDLEST) &
+				PER_IDLEST_ALL) != PER_IDLEST_ALL) {
+			per_next_state = PWRDM_POWER_RET;
+			pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
+			per_state_modified = 1;
+		}
+	}
 	/*
 	 * Check whether core will enter idle or not. This is needed
 	 * because I/O pad wakeup will fail if core stays on and PER
 	 * enters off. This will also prevent unnecessary core context
 	 * save / restore.
 	 */
-	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	dss_state = pwrdm_read_pwrst(dss_pwrdm);
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_saved_state = core_next_state;
 		if ((cm_read_mod_reg(CORE_MOD, CM_IDLEST1) & CORE_IDLEST1_ALL)
@@ -482,14 +505,16 @@ void omap_sram_idle(void)
 			core_next_state = PWRDM_POWER_ON;
 			pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
 		} else if (core_next_state == PWRDM_POWER_OFF &&
-				 dss_state == PWRDM_POWER_ON) {
+				 (dss_state == PWRDM_POWER_ON ||
+				  iva2_state >= PWRDM_POWER_RET ||
+				  usb_state >= PWRDM_POWER_RET ||
+				  per_next_state >= PWRDM_POWER_RET)) {
 			core_next_state = PWRDM_POWER_RET;
 			pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
 		}
 	}
 
 	/* PER */
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_idle(per_next_state);
@@ -1240,6 +1265,7 @@ static int __init omap3_pm_init(void)
 	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 	iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
 	dss_pwrdm = pwrdm_lookup("dss_pwrdm");
+	usb_pwrdm = pwrdm_lookup("usbhost_pwrdm");
 
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
-- 
1.5.4.3

