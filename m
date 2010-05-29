From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 3/4] OMAP3: PM: Removing voltage related code from the generic pm code.
Date: Sat, 29 May 2010 22:16:53 +0530
Message-ID: <1275151614-16634-4-git-send-email-thara@ti.com>
References: <1275151614-16634-1-git-send-email-thara@ti.com>
 <1275151614-16634-2-git-send-email-thara@ti.com>
 <1275151614-16634-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41729 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab0E2QrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 12:47:03 -0400
In-Reply-To: <1275151614-16634-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

Now there is a voltage driver to handle all voltage
specific code. This patch removes all voltage specific code
from generic pm code so that the new voltage driver can
function properly. Also this patch renames the smartreflex
API's used in the generic pm code as per the new
smartreflex driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    5 +-
 arch/arm/mach-omap2/pm.h            |   25 ---------
 arch/arm/mach-omap2/pm34xx.c        |   94 ++--------------------------------
 3 files changed, 9 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a00dd9d..3142ef3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,6 +47,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
+#include "voltage.h"
 #include "omap3-opp.h"
 
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
@@ -76,7 +77,7 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 };
 
 /* FIXME: These are not the optimal setup values to be used on 3430sdp*/
-static struct prm_setup_vc omap3_setuptime_table = {
+static struct omap_volt_vc_data omap3_setuptime_table = {
 	.clksetup = 0xff,
 	.voltsetup_time1 = 0xfff,
 	.voltsetup_time2 = 0xfff,
@@ -345,7 +346,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap3_pm_init_vc(&omap3_setuptime_table);
+	omap_voltage_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b3594a9..bad9058 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -40,31 +40,6 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 }
 #endif
 
-struct prm_setup_vc {
-	u16 clksetup;
-	u16 voltsetup_time1;
-	u16 voltsetup_time2;
-	u16 voltoffset;
-	u16 voltsetup2;
-/* PRM_VC_CMD_VAL_0 specific bits */
-	u16 vdd0_on;
-	u16 vdd0_onlp;
-	u16 vdd0_ret;
-	u16 vdd0_off;
-/* PRM_VC_CMD_VAL_1 specific bits */
-	u16 vdd1_on;
-	u16 vdd1_onlp;
-	u16 vdd1_ret;
-	u16 vdd1_off;
-};
-#ifdef CONFIG_PM
-extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
-#else
-static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
-{
-}
-#endif
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 48857a4..1a5025c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -40,6 +40,7 @@
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/usb.h>
+#include <plat/smartreflex.h>
 
 #include <plat/resource.h>
 
@@ -49,11 +50,11 @@
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 
-#include "smartreflex.h"
 #include "prm.h"
 #include "pm.h"
 #include "sdrc.h"
 #include "omap3-opp.h"
+#include "voltage.h"
 
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
@@ -98,22 +99,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static struct prm_setup_vc prm_setup = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,	/* 1.2v */
-	.vdd0_onlp = 0x20,	/* 1.0v */
-	.vdd0_ret = 0x1e,	/* 0.975v */
-	.vdd0_off = 0x00,	/* 0.6v */
-	.vdd1_on = 0x2c,	/* 1.15v */
-	.vdd1_onlp = 0x20,	/* 1.0v */
-	.vdd1_ret = 0x1e,	/* .975v */
-	.vdd1_off = 0x00,	/* 0.6v */
-};
-
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -446,9 +431,9 @@ void omap_sram_idle(void)
 	 * Only needed if we are going to enter retention or off.
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR1);
+		omap_smartreflex_disable(VDD1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR2);
+		omap_smartreflex_disable(VDD2);
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -545,9 +530,9 @@ void omap_sram_idle(void)
 	 * retention or off
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR1);
+		omap_smartreflex_enable(VDD1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR2);
+		omap_smartreflex_enable(VDD2);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -1096,26 +1081,6 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
-void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
-{
-	if (!setup_vc)
-		return;
-
-	prm_setup.clksetup = setup_vc->clksetup;
-	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
-	prm_setup.voltoffset = setup_vc->voltoffset;
-	prm_setup.voltsetup2 = setup_vc->voltsetup2;
-	prm_setup.vdd0_on = setup_vc->vdd0_on;
-	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
-	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
-	prm_setup.vdd0_off = setup_vc->vdd0_off;
-	prm_setup.vdd1_on = setup_vc->vdd1_on;
-	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
-	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
-	prm_setup.vdd1_off = setup_vc->vdd1_off;
-}
-
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -1253,57 +1218,10 @@ err2:
 	return ret;
 }
 
-static void __init configure_vc(void)
-{
-
-	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
-			  (R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
-			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
-	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
-			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
-			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
-
-	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
-		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
-		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
-
-	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
-		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
-		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
-			  OMAP3_PRM_VC_CH_CONF_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
-			  OMAP3430_GR_MOD,
-			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
-
-	/* Write setup times */
-	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
-			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
-			OMAP3430_SETUP_TIME2_SHIFT) |
-			(prm_setup.voltsetup_time1 <<
-			OMAP3430_SETUP_TIME1_SHIFT),
-			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
-
-	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTOFFSET_OFFSET);
-	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTSETUP2_OFFSET);
-}
-
 static int __init omap3_pm_early_init(void)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
 				OMAP3_PRM_POLCTRL_OFFSET);
-
-	configure_vc();
-
 	return 0;
 }
 
-- 
1.7.0.rc1.33.g07cf0f

