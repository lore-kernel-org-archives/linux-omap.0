From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 04/18] omap3+: voltage: use IS_ERR_OR_NULL
Date: Wed,  2 Mar 2011 16:25:17 +0530
Message-ID: <1299063331-27968-5-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33170 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757108Ab1CBK4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:56:18 -0500
Received: by mail-yw0-f51.google.com with SMTP id 4so2564444ywg.24
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:56:17 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Use IS_ERR_OR_NULL macro instead of just IS_ERR or !xyz || IS_ERR(xyz)
style usage.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 992b383..3ee8a80 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -471,7 +471,7 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 
 	vdd->debug_dir = debugfs_create_dir(name, voltage_dir);
 	kfree(name);
-	if (IS_ERR(vdd->debug_dir)) {
+	if (IS_ERR_OR_NULL(vdd->debug_dir)) {
 		pr_warning("%s: Unable to create debugfs directory for"
 			" vdd_%s\n", __func__, vdd->voltdm.name);
 		vdd->debug_dir = NULL;
@@ -851,7 +851,7 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	 * smpswaittimemin and smpswaittimemax.
 	 */
 	sys_ck = clk_get(NULL, "sys_ck");
-	if (IS_ERR(sys_ck)) {
+	if (IS_ERR_OR_NULL(sys_ck)) {
 		pr_warning("%s: Could not get the sys clk to calculate"
 			"various vdd_%s params\n", __func__, vdd->voltdm.name);
 		return -EINVAL;
@@ -1041,7 +1041,7 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	 * smpswaittimemin and smpswaittimemax.
 	 */
 	sys_ck = clk_get(NULL, "sys_clkin_ck");
-	if (IS_ERR(sys_ck)) {
+	if (IS_ERR_OR_NULL(sys_ck)) {
 		pr_warning("%s: Could not get the sys clk to calculate"
 			"various vdd_%s params\n", __func__, vdd->voltdm.name);
 		return -EINVAL;
@@ -1125,7 +1125,7 @@ unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return 0;
 	}
@@ -1146,7 +1146,7 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 	struct omap_vdd_info *vdd;
 	u8 curr_vsel;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return 0;
 	}
@@ -1183,7 +1183,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	u32 vpconfig;
 	u16 mod;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -1224,7 +1224,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	u16 mod;
 	int timeout;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -1308,7 +1308,7 @@ void omap_voltage_reset(struct voltagedomain *voltdm)
 {
 	unsigned long target_uvdc;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -1340,7 +1340,7 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -1371,7 +1371,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 	struct omap_vdd_info *vdd;
 	int i;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -1409,7 +1409,7 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return -EINVAL;
 	}
@@ -1436,7 +1436,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm)
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return NULL;
 	}
@@ -1461,7 +1461,7 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 {
 	struct omap_vdd_info *vdd;
 
-	if (!voltdm || IS_ERR(voltdm)) {
+	if (IS_ERR_OR_NULL(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
@@ -1531,7 +1531,7 @@ int __init omap_voltage_late_init(void)
 	}
 
 	voltage_dir = debugfs_create_dir("voltage", NULL);
-	if (IS_ERR(voltage_dir))
+	if (IS_ERR_OR_NULL(voltage_dir))
 		pr_err("%s: Unable to create voltage debugfs main dir\n",
 			__func__);
 	for (i = 0; i < nr_scalable_vdd; i++) {
-- 
1.7.1

