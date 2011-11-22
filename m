From: jean.pihet@newoldbits.com
Subject: [PATCH 23/26] OMAP2+: SmartReflex: conversion into generic driver
Date: Tue, 22 Nov 2011 16:06:07 +0100
Message-ID: <1321974370-25800-24-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64917 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab1KVPHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:34 -0500
Received: by wwe3 with SMTP id 3so7366646wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:32 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Use pdev and pdata to register the driver and pass data to it from the
platform code.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +-
 arch/arm/mach-omap2/smartreflex.c        |  120 ++++++++++--------------------
 arch/arm/mach-omap2/smartreflex.h        |   52 +++++++------
 3 files changed, 69 insertions(+), 108 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index f741193..2d37f76 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -53,7 +53,10 @@ static struct smartreflex_class_data class3_data = {
 /* Smartreflex Class3 init API to be called from board file */
 static int __init sr_class3_init(void)
 {
+	/* XXX fix the registration of pdev */
+	struct platform_device *pdev = NULL;
+
 	pr_info("SmartReflex Class3 initialized\n");
-	return sr_register_class(&class3_data);
+	return sr_register_class(pdev, &class3_data);
 }
 late_initcall(sr_class3_init);
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 947446f..f7d305d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1,5 +1,5 @@
 /*
- * SmartReflex Voltage Control
+ * Device driver for the SmartReflex IP block
  *
  * Author: Thara Gopinath	<thara@ti.com>
  *
@@ -40,10 +40,6 @@
  */
 #define SR_CLK			100000 /* Hz */
 
-/* sr_list contains all the instances of smartreflex module */
-static LIST_HEAD(sr_list);
-
-static struct smartreflex_class_data *sr_class;
 static struct dentry		*sr_dbg_dir;
 
 static inline void sr_write_reg(struct smartreflex *sr, unsigned offset,
@@ -138,20 +134,21 @@ static int sr_calculate_clk_length(struct smartreflex *sr)
 
 static void sr_start_vddautocomp(struct smartreflex *sr)
 {
-	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
+	if (!sr->sr_class || !sr->sr_class->enable ||
+	    !sr->sr_class->configure) {
 		dev_warn(&sr->pdev->dev,
 			"%s: smartreflex class driver not registered\n",
 			__func__);
 		return;
 	}
 
-	if (!sr_class->enable(sr))
+	if (!sr->sr_class->enable(sr))
 		sr->autocomp_active = true;
 }
 
 static void sr_stop_vddautocomp(struct smartreflex *sr)
 {
-	if (!sr_class || !(sr_class->disable)) {
+	if (!sr->sr_class || !sr->sr_class->disable) {
 		dev_warn(&sr->pdev->dev,
 			"%s: smartreflex class driver not registered\n",
 			__func__);
@@ -159,51 +156,11 @@ static void sr_stop_vddautocomp(struct smartreflex *sr)
 	}
 
 	if (sr->autocomp_active) {
-		sr_class->disable(sr, 1);
+		sr->sr_class->disable(sr, 1);
 		sr->autocomp_active = false;
 	}
 }
 
-/*
- * This function handles the intializations which have to be done
- * only when both sr device and class driver regiter has
- * completed. This will be attempted to be called from both sr class
- * driver register and sr device intializtion API's. Only one call
- * will ultimately succeed.
- *
- * Currently this function registers interrupt handler for a particular SR
- * if smartreflex class driver is already registered and has
- * requested for interrupts and the SR interrupt line in present.
- */
-static int sr_late_init(struct smartreflex *sr)
-{
-	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
-	struct resource *mem;
-	int ret = 0;
-
-	if (sr->irq) {
-		ret = request_irq(sr->irq, sr_interrupt, 0, sr->name,
-				  (void *)sr);
-		if (ret)
-			goto error;
-		disable_irq(sr->irq);
-	}
-
-	if (pdata && pdata->enable_on_init)
-		sr_start_vddautocomp(sr);
-
-	return ret;
-
-error:
-	iounmap(sr->base);
-	mem = platform_get_resource(sr->pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
-	list_del(&sr->node);
-	dev_err(&sr->pdev->dev, "%s: ERROR in registering interrupt handler. Smartreflex will not function as desired\n", __func__);
-	kfree(sr);
-	return ret;
-}
-
 static void sr_v1_disable(struct smartreflex *sr)
 {
 	int timeout = 0;
@@ -428,7 +385,7 @@ int sr_enable(struct smartreflex *sr, unsigned long volt)
 		return 0;
 
 	/* Configure SR */
-	ret = sr_class->configure(sr);
+	ret = sr->sr_class->configure(sr);
 	if (ret)
 		return ret;
 
@@ -475,36 +432,51 @@ void sr_disable(struct smartreflex *sr)
  * sr_register_class() - API to register a smartreflex class parameters.
  * @class_data:	The structure containing various sr class specific data.
  *
+ * XXX FIX THIS DOCUMENTATION
+ *
  * This API is to be called by the smartreflex class driver to register itself
  * with the smartreflex driver during init. Returns 0 on success else the
  * error value.
  */
-int sr_register_class(struct smartreflex_class_data *class_data)
+int sr_register_class(struct platform_device *pdev, 
+		      struct smartreflex_class_data *class_data)
 {
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct smartreflex *sr;
+	int ret = 0;
 
-	if (!class_data) {
-		pr_warning("%s:, Smartreflex class data passed is NULL\n",
-			__func__);
+	if (!pdev || !class_data)
 		return -EINVAL;
+
+	sr = pdata->sr;
+	if (sr) {
+		dev_err(&pdev->dev, "%s: Smartreflex class driver already registered\n",
+		       __func__);
+		return -EBUSY; /* XXX -EEXIST seems better */
 	}
 
-	if (sr_class) {
-		pr_warning("%s: Smartreflex class driver already registered\n",
-			__func__);
-		return -EBUSY;
+	if (class_data->isr) {
+		if (!sr->irq) {
+			dev_err(&pdev->dev, "%s: cannot register since class driver has an IRQ hook, but no SR IRQ specified\n", __func__);
+			ret = -EINVAL;
+			goto src_err;
+		}
+
+		ret = request_irq(sr->irq, sr_interrupt, 0, pdata->name,
+				  (void *)sr);
+		if (ret) {
+			dev_err(&pdev->dev, "%s: could not register interrupt handler\n", __func__);
+			goto src_err;
+		}
 	}
 
-	sr_class = class_data;
+	sr->sr_class = class_data;
 
-	/*
-	 * Call into late init to do intializations that require
-	 * both sr driver and sr class driver to be initiallized.
-	 */
-	list_for_each_entry(sr, &sr_list, node)
-		sr_late_init(sr);
+	if (pdata->enable_on_init)
+		sr_start_vddautocomp(sr);
 
-	return 0;
+src_err:
+	return ret;
 }
 
 /* PM Debug Fs enteries to enable disable smartreflex. */
@@ -635,20 +607,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
 				(pdata->senp_mod << senp_shift));
 
-	list_add(&sr->node, &sr_list);
-
-	/*
-	 * Call into late init to do intializations that require
-	 * both sr driver and sr class driver to be initiallized.
-	 */
-	if (sr_class) {
-		ret = sr_late_init(sr);
-		if (ret) {
-			pr_warning("%s: Error in SR late init\n", __func__);
-			return ret;
-		}
-	}
-
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
 	if (!sr_dbg_dir) {
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
@@ -710,7 +668,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 err_debugfs:
 	debugfs_remove_recursive(sr->dbg_dir);
 err_iounmap:
-	list_del(&sr->node);
 	iounmap(sr->base);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
@@ -743,7 +700,6 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	if (sr->dbg_dir)
 		debugfs_remove_recursive(sr->dbg_dir);
 
-	list_del(&sr->node);
 	iounmap(sr->base);
 	kfree(sr);
 	pdata->sr = NULL;
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5c641a8..30b7179 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -21,6 +21,7 @@
 #define __ASM_ARM_OMAP_SMARTREFLEX_H
 
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 
 #include "voltage.h"
 
@@ -134,6 +135,16 @@
 #define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
+/*
+ * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
+ * The smartreflex class driver should pass the class type.
+ * Should be used to populate the class_type field of the
+ * omap_smartreflex_class_data structure.
+ */
+#define SR_CLASS1	0x1
+#define SR_CLASS2	0x2
+#define SR_CLASS3	0x3
+
 /* XXX kerneldoc documentation needed */
 struct smartreflex {
 	char				*name;
@@ -149,35 +160,14 @@ struct smartreflex {
 	struct platform_device		*pdev;
 	struct list_head		node;
 	struct omap_sr_data_table	*data_table;
+	struct smartreflex_class_data	*sr_class;
 	struct voltagedomain		*voltdm;
 	struct dentry			*dbg_dir;
 	u8				errconfig_offs;
 };
 
-/* XXX Kerneldoc documentation needed */
-struct omap_sr_dev_attr {
-	char *sensor_voltdm_name; /* XXX should be const */
-	u32 errweight;
-	u32 errmaxlimit;
-	u32 accumdata;
-	u32 senn_avgweight;
-	u32 senp_avgweight;
-	u8 pdev_inst_id;
-};
-
-#ifdef CONFIG_OMAP_SMARTREFLEX
-/*
- * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
- * The smartreflex class driver should pass the class type.
- * Should be used to populate the class_type field of the
- * omap_smartreflex_class_data structure.
- */
-#define SR_CLASS1	0x1
-#define SR_CLASS2	0x2
-#define SR_CLASS3	0x3
-
 /**
- * struct smartreflex_class_data - Smartreflex class driver info
+ * struct omap_sr_class_data - Smartreflex class driver info
  *
  * @enable:		API to enable a particular class smaartreflex.
  * @disable:		API to disable a particular class smartreflex.
@@ -190,9 +180,21 @@ struct smartreflex_class_data {
 	int (*enable)(struct smartreflex *sr);
 	int (*disable)(struct smartreflex *sr, int is_volt_reset);
 	int (*configure)(struct smartreflex *sr);
+	irqreturn_t (*isr) (int irq, void *data);
 	u8 class_type;
 };
 
+/* XXX Kerneldoc documentation needed */
+struct omap_sr_dev_attr {
+	char *sensor_voltdm_name; /* XXX should be const */
+	u32 errweight;
+	u32 errmaxlimit;
+	u32 accumdata;
+	u32 senn_avgweight;
+	u32 senp_avgweight;
+	u8 pdev_inst_id;
+};
+
 /**
  * struct omap_sr_data_table	- Smartreflex n-target value info
  *
@@ -252,6 +254,6 @@ int sr_configure_errgen(struct smartreflex *sr);
 int sr_configure_minmax(struct smartreflex *sr);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
-int sr_register_class(struct smartreflex_class_data *class_data);
-#endif
+int sr_register_class(struct platform_device *pdev,
+		      struct smartreflex_class_data *class_data);
 #endif
-- 
1.7.5.4

