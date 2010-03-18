From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 12/17] OMAP3: PM: Configurations for Smartreflex Class 2 and Smartreflex Class 3
Date: Thu, 18 Mar 2010 14:45:50 +0530
Message-ID: <1268903755-4151-13-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57341 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-12-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

There are two separate modules in SmartReflex-AVS :
MinMaxAvg module and Error module. Class3 uses the Error module only.
In Class2 you can choose between either module since it is software based.
The registers are mapped to the modules as followed:

MinMaxAvg module: AccumData, MinMaxAvgEnable, MinMaxAvgValid,
        MinMaxAvgAccumValid, SenVal, SenMin, SenMax, SenAverage,
        AverageWeight, MCUAccum, MCUValid, MCUBounds.

Error module: SenNGain, SenPGain, SenPRN, SenNRN, AvgError,
        SenError, VPBounds, ErrWeight, ErrMaxLimit, ErrMinLimit.

Shared between both: SRClkLength, SREnable, SenEnable, SenNEnable,
        SenPEnable, DelayCtrl, MCUDisableAck, ClkActivity.

This patch introduces class specific configuration of registers in smartreflex.c
This also allows for choosing between Error module and Minmaxavg module
for Class 2 SR. This patch allows allows for registering for smartreflex
interrupt handler and notification of interrupts in case requested by
the smartreflex class driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    1 +
 arch/arm/mach-omap2/smartreflex.c        |  201 ++++++++++++++++++++++++------
 arch/arm/mach-omap2/smartreflex.h        |   22 ++++
 3 files changed, 187 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 7904ed9..96c46c1 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -42,6 +42,7 @@ static int sr_class3_disable(int id)
 struct omap_smartreflex_class_data class3_data = {
 	.enable = sr_class3_enable,
 	.disable = sr_class3_disable,
+	.class_type = SR_CLASS3,
 };
 
 static int __init sr_class3_init(void)
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 3f93b6e..35848d9 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -40,6 +40,12 @@ struct omap_sr {
 	int				is_sr_reset;
 	int				is_autocomp_active;
 	u32				clk_length;
+	u32				err_weight;
+	u32				err_minlimit;
+	u32				err_maxlimit;
+	u32				accum_data;
+	u32				senn_avgweight;
+	u32				senp_avgweight;
 	unsigned int			irq;
 	struct platform_device		*pdev;
 	struct omap_sr_volt_tuple	*volt_tuple;
@@ -132,6 +138,24 @@ static int sr_match_volt(struct omap_sr *sr, unsigned long volt,
 	return false;
 }
 
+static irqreturn_t sr_omap_isr(int irq, void *data)
+{
+	struct omap_sr *sr_info = (struct omap_sr *)data;
+	u32 status;
+
+	/* Read the status bits */
+	status = sr_read_reg(sr_info, ERRCONFIG);
+
+	/* Clear them by writing back */
+	sr_write_reg(sr_info, ERRCONFIG, status);
+
+	/* Call the class driver notify function if registered*/
+	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
+		sr_class->notify(sr_info->srid, status);
+
+	return IRQ_HANDLED;
+}
+
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *sys_ck;
@@ -163,50 +187,96 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	}
 }
 
