From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 07/17] OMAP3: PM: Smartreflex class related changes for smartreflex.c
Date: Thu, 18 Mar 2010 14:45:45 +0530
Message-ID: <1268903755-4151-8-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-7-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

OMAP3 smartreflex modules are capable of two different classes
of implementaion -
	Class-2: Continuous Software Calibration
	Class-3: Continuous Hardware Calibration.
OMAP3 along with T2/Gaia supports the Class 3 implementaion.
With a different PMIC it can support Class 2 implementaion also.

The idea behind this patch is that smartreflex.c should be able
to support both the classes of Smartreflex and the class specific
details for smartreflex should stay out of this file in a separate
class file.
This patch introduces smartreflex class specific hooks in
smartreflex.c. This patch only takes care of smartreflex enable
disable hooks which differ between Class 2 and Class 3. There
are some register setting changes between both the classes which
will be taken care of in a later patch.
This will form the base for adding class specific
drivers in later patches.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  259 ++++++++++++++++++++----------------
 arch/arm/mach-omap2/smartreflex.h |   44 ++++++-
 2 files changed, 181 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c0345e7..76c749a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -57,6 +57,7 @@ struct omap_sr {
 
 /* sr_list contains all the instances of smartreflex module */
 static LIST_HEAD(sr_list);
+static struct omap_smartreflex_class_data *sr_class;
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
@@ -428,12 +429,84 @@ static int sr_reset_voltage(int srid)
 	return 0;
 }
 
-static int sr_enable(struct omap_sr *sr, unsigned long volt)
+static void sr_start_vddautocomp(int srid)
+{
+	struct omap_sr *sr = _sr_lookup(srid);
+
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
+		return;
+	}
+
+	if (!sr_class || !(sr_class->enable)) {
+		pr_warning("smartreflex class driver not registered\n");
+		return;
+	}
+
+	if (sr->is_sr_reset == 1) {
+		sr_clk_enable(sr);
+		sr_configure(sr);
+	}
+
+	sr->is_autocomp_active = 1;
+	if (!sr_class->enable(srid)) {
+		sr->is_autocomp_active = 0;
+		if (sr->is_sr_reset == 1)
+			sr_clk_disable(sr);
+	}
+}
+
+static void  sr_stop_vddautocomp(int srid)
+{
+	struct omap_sr *sr = _sr_lookup(srid);
+
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
+		return;
+	}
+
+	if (!sr_class || !(sr_class->disable)) {
+		pr_warning("smartreflex class driver not registered\n");
+		return;
+	}
+
+	if (sr->is_autocomp_active == 1) {
+		sr_class->disable(srid);
+		sr_clk_disable(sr);
+		sr->is_autocomp_active = 0;
+		/* Reset the volatage for current OPP */
+		sr_reset_voltage(srid);
+	}
+}
+
+/* Public Functions */
+
+/**
+ * sr_enable : Enables the smartreflex module.
+ * @srid - The id of the sr module to be enabled.
+ * @target_opp_no - The OPP at which the Voltage domain associated with
+ * the smartreflex module is operating at. This is required only to program
+ * the correct Ntarget value.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * enable a smartreflex module. Returns true on success.Returns false if the
+ * target opp id passed is wrong or if ntarget value is wrong.
+ */
+int sr_enable(int srid, unsigned long volt)
 {
 	u32 nvalue_reciprocal, v;
 	struct omap_sr_volt_data volt_data;
+	struct omap_sr *sr = _sr_lookup(srid);
 	char vsel;
 
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
+		return false;
+	}
+
 	if (!sr_match_volt(sr, volt, &volt_data))
 		return false;
 	nvalue_reciprocal = volt_data.sr_nvalue;
@@ -495,10 +568,24 @@ static int sr_enable(struct omap_sr *sr, unsigned long volt)
 	return true;
 }
 
-static void sr_disable(struct omap_sr *sr)
+/**
+ * sr_disable : Disables the smartreflex module.
+ * @srid - The id of the sr module to be disabled.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * disable a smartreflex module.
+ */
+void sr_disable(int srid)
 {
+	struct omap_sr *sr = _sr_lookup(srid);
 	u32 i = 0;
 
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
+		return;
+	}
+
 	sr->is_sr_reset = 1;
 
 	/* SRCONFIG - disable SR */
@@ -536,8 +623,17 @@ static void sr_disable(struct omap_sr *sr)
 	}
 }
 
