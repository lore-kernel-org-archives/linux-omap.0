From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Mon, 24 Sep 2012 16:16:41 +0200
Message-ID: <1348496201-6378-3-git-send-email-j-pihet@ti.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
 <1348496201-6378-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45226 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab2IXORD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 10:17:03 -0400
Received: by weyt9 with SMTP id t9so238117wey.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 07:17:01 -0700 (PDT)
In-Reply-To: <1348496201-6378-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>
Cc: Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code, as required by the move of the platform header files to
include/linux/platform_data.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/sr_device.c   |   13 ++++++++++++
 drivers/power/avs/smartreflex.c   |   40 ++++++++++--------------------------
 include/linux/power/smartreflex.h |   14 +++++++++++-
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d033a65..2885a77 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -122,6 +122,19 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
+		sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
+		sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
+		if (!(strcmp(sr_data->name, "smartreflex_mpu"))) {
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
index 92f6728..7c03c90 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -128,17 +128,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 
 static void sr_set_clk_length(struct omap_sr *sr)
 {
+	char fck_name[16]; /* "smartreflex.0" fits in 16 chars */
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
 
-	if (cpu_is_omap34xx())
-		sys_ck = clk_get(NULL, "sys_ck");
-	else
-		sys_ck = clk_get(NULL, "sys_clkin_ck");
+	sprintf(fck_name, "smartreflex.%d", sr->srid);
+	sys_ck = clk_get(NULL, fck_name);
 
 	if (IS_ERR(sys_ck)) {
-		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
-			__func__);
+		dev_err(&sr->pdev->dev, "%s: unable to get smartreflex fck %s\n",
+			__func__, fck_name);
 		return;
 	}
 
@@ -168,28 +167,6 @@ static void sr_set_clk_length(struct omap_sr *sr)
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
@@ -922,8 +899,14 @@ static int __init omap_sr_probe(struct platform_device *pdev)
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
@@ -935,7 +918,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		sr_info->irq = irq->start;
 
 	sr_set_clk_length(sr_info);
-	sr_set_regfields(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
 
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 3101e62..09d5efc 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -260,8 +260,13 @@ struct omap_sr_nvalue_table {
  *
  * @name:		instance name
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
@@ -274,6 +279,11 @@ struct omap_sr_data {
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

