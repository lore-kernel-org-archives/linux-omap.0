From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 05/17] OMAP3: PM: Remove OPP id dependency from smartreflex driver
Date: Thu, 18 Mar 2010 14:45:43 +0530
Message-ID: <1268903755-4151-6-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0CRJQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 05:16:11 -0400
In-Reply-To: <1268903755-4151-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch removes get_vdd1_opp and get_vdd2_opp API's and replaces
them with get_curr_vdd1_voltage and get_curr_vdd2_voltage API's.
N-target values are now linked to voltages and the link bewtween
voltage and n-target values is managed internally in smartreflex
driver and sr_devices.c

get_curr_vdd1_voltage and get_curr_vdd2_voltage are added in
smartreflex driver in this patch. These API's will be moved to the
voltage driver in a later patch when voltage specific code is separated
out of smartreflex.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  219 ++++++++++++++----------------------
 arch/arm/mach-omap2/smartreflex.h |   27 ++++-
 arch/arm/mach-omap2/sr_device.c   |   88 ++++++++-------
 3 files changed, 152 insertions(+), 182 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 4065b45..5ea671b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -45,14 +45,14 @@
 #define SMARTREFLEX_NAME_LEN	16
 
 struct omap_sr {
-	int			srid;
-	int			is_sr_reset;
-	int			is_autocomp_active;
-	struct clk		*vdd_opp_clk;
-	u32			clk_length;
-	unsigned int		irq;
-	struct platform_device	*pdev;
-	struct list_head	node;
+	int				srid;
+	int				is_sr_reset;
+	int				is_autocomp_active;
+	u32				clk_length;
+	unsigned int			irq;
+	struct platform_device		*pdev;
+	struct omap_sr_volt_tuple	*volt_tuple;
+	struct list_head		node;
 };
 
 /* sr_list contains all the instances of smartreflex module */
