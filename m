From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 04/12] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Fri, 18 Feb 2011 22:38:50 +0530
Message-ID: <1298048938-1480-5-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1BRRJS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:09:18 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Since the clocksetup & voltsetup time used for RET & OFF is different.
And Updating the VC setuptime struct during init based on the OMAP Si.

Clocksetup & voltsetup time values used are recommended by TI Soldel team,
which is tested on omap3 platform.

http://omapedia.org/wiki/TWL4030_power_scripts

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/omap_twl.c            |  147 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/voltage.c             |   16 +++-
 arch/arm/plat-omap/include/plat/voltage.h |   39 ++++++--
 3 files changed, 184 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 9510623..4b5a8e9 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -86,6 +86,86 @@
 #define TWL4030_SMPS_SLEW_RATE	4000
 #define TWL4030_SMPS_STEP_SIZE	12500
 
+/*
+ * Configuring setuptime when using i2c/sys_off signal for entering OFFMODE.
+ *
+ * 1. clock & volt setuptime for OMAP when using i2c for entering OFFMODE.
+ *
+ * <-----------clksetup----------->|
+ *
+ *                                 |<----------voltsetup1-------->|
+ *
+ *                                 |<-vdd2 setup->|
+ *                                                 |<-vdd1 setup->|
+ *
+ * voltsetup1 is total (VDD2 + VDD1) setup time
+ * when this sequence is managed by OMAP.
+ *
+ * voltsetup1 = voltsetup1[31:16] (VDD2 voltsetup time) +
+ *			voltsetup1[15:0] (VDD1 voltsetup time).
+ *
+ * 2. clock & volt setuptime for OMAP when using sys_off signal
+ * for entering OFFMODE.
+ *
+ * <-------------------------clksetup---------------------------->|
+ *
+ * <----voltoffset---->|
+ *                     |<---------------voltsetup2--------------->|
+ *
+ *                     |<--vdd2 setup-->|
+ *                                 |<--vdd1 setup-->|
+ *
+ * clksetup = voltoffset + voltsetup2.
+ *
+ * When exiting OFFMODE:
+ *
+ *	clksetup is the rampup and stabilization time required
+ *	for the X'stall or oscillator.
+ *
+ *	voltoffset is the offset time to de-assert the sys_off signal,
+ *	when this sequence is managed by the PM IC.
+ *	And this will trigger the VDD1 & VDD2 voltage ramp on PM IC.
+ *
+ *	voltsetup2 is the overall setup time of VDD1 and VDD2 regulators.
+ */
+
+/*
+ * VOLTSETUP1 for RET & OFF
+ * Setup time of the VDD1 and VDD2 regulators.
+ * Number of sys_clk cycles required for VDD regulator to stabilize is
+ * devide by 8 and programmed in the register field for VDD1/VDD2.
+ */
+#define OMAP3_VOLTSETUP_VDD1_RET	28	/* 28 uS */
+#define OMAP3_VOLTSETUP_VDD2_RET	26	/* 26 uS */
+
+#define OMAP3_VOLTSETUP_VDD1_OFF	55	/* 55 uS */
+#define OMAP3_VOLTSETUP_VDD2_OFF	49	/* 49 uS */
+
+/*
+ * VOLTOFFSET for RET & OFF
+ * Offset-time to de-assert sys_offmode signal while exiting the OFF mode
+ * and when the OFF sequence is supervised by the Power IC.
+ */
+#define OMAP3_VOLTOFFSET_RET		0
+#define OMAP3_VOLTOFFSET_OFF		8545	/* 8.545 mS */
+
+/*
+ * VOLTSETUP2 for RET & OFF
+ * Overall setup time of VDD1 and VDD2 regulators.
+ * Used when exiting OFF mode with the Power IC managing the
+ * sequencing of the voltages regulation steps.
+ */
+#define OMAP3_VOLTSETUP2_RET		0
+#define OMAP3_VOLTSETUP2_OFF		1526	/* 1.526 mS */
+
+/*
+ * OMAP3 CLKSETUP TIME for RET & OFF
+ * Setup time of the oscillator (sys_clk), based on number of
+ * 32 kHz clock cycles.
+ */
+#define OMAP3_CLKSETUP_RET		31	/* 30.5 uS */
+#define OMAP3_CLKSETUP_OFF		10000	/* 10 mS */
+
 static bool is_offset_valid;
 static u8 smps_offset;
 
