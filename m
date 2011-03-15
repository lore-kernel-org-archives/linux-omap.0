From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [RFC][PATCH 1/3] OMAP PM: Seggregate Voltage layer parameters
Date: Tue, 15 Mar 2011 20:03:40 +0530
Message-ID: <1300199622-32500-2-git-send-email-vishwanath.bs@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44172 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757833Ab1COO37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 10:29:59 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2FETuY0023033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 09:29:58 -0500
In-Reply-To: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

Voltage layer takes various parameters which can be broadly classified as
1. OMAP/VP specific parameters
2. PMIC specific parameters
3. Board specific parameters

This patch attempts to categorize the parameters in current voltage layer into
above buckets. This will make voltage layer to work with different kinds of PMIC
and boards.

TODO: Provide infrastructure to use VC I2C (I2C4) for PMIC configuration (useful
for cases where PMIC is connected to OMAP only via I2C4.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |    8 ++
 arch/arm/mach-omap2/omap_twl.c                |  108 ++++++++---------
 arch/arm/mach-omap2/opp3xxx_data.c            |   50 ++++++++
 arch/arm/mach-omap2/opp4xxx_data.c            |   38 ++++++
 arch/arm/mach-omap2/voltage.c                 |  167 ++++++++++++++++++++-----
 arch/arm/mach-omap2/voltage.h                 |  115 +++++++++++++++--
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    4 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    4 +
 8 files changed, 393 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..70d61d2 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -86,11 +86,19 @@ extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 
 extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap34xx_vddcore_volt_data[];
+extern struct omap_vp_param omap34xx_mpu_vp_data;
+extern struct omap_vp_param omap34xx_core_vp_data;
+
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap36xx_vddcore_volt_data[];
+extern struct omap_vp_param omap36xx_mpu_vp_data;
+extern struct omap_vp_param omap36xx_core_vp_data;
 
 extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
+extern struct omap_vp_param omap44xx_mpu_vp_data;
+extern struct omap_vp_param omap44xx_iva_vp_data;
+extern struct omap_vp_param omap44xx_core_vp_data;
 
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 0a8e74e..f96d4b2 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -29,7 +29,6 @@
 #define OMAP3_VP_VSTEPMIN_VSTEPMIN	0x1
 #define OMAP3_VP_VSTEPMAX_VSTEPMAX	0x04
 #define OMAP3_VP_VLIMITTO_TIMEOUT_US	200
-
 #define OMAP3430_VP1_VLIMITTO_VDDMIN	0x14
 #define OMAP3430_VP1_VLIMITTO_VDDMAX	0x42
 #define OMAP3430_VP2_VLIMITTO_VDDMIN	0x18
@@ -44,12 +43,10 @@
 #define OMAP4_VDD_MPU_SR_VOLT_REG	0x55
 #define OMAP4_VDD_IVA_SR_VOLT_REG	0x5B
 #define OMAP4_VDD_CORE_SR_VOLT_REG	0x61
-
 #define OMAP4_VP_CONFIG_ERROROFFSET	0x00
 #define OMAP4_VP_VSTEPMIN_VSTEPMIN	0x01
 #define OMAP4_VP_VSTEPMAX_VSTEPMAX	0x04
 #define OMAP4_VP_VLIMITTO_TIMEOUT_US	200
-
 #define OMAP4_VP_MPU_VLIMITTO_VDDMIN	0xA
 #define OMAP4_VP_MPU_VLIMITTO_VDDMAX	0x39
 #define OMAP4_VP_IVA_VLIMITTO_VDDMIN	0xA
@@ -146,101 +143,96 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
-	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
-	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
-	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_timeout_us	= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr	= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.vp_erroroffset	= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin	= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax	= OMAP3_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
-	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
-	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.on_cmd			= twl4030_uv_to_vsel,
+	.onlp_cmd		= twl4030_uv_to_vsel,
+	.ret_cmd		= twl4030_uv_to_vsel,
+	.off_cmd		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap3_core_volt_info = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
-	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
-	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
-	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_timeout_us	= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr	= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.vp_erroroffset	= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin	= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax	= OMAP3_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
-	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
-	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.on_cmd			= twl4030_uv_to_vsel,
+	.onlp_cmd		= twl4030_uv_to_vsel,
+	.ret_cmd		= twl4030_uv_to_vsel,
+	.off_cmd		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1350000,
-	.onlp_volt		= 1350000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
-	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
-	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
-	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
+	.vp_timeout_us	= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr	= OMAP4_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP4_VDD_MPU_SR_VOLT_REG,
+	.vp_erroroffset	= OMAP4_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin	= OMAP4_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax	= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
-	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_MPU_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
+	.on_cmd			= twl4030_uv_to_vsel,
+	.onlp_cmd		= twl4030_uv_to_vsel,
+	.ret_cmd		= twl4030_uv_to_vsel,
+	.off_cmd		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
-	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
-	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
-	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
+	.vp_timeout_us	= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr	= OMAP4_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.vp_erroroffset	= OMAP4_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin	= OMAP4_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax	= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
-	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_IVA_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
+	.on_cmd			= twl4030_uv_to_vsel,
+	.onlp_cmd		= twl4030_uv_to_vsel,
+	.ret_cmd		= twl4030_uv_to_vsel,
+	.off_cmd		= twl4030_uv_to_vsel,
 };
 
 static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0,
