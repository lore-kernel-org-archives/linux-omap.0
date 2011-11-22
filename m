From: jean.pihet@newoldbits.com
Subject: [PATCH 03/26] OMAP3/4: SmartReflex: API should use struct omap_sr *, not struct voltagedomain *
Date: Tue, 22 Nov 2011 16:05:47 +0100
Message-ID: <1321974370-25800-4-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab1KVPGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:54 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:54 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The SmartReflex API should take pointers to a SmartReflex instance-specific
structure record, not pointers to a OMAP subarchitecture-specific struct
voltagedomain *.  The SmartReflex drivers should not be tightly coupled
to the SoC subarchitecture; these IP blocks could appear on different
subarchitectures.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    6 +-
 arch/arm/mach-omap2/smartreflex.c        |   68 ++++++++----------------------
 arch/arm/mach-omap2/smartreflex.h        |   20 ++++----
 3 files changed, 31 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 97bdb0b..0205f17 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -24,13 +24,13 @@ static int sr_class3_enable(struct omap_sr *sr)
 	}
 
 	omap_vp_enable(sr->voltdm);
-	return sr_enable(sr->voltdm, volt);
+	return sr_enable(sr, volt);
 }
 
 static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
 {
 	omap_vp_disable(sr->voltdm);
-	sr_disable(sr->voltdm);
+	sr_disable(sr);
 	if (is_volt_reset)
 		voltdm_reset(sr->voltdm);
 
@@ -39,7 +39,7 @@ static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
 
 static int sr_class3_configure(struct omap_sr *sr)
 {
-	return sr_configure_errgen(sr->voltdm);
+	return sr_configure_errgen(sr);
 }
 
 /* SR class3 structure */
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 01ff78a..55966bc 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -364,7 +364,7 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
 /**
  * sr_configure_errgen() - Configures the smrtreflex to perform AVS using the
  *			 error generator module.
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the smartreflex class driver to
  * configure the error generator module inside the smartreflex module.
@@ -373,18 +373,14 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
  * SR CLASS 2 can choose between ERROR module and MINMAXAVG
  * module. Returns 0 on success and error value in case of failure.
  */
-int sr_configure_errgen(struct voltagedomain *voltdm)
+int sr_configure_errgen(struct omap_sr *sr)
 {
 	u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
 	u32 vpboundint_st, senp_en = 0, senn_en = 0;
 	u8 senp_shift, senn_shift;
-	struct omap_sr *sr = _sr_lookup(voltdm);
 
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
-	}
 
 	if (!sr->clk_length)
 		sr_set_clk_length(sr);
@@ -433,7 +429,7 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 /**
  * sr_configure_minmax() - Configures the smrtreflex to perform AVS using the
  *			 minmaxavg module.
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the smartreflex class driver to
  * configure the minmaxavg module inside the smartreflex module.
@@ -442,18 +438,14 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
  * SR CLASS 2 can choose between ERROR module and MINMAXAVG
  * module. Returns 0 on success and error value in case of failure.
  */
-int sr_configure_minmax(struct voltagedomain *voltdm)
+int sr_configure_minmax(struct omap_sr *sr)
 {
 	u32 sr_config, sr_avgwt;
 	u32 senp_en = 0, senn_en = 0;
 	u8 senp_shift, senn_shift;
-	struct omap_sr *sr = _sr_lookup(voltdm);
 
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
-	}
 
 	if (!sr->clk_length)
 		sr_set_clk_length(sr);
@@ -509,7 +501,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 
 /**
  * sr_enable() - Enables the smartreflex module.
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  * @volt:	The voltage at which the Voltage domain associated with
  *		the smartreflex module is operating at.
  *		This is required only to program the correct Ntarget value.
@@ -518,18 +510,14 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
  * enable a smartreflex module. Returns 0 on success. Returns error
  * value if the voltage passed is wrong or if ntarget value is wrong.
  */
-int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
+int sr_enable(struct omap_sr *sr, unsigned long volt)
 {
 	u32 nvalue_reciprocal;
 	struct omap_volt_data *volt_data;
-	struct omap_sr *sr = _sr_lookup(voltdm);
 	int ret;
 
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
-	}
 
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
 
@@ -575,15 +563,10 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
  * This API is to be called from the smartreflex class driver to
  * disable a smartreflex module.
  */
-void sr_disable(struct voltagedomain *voltdm)
+void sr_disable(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(voltdm);
-
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return;
-	}
 
 	/* Check if SR clocks are already disabled. If yes do nothing */
 	if (pm_runtime_suspended(&sr->pdev->dev))
@@ -649,15 +632,10 @@ int sr_register_class(struct omap_sr_class_data *class_data)
  * configurations to turn on the smartreflex module and in turn call
  * into the registered smartreflex class enable API.
  */
-void omap_sr_enable(struct voltagedomain *voltdm)
+void omap_sr_enable(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(voltdm);
-
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return;
-	}
 
 	if (!sr->autocomp_active)
 		return;
@@ -682,15 +660,10 @@ void omap_sr_enable(struct voltagedomain *voltdm)
  * the smartreflex class disable not to reset the VP voltage after
  * disabling smartreflex.
  */
-void omap_sr_disable(struct voltagedomain *voltdm)
+void omap_sr_disable(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(voltdm);
-
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return;
-	}
 
 	if (!sr->autocomp_active)
 		return;
@@ -707,7 +680,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 /**
  * omap_sr_disable_reset_volt() - API to disable SR and reset the
  *				voltage processor voltage
- * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @sr: struct omap_sr *
  *
  * This API is to be called from the kernel in order to disable
  * a particular smartreflex module. This API will in turn call
@@ -715,15 +688,10 @@ void omap_sr_disable(struct voltagedomain *voltdm)
  * the smartreflex class disable to reset the VP voltage after
  * disabling smartreflex.
  */
-void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
+void omap_sr_disable_reset_volt(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(voltdm);
-
-	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, voltdm->name);
+	if (IS_ERR_OR_NULL(sr))
 		return;
-	}
 
 	if (!sr->autocomp_active)
 		return;
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index f435972..305776f 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -244,26 +244,26 @@ struct omap_sr_data {
 };
 
 /* Smartreflex module enable/disable interface */
