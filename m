From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Thu, 20 Sep 2012 16:47:33 +0200
Message-ID: <1348152453-30532-3-git-send-email-j-pihet@ti.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58594 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2ITOrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 10:47:47 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so529872wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 07:47:46 -0700 (PDT)
In-Reply-To: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/sr_device.c   |   14 ++++++++++
 drivers/power/avs/smartreflex.c   |   51 +++++++++++++++---------------------
 include/linux/power/smartreflex.h |   17 +++++++++++-
 3 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d033a65..12d95c8 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -118,10 +118,24 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 	}
 
 	sr_data->name = oh->name;
+	sr_data->fck_name = oh->main_clk;
 	sr_data->ip_type = oh->class->rev;
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
+		sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
+		sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
+		if (!(strcmp(sr_data->name, "smartreflex_mpu_iva"))) {
+			sr_data->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
+			sr_data->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
+		} else {
+			sr_data->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
+			sr_data->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
+		}
+	}
+
 	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
 	if (IS_ERR(sr_data->voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 92f6728..f09e8df 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -131,14 +131,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
 
-	if (cpu_is_omap34xx())
-		sys_ck = clk_get(NULL, "sys_ck");
-	else
-		sys_ck = clk_get(NULL, "sys_clkin_ck");
+	sys_ck = clk_get(NULL, sr->fck_name);
 
 	if (IS_ERR(sys_ck)) {
-		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
-			__func__);
+		dev_err(&sr->pdev->dev, "%s: unable to get smartreflex fck %s\n",
+			__func__, sr->fck_name);
 		return;
 	}
 
@@ -168,28 +165,6 @@ static void sr_set_clk_length(struct omap_sr *sr)
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
-		if (!(strcmp(sr->name, "smartreflex_mpu_iva"))) {
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
@@ -915,6 +890,14 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	sr_info->fck_name = kasprintf(GFP_KERNEL, "%s", pdata->fck_name);
+	if (!sr_info->fck_name) {
+		dev_err(&pdev->dev, "%s: Unable to alloc SR instance fck name\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
 	sr_info->voltdm = pdata->voltdm;
@@ -922,20 +905,25 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr_info->nvalue_count = pdata->nvalue_count;
 	sr_info->senn_mod = pdata->senn_mod;
 	sr_info->senp_mod = pdata->senp_mod;
+	sr_info->err_weight = pdata->err_weight;
+	sr_info->err_maxlimit = pdata->err_maxlimit;
+	sr_info->accum_data = pdata->accum_data;
+	sr_info->senn_avgweight = pdata->senn_avgweight;
+	sr_info->senp_avgweight = pdata->senp_avgweight;
 	sr_info->autocomp_active = false;
 	sr_info->ip_type = pdata->ip_type;
+
 	sr_info->base = ioremap(mem->start, resource_size(mem));
 	if (!sr_info->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		ret = -ENOMEM;
-		goto err_free_name;
+		goto err_free_fck_name;
 	}
 
 	if (irq)
 		sr_info->irq = irq->start;
 
 	sr_set_clk_length(sr_info);
-	sr_set_regfields(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
 
@@ -1014,6 +1002,8 @@ err_debugfs:
 err_iounmap:
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
+err_free_fck_name:
+	kfree(sr_info->fck_name);
 err_free_name:
 	kfree(sr_info->name);
 err_release_region:
@@ -1049,6 +1039,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
+	kfree(sr_info->fck_name);
 	kfree(sr_info->name);
 	kfree(sr_info);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 3101e62..7b16c3c 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -145,6 +145,7 @@
 
 struct omap_sr {
 	char				*name;
+	char				*fck_name;
 	struct list_head		node;
 	struct platform_device		*pdev;
 	struct omap_sr_nvalue_table	*nvalue_table;
@@ -259,9 +260,15 @@ struct omap_sr_nvalue_table {
  * struct omap_sr_data - Smartreflex platform data.
  *
  * @name:		instance name
+ * @fck_name:		IP block fck name
  * @ip_type:		Smartreflex IP type.
- * @senp_mod:		SENPENABLE value for the sr
- * @senn_mod:		SENNENABLE value for sr
+ * @senp_mod:		SENPENABLE value of the sr CONFIG register
+ * @senn_mod:		SENNENABLE value for sr CONFIG register
+ * @err_weight		ERRWEIGHT value of the sr ERRCONFIG register
+ * @err_maxlimit	ERRMAXLIMIT value of the sr ERRCONFIG register
+ * @accum_data		ACCUMDATA value of the sr CONFIG register
+ * @senn_avgweight	SENNAVGWEIGHT value of the sr AVGWEIGHT register
+ * @senp_avgweight	SENPAVGWEIGHT value of the sr AVGWEIGHT register
  * @nvalue_count:	Number of distinct nvalues in the nvalue table
  * @enable_on_init:	whether this sr module needs to enabled at
  *			boot up or not.
@@ -271,9 +278,15 @@ struct omap_sr_nvalue_table {
  */
 struct omap_sr_data {
 	const char			*name;
+	const char			*fck_name;
 	int				ip_type;
 	u32				senp_mod;
 	u32				senn_mod;
+	u32				err_weight;
+	u32				err_maxlimit;
+	u32				accum_data;
+	u32				senn_avgweight;
+	u32				senp_avgweight;
 	int				nvalue_count;
 	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
-- 
1.7.7.6