-	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
-	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
-	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
+	.vp_timeout_us	= OMAP4_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr	= OMAP4_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP4_VDD_CORE_SR_VOLT_REG,
+	.vp_erroroffset	= OMAP4_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin	= OMAP4_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax	= OMAP4_VP_VSTEPMAX_VSTEPMAX,
 	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
-	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_CORE_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
+	.on_cmd			= twl4030_uv_to_vsel,
+	.onlp_cmd		= twl4030_uv_to_vsel,
+	.ret_cmd		= twl4030_uv_to_vsel,
+	.off_cmd		= twl4030_uv_to_vsel,
 };
 
 int __init omap4_twl_init(void)
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..a614baf 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -26,6 +26,16 @@
 #include "pm.h"
 
 /* 34xx */
+/* OMAP VP parameter values */
+#define OMAP3430_VP1_VLIMITTO_VDDMIN	0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX	0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3430_VP2_VLIMITTO_VDDMAX	0x2c
+
+#define OMAP3_ON_VOLTAGE_UV				1200000
+#define OMAP3_ONLP_VOLTAGE_UV			1000000
+#define OMAP3_RET_VOLTAGE_UV			975000
+#define OMAP3_OFF_VOLTAGE_UV			600000
 
 /* VDD1 */
 
@@ -44,6 +54,15 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_mpu_vp_data = {
+	.on_volt		= OMAP3_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP3_RET_VOLTAGE_UV,
+	.off_volt		= OMAP3_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
+};
+
 /* VDD2 */
 
 #define OMAP3430_VDD_CORE_OPP1_UV		975000
@@ -57,7 +76,20 @@ struct omap_volt_data omap34xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_core_vp_data = {
+	.on_volt		= OMAP3_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP3_RET_VOLTAGE_UV,
+	.off_volt		= OMAP3_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
+};
+
 /* 36xx */
+#define OMAP3630_VP1_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX	0x3c
+#define OMAP3630_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX	0x30
 
 /* VDD1 */
 
@@ -74,6 +106,14 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_mpu_vp_data = {
+	.on_volt		= OMAP3_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP3_RET_VOLTAGE_UV,
+	.off_volt		= OMAP3_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP3630_VP1_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3630_VP1_VLIMITTO_VDDMAX,
+};
 /* VDD2 */
 
 #define OMAP3630_VDD_CORE_OPP50_UV		1000000
@@ -85,6 +125,16 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_core_vp_data = {
+	.on_volt		= OMAP3_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP3_RET_VOLTAGE_UV,
+	.off_volt		= OMAP3_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP3630_VP2_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3630_VP2_VLIMITTO_VDDMAX,
+};
+
+
 /* OPP data */
 
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..d5a5d3f 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -30,6 +30,17 @@
  * Structures containing OMAP4430 voltage supported and various
  * voltage dependent data for each VDD.
  */