@@ -119,64 +119,62 @@ static void sr_clk_disable(struct omap_sr *sr)
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
+	freq = dpll1_clk->rate;
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
+				struct omap_sr_volt_data *volt_data)
+{
+	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
+	int i;
+
+	if (!pdata->sr_volt_data) {
+		pr_notice("voltage table does not exist for SR %d\n", sr->srid);
+		return false;
+	}
+	for (i = 0; i < pdata->no_opp; i++) {
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
@@ -211,21 +209,14 @@ static void sr_set_clk_length(struct omap_sr *sr)
 
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
@@ -267,14 +258,10 @@ static void sr_configure_vp(int srid)
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
@@ -368,9 +355,8 @@ static void sr_configure(struct omap_sr *sr)
 
 static int sr_reset_voltage(int srid)
 {
-	struct omap_opp *opp;
 	unsigned long uvdc;
-	u32 target_opp_no, vsel = 0;
+	u32 vsel = 0;
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_bypass_value;
@@ -379,17 +365,12 @@ static int sr_reset_voltage(int srid)
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
@@ -397,17 +378,12 @@ static int sr_reset_voltage(int srid)
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
@@ -452,40 +428,19 @@ static int sr_reset_voltage(int srid)
 	return 0;
 }
 
-static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
+static int sr_enable(struct omap_sr *sr, unsigned long volt)
 {
 	u32 nvalue_reciprocal, v;
-	struct omap_opp *opp;
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-	int uvdc;
+	struct omap_sr_volt_data volt_data;
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
-	if (target_opp_no > pdata->no_opp) {
-		pr_notice("Wrong target opp for VDD %d\n", sr->srid);
-		return false;
-	}
-
-	if (!pdata->sr_nvalue) {
-		pr_notice("N target values does not exist for SR%d\n",
-								sr->srid);
+	if (!sr_match_volt(sr, volt, &volt_data))
 		return false;
-	}
-
-	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
+	nvalue_reciprocal = volt_data.sr_nvalue;
 
 	if (nvalue_reciprocal == 0) {
-		pr_notice("OPP%d doesn't support SmartReflex\n",
-								target_opp_no);
+		pr_notice("NVALUE = 0 at voltage %ld for Smartreflex %d\n",
+						volt, sr->srid);
 		return false;
 	}
 
@@ -496,8 +451,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
 
-	uvdc = opp_get_voltage(opp);
-	vsel = omap_twl_uv_to_vsel(uvdc);
+	vsel = omap_twl_uv_to_vsel(volt);
 
 	if (sr->srid == SR1) {
 		/* set/latch init voltage */
@@ -583,7 +537,7 @@ static void sr_disable(struct omap_sr *sr)
 }
 
 
-void sr_start_vddautocomap(int srid, u32 target_opp_no)
+void sr_start_vddautocomap(int srid, unsigned long volt)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -599,7 +553,7 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 	}
 
 	sr->is_autocomp_active = 1;
-	if (!sr_enable(sr, target_opp_no)) {
+	if (!sr_enable(sr, volt)) {
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
@@ -632,7 +586,7 @@ EXPORT_SYMBOL(sr_stop_vddautocomap);
 
 void enable_smartreflex(int srid)
 {
-	u32 target_opp_no = 0;
+	unsigned long curr_volt = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
 
 	if (!sr) {
@@ -647,18 +601,18 @@ void enable_smartreflex(int srid)
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
@@ -793,10 +747,13 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
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
@@ -829,13 +786,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
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
@@ -861,12 +818,6 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
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
index f7e6e1b..cab66a4 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -248,11 +248,23 @@ extern u32 current_vdd2_opp;
  */
 #ifdef CONFIG_OMAP_SMARTREFLEX
 /**
+ * omap_sr_volt_data - Smartreflex voltage specific data
+ *
+ * @voltage	: The possible voltage value
+ * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
+ */
+struct omap_sr_volt_data {
+	unsigned long	voltage;
+	u32		sr_nvalue;
+};
+
+/**
  * omap_smartreflex_data - Smartreflex platform data
  *
  * @senp_mod		: SENPENABLE value for the sr
  * @senn_mod		: SENNENABLE value for sr
- * @sr_nvalue		: array of n target values for sr
+ * @sr_volt_data	: array of various possible voltages and N target
+ *			values for a particular SR.
  * @no_opp		: number of opp's for this SR
  * @enable_on_init	: whether this sr module needs to enabled at
  *			  boot up or not
@@ -263,11 +275,12 @@ extern u32 current_vdd2_opp;
  * @device_idle		: fn pointer to be pouplated with omap_device idle API
  */
 struct omap_smartreflex_data {
-	u32		senp_mod;
-	u32		senn_mod;
-	u32		*sr_nvalue;
-	int		no_opp;
-	bool		enable_on_init;
+	u32				senp_mod;
+	u32				senn_mod;
+	u32				*sr_nvalue;
+	struct omap_sr_volt_data	*sr_volt_data;
+	int				no_opp;
+	bool				enable_on_init;
 	int (*device_enable)(struct platform_device *pdev);
 	int (*device_shutdown)(struct platform_device *pdev);
 	int (*device_idle)(struct platform_device *pdev);
@@ -276,7 +289,7 @@ struct omap_smartreflex_data {
 void enable_smartreflex(int srid);
 void disable_smartreflex(int srid);
 int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
-void sr_start_vddautocomap(int srid, u32 target_opp_no);
+void sr_start_vddautocomap(int srid, unsigned long volt);
 int sr_stop_vddautocomap(int srid);
 #else
 static inline void enable_smartreflex(int srid) {}
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index b21267d..1ee7f4c 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -43,47 +43,38 @@ struct omap_device_pm_latency omap_sr_latency[] = {
 static void __init omap34xx_sr_read_efuse(struct omap_smartreflex_data *sr_data,
 						int sr_id)
 {
-	if (sr_id == SR1) {
-		sr_data->no_opp = opp_get_opp_count(OPP_MPU);
-		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-					sr_data->no_opp , GFP_KERNEL);
-		if (WARN_ON(!sr_data->sr_nvalue))
-			return;
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
 
+	if (sr_id == SR1) {
 		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR1_SENNENABLE_MASK) >>
 					OMAP343X_SR1_SENNENABLE_SHIFT;
 		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR1_SENPENABLE_MASK) >>
 					OMAP343X_SR1_SENPENABLE_SHIFT;
-		sr_data->sr_nvalue[4] = omap_ctrl_readl(
+		sr_data->sr_volt_data[4].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP5_VDD1);
-		sr_data->sr_nvalue[3] = omap_ctrl_readl(
+		sr_data->sr_volt_data[3].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP4_VDD1);
-		sr_data->sr_nvalue[2] = omap_ctrl_readl(
+		sr_data->sr_volt_data[2].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP3_VDD1);
-		sr_data->sr_nvalue[1] = omap_ctrl_readl(
+		sr_data->sr_volt_data[1].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP2_VDD1);
-		sr_data->sr_nvalue[0] = omap_ctrl_readl(
+		sr_data->sr_volt_data[0].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP1_VDD1);
 	} else if (sr_id == SR2) {
-		sr_data->no_opp = 3;
-		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-					sr_data->no_opp , GFP_KERNEL);
-		if (WARN_ON(!sr_data->sr_nvalue))
-			return;
-
 		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR2_SENNENABLE_MASK) >>
 					OMAP343X_SR2_SENNENABLE_SHIFT;
 		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR2_SENPENABLE_MASK) >>
 					OMAP343X_SR2_SENPENABLE_SHIFT;
-		sr_data->sr_nvalue[2] = omap_ctrl_readl(
+		sr_data->sr_volt_data[2].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP3_VDD2);
-		sr_data->sr_nvalue[1] = omap_ctrl_readl(
+		sr_data->sr_volt_data[1].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP2_VDD2);
-		sr_data->sr_nvalue[0] = omap_ctrl_readl(
+		sr_data->sr_volt_data[0].sr_nvalue = omap_ctrl_readl(
 					OMAP343X_CONTROL_FUSE_OPP1_VDD2);
 	}
 }
@@ -95,33 +86,24 @@ static void __init omap34xx_sr_read_efuse(struct omap_smartreflex_data *sr_data,
 static void __init omap34xx_sr_set_testing_nvalues(
 				struct omap_smartreflex_data *sr_data, int srid)
 {
-	if (srid == SR1) {
-		sr_data->no_opp = opp_get_opp_count(OPP_MPU);
-		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-				sr_data->no_opp , GFP_KERNEL);
-		if (WARN_ON(!sr_data->sr_nvalue))
-			return;
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
 
+	if (srid == SR1) {
 		sr_data->senp_mod = 0x03;	/* SenN-M5 enabled */
 		sr_data->senn_mod = 0x03;
 		/* calculate nvalues for each opp */
-		sr_data->sr_nvalue[4] = 0x0;
-		sr_data->sr_nvalue[3] = 0x0;
-		sr_data->sr_nvalue[2] = 0x0;
-		sr_data->sr_nvalue[1] = 0x0;
-		sr_data->sr_nvalue[0] = 0x0;
+		sr_data->sr_volt_data[4].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[3].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[2].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[1].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[0].sr_nvalue = 0x0;
 	} else if (srid == SR2) {
-		sr_data->no_opp = 3;
-		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
-					sr_data->no_opp , GFP_KERNEL);
-		if (WARN_ON(!sr_data->sr_nvalue))
-			return;
-
 		sr_data->senp_mod = 0x03;	/* SenN-M5 enabled */
 		sr_data->senn_mod = 0x03;
-		sr_data->sr_nvalue[2] = 0x0;
-		sr_data->sr_nvalue[1] = 0x0;
-		sr_data->sr_nvalue[0] = 0x0;
+		sr_data->sr_volt_data[2].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[1].sr_nvalue = 0x0;
+		sr_data->sr_volt_data[0].sr_nvalue = 0x0;
 	}
 }
 
@@ -135,6 +117,29 @@ static void __init sr_set_nvalues(struct omap_smartreflex_data *sr_data,
 			omap34xx_sr_read_efuse(sr_data, srid);
 	}
 }
+static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
+						*sr_data, int srid)
+{
+	if (srid == SR1) {
+		sr_data->no_opp = opp_get_opp_count(OPP_MPU);
+		sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
+				sr_data->no_opp , GFP_KERNEL);
+		WARN_ON(!sr_data->sr_volt_data);
+		sr_data->sr_volt_data[0].voltage = 975000;
+		sr_data->sr_volt_data[1].voltage = 1075000;
+		sr_data->sr_volt_data[2].voltage = 1200000;
+		sr_data->sr_volt_data[3].voltage = 1270000;
+		sr_data->sr_volt_data[4].voltage = 1350000;
+	} else if (srid == SR2) {
+		sr_data->no_opp = 3;
+		sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
+				sr_data->no_opp , GFP_KERNEL);
+		WARN_ON(!sr_data->sr_volt_data);
+		sr_data->sr_volt_data[0].voltage = 975000;
+		sr_data->sr_volt_data[1].voltage = 1050000;
+		sr_data->sr_volt_data[2].voltage = 1150000;
+	}
+}
 
 static int __init omap_devinit_smartreflex(void)
 {
@@ -161,8 +166,9 @@ static int __init omap_devinit_smartreflex(void)
 		sr_data->device_enable = omap_device_enable;
 		sr_data->device_shutdown = omap_device_shutdown;
 		sr_data->device_idle = omap_device_idle;
+		if (cpu_is_omap34xx())
+			omap34xx_sr_volt_details(sr_data, i + 1);
 		sr_set_nvalues(sr_data, i + 1);
-
 		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
 				       omap_sr_latency,
 				       ARRAY_SIZE(omap_sr_latency), 0);
-- 
1.7.0.rc1.33.g07cf0f

