From: jean.pihet@newoldbits.com
Subject: [PATCH 06/26] OMAP3+: Pass SmartReflex instance-specific data via hwmod dev_attr
Date: Tue, 22 Nov 2011 16:05:50 +0100
Message-ID: <1321974370-25800-7-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab1KVPHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:00 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:59 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   28 +++++-----------------------
 arch/arm/mach-omap2/smartreflex.h |   10 ++++++++++
 arch/arm/mach-omap2/sr_device.c   |   30 +++++++++++++++++++-----------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c03eb4e..ca3987a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -152,28 +152,6 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	}
 }
 
-static void sr_set_regfields(struct omap_sr *sr)
-{
-	/*
-	 * For time being these values are defined in smartreflex.h
-	 * and populated during init. May be they can be moved to board
-	 * file or pmic specific data structure. In that case these structure
-	 * fields will have to be populated using the pdata or pmic structure.
-	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
-		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
-		sr->accum_data = OMAP3430_SR_ACCUMDATA;
-		if (!(strcmp(sr->voltdm->name, "mpu"))) {
-			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
-			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
-		} else {
-			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
-			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
-		}
-	}
-}
-
 static void sr_start_vddautocomp(struct omap_sr *sr)
 {
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
@@ -800,8 +778,13 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr_info->voltdm = pdata->voltdm;
 	sr_info->nvalue_table = pdata->nvalue_table;
 	sr_info->nvalue_count = pdata->nvalue_count;
+	sr_info->err_weight = pdata->err_weight;
+	sr_info->err_maxlimit = pdata->err_maxlimit;
+	sr_info->accum_data = pdata->accum_data;
 	sr_info->senn_mod = pdata->senn_mod;
+	sr_info->senn_avgweight = pdata->senn_avgweight;
 	sr_info->senp_mod = pdata->senp_mod;
+	sr_info->senp_avgweight = pdata->senp_avgweight;
 	sr_info->autocomp_active = false;
 	sr_info->ip_type = pdata->ip_type;
 	sr_info->base = ioremap(mem->start, resource_size(mem));
@@ -815,7 +798,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		sr_info->irq = irq->start;
 
 	sr_set_clk_length(sr_info);
-	sr_set_regfields(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index deed861..6cf9e96 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -235,8 +235,13 @@ struct omap_sr_nvalue_table {
  * struct omap_sr_data - Smartreflex platform data.
  *
  * @ip_type:		Smartreflex IP type.
+ * @err_weight: XXX
+ * @err_maxlimit: XXX
+ * @accum_data: XXX
  * @senp_mod:		SENPENABLE value for the sr
  * @senn_mod:		SENNENABLE value for sr
+ * @senn_avgweight: XXX
+ * @senp_avgweight: XXX
  * @nvalue_count:	Number of distinct nvalues in the nvalue table
  * @enable_on_init:	whether this sr module needs to enabled at
  *			boot up or not.
@@ -247,8 +252,13 @@ struct omap_sr_nvalue_table {
  */
 struct omap_sr_data {
 	int				ip_type;
+	u32				err_weight;
+	u32				err_maxlimit;
+	u32				accum_data;
 	u32				senp_mod;
 	u32				senn_mod;
+	u32				senn_avgweight;
+	u32				senp_avgweight;
 	int				nvalue_count;
 	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 221407a..77442bb 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -81,8 +81,8 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	struct omap_sr_data *sr_data;
 	struct platform_device *pdev;
 	struct omap_volt_data *volt_data;
+	struct omap_sr_dev_attr *da;
 	char *name = "smartreflex";
-	static int i;
 
 	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
 	if (!sr_data) {
@@ -91,9 +91,9 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		return -ENOMEM;
 	}
 
-	if (!oh->vdd_name) {
-		pr_err("%s: No voltage domain specified for %s."
-			"Cannot initialize\n", __func__, oh->name);
+	if (!oh->dev_attr) {
+		pr_err("%s: No dev_attr specified for %s.  Cannot initialize\n",
+		       __func__, oh->name);
 		goto exit;
 	}
 
@@ -101,17 +101,26 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
-	sr_data->voltdm = voltdm_lookup(oh->vdd_name);
+	da = (struct omap_sr_dev_attr *)oh->dev_attr;
+
+	sr_data->err_weight = da->errweight;
+	sr_data->err_maxlimit = da->errmaxlimit;
+	sr_data->accum_data = da->accumdata;
+	sr_data->senn_avgweight = da->senn_avgweight;
+	sr_data->senp_avgweight = da->senp_avgweight;
+
+	sr_data->voltdm = voltdm_lookup(da->sensor_voltdm_name);
 	if (IS_ERR(sr_data->voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
-			__func__, oh->vdd_name);
+			__func__, da->sensor_voltdm_name);
 		goto exit;
 	}
 
 	omap_voltage_get_volttable(sr_data->voltdm, &volt_data);
 	if (!volt_data) {
-		pr_warning("%s: No Voltage table registerd fo VDD%d."
-			"Something really wrong\n\n", __func__, i + 1);
+		pr_warning("%s: No Voltage table registerd fo VDD %s."
+			"Something really wrong\n\n", __func__,
+			da->sensor_voltdm_name);
 		goto exit;
 	}
 
@@ -119,13 +128,12 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data->enable_on_init = sr_enable_on_init;
 
-	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
-				 NULL, 0, 0);
+	pdev = omap_device_build(name, da->pdev_inst_id, oh, sr_data,
+			       sizeof(*sr_data), NULL, 0, 0);
 	if (IS_ERR(pdev))
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
 exit:
-	i++;
 	kfree(sr_data);
 	return 0;
 }
-- 
1.7.5.4

