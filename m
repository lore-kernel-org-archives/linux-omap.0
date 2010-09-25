From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 05/11] OMAP4: Adding voltage driver support
Date: Sat, 25 Sep 2010 18:21:20 +0530
Message-ID: <1285419086-13047-6-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53966 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0IYMvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 08:51:39 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

OMAP4 has three scalable voltage domains vdd_mpu, vdd_iva
and vdd_core. This patch adds the voltage tables and other
configurable voltage processor and voltage controller
settings to control these three scalable domains in OMAP4.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    2 +-
 arch/arm/mach-omap2/voltage.c             |  211 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |   20 +++-
 3 files changed, 229 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 38458b7..b18d171 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
 					   cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 5375bf9..03cfd7d 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -29,6 +29,8 @@
 #include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
+#include "prm44xx.h"
+#include "prm-regbits-44xx.h"
 #include "pm.h"
 
 #define VP_IDLE_TIMEOUT		200
@@ -148,7 +150,50 @@ static struct omap_vdd_info omap3_vdd_info[] = {
 
 #define OMAP3_NR_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
 
-/* TODO: OMAP4 register offsets */
+/* OMAP4 VDD sturctures */
+static struct omap_vdd_info omap4_vdd_info[] = {
+	{
+		.vp_offs = {
+			.vpconfig = OMAP4_PRM_VP_MPU_CONFIG_OFFSET,
+			.vstepmin = OMAP4_PRM_VP_MPU_VSTEPMIN_OFFSET,
+			.vstepmax = OMAP4_PRM_VP_MPU_VSTEPMAX_OFFSET,
+			.vlimitto = OMAP4_PRM_VP_MPU_VLIMITTO_OFFSET,
+			.vstatus = OMAP4_PRM_VP_MPU_STATUS_OFFSET,
+			.voltage = OMAP4_PRM_VP_MPU_VOLTAGE_OFFSET,
+		},
+		.voltdm = {
+			.name = "mpu",
+		},
+	},
+	{
+		.vp_offs = {
+			.vpconfig = OMAP4_PRM_VP_IVA_CONFIG_OFFSET,
+			.vstepmin = OMAP4_PRM_VP_IVA_VSTEPMIN_OFFSET,
+			.vstepmax = OMAP4_PRM_VP_IVA_VSTEPMAX_OFFSET,
+			.vlimitto = OMAP4_PRM_VP_IVA_VLIMITTO_OFFSET,
+			.vstatus = OMAP4_PRM_VP_IVA_STATUS_OFFSET,
+			.voltage = OMAP4_PRM_VP_IVA_VOLTAGE_OFFSET,
+		},
+		.voltdm = {
+			.name = "iva",
+		},
+	},
+	{
+		.vp_offs = {
+			.vpconfig = OMAP4_PRM_VP_CORE_CONFIG_OFFSET,
+			.vstepmin = OMAP4_PRM_VP_CORE_VSTEPMIN_OFFSET,
+			.vstepmax = OMAP4_PRM_VP_CORE_VSTEPMAX_OFFSET,
+			.vlimitto = OMAP4_PRM_VP_CORE_VLIMITTO_OFFSET,
+			.vstatus = OMAP4_PRM_VP_CORE_STATUS_OFFSET,
+			.voltage = OMAP4_PRM_VP_CORE_VOLTAGE_OFFSET,
+		},
+		.voltdm = {
+			.name = "core",
+		},
+	},
+};
+
+#define OMAP4_NR_SCALABLE_VDD ARRAY_SIZE(omap4_vdd_info)
 
 /*
  * Default voltage controller settings.
@@ -212,6 +257,29 @@ static struct omap_volt_data omap36xx_vdd2_volt_data[] = {
 	{.volt_nominal = 1137500, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
 };
 
+/*
+ * Structures containing OMAP4430 voltage supported and various
+ * data associated with it per voltage domain basis. Smartreflex Ntarget
+ * values are left as 0 as they have to be populated by smartreflex
+ * driver after reading the efuse.
+ */
+static struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
+	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
+	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
+	{.volt_nominal = 1260000, .sr_errminlimit = 0xFA, .vp_errgain = 0x23},
+	{.volt_nominal = 1350000, .sr_errminlimit = 0xFA, .vp_errgain = 0x27},
+};
+
+static struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
+	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
+	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
+	{.volt_nominal = 1260000, .sr_errminlimit = 0xFA, .vp_errgain = 0x23},
+};
+
+static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
+	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
+	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
+};
 
 /* By default VPFORCEUPDATE is the chosen method of voltage scaling */
 static bool voltscale_vpforceupdate = true;