@@ -176,13 +256,28 @@ static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
-	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
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
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
 	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
 	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.clksetup_ret		= {
+		.clksetup	= OMAP3_CLKSETUP_RET,
+	},
+	.clksetup_off		= {
+		.clksetup	= OMAP3_CLKSETUP_OFF,
+	},
 };
 
 static struct omap_volt_pmic_info omap3_core_volt_info = {
@@ -196,15 +291,34 @@ static struct omap_volt_pmic_info omap3_core_volt_info = {
 	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
-	.volt_setup_time        = OMAP_VOLTSETUP_TIME,
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
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
 	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
 	.step_size		= TWL4030_SMPS_STEP_SIZE,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
+	.clksetup_ret		= {
+		.clksetup	= OMAP3_CLKSETUP_RET,
+	},
+	.clksetup_off		= {
+		.clksetup	= OMAP3_CLKSETUP_OFF,
+	},
 };
 
+/*
+ * FIXME: voltsetup time values should be updated
+ * after profiling on OMAP4 board.
+ */
 static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.on_volt		= OMAP4430_VDD1_ON,
 	.onlp_volt		= OMAP4430_VDD1_ONLP,
@@ -216,7 +330,12 @@ static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
+	.voltsetup_ret		= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
+	.voltsetup_off		= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_MPU_SR_VOLT_REG,
 	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
@@ -225,6 +344,10 @@ static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
+/*
+ * FIXME: voltsetup time values should be updated
+ * after profiling on OMAP4 board.
+ */
 static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.on_volt		= OMAP4430_VDD2_ON,
 	.onlp_volt		= OMAP4430_VDD2_ONLP,
@@ -236,7 +359,12 @@ static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
+	.voltsetup_ret			= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
+	.voltsetup_off			= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_IVA_SR_VOLT_REG,
 	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
@@ -245,6 +373,10 @@ static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
+/*
+ * FIXME: voltsetup time values should be updated
+ * after profiling on OMAP4 board.
+ */
 static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.on_volt		= OMAP4430_VDD3_ON,
 	.onlp_volt		= OMAP4430_VDD3_ONLP,
@@ -256,7 +388,12 @@ static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
 	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
-	.volt_setup_time	= OMAP_VOLTSETUP_TIME,
+	.voltsetup_ret		= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
+	.voltsetup_off		= {
+		.voltsetup	= OMAP_VOLTSETUP_TIME,
+	},
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.pmic_reg		= OMAP4_VDD_CORE_SR_VOLT_REG,
 	.slew_rate		= TWL4030_SMPS_SLEW_RATE,
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 12be525..1c58f8b 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -27,6 +27,7 @@
 
 #include <plat/common.h>
 #include <plat/voltage.h>
+#include <plat/clock.h>
 
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
@@ -95,6 +96,8 @@ struct vc_reg_info {
 	u8 bypass_val_reg;
 	u8 cmdval_reg;
 	u8 voltsetup_reg;
+	u8 voltsetup2_reg;
+	u8 voltoffset_reg;
 	/*VC_SMPS_SA*/
 	u8 smps_sa_shift;
 	u32 smps_sa_mask;
@@ -771,7 +774,7 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 	/*Configure the setup times */
 	vc_val = vdd->read_reg(mod, vdd->vc_reg.voltsetup_reg);
 	vc_val &= ~vdd->vc_reg.voltsetup_mask;
-	vc_val |= vdd->pmic_info->volt_setup_time <<
+	vc_val |= vdd->pmic_info->voltsetup_ret.voltsetup <<
 			vdd->vc_reg.voltsetup_shift;
 	vdd->write_reg(vc_val, mod, vdd->vc_reg.voltsetup_reg);
 
@@ -794,9 +797,12 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 			OMAP3_PRM_VC_CH_CONF_OFFSET);
 	vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK, mod,
 			OMAP3_PRM_VC_I2C_CFG_OFFSET);
