From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v7 3/8] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Thu,  1 Jul 2010 15:41:44 +0530
Message-ID: <1277979104-2045-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43494 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960Ab0GAKPM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:15:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch has the changes to use separate clk/volt setup_time
for RET and OFF state. Because the clocksetup voltsetup time1
used for RET & OFF is different.

Create separate copies of VC parameters for each Si in voltage.c.
Since the voltage vales for each state is different in different OMAP Si.

Updates the VC setuptime struct during init based on the OMAP Si.
Removes the VC setuptime struct from board files.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   19 -------
 arch/arm/mach-omap2/pm.h            |   18 -------
 arch/arm/mach-omap2/voltage.c       |   93 +++++++++++++++++++++++++---------
 arch/arm/mach-omap2/voltage.h       |   25 +++++++++
 4 files changed, 93 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 75c66dd..c7f0fa8 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,7 +47,6 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
-#include "voltage.h"
 #include "omap3-opp.h"
 #include "smartreflex-class3.h"
 
@@ -77,23 +76,6 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{1, 10000, 30000, 300000},
 };
 
-/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
-static struct prm_setup_vc omap3_setuptime_table = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,
-	.vdd0_onlp = 0x20,
-	.vdd0_ret = 0x1e,
-	.vdd0_off = 0x00,
-	.vdd1_on = 0x2c,
-	.vdd1_onlp = 0x20,
-	.vdd1_ret = 0x1e,
-	.vdd1_off = 0x00,
-};
-
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -347,7 +329,6 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap_voltage_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b608490..bad9058 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -40,24 +40,6 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
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
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c5e9c42..efa16d4 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -127,14 +127,26 @@ struct vc_reg_info {
 } vc_reg;
 
 /*
- * Default voltage controller settings for OMAP3
+ * Default voltage controller settings for OMAP3430
  */
-static struct prm_setup_vc vc_config = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
+struct __initdata prm_setup_vc omap3430_vc_config = {
+	/* CLK & VOLT SETUPTIME for RET */
+	.ret = {
+		.clksetup = 0x1,
+		.voltsetup1_vdd1 = 0x005B,
+		.voltsetup1_vdd2 = 0x0055,
+		.voltsetup2 = 0x0,
+		.voltoffset = 0x0,
+	},
+	/* CLK & VOLT SETUPTIME for OFF */
+	.off = {
+		.clksetup = 0x14A,
+		.voltsetup1_vdd1 = 0x00B3,
+		.voltsetup1_vdd2 = 0x00A0,
+		.voltsetup2 = 0x118,
+		.voltoffset = 0x32,
+	},
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	.vdd0_on = 0x30,        /* 1.2v */
 	.vdd0_onlp = 0x20,      /* 1.0v */
 	.vdd0_ret = 0x1e,       /* 0.975v */
@@ -146,6 +158,39 @@ static struct prm_setup_vc vc_config = {
 };
 
 /*
+ * Default voltage controller settings for OMAP3630
+ */
+struct __initdata prm_setup_vc omap3630_vc_config = {
+	/* CLK & VOLT SETUPTIME for RET */
+	.ret = {
+		.clksetup = 0x1,
+		.voltsetup1_vdd1 = 0x005B,
+		.voltsetup1_vdd2 = 0x0055,
+		.voltsetup2 = 0x0,
+		.voltoffset = 0x0,
+	},
+	/* CLK & VOLT SETUPTIME for OFF */
+	.off = {
+		.clksetup = 0x14A,
+		.voltsetup1_vdd1 = 0x00B3,
+		.voltsetup1_vdd2 = 0x00A0,
+		.voltsetup2 = 0x118,
+		.voltoffset = 0x32,
+	},
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd0_on = 0x28,	/* 1.1v */
+	.vdd0_onlp = 0x20,	/* 1.0v */
+	.vdd0_ret = 0x13,	/* 0.83v */
+	.vdd0_off = 0x00,	/* 0.6v */
+	.vdd1_on = 0x2B,	/* 1.1375v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x13,	/* 0.83v */
+	.vdd1_off = 0x00,	/* 0.6v */
+};
+
+static struct prm_setup_vc vc_config;
+
+/*
  * Structures containing OMAP3430 voltage supported and various data
  * associated with it per voltage domain basis. Smartreflex Ntarget
  * vales are left as 0 as they have to be populated by smartreflex
@@ -250,12 +295,12 @@ static void __init init_voltagecontroller(void)
 	voltage_write_reg(vc_i2c_cfg_reg, VC_MCODE_SHIFT | VC_HSEN);
 
 	/* Write setup times */
-	voltage_write_reg(prm_clksetup_reg, vc_config.clksetup);
+	voltage_write_reg(prm_clksetup_reg, vc_config.ret.clksetup);
 	voltage_write_reg(prm_voltsetup1_reg,
-			(vc_config.voltsetup_time2 << VC_SETUP_TIME2_SHIFT) |
-			(vc_config.voltsetup_time1 << VC_SETUP_TIME1_SHIFT));
-	voltage_write_reg(prm_voltoffset_reg, vc_config.voltoffset);
-	voltage_write_reg(prm_voltsetup2_reg, vc_config.voltsetup2);
+		(vc_config.ret.voltsetup1_vdd2 << VC_SETUP_TIME2_SHIFT) |
+		(vc_config.ret.voltsetup1_vdd1 << VC_SETUP_TIME1_SHIFT));
+	voltage_write_reg(prm_voltoffset_reg, vc_config.ret.voltoffset);
+	voltage_write_reg(prm_voltsetup2_reg, vc_config.ret.voltsetup2);
 }
 
 static void vp_latch_vsel(int vp_id)
