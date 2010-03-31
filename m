From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 3/3] OMAP3: PM: Adding OMAP3630 support in smartreflex driver
Date: Wed, 31 Mar 2010 12:00:14 +0530
Message-ID: <1270017014-27704-4-git-send-email-thara@ti.com>
References: <1270017014-27704-1-git-send-email-thara@ti.com>
 <1270017014-27704-2-git-send-email-thara@ti.com>
 <1270017014-27704-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57841 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932759Ab0CaGab (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 02:30:31 -0400
In-Reply-To: <1270017014-27704-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adapts smartreflex driver to support OMAP3630 also.
Changes involve:
1. Separate hwmod structures for OMAP3630 distinguished from
   3430 structures using omap_chip attribute.
2. Introducing new test nvalues for OMAP3630.
3. OMAP3630 specific changes for srconfig err_minlimit field,
   vpx_config errorgain field and vpx_vlimitto vddmax and vddmin
   fields.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   47 +++++++++++++-
 arch/arm/mach-omap2/smartreflex.c          |   38 ++++++++---
 arch/arm/mach-omap2/smartreflex.h          |    5 +-
 arch/arm/mach-omap2/sr_device.c            |   94 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/voltage.c              |   47 ++++++++++++--
 arch/arm/mach-omap2/voltage.h              |   32 ++++++++--
 arch/arm/plat-omap/include/plat/control.h  |    8 +++
 7 files changed, 244 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9c0c9e3..c78f128 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -222,6 +222,25 @@ static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
 	.rev  = 1,
 };
 
+static struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26
+};
+
+static struct omap_hwmod_class_sysconfig omap36xx_sr_sysc = {
+	.sysc_offs	= 0x38,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			SYSC_NO_CACHE),
+	.sysc_fields	= &omap36xx_sr_sysc_fields,
+};
+
+static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap36xx_sr_sysc,
+	.rev  = 2,
+};
+
 /* SR1 */
 static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
@@ -235,10 +254,21 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.main_clk	= "sr1_fck",
 	.slaves		= omap34xx_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static struct omap_hwmod omap36xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr1_fck",
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 /* SR2 */
 static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
@@ -252,10 +282,21 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.main_clk	= "sr2_fck",
 	.slaves		= omap34xx_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static struct omap_hwmod omap36xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap36xx_smartreflex_hwmod_class,
+	.main_clk	= "sr2_fck",
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -264,6 +305,8 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mpu_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 0e5c052..9ff306c 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -246,7 +246,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * file or pmic specific data structure. In that case these structure
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap34xx()) {
 		struct omap_smartreflex_data *pdata =
 					sr->pdev->dev.platform_data;
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
@@ -255,28 +255,46 @@ static void sr_set_regfields(struct omap_sr *sr)
 		if (sr->srid == SR1) {
 			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
-			pdata->sr_volt_data[0].sr_errminlimit =
+			if (cpu_is_omap3630()) {
+				pdata->sr_volt_data[0].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
-			pdata->sr_volt_data[1].sr_errminlimit =
+				pdata->sr_volt_data[1].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+				pdata->sr_volt_data[2].sr_errminlimit =
+					OMAP3630_SR_ERRMINLIMIT_OPPTB;
+				pdata->sr_volt_data[3].sr_errminlimit =
+					OMAP3630_SR_ERRMINLIMIT_OPPTB;
+			} else {
+				pdata->sr_volt_data[0].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+				pdata->sr_volt_data[1].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
-			pdata->sr_volt_data[2].sr_errminlimit =
+				pdata->sr_volt_data[2].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
-			pdata->sr_volt_data[3].sr_errminlimit =
+				pdata->sr_volt_data[3].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
-			pdata->sr_volt_data[4].sr_errminlimit =
+				pdata->sr_volt_data[4].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			}
 		} else {
 			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
-			pdata->sr_volt_data[0].sr_errminlimit =
+			if (cpu_is_omap3630()) {
+				pdata->sr_volt_data[0].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+				pdata->sr_volt_data[1].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			} else {
+				pdata->sr_volt_data[0].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
-			pdata->sr_volt_data[1].sr_errminlimit =
+				pdata->sr_volt_data[1].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
-			pdata->sr_volt_data[2].sr_errminlimit =
+				pdata->sr_volt_data[2].sr_errminlimit =
 					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			}
 		}
 	}
-	/* TODO: 3630 and Omap4 specific bit field values */
+	/* TODO: Omap4 specific bit field values */
 }
 
 static void sr_configure(struct omap_sr *sr)
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 66c3770..a126362 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -146,7 +146,10 @@ extern struct dentry *pm_dbg_main_dir;
 #define OMAP3430_SR_ERRMINLIMIT_HIGHOPP	0xF9
 #define OMAP3430_SR_ERRMINLIMIT_LOWOPP	0xF4
 
