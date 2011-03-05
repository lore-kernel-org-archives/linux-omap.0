From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 06/19] OMAP3+: voltage: use volt_data pointer instead values
Date: Sat,  5 Mar 2011 20:59:09 +0530
Message-ID: <1299338962-5602-7-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48799 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572Ab1CEPal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:30:41 -0500
Received: by yxk30 with SMTP id 30so1242060yxk.3
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:30:39 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Voltage values can get confusing in meaning with various SmartReflex
classes being active. Depending on the class used, the actual voltage
selected might be a variant. For example:
With SmartReflex AVS class 3:
a) If we don't have SR enabled, we will go to volt_nominal.
b) If have SR enabled, we go to volt_nominal, then enable SR and
   expect it to adjust voltage. We don't really care about the
   resultant voltage.
Essentially, when we ask voltage layer to scale to voltage x for OPP
y, it always means x is the nominal voltage for OPP y.

Now, once we introduce SmartReflex AVS class 1.5:
a) If you are booting for the first time OR if you never enabled SR
   before, we always go to volt_nominal.
b) If you enable SR and the OPP is calibrated, we will not enable SR
   again when that OPP is accessed anymore, but when we set voltage for
   an OPP, the voltage achieved will be volt_calibrated.
c) If recalibration timeout triggers or SR is disabled after a
   calibration, the calibrated values are not valid anymore, at this point,
   setting the voltage will mean volt_dynamic_nominal.
So, depending on which state the system is at, voltage for that OPP
we are setting has not 1 single value anymore, but 3 possible valid
values.

For upper layers(DVFS/cpufreq OMAP SoC layers) to use voltage values, it
will need to know which type of voltage AVS strategy is being used and
the corresponding system state from voltage layer perspective. This
would replicate the role of voltage layer, SmartReflex AVS in the upper
layers and make the corresponding implementations complex.

Since each voltage domain contains a set of volt_data structs representing
a voltage point that is supported for that domain, volt_data is a more
accurate representation of the voltage point we are interested in going to,
and the actual translation of this voltage point to the voltage value is
done inside the voltage layer. Doing this allows the users of the voltage
layer to be blissfully ignorant of any complexity of the underneath
layers and simplify the implementation of dependent layers.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.c                 |    3 +-
 arch/arm/mach-omap2/smartreflex-class3.c |    3 +-
 arch/arm/mach-omap2/voltage.c            |   75 +++++++++++++++++-------------
 arch/arm/mach-omap2/voltage.h            |   17 +++++--
 4 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 2c3a253..2372744 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -209,7 +209,8 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 		goto exit;
 	}
 
