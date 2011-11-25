From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Fri, 25 Nov 2011 17:49:35 +0200
Message-ID: <1322236188-19456-3-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51378 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1KYPuB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:01 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFo1oh005671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:01 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFo0sB005492
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:01 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo0pM017522
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:00 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Introduced two new voltage domain specific parameter structures,
omap_vp_param and omap_vc_param. These are used to describe the minimum
and maximum voltages for the voltagedomains, and also the sleep voltage
levels. Existing voltage levels are also moved into these new structures,
and the voltage domain code is changed to use these.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |   15 ++
 arch/arm/mach-omap2/omap_twl.c                |   25 ----
 arch/arm/mach-omap2/opp3xxx_data.c            |   52 +++++++
 arch/arm/mach-omap2/opp4xxx_data.c            |   40 ++++++
 arch/arm/mach-omap2/vc.c                      |  178 +++++++++++++++++++++----
 arch/arm/mach-omap2/vc.h                      |    1 -
 arch/arm/mach-omap2/voltage.h                 |   18 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    8 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    8 +
 9 files changed, 289 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..b5fe711 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -86,11 +86,26 @@ extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 
 extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap34xx_vddcore_volt_data[];
+extern struct omap_vp_param omap34xx_mpu_vp_data;
+extern struct omap_vp_param omap34xx_core_vp_data;
+extern struct omap_vc_param omap34xx_mpu_vc_data;
+extern struct omap_vc_param omap34xx_core_vc_data;
+
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap36xx_vddcore_volt_data[];
+extern struct omap_vp_param omap36xx_mpu_vp_data;
+extern struct omap_vp_param omap36xx_core_vp_data;
+extern struct omap_vc_param omap36xx_mpu_vc_data;
+extern struct omap_vc_param omap36xx_core_vc_data;
 
 extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
+extern struct omap_vp_param omap44xx_mpu_vp_data;
+extern struct omap_vp_param omap44xx_iva_vp_data;
+extern struct omap_vp_param omap44xx_core_vp_data;
+extern struct omap_vc_param omap44xx_mpu_vc_data;
+extern struct omap_vc_param omap44xx_iva_vc_data;
+extern struct omap_vc_param omap44xx_core_vc_data;
 
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index df4e7c3..62ed050 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -141,11 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -162,11 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -183,11 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1375000,
-	.onlp_volt		= 1375000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -205,11 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1188000,
-	.onlp_volt		= 1188000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1200000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..1d44df5 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -26,6 +26,10 @@
 #include "pm.h"
 
 /* 34xx */
+#define OMAP3_ON_VOLTAGE_UV		1200000
+#define OMAP3_ONLP_VOLTAGE_UV		1000000
+#define OMAP3_RET_VOLTAGE_UV		975000
+#define OMAP3_OFF_VOLTAGE_UV		600000
 
 /* VDD1 */
 
