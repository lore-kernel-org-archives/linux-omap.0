From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 05/12] omap3630: pm: Adding voltage controller data
Date: Fri, 18 Feb 2011 22:38:51 +0530
Message-ID: <1298048938-1480-6-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab1BRRJT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 12:09:19 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Since voltage controller command values(ON/RET) for OMAP3630 Si is different.
Using the new voltage values specified in the Operating Condition Addendum
for OMAP3630.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/omap_twl.c |   98 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 4b5a8e9..f0feab9 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -67,6 +67,16 @@
 #define OMAP3430_VDD2_RET	975000
 #define OMAP3430_VDD2_OFF	600000
 
+#define OMAP3630_VDD1_ON	1100000
+#define OMAP3630_VDD1_ONLP	1000000
+#define OMAP3630_VDD1_RET	830000
+#define OMAP3630_VDD1_OFF	600000
+
+#define OMAP3630_VDD2_ON	1137500
+#define OMAP3630_VDD2_ONLP	1000000
+#define OMAP3630_VDD2_RET	830000
+#define OMAP3630_VDD2_OFF	600000
+
 #define OMAP4430_VDD1_ON	1350000
 #define OMAP4430_VDD1_ONLP	1350000
 #define OMAP4430_VDD1_RET	837500
@@ -245,7 +255,7 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 		return DIV_ROUND_UP(uv - 600000, 12500) + 1;
 }
 
-static struct omap_volt_pmic_info omap3_mpu_volt_info = {
+static struct omap_volt_pmic_info omap3430_mpu_volt_info = {
 	.on_volt		= OMAP3430_VDD1_ON,
 	.onlp_volt		= OMAP3430_VDD1_ONLP,
 	.ret_volt		= OMAP3430_VDD1_RET,
@@ -280,7 +290,7 @@ static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	},
 };
 
-static struct omap_volt_pmic_info omap3_core_volt_info = {
+static struct omap_volt_pmic_info omap3430_core_volt_info = {
 	.on_volt		= OMAP3430_VDD2_ON,
 	.onlp_volt		= OMAP3430_VDD2_ONLP,
 	.ret_volt		= OMAP3430_VDD2_RET,
@@ -315,6 +325,76 @@ static struct omap_volt_pmic_info omap3_core_volt_info = {
 	},
 };
 
+static struct omap_volt_pmic_info omap3630_mpu_volt_info = {
+	.on_volt		= OMAP3630_VDD1_ON,
+	.onlp_volt		= OMAP3630_VDD1_ONLP,
+	.ret_volt		= OMAP3630_VDD1_RET,
+	.off_volt		= OMAP3630_VDD1_OFF,
+	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_vddmin		= OMAP3630_VP1_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3630_VP1_VLIMITTO_VDDMAX,
+	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.voltsetup_ret		= {
+		.voltsetup	= OMAP3_VOLTSETUP_VDD1_RET,
+		.voltsetup2	= OMAP3_VOLTSETUP2_RET,
+		.voltoffset	= OMAP3_VOLTOFFSET_RET,
+	},
+	.voltsetup_off		= {
+		.voltsetup	= OMAP3_VOLTSETUP_VDD1_OFF,
+		.voltsetup2	= OMAP3_VOLTSETUP2_OFF,
+		.voltoffset	= OMAP3_VOLTOFFSET_OFF,
+	},
+	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
+	.vsel_to_uv		= twl4030_vsel_to_uv,
+	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.clksetup_ret		= {
+		.clksetup	= OMAP3_CLKSETUP_RET,
+	},
+	.clksetup_off		= {
+		.clksetup	= OMAP3_CLKSETUP_OFF,
+	},
+};
+
+static struct omap_volt_pmic_info omap3630_core_volt_info = {
+	.on_volt		= OMAP3630_VDD2_ON,
+	.onlp_volt		= OMAP3630_VDD2_ONLP,
+	.ret_volt		= OMAP3630_VDD2_RET,
+	.off_volt		= OMAP3630_VDD2_OFF,
+	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_vddmin		= OMAP3630_VP2_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3630_VP2_VLIMITTO_VDDMAX,
+	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.voltsetup_ret		= {
+		.voltsetup	= OMAP3_VOLTSETUP_VDD2_RET,
+		.voltsetup2	= OMAP3_VOLTSETUP2_RET,
+		.voltoffset	= OMAP3_VOLTOFFSET_RET,
+	},
+	.voltsetup_off		= {
+		.voltsetup	= OMAP3_VOLTSETUP_VDD2_OFF,
+		.voltsetup2	= OMAP3_VOLTSETUP2_OFF,
+		.voltoffset	= OMAP3_VOLTOFFSET_OFF,
+	},
+	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
+	.vsel_to_uv		= twl4030_vsel_to_uv,
+	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.clksetup_ret		= {
+		.clksetup	= OMAP3_CLKSETUP_RET,
+	},
+	.clksetup_off		= {
+		.clksetup	= OMAP3_CLKSETUP_OFF,
+	},
+};
+
 /*
  * FIXME: voltsetup time values should be updated
  * after profiling on OMAP4 board.
@@ -424,22 +504,24 @@ int __init omap4_twl_init(void)
 int __init omap3_twl_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct omap_volt_pmic_info *mpu_volt_info, *core_volt_info;
 
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
 	if (cpu_is_omap3630()) {
-		omap3_mpu_volt_info.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
-		omap3_mpu_volt_info.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
-		omap3_core_volt_info.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
-		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+		mpu_volt_info = &omap3630_mpu_volt_info;
+		core_volt_info = &omap3630_core_volt_info;
+	} else {
+		mpu_volt_info = &omap3430_mpu_volt_info;
+		core_volt_info = &omap3430_core_volt_info;
 	}
 
 	voltdm = omap_voltage_domain_lookup("mpu");
-	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
+	omap_voltage_register_pmic(voltdm, mpu_volt_info);
 
 	voltdm = omap_voltage_domain_lookup("core");
-	omap_voltage_register_pmic(voltdm, &omap3_core_volt_info);
+	omap_voltage_register_pmic(voltdm, core_volt_info);
 
 	return 0;
 }
-- 
1.7.1