-	omap_voltage_scale_vdd(voltdm, bootup_volt);
+	omap_voltage_scale_vdd(voltdm,
+			omap_voltage_get_voltdata(voltdm, bootup_volt));
 	return 0;
 
 exit:
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index f438cf4..2ee48af 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -15,7 +15,8 @@
 
 static int sr_class3_enable(struct voltagedomain *voltdm)
 {
-	unsigned long volt = omap_voltage_get_nom_volt(voltdm);
+	unsigned long volt = omap_get_operation_voltage(
+		omap_voltage_get_nom_volt(voltdm));
 
 	if (!volt) {
 		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 76bcaee..a12ac1e 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -58,7 +58,7 @@ static struct dentry *voltage_dir;
 
 /* Init function pointers */
 static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
-					unsigned long target_volt);
+					struct omap_volt_data *target_volt);
 
 static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
 {
@@ -164,13 +164,20 @@ static int vp_volt_debug_get(void *data, u64 *val)
 static int nom_volt_debug_get(void *data, u64 *val)
 {
 	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+	struct omap_volt_data *volt_data;
 
 	if (!vdd) {
 		pr_warning("Wrong paramater passed\n");
 		return -EINVAL;
 	}
 
-	*val = omap_voltage_get_nom_volt(&vdd->voltdm);
+	volt_data = omap_voltage_get_nom_volt(&vdd->voltdm);
+	if (IS_ERR_OR_NULL(volt_data)) {
+		pr_warning("%s: No voltage/domain?\n", __func__);
+		return -ENODEV;
+	}
+
+	*val = volt_data->volt_nominal;
 
 	return 0;
 }
@@ -184,7 +191,8 @@ static void vp_latch_vsel(struct omap_vdd_info *vdd)
 	unsigned long uvdc;
 	char vsel;
 
-	uvdc = omap_voltage_get_nom_volt(&vdd->voltdm);
+	uvdc = omap_get_operation_voltage(
+			omap_voltage_get_nom_volt(&vdd->voltdm));
 	if (!uvdc) {
 		pr_warning("%s: unable to find current voltage for vdd_%s\n",
 			__func__, vdd->voltdm.name);
@@ -302,13 +310,19 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 
 /* Voltage scale and accessory APIs */
 static int _pre_volt_scale(struct omap_vdd_info *vdd,
-		unsigned long target_volt, u8 *target_vsel, u8 *current_vsel)
+		struct omap_volt_data *target_volt, u8 *target_vsel,
+		u8 *current_vsel)
 {
-	struct omap_volt_data *volt_data;
 	const struct omap_vc_common_data *vc_common;
 	const struct omap_vp_common_data *vp_common;
 	u32 vc_cmdval, vp_errgain_val;
 
+	if (IS_ERR_OR_NULL(target_volt) || IS_ERR_OR_NULL(vdd) ||
+			!target_vsel || !current_vsel) {
+		pr_err("%s: invalid parms!\n", __func__);
+		return -EINVAL;
+	}
+
 	vc_common = vdd->vc_data->vc_common;
 	vp_common = vdd->vp_data->vp_common;
 
@@ -332,12 +346,8 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 		return -EINVAL;
 	}
 
-	/* Get volt_data corresponding to target_volt */
-	volt_data = omap_voltage_get_voltdata(&vdd->voltdm, target_volt);
-	if (IS_ERR(volt_data))
-		volt_data = NULL;
-
-	*target_vsel = vdd->pmic_info->uv_to_vsel(target_volt);
+	*target_vsel = vdd->pmic_info->uv_to_vsel(
+			omap_get_operation_voltage(target_volt));
 	*current_vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
 
 	/* Setting the ON voltage to the new target voltage */
@@ -347,22 +357,21 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 	vdd->write_reg(vc_cmdval, prm_mod_offs, vdd->vc_data->cmdval_reg);
 
 	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
-		vp_errgain_val = vdd->read_reg(prm_mod_offs,
-					       vdd->vp_data->vpconfig);
-		vdd->vp_rt_data.vpconfig_errorgain = volt_data->vp_errgain;
-		vp_errgain_val &= ~vp_common->vpconfig_errorgain_mask;
-		vp_errgain_val |= vdd->vp_rt_data.vpconfig_errorgain <<
-			vp_common->vpconfig_errorgain_shift;
-		vdd->write_reg(vp_errgain_val, prm_mod_offs,
-			       vdd->vp_data->vpconfig);
-	}
+	vp_errgain_val = vdd->read_reg(prm_mod_offs,
+				       vdd->vp_data->vpconfig);
+	vdd->vp_rt_data.vpconfig_errorgain = target_volt->vp_errgain;
+	vp_errgain_val &= ~vp_common->vpconfig_errorgain_mask;
+	vp_errgain_val |= vdd->vp_rt_data.vpconfig_errorgain <<
+		vp_common->vpconfig_errorgain_shift;
+	vdd->write_reg(vp_errgain_val, prm_mod_offs,
+		       vdd->vp_data->vpconfig);
 
 	return 0;
 }
 
 static void _post_volt_scale(struct omap_vdd_info *vdd,
-		unsigned long target_volt, u8 target_vsel, u8 current_vsel)
+		struct omap_volt_data *target_volt, u8 target_vsel,
+		u8 current_vsel)
 {
 	u32 smps_steps = 0, smps_delay = 0;
 
@@ -377,7 +386,7 @@ static void _post_volt_scale(struct omap_vdd_info *vdd,
 
 /* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
 static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
-		unsigned long target_volt)
+		struct omap_volt_data *target_volt)
 {
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
@@ -429,7 +438,7 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 
 /* VP force update method of voltage scaling */
 static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
-		unsigned long target_volt)
+		struct omap_volt_data *target_volt)
 {
 	u32 vpconfig;
 	u8 target_vsel, current_vsel, prm_irqst_reg;
@@ -675,16 +684,15 @@ ovdc_out:
  * omap_voltage_get_nom_volt() - Gets the current non-auto-compensated voltage
  * @voltdm:	pointer to the VDD for which current voltage info is needed
  *
- * API to get the current non-auto-compensated voltage for a VDD.
- * Returns 0 in case of error else returns the current voltage for the VDD.
+ * API to get the current voltage data pointer for a VDD.
  */
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
+struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd;
 
 	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
-		return 0;
+		return ERR_PTR(-ENODATA);
 	}
 
 	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
@@ -819,18 +827,19 @@ void omap_vp_disable(struct voltagedomain *voltdm)
  * omap_voltage_scale_vdd() - API to scale voltage of a particular
  *				voltage domain.
  * @voltdm:	pointer to the VDD which is to be scaled.
- * @target_volt:	The target voltage of the voltage domain
+ * @target_volt:	The target voltage data for the voltage domain
  *
  * This API should be called by the kernel to do the voltage scaling
  * for a particular voltage domain during dvfs or any other situation.
  */
 int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
-		unsigned long target_volt)
+		struct omap_volt_data *target_volt)
 {
 	struct omap_vdd_info *vdd;
 
-	if (IS_ERR_OR_NULL(voltdm)) {
-		pr_warning("%s: VDD specified does not exist!\n", __func__);
+	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(target_volt)) {
+		pr_warning("%s: Bad Params vdm=%p tv=%p!\n", __func__,
+				voltdm, target_volt);
 		return -EINVAL;
 	}
 
@@ -856,7 +865,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
  */
 void omap_voltage_reset(struct voltagedomain *voltdm)
 {
-	unsigned long target_uvdc;
+	struct omap_volt_data *target_uvdc;
 
 	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index e9f5408..6e9acd6 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -131,25 +131,25 @@ struct omap_vdd_info {
 	const struct omap_vfsm_instance_data *vfsm;
 	struct voltagedomain voltdm;
 	struct dentry *debug_dir;
-	u32 curr_volt;
+	struct omap_volt_data *curr_volt;
 	bool vp_enabled;
 	u32 (*read_reg) (u16 mod, u8 offset);
 	void (*write_reg) (u32 val, u16 mod, u8 offset);
 	int (*volt_scale) (struct omap_vdd_info *vdd,
-		unsigned long target_volt);
+		struct omap_volt_data *target_volt);
 };
 
 unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
 int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
-		unsigned long target_volt);
+		struct omap_volt_data *target_volt);
 void omap_voltage_reset(struct voltagedomain *voltdm);
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
 				   struct omap_vdd_info *omap_vdd_array[],
@@ -181,4 +181,13 @@ static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
 }
 #endif
 
+/* convert volt data to the voltage for the voltage data */
+static inline unsigned long omap_get_operation_voltage(
+		struct omap_volt_data *vdata)
+{
+	if (IS_ERR_OR_NULL(vdata))
+		return 0;
+	return vdata->volt_nominal;
+}
+
 #endif
-- 
1.7.1

