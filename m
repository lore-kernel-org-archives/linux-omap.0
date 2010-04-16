From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 14/22] OMAP3: PM: Configurations for Smartreflex Class 2 and Smartreflex Class 3
Date: Fri, 16 Apr 2010 14:33:09 +0530
Message-ID: <1271408597-3066-15-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
 <1271408597-3066-10-git-send-email-thara@ti.com>
 <1271408597-3066-11-git-send-email-thara@ti.com>
 <1271408597-3066-12-git-send-email-thara@ti.com>
 <1271408597-3066-13-git-send-email-thara@ti.com>
 <1271408597-3066-14-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36077 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964Ab0DPJDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:31 -0400
In-Reply-To: <1271408597-3066-14-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

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

This patch generates separate API's to configure the two modules
which can be used by the smartreflex class driver as per its
requirement. This patch allows allows for registering for smartreflex
interrupt handler and notification of interrupts in case requested by
the smartreflex class driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    7 +
 arch/arm/mach-omap2/smartreflex.c        |  253 +++++++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h        |   14 ++
 3 files changed, 219 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 66696be..53bfd05 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -39,10 +39,17 @@ static int sr_class3_disable(int id)
 	return true;
 }
 
+static void sr_class3_configure(int id)
+{
+	sr_configure_errgen(id);
+}
+
 /* SR class3 structure */
 struct omap_smartreflex_class_data class3_data = {
 	.enable = sr_class3_enable,
 	.disable = sr_class3_disable,
+	.configure = sr_class3_configure,
+	.class_type = SR_CLASS3,
 };
 
 int __init sr_class3_init(void)
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c6942e9..d043951 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -41,6 +41,12 @@ struct omap_sr {
 	int			is_sr_reset;
 	int			is_autocomp_active;
 	u32			clk_length;
+	u32			err_weight;
+	u32			err_minlimit;
+	u32			err_maxlimit;
+	u32			accum_data;
+	u32			senn_avgweight;
+	u32			senp_avgweight;
 	unsigned int		irq;
 	struct platform_device	*pdev;
 	struct list_head	node;
@@ -111,6 +117,24 @@ static void sr_clk_disable(struct omap_sr *sr)
 	sr->is_sr_reset = 1;
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
@@ -142,64 +166,41 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	}
 }
 
-static void sr_configure(struct omap_sr *sr)
+static void sr_set_regfields(struct omap_sr *sr)
 {
-	u32 sr_config;
-	u32 senp_en , senn_en;
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-
-	if (sr->clk_length == 0)
-		sr_set_clk_length(sr);
-
-	senp_en = pdata->senp_mod;
-	senn_en = pdata->senn_mod;
-	if (sr->srid == VDD1) {
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
-
-		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
-			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
-			(SR1_ERRWEIGHT | SR1_ERRMAXLIMIT | SR1_ERRMINLIMIT));
-
-	} else if (sr->srid == VDD2) {
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
+		if (sr->srid == VDD1) {
+			sr->err_minlimit = OMAP3430_SR1_ERRMINLIMIT;
+			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
+			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
+		} else {
+			sr->err_minlimit = OMAP3430_SR2_ERRMINLIMIT;
+			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
+			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
+		}
 	}
-	sr->is_sr_reset = 0;
+	/* TODO: 3630 and Omap4 specific bit field values */
 }
 
 static void sr_start_vddautocomp(struct omap_sr *sr)
 {
-	if (!sr_class || !(sr_class->enable)) {
+	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
 
 	if (sr->is_sr_reset == 1) {
 		sr_clk_enable(sr);
-		sr_configure(sr);
+		sr_class->configure(sr->srid);
 	}
 
 	sr->is_autocomp_active = 1;
@@ -224,9 +225,139 @@ static void  sr_stop_vddautocomp(struct omap_sr *sr)
 	}
 }
 
