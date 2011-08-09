From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 3/3] OMAP2+: voltage: clean up error messages
Date: Tue,  9 Aug 2011 18:34:21 +0200
Message-ID: <1312907661-24436-3-git-send-email-jhovold@gmail.com>
References: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1HIQen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 12:34:43 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so192442fxh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 09:34:43 -0700 (PDT)
In-Reply-To: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Clean up error messages by adding missing whitespace, reducing excessive
verbosity, and fixing a few language issues.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-omap2/voltage.c |   51 ++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 9ef3789..0b460b9 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -104,7 +104,7 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
 	 */
 	sys_ck = clk_get(NULL, sys_ck_name);
 	if (IS_ERR(sys_ck)) {
-		pr_warning("%s: Could not get the sys clk to calculate"
+		pr_warning("%s: Could not get the sys clk to calculate "
 			"various vdd_%s params\n", __func__, vdd->voltdm.name);
 		return -EINVAL;
 	}
@@ -143,14 +143,14 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	u8 vsel;
 
 	if (!vdd) {
-		pr_warning("Wrong paramater passed\n");
+		pr_warning("Wrong parameter passed\n");
 		return -EINVAL;
 	}
 
 	vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
-		pr_warning("PMIC function to convert vsel to voltage"
+		pr_warning("PMIC function to convert vsel to voltage "
 			"in uV not registerd\n");
 		return -EINVAL;
 	}
@@ -164,7 +164,7 @@ static int nom_volt_debug_get(void *data, u64 *val)
 	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
 
 	if (!vdd) {
-		pr_warning("Wrong paramater passed\n");
+		pr_warning("Wrong parameter passed\n");
 		return -EINVAL;
 	}
 
@@ -312,15 +312,14 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 
 	/* Check if suffiecient pmic info is available for this vdd */
 	if (!vdd->pmic_info) {
-		pr_err("%s: Insufficient pmic info to scale the vdd_%s\n",
+		pr_err("%s: No PMIC info for vdd_%s\n",
 			__func__, vdd->voltdm.name);
 		return -EINVAL;
 	}
 
 	if (!vdd->pmic_info->uv_to_vsel) {
-		pr_err("%s: PMIC function to convert voltage in uV to"
-			"vsel not registered. Hence unable to scale voltage"
-			"for vdd_%s\n", __func__, vdd->voltdm.name);
+		pr_err("%s: No PMIC function to convert voltage in uV to "
+			"vsel for vdd_%s\n", __func__, vdd->voltdm.name);
 		return -ENODATA;
 	}
 
@@ -452,7 +451,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 		udelay(1);
 	}
 	if (timeout >= VP_TRANXDONE_TIMEOUT) {
-		pr_warning("%s: vdd_%s TRANXDONE timeout exceeded."
+		pr_warning("%s: vdd_%s TRANXDONE timeout exceeded. "
 			"Voltage change aborted", __func__, vdd->voltdm.name);
 		return -ETIMEDOUT;
 	}
@@ -483,7 +482,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 			   vdd->vp_data->prm_irqst_data->tranxdone_status),
 			  VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
-		pr_err("%s: vdd_%s TRANXDONE timeout exceeded."
+		pr_err("%s: vdd_%s TRANXDONE timeout exceeded. "
 			"TRANXDONE never got set after the voltage update\n",
 			__func__, vdd->voltdm.name);
 
@@ -505,7 +504,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
 		pr_warning("%s: vdd_%s TRANXDONE timeout exceeded while trying"
-			"to clear the TRANXDONE status\n",
+			" to clear the TRANXDONE status\n",
 			__func__, vdd->voltdm.name);
 
 	vpconfig = vdd->read_reg(prm_mod_offs, vdd->vp_data->vpconfig);
@@ -599,8 +598,7 @@ static void __init omap_vc_init(struct omap_vdd_info *vdd)
 	u32 vc_val;
 
 	if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
-		pr_err("%s: PMIC info requried to configure vc for"
-			"vdd_%s not populated.Hence cannot initialize vc\n",
+		pr_err("%s: No PMIC info for vdd_%s\n",
 			__func__, vdd->voltdm.name);
 		return;
 	}
@@ -645,9 +643,8 @@ static int __init omap_vdd_data_configure(struct omap_vdd_info *vdd)
 	int ret = -EINVAL;
 
 	if (!vdd->pmic_info) {
-		pr_err("%s: PMIC info requried to configure vdd_%s not"
-			"populated.Hence cannot initialize vdd_%s\n",
-			__func__, vdd->voltdm.name, vdd->voltdm.name);
+		pr_err("%s: No PMIC info for vdd_%s\n",
+			__func__, vdd->voltdm.name);
 		goto ovdc_out;
 	}
 
@@ -716,8 +713,8 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 	curr_vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
 
 	if (!vdd->pmic_info || !vdd->pmic_info->vsel_to_uv) {
-		pr_warning("%s: PMIC function to convert vsel to voltage"
-			"in uV not registerd\n", __func__);
+		pr_warning("%s: No PMIC function to convert vsel to uV "
+				"for vdd_%s\n", __func__, voltdm->name);
 		return 0;
 	}
 
@@ -788,7 +785,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 
 	/* If VP is already disabled, do nothing. Return */
 	if (!vdd->vp_enabled) {
-		pr_warning("%s: Trying to disable VP for vdd_%s when"
+		pr_warning("%s: Trying to disable VP for vdd_%s when "
 			"it is already disabled\n", __func__, voltdm->name);
 		return;
 	}
@@ -805,7 +802,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 				VP_IDLE_TIMEOUT, timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
-		pr_warning("%s: vdd_%s idle timedout\n",
+		pr_warning("%s: vdd_%s idle timeout\n",
 			__func__, voltdm->name);
 
 	vdd->vp_enabled = false;
@@ -937,7 +934,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 			return &vdd->volt_data[i];
 	}
 
-	pr_notice("%s: Unable to match the current voltage with the voltage"
+	pr_notice("%s: Unable to match the current voltage with the voltage "
 		"table for vdd_%s\n", __func__, voltdm->name);
 
 	return ERR_PTR(-ENODATA);
@@ -1024,8 +1021,8 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		vdd->volt_scale = vc_bypass_scale_voltage;
 		return;
 	default:
-		pr_warning("%s: Trying to change the method of voltage scaling"
-			"to an unsupported one!\n", __func__);
+		pr_warning("%s: Voltage scale method not supported\n",
+				__func__);
 	}
 }
 
@@ -1043,13 +1040,12 @@ struct voltagedomain *omap_voltage_domain_lookup(char *name)
 	int i;
 
 	if (!vdd_info) {
-		pr_err("%s: Voltage driver init not yet happened.Faulting!\n",
-			__func__);
+		pr_err("%s: Voltage driver not initialised\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!name) {
-		pr_err("%s: No name to get the votage domain!\n", __func__);
+		pr_err("%s: Missing voltage-domain name\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1073,8 +1069,7 @@ int __init omap_voltage_late_init(void)
 	int i;
 
 	if (!vdd_info) {
-		pr_err("%s: Voltage driver support not added\n",
-			__func__);
+		pr_err("%s: Voltage driver support not added\n", __func__);
 		return -EINVAL;
 	}
 
-- 
1.7.6

