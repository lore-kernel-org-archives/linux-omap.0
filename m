From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 05/22] OMAP3: PM: Remove OPP id dependency from smartreflex driver
Date: Fri, 16 Apr 2010 14:33:00 +0530
Message-ID: <1271408597-3066-6-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55665 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823Ab0DPJDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:30 -0400
In-Reply-To: <1271408597-3066-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch removes get_vdd1_opp and get_vdd2_opp API's and replaces
them with get_curr_vdd1_voltage and get_curr_vdd2_voltage API's.
N-target values are now linked to voltages and the link bewtween
voltage and n-target values is managed internally in smartreflex
driver and sr_devices.c.

get_curr_vdd1_voltage and get_curr_vdd2_voltage are added in
smartreflex driver in this patch. These API's will be moved to the
voltage driver in a later patch when voltage specific code is separated
out of smartreflex. The link between various voltages and n-target
values will also be separated out later.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  201 +++++++++++++++----------------------
 arch/arm/mach-omap2/smartreflex.h |   21 +++-
 arch/arm/mach-omap2/sr_device.c   |   39 ++++++-
 3 files changed, 129 insertions(+), 132 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2f89d79..669f1bb 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -48,7 +48,6 @@ struct omap_sr {
 	int			srid;
 	int			is_sr_reset;
 	int			is_autocomp_active;
-	struct clk		*vdd_opp_clk;
 	u32			clk_length;
 	unsigned int		irq;
 	struct platform_device	*pdev;
@@ -119,64 +118,65 @@ static void sr_clk_disable(struct omap_sr *sr)
 	sr->is_sr_reset = 1;
 }
 
-static u8 get_vdd1_opp(void)
+static unsigned long get_curr_vdd1_voltage(void)
 {
 	struct omap_opp *opp;
 	unsigned long freq;
-	struct omap_sr *sr_info = _sr_lookup(SR1);
+	struct clk *dpll1_clk;
 
-	if (!sr_info) {
-		pr_warning("omap_sr struct corresponding to SR1 not found\n");
-		return 0;
-	}
-
-	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
+	dpll1_clk = clk_get(NULL, "dpll1_ck");
+	if (IS_ERR(dpll1_clk))
 		return 0;
 
-	freq = sr_info->vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(OPP_MPU, &freq);
+	freq = dpll1_clk->rate;;
+	opp = opp_find_freq_exact(OPP_MPU, freq, 1);
 	if (IS_ERR(opp))
 		return 0;
-	/*
-	 * Use higher freq voltage even if an exact match is not available
-	 * we are probably masking a clock framework bug, so warn
-	 */
-	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
-		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr_info->vdd_opp_clk->rate);
 
-	return opp_get_opp_id(opp);
+	return opp_get_voltage(opp);
 }
 
-static u8 get_vdd2_opp(void)
+static unsigned long get_curr_vdd2_voltage(void)
 {
 	struct omap_opp *opp;
 	unsigned long freq;
-	struct omap_sr *sr_info = _sr_lookup(SR2);
+	struct clk *l3_clk;
 
-	if (!sr_info) {
-		pr_warning("omap_sr struct corresponding to SR2 not found\n");
-		return 0;
-	}
-
-	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
+	l3_clk = clk_get(NULL, "l3_ick");
+	if (IS_ERR(l3_clk))
 		return 0;
 
-	freq = sr_info->vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(OPP_L3, &freq);
+	freq = l3_clk->rate;
+	opp = opp_find_freq_exact(OPP_L3, freq, 1);
 	if (IS_ERR(opp))
 		return 0;
 
-	/*
-	 * Use higher freq voltage even if an exact match is not available
-	 * we are probably masking a clock framework bug, so warn
-	 */
-	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
-		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr_info->vdd_opp_clk->rate);
-	return opp_get_opp_id(opp);
+	return opp_get_voltage(opp);
 }
 