+#define OMAP4_VP_MPU_VLIMITTO_VDDMIN	0xA
+#define OMAP4_VP_MPU_VLIMITTO_VDDMAX	0x39
+#define OMAP4_VP_IVA_VLIMITTO_VDDMIN	0xA
+#define OMAP4_VP_IVA_VLIMITTO_VDDMAX	0x2D
+#define OMAP4_VP_CORE_VLIMITTO_VDDMIN	0xA
+#define OMAP4_VP_CORE_VLIMITTO_VDDMAX	0x28
+
+#define OMAP4_ON_VOLTAGE_UV				1350000
+#define OMAP4_ONLP_VOLTAGE_UV			1350000
+#define OMAP4_RET_VOLTAGE_UV			837500
+#define OMAP4_OFF_VOLTAGE_UV			600000
 
 #define OMAP4430_VDD_MPU_OPP50_UV		1025000
 #define OMAP4430_VDD_MPU_OPP100_UV		1200000
@@ -44,6 +55,15 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_mpu_vp_data = {
+	.on_volt		= OMAP4_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP4_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP4_RET_VOLTAGE_UV,
+	.off_volt		= OMAP4_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+};
+
 #define OMAP4430_VDD_IVA_OPP50_UV		1013000
 #define OMAP4430_VDD_IVA_OPP100_UV		1188000
 #define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
@@ -55,6 +75,15 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_iva_vp_data = {
+	.on_volt		= OMAP4_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP4_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP4_RET_VOLTAGE_UV,
+	.off_volt		= OMAP4_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+};
+
 #define OMAP4430_VDD_CORE_OPP50_UV		1025000
 #define OMAP4430_VDD_CORE_OPP100_UV		1200000
 
@@ -64,6 +93,15 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_core_vp_data = {
+	.on_volt		= OMAP4_ON_VOLTAGE_UV,
+	.onlp_volt		= OMAP4_ONLP_VOLTAGE_UV,
+	.ret_volt		= OMAP4_RET_VOLTAGE_UV,
+	.off_volt		= OMAP4_OFF_VOLTAGE_UV,
+	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+};
+
 
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c6facf7..2ac990f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -42,7 +42,6 @@
 
 #define VOLTAGE_DIR_SIZE	16
 
-
 static struct omap_vdd_info **vdd_info;
 
 /*
@@ -124,9 +123,10 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
 
 	timeout_val = (sys_clk_speed * vdd->pmic_info->vp_timeout_us) / 1000;
 	vdd->vp_rt_data.vlimitto_timeout = timeout_val;
-	vdd->vp_rt_data.vlimitto_vddmin = vdd->pmic_info->vp_vddmin;
-	vdd->vp_rt_data.vlimitto_vddmax = vdd->pmic_info->vp_vddmax;
-
+	vdd->vp_rt_data.vlimitto_vddmin = (vdd->vp_param->vp_vddmin > vdd->pmic_info->vp_vddmin) ?
+						vdd->vp_param->vp_vddmin : vdd->pmic_info->vp_vddmin;
+	vdd->vp_rt_data.vlimitto_vddmax = (vdd->vp_param->vp_vddmax > vdd->pmic_info->vp_vddmax) ?
+						vdd->pmic_info->vp_vddmax : vdd->vp_param->vp_vddmax;
 	waittime = ((vdd->pmic_info->step_size / vdd->pmic_info->slew_rate) *
 				sys_clk_speed) / 1000;
 	vdd->vp_rt_data.vstepmin_smpswaittimemin = waittime;
@@ -523,15 +523,35 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 
 static void __init omap3_vfsm_init(struct omap_vdd_info *vdd)
 {
+	struct clk *omap_32k_clk;
+	u32 omap_32k_clk_speed;
+	unsigned long temp;
+
 	/*
 	 * Voltage Manager FSM parameters init
-	 * XXX This data should be passed in from the board file
 	 */
