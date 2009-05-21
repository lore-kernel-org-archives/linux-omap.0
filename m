From: Mike Chan <mike@android.com>
Subject: [PATCH] OMAP3: PM: Add voltage levels to prm_setup_vc (previously prm_setup_time)
Date: Thu, 21 May 2009 16:47:11 -0700
Message-ID: <1242949631-27191-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:34810 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZEUXrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 19:47:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: inux-omap@vger.kernel.org, Mike Chan <mike@android.com>

Expand configure_vc() to support configurable voltage levels.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/mach-omap2/pm.h     |   14 ++++++++-
 arch/arm/mach-omap2/pm34xx.c |   60 +++++++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 2547e1b..50a7a98 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -33,18 +33,28 @@ extern unsigned short wakeup_timer_seconds;
 extern struct omap_dm_timer *gptimer_wakeup;
 
 #ifdef CONFIG_ARCH_OMAP3
-struct prm_setup_times {
+struct prm_setup_vc {
 	u16 clksetup;
 	u16 voltsetup_time1;
 	u16 voltsetup_time2;
 	u16 voltoffset;
 	u16 voltsetup2;
+/* PRM_VC_CMD_VAL_0 specific bits */
+	u16 vdd0_on;
+	u16 vdd0_onlp;
+	u16 vdd0_ret;
+	u16 vdd0_off;
+/* PRM_VC_CMD_VAL_1 specific bits */
+	u16 vdd1_on;
+	u16 vdd1_onlp;
+	u16 vdd1_ret;
+	u16 vdd1_off;
 };
 
 extern void omap3_pm_off_mode_enable(int);
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
-extern void omap3_set_prm_setup_times(struct prm_setup_times *setup_times);
+extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
 #else
 #define omap3_pm_off_mode_enable(int) do {} while (0);
 #define omap3_pm_get_suspend_state(pwrdm) do {} while (0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 80992c5..b925501 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -87,12 +87,20 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static struct prm_setup_times prm_setup = {
+static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
 	.voltsetup_time1 = 0xfff,
 	.voltsetup_time2 = 0xfff,
 	.voltoffset = 0xff,
 	.voltsetup2 = 0xff,
+	.vdd0_on = 0x30,
+	.vdd0_onlp = 0x1e,
+	.vdd0_ret = 0x1e,
+	.vdd0_off = 0x30,
+	.vdd1_on = 0x2c,
+	.vdd1_onlp = 0x1e,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x2c,
 };
 
 static inline void omap3_per_save_context(void)
@@ -951,13 +959,21 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
-void omap3_set_prm_setup_times(struct prm_setup_times *setup_times)
+void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
 {
-	prm_setup.clksetup = setup_times->clksetup;
-	prm_setup.voltsetup_time1 = setup_times->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_times->voltsetup_time2;
-	prm_setup.voltoffset = setup_times->voltoffset;
-	prm_setup.voltsetup2 = setup_times->voltsetup2;
+	prm_setup.clksetup = setup_vc->clksetup;
+	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
+	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
+	prm_setup.voltoffset = setup_vc->voltoffset;
+	prm_setup.voltsetup2 = setup_vc->voltsetup2;
+	prm_setup.vdd0_on = setup_vc->vdd0_on;
+	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
+	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
+	prm_setup.vdd0_off = setup_vc->vdd0_off;
+	prm_setup.vdd1_on = setup_vc->vdd1_on;
+	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
+	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
+	prm_setup.vdd1_off = setup_vc->vdd1_off;
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
@@ -1092,18 +1108,6 @@ err2:
 	return ret;
 }
 
-/* PRM_VC_CMD_VAL_0 specific bits */
-#define OMAP3430_VC_CMD_VAL0_ON		0x30
-#define OMAP3430_VC_CMD_VAL0_ONLP	0x1E
-#define OMAP3430_VC_CMD_VAL0_RET	0x1E
-#define OMAP3430_VC_CMD_VAL0_OFF	0x30
-
-/* PRM_VC_CMD_VAL_1 specific bits */
-#define OMAP3430_VC_CMD_VAL1_ON		0x2C
-#define OMAP3430_VC_CMD_VAL1_ONLP	0x1E
-#define OMAP3430_VC_CMD_VAL1_RET	0x1E
-#define OMAP3430_VC_CMD_VAL1_OFF	0x2C
-
 static void __init configure_vc(void)
 {
 
@@ -1114,18 +1118,16 @@ static void __init configure_vc(void)
 			(R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
 
-	prm_write_mod_reg((OMAP3430_VC_CMD_VAL0_ON <<
-		OMAP3430_VC_CMD_ON_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
+		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
+		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
 		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
 
-	prm_write_mod_reg((OMAP3430_VC_CMD_VAL1_ON <<
-		OMAP3430_VC_CMD_ON_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
+		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
+		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
 		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
 
 	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1,
-- 
1.5.4.5