+static int sr_match_volt(struct omap_sr *sr, unsigned long volt,
+				struct omap_volt_data *volt_data)
+{
+	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
+	struct omap_device *odev = to_omap_device(sr->pdev);
+	struct omap_smartreflex_dev_data *sr_dev_data =
+					odev->hwmods[0]->dev_attr;
+	int i;
+
+	if (!pdata->sr_volt_data) {
+		pr_notice("voltage table does not exist for SR %d\n", sr->srid);
+		return false;
+	}
+	for (i = 0; i < sr_dev_data->volts_supported; i++) {
+		if (pdata->sr_volt_data[i].voltage == volt) {
+			*volt_data = pdata->sr_volt_data[i];
+			return true;
+		}
+	}
+	pr_notice("Unable to match the current voltage with \
+				the voltage table for SR %d\n", sr->srid);
+	return false;
+}
 
 static void sr_set_clk_length(struct omap_sr *sr)
 {
@@ -211,21 +211,14 @@ static void sr_set_clk_length(struct omap_sr *sr)
 
 static void sr_configure_vp(int srid)
 {
-	u32 vpconfig;
-	u32 vsel;
-	int uvdc;
-	u32 target_opp_no;
-	struct omap_opp *opp;
+	u32 vpconfig, vsel;
+	unsigned long uvdc;
 
 	if (srid == SR1) {
-		target_opp_no = get_vdd1_opp();
-		if (!target_opp_no)
-			target_opp_no = VDD1_OPP3;
-
-		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
-		BUG_ON(!opp); /* XXX ugh */
-
-		uvdc = opp_get_voltage(opp);
+		uvdc = get_curr_vdd1_voltage();
+		if (!uvdc)
+			pr_err("Something wrong.Current voltage not obtained \
+				from OPP framework for SR %d!\n", srid);
 		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
@@ -267,14 +260,10 @@ static void sr_configure_vp(int srid)
 				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 
 	} else if (srid == SR2) {
-		target_opp_no = get_vdd2_opp();
-		if (!target_opp_no)
-			target_opp_no = VDD2_OPP3;
-
-		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
-		BUG_ON(!opp); /* XXX ugh */
-
-		uvdc = opp_get_voltage(opp);
+		uvdc = get_curr_vdd2_voltage();
+		if (!uvdc)
+			pr_err("Something wrong.Current voltage not obtained \
+				from OPP framework for SR %d!\n", srid);
 		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
@@ -368,9 +357,8 @@ static void sr_configure(struct omap_sr *sr)
 
 static int sr_reset_voltage(int srid)
 {
-	struct omap_opp *opp;
 	unsigned long uvdc;
-	u32 target_opp_no, vsel = 0;
+	u32 vsel = 0;
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_bypass_value;
@@ -379,17 +367,12 @@ static int sr_reset_voltage(int srid)
 	u32 prm_vp1_voltage, prm_vp2_voltage;
 
 	if (srid == SR1) {
-		target_opp_no = get_vdd1_opp();
-		if (!target_opp_no) {
-			pr_info("Current OPP unknown: Cannot reset voltage\n");
+		uvdc = get_curr_vdd1_voltage();
+		if (!uvdc) {
+			pr_err("Something wrong.Current voltage not obtained \
+				from OPP framework for SR %d!\n", srid);
 			return 1;
 		}
-
-		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
-		if (!opp)
-			return 1;
-
-		uvdc = opp_get_voltage(opp);
 		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		reg_addr = R_VDD1_SR_CONTROL;
@@ -397,17 +380,12 @@ static int sr_reset_voltage(int srid)
 						OMAP3_PRM_VP1_VOLTAGE_OFFSET);
 		t2_smps_steps = abs(vsel - prm_vp1_voltage);
 	} else if (srid == SR2) {
-		target_opp_no = get_vdd2_opp();
-		if (!target_opp_no) {
-			pr_info("Current OPP unknown: Cannot reset voltage\n");
+		uvdc = get_curr_vdd2_voltage();
+		if (!uvdc) {
+			pr_err("Something wrong.Current voltage not obtained \
+				from OPP framework for SR %d!\n", srid);
 			return 1;
 		}
-
-		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
-		if (!opp)
-			return 1;
-
-		uvdc = opp_get_voltage(opp);
 		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		reg_addr = R_VDD2_SR_CONTROL;
@@ -452,35 +430,20 @@ static int sr_reset_voltage(int srid)
 	return 0;
 }
 
-static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
+static int sr_enable(struct omap_sr *sr, unsigned long volt)
 {
 	u32 nvalue_reciprocal, v;
-	struct omap_opp *opp;
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-	int uvdc;
+	struct omap_volt_data volt_data;
 	char vsel;
 
-	if (sr->srid == SR1) {
-		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
-		if (!opp)
-			return false;
-	} else {
-		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
-		if (!opp)
-			return false;
-	}
-
-	if (!pdata->sr_nvalue) {
-		pr_notice("N target values does not exist for SR%d\n",
-								sr->srid);
+	if (!sr_match_volt(sr, volt, &volt_data))
 		return false;
-	}
 
-	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
+	nvalue_reciprocal = volt_data.sr_nvalue;
 
 	if (nvalue_reciprocal == 0) {
-		pr_notice("OPP%d doesn't support SmartReflex\n",
-								target_opp_no);
+		pr_notice("NVALUE = 0 at voltage %ld for Smartreflex %d\n",
+						volt, sr->srid);
 		return false;
 	}
 
@@ -491,8 +454,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
 
-	uvdc = opp_get_voltage(opp);
-	vsel = omap_twl_uv_to_vsel(uvdc);
+	vsel = omap_twl_uv_to_vsel(volt);
 
 	if (sr->srid == SR1) {
 		/* set/latch init voltage */
@@ -578,7 +540,7 @@ static void sr_disable(struct omap_sr *sr)
 }
 
 
-void sr_start_vddautocomap(int srid, u32 target_opp_no)
+void sr_start_vddautocomap(int srid, unsigned long volt)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -594,7 +556,7 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 	}
 
 	sr->is_autocomp_active = 1;
-	if (!sr_enable(sr, target_opp_no)) {
+	if (!sr_enable(sr, volt)) {
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
@@ -627,7 +589,7 @@ EXPORT_SYMBOL(sr_stop_vddautocomap);
 
 void enable_smartreflex(int srid)
 {
-	u32 target_opp_no = 0;
+	unsigned long curr_volt = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
 
 	if (!sr) {
@@ -642,18 +604,18 @@ void enable_smartreflex(int srid)
 			sr_clk_enable(sr);
 
 			if (srid == SR1)
-				target_opp_no = get_vdd1_opp();
+				curr_volt = get_curr_vdd1_voltage();
 			else if (srid == SR2)
-				target_opp_no = get_vdd2_opp();
+				curr_volt = get_curr_vdd2_voltage();
 
-			if (!target_opp_no) {
-				pr_info("Current OPP unknown \
+			if (!curr_volt) {
+				pr_info("Current voltage unknown \
 						 Cannot configure SR\n");
 			}
 
 			sr_configure(sr);
 
-			if (!sr_enable(sr, target_opp_no))
+			if (!sr_enable(sr, curr_volt))
 				sr_clk_disable(sr);
 		}
 	}
@@ -788,10 +750,13 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	udelay(t2_smps_delay);
 
 	if (sr_status) {
+		unsigned long volt;
+
+		volt = (target_vsel * 12500) + 600000;
 		if (vdd == VDD1_OPP)
-			sr_start_vddautocomap(SR1, target_opp_no);
+			sr_start_vddautocomap(SR1, volt);
 		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomap(SR2, target_opp_no);
+			sr_start_vddautocomap(SR2, volt);
 	}
 
 	return 0;
@@ -824,13 +789,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	if (val == 0) {
 		sr_stop_vddautocomap(sr_info->srid);
 	} else {
-		u32 current_opp;
+		unsigned long curr_volt;
 
 		if (sr_info->srid == SR1)
-			current_opp = get_vdd1_opp();
+			curr_volt = get_curr_vdd1_voltage();
 		else
-			current_opp = get_vdd2_opp();
-		sr_start_vddautocomap(sr_info->srid, current_opp);
+			curr_volt = get_curr_vdd2_voltage();
+		sr_start_vddautocomap(sr_info->srid, curr_volt);
 	}
 	return 0;
 }
@@ -856,12 +821,6 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
 	sr_set_clk_length(sr_info);
 
-	if (sr_info->srid == SR1) {
-		sr_info->vdd_opp_clk = clk_get(NULL, "dpll1_ck");
-	} else {
-		sr_info->vdd_opp_clk = clk_get(NULL, "l3_ick");
-	}
-
 	/* Create the debug fs enteries */
 	sprintf(name, "sr%d_autocomp", sr_info->srid);
 	(void) debugfs_create_file(name, S_IRUGO | S_IWUGO, pm_dbg_main_dir,
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index ea0ddd3..b14ba50 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -242,6 +242,17 @@ extern u32 current_vdd2_opp;
 #endif
 
 /**
+ * omap_volt_data - Omap voltage specific data.
+ *
+ * @voltage	: The possible voltage value
+ * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
+ */
+struct omap_volt_data {
+	unsigned long	voltage;
+	u32		sr_nvalue;
+};
+
+/**
  * omap_smartreflex_dev_data - Smartreflex device specific data
  *
  * @volts_supported	: Number of distinct voltages possible for the VDD
@@ -295,10 +306,10 @@ struct omap_smartreflex_dev_data {
  * @device_idle		: fn pointer to be pouplated with omap_device idle API
  */
 struct omap_smartreflex_data {
-	u32		senp_mod;
-	u32		senn_mod;
-	u32		*sr_nvalue;
-	bool		enable_on_init;
+	u32				senp_mod;
+	u32				senn_mod;
+	struct omap_volt_data		*sr_volt_data;
+	bool				enable_on_init;
 	int (*device_enable)(struct platform_device *pdev);
 	int (*device_shutdown)(struct platform_device *pdev);
 	int (*device_idle)(struct platform_device *pdev);
@@ -307,7 +318,7 @@ struct omap_smartreflex_data {
 void enable_smartreflex(int srid);
 void disable_smartreflex(int srid);
 int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
-void sr_start_vddautocomap(int srid, u32 target_opp_no);
+void sr_start_vddautocomap(int srid, unsigned long volt);
 int sr_stop_vddautocomap(int srid);
 #else
 static inline void enable_smartreflex(int srid) {}
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index a9c1ef0..544d575 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -51,8 +51,9 @@ static void __init sr_read_efuse(
 			!dev_data->efuse_nvalues_offs))
 		return;
 
-	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-			dev_data->volts_supported , GFP_KERNEL);
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
+
 	sr_data->senn_mod = (omap_ctrl_readl(dev_data->efuse_sr_control) &
 				(0x3 << dev_data->sennenable_shift) >>
 				dev_data->sennenable_shift);
@@ -60,7 +61,7 @@ static void __init sr_read_efuse(
 				(0x3 << dev_data->senpenable_shift) >>
 				dev_data->senpenable_shift);
 	for (i = 0; i < dev_data->volts_supported; i++)
-		sr_data->sr_nvalue[i] = omap_ctrl_readl(
+		sr_data->sr_volt_data[i].sr_nvalue = omap_ctrl_readl(
 				dev_data->efuse_nvalues_offs[i]);
 }
 
@@ -78,12 +79,13 @@ static void __init sr_set_testing_nvalues(
 			!dev_data->test_nvalues))
 		return;
 
-	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-			dev_data->volts_supported , GFP_KERNEL);
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
+
 	sr_data->senn_mod = dev_data->test_sennenable;
 	sr_data->senp_mod = dev_data->test_senpenable;
 	for (i = 0; i < dev_data->volts_supported; i++)
-		sr_data->sr_nvalue[i] = dev_data->test_nvalues[i];
+		sr_data->sr_volt_data[i].sr_nvalue = dev_data->test_nvalues[i];
 }
 
 static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
@@ -97,6 +99,28 @@ static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
 	}
 }
 
+static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
+						*sr_data, int srid,
+						int volt_count)
+{
+	sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
+				volt_count , GFP_KERNEL);
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
+
+	if (srid == SR1) {
+		sr_data->sr_volt_data[0].voltage = 975000;
+		sr_data->sr_volt_data[1].voltage = 1075000;
+		sr_data->sr_volt_data[2].voltage = 1200000;
+		sr_data->sr_volt_data[3].voltage = 1270000;
+		sr_data->sr_volt_data[4].voltage = 1350000;
+	} else if (srid == SR2) {
+		sr_data->sr_volt_data[0].voltage = 975000;
+		sr_data->sr_volt_data[1].voltage = 1050000;
+		sr_data->sr_volt_data[2].voltage = 1150000;
+	}
+}
+
 static int __init omap_devinit_smartreflex(void)
 {
 	int i = 0;
@@ -124,6 +148,9 @@ static int __init omap_devinit_smartreflex(void)
 		sr_data->device_enable = omap_device_enable;
 		sr_data->device_shutdown = omap_device_shutdown;
 		sr_data->device_idle = omap_device_idle;
+		if (cpu_is_omap34xx())
+			omap34xx_sr_volt_details(sr_data, i + 1,
+					sr_dev_data->volts_supported);
 		sr_set_nvalues(sr_dev_data, sr_data);
 
 		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
-- 
1.7.0.rc1.33.g07cf0f