-	vdd->write_reg(OMAP3_CLKSETUP, prm_mod_offs, OMAP3_PRM_CLKSETUP_OFFSET);
-	vdd->write_reg(OMAP3_VOLTOFFSET, prm_mod_offs,
-		       OMAP3_PRM_VOLTOFFSET_OFFSET);
-	vdd->write_reg(OMAP3_VOLTSETUP2, prm_mod_offs,
-		       OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	omap_32k_clk = clk_get(NULL, "wkup_32k_fck");
+	if (IS_ERR(omap_32k_clk)) {
+		pr_warning("%s: Could not get the 32k_clk clk to calculate"
+			"various vdd_%s params\n", __func__, vdd->voltdm.name);
+		return;
+	}
+	omap_32k_clk_speed = clk_get_rate(omap_32k_clk);
+	clk_put(omap_32k_clk);
+
+	temp = vdd->board_data->omap3_board_data.vdd_setup_off.clksetup;
+	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
+	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_CLKSETUP_OFFSET);
+
+	temp = vdd->board_data->omap3_board_data.vdd_setup_off.voltsetup2;
+	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
+	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	temp = vdd->board_data->omap3_board_data.voltoffset;
+	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
+	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_VOLTOFFSET_OFFSET);
+
 }
 
 static void __init omap3_vc_init(struct omap_vdd_info *vdd)
@@ -539,21 +559,45 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 	static bool is_initialized;
 	u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
 	u32 vc_val;
-
-	if (is_initialized)
-		return;
+	struct clk *sys_ck;
+	u32 sys_clk_speed;
+	unsigned long temp;
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->on_volt);
-	onlp_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->onlp_volt);
-	ret_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->ret_volt);
-	off_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->off_volt);
+	on_vsel = vdd->pmic_info->on_cmd(vdd->vp_param->on_volt);
+	onlp_vsel = vdd->pmic_info->onlp_cmd(vdd->vp_param->onlp_volt);
+	ret_vsel = vdd->pmic_info->ret_cmd(vdd->vp_param->ret_volt);
+	off_vsel = vdd->pmic_info->off_cmd(vdd->vp_param->off_volt);
 	vc_val	= ((on_vsel << vdd->vc_data->vc_common->cmd_on_shift) |
 		(onlp_vsel << vdd->vc_data->vc_common->cmd_onlp_shift) |
 		(ret_vsel << vdd->vc_data->vc_common->cmd_ret_shift) |
 		(off_vsel << vdd->vc_data->vc_common->cmd_off_shift));
 	vdd->write_reg(vc_val, prm_mod_offs, vdd->vc_data->cmdval_reg);
 