-
-void sr_start_vddautocomp(int srid, unsigned long volt)
+/**
+ * omap_smartreflex_enable : API to enable SR clocks and to call into the
+ * registered smartreflex class enable API.
+ * @srid - The id of the sr module to be enabled.
+ *
+ * This API is to be called from the kernel in order to enable
+ * a particular smartreflex module. This API will do the initial
+ * configurations to turn on the smartreflex module and in turn call
+ * into the registered smartreflex class enable API.
+ */
+void omap_smartreflex_enable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -547,51 +643,8 @@ void sr_start_vddautocomp(int srid, unsigned long volt)
 		return;
 	}
 
-	if (sr->is_sr_reset == 1) {
-		sr_clk_enable(sr);
-		sr_configure(sr);
-	}
-
-	sr->is_autocomp_active = 1;
-	if (!sr_enable(sr, volt)) {
-		sr->is_autocomp_active = 0;
-		if (sr->is_sr_reset == 1)
-			sr_clk_disable(sr);
-	}
-}
-EXPORT_SYMBOL(sr_start_vddautocomp);
-
-int sr_stop_vddautocomp(int srid)
-{
-	struct omap_sr *sr = _sr_lookup(srid);
-
-	if (!sr) {
-		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
-		return false;
-	}
-
-	if (sr->is_autocomp_active == 1) {
-		sr_disable(sr);
-		sr_clk_disable(sr);
-		sr->is_autocomp_active = 0;
-		/* Reset the volatage for current OPP */
-		sr_reset_voltage(srid);
-		return true;
-	} else
-		return false;
-
-}
-EXPORT_SYMBOL(sr_stop_vddautocomp);
-
-void omap_smartreflex_enable(int srid)
-{
-	unsigned long curr_volt = 0;
-	struct omap_sr *sr = _sr_lookup(srid);
-
-	if (!sr) {
-		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+	if (!sr_class || !(sr_class->enable)) {
+		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
 
@@ -599,28 +652,24 @@ void omap_smartreflex_enable(int srid)
 		if (sr->is_sr_reset == 1) {
 			/* Enable SR clks */
 			sr_clk_enable(sr);
-
-			if (srid == SR1)
-				curr_volt = get_curr_vdd1_voltage();
-			else if (srid == SR2)
-				curr_volt = get_curr_vdd2_voltage();
-
-			if (!curr_volt) {
-				pr_info("Current voltage unknown \
-						 Cannot configure SR\n");
-			}
-
 			sr_configure(sr);
-
-			if (!sr_enable(sr, curr_volt))
+			if (!sr_class->enable(srid))
 				sr_clk_disable(sr);
 		}
 	}
 }
 
+/**
+ * omap_smartreflex_disable : API to disable SR clocks and to call into the
+ * registered smartreflex class disable API.
+ * @srid - The id of the sr module to be disabled.
+ *
+ * This API is to be called from the kernel in order to disable
+ * a particular smartreflex module. This API will in turn call
+ * into the registered smartreflex class disable API.
+ */
 void omap_smartreflex_disable(int srid)
 {
-	u32 i = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
 
 	if (!sr) {
@@ -629,53 +678,43 @@ void omap_smartreflex_disable(int srid)
 		return;
 	}
 
+	if (!sr_class || !(sr_class->disable)) {
+		pr_warning("smartreflex class driver not registered\n");
+		return;
+	}
+
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 0) {
-
-			sr->is_sr_reset = 1;
-			/* SRCONFIG - disable SR */
-			sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE,
-							~SRCONFIG_SRENABLE);
-
+			sr_class->disable(srid);
 			/* Disable SR clk */
 			sr_clk_disable(sr);
-			if (sr->srid == SR1) {
-				/* Wait for VP idle before disabling VP */
-				while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
-						OMAP3_PRM_VP1_STATUS_OFFSET))
-						&& i++ < MAX_TRIES)
-					udelay(1);
-
-				if (i >= MAX_TRIES)
-					pr_warning("VP1 not idle, still going \
-						ahead with VP1 disable\n");
-
-				/* Disable VP1 */
-				prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE,
-						OMAP3430_GR_MOD,
-						OMAP3_PRM_VP1_CONFIG_OFFSET);
-			} else if (sr->srid == SR2) {
-				/* Wait for VP idle before disabling VP */
-				while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
-						OMAP3_PRM_VP2_STATUS_OFFSET))
-						&& i++ < MAX_TRIES)
-					udelay(1);
-
-				if (i >= MAX_TRIES)
-					pr_warning("VP2 not idle, still going \
-						 ahead with VP2 disable\n");
-
-				/* Disable VP2 */
-				prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE,
-						OMAP3430_GR_MOD,
-						OMAP3_PRM_VP2_CONFIG_OFFSET);
-			}
 			/* Reset the volatage for current OPP */
 			sr_reset_voltage(srid);
 		}
 	}
 }
 
