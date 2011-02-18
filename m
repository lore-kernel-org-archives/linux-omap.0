From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 3/4] OMAP: Voltage: add ABB structures and data
Date: Fri, 18 Feb 2011 03:20:52 -0600
Message-ID: <1298020853-13761-3-git-send-email-mturquette@ti.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59174 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932105Ab1BRJW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 04:22:56 -0500
Received: by mail-gw0-f47.google.com with SMTP id a12so1628346gwa.20
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 01:22:54 -0800 (PST)
In-Reply-To: <1298020853-13761-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>

OMAP3630 and OMAP4 support an Adaptive Body-Bias LDO on some voltage domains
which effects voltage supplied to PMOS back-gates.  These LDOs have
different operating modes which correspond to the voltage of each VDD.

This patch introduces the data structures needed to represent the ABB LDOs
in the voltage layer, and populates the appropriate data for 3630 and OMAP4.
Note that OMAP34XX does not have this LDO, so any data for that chip has
been initialized as zero.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |  137 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/voltage.h |   28 ++++++
 2 files changed, 133 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 0cbc58a..6ede092 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -39,6 +39,10 @@
 #define VP_TRANXDONE_TIMEOUT	300
 #define VOLTAGE_DIR_SIZE	16
 
+#define ABB_TRANXDONE_TIMEOUT	30
+#define FAST_OPP		0x1
+#define NOMINAL_OPP		0x0
+
 static struct omap_vdd_info *vdd_info;
 /*
  * Number of scalable voltage domains.
@@ -59,6 +63,17 @@ static struct omap_vdd_info omap3_vdd_info[] = {
 		.voltdm = {
 			.name = "mpu",
 		},
+		.abb = {
+			.setup_offs	= OMAP3_PRM_LDO_ABB_SETUP_OFFSET,
+			.ctrl_offs	= OMAP3_PRM_LDO_ABB_CTRL_OFFSET,
+			.irqstatus_mpu_offs
+					= OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
+			.done_st_shift	= OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
+			.done_st_mask	= OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
+			.configure	= NULL,
+			.nb_handler	= NULL,
+			.set_opp	= NULL,
+		},
 	},
 	{
 		.vp_offs = {
@@ -91,6 +106,17 @@ static struct omap_vdd_info omap4_vdd_info[] = {
 		.voltdm = {
 			.name = "mpu",
 		},
+		.abb = {
+			.setup_offs	= OMAP4_PRM_LDO_ABB_MPU_SETUP_OFFSET,
+			.ctrl_offs	= OMAP4_PRM_LDO_ABB_MPU_CTRL_OFFSET,
+			.irqstatus_mpu_offs
+					= OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
+			.done_st_shift	= OMAP4430_ABB_MPU_DONE_ST_SHIFT,
+			.done_st_mask	= OMAP4430_ABB_MPU_DONE_ST_MASK,
+			.configure	= NULL,
+			.nb_handler	= NULL,
+			.set_opp	= NULL,
+		},
 	},
 	{
 		.vp_offs = {
@@ -104,6 +130,17 @@ static struct omap_vdd_info omap4_vdd_info[] = {
 		.voltdm = {
 			.name = "iva",
 		},
+		.abb = {
+			.setup_offs	= OMAP4_PRM_LDO_ABB_IVA_SETUP_OFFSET,
+			.ctrl_offs	= OMAP4_PRM_LDO_ABB_IVA_CTRL_OFFSET,
+			.irqstatus_mpu_offs
+					= OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
+			.done_st_shift	= OMAP4430_ABB_IVA_DONE_ST_SHIFT,
+			.done_st_mask	= OMAP4430_ABB_IVA_DONE_ST_MASK,
+			.configure	= NULL,
+			.nb_handler	= NULL,
+			.set_opp	= NULL,
+		},
 	},
 	{
 		.vp_offs = {
@@ -126,44 +163,64 @@ static struct omap_vdd_info omap4_vdd_info[] = {
  * Structures containing OMAP3430/OMAP3630 voltage supported and various
  * voltage dependent data for each VDD.
  */
-#define VOLT_DATA_DEFINE(_v_nom, _efuse_offs, _errminlimit, _errgain)	\
+#define VOLT_DATA_DEFINE(_v_nom, _efuse_offs, _errminlimit, _errgain,	\
+		_abb_opp)						\
 {									\
 	.volt_nominal	= _v_nom,					\
 	.sr_efuse_offs	= _efuse_offs,					\
 	.sr_errminlimit	= _errminlimit,					\
-	.vp_errgain	= _errgain					\
+	.vp_errgain	= _errgain,					\
+	.abb_opp	= _abb_opp					\
 }
 
 /* VDD1 */
 static struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP1_UV, OMAP343X_CONTROL_FUSE_OPP1_VDD1, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP2_UV, OMAP343X_CONTROL_FUSE_OPP2_VDD1, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP1_UV,