-	vdd->write_reg(OMAP3_CLKSETUP, mod, OMAP3_PRM_CLKSETUP_OFFSET);
-	vdd->write_reg(OMAP3_VOLTOFFSET, mod, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	vdd->write_reg(OMAP3_VOLTSETUP2, mod, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	vdd->write_reg(vdd->pmic_info->clksetup_ret.clksetup, mod,
+			OMAP3_PRM_CLKSETUP_OFFSET);
+	vdd->write_reg(vdd->pmic_info->voltsetup_ret.voltoffset, mod,
+			vdd->vc_reg.voltoffset_reg);
+	vdd->write_reg(vdd->pmic_info->voltsetup_ret.voltsetup2, mod,
+			vdd->vc_reg.voltsetup2_reg);
 	is_initialized = true;
 }
 
@@ -877,6 +883,8 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	vdd->vc_reg.smps_volra_reg = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET;
 	vdd->vc_reg.bypass_val_reg = OMAP3_PRM_VC_BYPASS_VAL_OFFSET;
 	vdd->vc_reg.voltsetup_reg = OMAP3_PRM_VOLTSETUP1_OFFSET;
+	vdd->vc_reg.voltsetup2_reg = OMAP3_PRM_VOLTSETUP2_OFFSET;
+	vdd->vc_reg.voltoffset_reg = OMAP3_PRM_VOLTOFFSET_OFFSET;
 	vdd->vc_reg.data_shift = OMAP3430_DATA_SHIFT;
 	vdd->vc_reg.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT;
 	vdd->vc_reg.regaddr_shift = OMAP3430_REGADDR_SHIFT;
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 7fcb788..c0373d0 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -19,14 +19,6 @@
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
 /* Voltage value defines */
 #define OMAP3430_VDD_MPU_OPP1_UV		975000
 #define OMAP3430_VDD_MPU_OPP2_UV		1075000
@@ -87,11 +79,36 @@ struct omap_volt_data {
 };
 
 /**
+ * struct volt_setuptime - voltage setup time values.
+ * @voltsetup: voltage setuptime for regulators (VDD1/VDD2),
+ *     when the OMAP manages the sequencing of voltage regulation steps.
+ * @voltsetup2:        overall setup time of regulators (VDD2 & VDD1),
+ *     when the PMIC manages the sequencing of voltage regulation steps.
+ * @voltoffset:        offset-time to de-assert sys_offmode signal,
+ *     when the PMIC manages the sequencing of voltage regulation steps.
+ */
+struct volt_setuptime {
+	u16 voltsetup;
+	u16 voltsetup2;
+	u16 voltoffset;
+};
+
+/**
+ * struct clk_setuptime
+ * @clksetup:  clksetup time (rampup + stabilization time)
+ */
+struct clk_setuptime {
+	u16 clksetup;
+};
+
+/**
  * struct omap_volt_pmic_info - PMIC specific data required by voltage driver.
+ * @voltsetup_ret/off: voltetup values for CORE RET/OFF.
  * @slew_rate:	PMIC slew rate (in uv/us)
  * @step_size:	PMIC voltage step size (in uv)
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
+ * @clksetup_ret/off:  clksetup values for CORE RET/OFF.
  */
 struct omap_volt_pmic_info {
 	/* OMAP specific params: vc_cmd_values, vp_params */
@@ -106,13 +123,17 @@ struct omap_volt_pmic_info {
 	u8 vp_vddmax;
 	u8 vp_timeout_us;
 	/* PM IC specific params: voltsetup, pmic_config values */
-	u16 volt_setup_time;
+	struct volt_setuptime voltsetup_ret;
+	struct volt_setuptime voltsetup_off;
 	u8 i2c_slave_addr;
 	u8 pmic_reg;
 	int slew_rate;
 	int step_size;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
+	/* Board specific: clksetup_time */
+	struct clk_setuptime clksetup_ret;
+	struct clk_setuptime clksetup_off;
 };
 
 unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
-- 
1.7.1

