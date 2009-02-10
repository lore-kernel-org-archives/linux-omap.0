From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] per board prm timings
Date: Tue, 10 Feb 2009 18:04:35 +0200
Message-ID: <1234281875-19768-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1234281875-19768-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46517 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbZBJQFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 11:05:08 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1AG4gZe014828
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 18:05:04 +0200
In-Reply-To: <1234281875-19768-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

API definition to set prm setup times.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    9 +++++++++
 arch/arm/mach-omap2/pm34xx.c |   31 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 451f247..d79ea07 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -33,9 +33,18 @@ extern void *omap3_secure_ram_storage;
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 #ifdef CONFIG_ARCH_OMAP3
+struct prm_setup_times {
+	u16 clksetup;
+	u16 voltsetup_time1;
+	u16 voltsetup_time2;
+	u16 voltoffset;
+	u16 voltsetup2;
+};
+
 extern void omap3_pm_off_mode_enable(int);
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
+extern void omap3_set_prm_setup_times(struct prm_setup_times *setup_times);
 #else
 #define omap3_pm_off_mode_enable(int) do {} while (0);
 #define omap3_pm_get_suspend_state(pwrdm) do {} while (0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 44189a0..06aa382 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -85,6 +85,14 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
+static struct prm_setup_times prm_setup = {
+	.clksetup = 0xff,
+	.voltsetup_time1 = 0xfff,
+	.voltsetup_time2 = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+};
+
 static inline void omap3_per_save_context(void)
 {
 	omap3_gpio_save_context();
@@ -880,6 +888,15 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
+void omap3_set_prm_setup_times(struct prm_setup_times *setup_times)
+{
+	prm_setup.clksetup = setup_times->clksetup;
+	prm_setup.voltsetup_time1 = setup_times->voltsetup_time1;
+	prm_setup.voltsetup_time2 = setup_times->voltsetup_time2;
+	prm_setup.voltoffset = setup_times->voltoffset;
+	prm_setup.voltsetup2 = setup_times->voltsetup2;
+}
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -1015,6 +1032,7 @@ err2:
 
 static void __init configure_vc(void)
 {
+
 	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
 			(R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
@@ -1044,21 +1062,22 @@ static void __init configure_vc(void)
 				OMAP3430_GR_MOD,
 				OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
-	/* Setup voltctrl and other setup times */
+	/* Setup value for voltctrl */
 	prm_write_mod_reg(OMAP3430_AUTO_RET,
 			  OMAP3430_GR_MOD, OMAP3_PRM_VOLTCTRL_OFFSET);
 
-	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
+	/* Write setup times */
+	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
+	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
 			OMAP3430_SETUP_TIME2_SHIFT) |
-			(OMAP3430_VOLTSETUP_TIME1 <<
+			(prm_setup.voltsetup_time1 <<
 			OMAP3430_SETUP_TIME1_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
 
-	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
+	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTOFFSET_OFFSET);
-	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
+	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
-- 
1.5.6.3