+static void sr_set_regfields(struct omap_sr *sr)
+{
+	/*
+	 * For time being these values are defined in smartreflex.h
+	 * and populated during init. May be they can be moved to board
+	 * file or pmic specific data structure. In that case these structure
+	 * fields will have to be populated using the pdata or pmic structure.
+	 */
+	if (cpu_is_omap343x()) {
+		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
+		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
+		sr->accum_data = OMAP3430_SR_ACCUMDATA;
+		if (sr->srid == SR1) {
+			sr->err_minlimit = OMAP3430_SR1_ERRMINLIMIT;
+			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
+			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
+		} else {
+			sr->err_minlimit = OMAP3430_SR2_ERRMINLIMIT;
+			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
+			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
+		}
+	}
+	/* TODO: 3630 and Omap4 specific bit field values */
+}
+
 static void sr_configure(struct omap_sr *sr)
 {
 	u32 sr_config;
 	u32 senp_en , senn_en;
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
+	/* Common settings for SR Class3 and SR Class2 */
 	if (sr->clk_length == 0)
 		sr_set_clk_length(sr);
 
 	senp_en = pdata->senp_mod;
 	senn_en = pdata->senn_mod;
-	if (sr->srid == SR1) {
-		sr_config = SR1_SRCONFIG_ACCUMDATA |
-			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
-			SRCONFIG_MINMAXAVG_EN |
-			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
-			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
-			SRCONFIG_DELAYCTRL;
-
-		sr_write_reg(sr, SRCONFIG, sr_config);
-		sr_write_reg(sr, AVGWEIGHT, SR1_AVGWEIGHT_SENPAVGWEIGHT |
-					SR1_AVGWEIGHT_SENNAVGWEIGHT);
 
+	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE | (senn_en << SRCONFIG_SENNENABLE_SHIFT) |
+		(senp_en << SRCONFIG_SENPENABLE_SHIFT) | SRCONFIG_DELAYCTRL;
+	sr_write_reg(sr, SRCONFIG, sr_config);
+
+	if ((sr_class->class_type == SR_CLASS3) || (sr_class->class_type ==
+		SR_CLASS2 && sr_class->calib_mode == SR_USE_ERROR_MOD)) {
+		/*
+		 * SR settings if using the ERROR module inside Smartreflex.
+		 * SR CLASS 3 by default uses only the ERROR module where as
+		 * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+		 * module.
+		 */
+		u32 sr_errconfig;
+
+		sr_modify_reg(sr, SRCONFIG, SRCONFIG_ERRGEN_EN,
+			SRCONFIG_ERRGEN_EN);
+		sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
+			(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
+			(sr->err_minlimit <<  ERRCONFIG_ERRMiNLIMIT_SHIFT);
 		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
 			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
-			(SR1_ERRWEIGHT | SR1_ERRMAXLIMIT | SR1_ERRMINLIMIT));
-
-	} else if (sr->srid == SR2) {
-		sr_config = SR2_SRCONFIG_ACCUMDATA |
-			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
-			SRCONFIG_MINMAXAVG_EN |
-			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
-			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
-			SRCONFIG_DELAYCTRL;
-
-		sr_write_reg(sr, SRCONFIG, sr_config);
-		sr_write_reg(sr, AVGWEIGHT, SR2_AVGWEIGHT_SENPAVGWEIGHT |
-					SR2_AVGWEIGHT_SENNAVGWEIGHT);
-		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
-			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
-			(SR2_ERRWEIGHT | SR2_ERRMAXLIMIT | SR2_ERRMINLIMIT));
-
+			sr_errconfig);
+		/* Enabling the interrupts if the ERROR module is used */
+		sr_modify_reg(sr, ERRCONFIG,
+			(ERRCONFIG_VPBOUNDINTEN),
+			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+	} else if ((sr_class->class_type == SR_CLASS2) &&
+			(sr_class->calib_mode == SR_USE_MINMAXAVG_MOD)) {
+		/*
+		 * SR settings if using the MINMAXAVG module inside
+		 * Smartreflex. SR CLASS 3 does not use this module where as
+		 * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+		 * module.
+		 */
+		u32 avgwt;
+
+		sr_modify_reg(sr, SRCONFIG, SRCONFIG_ACCUMDATA_MASK,
+			sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
+		avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
+			(sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
+		sr_write_reg(sr, AVGWEIGHT, avgwt);
+		/*
+		 * Enabling the interrupts if MINMAXAVG module is used.
+		 * TODO: check if all the interrupts are mandatory
+		 */
+		sr_modify_reg(sr, ERRCONFIG,
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+			ERRCONFIG_MCUBOUNDINTEN),
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
+			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
+			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
 	}
 	sr->is_sr_reset = 0;
 }
@@ -261,6 +331,36 @@ static void  sr_stop_vddautocomp(int srid)
 	}
 }
 