-/* TODO:3630/OMAP4 values if it has to come from this file */
+/* OMAP3630 specific values */
+#define OMAP3630_SR_ERRMINLIMIT_OPPTB   0xFA
+
+/* TODO:OMAP4 specific values */
 
 /* Info for enabling SR in T2/gaia. ToDo: Move it to twl4030_power.c */
 #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 209909c..2dcd1ba 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -107,16 +107,82 @@ static void __init omap34xx_sr_set_testing_nvalues(
 	}
 }
 
+static void __init omap3630_sr_read_efuse(
+			struct omap_smartreflex_data *sr_data, int sr_id)
+{
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
+
+	if (sr_id == SR1) {
+		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENNENABLE_MASK) >>
+					OMAP343X_SR1_SENNENABLE_SHIFT;
+		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENPENABLE_MASK) >>
+					OMAP343X_SR1_SENPENABLE_SHIFT;
+		sr_data->sr_volt_data[3].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPPTM_VDD1);
+		sr_data->sr_volt_data[2].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP120_VDD1);
+		sr_data->sr_volt_data[1].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP100_VDD1);
+		sr_data->sr_volt_data[0].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP50_VDD1);
+	} else if (sr_id == SR2) {
+
+		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENNENABLE_MASK) >>
+					OMAP343X_SR2_SENNENABLE_SHIFT;
+		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENPENABLE_MASK) >>
+					OMAP343X_SR2_SENPENABLE_SHIFT;
+		sr_data->sr_volt_data[1].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP100_VDD2);
+		sr_data->sr_volt_data[0].sr_nvalue = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP50_VDD2);
+	}
+}
+
+/* OMAP3630 Hard coded nvalues for testing purposes.*/
+static void __init omap3630_sr_set_testing_nvalues(
+			struct omap_smartreflex_data *sr_data, int srid)
+{
+	if (WARN_ON(!sr_data->sr_volt_data))
+		return;
+
+	if (srid == SR1) {
+		sr_data->senp_mod = 0x1;
+		sr_data->senn_mod = 0x1;
+		/* OMAP3630 nvalues for each VDD1 opp */
+		sr_data->sr_volt_data[3].sr_nvalue = 0xaab197;
+		sr_data->sr_volt_data[2].sr_nvalue = 0xaac5a8;
+		sr_data->sr_volt_data[1].sr_nvalue = 0x999b83;
+		sr_data->sr_volt_data[0].sr_nvalue = 0x898beb;
+	} else if (srid == SR2) {
+		sr_data->senp_mod = 0x1;
+		sr_data->senn_mod = 0x1;
+		/* OMAP3630 nvalues for each VDD2 opp */
+		sr_data->sr_volt_data[1].sr_nvalue = 0x9a8cee;
+		sr_data->sr_volt_data[0].sr_nvalue = 0x898beb;
+	}
+}
+
 static void __init sr_set_nvalues(struct omap_smartreflex_data *sr_data,
 						int srid)
 {
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3630()) {
+		if (SR_TESTING_NVALUES)
+			omap3630_sr_set_testing_nvalues(sr_data, srid);
+		else
+			omap3630_sr_read_efuse(sr_data, srid);
+	} else if (cpu_is_omap34xx()) {
 		if (SR_TESTING_NVALUES)
 			omap34xx_sr_set_testing_nvalues(sr_data, srid);
 		else
 			omap34xx_sr_read_efuse(sr_data, srid);
 	}
 }
+
 static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
 						*sr_data, int srid)
 {
@@ -141,6 +207,28 @@ static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
 	}
 }
 