+/*
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
+ * sr_configure_errgen : Configures the smrtreflex to perform AVS using the
+ *			 error generator module.
+ * @srid - The id of the sr module to be configured.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * configure the error generator module inside the smartreflex module.
+ * SR settings if using the ERROR module inside Smartreflex.
+ * SR CLASS 3 by default uses only the ERROR module where as
+ * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+ * module.
+ */
+void sr_configure_errgen(int srid)
+{
+	u32 sr_config, sr_errconfig;
+	u32 senp_en , senn_en;
+	struct omap_sr *sr = _sr_lookup(srid);
+	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
+
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid + 1);
+		return;
+	}
+
+	if (sr->clk_length == 0)
+		sr_set_clk_length(sr);
+
+	senp_en = pdata->senp_mod;
+	senn_en = pdata->senn_mod;
+	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
+		(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
+		(senp_en << SRCONFIG_SENPENABLE_SHIFT) | SRCONFIG_DELAYCTRL;
+	sr_write_reg(sr, SRCONFIG, sr_config);
+	sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
+		(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
+		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
+	sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
+		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
+		sr_errconfig);
+	/* Enabling the interrupts if the ERROR module is used */
+	sr_modify_reg(sr, ERRCONFIG,
+		(ERRCONFIG_VPBOUNDINTEN),
+		(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+	sr->is_sr_reset = 0;
+}
+
+/**
+ * sr_configure_minmax : Configures the smrtreflex to perform AVS using the
+ *			 minmaxavg module.
+ * @srid - The id of the sr module to be configured.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * configure the minmaxavg module inside the smartreflex module.
+ * SR settings if using the ERROR module inside Smartreflex.
+ * SR CLASS 3 by default uses only the ERROR module where as
+ * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+ * module.
+ */
+void sr_configure_minmax(int srid)
+{
+	u32 sr_config, sr_avgwt;
+	u32 senp_en , senn_en;
+	struct omap_sr *sr = _sr_lookup(srid);
+	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
+
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid + 1);
+		return;
+	}
+
+	if (sr->clk_length == 0)
+		sr_set_clk_length(sr);
+
+	senp_en = pdata->senp_mod;
+	senn_en = pdata->senn_mod;
+	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE | (senn_en << SRCONFIG_SENNENABLE_SHIFT) |
+		(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
+		(sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT) |
+		SRCONFIG_DELAYCTRL;
+	sr_write_reg(sr, SRCONFIG, sr_config);
+	sr_avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
+		(sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
+	sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
+	/*
+	 * Enabling the interrupts if MINMAXAVG module is used.
+	 * TODO: check if all the interrupts are mandatory
+	 */
+	sr_modify_reg(sr, ERRCONFIG,
+		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+		ERRCONFIG_MCUBOUNDINTEN),
+		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
+		 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
+		 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
+	sr->is_sr_reset = 0;
+}
+
+/**
  * sr_enable : Enables the smartreflex module.
  * @srid - The id of the sr module to be enabled.
  * @volt - The voltage at which the Voltage domain associated with
@@ -261,12 +392,6 @@ int sr_enable(int srid, unsigned long volt)
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
@@ -315,7 +440,7 @@ void omap_smartreflex_enable(int srid)
 		return;
 	}
 
-	if (!sr_class || !(sr_class->enable)) {
+	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
@@ -324,7 +449,7 @@ void omap_smartreflex_enable(int srid)
 		if (sr->is_sr_reset == 1) {
 			/* Enable SR clks */
 			sr_clk_enable(sr);
-			sr_configure(sr);
+			sr_class->configure(srid);
 			if (!sr_class->enable(srid))
 				sr_clk_disable(sr);
 		}
@@ -373,6 +498,8 @@ void omap_smartreflex_disable(int srid)
  */
 void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 {
+	struct omap_sr *sr_info;
+
 	if (!class_data) {
 		pr_warning("Smartreflex class data passed is NULL\n");
 		return;
@@ -382,7 +509,15 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 		pr_warning("Smartreflex class driver already registered\n");
 		return;
 	}
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
@@ -436,6 +571,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	if (odev->hwmods[0]->mpu_irqs)
 		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
 	sr_set_clk_length(sr_info);
+	sr_set_regfields(sr_info);
 
 	/* Create the debug fs enteries */
 	sprintf(name, "sr%d_autocomp", sr_info->srid + 1);
@@ -443,8 +579,15 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 				(void *)sr_info, &pm_sr_fops);
 
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
index 85cfbe3..0cdee6e 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -151,12 +151,23 @@ struct omap_smartreflex_dev_data {
 };
 
 #ifdef CONFIG_OMAP_SMARTREFLEX
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
 /**
  * omap_smartreflex_class_data : Structure to be populated by
  * Smartreflex class driver with corresponding class enable disable API's
  *
  * @enable - API to enable a particular class smaartreflex.
  * @disable - API to disable a particular class smartreflex.
+ * @configure - API to configure a particular class smartreflex.
  * @notify - API to notify the class driver about an event in SR. Not needed
  *		for class3.
  * @notify_flags - specify the events to be notified to the class driver
@@ -166,6 +177,7 @@ struct omap_smartreflex_dev_data {
 struct omap_smartreflex_class_data {
 	int (*enable)(int sr_id);
 	int (*disable)(int sr_id);
+	void (*configure)(int sr_id);
 	int (*notify)(int sr_id, u32 status);
 	u8 notify_flags;
 	u8 class_type;
@@ -207,6 +219,8 @@ void omap_smartreflex_disable(int srid);
  */
 int sr_enable(int srid, unsigned long volt);
 void sr_disable(int srid);
+void sr_configure_errgen(int srid);
+void sr_configure_minmax(int srid);
 
 /*
  * API to register the smartreflex class driver with the smartreflex driver
-- 
1.7.0.rc1.33.g07cf0f