+			OMAP343X_CONTROL_FUSE_OPP1_VDD1, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP2_UV,
+			OMAP343X_CONTROL_FUSE_OPP2_VDD1, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV,
+			OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV,
+			OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV,
+			OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18, 0),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 static struct omap_volt_data omap36xx_vddmpu_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP50_UV, OMAP3630_CONTROL_FUSE_OPP50_VDD1, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV, OMAP3630_CONTROL_FUSE_OPP100_VDD1, 0xf9, 0x16),
-	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV, OMAP3630_CONTROL_FUSE_OPP120_VDD1, 0xfa, 0x23),
-	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP1G_UV, OMAP3630_CONTROL_FUSE_OPP1G_VDD1, 0xfa, 0x27),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP50_UV,
+			OMAP3630_CONTROL_FUSE_OPP50_VDD1, 0xf4, 0x0c,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV,
+			OMAP3630_CONTROL_FUSE_OPP100_VDD1, 0xf9, 0x16,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV,
+			OMAP3630_CONTROL_FUSE_OPP120_VDD1, 0xfa, 0x23,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP1G_UV,
+			OMAP3630_CONTROL_FUSE_OPP1G_VDD1, 0xfa, 0x27,
+			FAST_OPP),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 /* VDD2 */
 static struct omap_volt_data omap34xx_vddcore_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP1_UV, OMAP343X_CONTROL_FUSE_OPP1_VDD2, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP2_UV, OMAP343X_CONTROL_FUSE_OPP2_VDD2, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD2, 0xf9, 0x18),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP1_UV,
+			OMAP343X_CONTROL_FUSE_OPP1_VDD2, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP2_UV,
+			OMAP343X_CONTROL_FUSE_OPP2_VDD2, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_CORE_OPP3_UV,
+			OMAP343X_CONTROL_FUSE_OPP3_VDD2, 0xf9, 0x18, 0),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 static struct omap_volt_data omap36xx_vddcore_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP50_UV, OMAP3630_CONTROL_FUSE_OPP50_VDD2, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP100_UV, OMAP3630_CONTROL_FUSE_OPP100_VDD2, 0xf9, 0x16),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP50_UV,
+			OMAP3630_CONTROL_FUSE_OPP50_VDD2, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP100_UV,
+			OMAP3630_CONTROL_FUSE_OPP100_VDD2, 0xf9, 0x16, 0),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 /*
@@ -171,24 +228,40 @@ static struct omap_volt_data omap36xx_vddcore_volt_data[] = {
  * voltage dependent data for each VDD.
  */
 static struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP100_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP100, 0xf9, 0x16),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPNITRO_UV, OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO, 0xfa, 0x27),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV,
+			OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP100_UV,
+			OMAP44XX_CONTROL_FUSE_MPU_OPP100, 0xf9, 0x16,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPTURBO_UV,
+			OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPNITRO_UV,
+			OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO, 0xfa, 0x27,
+			FAST_OPP),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 static struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP100_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP100, 0xf9, 0x16),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV,
+			OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP100_UV,
+			OMAP44XX_CONTROL_FUSE_IVA_OPP100, 0xf9, 0x16,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPPTURBO_UV,
+			OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23,
+			NOMINAL_OPP),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
-	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP50_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),
-	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP100_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16),
-	VOLT_DATA_DEFINE(0, 0, 0, 0),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP50_UV,
+			OMAP44XX_CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c, 0),
+	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP100_UV,
+			OMAP44XX_CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16, 0),
+	VOLT_DATA_DEFINE(0, 0, 0, 0, 0),
 };
 
 /* OMAP 3430 MPU Core VDD dependency table */
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 017e65b..af790bf 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -82,12 +82,16 @@ struct voltagedomain {
  *			with voltage.
  * @vp_errorgain:	Error gain value for the voltage processor. This
  *			field also differs according to the voltage/opp.
+ * @abb_opp:		State that ABB LDO should be in at this voltage.
+ * 			LDO can be in Forward Body-Bias, Reverse Body-Bias or
+ * 			Bypassed.
  */
 struct omap_volt_data {
 	u32	volt_nominal;
 	u32	sr_efuse_offs;
 	u8	sr_errminlimit;
 	u8	vp_errgain;
+	u8	abb_opp;
 };
 
 /**
@@ -223,6 +227,29 @@ struct omap_vdd_dep_info {
 	struct omap_vdd_dep_volt *dep_table;
 };
 
+/**
+ * omap_abb_info - Adaptive Body-Bias info for a single VDD
+ *
+ * @setup_offs		: PRM_LDO_ABB_SETUP register offset
+ * @ctrl_offs		: PRM_LDO_ABB_CTRL register offset
+ * @irqstatus_mpu_offs	: PRM_IRQSTATUS_MPU* register offset
+ * @done_st_shift	: ABB_vdd_DONE_ST shift
+ * @done_st_mask	: ABB_vdd_DONE_ST bit mask
+ * @configure		: boot-time configuration
+ * @nb_handler		: voltage transition notification handler
+ * @set_opp		: transition function called from nb_handler
+ */
+struct omap_abb_info {
+	u8 setup_offs;
+	u8 ctrl_offs;
+	u8 irqstatus_mpu_offs;
+	u8 done_st_shift;
+	u32 done_st_mask;
+	int (*configure) (struct omap_abb_info *abb);
+	int (*nb_handler) (struct notifier_block *nb, unsigned long val,
+			void *data);
+	int (*set_opp) (struct omap_abb_info *abb, int opp_type);
+};
 
 /**
  * omap_vdd_info - Per Voltage Domain info
@@ -253,6 +280,7 @@ struct omap_vdd_info {
 	struct vc_reg_info vc_reg;
 	struct voltagedomain voltdm;
 	struct omap_vdd_dep_info *dep_vdd_info;
+	struct omap_abb_info abb;
 	struct srcu_notifier_head volt_change_notify_chain;
 	int nr_dep_vdd;
 	struct dentry *debug_dir;
-- 
1.7.1

