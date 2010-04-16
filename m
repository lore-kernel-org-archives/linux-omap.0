From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 11/22] OMAP3: PM: Removing VP1, VP2, SR1 and SR2 defintions.
Date: Fri, 16 Apr 2010 14:33:06 +0530
Message-ID: <1271408597-3066-12-git-send-email-thara@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119Ab0DPJDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:03:32 -0400
In-Reply-To: <1271408597-3066-11-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch removes VP1, VP2, SR1 and SR2 macros and replaces them with
VDD1 and VDD2 macros.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c             |    8 +++---
 arch/arm/mach-omap2/smartreflex-class3.c |    4 +-
 arch/arm/mach-omap2/smartreflex.c        |   26 +++++++++++-----------
 arch/arm/mach-omap2/smartreflex.h        |    4 ---
 arch/arm/mach-omap2/voltage.c            |   35 +++++++++++++++--------------
 arch/arm/mach-omap2/voltage.h            |    6 ++--
 6 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f5c894..f3994c0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -415,9 +415,9 @@ void omap_sram_idle(void)
 	 * Only needed if we are going to enter retention or off.
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(SR1);
+		omap_smartreflex_disable(VDD1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(SR2);
+		omap_smartreflex_disable(VDD2);
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -516,9 +516,9 @@ void omap_sram_idle(void)
 	 * retention or off
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_enable(SR1);
+		omap_smartreflex_enable(VDD1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_enable(SR2);
+		omap_smartreflex_enable(VDD2);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 1b098ff..66696be 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -17,9 +17,9 @@ static int sr_class3_enable(int id)
 {
 	unsigned long volt = 0;
 
-	if (id == SR1)
+	if (id == VDD1)
 		volt = get_curr_vdd1_voltage();
-	else if (id == SR2)
+	else if (id == VDD2)
 		volt = get_curr_vdd2_voltage();
 	if (!volt) {
 		pr_warning("Current voltage unknown.Cannot enable SR%d\n", id);
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d3222a5..fffd5f7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -153,7 +153,7 @@ static void sr_configure(struct omap_sr *sr)
 
 	senp_en = pdata->senp_mod;
 	senn_en = pdata->senn_mod;
-	if (sr->srid == SR1) {
+	if (sr->srid == VDD1) {
 		sr_config = SR1_SRCONFIG_ACCUMDATA |
 			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
 			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
@@ -170,7 +170,7 @@ static void sr_configure(struct omap_sr *sr)
 			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
 			(SR1_ERRWEIGHT | SR1_ERRMAXLIMIT | SR1_ERRMINLIMIT));
 
-	} else if (sr->srid == SR2) {
+	} else if (sr->srid == VDD2) {
 		sr_config = SR2_SRCONFIG_ACCUMDATA |
 			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
 			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
@@ -196,7 +196,7 @@ static void sr_start_vddautocomp(int srid)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return;
 	}
 
@@ -224,7 +224,7 @@ static void  sr_stop_vddautocomp(int srid)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return;
 	}
 
@@ -261,7 +261,7 @@ int sr_enable(int srid, unsigned long volt)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return false;
 	}
 
@@ -272,7 +272,7 @@ int sr_enable(int srid, unsigned long volt)
 
 	if (nvalue_reciprocal == 0) {
 		pr_notice("NVALUE = 0 at voltage %ld for Smartreflex %d\n",
-						volt, sr->srid);
+						volt, sr->srid + 1);
 		return false;
 	}
 
@@ -301,7 +301,7 @@ void sr_disable(int srid)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return;
 	}
 
@@ -327,7 +327,7 @@ void omap_smartreflex_enable(int srid)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return;
 	}
 
@@ -362,7 +362,7 @@ void omap_smartreflex_disable(int srid)
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid);
+								srid + 1);
 		return;
 	}
 
@@ -409,7 +409,7 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
 
 	if (!sr_info) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-							sr_info->srid);
+							sr_info->srid + 1);
 		return 0;
 	}
 	*val = sr_info->is_autocomp_active;
@@ -422,7 +422,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 
 	if (!sr_info) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-							sr_info->srid);
+							sr_info->srid + 1);
 		return 0;
 	}
 	if (val == 0)
@@ -445,7 +445,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	if (WARN_ON(!sr_info))
 		return -ENOMEM;
 	sr_info->pdev = pdev;
-	sr_info->srid = pdev->id + 1;
+	sr_info->srid = pdev->id;
 	sr_info->is_sr_reset = 1,
 	sr_info->is_autocomp_active = 0;
 	sr_info->clk_length = 0;
@@ -454,7 +454,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	sr_set_clk_length(sr_info);
 
 	/* Create the debug fs enteries */
-	sprintf(name, "sr%d_autocomp", sr_info->srid);
+	sprintf(name, "sr%d_autocomp", sr_info->srid + 1);
 	(void) debugfs_create_file(name, S_IRUGO | S_IWUGO, pm_dbg_main_dir,
 				(void *)sr_info, &pm_sr_fops);
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 0f60a97..50d534a 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -32,10 +32,6 @@ extern struct dentry *pm_dbg_main_dir;
 #define SENERROR	0x20
 #define ERRCONFIG	0x24
 
