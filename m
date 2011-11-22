From: jean.pihet@newoldbits.com
Subject: [PATCH 16/26] OMAP2+: SmartReflex: cosmetic changes
Date: Tue, 22 Nov 2011 16:06:00 +0100
Message-ID: <1321974370-25800-17-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab1KVPHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:19 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:18 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Concatenate error message strings; fix some indenting.

Kevin mentioned some time ago that the lkml consensus was to not break
error messages up into partial strings to fit within 80 columns, but
rather to make it one big line; so, do so in the SmartReflex driver
code.

Also, while here, fix some obviously incorrect indentation and whitespace,
and remove some of the obvious references to "OMAP", since we're trying
to convert this into an SoC-independent driver.

This patch shouldn't result in any functional changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 41c4d2a..154a98b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1,5 +1,5 @@
 /*
- * OMAP SmartReflex Voltage Control
+ * SmartReflex Voltage Control
  *
  * Author: Thara Gopinath	<thara@ti.com>
  *
@@ -39,13 +39,14 @@ static LIST_HEAD(sr_list);
 static struct smartreflex_class_data *sr_class;
 static struct dentry		*sr_dbg_dir;
 
-static inline void sr_write_reg(struct smartreflex *sr, unsigned offset, u32 value)
+static inline void sr_write_reg(struct smartreflex *sr, unsigned offset,
+				u32 value)
 {
 	__raw_writel(value, (sr->base + offset));
 }
 
-static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset, u32 mask,
-					u32 value)
+static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset,
+				 u32 mask, u32 value)
 {
 	u32 reg_val;
 	u32 errconfig_offs = 0, errconfig_mask = 0;
@@ -212,9 +213,7 @@ error:
 	mem = platform_get_resource(sr->pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 	list_del(&sr->node);
-	dev_err(&sr->pdev->dev, "%s: ERROR in registering"
-		"interrupt handler. Smartreflex will"
-		"not function as desired\n", __func__);
+	dev_err(&sr->pdev->dev, "%s: ERROR in registering interrupt handler. Smartreflex will not function as desired\n", __func__);
 	kfree(sr);
 	return ret;
 }
@@ -358,8 +357,7 @@ int sr_configure_errgen(struct smartreflex *sr)
 		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
 	} else {
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
 
@@ -418,8 +416,7 @@ int sr_configure_minmax(struct smartreflex *sr)
 		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
 	} else {
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
 
@@ -584,8 +581,7 @@ void omap_sr_enable(struct smartreflex *sr)
 		return;
 
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
 		return;
 	}
 
@@ -612,8 +608,7 @@ void omap_sr_disable(struct smartreflex *sr)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
 		return;
 	}
 
@@ -640,8 +635,7 @@ void omap_sr_disable_reset_volt(struct smartreflex *sr)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
 		return;
 	}
 
@@ -807,8 +801,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
-			"for n-values\n", __func__);
+		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
 		goto err_debugfs;
 	}
@@ -878,7 +871,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove		= omap_sr_remove,
 	.driver		= {
 		.name	= "smartreflex",
 	},
@@ -905,7 +898,7 @@ static void __exit sr_exit(void)
 late_initcall(sr_init);
 module_exit(sr_exit);
 
-MODULE_DESCRIPTION("OMAP Smartreflex Driver");
+MODULE_DESCRIPTION("SmartReflex device driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-- 
1.7.5.4