-void omap_sr_enable(struct voltagedomain *voltdm);
-void omap_sr_disable(struct voltagedomain *voltdm);
-void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
+void omap_sr_enable(struct omap_sr *sr);
+void omap_sr_disable(struct omap_sr *sr);
+void omap_sr_disable_reset_volt(struct omap_sr *sr);
 
 /* API to register the pmic specific data with the smartreflex driver. */
 void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
-int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
-void sr_disable(struct voltagedomain *voltdm);
-int sr_configure_errgen(struct voltagedomain *voltdm);
-int sr_configure_minmax(struct voltagedomain *voltdm);
+int sr_enable(struct omap_sr *sr, unsigned long volt);
+void sr_disable(struct omap_sr *sr);
+int sr_configure_errgen(struct omap_sr *sr);
+int sr_configure_minmax(struct omap_sr *sr);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
 int sr_register_class(struct omap_sr_class_data *class_data);
 #else
-static inline void omap_sr_enable(struct voltagedomain *voltdm) {}
-static inline void omap_sr_disable(struct voltagedomain *voltdm) {}
+static inline void omap_sr_enable(struct omap_sr *sr) {}
+static inline void omap_sr_disable(struct omap_sr *sr) {}
 static inline void omap_sr_disable_reset_volt(
-		struct voltagedomain *voltdm) {}
+		struct omap_sr *sr) {}
 static inline void omap_sr_register_pmic(
 		struct omap_sr_pmic_data *pmic_data) {}
 #endif
-- 
1.7.5.4