+	sys_ck = clk_get(NULL, "sys_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: Could not get the sys clk to calculate"
+			"various vdd_%s params\n", __func__, vdd->voltdm.name);
+		return;
+	}
+	sys_clk_speed = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+	/* Divide to avoid overflow */
+	sys_clk_speed /= 1000000;
+
+	/* Configure the setup times */
+	vc_val = vdd->read_reg(prm_mod_offs, vdd->vfsm->voltsetup_reg);
+	vc_val &= ~vdd->vfsm->voltsetup_mask;
+	temp = vdd->board_data->omap3_board_data.vdd_setup_off.voltsetup;
+	temp = temp * sys_clk_speed / 8;
+	vc_val |= temp << vdd->vfsm->voltsetup_shift;
+	vdd->write_reg(vc_val, prm_mod_offs, vdd->vfsm->voltsetup_reg);
+
+	omap3_vfsm_init(vdd);
+
+	if (is_initialized)
+		return;
+
 	/*
 	 * Generic VC parameters init
 	 * XXX This data should be abstracted out
@@ -563,8 +607,6 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 	vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK, prm_mod_offs,
 			OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
-	omap3_vfsm_init(vdd);
-
 	is_initialized = true;
 }
 
@@ -573,12 +615,69 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 {
 	static bool is_initialized;
-	u32 vc_val;
+	u32 vc_val, temp, prescalar, ramp_count;
+	struct clk *sys_ck;
+	u32 sys_clk_speed;
 
-	if (is_initialized)
+	sys_ck = clk_get(NULL, "sys_clkin_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: Could not get the sys clk to calculate"
+			"various vdd_%s params\n", __func__, vdd->voltdm.name);
 		return;
+	}
+	sys_clk_speed = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+	/* Divide to avoid overflow */
+	sys_clk_speed /= 1000000;
+
+	/* Configure the setup times */
+	vc_val = vdd->read_reg(prm_mod_offs, vdd->vfsm->voltsetup_reg);
+	temp = vdd->board_data->omap4_board_data.vdd_setup_off.voltsetup_ramp_down;
+	prescalar = temp * 63 / sys_clk_speed;
+	if (prescalar <= 16)
+		prescalar = 16;
+	else if (prescalar <= 64)
+		prescalar = 64;
+	else if (prescalar <= 128)
+		prescalar = 128;
+	else if (prescalar <= 512)
+		prescalar = 512;
+	else
+		pr_warning("%s: Invalid VoltOff set up time for vdd%s\n",
+			__func__, vdd->voltdm.name);
+
+	vc_val &= ~OMAP4430_RAMP_DOWN_PRESCAL_MASK;
+	vc_val |= prescalar << OMAP4430_RAMP_DOWN_PRESCAL_SHIFT;
+
+	ramp_count = (temp * sys_clk_speed / prescalar) << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+	vc_val &= ~OMAP4430_RAMP_DOWN_COUNT_MASK;
+	vc_val |= ramp_count;
+
+	temp = vdd->board_data->omap4_board_data.vdd_setup_off.voltsetup_ramp_up;
+	prescalar = temp * 63 / sys_clk_speed;
+	if (prescalar <= 16)
+		prescalar = 16;
+	else if (prescalar <= 64)
+		prescalar = 64;
+	else if (prescalar <= 128)
+		prescalar = 128;
+	else if (prescalar <= 512)
+		prescalar = 512;
+	else
+		pr_warning("%s: Invalid VoltOff set up time for vdd%s\n",
+			__func__, vdd->voltdm.name);
+
+	vc_val &= ~OMAP4430_RAMP_UP_PRESCAL_MASK;
+	vc_val |= prescalar << OMAP4430_RAMP_UP_PRESCAL_SHIFT;
 
-	/* TODO: Configure setup times and CMD_VAL values*/
+	ramp_count = (temp * sys_clk_speed / prescalar) << OMAP4430_RAMP_UP_COUNT_SHIFT;
+	vc_val &= ~OMAP4430_RAMP_UP_COUNT_MASK;
+	vc_val |= ramp_count;
+
+	vdd->write_reg(vc_val, prm_mod_offs, vdd->vfsm->voltsetup_reg);
+
+	if (is_initialized)
+		return;
 
 	/*
 	 * Generic VC parameters init
@@ -629,13 +728,6 @@ static void __init omap_vc_init(struct omap_vdd_info *vdd)
 	vdd->write_reg(vc_val, prm_mod_offs,
 		       vdd->vc_data->vc_common->smps_volra_reg);
 
-	/* Configure the setup times */
-	vc_val = vdd->read_reg(prm_mod_offs, vdd->vfsm->voltsetup_reg);
-	vc_val &= ~vdd->vfsm->voltsetup_mask;
-	vc_val |= vdd->pmic_info->volt_setup_time <<
-			vdd->vfsm->voltsetup_shift;
-	vdd->write_reg(vc_val, prm_mod_offs, vdd->vfsm->voltsetup_reg);
-
 	if (cpu_is_omap34xx())
 		omap3_vc_init(vdd);
 	else if (cpu_is_omap44xx())
@@ -971,6 +1063,23 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 	return 0;
 }
 
