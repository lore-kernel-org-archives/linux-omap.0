From: jean.pihet@newoldbits.com
Subject: [PATCH 04/26] OMAP: SmartReflex: drop _sr_lookup()
Date: Tue, 22 Nov 2011 16:05:48 +0100
Message-ID: <1321974370-25800-5-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab1KVPG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:57 -0500
Received: by wwe5 with SMTP id 5so432213wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:56 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Drop the _sr_lookup() function that returns a struct omap_sr from a
struct voltagedomain.  Instead, retain a pointer to the struct omap_sr
* in the driver platform data.  This removes another struct
voltagedomain * dependency in the SmartReflex driver code.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   28 +++++++---------------------
 arch/arm/mach-omap2/smartreflex.h |    2 ++
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 55966bc..c03eb4e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -86,23 +86,6 @@ static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
 	return __raw_readl(sr->base + offset);
 }
 
-static struct omap_sr *_sr_lookup(struct voltagedomain *voltdm)
-{
-	struct omap_sr *sr_info;
-
-	if (!voltdm) {
-		pr_err("%s: Null voltage domain passed!\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-
-	list_for_each_entry(sr_info, &sr_list, node) {
-		if (voltdm == sr_info->voltdm)
-			return sr_info;
-	}
-
-	return ERR_PTR(-ENODATA);
-}
-
 static irqreturn_t sr_interrupt(int irq, void *data)
 {
 	struct omap_sr *sr_info = (struct omap_sr *)data;
@@ -558,7 +541,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 
 /**
  * sr_disable() - Disables the smartreflex module.
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the smartreflex class driver to
  * disable a smartreflex module.
@@ -625,7 +608,7 @@ int sr_register_class(struct omap_sr_class_data *class_data)
 /**
  * omap_sr_enable() -  API to enable SR clocks and to call into the
  *			registered smartreflex class enable API.
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the kernel in order to enable
  * a particular smartreflex module. This API will do the initial
@@ -652,7 +635,7 @@ void omap_sr_enable(struct omap_sr *sr)
 /**
  * omap_sr_disable() - API to disable SR without resetting the voltage
  *			processor voltage
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the kernel in order to disable
  * a particular smartreflex module. This API will in turn call
@@ -810,6 +793,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_irq_safe(&pdev->dev);
 
+	pdata->sr = sr_info;
+
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
 	sr_info->voltdm = pdata->voltdm;
@@ -935,7 +920,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	sr_info = _sr_lookup(pdata->voltdm);
+	sr_info = pdata->sr;
 	if (IS_ERR(sr_info)) {
 		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
 			__func__);
@@ -950,6 +935,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
 	kfree(sr_info);
+	pdata->sr = NULL;
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 305776f..d7e8d90 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -232,6 +232,7 @@ struct omap_sr_nvalue_table {
  * @nvalue_table:	table containing the  efuse offsets and nvalues
  *			corresponding to them.
  * @voltdm:		Pointer to the voltage domain associated with the SR
+ * @sr: struct omap_sr * associated with this SR device (allocated in *_probe())
  */
 struct omap_sr_data {
 	int				ip_type;
@@ -241,6 +242,7 @@ struct omap_sr_data {
 	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
+	struct omap_sr			*sr;
 };
 
 /* Smartreflex module enable/disable interface */
-- 
1.7.5.4

