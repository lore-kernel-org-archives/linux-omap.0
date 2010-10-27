From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Wed, 27 Oct 2010 21:40:54 +0530
Message-ID: <1288195856-11011-8-git-send-email-thara@ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38077 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760918Ab0J0QLJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 12:11:09 -0400
In-Reply-To: <1288195856-11011-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds debug support to the voltage and smartreflex drivers.
This means a whole bunch of voltage processor and smartreflex
parameters are now visible through the pm debugfs.
The voltage parameters can be viewed at
        /debug/voltage/vdd_<x>/<parameter>
and the smartreflex parameters can be viewed at
        /debug/vdd_<x>/smartreflex/<parameter>

To enable overriding of these parameters from user side, write 1
into
	/debug/voltage/vdd_<x>/override_volt_params

where <x> is mpu or core for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c         |   34 ++++-
 arch/arm/mach-omap2/voltage.c             |  219 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |    1 +
 3 files changed, 248 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c24ae54..2669584 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -555,8 +555,13 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 		return -ENODATA;
 	}
 
-	/* errminlimit is opp dependent and hence linked to voltage */
-	sr->err_minlimit = volt_data->sr_errminlimit;
+	/*
+	 * errminlimit is opp dependent and hence linked to voltage.
+	 * If the override option is enabled, the user might have over ridden
+	 * this parameter, so do not get it from voltage table.
+	 */
+	if (!omap_voltage_override_params(voltdm))
+		sr->err_minlimit = volt_data->sr_errminlimit;
 
 	pm_runtime_get_sync(&sr->pdev->dev);
 
@@ -804,9 +809,28 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	return 0;
 }
 
+static int omap_sr_params_show(void *data, u64 *val)
+{
+	u32 *param = data;
+
+	*val = *param;
+	return 0;
+}
+
+static int omap_sr_params_store(void *data, u64 val)
+{
+	u32 *option = data;
+
+	*option = val;
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 		omap_sr_autocomp_store, "%llu\n");
 
+DEFINE_SIMPLE_ATTRIBUTE(sr_params_fops, omap_sr_params_show,
+		omap_sr_params_store, "%llu\n");
+
 static int __init omap_sr_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
@@ -889,6 +913,12 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
 				(void *)sr_info, &pm_sr_fops);
+	(void) debugfs_create_file("errweight", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_weight, &sr_params_fops);
+	(void) debugfs_create_file("errmaxlimit", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_maxlimit, &sr_params_fops);
+	(void) debugfs_create_file("errminlimit", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_minlimit, &sr_params_fops);
 
 	return ret;
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 5aa5109..ac81ace 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -110,6 +110,7 @@ struct omap_vdd_info{
 	u32 curr_volt;
 	u8 cmdval_reg;
 	u8 vdd_sr_reg;
+	bool user_override_params;
 };
 
 static struct omap_vdd_info *vdd_info;
@@ -228,6 +229,115 @@ static inline void voltage_write_reg(u8 offset, u32 value)
 	prm_write_mod_reg(value, volt_mod, offset);
 }
 
+/* Voltage debugfs support */
+static int vp_debug_get(void *data, u64 *val)
+{
+	u16 *option = data;
+
+	if (!option) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = *option;
+
+	return 0;
+}
+
+static int vp_debug_set(void *data, u64 val)
+{
+	u32 *option = data;
+
+	if (!option) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*option = val;
+
+	return 0;
+}
+
+static int volt_params_override_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = vdd->user_override_params;
+
+	return 0;
+}
+
+static int volt_params_override_set(void *data, u64 val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	 if (val && (val != 1)) {
+		pr_warning("Invalid argument %lld\n", val);
+		return -EINVAL;
+	 }
+
+	 if (!val)
+		vdd->user_override_params = false;
+	 else
+		vdd->user_override_params = true;
+
+	 return 0;
+}
+
+static int vp_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+	u8 vsel;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	vsel = voltage_read_reg(vdd->vp_offs.voltage);
+	pr_notice("curr_vsel = %x\n", vsel);
+
+	if (!volt_pmic_info.vsel_to_uv) {
+		pr_warning("PMIC function to convert vsel to voltage"
+			"in uV not registerd\n");
+		return -EINVAL;
+	}
+
+	*val = volt_pmic_info.vsel_to_uv(vsel);
+	return 0;
+}
+
+static int nom_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = omap_voltage_get_nom_volt(&vdd->voltdm);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vp_debug_fops, vp_debug_get, vp_debug_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(volt_override_fops, volt_params_override_get,
+				volt_params_override_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
+								"%llu\n");
+
 static void vp_latch_vsel(struct omap_vdd_info *vdd)
 {
 	u32 vpconfig;
@@ -467,7 +577,49 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 		pr_warning("%s: Unable to create debugfs directory for"
 			"vdd_%s\n", __func__, vdd->voltdm.name);
 		vdd->debug_dir = NULL;
+		return;
 	}
