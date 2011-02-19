From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 17/19] omap3+: sr: make enable path use volt_data pointer
Date: Sat, 19 Feb 2011 17:31:56 +0530
Message-ID: <1298116918-30744-18-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45038 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754406Ab1BSMEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:04:23 -0500
Received: by gyg4 with SMTP id 4so1897175gyg.36
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:04:22 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Passing the volt_data pointers accross allows us to save us the effort
of looking up the voltage data pointer from the voltage value at
multiple layers, we need to look at the voltage data in dvfs layer
for further processing, so modify the APIs to pass the voltage data
pointer all the way through to lower layers to the smartreflex class
drivers.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c      |   13 +++----------
 arch/arm/mach-omap2/smartreflex.c             |   25 ++++++++++++-------------
 arch/arm/plat-omap/include/plat/smartreflex.h |    8 +++++---
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 2195668..7ac88da 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -13,19 +13,12 @@
 
 #include <plat/smartreflex.h>
 
-static int sr_class3_enable(struct voltagedomain *voltdm)
+static int sr_class3_enable(struct voltagedomain *voltdm,
+		struct omap_volt_data *volt_data)
 {
-	unsigned long volt = omap_get_operation_voltage(
-		omap_voltage_get_nom_volt(voltdm));
-
-	if (!volt) {
-		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
-				__func__, voltdm->name);
-		return -ENODATA;
-	}
 
 	omap_vp_enable(voltdm);
-	return sr_enable(voltdm, volt);
+	return sr_enable(voltdm, volt_data);
 }
 
 static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 0301186..3a5f2f6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -302,7 +302,8 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
-	if (!sr_class->enable(sr->voltdm))
+	if (!sr_class->enable(sr->voltdm,
+			omap_voltage_get_nom_volt(sr->voltdm)))
 		sr->autocomp_active = true;
 }
 
@@ -618,7 +619,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 /**
  * sr_enable() - Enables the smartreflex module.
  * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
- * @volt:	The voltage at which the Voltage domain associated with
+ * @volt_data:	The voltage at which the Voltage domain associated with
  *		the smartreflex module is operating at.
  *		This is required only to program the correct Ntarget value.
  *
@@ -626,10 +627,9 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
  * enable a smartreflex module. Returns 0 on success. Returns error
  * value if the voltage passed is wrong or if ntarget value is wrong.
  */
-int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
+int sr_enable(struct voltagedomain *voltdm, struct omap_volt_data *volt_data)
 {
 	u32 nvalue_reciprocal;
-	struct omap_volt_data *volt_data;
 	struct omap_sr *sr = _sr_lookup(voltdm);
 	int ret;
 
@@ -639,19 +639,16 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 		return -EINVAL;
 	}
 
-	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
-
-	if (IS_ERR(volt_data)) {
-		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
-			"for nominal voltage %ld\n", __func__, volt);
-		return -ENODATA;
+	if (IS_ERR_OR_NULL(volt_data)) {
+		dev_warn(&sr->pdev->dev, "%s: bad voltage data\n", __func__);
+		return -EINVAL;
 	}
 
 	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
 
 	if (!nvalue_reciprocal) {
 		dev_warn(&sr->pdev->dev, "%s: NVALUE = 0 at voltage %ld\n",
-			__func__, volt);
+			__func__, omap_get_operation_voltage(volt_data));
 		return -ENODATA;
 	}
 
@@ -808,13 +805,15 @@ int sr_register_class(struct omap_sr_class_data *class_data)
  * omap_sr_enable() -  API to enable SR clocks and to call into the
  *			registered smartreflex class enable API.
  * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
+ * @volt_data:	Voltage data to go to
  *
  * This API is to be called from the kernel in order to enable
  * a particular smartreflex module. This API will do the initial
  * configurations to turn on the smartreflex module and in turn call
  * into the registered smartreflex class enable API.
  */
-void omap_sr_enable(struct voltagedomain *voltdm)
+void omap_sr_enable(struct voltagedomain *voltdm,
+			struct omap_volt_data *volt_data)
 {
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
@@ -833,7 +832,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->enable(voltdm);
+	sr_class->enable(voltdm, volt_data);
 }
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
index d420f44..07f35b2 100644
--- a/arch/arm/plat-omap/include/plat/smartreflex.h
+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
@@ -185,7 +185,8 @@ struct omap_sr_pmic_data {
  * @class_priv_data:	Class specific private data (optional)
  */
 struct omap_sr_class_data {
-	int (*enable)(struct voltagedomain *voltdm);
+	int (*enable)(struct voltagedomain *voltdm,
+			struct omap_volt_data *volt_data);
 	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
 	int (*class_init)(struct voltagedomain *voltdm, void *class_priv_data);
 	int (*class_deinit)(struct voltagedomain *voltdm,
@@ -232,7 +233,8 @@ struct omap_sr_data {
 };
 
 /* Smartreflex module enable/disable interface */
-void omap_sr_enable(struct voltagedomain *voltdm);
+void omap_sr_enable(struct voltagedomain *voltdm,
+			struct omap_volt_data *volt_data);
 void omap_sr_disable(struct voltagedomain *voltdm);
 void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
 
@@ -240,7 +242,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
 void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
-int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
+int sr_enable(struct voltagedomain *voltdm, struct omap_volt_data *volt_data);
 void sr_disable(struct voltagedomain *voltdm);
 int sr_notifier_control(struct voltagedomain *voltdm, bool enable);
 int sr_configure_errgen(struct voltagedomain *voltdm);
-- 
1.7.1