+static void __init omap3630_sr_volt_details(struct omap_smartreflex_data
+						*sr_data, int srid)
+{
+	if (srid == SR1) {
+		sr_data->no_opp = 4;
+		sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
+				sr_data->no_opp , GFP_KERNEL);
+		WARN_ON(!sr_data->sr_volt_data);
+		sr_data->sr_volt_data[0].voltage = 930000;
+		sr_data->sr_volt_data[1].voltage = 1100000;
+		sr_data->sr_volt_data[2].voltage = 1260000;
+		sr_data->sr_volt_data[3].voltage = 1310000;
+	} else if (srid == SR2) {
+		sr_data->no_opp = 2;
+		sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
+				sr_data->no_opp , GFP_KERNEL);
+		WARN_ON(!sr_data->sr_volt_data);
+		sr_data->sr_volt_data[0].voltage = 930000;
+		sr_data->sr_volt_data[1].voltage = 1137500;
+	}
+}
+
 static int __init omap_devinit_smartreflex(void)
 {
 	int i = 0;
@@ -180,7 +268,9 @@ static int __init omap_devinit_smartreflex(void)
 		sr_data->device_enable = omap_device_enable;
 		sr_data->device_shutdown = omap_device_shutdown;
 		sr_data->device_idle = omap_device_idle;
-		if (cpu_is_omap34xx())
+		if (cpu_is_omap3630())
+			omap3630_sr_volt_details(sr_data, i + 1);
+		else if (cpu_is_omap34xx())
 			omap34xx_sr_volt_details(sr_data, i + 1);
 		sr_set_nvalues(sr_data, i + 1);
 		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 8fd1949..9690b8d 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -224,6 +224,23 @@ static u8 omap3_get_vp_errorgain(int vp_id, unsigned long volt)
 {
 	unsigned long lowopp_volt;
 
+	if (cpu_is_omap3630()) {
+		switch (volt) {
+		case 930000:
+			return OMAP3630_VP_CONFIG_ERRORGAIN_OPP50;
+		case 1100000:
+		case 1137500:
+			return OMAP3630_VP_CONFIG_ERRORGAIN_OPP100;
+		case 1260000:
+			return OMAP3630_VP_CONFIG_ERRORGAIN_OPPTB;
+		case 1310000:
+			return OMAP3630_VP_CONFIG_ERRORGAIN_OPP1G;
+		default:
+			pr_warning("Wrong voltage. Unable to retrieve \
+				error gain for VP %d", vp_id + 1);
+			return 0;
+		}
+	}
 	if (vp_id == VP1)
 		lowopp_volt = VDD1_LOWOPP_VOLT;
 	else if (vp_id == VP2)
@@ -232,8 +249,8 @@ static u8 omap3_get_vp_errorgain(int vp_id, unsigned long volt)
 		pr_warning("Voltage processor%d does not exisit", vp_id);
 		return 0;
 	}
-	return ((volt > lowopp_volt) ? (OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-		(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP));
+	return ((volt > lowopp_volt) ? (OMAP3430_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+		(OMAP3430_VP_CONFIG_ERRORGAIN_LOWOPP));
 }
 static void vp_latch_vsel(int vp_id)
 {
@@ -311,18 +328,36 @@ static void __init vp_reg_configure(int vp_id)
 
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VP1) {
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
 			curr_volt = get_curr_vdd1_voltage();
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+			} else {
+				vlimitto_vddmin = OMAP3430_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP1_VLIMITTO_VDDMAX;
+			}
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VP2) {
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
 			curr_volt = get_curr_vdd2_voltage();
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+			} else {
+				vlimitto_vddmin = OMAP3430_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP2_VLIMITTO_VDDMAX;
+			}
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP2_TRANXDONE_ST;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index a350444..61b3220 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -54,19 +54,39 @@
  * board file or PMIC data structure
  */
 #define OMAP3_VP_CONFIG_ERROROFFSET		0x00
-#define OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
-#define OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
 #define OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x3C
 #define OMAP3_VP_VSTEPMIN_VSTEPMIN		0x1
 #define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x3C
 #define OMAP3_VP_VSTEPMAX_VSTEPMAX		0x04
-#define OMAP3_VP1_VLIMITTO_VDDMIN		0x14
-#define OMAP3_VP1_VLIMITTO_VDDMAX		0x42
-#define OMAP3_VP2_VLIMITTO_VDDMAX		0x2C
-#define OMAP3_VP2_VLIMITTO_VDDMIN		0x18
 #define OMAP3_VP_VLIMITTO_TIMEOUT_US		0x200
 
 #define VOLTAGE_MOD	OMAP3430_GR_MOD
+
+/*
+ * Omap3430 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3430_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
+#define OMAP3430_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
+#define OMAP3430_VP1_VLIMITTO_VDDMIN		0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX		0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMAX		0x2C
+#define OMAP3430_VP2_VLIMITTO_VDDMIN		0x18
+
+/*
+ * Omap3630 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP50	0x0C
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP100	0x16
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPPTB	0x23
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP1G	0x27
+#define OMAP3630_VP1_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX		0x3C
+#define OMAP3630_VP2_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX		0x30
+
+
 /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
 
 void omap_voltageprocessor_enable(int vp_id);
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index d540ae8..7a94feb 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -169,6 +169,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* OMAP3630 only CONTROL_GENERAL register offsets */
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD1	(OMAP2_CONTROL_GENERAL + 0x0114)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD1	(OMAP2_CONTROL_GENERAL + 0x0118)
+#define OMAP3630_CONTROL_FUSE_OPP120_VDD1	(OMAP2_CONTROL_GENERAL + 0x011C)
+#define OMAP3630_CONTROL_FUSE_OPPTM_VDD1	(OMAP2_CONTROL_GENERAL + 0x0120)
+#define OMAP3630_CONTROL_FUSE_OPP50_VDD2	(OMAP2_CONTROL_GENERAL + 0x0128)
+#define OMAP3630_CONTROL_FUSE_OPP100_VDD2	(OMAP2_CONTROL_GENERAL + 0x012C)
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
-- 
1.7.0.rc1.33.g07cf0f

