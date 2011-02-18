From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 03/12] omap3: pm: cleanup pmic_info structure
Date: Fri, 18 Feb 2011 22:38:49 +0530
Message-ID: <1298048938-1480-4-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab1BRRJR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 12:09:17 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Removing the hard coded values, rearranging the elements based on
OMAP, PMIC & board specific.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/omap_twl.c            |   99 +++++++++++++++++++----------
 arch/arm/plat-omap/include/plat/voltage.h |    8 ++-
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 00e1d2b..9510623 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -57,6 +57,35 @@
 #define OMAP4_VP_CORE_VLIMITTO_VDDMIN	0xA
 #define OMAP4_VP_CORE_VLIMITTO_VDDMAX	0x28
 
+#define OMAP3430_VDD1_ON	1200000
+#define OMAP3430_VDD1_ONLP	1000000
+#define OMAP3430_VDD1_RET	975000
+#define OMAP3430_VDD1_OFF	600000
+
+#define OMAP3430_VDD2_ON	1200000
+#define OMAP3430_VDD2_ONLP	1000000
+#define OMAP3430_VDD2_RET	975000
+#define OMAP3430_VDD2_OFF	600000
+
+#define OMAP4430_VDD1_ON	1350000
+#define OMAP4430_VDD1_ONLP	1350000
+#define OMAP4430_VDD1_RET	837500
+#define OMAP4430_VDD1_OFF	600000
+
+#define OMAP4430_VDD2_ON	1100000
+#define OMAP4430_VDD2_ONLP	1100000
+#define OMAP4430_VDD2_RET	837500
+#define OMAP4430_VDD2_OFF	600000
+
+#define OMAP4430_VDD3_ON	1100000
+#define OMAP4430_VDD3_ONLP	1100000
+#define OMAP4430_VDD3_RET	837500
+#define OMAP4430_VDD3_OFF	600000
+
+#define OMAP_VOLTSETUP_TIME	0xff
+#define TWL4030_SMPS_SLEW_RATE	4000
+#define TWL4030_SMPS_STEP_SIZE	12500
+
 static bool is_offset_valid;
 static u8 smps_offset;
 
@@ -137,101 +166,101 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 }
 
 static struct omap_volt_pmic_info omap3_mpu_volt_info = {
-	.slew_rate		= 4000,
-	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
+	.on_volt		= OMAP3430_VDD1_ON,
+	.onlp_volt		= OMAP3430_VDD1_ONLP,
+	.ret_volt		= OMAP3430_VDD1_RET,
+	.off_volt		= OMAP3430_VDD1_OFF,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap3_core_volt_info = {
-	.slew_rate		= 4000,
-	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
+	.on_volt		= OMAP3430_VDD2_ON,
+	.onlp_volt		= OMAP3430_VDD2_ONLP,
+	.ret_volt		= OMAP3430_VDD2_RET,
+	.off_volt		= OMAP3430_VDD2_OFF,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.volt_setup_time        = OMAP_VOLTSETUP_TIME,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_mpu_volt_info = {
-	.slew_rate		= 4000,
-	.step_size		= 12500,
-	.on_volt		= 1350000,
-	.onlp_volt		= 1350000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
+	.on_volt		= OMAP4430_VDD1_ON,
+	.onlp_volt		= OMAP4430_VDD1_ONLP,
+	.ret_volt		= OMAP4430_VDD1_RET,
+	.off_volt		= OMAP4430_VDD1_OFF,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_MPU_SR_VOLT_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_iva_volt_info = {
-	.slew_rate		= 4000,
-	.step_size		= 12500,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
+	.on_volt		= OMAP4430_VDD2_ON,
+	.onlp_volt		= OMAP4430_VDD2_ONLP,
+	.ret_volt		= OMAP4430_VDD2_RET,
+	.off_volt		= OMAP4430_VDD2_OFF,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_core_volt_info = {
-	.slew_rate		= 4000,
-	.step_size		= 12500,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
+	.on_volt		= OMAP4430_VDD3_ON,
+	.onlp_volt		= OMAP4430_VDD3_ONLP,
+	.ret_volt		= OMAP4430_VDD3_RET,
+	.off_volt		= OMAP4430_VDD3_OFF,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_CORE_SR_VOLT_REG,
+	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
+	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 5bd204e..7fcb788 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -94,21 +94,23 @@ struct omap_volt_data {
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
  */
 struct omap_volt_pmic_info {
-	int slew_rate;
-	int step_size;
+	/* OMAP specific params: vc_cmd_values, vp_params */
 	u32 on_volt;
 	u32 onlp_volt;
 	u32 ret_volt;
 	u32 off_volt;
-	u16 volt_setup_time;
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
 	u8 vp_vddmin;
 	u8 vp_vddmax;
 	u8 vp_timeout_us;
+	/* PM IC specific params: voltsetup, pmic_config values */
+	u16 volt_setup_time;
 	u8 i2c_slave_addr;
 	u8 pmic_reg;
+	int slew_rate;
+	int step_size;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
-- 
1.7.1