+
+	(void) debugfs_create_file("vp_errorgain", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vpconfig_errorgain),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemin", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vstepmin_smpswaittimemin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmin", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vstepmin_stepmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemax", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vstepmax_smpswaittimemax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmax", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vstepmax_stepmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmax", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vlimitto_vddmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmin", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vlimitto_vddmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_timeout", S_IRUGO | S_IWUGO,
+				vdd->debug_dir,
+				&(vdd->vp_reg.vlimitto_timeout),
+				&vp_debug_fops);
+	(void) debugfs_create_file("override_volt_params", S_IRUGO | S_IWUGO,
+				vdd->debug_dir, (void *) vdd,
+				&volt_override_fops);
+	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd->debug_dir,
+				(void *) vdd, &vp_volt_debug_fops);
+	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
+				vdd->debug_dir, (void *) vdd,
+				&nom_volt_debug_fops);
 }
 
 /* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
@@ -531,8 +683,11 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
 
-	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
+	/*
+	 * Setting vp errorgain based on the voltage If enabled allow
+	 * the override of errorgain from user side.
+	 */
+	if (!vdd->user_override_params && vdd->volt_data) {
 		vp_errgain_val = voltage_read_reg(vdd->vp_offs.vpconfig);
 		vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
 		vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
@@ -637,8 +792,11 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
 
-	/* Getting  vp errorgain based on the voltage */
-	if (volt_data)
+	/*
+	 * Getting vp errorgain based on the voltage If enabled allow
+	 * the override of errorgain from user side.
+	 */
+	if (!vdd->user_override_params && vdd->volt_data)
 		vdd->vp_reg.vpconfig_errorgain =
 					volt_data->vp_errgain;
 
@@ -813,6 +971,37 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	if (!voltscale_vpforceupdate)
 		vp_latch_vsel(vdd);
 
+	/*
+	 * If override option is enabled, it is likely that the
+	 * following parameters were set from user space so rewrite them.
+	 */
+	if (vdd->user_override_params) {
+		vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
+		vpconfig |= (vdd->vp_reg.vpconfig_errorgain <<
+			vdd->vp_reg.vpconfig_errorgain_shift);
+		voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
+
+		voltage_write_reg(vdd->vp_offs.vstepmin,
+			(vdd->vp_reg.vstepmin_smpswaittimemin <<
+			vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
+			(vdd->vp_reg.vstepmin_stepmin <<
+			vdd->vp_reg.vstepmin_stepmin_shift));
+
+		voltage_write_reg(vdd->vp_offs.vstepmax,
+			(vdd->vp_reg.vstepmax_smpswaittimemax <<
+			vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
+			(vdd->vp_reg.vstepmax_stepmax <<
+			vdd->vp_reg.vstepmax_stepmax_shift));
+
+		voltage_write_reg(vdd->vp_offs.vlimitto,
+			(vdd->vp_reg.vlimitto_vddmax <<
+			vdd->vp_reg.vlimitto_vddmax_shift) |
+			(vdd->vp_reg.vlimitto_vddmin <<
+			vdd->vp_reg.vlimitto_vddmin_shift) |
+			(vdd->vp_reg.vlimitto_timeout <<
+			vdd->vp_reg.vlimitto_timeout_shift));
+	}
+
 	/* Enable VP */
 	vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
 	voltage_write_reg(vdd->vp_offs.vpconfig,
@@ -1073,6 +1262,28 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm)
 }
 
 /**
+ * omap_voltage_override_params() - API to return whether user wants
+ *					to override voltage params or not.
+ * @voltdm:	pointer to the VDD
+ *
+ * This API returns back the value of the flag user_override_params for
+ * a particular voltage domain indicating whether user wants to over ride
+ * various voltage parameters from user-space or not.
+ */
+bool omap_voltage_override_params(struct voltagedomain *voltdm)
+{
+	struct omap_vdd_info *vdd;
+
+	if (!voltdm || IS_ERR(voltdm)) {
+		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		return false;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+	return vdd->user_override_params;
+}
+
+/**
  * omap_voltage_register_pmic() - API to register PMIC specific data
  * @pmic_info:	the structure containing pmic info
  *
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index ecd7352..5677544 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -127,6 +127,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
 unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
+bool omap_voltage_override_params(struct voltagedomain *voltdm);
 #ifdef CONFIG_PM
 void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
 void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
-- 
1.7.0.4

