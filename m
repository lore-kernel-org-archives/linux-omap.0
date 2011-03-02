From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 05/18] omap3+: voltage: use volt_data pointer instead values
Date: Wed,  2 Mar 2011 16:25:18 +0530
Message-ID: <1299063331-27968-6-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51143 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757120Ab1CBK42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:56:28 -0500
Received: by mail-yx0-f175.google.com with SMTP id 22so2352988yxn.6
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:56:26 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Voltage values can get confusing in meaning with various Smartreflex
classes being active.  Depending on the class used, the actual voltage
selected might be a variant. For example:
with SmartReflex AVS class 3:
a) if we dont have SR enabled, we will go to volt_nominal
b) if have SR enabled, we go to volt_nominal, then enable SR and
   expect it to adjust voltage. We dont really care about the
   resultant voltage
Essentially, when we ask voltage layer to scale to voltage x for OPP
y, it always means x is the nominal voltage for OPP y.

Now, once we introduce SmartReflex AVS class 1.5:
a) If you are booting for the first time OR if you never enable SR
   before, we always go to volt_nominal
b) If you enable SR and the OPP is calibrated, we will not enable SR
   again when that OPP is accessed anymore, but when we set voltage for
   an OPP, the voltage achieved will be volt_calibrated
c) If recalibration timeout triggers,or SR is disabled after a
   calibration, the calibrated values are not valid anymore, at this point,
   setting the voltage will mean volt_dynamic_nominal.
So, depending on which state the system is at, voltage for that OPP
we are setting has not 1 single value anymore, but 3 possible valid
values.

For upper layers(dvfs/cpufreq OMAP SoC layers) to use voltage values, it
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
 arch/arm/mach-omap2/pm.c                  |    3 +-
 arch/arm/mach-omap2/smartreflex-class3.c  |    3 +-
 arch/arm/mach-omap2/voltage.c             |   77 ++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/voltage.h |   13 ++++-
 4 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d5a102c..669998b 100644
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
index 60e7055..2195668 100644
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
index 3ee8a80..50a6913 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -146,14 +146,14 @@ struct omap_vdd_info {
 	struct vc_reg_info vc_reg;
 	struct voltagedomain voltdm;
 	struct dentry *debug_dir;
-	u32 curr_volt;
+	struct omap_volt_data *curr_volt;
 	u16 ocp_mod;
 	u8 prm_irqst_reg;
 	bool vp_enabled;
 	u32 (*read_reg) (u16 mod, u8 offset);
 	void (*write_reg) (u32 val, u16 mod, u8 offset);
 	int (*volt_scale) (struct omap_vdd_info *vdd,
-		unsigned long target_volt);
+		struct omap_volt_data *target_volt);
 };
 
 static struct omap_vdd_info *vdd_info;
@@ -361,13 +361,20 @@ static int vp_volt_debug_get(void *data, u64 *val)
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
@@ -382,7 +389,8 @@ static void vp_latch_vsel(struct omap_vdd_info *vdd)
 	unsigned long uvdc;
 	char vsel;
 