-/* SR Modules */
-#define SR1		1
-#define SR2		2
-
 #define GAIN_MAXLIMIT	16
 #define R_MAXLIMIT	256
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index dd9618c..7777e28 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -246,11 +246,11 @@ static void vp_latch_vsel(int vp_id)
 	char vsel;
 
 	/* Should remove this once OPP framework is fixed */
-	if (vp_id == VP1) {
+	if (vp_id == VDD1) {
 		uvdc = get_curr_vdd1_voltage();
 		if (!uvdc)
 			return;
-	} else if (vp_id == VP2) {
+	} else if (vp_id == VDD2) {
 		uvdc = get_curr_vdd2_voltage();
 		if (!uvdc)
 			return;
@@ -310,7 +310,7 @@ static void __init vp_data_configure(int vp_id)
 {
 	if (cpu_is_omap34xx()) {
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
-		if (vp_id == VP1) {
+		if (vp_id == VDD1) {
 			vp_reg[vp_id].volt_data = omap34xx_vdd1_volt_data;
 			vp_reg[vp_id].volt_data_count =
 					ARRAY_SIZE(omap34xx_vdd1_volt_data);
@@ -318,7 +318,7 @@ static void __init vp_data_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
-		} else if (vp_id == VP2) {
+		} else if (vp_id == VDD2) {
 			vp_reg[vp_id].volt_data = omap34xx_vdd2_volt_data;
 			vp_reg[vp_id].volt_data_count =
 					ARRAY_SIZE(omap34xx_vdd2_volt_data);
@@ -368,7 +368,7 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 	current_vsel = omap_twl_uv_to_vsel(current_volt);
 	smps_steps = abs(target_vsel - current_vsel);
 
-	if (vdd == VDD1_OPP) {
+	if (vdd == VDD1) {
 		u32 vc_cmdval0;
 
 		vc_cmdval0 = voltage_read_reg(vc_reg.cmdval0_reg);
@@ -377,7 +377,7 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 		voltage_write_reg(vc_reg.cmdval0_reg, vc_cmdval0);
 		reg_addr = R_VDD1_SR_CONTROL;
 
-	} else if (vdd == VDD2_OPP) {
+	} else if (vdd == VDD2) {
 		u32 vc_cmdval1;
 
 		vc_cmdval1 = voltage_read_reg(vc_reg.cmdval1_reg);
@@ -387,7 +387,7 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 		reg_addr = R_VDD2_SR_CONTROL;
 	} else {
 		pr_warning("Wrong VDD passed in vc_bypass_scale_voltage %d\n",
-				vdd);
+				vdd + 1);
 		return false;
 	}
 
@@ -531,10 +531,10 @@ void omap_voltageprocessor_enable(int vp_id)
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
 	 */
-	vp_latch_vsel(vp_id - 1);
-	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
+	vp_latch_vsel(vp_id);
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
 	/* Enable VP */
-	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg,
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg,
 				vpconfig | VP_CONFIG_VPENABLE);
 }
 
@@ -551,7 +551,7 @@ void omap_voltageprocessor_disable(int vp_id)
 	u32 vpconfig;
 
 	/* Wait for VP idle before disabling VP */
-	while ((!voltage_read_reg(vp_reg[vp_id - 1].vp_offs.status_reg)) &&
+	while ((!voltage_read_reg(vp_reg[vp_id].vp_offs.status_reg)) &&
 				i++ < MAX_TRIES)
 		udelay(1);
 
@@ -559,9 +559,9 @@ void omap_voltageprocessor_disable(int vp_id)
 		pr_warning("VP1 not idle, still going ahead with \
 						VP1 disable\n");
 	/* Disable VP1 */
-	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
 	vpconfig &= ~VP_CONFIG_VPENABLE;
-	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg, vpconfig);
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
 }
 
 /**
@@ -597,19 +597,20 @@ void omap_reset_voltage(int vdd)
 	char vsel;
 
 	/* Should remove this once OPP framework is fixed */
-	if ((vdd - 1) == VP1) {
+	if (vdd == VDD1) {
 		target_uvdc = get_curr_vdd1_voltage();
 		if (!target_uvdc)
 			return;
-	} else if ((vdd - 1) == VP2) {
+	} else if (vdd == VDD2) {
 		target_uvdc = get_curr_vdd2_voltage();
 		if (!target_uvdc)
 			return;
 	} else {
-		pr_warning("Wrong VDD passed in omap_reset_voltage %d\n", vdd);
+		pr_warning("Wrong VDD passed in omap_reset_voltage %d\n",
+					vdd + 1);
 		return;
 	}
-	vsel = voltage_read_reg(vp_reg[vdd - 1].vp_offs.voltage_reg);
+	vsel = voltage_read_reg(vp_reg[vdd].vp_offs.voltage_reg);
 	current_uvdc = (vsel * 12500) + 600000;
 	omap_voltage_scale(vdd, target_uvdc, current_uvdc);
 }
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index cc3308e..2effa3e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -10,9 +10,9 @@
  */
 #include "pm.h"
 
-/* Voltageprocessor instances */
-#define VP1	0
-#define VP2	1
+/* VoltageDomain instances */
+#define VDD1	0
+#define VDD2	1
 
 
 /* Generic VP definitions. Need to be redefined for OMAP4 */
-- 
1.7.0.rc1.33.g07cf0f

