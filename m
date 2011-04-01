From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 12/13] OMAP3+: voltage domain: move PMIC struct from vdd_info into struct voltagedomain
Date: Fri,  1 Apr 2011 16:41:10 -0700
Message-ID: <1301701271-22096-13-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38399 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306Ab1DAXlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:41:03 -0400
Received: by iyb39 with SMTP id 39so4903476iyb.8
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:56 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Move structure containing PMIC configurable settings into struct
voltagedomain.  In the process, rename from omap_volt_pmic_info to
omap_voltdm_pmic (_info suffix is not helpful.)

No functional changes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   28 ++++++++++++++--------------
 arch/arm/mach-omap2/vc.c       |   29 ++++++++++++++---------------
 arch/arm/mach-omap2/voltage.c  |   29 ++++++++++++-----------------
 arch/arm/mach-omap2/voltage.h  |   12 ++++++------
 arch/arm/mach-omap2/vp.c       |   13 ++++++-------
 5 files changed, 52 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 9428b00..feefd30 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -143,7 +143,7 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 		return DIV_ROUND_UP(uv - 600000, 12500) + 1;
 }
 
-static struct omap_volt_pmic_info omap3_mpu_volt_info = {
+static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
 	.on_volt		= 1200000,
@@ -163,7 +163,7 @@ static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
 
-static struct omap_volt_pmic_info omap3_core_volt_info = {
+static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
 	.on_volt                = 1200000,
@@ -183,7 +183,7 @@ static struct omap_volt_pmic_info omap3_core_volt_info = {
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
 
-static struct omap_volt_pmic_info omap4_mpu_volt_info = {
+static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
 	.on_volt		= 1350000,
@@ -203,7 +203,7 @@ static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
-static struct omap_volt_pmic_info omap4_iva_volt_info = {
+static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
 	.on_volt		= 1100000,
@@ -223,7 +223,7 @@ static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
-static struct omap_volt_pmic_info omap4_core_volt_info = {
+static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
 	.on_volt		= 1100000,
@@ -251,13 +251,13 @@ int __init omap4_twl_init(void)
 		return -ENODEV;
 
 	voltdm = voltdm_lookup("mpu");
-	omap_voltage_register_pmic(voltdm, &omap4_mpu_volt_info);
+	omap_voltage_register_pmic(voltdm, &omap4_mpu_pmic);
 
 	voltdm = voltdm_lookup("iva");
-	omap_voltage_register_pmic(voltdm, &omap4_iva_volt_info);
+	omap_voltage_register_pmic(voltdm, &omap4_iva_pmic);
 
 	voltdm = voltdm_lookup("core");
-	omap_voltage_register_pmic(voltdm, &omap4_core_volt_info);
+	omap_voltage_register_pmic(voltdm, &omap4_core_pmic);
 
 	return 0;
 }
@@ -270,10 +270,10 @@ int __init omap3_twl_init(void)
 		return -ENODEV;
 
 	if (cpu_is_omap3630()) {
-		omap3_mpu_volt_info.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
-		omap3_mpu_volt_info.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
-		omap3_core_volt_info.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
-		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+		omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+		omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+		omap3_core_pmic.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+		omap3_core_pmic.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
 	}
 
 	/*
@@ -289,10 +289,10 @@ int __init omap3_twl_init(void)
 		omap3_twl_set_sr_bit(true);
 
 	voltdm = voltdm_lookup("mpu_iva");
-	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
+	omap_voltage_register_pmic(voltdm, &omap3_mpu_pmic);
 
 	voltdm = voltdm_lookup("core");
-	omap_voltage_register_pmic(voltdm, &omap3_core_volt_info);
+	omap_voltage_register_pmic(voltdm, &omap3_core_pmic);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 1ce7b24..910d02f 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -71,13 +71,13 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	vp_common = vdd->vp_data->vp_common;
 
 	/* Check if sufficient pmic info is available for this vdd */
-	if (!vdd->pmic_info) {
+	if (!voltdm->pmic) {
 		pr_err("%s: Insufficient pmic info to scale the vdd_%s\n",
 			__func__, voltdm->name);
 		return -EINVAL;
 	}
 
-	if (!vdd->pmic_info->uv_to_vsel) {
+	if (!voltdm->pmic->uv_to_vsel) {
 		pr_err("%s: PMIC function to convert voltage in uV to"
 			"vsel not registered. Hence unable to scale voltage"
 			"for vdd_%s\n", __func__, voltdm->name);
@@ -95,7 +95,7 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	if (IS_ERR(volt_data))
 		volt_data = NULL;
 
-	*target_vsel = vdd->pmic_info->uv_to_vsel(target_volt);
+	*target_vsel = voltdm->pmic->uv_to_vsel(target_volt);
 	*current_vsel = voltdm->read(vdd->vp_data->voltage);
 
 	/* Setting the ON voltage to the new target voltage */
@@ -126,8 +126,8 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 
 	smps_steps = abs(target_vsel - current_vsel);
 	/* SMPS slew rate / step size. 2us added as buffer. */
-	smps_delay = ((smps_steps * vdd->pmic_info->step_size) /
-			vdd->pmic_info->slew_rate) + 2;
+	smps_delay = ((smps_steps * voltdm->pmic->step_size) /
+			voltdm->pmic->slew_rate) + 2;
 	udelay(smps_delay);
 
 	vdd->curr_volt = target_volt;
@@ -232,11 +232,10 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
-	struct omap_vdd_info *vdd = voltdm->vdd;
 	u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
 	u32 val;
 
-	if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
+	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
 		pr_err("%s: PMIC info requried to configure vc for"
 			"vdd_%s not populated.Hence cannot initialize vc\n",
 			__func__, voltdm->name);
@@ -252,10 +251,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->cfg_channel = 0;
 
 	/* get PMIC/board specific settings */
-	vc->i2c_slave_addr = vdd->pmic_info->i2c_slave_addr;
-	vc->volt_reg_addr = vdd->pmic_info->volt_reg_addr;
-	vc->cmd_reg_addr = vdd->pmic_info->cmd_reg_addr;
-	vc->setup_time = vdd->pmic_info->volt_setup_time;
+	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
+	vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
+	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
+	vc->setup_time = voltdm->pmic->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -279,10 +278,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->on_volt);
-	onlp_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->onlp_volt);
-	ret_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->ret_volt);
-	off_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->off_volt);
+	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
+	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
+	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
+	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
 	val = ((on_vsel << vc->common->cmd_on_shift) |
 	       (onlp_vsel << vc->common->cmd_onlp_shift) |
 	       (ret_vsel << vc->common->cmd_ret_shift) |
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 7d859f0..d9e619f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -84,20 +84,20 @@ static int __init _config_common_vdd_data(struct voltagedomain *voltdm)
 	vdd->vp_enabled = false;
 
 	vdd->vp_rt_data.vpconfig_erroroffset =
-		(vdd->pmic_info->vp_erroroffset <<
+		(voltdm->pmic->vp_erroroffset <<
 		 vdd->vp_data->vp_common->vpconfig_erroroffset_shift);
 
-	timeout_val = (sys_clk_speed * vdd->pmic_info->vp_timeout_us) / 1000;
+	timeout_val = (sys_clk_speed * voltdm->pmic->vp_timeout_us) / 1000;
 	vdd->vp_rt_data.vlimitto_timeout = timeout_val;
-	vdd->vp_rt_data.vlimitto_vddmin = vdd->pmic_info->vp_vddmin;
-	vdd->vp_rt_data.vlimitto_vddmax = vdd->pmic_info->vp_vddmax;
+	vdd->vp_rt_data.vlimitto_vddmin = voltdm->pmic->vp_vddmin;
+	vdd->vp_rt_data.vlimitto_vddmax = voltdm->pmic->vp_vddmax;
 
-	waittime = ((vdd->pmic_info->step_size / vdd->pmic_info->slew_rate) *
+	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 				sys_clk_speed) / 1000;
 	vdd->vp_rt_data.vstepmin_smpswaittimemin = waittime;
 	vdd->vp_rt_data.vstepmax_smpswaittimemax = waittime;
-	vdd->vp_rt_data.vstepmin_stepmin = vdd->pmic_info->vp_vstepmin;
-	vdd->vp_rt_data.vstepmax_stepmax = vdd->pmic_info->vp_vstepmax;
+	vdd->vp_rt_data.vstepmin_stepmin = voltdm->pmic->vp_vstepmin;
+	vdd->vp_rt_data.vstepmax_stepmax = voltdm->pmic->vp_vstepmax;
 
 	return 0;
 }
@@ -149,10 +149,9 @@ static void __init vdd_debugfs_init(struct voltagedomain *voltdm)
 
 static int __init omap_vdd_data_configure(struct voltagedomain *voltdm)
 {
-	struct omap_vdd_info *vdd = voltdm->vdd;
 	int ret = -EINVAL;
 
-	if (!vdd->pmic_info) {
+	if (!voltdm->pmic) {
 		pr_err("%s: PMIC info requried to configure vdd_%s not"
 			"populated.Hence cannot initialize vdd_%s\n",
 			__func__, voltdm->name, voltdm->name);
@@ -324,24 +323,20 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
  * omap_voltage_register_pmic() - API to register PMIC specific data
  * @voltdm:	pointer to the VDD for which the PMIC specific data is
  *		to be registered
- * @pmic_info:	the structure containing pmic info
+ * @pmic:	the structure containing pmic info
  *
  * This API is to be called by the SOC/PMIC file to specify the
- * pmic specific info as present in omap_volt_pmic_info structure.
+ * pmic specific info as present in omap_voltdm_pmic structure.
  */
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info)
+			       struct omap_voltdm_pmic *pmic)
 {
-	struct omap_vdd_info *vdd;
-
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return -EINVAL;
 	}
 
-	vdd = voltdm->vdd;
-
-	vdd->pmic_info = pmic_info;
+	voltdm->pmic = pmic;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index db08e2a..8b2d951 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -68,6 +68,7 @@ struct voltagedomain {
 	struct list_head pwrdm_list;
 	struct omap_vc_channel *vc;
 	const struct omap_vfsm_instance_data *vfsm;
+	struct omap_voltdm_pmic *pmic;
 
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
@@ -97,13 +98,13 @@ struct omap_volt_data {
 };
 
 /**
- * struct omap_volt_pmic_info - PMIC specific data required by voltage driver.
+ * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
  * @step_size:	PMIC voltage step size (in uv)
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
  */
-struct omap_volt_pmic_info {
+struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
 	u32 on_volt;
@@ -129,7 +130,7 @@ struct omap_volt_pmic_info {
  *
  * @volt_data		: voltage table having the distinct voltages supported
  *			  by the domain and other associated per voltage data.
- * @pmic_info		: pmic specific parameters which should be populted by
+ * @pmic		: pmic specific parameters which should be populted by
  *			  the pmic drivers.
  * @vp_data		: the register values, shifts, masks for various
  *			  vp registers
@@ -145,7 +146,6 @@ struct omap_volt_pmic_info {
  */
 struct omap_vdd_info {
 	struct omap_volt_data *volt_data;
-	struct omap_volt_pmic_info *pmic_info;
 	struct omap_vp_instance_data *vp_data;
 	struct omap_vp_runtime_data vp_rt_data;
 	struct dentry *debug_dir;
@@ -167,13 +167,13 @@ unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info);
+			       struct omap_voltdm_pmic *pmic);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 int omap_voltage_late_init(void);
 #else
 static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info)
+					     struct omap_voltdm_pmic *pmic)
 {
 	return -EINVAL;
 }
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 88ac742..a3afcbe 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -18,7 +18,6 @@ static void vp_latch_vsel(struct voltagedomain *voltdm)
 	u32 vpconfig;
 	unsigned long uvdc;
 	char vsel;
-	struct omap_vdd_info *vdd = voltdm->vdd;
 
 	uvdc = omap_voltage_get_nom_volt(voltdm);
 	if (!uvdc) {
@@ -27,13 +26,13 @@ static void vp_latch_vsel(struct voltagedomain *voltdm)
 		return;
 	}
 
-	if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
+	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
 		pr_warning("%s: PMIC function to convert voltage in uV to"
 			" vsel not registered\n", __func__);
 		return;
 	}
 
-	vsel = vdd->pmic_info->uv_to_vsel(uvdc);
+	vsel = voltdm->pmic->uv_to_vsel(uvdc);
 
 	vpconfig = voltdm->read(vp->vpconfig);
 	vpconfig &= ~(vp->vp_common->vpconfig_initvoltage_mask |
@@ -206,13 +205,13 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 
 	curr_vsel = voltdm->read(vp->voltage);
 
-	if (!vdd->pmic_info || !vdd->pmic_info->vsel_to_uv) {
+	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
 		pr_warning("%s: PMIC function to convert vsel to voltage"
 			"in uV not registerd\n", __func__);
 		return 0;
 	}
 
-	return vdd->pmic_info->vsel_to_uv(curr_vsel);
+	return voltdm->pmic->vsel_to_uv(curr_vsel);
 }
 
 /**
@@ -323,13 +322,13 @@ static int vp_volt_debug_get(void *data, u64 *val)
 
 	vsel = voltdm->read(vp->voltage);
 
-	if (!vdd->pmic_info->vsel_to_uv) {
+	if (!voltdm->pmic->vsel_to_uv) {
 		pr_warning("PMIC function to convert vsel to voltage"
 			"in uV not registerd\n");
 		return -EINVAL;
 	}
 
-	*val = vdd->pmic_info->vsel_to_uv(vsel);
+	*val = voltdm->pmic->vsel_to_uv(vsel);
 	return 0;
 }
 
-- 
1.7.4