-	uvdc = omap_voltage_get_nom_volt(&vdd->voltdm);
+	uvdc = omap_get_operation_voltage(
+			omap_voltage_get_nom_volt(&vdd->voltdm));
 	if (!uvdc) {
 		pr_warning("%s: unable to find current voltage for vdd_%s\n",
 			__func__, vdd->voltdm.name);
@@ -505,12 +513,18 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 
 /* Voltage scale and accessory APIs */
 static int _pre_volt_scale(struct omap_vdd_info *vdd,
-		unsigned long target_volt, u8 *target_vsel, u8 *current_vsel)
+		struct omap_volt_data *target_volt, u8 *target_vsel,
+		u8 *current_vsel)
 {
-	struct omap_volt_data *volt_data;
 	u32 vc_cmdval, vp_errgain_val;
 	u16 vp_mod, vc_mod;
 
+	if (IS_ERR_OR_NULL(target_volt) || IS_ERR_OR_NULL(vdd) ||
+			!target_vsel || !current_vsel) {
+		pr_err("%s: invalid parms!\n", __func__);
+		return -EINVAL;
+	}
+
 	/* Check if suffiecient pmic info is available for this vdd */
 	if (!vdd->pmic_info) {
 		pr_err("%s: Insufficient pmic info to scale the vdd_%s\n",
@@ -534,12 +548,8 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 	vp_mod = vdd->vp_reg.prm_mod;
 	vc_mod = vdd->vc_reg.prm_mod;
 
-	/* Get volt_data corresponding to target_volt */
-	volt_data = omap_voltage_get_voltdata(&vdd->voltdm, target_volt);
-	if (IS_ERR(volt_data))
-		volt_data = NULL;
-
-	*target_vsel = vdd->pmic_info->uv_to_vsel(target_volt);
+	*target_vsel = vdd->pmic_info->uv_to_vsel(
+			omap_get_operation_voltage(target_volt));
 	*current_vsel = vdd->read_reg(vp_mod, vdd->vp_offs.voltage);
 
 	/* Setting the ON voltage to the new target voltage */
@@ -549,22 +559,21 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 	vdd->write_reg(vc_cmdval, vc_mod, vdd->vc_reg.cmdval_reg);
 
 	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
-		vp_errgain_val = vdd->read_reg(vp_mod,
-				vdd->vp_offs.vpconfig);
-		vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
-		vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
-		vp_errgain_val |= vdd->vp_reg.vpconfig_errorgain <<
-				vdd->vp_reg.vpconfig_errorgain_shift;
-		vdd->write_reg(vp_errgain_val, vp_mod,
-				vdd->vp_offs.vpconfig);
-	}
+	vp_errgain_val = vdd->read_reg(vp_mod,
+			vdd->vp_offs.vpconfig);
+	vdd->vp_reg.vpconfig_errorgain = target_volt->vp_errgain;
+	vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
+	vp_errgain_val |= vdd->vp_reg.vpconfig_errorgain <<
+			vdd->vp_reg.vpconfig_errorgain_shift;
+	vdd->write_reg(vp_errgain_val, vp_mod,
+			vdd->vp_offs.vpconfig);
 
 	return 0;
 }
 
 static void _post_volt_scale(struct omap_vdd_info *vdd,
-		unsigned long target_volt, u8 target_vsel, u8 current_vsel)
+		struct omap_volt_data *target_volt, u8 target_vsel,
+		u8 current_vsel)
 {
 	u32 smps_steps = 0, smps_delay = 0;
 
@@ -579,7 +588,7 @@ static void _post_volt_scale(struct omap_vdd_info *vdd,
 
 /* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
 static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
-		unsigned long target_volt)
+		struct omap_volt_data *target_volt)
 {
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
@@ -632,7 +641,7 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 
 /* VP force update method of voltage scaling */
 static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
-		unsigned long target_volt)
+		struct omap_volt_data *target_volt)
 {
 	u32 vpconfig;
 	u16 mod, ocp_mod;
@@ -1118,16 +1127,15 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
  * omap_voltage_get_nom_volt() - Gets the current non-auto-compensated voltage
  * @voltdm:	pointer to the VDD for which current voltage info is needed
  *
- * API to get the current non-auto-compensated voltage for a VDD.
- * Returns 0 in case of error else returns the current voltage for the VDD.
+ * API to get the current non-auto-compensated voltage data pointer for a VDD.
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
@@ -1269,18 +1277,19 @@ void omap_vp_disable(struct voltagedomain *voltdm)
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
 
-	if (!voltdm || IS_ERR(voltdm)) {
-		pr_warning("%s: VDD specified does not exist!\n", __func__);
+	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(target_volt)) {
+		pr_warning("%s: Bad Params vdm=%p tv=%p!\n", __func__,
+				voltdm, target_volt);
 		return -EINVAL;
 	}
 
@@ -1306,7 +1315,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
  */
 void omap_voltage_reset(struct voltagedomain *voltdm)
 {
-	unsigned long target_uvdc;
+	struct omap_volt_data *target_uvdc;
 
 	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 4d9bab1..00fcfb4 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -117,13 +117,13 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
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
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
@@ -152,4 +152,13 @@ static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
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