@@ -893,19 +938,9 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	if (!setup_vc)
 		return;
 
-	vc_config.clksetup = setup_vc->clksetup;
-	vc_config.voltsetup_time1 = setup_vc->voltsetup_time1;
-	vc_config.voltsetup_time2 = setup_vc->voltsetup_time2;
-	vc_config.voltoffset = setup_vc->voltoffset;
-	vc_config.voltsetup2 = setup_vc->voltsetup2;
-	vc_config.vdd0_on = setup_vc->vdd0_on;
-	vc_config.vdd0_onlp = setup_vc->vdd0_onlp;
-	vc_config.vdd0_ret = setup_vc->vdd0_ret;
-	vc_config.vdd0_off = setup_vc->vdd0_off;
-	vc_config.vdd1_on = setup_vc->vdd1_on;
-	vc_config.vdd1_onlp = setup_vc->vdd1_onlp;
-	vc_config.vdd1_ret = setup_vc->vdd1_ret;
-	vc_config.vdd1_off = setup_vc->vdd1_off;
+	/* CLK SETUPTIME for RET & OFF */
+	vc_config.ret.clksetup = setup_vc->ret.clksetup;
+	vc_config.off.clksetup = setup_vc->off.clksetup;
 }
 
 /**
@@ -972,6 +1007,14 @@ void __init omap_voltage_init(void)
 		volt_mod = OMAP3430_GR_MOD;
 	else
 		return;
+
+	if (cpu_is_omap3430())
+		memcpy(&vc_config, &omap3430_vc_config,
+				sizeof(struct prm_setup_vc));
+	else if (cpu_is_omap3630())
+		memcpy(&vc_config, &omap3630_vc_config,
+				sizeof(struct prm_setup_vc));
+
 	init_voltagecontroller();
 	init_voltageprocessors();
 }
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index c6445c5..526c02d 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -14,6 +14,31 @@
 #define VDD1	0
 #define VDD2	1
 
+struct setuptime_vc{
+	u16 clksetup;
+	u16 voltsetup1_vdd1;
+	u16 voltsetup1_vdd2;
+	u16 voltsetup2;
+	u16 voltoffset;
+};
+
+struct prm_setup_vc {
+	/* CLK & VOLT SETUPTIME for RET */
+	struct setuptime_vc ret;
+	/* CLK & VOLT SETUPTIME for OFF */
+	struct setuptime_vc off;
+	/* PRM_VC_CMD_VAL_0 specific bits */
+	u16 vdd0_on;
+	u16 vdd0_onlp;
+	u16 vdd0_ret;
+	u16 vdd0_off;
+	/* PRM_VC_CMD_VAL_1 specific bits */
+	u16 vdd1_on;
+	u16 vdd1_onlp;
+	u16 vdd1_ret;
+	u16 vdd1_off;
+};
+
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
-- 
1.7.0.4

