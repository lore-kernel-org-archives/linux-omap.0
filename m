From: jean.pihet@newoldbits.com
Subject: [PATCH 14/26] OMAP2+: Use the names from the SmartReflex data instead of voltage domains.
Date: Tue, 22 Nov 2011 16:05:58 +0100
Message-ID: <1321974370-25800-15-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab1KVPHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:15 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:14 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Associate a name with each SmartReflex instance, rather than
attempting to reuse the name of a voltage domain.  This helps remove
any dependencies on SoC-specific structures.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 arch/arm/mach-omap2/smartreflex.c        |   23 ++++++-----------------
 arch/arm/mach-omap2/smartreflex.h        |    3 +++
 arch/arm/mach-omap2/sr_device.c          |   10 ++++++----
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index c9ea22f..f741193 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -19,7 +19,7 @@ static int sr_class3_enable(struct smartreflex *sr)
 
 	if (!volt) {
 		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
-				__func__, sr->voltdm->name);
+				__func__, sr->name);
 		return -ENODATA;
 	}
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 66c6f6b..5a72c87 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -191,19 +191,13 @@ static void sr_stop_vddautocomp(struct smartreflex *sr)
  */
 static int sr_late_init(struct smartreflex *sr)
 {
-	char *name;
 	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	struct resource *mem;
 	int ret = 0;
 
 	if (sr_class->notify && sr_class->notify_flags && sr->irq) {
-		name = kasprintf(GFP_KERNEL, "sr_%s", sr->voltdm->name);
-		if (name == NULL) {
-			ret = -ENOMEM;
-			goto error;
-		}
-		ret = request_irq(sr->irq, sr_interrupt,
-				0, name, (void *)sr);
+		ret = request_irq(sr->irq, sr_interrupt, 0, sr->name,
+				  (void *)sr);
 		if (ret)
 			goto error;
 		disable_irq(sr->irq);
@@ -222,7 +216,6 @@ error:
 	dev_err(&sr->pdev->dev, "%s: ERROR in registering"
 		"interrupt handler. Smartreflex will"
 		"not function as desired\n", __func__);
-	kfree(name);
 	kfree(sr);
 	return ret;
 }
@@ -707,7 +700,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
 	int i, ret = 0;
-	char *name;
 
 	if (!sr) {
 		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
@@ -792,15 +784,14 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		}
 	}
 
-	name = kasprintf(GFP_KERNEL, "sr_%s", sr->voltdm->name);
-	if (!name) {
+	sr->name = kasprintf(GFP_KERNEL, "sr_%s", pdata->name);
+	if (!sr->name) {
 		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
 			__func__);
 		ret = -ENOMEM;
 		goto err_iounmap;
 	}
-	sr->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
-	kfree(name);
+	sr->dbg_dir = debugfs_create_dir(sr->name, sr_dbg_dir);
 	if (IS_ERR(sr->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
@@ -824,9 +815,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 
 	if (sr->nvalue_count == 0 || !sr->nvalue_table) {
-		dev_warn(&pdev->dev, "%s: No Voltage table for the "
-			 "corresponding vdd vdd_%s. Cannot create debugfs "
-			 "entries for n-values\n", __func__, sr->voltdm->name);
+		dev_warn(&pdev->dev, "%s: no SR data table\n", __func__);
 		ret = -ENODATA;
 		goto err_debugfs;
 	}
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index ca70a90..7b0304a 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -144,6 +144,7 @@
 
 /* XXX kerneldoc documentation needed */
 struct smartreflex {
+	char				*name;
 	int				srid;
 	int				ip_type;
 	int				nvalue_count;
@@ -228,6 +229,7 @@ struct omap_sr_nvalue_table {
 /**
  * struct smartreflex_platform_data - Smartreflex platform data.
  *
+ * @name: XXX
  * @ip_type:		Smartreflex IP type.
  * @err_weight: XXX
  * @err_maxlimit: XXX
@@ -246,6 +248,7 @@ struct omap_sr_nvalue_table {
  *			associated with this SR device (allocated in *_probe())
  */
 struct smartreflex_platform_data {
+	const char			*name;
 	int				ip_type;
 	u32				err_weight;
 	u32				err_maxlimit;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 2dec827..aece907 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -82,7 +82,7 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 		 */
 		if (v == 0) {
 			pr_debug("SR: %s: voltage %d: no N value; skipping\n",
-				 sr_data->voltdm->name, volt_data[i].volt_nominal);
+				 pdata->name, volt_data[i].volt_nominal);
 			continue;
 		}
 
@@ -103,6 +103,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	struct platform_device *pdev;
 	struct omap_volt_data *volt_data;
 	struct omap_sr_dev_attr *da;
+	struct voltagedomain *voltdm;
 	char *name = "smartreflex";
 
 	pdata = kzalloc(sizeof(struct smartreflex_platform_data), GFP_KERNEL);
@@ -118,6 +119,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		goto exit;
 	}
 
+	pdata->name = oh->name;
 	pdata->ip_type = oh->class->rev;
 	pdata->senn_mod = 0x1;
 	pdata->senp_mod = 0x1;
@@ -130,14 +132,14 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	pdata->senn_avgweight = da->senn_avgweight;
 	pdata->senp_avgweight = da->senp_avgweight;
 
-	pdata->voltdm = voltdm_lookup(da->sensor_voltdm_name);
-	if (IS_ERR(pdata->voltdm)) {
+	voltdm = voltdm_lookup(da->sensor_voltdm_name);
+	if (IS_ERR(voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
 			__func__, da->sensor_voltdm_name);
 		goto exit;
 	}
 
-	omap_voltage_get_volttable(pdata->voltdm, &volt_data);
+	omap_voltage_get_volttable(voltdm, &volt_data);
 	if (!volt_data) {
 		pr_warning("%s: No Voltage table registerd fo VDD %s."
 			"Something really wrong\n\n", __func__,
-- 
1.7.5.4

