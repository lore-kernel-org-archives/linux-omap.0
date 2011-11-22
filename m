From: jean.pihet@newoldbits.com
Subject: [PATCH 09/26] OMAP: SmartReflex: Use 'sr' for struct smartreflex
Date: Tue, 22 Nov 2011 16:05:53 +0100
Message-ID: <1321974370-25800-10-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab1KVPHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:06 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:05 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    6 +-
 arch/arm/mach-omap2/smartreflex.c        |  233 +++++++++++++++---------------
 arch/arm/mach-omap2/smartreflex.h        |   35 +++---
 3 files changed, 136 insertions(+), 138 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 0205f17..190f330 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -13,7 +13,7 @@
 
 #include "smartreflex.h"
 
-static int sr_class3_enable(struct omap_sr *sr)
+static int sr_class3_enable(struct smartreflex *sr)
 {
 	unsigned long volt = voltdm_get_voltage(sr->voltdm);
 
@@ -27,7 +27,7 @@ static int sr_class3_enable(struct omap_sr *sr)
 	return sr_enable(sr, volt);
 }
 
-static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
+static int sr_class3_disable(struct smartreflex *sr, int is_volt_reset)
 {
 	omap_vp_disable(sr->voltdm);
 	sr_disable(sr);
@@ -37,7 +37,7 @@ static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
 	return 0;
 }
 
-static int sr_class3_configure(struct omap_sr *sr)
+static int sr_class3_configure(struct smartreflex *sr)
 {
 	return sr_configure_errgen(sr);
 }
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 4b0dafc..e856d9f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -31,7 +31,6 @@
 #include "pm.h"
 #include "smartreflex.h"
 
-#define SMARTREFLEX_NAME_LEN	16
 #define NVALUE_NAME_LEN		40
 #define SR_DISABLE_TIMEOUT	200
 
@@ -42,12 +41,12 @@ static struct omap_sr_class_data *sr_class;
 static struct omap_sr_pmic_data *sr_pmic_data;
 static struct dentry		*sr_dbg_dir;
 
-static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
+static inline void sr_write_reg(struct smartreflex *sr, unsigned offset, u32 value)
 {
 	__raw_writel(value, (sr->base + offset));
 }
 
-static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
+static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset, u32 mask,
 					u32 value)
 {
 	u32 reg_val;
@@ -81,37 +80,37 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 	__raw_writel(reg_val, (sr->base + offset));
 }
 
-static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
+static inline u32 sr_read_reg(struct smartreflex *sr, unsigned offset)
 {
 	return __raw_readl(sr->base + offset);
 }
 
 static irqreturn_t sr_interrupt(int irq, void *data)
 {
-	struct omap_sr *sr_info = (struct omap_sr *)data;
+	struct smartreflex *sr = (struct smartreflex *)data;
 	u32 status = 0;
 
-	if (sr_info->ip_type == SR_TYPE_V1) {
+	if (sr->ip_type == SR_TYPE_V1) {
 		/* Read the status bits */
-		status = sr_read_reg(sr_info, ERRCONFIG_V1);
+		status = sr_read_reg(sr, ERRCONFIG_V1);
 
 		/* Clear them by writing back */
-		sr_write_reg(sr_info, ERRCONFIG_V1, status);
-	} else if (sr_info->ip_type == SR_TYPE_V2) {
+		sr_write_reg(sr, ERRCONFIG_V1, status);
+	} else if (sr->ip_type == SR_TYPE_V2) {
 		/* Read the status bits */
-		status = sr_read_reg(sr_info, IRQSTATUS);
+		status = sr_read_reg(sr, IRQSTATUS);
 
 		/* Clear them by writing back */
-		sr_write_reg(sr_info, IRQSTATUS, status);
+		sr_write_reg(sr, IRQSTATUS, status);
 	}
 
 	if (sr_class->notify)
-		sr_class->notify(sr_info, status);
+		sr_class->notify(sr, status);
 
 	return IRQ_HANDLED;
 }
 
-static void sr_set_clk_length(struct omap_sr *sr)
+static void sr_set_clk_length(struct smartreflex *sr)
 {
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
@@ -152,7 +151,7 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	}
 }
 