@@ -44,6 +48,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_mpu_vp_data = {
+	.vddmin			= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP1_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap34xx_mpu_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* VDD2 */
 
 #define OMAP3430_VDD_CORE_OPP1_UV		975000
@@ -57,6 +73,18 @@ struct omap_volt_data omap34xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_core_vp_data = {
+	.vddmin			= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP2_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap34xx_core_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* 36xx */
 
 /* VDD1 */
@@ -74,6 +102,18 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_mpu_vp_data = {
+	.vddmin			= OMAP3630_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3630_VP1_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap36xx_mpu_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* VDD2 */
 
 #define OMAP3630_VDD_CORE_OPP50_UV		1000000
@@ -85,6 +125,18 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_core_vp_data = {
+	.vddmin			= OMAP3630_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3630_VP2_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap36xx_core_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* OPP data */
 
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..dc405b6 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -31,6 +31,11 @@
  * voltage dependent data for each VDD.
  */
 
+#define OMAP4_ON_VOLTAGE_UV			1375000
+#define OMAP4_ONLP_VOLTAGE_UV			1375000
+#define OMAP4_RET_VOLTAGE_UV			837500
+#define OMAP4_OFF_VOLTAGE_UV			600000
+
 #define OMAP4430_VDD_MPU_OPP50_UV		1025000
 #define OMAP4430_VDD_MPU_OPP100_UV		1200000
 #define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
@@ -44,6 +49,18 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_mpu_vp_data = {
+	.vddmin			= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_mpu_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
 #define OMAP4430_VDD_IVA_OPP50_UV		1013000
 #define OMAP4430_VDD_IVA_OPP100_UV		1188000
 #define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
@@ -55,6 +72,18 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_iva_vp_data = {
+	.vddmin			= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_iva_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
 #define OMAP4430_VDD_CORE_OPP50_UV		1025000
 #define OMAP4430_VDD_CORE_OPP100_UV		1200000
 
@@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_core_vp_data = {
+	.vddmin			= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_core_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
 
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 031d116..8384b70 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,14 +10,18 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
 #include <plat/cpu.h>
+#include <plat/prcm.h>
 
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "scrm44xx.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -136,6 +140,8 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	vc_cmdval |= (*target_vsel << vc->common->cmd_on_shift);
 	voltdm->write(vc_cmdval, vc->cmdval_reg);
 
+	voltdm->vc_param->on = target_volt;
+
 	omap_vp_update_errorgain(voltdm, target_volt);
 
 	return 0;
@@ -203,44 +209,170 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
-static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
+static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int off_mode)
 {
+	unsigned long voltsetup1;
+	u32 tgt_volt;
+
+	if (off_mode)
+		tgt_volt = voltdm->vc_param->off;
+	else
+		tgt_volt = voltdm->vc_param->ret;
+
+	voltsetup1 = (voltdm->vc_param->on - tgt_volt) /
+			voltdm->pmic->slew_rate;
+
+	voltsetup1 = voltsetup1 * voltdm->sys_clk.rate / 8 / 1000000 + 1;
+
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
+		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
+		voltdm->vfsm->voltsetup_reg);
+
 	/*
-	 * Voltage Manager FSM parameters init
-	 * XXX This data should be passed in from the board file
+	 * pmic is not controlling the voltage scaling during retention,
+	 * thus set voltsetup2 to 0
 	 */
-	voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET);
-	voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
-static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
+	unsigned long clksetup;
+	unsigned long voltsetup2;
+	unsigned long voltsetup2_old;
+	u32 val;
 
-	if (is_initialized)
+	/* check if pmic is controlling off-mode voltages */
+	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
+	if (!(val & OMAP3430_SEL_OFF_MASK)) {
+		/* No, omap is controlling them over I2C */
+		omap3_set_i2c_timings(voltdm, 1);
 		return;
+	}
+
+	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
+
+	/* voltsetup 2 in us */
+	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
+
+	/* convert to 32k clk cycles */
+	voltsetup2 = DIV_ROUND_UP(voltsetup2 * 32768, 1000000);
+
+	voltsetup2_old = voltdm->read(OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	/*
+	 * Update voltsetup2 if higher than current value (needed because
+	 * we have multiple channels with different ramp times), also
+	 * update voltoffset always to value recommended by TRM
+	 */
+	if (voltsetup2 > voltsetup2_old) {
+		voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+		voltdm->write(clksetup - voltsetup2,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+	} else
+		voltdm->write(clksetup - voltsetup2_old,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+
+	/*
+	 * omap is not controlling voltage scaling during off-mode,
+	 * thus set voltsetup1 to 0
+	 */
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
+		voltdm->vfsm->voltsetup_reg);
+
+	/* voltoffset must be clksetup minus voltsetup2 according to TRM */
+	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
+}
+
+static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+{
+	omap3_set_off_timings(voltdm);
+}
+
+static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
+		u32 clk_rate)
+{
+	u32 prescaler;
+	u32 cycles;
+	u32 time;
+
+	time = voltage_diff / voltdm->pmic->slew_rate;
+
+	cycles = clk_rate / 1000 * time / 1000;
+
+	cycles /= 64;
+	prescaler = 0;
+
+	/* shift to next prescaler until no overflow */
+
+	/* scale for div 256 = 64 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
 
-	omap3_vfsm_init(voltdm);
+	/* scale for div 512 = 256 * 2 */
+	if (cycles > 63) {
+		cycles /= 2;
+		prescaler++;
+	}
+
+	/* scale for div 2048 = 512 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
 
-	is_initialized = true;
+	/* check for overflow => invalid ramp time */
+	if (cycles > 63) {
+		pr_warning("%s: invalid setuptime for vdd_%s\n", __func__,
+			voltdm->name);
+		return 0;
+	}
+
+	cycles++;
+
+	return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
+		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
 }
 
+static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
+{
+	u32 val;
+	u32 ramp;
+
+	/* configure the setup times */
+	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
+
+	if (off_mode)
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->off,
+			voltdm->sys_clk.rate);
+	else
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->ret,
+			voltdm->sys_clk.rate);
+
+	if (!ramp)
+		return;
+
+	val |= ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+
+	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
+
+	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+}
 
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
 	u32 vc_val;
 
-	if (is_initialized)
-		return;
+	omap4_set_timings(voltdm, true);
 
 	/* XXX These are magic numbers and do not belong! */
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
-
-	is_initialized = true;
 }
 
 /**
@@ -314,7 +446,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
 	vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
 	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
-	vc->setup_time = voltdm->pmic->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -338,10 +469,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
-	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
-	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
-	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
+	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->on);
+	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->onlp);
+	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->ret);
+	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->off);
 	val = ((on_vsel << vc->common->cmd_on_shift) |
 	       (onlp_vsel << vc->common->cmd_onlp_shift) |
 	       (ret_vsel << vc->common->cmd_ret_shift) |
@@ -352,11 +483,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
 
-	/* Configure the setup times */
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
-		    voltdm->vfsm->voltsetup_reg);
-
 	omap_vc_i2c_init(voltdm);
 
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 478bf6b..916c8fc 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -86,7 +86,6 @@ struct omap_vc_channel {
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
 	u16 cmd_reg_addr;
-	u16 setup_time;
 	u8 cfg_channel;
 	bool i2c_high_speed;
 
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 5204936..3afd1fc 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -72,6 +72,8 @@ struct voltagedomain {
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
 	struct omap_voltdm_pmic *pmic;
+	struct omap_vp_param *vp_param;
+	struct omap_vc_param *vc_param;
 
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
@@ -142,10 +144,6 @@ struct omap_volt_data {
 struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
 	u16 volt_setup_time;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
@@ -162,6 +160,18 @@ struct omap_voltdm_pmic {
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
 
+struct omap_vp_param {
+	u32 vddmax;
+	u32 vddmin;
+};
+
+struct omap_vc_param {
+	u32 on;
+	u32 onlp;
+	u32 ret;
+	u32 off;
+};
+
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 071101d..35b3bed 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -88,9 +88,17 @@ void __init omap3xxx_voltagedomains_init(void)
 	if (cpu_is_omap3630()) {
 		omap3_voltdm_mpu.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap36xx_vddcore_volt_data;
+		omap3_voltdm_mpu.vp_param = &omap36xx_mpu_vp_data;
+		omap3_voltdm_core.vp_param = &omap36xx_core_vp_data;
+		omap3_voltdm_mpu.vc_param = &omap36xx_mpu_vc_data;
+		omap3_voltdm_core.vc_param = &omap36xx_core_vc_data;
 	} else {
 		omap3_voltdm_mpu.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
+		omap3_voltdm_mpu.vp_param = &omap34xx_mpu_vp_data;
+		omap3_voltdm_core.vp_param = &omap34xx_core_vp_data;
+		omap3_voltdm_mpu.vc_param = &omap34xx_mpu_vc_data;
+		omap3_voltdm_core.vc_param = &omap34xx_core_vc_data;
 	}
 
 	for (i = 0; voltdm = voltagedomains_omap3[i], voltdm; i++)
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c4584e9..0a22960 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
 	omap4_voltdm_iva.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_voltdm_core.volt_data = omap44xx_vdd_core_volt_data;
 
+	omap4_voltdm_mpu.vp_param = &omap44xx_mpu_vp_data;
+	omap4_voltdm_iva.vp_param = &omap44xx_iva_vp_data;
+	omap4_voltdm_core.vp_param = &omap44xx_core_vp_data;
+
+	omap4_voltdm_mpu.vc_param = &omap44xx_mpu_vc_data;
+	omap4_voltdm_iva.vc_param = &omap44xx_iva_vc_data;
+	omap4_voltdm_core.vc_param = &omap44xx_core_vc_data;
+
 	for (i = 0; voltdm = voltagedomains_omap4[i], voltdm; i++)
 		voltdm->sys_clk.name = sys_clk_name;
 
-- 
1.7.4.1

