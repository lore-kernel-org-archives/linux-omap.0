From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 3/3] OMAP3: PM: Adding OMAP3630 support in smartreflex driver
Date: Mon,  8 Mar 2010 22:50:51 +0530
Message-ID: <1268068851-30022-4-git-send-email-thara@ti.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
 <1268068851-30022-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39609 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab0CHRVF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 12:21:05 -0500
In-Reply-To: <1268068851-30022-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

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
 arch/arm/mach-omap2/omap_hwmod_34xx.h     |   49 ++++++++-
 arch/arm/mach-omap2/smartreflex.c         |  105 ++++++++++++++++++-
 arch/arm/mach-omap2/voltage.c             |  167 ++++++++++++++++++++++-------
 arch/arm/mach-omap2/voltage.h             |   32 +++++--
 arch/arm/plat-omap/include/plat/control.h |    8 ++
 5 files changed, 313 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index dccb4a4..eb2233b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -204,6 +204,19 @@ static struct omap_hwmod_sysconfig sr_if_ctrl = {
 	.sysc_fields	= &sr_sysc_fields,
 };
 
+static struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26
+};
+
+static struct omap_hwmod_sysconfig omap36xx_sr_if_ctrl = {
+	.sysc_offs	= 0x38,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			SYSC_NO_CACHE),
+	.sysc_fields	= &omap36xx_sr_sysc_fields,
+};
+
 /* SR1 */
 static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
@@ -218,10 +231,24 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.slaves		= omap34xx_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
 	.sysconfig	= &sr_if_ctrl,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static struct omap_hwmod omap36xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.mpu_irqs	= NULL,
+	.sdma_chs	= NULL,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "sr1_fck",
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
+	.sysconfig	= &omap36xx_sr_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 /* SR2 */
 static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
@@ -236,10 +263,26 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.slaves		= omap34xx_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
 	.sysconfig	= &sr_if_ctrl,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
+					CHIP_IS_OMAP3430ES3_0 |
+					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+
+static struct omap_hwmod omap36xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.mpu_irqs	= NULL,
+	.sdma_chs	= NULL,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "sr2_fck",
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
+	.sysconfig	= &omap36xx_sr_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
+
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_l3_hwmod,
 	&omap34xx_l4_core_hwmod,
@@ -248,6 +291,8 @@ static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_mpu_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2b1c529..1f13fab 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -497,7 +497,18 @@ int sr_enable(int srid, u32 target_opp_no)
 	 * For OMAP3430 errminlimit is dependent on opp. So choose
 	 * it appropriately
 	 */
-	if (cpu_is_omap343x())
+	if (cpu_is_omap3630()) {
+		switch (target_opp_no) {
+		case 1:
+			sr->err_minlimit = OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+			break;
+		case 2:
+			sr->err_minlimit = OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			break;
+		default:
+			sr->err_minlimit = OMAP3630_SR_ERRMINLIMIT_OPPTM;
+		}
+	} else if (cpu_is_omap343x())
 		sr->err_minlimit = (target_opp_no > 2) ?
 			OMAP3430_SR_ERRMINLIMIT_HIGHOPP :
 			OMAP3430_SR_ERRMINLIMIT_LOWOPP;
@@ -936,10 +947,100 @@ static void __init omap3_sr_set_testing_nvalues(
 	}
 }
 