+int omap_voltage_register_board_params(struct voltagedomain *voltdm,
+		union omap_volt_board_data *board_params)
+{
+	struct omap_vdd_info *vdd;
+
+	if (!voltdm || IS_ERR(voltdm)) {
+		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		return -EINVAL;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+
+	vdd->board_data = board_params;
+
+	return 0;
+}
+
 /**
  * omap_voltage_get_dbgdir() - API to get pointer to the debugfs directory
  *				corresponding to a voltage domain.
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index e9f5408..de4e09b 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -23,14 +23,6 @@
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
-/*
- * OMAP3 GENERIC setup times. Revisit to see if these needs to be
- * passed from board or PMIC file
- */
-#define OMAP3_CLKSETUP		0xff
-#define OMAP3_VOLTOFFSET	0xff
-#define OMAP3_VOLTSETUP2	0xff
-
 /**
  * struct omap_vfsm_instance_data - per-voltage manager FSM register/bitfield
  * data
@@ -80,17 +72,25 @@ struct omap_volt_data {
  * struct omap_volt_pmic_info - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
  * @step_size:	PMIC voltage step size (in uv)
+ * @vp_erroroffset:	Offset value in the Error to Voltage converter
+ * @vp_vstepmin:	Minimum voltage step in mV
+ * @vp_vstepmax:	Maximum voltage step in mV
+ * @vp_vddmin:	Minimum voltage supply level in mV
+ * @vp_vddmax:	Maximum voltage supply level in mV
+ * @vp_timeout_us:	Voltage Controller's maximum wait time for response
+ * @i2c_slave_addr:	I2C slave address value for the Power IC device.
+ * @pmic_reg:	voltage configuration register address value for the
+ *				VDD channe
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
+ * @on_cmd:	PMIC API to send on command instruction
+ * @onlp_cmd:	PMIC API to send onlp command instruction
+ * @ret_cmd:	PMIC API to send ret command instruction
+ * @off_cmd:	PMIC API to send off command instruction
  */
 struct omap_volt_pmic_info {
 	int slew_rate;
 	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
-	u16 volt_setup_time;
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
@@ -101,11 +101,30 @@ struct omap_volt_pmic_info {
 	u8 pmic_reg;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
+	unsigned char (*on_cmd)(unsigned long uV);
+	unsigned char (*onlp_cmd)(unsigned long uV);
+	unsigned char (*ret_cmd)(unsigned long uV);
+	unsigned char (*off_cmd)(unsigned long uV);
+};
+
+/**
+ * struct omap_vp_param - VP specific data required by voltage driver.
+ * @on_volt: on voltage for the device in mV
+ * @onlp_volt: inactive voltage for the device in mV
+ * @ret_volt: retention voltage for the device in mV
+ * @off_volt: off voltage for the device in mV
+ */
+struct omap_vp_param {
+	u32 on_volt;
+	u32 onlp_volt;
+	u32 ret_volt;
+	u32 off_volt;
+	u8 vp_vddmax;
+	u8 vp_vddmin;
 };
 
 /**
  * omap_vdd_info - Per Voltage Domain info
- *
  * @volt_data		: voltage table having the distinct voltages supported
  *			  by the domain and other associated per voltage data.
  * @pmic_info		: pmic specific parameters which should be populted by
@@ -116,6 +135,9 @@ struct omap_volt_pmic_info {
  * @vc_data		: structure containing various various vc registers,
  *			  shifts, masks etc.
  * @vfsm                : voltage manager FSM data
+ * @vfsm                : voltage manager FSM data
+ * @vp_param			: VP specific parameters
+ * @board_data			: board specific parameters
  * @voltdm		: pointer to the voltage domain structure
  * @debug_dir		: debug directory for this voltage domain.
  * @curr_volt		: current voltage for this vdd.
@@ -129,6 +151,8 @@ struct omap_vdd_info {
 	struct omap_vp_runtime_data vp_rt_data;
 	struct omap_vc_instance_data *vc_data;
 	const struct omap_vfsm_instance_data *vfsm;
+	struct omap_vp_param *vp_param;
+	union omap_volt_board_data *board_data;
 	struct voltagedomain voltdm;
 	struct dentry *debug_dir;
 	u32 curr_volt;
@@ -139,6 +163,61 @@ struct omap_vdd_info {
 		unsigned long target_volt);
 };
 
+/**
+ * omap3_vdd_setuptime - vdd set up time info
+ * @voltsetup	: setup time of the VDDregulators in us
+ * @clksetup	: setup time of the oscillator system clock (sys_clk) in us
+ * @voltsetup2	: Overall setup time of VDDregulators in us
+ */
+struct omap3_vdd_setuptime {
+	u16 voltsetup;
+	u16 clksetup;
+	u16 voltsetup2;
+};
+
+/**
+ * omap3_volt_board_data - vdd set up time info for OMAP3
+ * @vdd_setup_ret	: VDD setup time for retention mode
+ * @vdd_setup_off	: VDD setup time for off mode
+ * @voltoffset		: offset-time to de-assert sys_offmode
+ *					when exiting the OFF mode
+ */
+struct omap3_volt_board_data {
+	struct omap3_vdd_setuptime vdd_setup_ret;
+	struct omap3_vdd_setuptime vdd_setup_off;
+	u16 voltoffset;
+};
+
+/**
+ * omap4_volt_setuptime - vdd set up time info for OMAP4
+ * @voltsetup_ramp_up	: VDD ram up time in us
+ * @voltsetup_ramp_down	: VDD ram down time in us
+ */
+struct omap4_volt_setuptime {
+	u16 voltsetup_ramp_up;
+	u16 voltsetup_ramp_down;
+};
+
+/**
+ * omap4_volt_board_data - vdd set up time info for OMAP4
+ * @vdd_setup_ret	: VDD setup time for retention mode
+ * @vdd_setup_off	: VDD setup time for off mode
+ */
+struct omap4_volt_board_data {
+	struct omap4_volt_setuptime vdd_setup_ret;
+	struct omap4_volt_setuptime vdd_setup_off;
+};
+
+/**
+ * omap_volt_board_data - board specific voltage set up time data
+ * @omap3_board_data	: omap3 board data
+ * @omap4_board_data	: omap4 board data
+ */
+union omap_volt_board_data {
+	struct omap3_volt_board_data omap3_board_data;
+	struct omap4_volt_board_data omap4_board_data;
+};
+
 unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
@@ -163,6 +242,9 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 struct voltagedomain *omap_voltage_domain_lookup(char *name);
 
 int omap_voltage_late_init(void);
+int omap_voltage_register_board_params(struct voltagedomain *voltdm,
+		union omap_volt_board_data *board_params);
+
 #else
 static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 		struct omap_volt_pmic_info *pmic_info)
@@ -179,6 +261,11 @@ static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
 {
 	return ERR_PTR(-EINVAL);
 }
+static inline int omap_voltage_register_board_params(struct voltagedomain *voltdm,
+		struct omap_volt_board_data *board_params)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index def230f..62ae1ee 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -83,9 +83,13 @@ static int __init omap3xxx_voltage_early_init(void)
 	if (cpu_is_omap3630()) {
 		omap3_vdd1_info.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_vdd2_info.volt_data = omap36xx_vddcore_volt_data;
+		omap3_vdd1_info.vp_param = &omap36xx_mpu_vp_data;
+		omap3_vdd2_info.vp_param = &omap36xx_core_vp_data;
 	} else {
 		omap3_vdd1_info.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_vdd2_info.volt_data = omap34xx_vddcore_volt_data;
+		omap3_vdd1_info.vp_param = &omap34xx_mpu_vp_data;
+		omap3_vdd2_info.vp_param = &omap34xx_core_vp_data;
 	}
 
 	return omap_voltage_early_init(prm_mod, prm_irqst_ocp_mod,
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index cb64996..972760c 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -95,6 +95,10 @@ static int __init omap44xx_voltage_early_init(void)
 	omap4_vdd_iva_info.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_vdd_core_info.volt_data = omap44xx_vdd_core_volt_data;
 
+	omap4_vdd_mpu_info.vp_param = &omap44xx_mpu_vp_data;
+	omap4_vdd_iva_info.vp_param = &omap44xx_iva_vp_data;
+	omap4_vdd_core_info.vp_param = &omap44xx_core_vp_data;
+
 	return omap_voltage_early_init(prm_mod, prm_irqst_ocp_mod,
 				       omap4_vdd_info,
 				       ARRAY_SIZE(omap4_vdd_info));
-- 
1.7.0.4