@@ -489,6 +557,130 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	vdd->vp_reg.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT;
 }
 
+/* OMAP4 specific voltage init functions */
+static void __init omap4_init_voltagecontroller(void)
+{
+	voltage_write_reg(OMAP4_PRM_VC_SMPS_SA_OFFSET,
+			(OMAP4_SRI2C_SLAVE_ADDR <<
+			 OMAP4430_SA_VDD_CORE_L_0_6_SHIFT) |
+			(OMAP4_SRI2C_SLAVE_ADDR <<
+			 OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT) |
+			(OMAP4_SRI2C_SLAVE_ADDR <<
+			 OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT));
+	voltage_write_reg(OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
+			(OMAP4_VDD_MPU_SR_VOLT_REG <<
+			 OMAP4430_VOLRA_VDD_MPU_L_SHIFT) |
+			(OMAP4_VDD_IVA_SR_VOLT_REG <<
+			 OMAP4430_VOLRA_VDD_IVA_L_SHIFT) |
+			(OMAP4_VDD_CORE_SR_VOLT_REG <<
+			 OMAP4430_VOLRA_VDD_CORE_L_SHIFT));
+	voltage_write_reg(OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
+			OMAP4430_RAV_VDD_MPU_L_MASK |
+			OMAP4430_CMD_VDD_MPU_L_MASK |
+			OMAP4430_RAV_VDD_IVA_L_MASK |
+			OMAP4430_CMD_VDD_IVA_L_MASK |
+			OMAP4430_RAV_VDD_CORE_L_MASK |
+			OMAP4430_CMD_VDD_CORE_L_MASK);
+
+	voltage_write_reg(OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET,
+			(0x60 << OMAP4430_SCLL_SHIFT |
+			0x26 << OMAP4430_SCLH_SHIFT));
+	/* TODO: Configure setup times and CMD_VAL values*/
+}
+
+/* Sets up all the VDD related info for OMAP4 */
+static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
+{
+	struct clk *sys_ck;
+	u32 sys_clk_speed, timeout_val, waittime;
+
+	if (!strcmp(vdd->voltdm.name, "mpu")) {
+		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_MPU_VLIMITTO_VDDMIN;
+		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_MPU_VLIMITTO_VDDMAX;
+		vdd->volt_data = omap44xx_vdd_mpu_volt_data;
+		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_mpu_volt_data);
+		vdd->vp_reg.tranxdone_status =
+				OMAP4430_VP_MPU_TRANXDONE_ST_MASK;
+		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET;
+		vdd->vdd_sr_reg = OMAP4_VDD_MPU_SR_VOLT_REG;
+	} else if (!strcmp(vdd->voltdm.name, "core")) {
+		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_CORE_VLIMITTO_VDDMIN;
+		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_CORE_VLIMITTO_VDDMAX;
+		vdd->volt_data = omap44xx_vdd_core_volt_data;
+		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_core_volt_data);
+		vdd->vp_reg.tranxdone_status =
+				OMAP4430_VP_CORE_TRANXDONE_ST_MASK;
+		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET;
+		vdd->vdd_sr_reg = OMAP4_VDD_CORE_SR_VOLT_REG;
+	} else if (!strcmp(vdd->voltdm.name, "iva")) {
+		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_IVA_VLIMITTO_VDDMIN;
+		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_IVA_VLIMITTO_VDDMAX;
+		vdd->volt_data = omap44xx_vdd_iva_volt_data;
+		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_iva_volt_data);
+		vdd->vp_reg.tranxdone_status =
+			OMAP4430_VP_IVA_TRANXDONE_ST_MASK;
+		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET;
+		vdd->vdd_sr_reg = OMAP4_VDD_IVA_SR_VOLT_REG;
+	} else {
+		pr_warning("%s: vdd_%s does not exisit in OMAP4\n",
+			__func__, vdd->voltdm.name);
+		return;
+	}
+
+	/*
+	 * Sys clk rate is require to calculate vp timeout value and
+	 * smpswaittimemin and smpswaittimemax.
+	 */
+	sys_ck = clk_get(NULL, "sys_clkin_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: Could not get the sys clk to calculate"
+			"various vdd_%s params\n", __func__, vdd->voltdm.name);
+		return;
+	}
+	sys_clk_speed = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	/* Divide to avoid overflow */
+	sys_clk_speed /= 1000;
+
+	/* Nominal/Reset voltage of the VDD */
+	vdd->nominal_volt = vdd->curr_volt = 1200000;
+
+	/* VPCONFIG bit fields */
+	vdd->vp_reg.vpconfig_erroroffset =
+				(OMAP4_VP_CONFIG_ERROROFFSET <<
+				 OMAP4430_ERROROFFSET_SHIFT);
+	vdd->vp_reg.vpconfig_errorgain_mask = OMAP4430_ERRORGAIN_MASK;
+	vdd->vp_reg.vpconfig_errorgain_shift = OMAP4430_ERRORGAIN_SHIFT;
+	vdd->vp_reg.vpconfig_initvoltage_shift = OMAP4430_INITVOLTAGE_SHIFT;
+	vdd->vp_reg.vpconfig_initvoltage_mask = OMAP4430_INITVOLTAGE_MASK;
+	vdd->vp_reg.vpconfig_timeouten = OMAP4430_TIMEOUTEN_MASK;
+	vdd->vp_reg.vpconfig_initvdd = OMAP4430_INITVDD_MASK;
+	vdd->vp_reg.vpconfig_forceupdate = OMAP4430_FORCEUPDATE_MASK;
+	vdd->vp_reg.vpconfig_vpenable = OMAP4430_VPENABLE_MASK;
+
+	/* VSTEPMIN VSTEPMAX bit fields */
+	waittime = ((volt_pmic_info.step_size / volt_pmic_info.slew_rate) *
+				sys_clk_speed) / 1000;
+	vdd->vp_reg.vstepmin_smpswaittimemin = waittime;
+	vdd->vp_reg.vstepmax_smpswaittimemax = waittime;
+	vdd->vp_reg.vstepmin_stepmin = OMAP4_VP_VSTEPMIN_VSTEPMIN;
+	vdd->vp_reg.vstepmax_stepmax = OMAP4_VP_VSTEPMAX_VSTEPMAX;
+	vdd->vp_reg.vstepmin_smpswaittimemin_shift =
+		OMAP4430_SMPSWAITTIMEMIN_SHIFT;
+	vdd->vp_reg.vstepmax_smpswaittimemax_shift =
+		OMAP4430_SMPSWAITTIMEMAX_SHIFT;
+	vdd->vp_reg.vstepmin_stepmin_shift = OMAP4430_VSTEPMIN_SHIFT;
+	vdd->vp_reg.vstepmax_stepmax_shift = OMAP4430_VSTEPMAX_SHIFT;
+
+	/* VLIMITTO bit fields */
+	timeout_val = (sys_clk_speed * OMAP4_VP_VLIMITTO_TIMEOUT_US) / 1000;
+	vdd->vp_reg.vlimitto_timeout = timeout_val;
+	vdd->vp_reg.vlimitto_vddmin_shift = OMAP4430_VDDMIN_SHIFT;
+	vdd->vp_reg.vlimitto_vddmax_shift = OMAP4430_VDDMAX_SHIFT;
+	vdd->vp_reg.vlimitto_timeout_shift = OMAP4430_TIMEOUT_SHIFT;
+}
+
 /* Generic voltage init functions */
 static void __init init_voltageprocessor(struct omap_vdd_info *vdd)
 {
@@ -526,6 +718,8 @@ static void __init vdd_data_configure(struct omap_vdd_info *vdd)
 {
 	if (cpu_is_omap34xx())
 		omap3_vdd_data_configure(vdd);
+	else if (cpu_is_omap44xx())
+		omap4_vdd_data_configure(vdd);
 }
 
 static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
@@ -587,6 +781,8 @@ static void __init init_voltagecontroller(void)
 {
 	if (cpu_is_omap34xx())
 		omap3_init_voltagecontroller();
+	else if (cpu_is_omap44xx())
+		omap4_init_voltagecontroller();
 }
 
 /* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
@@ -720,6 +916,14 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 		vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
 		prm_irqst_reg_offs = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
 		ocp_mod = OCP_MOD;
+	} else if (cpu_is_omap44xx()) {
+		vc_cmd_on_shift = OMAP4430_ON_SHIFT;
+		vc_cmd_on_mask = OMAP4430_ON_MASK;
+		if (!strcmp(vdd->voltdm.name, "mpu"))
+			prm_irqst_reg_offs = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET;
+		else
+			prm_irqst_reg_offs = OMAP4_PRM_IRQSTATUS_MPU_OFFSET;
+		ocp_mod = OMAP4430_PRM_OCP_SOCKET_MOD;
 	} else {
 		pr_warning("%s: Voltage scaling not yet enabled for"
 			"this chip\n", __func__);
@@ -1265,12 +1469,15 @@ static int __init omap_voltage_init(void)
 		volt_mod = OMAP3430_GR_MOD;
 		vdd_info = omap3_vdd_info;
 		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
+	} else if (cpu_is_omap44xx()) {
+		volt_mod = OMAP4430_PRM_DEVICE_MOD;
+		vdd_info = omap4_vdd_info;
+		nr_scalable_vdd = OMAP4_NR_SCALABLE_VDD;
 	} else {
 		pr_warning("%s: voltage driver support not added\n", __func__);
 		return 0;
 	}
 
-
 	init_voltagecontroller();
 	for (i = 0; i < nr_scalable_vdd; i++) {
 		vdd_data_configure(&vdd_info[i]);
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 41d6f3d..de5b48e 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -27,6 +27,12 @@ extern struct dentry *pm_dbg_main_dir;
 #define OMAP3_VDD1_SR_CONTROL_REG		0x00
 #define OMAP3_VDD2_SR_CONTROL_REG		0x01
 
+/* Voltage SR parameters for OMAP4 */
+#define OMAP4_SRI2C_SLAVE_ADDR			0x12
+#define OMAP4_VDD_MPU_SR_VOLT_REG		0x55
+#define OMAP4_VDD_IVA_SR_VOLT_REG		0x5B
+#define OMAP4_VDD_CORE_SR_VOLT_REG		0x61
+
 /*
  * Omap3 VP register specific values. Maybe these need to come from
  * board file or PMIC data structure
@@ -56,7 +62,19 @@ extern struct dentry *pm_dbg_main_dir;
 #define OMAP3630_VP2_VLIMITTO_VDDMIN		0x18
 #define OMAP3630_VP2_VLIMITTO_VDDMAX		0x30
 
-/* TODO OMAP4 VP register values if the same file is used for OMAP4*/
+/* OMAP4 VP register values */
+#define OMAP4_VP_CONFIG_ERROROFFSET		0x00
+#define	OMAP4_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x3C
+#define OMAP4_VP_VSTEPMIN_VSTEPMIN		0x1
+#define OMAP4_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x3C
+#define OMAP4_VP_VSTEPMAX_VSTEPMAX		0x04
+#define OMAP4_VP_VLIMITTO_TIMEOUT_US		0x200
+#define OMAP4_VP_MPU_VLIMITTO_VDDMIN		0x18
+#define OMAP4_VP_MPU_VLIMITTO_VDDMAX		0x3C
+#define OMAP4_VP_IVA_VLIMITTO_VDDMIN		0x18
+#define OMAP4_VP_IVA_VLIMITTO_VDDMAX		0x3C
+#define OMAP4_VP_CORE_VLIMITTO_VDDMIN		0x18
+#define OMAP4_VP_CORE_VLIMITTO_VDDMAX		0x30
 
 /**
  * voltagedomain - omap voltage domain global structure
-- 
1.7.0.4