+static void __init omap3630_sr_read_efuse(
+			struct omap_smartreflex_data *sr_data, int sr_id)
+{
+	if (sr_id == SR1) {
+		/*
+		 * TODO: When opp framework come into picture use appropriate
+		 * API's to find out number of opp's.
+		 */
+		sr_data->no_opp = 4;
+		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
+					sr_data->no_opp , GFP_KERNEL);
+		if (WARN_ON(!sr_data->sr_nvalue))
+			return;
+
+		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENNENABLE_MASK) >>
+					OMAP343X_SR1_SENNENABLE_SHIFT;
+		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENPENABLE_MASK) >>
+					OMAP343X_SR1_SENPENABLE_SHIFT;
+		sr_data->sr_nvalue[3] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPPTM_VDD1);
+		sr_data->sr_nvalue[2] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP120_VDD1);
+		sr_data->sr_nvalue[1] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP100_VDD1);
+		sr_data->sr_nvalue[0] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP50_VDD1);
+	} else if (sr_id == SR2) {
+		/*
+		 * TODO: When opp framework come into picture use appropriate
+		 * API's to find out number of opp's.
+		 */
+		sr_data->no_opp = 2;
+		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
+					sr_data->no_opp , GFP_KERNEL);
+		if (WARN_ON(!sr_data->sr_nvalue))
+			return;
+
+		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENNENABLE_MASK) >>
+					OMAP343X_SR2_SENNENABLE_SHIFT;
+		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENPENABLE_MASK) >>
+					OMAP343X_SR2_SENPENABLE_SHIFT;
+		sr_data->sr_nvalue[1] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP100_VDD2);
+		sr_data->sr_nvalue[0] = omap_ctrl_readl(
+					OMAP3630_CONTROL_FUSE_OPP50_VDD2);
+	}
+}
+
+/* OMAP3630 Hard coded nvalues for testing purposes.*/
+static void __init omap3630_sr_set_testing_nvalues(
+			struct omap_smartreflex_data *sr_data, int srid)
+{
+	if (srid == SR1) {
+		sr_data->no_opp = 4;
+		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
+				sr_data->no_opp , GFP_KERNEL);
+		if (WARN_ON(!sr_data->sr_nvalue))
+			return;
+
+		sr_data->senp_mod = 0x1;
+		sr_data->senn_mod = 0x1;
+		/* OMAP3630 nvalues for each VDD1 opp */
+		sr_data->sr_nvalue[3] = 0xaab197;
+		sr_data->sr_nvalue[2] = 0xaac5a8;
+		sr_data->sr_nvalue[1] = 0x999b83;
+		sr_data->sr_nvalue[0] = 0x898beb;
+	} else if (srid == SR2) {
+		sr_data->no_opp = 2;
+		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
+				sr_data->no_opp , GFP_KERNEL);
+		if (WARN_ON(!sr_data->sr_nvalue))
+			return;
+
+		sr_data->senp_mod = 0x1;
+		sr_data->senn_mod = 0x1;
+		/* OMAP3630 nvalues for each VDD2 opp */
+		sr_data->sr_nvalue[1] = 0x9a8cee;
+		sr_data->sr_nvalue[0] = 0x898beb;
+	}
+}
+
 static void __init sr_set_nvalues(struct omap_smartreflex_data *sr_data,
 						int srid)
 {
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap3630()) {
+		if (SR_TESTING_NVALUES)
+			omap3630_sr_set_testing_nvalues(sr_data, srid);
+		else
+			omap3630_sr_read_efuse(sr_data, srid);
+	} else if (cpu_is_omap343x()) {
 		if (SR_TESTING_NVALUES)
 			omap3_sr_set_testing_nvalues(sr_data, srid);
 		else
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4f325af..b723927 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -80,6 +80,9 @@ static struct vp_reg_info *vp_reg;
  */
 static int no_scalable_vdd;
 
+/* Structure containing error gain values */
+static u8 *omap_errorgain;
+
 /* OMAP3 VP register offsets and other definitions */
 struct __init vp_reg_offs omap3_vp_offs[] = {
 	/* VP1 */
@@ -104,6 +107,25 @@ struct __init vp_reg_offs omap3_vp_offs[] = {
 #define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vp_offs)
 static struct vp_reg_info omap3_vp_reg[OMAP3_NO_SCALABLE_VDD];
 
+/*
+ * OMAP3430 Error Gain values. OMAP3430 has two errorgain
+ * values - one for OPP2 and below and one for above.
+ */
+static u8 omap3430_errorgain[2] = {
+	OMAP3430_VP_CONFIG_ERRORGAIN_LOWOPP,
+	OMAP3430_VP_CONFIG_ERRORGAIN_HIGHOPP
+};
+
+/*
+ * OMAP3630 Error Gain values. OMAP3630 has four errorgain
+ * values - one for each OPP
+ */
+static u8 omap3630_errorgain[4] = {
+	OMAP3630_VP_CONFIG_ERRORGAIN_OPP50,
+	OMAP3630_VP_CONFIG_ERRORGAIN_OPP100,
+	OMAP3630_VP_CONFIG_ERRORGAIN_OPP120,
+	OMAP3630_VP_CONFIG_ERRORGAIN_OPPTM
+};
 
 /* TODO: OMAP4 register offsets */
 
@@ -289,32 +311,66 @@ static void __init vp_reg_configure(int vp_id)
 
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VP1) {
-			/*
-			 * OMAP3430 has error gain varying btw higher and
-			 * lower opp's
-			 */
-			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+				/*
+				 * OMAP3630 has error gain varying btw
+				 * all opp's
+				 */
+				vp_reg[vp_id].vp_errorgain =
+					(omap_errorgain[get_vdd1_opp() - 1] <<
+					OMAP3430_ERRORGAIN_SHIFT);
+			} else {
+				vlimitto_vddmin = OMAP3430_VP1_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP1_VLIMITTO_VDDMAX;
+				/*
+				 * OMAP3430 has error gain varying btw higher
+				 * and lower opp's
+				 */
+				vp_reg[vp_id].vp_errorgain =
+					(((get_vdd1_opp() > 2) ?
+					(omap_errorgain[1]) :
+					(omap_errorgain[0])) <<
 					OMAP3430_ERRORGAIN_SHIFT);
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
+			}
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VP2) {
-			/*
-			 * OMAP3430 has error gain varying btw higher and
-			 * lower opp's
-			 */
-			vp_reg[vp_id].vp_errorgain = (((get_vdd2_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+			u8 vlimitto_vddmin, vlimitto_vddmax;
+
+			if (cpu_is_omap3630()) {
+				vlimitto_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+				/*
+				 * OMAP3630 has error gain varying btw
+				 * all opp's
+				 */
+				vp_reg[vp_id].vp_errorgain =
+					(omap_errorgain[get_vdd2_opp() - 1] <<
+					 OMAP3430_ERRORGAIN_SHIFT);
+			} else {
+				vlimitto_vddmin = OMAP3430_VP2_VLIMITTO_VDDMIN;
+				vlimitto_vddmax = OMAP3430_VP2_VLIMITTO_VDDMAX;
+				/*
+				 * OMAP3430 has error gain varying btw higher
+				 * and lower opp's
+				 */
+				vp_reg[vp_id].vp_errorgain =
+					(((get_vdd2_opp() > 2) ?
+					(omap_errorgain[1]) :
+					(omap_errorgain[0])) <<
 					OMAP3430_ERRORGAIN_SHIFT);
-			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
+			}
+			vp_reg[vp_id].vp_vddmin = (vlimitto_vddmin <<
 					OMAP3430_VDDMIN_SHIFT);
-			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
+			vp_reg[vp_id].vp_vddmax = (vlimitto_vddmax <<
 					OMAP3430_VDDMAX_SHIFT);
 			vp_reg[vp_id].vp_tranxdone_status =
 					OMAP3430_VP2_TRANXDONE_ST;
@@ -369,7 +425,6 @@ static int vp_forceupdate_scale_voltage(u32 vdd, u8 target_vsel,
 
 	smps_steps = abs(target_vsel - current_vsel);
 
-	/* OMAP3430 has errorgain varying btw higher and lower opp's */
 	if (cpu_is_omap34xx()) {
 		if (vdd == VDD1_OPP) {
 			u32 vc_cmdval0;
@@ -378,9 +433,20 @@ static int vp_forceupdate_scale_voltage(u32 vdd, u8 target_vsel,
 			vc_cmdval0 &= ~VC_CMD_ON_MASK;
 			vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
 			voltage_write_reg(vc_reg.vc_cmdval0_reg, vc_cmdval0);
-			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+			/*
+			 * OMAP3630 has error gain varying btw
+			 * all opp's where are 3430 has it varying between
+			 * higher and lower opp's
+			 */
+			if (cpu_is_omap3630())
+				vp_reg[vp_id].vp_errorgain =
+					(omap_errorgain[get_vdd1_opp() - 1] <<
+					OMAP3430_ERRORGAIN_SHIFT);
+			else
+				vp_reg[vp_id].vp_errorgain =
+					(((get_vdd1_opp() > 2) ?
+					(omap_errorgain[1]) :
+					(omap_errorgain[0])) <<
 					OMAP3430_ERRORGAIN_SHIFT);
 		} else if (vdd == VDD2_OPP) {
 			u32 vc_cmdval1;
@@ -389,9 +455,20 @@ static int vp_forceupdate_scale_voltage(u32 vdd, u8 target_vsel,
 			vc_cmdval1 &= ~VC_CMD_ON_MASK;
 			vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
 			voltage_write_reg(vc_reg.vc_cmdval1_reg, vc_cmdval1);
-			vp_reg[vp_id].vp_errorgain = (((get_vdd2_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+			/*
+			 * OMAP3630 has error gain varying btw
+			 * all opp's where are 3430 has it varying between
+			 * higher and lower opp's
+			 */
+			if (cpu_is_omap3630())
+				vp_reg[vp_id].vp_errorgain =
+					(omap_errorgain[get_vdd2_opp() - 1] <<
+					OMAP3430_ERRORGAIN_SHIFT);
+			else
+				vp_reg[vp_id].vp_errorgain =
+					(((get_vdd2_opp() > 2) ?
+					(omap_errorgain[1]) :
+					(omap_errorgain[0])) <<
 					OMAP3430_ERRORGAIN_SHIFT);
 		}
 	}
@@ -498,12 +575,18 @@ static int vc_bypass_scale_voltage(u32 vdd, u8 target_vsel, u8 current_vsel)
 		vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
 		voltage_write_reg(vc_reg.vc_cmdval0_reg, vc_cmdval0);
 		reg_addr = R_VDD1_SR_CONTROL;
-		/* OMAP3430 has errorgain varying btw higher and lower opp's */
-		if (cpu_is_omap34xx())
-			vp_reg[vdd].vp_errorgain = (((get_vdd1_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
-					OMAP3430_ERRORGAIN_SHIFT);
+		/*
+		 * OMAP3630 has error gain varying btw all opp's where
+		 * are 3430 has it varying between higher and lower opp's
+		 */
+		if (cpu_is_omap3630())
+			vp_reg[vp_id].vp_errorgain =
+				(omap_errorgain[get_vdd1_opp() - 1] <<
+				OMAP3430_ERRORGAIN_SHIFT);
+		else
+			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
+				(omap_errorgain[1]) : (omap_errorgain[0])) <<
+				OMAP3430_ERRORGAIN_SHIFT);
 	} else if (vdd == VDD2_OPP) {
 		u32 vc_cmdval1;
 
@@ -512,12 +595,18 @@ static int vc_bypass_scale_voltage(u32 vdd, u8 target_vsel, u8 current_vsel)
 		vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
 		voltage_write_reg(vc_reg.vc_cmdval1_reg, vc_cmdval1);
 		reg_addr = R_VDD2_SR_CONTROL;
-		/* OMAP3430 has errorgain varying btw higher and lower opp's */
-		if (cpu_is_omap34xx())
-			vp_reg[vdd].vp_errorgain = (((get_vdd2_opp() > 2) ?
-					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
-					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
-					OMAP3430_ERRORGAIN_SHIFT);
+		/*
+		 * OMAP3630 has error gain varying btw all opp's where
+		 * are 3430 has it varying between higher and lower opp's
+		 */
+		if (cpu_is_omap3630())
+			vp_reg[vp_id].vp_errorgain =
+				(omap_errorgain[get_vdd2_opp() - 1] <<
+				OMAP3430_ERRORGAIN_SHIFT);
+		else
+			vp_reg[vp_id].vp_errorgain = (((get_vdd2_opp() > 2) ?
+				(omap_errorgain[1]) : (omap_errorgain[0])) <<
+				OMAP3430_ERRORGAIN_SHIFT);
 	} else {
 		pr_warning("Wrong VDD passed in vc_bypass_scale_voltage %d\n",
 				vdd);
@@ -577,6 +666,10 @@ static void __init init_voltageprocessors(void)
 	if (cpu_is_omap34xx()) {
 		vp_reg = omap3_vp_reg;
 		no_scalable_vdd = OMAP3_NO_SCALABLE_VDD;
+		if (cpu_is_omap3630())
+			omap_errorgain = omap3630_errorgain;
+		else
+			omap_errorgain = omap3430_errorgain;
 	} else {
 		/* TODO: Add support for OMAP4 */
 		pr_warning("Voltage processor support not yet added \n");
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 615bde6..8135b91 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -50,23 +50,41 @@ extern int get_vdd2_opp(void);
 
 
 /*
- * Omap 3430 VP registerspecific values. Maybe these need to come from
+ * Omap3 generic VP register values. Maybe these need to come from
  * board file or PMIC data structure
  */
 #define OMAP3_VP_CONFIG_ERROROFFSET		0x00
-#define OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
-#define OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
 #define	OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x3C
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
+
+/* Omap3430 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3430_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
+#define OMAP3430_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
+#define OMAP3430_VP1_VLIMITTO_VDDMIN		0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX		0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMAX		0x2C
+#define OMAP3430_VP2_VLIMITTO_VDDMIN		0x18
+
+/* Omap3430 specific VP register values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP50	0x0C
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP100	0x16
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPP120	0x23
+#define OMAP3630_VP_CONFIG_ERRORGAIN_OPPTM	0x27
+#define OMAP3630_VP1_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX		0x3C
+#define OMAP3630_VP2_VLIMITTO_VDDMIN		0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX		0x30
+
 /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
 
 void omap_voltageprocessor_enable(int vp_id);
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 804ed50..9b5e87b 100644
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