-static void sr_start_vddautocomp(struct omap_sr *sr)
+static void sr_start_vddautocomp(struct smartreflex *sr)
 {
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev,
@@ -165,7 +164,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		sr->autocomp_active = true;
 }
 
-static void sr_stop_vddautocomp(struct omap_sr *sr)
+static void sr_stop_vddautocomp(struct smartreflex *sr)
 {
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev,
@@ -191,46 +190,45 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
  * if smartreflex class driver is already registered and has
  * requested for interrupts and the SR interrupt line in present.
  */
-static int sr_late_init(struct omap_sr *sr_info)
+static int sr_late_init(struct smartreflex *sr)
 {
 	char *name;
-	struct smartreflex_platform_data *pdata =
-					sr_info->pdev->dev.platform_data;
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	struct resource *mem;
 	int ret = 0;
 
-	if (sr_class->notify && sr_class->notify_flags && sr_info->irq) {
-		name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
+	if (sr_class->notify && sr_class->notify_flags && sr->irq) {
+		name = kasprintf(GFP_KERNEL, "sr_%s", sr->voltdm->name);
 		if (name == NULL) {
 			ret = -ENOMEM;
 			goto error;
 		}
-		ret = request_irq(sr_info->irq, sr_interrupt,
-				0, name, (void *)sr_info);
+		ret = request_irq(sr->irq, sr_interrupt,
+				0, name, (void *)sr);
 		if (ret)
 			goto error;
-		disable_irq(sr_info->irq);
+		disable_irq(sr->irq);
 	}
 
 	if (pdata && pdata->enable_on_init)
-		sr_start_vddautocomp(sr_info);
+		sr_start_vddautocomp(sr);
 
 	return ret;
 
 error:
-	iounmap(sr_info->base);
-	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
+	iounmap(sr->base);
+	mem = platform_get_resource(sr->pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
-	list_del(&sr_info->node);
-	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
+	list_del(&sr->node);
+	dev_err(&sr->pdev->dev, "%s: ERROR in registering"
 		"interrupt handler. Smartreflex will"
 		"not function as desired\n", __func__);
 	kfree(name);
-	kfree(sr_info);
+	kfree(sr);
 	return ret;
 }
 
-static void sr_v1_disable(struct omap_sr *sr)
+static void sr_v1_disable(struct smartreflex *sr)
 {
 	int timeout = 0;
 
@@ -266,7 +264,7 @@ static void sr_v1_disable(struct omap_sr *sr)
 			ERRCONFIG_MCUDISACKINTST);
 }
 
-static void sr_v2_disable(struct omap_sr *sr)
+static void sr_v2_disable(struct smartreflex *sr)
 {
 	int timeout = 0;
 
@@ -303,7 +301,7 @@ static void sr_v2_disable(struct omap_sr *sr)
 	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
 }
 
-static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
+static u32 sr_retrieve_nvalue(struct smartreflex *sr, u32 efuse_offs)
 {
 	int i;
 
@@ -326,7 +324,7 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
 /**
  * sr_configure_errgen() - Configures the smrtreflex to perform AVS using the
  *			 error generator module.
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the smartreflex class driver to
  * configure the error generator module inside the smartreflex module.
@@ -335,7 +333,7 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
  * SR CLASS 2 can choose between ERROR module and MINMAXAVG
  * module. Returns 0 on success and error value in case of failure.
  */
-int sr_configure_errgen(struct omap_sr *sr)
+int sr_configure_errgen(struct smartreflex *sr)
 {
 	u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
 	u32 vpboundint_st, senp_en = 0, senn_en = 0;
@@ -391,7 +389,7 @@ int sr_configure_errgen(struct omap_sr *sr)
 /**
  * sr_configure_minmax() - Configures the smrtreflex to perform AVS using the
  *			 minmaxavg module.
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the smartreflex class driver to
  * configure the minmaxavg module inside the smartreflex module.
@@ -400,7 +398,7 @@ int sr_configure_errgen(struct omap_sr *sr)
  * SR CLASS 2 can choose between ERROR module and MINMAXAVG
  * module. Returns 0 on success and error value in case of failure.
  */
-int sr_configure_minmax(struct omap_sr *sr)
+int sr_configure_minmax(struct smartreflex *sr)
 {
 	u32 sr_config, sr_avgwt;
 	u32 senp_en = 0, senn_en = 0;
@@ -463,7 +461,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 
 /**
  * sr_enable() - Enables the smartreflex module.
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  * @volt:	The voltage at which the Voltage domain associated with
  *		the smartreflex module is operating at.
  *		This is required only to program the correct Ntarget value.
@@ -472,7 +470,7 @@ int sr_configure_minmax(struct omap_sr *sr)
  * enable a smartreflex module. Returns 0 on success. Returns error
  * value if the voltage passed is wrong or if ntarget value is wrong.
  */
-int sr_enable(struct omap_sr *sr, unsigned long volt)
+int sr_enable(struct smartreflex *sr, unsigned long volt)
 {
 	u32 nvalue_reciprocal;
 	struct omap_volt_data *volt_data;
@@ -520,12 +518,12 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 
 /**
  * sr_disable() - Disables the smartreflex module.
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the smartreflex class driver to
  * disable a smartreflex module.
  */
-void sr_disable(struct omap_sr *sr)
+void sr_disable(struct smartreflex *sr)
 {
 	if (IS_ERR_OR_NULL(sr))
 		return;
@@ -558,7 +556,7 @@ void sr_disable(struct omap_sr *sr)
  */
 int sr_register_class(struct omap_sr_class_data *class_data)
 {
-	struct omap_sr *sr_info;
+	struct smartreflex *sr;
 
 	if (!class_data) {
 		pr_warning("%s:, Smartreflex class data passed is NULL\n",
@@ -578,8 +576,8 @@ int sr_register_class(struct omap_sr_class_data *class_data)
 	 * Call into late init to do intializations that require
 	 * both sr driver and sr class driver to be initiallized.
 	 */
-	list_for_each_entry(sr_info, &sr_list, node)
-		sr_late_init(sr_info);
+	list_for_each_entry(sr, &sr_list, node)
+		sr_late_init(sr);
 
 	return 0;
 }
@@ -587,14 +585,14 @@ int sr_register_class(struct omap_sr_class_data *class_data)
 /**
  * omap_sr_enable() -  API to enable SR clocks and to call into the
  *			registered smartreflex class enable API.
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the kernel in order to enable
  * a particular smartreflex module. This API will do the initial
  * configurations to turn on the smartreflex module and in turn call
  * into the registered smartreflex class enable API.
  */
-void omap_sr_enable(struct omap_sr *sr)
+void omap_sr_enable(struct smartreflex *sr)
 {
 	if (IS_ERR_OR_NULL(sr))
 		return;
@@ -614,7 +612,7 @@ void omap_sr_enable(struct omap_sr *sr)
 /**
  * omap_sr_disable() - API to disable SR without resetting the voltage
  *			processor voltage
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the kernel in order to disable
  * a particular smartreflex module. This API will in turn call
@@ -622,7 +620,7 @@ void omap_sr_enable(struct omap_sr *sr)
  * the smartreflex class disable not to reset the VP voltage after
  * disabling smartreflex.
  */
-void omap_sr_disable(struct omap_sr *sr)
+void omap_sr_disable(struct smartreflex *sr)
 {
 	if (IS_ERR_OR_NULL(sr))
 		return;
@@ -642,7 +640,7 @@ void omap_sr_disable(struct omap_sr *sr)
 /**
  * omap_sr_disable_reset_volt() - API to disable SR and reset the
  *				voltage processor voltage
- * @sr: struct omap_sr *
+ * @sr: struct smartreflex *
  *
  * This API is to be called from the kernel in order to disable
  * a particular smartreflex module. This API will in turn call
@@ -650,7 +648,7 @@ void omap_sr_disable(struct omap_sr *sr)
  * the smartreflex class disable to reset the VP voltage after
  * disabling smartreflex.
  */
-void omap_sr_disable_reset_volt(struct omap_sr *sr)
+void omap_sr_disable_reset_volt(struct smartreflex *sr)
 {
 	if (IS_ERR_OR_NULL(sr))
 		return;
@@ -689,24 +687,24 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
 /* PM Debug Fs enteries to enable disable smartreflex. */
 static int omap_sr_autocomp_show(void *data, u64 *val)
 {
-	struct omap_sr *sr_info = (struct omap_sr *) data;
+	struct smartreflex *sr = (struct smartreflex *) data;
 
-	if (!sr_info) {
-		pr_warning("%s: omap_sr struct not found\n", __func__);
+	if (!sr) {
+		pr_warning("%s: smartreflex struct not found\n", __func__);
 		return -EINVAL;
 	}
 
-	*val = sr_info->autocomp_active;
+	*val = sr->autocomp_active;
 
 	return 0;
 }
 
 static int omap_sr_autocomp_store(void *data, u64 val)
 {
-	struct omap_sr *sr_info = (struct omap_sr *) data;
+	struct smartreflex *sr = (struct smartreflex *) data;
 
-	if (!sr_info) {
-		pr_warning("%s: omap_sr struct not found\n", __func__);
+	if (!sr) {
+		pr_warning("%s: smartreflex struct not found\n", __func__);
 		return -EINVAL;
 	}
 
@@ -717,11 +715,11 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	/* control enable/disable only if there is a delta in value */
-	if (sr_info->autocomp_active != val) {
+	if (sr->autocomp_active != val) {
 		if (!val)
-			sr_stop_vddautocomp(sr_info);
+			sr_stop_vddautocomp(sr);
 		else
-			sr_start_vddautocomp(sr_info);
+			sr_start_vddautocomp(sr);
 	}
 
 	return 0;
@@ -732,7 +730,7 @@ DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 
 static int __init omap_sr_probe(struct platform_device *pdev)
 {
-	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
+	struct smartreflex *sr = kzalloc(sizeof(struct smartreflex), GFP_KERNEL);
 	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
@@ -740,9 +738,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	int i, ret = 0;
 	char *name;
 
-	if (!sr_info) {
-		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
-			__func__);
+	if (!sr) {
+		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -772,42 +769,41 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_irq_safe(&pdev->dev);
 
-	pdata->sr = sr_info;
-
-	sr_info->pdev = pdev;
-	sr_info->srid = pdev->id;
-	sr_info->voltdm = pdata->voltdm;
-	sr_info->nvalue_table = pdata->nvalue_table;
-	sr_info->nvalue_count = pdata->nvalue_count;
-	sr_info->err_weight = pdata->err_weight;
-	sr_info->err_maxlimit = pdata->err_maxlimit;
-	sr_info->accum_data = pdata->accum_data;
-	sr_info->senn_mod = pdata->senn_mod;
-	sr_info->senn_avgweight = pdata->senn_avgweight;
-	sr_info->senp_mod = pdata->senp_mod;
-	sr_info->senp_avgweight = pdata->senp_avgweight;
-	sr_info->autocomp_active = false;
-	sr_info->ip_type = pdata->ip_type;
-	sr_info->base = ioremap(mem->start, resource_size(mem));
-	if (!sr_info->base) {
+	pdata->sr = sr;
+
+	sr->pdev = pdev;
+	sr->srid = pdev->id;
+	sr->voltdm = pdata->voltdm;
+	sr->nvalue_count = pdata->nvalue_count;
+	sr->err_weight = pdata->err_weight;
+	sr->err_maxlimit = pdata->err_maxlimit;
+	sr->accum_data = pdata->accum_data;
+	sr->senn_mod = pdata->senn_mod;
+	sr->senn_avgweight = pdata->senn_avgweight;
+	sr->senp_mod = pdata->senp_mod;
+	sr->senp_avgweight = pdata->senp_avgweight;
+	sr->autocomp_active = false;
+	sr->ip_type = pdata->ip_type;
+	sr->base = ioremap(mem->start, resource_size(mem));
+	if (!sr->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		ret = -ENOMEM;
 		goto err_release_region;
 	}
 
 	if (irq)
-		sr_info->irq = irq->start;
+		sr->irq = irq->start;
 
-	sr_set_clk_length(sr_info);
+	sr_set_clk_length(sr);
 
-	list_add(&sr_info->node, &sr_list);
+	list_add(&sr->node, &sr_list);
 
 	/*
 	 * Call into late init to do intializations that require
 	 * both sr driver and sr class driver to be initiallized.
 	 */
 	if (sr_class) {
-		ret = sr_late_init(sr_info);
+		ret = sr_late_init(sr);
 		if (ret) {
 			pr_warning("%s: Error in SR late init\n", __func__);
 			return ret;
@@ -825,32 +821,32 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		}
 	}
 
-	name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
+	name = kasprintf(GFP_KERNEL, "sr_%s", sr->voltdm->name);
 	if (!name) {
 		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
 			__func__);
 		ret = -ENOMEM;
 		goto err_iounmap;
 	}
-	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
+	sr->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	kfree(name);
-	if (IS_ERR(sr_info->dbg_dir)) {
+	if (IS_ERR(sr->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
-		ret = PTR_ERR(sr_info->dbg_dir);
+		ret = PTR_ERR(sr->dbg_dir);
 		goto err_iounmap;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
-			sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
-	(void) debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
-			&sr_info->err_weight);
-	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
-			&sr_info->err_maxlimit);
-	(void) debugfs_create_x32("errminlimit", S_IRUGO, sr_info->dbg_dir,
-			&sr_info->err_minlimit);
-
-	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
+			sr->dbg_dir, (void *)sr, &pm_sr_fops);
+	(void) debugfs_create_x32("errweight", S_IRUGO, sr->dbg_dir,
+			&sr->err_weight);
+	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr->dbg_dir,
+			&sr->err_maxlimit);
+	(void) debugfs_create_x32("errminlimit", S_IRUGO, sr->dbg_dir,
+			&sr->err_minlimit);
+
+	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
@@ -858,36 +854,37 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_debugfs;
 	}
 
-	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
+	omap_voltage_get_volttable(sr->voltdm, &volt_data);
 	if (!volt_data) {
 		dev_warn(&pdev->dev, "%s: No Voltage table for the"
 			" corresponding vdd vdd_%s. Cannot create debugfs"
 			"entries for n-values\n",
-			__func__, sr_info->voltdm->name);
+			__func__, sr->voltdm->name);
 		ret = -ENODATA;
 		goto err_debugfs;
 	}
 
-	for (i = 0; i < sr_info->nvalue_count; i++) {
+	for (i = 0; i < sr->nvalue_count; i++) {
 		char name[NVALUE_NAME_LEN + 1];
 
-		snprintf(name, sizeof(name), "volt_%d",
+		/* XXX Also needs to include errminlimit! */
+		snprintf(name, sizeof(name), "volt_%u",
 			 volt_data[i].volt_nominal);
 		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
-				&(sr_info->nvalue_table[i].nvalue));
+				&(sr->nvalue_table[i].nvalue));
 	}
 
 	return ret;
 
 err_debugfs:
-	debugfs_remove_recursive(sr_info->dbg_dir);
+	debugfs_remove_recursive(sr->dbg_dir);
 err_iounmap:
-	list_del(&sr_info->node);
-	iounmap(sr_info->base);
+	list_del(&sr->node);
+	iounmap(sr->base);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 err_free_devinfo:
-	kfree(sr_info);
+	kfree(sr);
 
 	return ret;
 }
@@ -895,7 +892,7 @@ err_free_devinfo:
 static int __devexit omap_sr_remove(struct platform_device *pdev)
 {
 	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	struct omap_sr *sr_info;
+	struct smartreflex *sr;
 	struct resource *mem;
 
 	if (!pdata) {
@@ -903,21 +900,21 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	sr_info = pdata->sr;
-	if (IS_ERR(sr_info)) {
-		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
+	sr = pdata->sr;
+	if (IS_ERR(sr)) {
+		dev_warn(&pdev->dev, "%s: smartreflex struct not found\n",
 			__func__);
 		return -EINVAL;
 	}
 
-	if (sr_info->autocomp_active)
-		sr_stop_vddautocomp(sr_info);
-	if (sr_info->dbg_dir)
-		debugfs_remove_recursive(sr_info->dbg_dir);
+	if (sr->autocomp_active)
+		sr_stop_vddautocomp(sr);
+	if (sr->dbg_dir)
+		debugfs_remove_recursive(sr->dbg_dir);
 
-	list_del(&sr_info->node);
-	iounmap(sr_info->base);
-	kfree(sr_info);
+	list_del(&sr->node);
+	iounmap(sr->base);
+	kfree(sr);
 	pdata->sr = NULL;
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index e4930be..3341584 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -143,7 +143,7 @@
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
 /* XXX kerneldoc documentation needed */
-struct omap_sr {
+struct smartreflex {
 	int				srid;
 	int				ip_type;
 	int				nvalue_count;
@@ -212,10 +212,10 @@ struct omap_sr_dev_attr {
  *			based decisions.
  */
 struct omap_sr_class_data {
-	int (*enable)(struct omap_sr *sr);
-	int (*disable)(struct omap_sr *sr, int is_volt_reset);
-	int (*configure)(struct omap_sr *sr);
-	int (*notify)(struct omap_sr *sr, u32 status);
+	int (*enable)(struct smartreflex *sr);
+	int (*disable)(struct smartreflex *sr, int is_volt_reset);
+	int (*configure)(struct smartreflex *sr);
+	int (*notify)(struct smartreflex *sr, u32 status);
 	u8 notify_flags;
 	u8 class_type;
 };
@@ -248,7 +248,8 @@ struct omap_sr_nvalue_table {
  * @nvalue_table:	table containing the  efuse offsets and nvalues
  *			corresponding to them.
  * @voltdm:		Pointer to the voltage domain associated with the SR
- * @sr: struct omap_sr * associated with this SR device (allocated in *_probe())
+ * @sr: struct smartreflex:
+ *			associated with this SR device (allocated in *_probe())
  */
 struct smartreflex_platform_data {
 	int				ip_type;
@@ -263,30 +264,30 @@ struct smartreflex_platform_data {
 	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
-	struct omap_sr			*sr;
+	struct smartreflex		*sr;
 };
 
 /* Smartreflex module enable/disable interface */
-void omap_sr_enable(struct omap_sr *sr);
-void omap_sr_disable(struct omap_sr *sr);
-void omap_sr_disable_reset_volt(struct omap_sr *sr);
+void omap_sr_enable(struct smartreflex *sr);
+void omap_sr_disable(struct smartreflex *sr);
+void omap_sr_disable_reset_volt(struct smartreflex *sr);
 
 /* API to register the pmic specific data with the smartreflex driver. */
 void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
-int sr_enable(struct omap_sr *sr, unsigned long volt);
-void sr_disable(struct omap_sr *sr);
-int sr_configure_errgen(struct omap_sr *sr);
-int sr_configure_minmax(struct omap_sr *sr);
+int sr_enable(struct smartreflex *sr, unsigned long volt);
+void sr_disable(struct smartreflex *sr);
+int sr_configure_errgen(struct smartreflex *sr);
+int sr_configure_minmax(struct smartreflex *sr);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
 int sr_register_class(struct omap_sr_class_data *class_data);
 #else
-static inline void omap_sr_enable(struct omap_sr *sr) {}
-static inline void omap_sr_disable(struct omap_sr *sr) {}
+static inline void omap_sr_enable(struct smartreflex *sr) {}
+static inline void omap_sr_disable(struct smartreflex *sr) {}
 static inline void omap_sr_disable_reset_volt(
-		struct omap_sr *sr) {}
+		struct smartreflex *sr) {}
 static inline void omap_sr_register_pmic(
 		struct omap_sr_pmic_data *pmic_data) {}
 #endif
-- 
1.7.5.4

