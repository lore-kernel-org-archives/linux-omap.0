From: jean.pihet@newoldbits.com
Subject: [PATCH 08/26] OMAP: SmartReflex: make pdata distinct from other data
Date: Tue, 22 Nov 2011 16:05:52 +0100
Message-ID: <1321974370-25800-9-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab1KVPHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:03 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:03 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Rename "struct omap_sr_data" to "struct smartreflex_platform_data" to
highlight that this structure contains platform_data.  Rename the
sr_data variable in arch/arm/mach-omap2/sr_device.c to pdata to
indicate that this data is platform_data.  This patch should result in
no functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    7 +++--
 arch/arm/mach-omap2/smartreflex.h |    4 +-
 arch/arm/mach-omap2/sr_device.c   |   50 ++++++++++++++++++------------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ca3987a..4b0dafc 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -194,7 +194,8 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 static int sr_late_init(struct omap_sr *sr_info)
 {
 	char *name;
-	struct omap_sr_data *pdata = sr_info->pdev->dev.platform_data;
+	struct smartreflex_platform_data *pdata =
+					sr_info->pdev->dev.platform_data;
 	struct resource *mem;
 	int ret = 0;
 
@@ -732,7 +733,7 @@ DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 static int __init omap_sr_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
 	struct omap_volt_data *volt_data;
@@ -893,7 +894,7 @@ err_free_devinfo:
 
 static int __devexit omap_sr_remove(struct platform_device *pdev)
 {
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct omap_sr *sr_info;
 	struct resource *mem;
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 6cf9e96..e4930be 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -232,7 +232,7 @@ struct omap_sr_nvalue_table {
 };
 
 /**
- * struct omap_sr_data - Smartreflex platform data.
+ * struct smartreflex_platform_data - Smartreflex platform data.
  *
  * @ip_type:		Smartreflex IP type.
  * @err_weight: XXX
@@ -250,7 +250,7 @@ struct omap_sr_nvalue_table {
  * @voltdm:		Pointer to the voltage domain associated with the SR
  * @sr: struct omap_sr * associated with this SR device (allocated in *_probe())
  */
-struct omap_sr_data {
+struct smartreflex_platform_data {
 	int				ip_type;
 	u32				err_weight;
 	u32				err_maxlimit;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 77442bb..f464d6a2 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -33,13 +33,13 @@ static bool sr_enable_on_init;
 
 /* Read EFUSE values from control registers for OMAP3430 */
 static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
-				struct omap_sr_data *sr_data)
+				  struct smartreflex_platform_data *pdata)
 {
 	struct omap_sr_nvalue_table *nvalue_table;
 	int i, count = 0;
 
-	sr_data->nvalue_count = 0;
-	sr_data->nvalue_table = NULL;
+	pdata->nvalue_count = 0;
+	pdata->nvalue_table = NULL;
 
 	while (volt_data[count].volt_nominal)
 		count++;
@@ -72,21 +72,21 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 		nvalue_table[i].nvalue = v;
 	}
 
-	sr_data->nvalue_table = nvalue_table;
-	sr_data->nvalue_count = count;
+	pdata->nvalue_table = nvalue_table;
+	pdata->nvalue_count = count;
 }
 
 static int sr_dev_init(struct omap_hwmod *oh, void *user)
 {
-	struct omap_sr_data *sr_data;
+	struct smartreflex_platform_data *pdata;
 	struct platform_device *pdev;
 	struct omap_volt_data *volt_data;
 	struct omap_sr_dev_attr *da;
 	char *name = "smartreflex";
 
-	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
-	if (!sr_data) {
-		pr_err("%s: Unable to allocate memory for %s sr_data.Error!\n",
+	pdata = kzalloc(sizeof(struct smartreflex_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: Unable to allocate memory for %s pdata.Error!\n",
 			__func__, oh->name);
 		return -ENOMEM;
 	}
@@ -97,26 +97,26 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		goto exit;
 	}
 
-	sr_data->ip_type = oh->class->rev;
-	sr_data->senn_mod = 0x1;
-	sr_data->senp_mod = 0x1;
+	pdata->ip_type = oh->class->rev;
+	pdata->senn_mod = 0x1;
+	pdata->senp_mod = 0x1;
 
 	da = (struct omap_sr_dev_attr *)oh->dev_attr;
 
-	sr_data->err_weight = da->errweight;
-	sr_data->err_maxlimit = da->errmaxlimit;
-	sr_data->accum_data = da->accumdata;
-	sr_data->senn_avgweight = da->senn_avgweight;
-	sr_data->senp_avgweight = da->senp_avgweight;
+	pdata->err_weight = da->errweight;
+	pdata->err_maxlimit = da->errmaxlimit;
+	pdata->accum_data = da->accumdata;
+	pdata->senn_avgweight = da->senn_avgweight;
+	pdata->senp_avgweight = da->senp_avgweight;
 
-	sr_data->voltdm = voltdm_lookup(da->sensor_voltdm_name);
-	if (IS_ERR(sr_data->voltdm)) {
+	pdata->voltdm = voltdm_lookup(da->sensor_voltdm_name);
+	if (IS_ERR(pdata->voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
 			__func__, da->sensor_voltdm_name);
 		goto exit;
 	}
 
-	omap_voltage_get_volttable(sr_data->voltdm, &volt_data);
+	omap_voltage_get_volttable(pdata->voltdm, &volt_data);
 	if (!volt_data) {
 		pr_warning("%s: No Voltage table registerd fo VDD %s."
 			"Something really wrong\n\n", __func__,
@@ -124,17 +124,17 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		goto exit;
 	}
 
-	sr_set_nvalues(volt_data, sr_data);
+	sr_set_nvalues(volt_data, pdata);
 
-	sr_data->enable_on_init = sr_enable_on_init;
+	pdata->enable_on_init = sr_enable_on_init;
 
-	pdev = omap_device_build(name, da->pdev_inst_id, oh, sr_data,
-			       sizeof(*sr_data), NULL, 0, 0);
+	pdev = omap_device_build(name, da->pdev_inst_id, oh, pdata,
+			       sizeof(*pdata), NULL, 0, 0);
 	if (IS_ERR(pdev))
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
 exit:
-	kfree(sr_data);
+	kfree(pdata);
 	return 0;
 }
 
-- 
1.7.5.4