+/**
+ * omap_sr_register_class : API to register a smartreflex class parameters.
+ * @class_data - The structure containing various sr class specific data.
+ *
+ * This API is to be called by the smartreflex class driver to register itself
+ * with the smartreflex driver during init.
+ */
+void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
+{
+	if (!class_data) {
+		pr_warning("Smartreflex class data passed is NULL\n");
+		return;
+	}
+
+	if (sr_class) {
+		pr_warning("Smartreflex class driver already registered\n");
+		return;
+	}
+	sr_class = class_data;
+}
+
 /* Voltage Scaling using SR VCBYPASS */
 int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 					u8 target_vsel, u8 current_vsel)
@@ -747,13 +786,10 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	udelay(t2_smps_delay);
 
 	if (sr_status) {
-		unsigned long volt;
-
-		volt = (target_vsel * 12500) + 600000;
 		if (vdd == VDD1_OPP)
-			sr_start_vddautocomp(SR1, volt);
+			sr_start_vddautocomp(SR1);
 		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomp(SR2, volt);
+			sr_start_vddautocomp(SR2);
 	}
 
 	return 0;
@@ -783,17 +819,10 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 							sr_info->srid);
 		return 0;
 	}
-	if (val == 0) {
+	if (val == 0)
 		sr_stop_vddautocomp(sr_info->srid);
-	} else {
-		unsigned long curr_volt;
-
-		if (sr_info->srid == SR1)
-			curr_volt = get_curr_vdd1_voltage();
-		else
-			curr_volt = get_curr_vdd2_voltage();
-		sr_start_vddautocomp(sr_info->srid, curr_volt);
-	}
+	else
+		sr_start_vddautocomp(sr_info->srid);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 365a21d..50ea4a8 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -241,13 +241,28 @@ extern u32 current_vdd2_opp;
 #define SR_TESTING_NVALUES 	0
 #endif
 
-/*
- * Smartreflex module enable/disable interface.
- * NOTE: if smartreflex is not enabled from sysfs, these functions will not
- * do anything.
- */
 #ifdef CONFIG_OMAP_SMARTREFLEX
 /**
+ * omap_smartreflex_class_data : Structure to be populated by
+ * Smartreflex class driver with corresponding class enable disable API's
+ *
+ * @enable - API to enable a particular class smaartreflex.
+ * @disable - API to disable a particular class smartreflex.
+ * @notify - API to notify the class driver about an event in SR. Not needed
+ *		for class3.
+ * @notify_flags - specify the events to be notified to the class driver
+ * @class_type - specify which smartreflex class. Can be used by the SR driver
+ *		to take any class based decisions.
+ */
+struct omap_smartreflex_class_data {
+	int (*enable)(int sr_id);
+	int (*disable)(int sr_id);
+	int (*notify)(int sr_id, u32 status);
+	u8 notify_flags;
+	u8 class_type;
+};
+
+/**
  * omap_sr_volt_data - Smartreflex voltage specific data
  *
  * @voltage	: The possible voltage value
@@ -286,11 +301,26 @@ struct omap_smartreflex_data {
 	int (*device_idle)(struct platform_device *pdev);
 };
 
+/*
+ * Smartreflex module enable/disable interface.
+ * NOTE: if smartreflex is not enabled from sysfs, these functions will not
+ * do anything.
+ */
 void omap_smartreflex_enable(int srid);
 void omap_smartreflex_disable(int srid);
+
+/*
+ * Smartreflex driver hooks to be called from Smartreflex class driver
+ */
+int sr_enable(int srid, unsigned long volt);
+void sr_disable(int srid);
+
+/**
+ * API to register the smartreflex class driver with the smartreflex driver
+ */
+void omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
+
 int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
-void sr_start_vddautocomp(int srid, unsigned long volt);
-int sr_stop_vddautocomp(int srid);
 #else
 static inline void enable_smartreflex(int srid) {}
 static inline void disable_smartreflex(int srid) {}
-- 
1.7.0.rc1.33.g07cf0f