+/**
+ * This function handles the intializations which have to be done
+ * only when both sr device and class driver regiter has
+ * completed. This will be attempted to be called from both sr class
+ * driver register and sr device intializtion API's. Only one call
+ * will ultimately succeed.
+ *
+ * Currenly this function registers interrrupt handler for a particular SR
+ * if smartreflex class driver is already registered and has
+ * requested for interrupts and the SR interrupt line in present.
+ */
+static int sr_late_init(struct omap_sr *sr_info)
+{
+	char name[SMARTREFLEX_NAME_LEN];
+	int ret = 0;
+
+	if (sr_class->class_type == SR_CLASS2 &&
+		sr_class->notify_flags && sr_info->irq) {
+
+		sprintf(name, "sr%d", sr_info->srid);
+		ret = request_irq(sr_info->irq, sr_omap_isr,
+				IRQF_DISABLED, name, (void *)sr_info);
+		if (ret < 0)
+			pr_warning("ERROR in registering interrupt \
+				handler for SR%d. Smartreflex will \
+				not function as desired\n", sr_info->srid);
+	}
+	return ret;
+}
+
 /* Public Functions */
 
 /**
@@ -297,12 +397,6 @@ int sr_enable(int srid, unsigned long volt)
 	}
 
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
-
-	/* Enable the interrupt */
-	sr_modify_reg(sr, ERRCONFIG,
-			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
-			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
-
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
 	return true;
@@ -409,6 +503,8 @@ void omap_smartreflex_disable(int srid)
  */
 void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 {
+	struct omap_sr *sr_info;
+
 	if (!class_data) {
 		pr_warning("Smartreflex class data passed is NULL\n");
 		return;
@@ -418,7 +514,30 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 		pr_warning("Smartreflex class driver already registered\n");
 		return;
 	}
+
+	if ((class_data->class_type != SR_CLASS2) &&
+			(class_data->class_type != SR_CLASS3)) {
+		pr_warning("SR Class type passed is invalid. So cannot \
+				register the class structure\n");
+		return;
+	}
+
+	if ((class_data->class_type == SR_CLASS2) &&
+			!((class_data->calib_mode == SR_USE_MINMAXAVG_MOD) ||
+			(class_data->calib_mode == SR_USE_ERROR_MOD))) {
+		pr_warning("SR Class 2 specified but whether to use error \
+				module or minmaxavg module not specified\n");
+		return;
+	}
+
 	sr_class = class_data;
+
+	/*
+	 * Call into late init to do intializations that require
+	 * both sr driver and sr class driver to be initiallized.
+	 */
+	list_for_each_entry(sr_info, &sr_list, node)
+		sr_late_init(sr_info);
 }
 
 /* PM Debug Fs enteries to enable disable smartreflex.*/
@@ -472,6 +591,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	if (odev->hwmods[0]->mpu_irqs)
 		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
 	sr_set_clk_length(sr_info);
+	sr_set_regfields(sr_info);
 
 	/* Create the debug fs enteries */
 	sprintf(name, "sr%d_autocomp", sr_info->srid);
@@ -480,8 +600,15 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 
 	odev->hwmods[0]->dev_attr = sr_info;
 	list_add(&sr_info->node, &sr_list);
-	pr_info("SmartReflex driver initialized\n");
 
+	/*
+	 * Call into late init to do intializations that require
+	 * both sr driver and sr class driver to be initiallized.
+	 */
+	if (sr_class)
+		ret = sr_late_init(sr_info);
+
+	pr_info("SmartReflex driver initialized\n");
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 12a76c4..52309e0 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -124,6 +124,24 @@ extern struct dentry *pm_dbg_main_dir;
 #endif
 
 #ifdef CONFIG_OMAP_SMARTREFLEX
+/*
+ * The smart reflex driver supports both CLASS2 and CLASS3 SR.
+ * The smartreflex class driver should pass the class type.
+ * Should be used to populate the class_type field of the
+ * omap_smartreflex_class_data structure.
+ */
+#define SR_CLASS2	0x1
+#define SR_CLASS3	0x2
+
+/*
+ * CLASS2 SR can use either the MINMAXAVG module or the ERROR module
+ * of the Smartreflex. Should be used to populate the mod_use field
+ * of omap_smartreflex_class_data structure is class_type is chosen
+ * as SR_CLASS2.
+ */
+#define SR_USE_MINMAXAVG_MOD	0x1
+#define SR_USE_ERROR_MOD	0x2
+
 /**
  * omap_smartreflex_class_data : Structure to be populated by
  * Smartreflex class driver with corresponding class enable disable API's
@@ -135,6 +153,9 @@ extern struct dentry *pm_dbg_main_dir;
  * @notify_flags - specify the events to be notified to the class driver
  * @class_type - specify which smartreflex class. Can be used by the SR driver
  *		to take any class based decisions.
+ * @calib_mode - specify whether to use the error module or minmaxavg module
+ *		for smartreflex calibrations in case of class2 SR. In case of
+ *		class 3 SR only error module is used.
  */
 struct omap_smartreflex_class_data {
 	int (*enable)(int sr_id);
@@ -142,6 +163,7 @@ struct omap_smartreflex_class_data {
 	int (*notify)(int sr_id, u32 status);
 	u8 notify_flags;
 	u8 class_type;
+	u8 calib_mode;
 };
 
 /**
-- 
1.7.0.rc1.33.g07cf0f

