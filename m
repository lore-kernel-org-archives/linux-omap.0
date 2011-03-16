From: Sanjeev Premi <premi@ti.com>
Subject: [RFCv2 2/2] AM35x: voltage: Basic initialization
Date: Wed, 16 Mar 2011 13:02:03 +0530
Message-ID: <1300260723-19422-3-git-send-email-premi@ti.com>
References: <1300260723-19422-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab1CPHcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 03:32:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2G7WKOp024120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 02:32:22 -0500
In-Reply-To: <1300260723-19422-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds the basic initialization of voltage layer
for AM35x. Since AM35x doesn't support voltage scaling,
Many functions emply fucntions have been defined to plug
into existing voltage layer.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/voltage.c |  110 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 109 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 2017dc0..a82a55f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -260,6 +260,40 @@ static struct omap_vdd_info omap3_vdd_info[] = {
 
 #define OMAP3_NR_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
 
+/*
+ * AM35x VDD structures
+ *
+ * In AM35x there neither scalable voltage domain nor any hook-up with
+ * voltage controller/processor. However, when trying to re-use the hwmod
+ * database for OMAP3, definition of "core" voltage domain is necessary.
+ * Else, changes in hwmod data structures grow spirally.
+ *
+ * As a workaround, "core" voltage domain is defined below. The definition
+ * doesn't lead to any side-effects.
+ */
+static struct omap_vdd_info am3517_vdd_info[] = {
+        {
+		.dep_vdd_info	= NULL,
+		.nr_dep_vdd	= 0,
+		.vp_enabled	= false,
+
+                .voltdm = {
+                        .name = "mpu",
+                },
+        },
+        {
+		.dep_vdd_info	= NULL,
+		.nr_dep_vdd	= 0,
+		.vp_enabled	= false,
+
+                .voltdm = {
+                        .name = "core",
+                },
+        },
+};
+
+#define AM3517_NR_SCALABLE_VDD ARRAY_SIZE(am3517_vdd_info)
+
 /* OMAP4 VDD sturctures */
 static struct omap_vdd_info omap4_vdd_info[] = {
 	{
@@ -374,6 +408,15 @@ static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+/* AM35x
+ *
+ * Fields related to SmartReflex and Voltage Processor are set to 0.
+ */
+static struct omap_volt_data am35xx_vdd_volt_data[] = {
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, 0x0, 0x0, 0x0),
+	VOLT_DATA_DEFINE(0, 0, 0, 0),
+};
+
 /* OMAP 3430 MPU Core VDD dependency table */
 static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
 	{.main_vdd_volt = 975000, .dep_vdd_volt = 1050000},
@@ -399,6 +442,12 @@ static void (*vp_init) (struct omap_vdd_info *vdd);
 
 static int (*vdd_data_configure) (struct omap_vdd_info *vdd);
 
+static int volt_scale_nop (struct omap_vdd_info *vdd,
+				unsigned long target_volt)
+{
+	return 0;
+}
+
 static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
 {
 	return omap2_prm_read_mod_reg(mod, offset);
@@ -1019,6 +1068,45 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	return 0;
 }
 
+/**
+ *Setup VDD related information for AM35x processors
+ */
+static int __init am3517_vdd_data_configure(struct omap_vdd_info *vdd)
+{
+	if (!vdd->pmic_info) {
+		pr_err("%s: PMIC info requried to configure vdd_%s not"
+			"populated.Hence cannot initialize vdd_%s\n",
+			__func__, vdd->voltdm.name, vdd->voltdm.name);
+		return -EINVAL;
+	}
+
+	if (!strcmp(vdd->voltdm.name, "mpu") ||
+		!strcmp(vdd->voltdm.name, "core")) {
+		vdd->volt_data = am35xx_vdd_volt_data;
+	} else {
+		pr_warning("%s: vdd_%s does not exist in AM35x\n",
+			__func__, vdd->voltdm.name);
+		return -EINVAL;
+	}
+
+	/* Generic voltage parameters */
+	vdd->curr_volt		= OMAP3430_VDD_MPU_OPP3_UV;
+	vdd->ocp_mod		= OCP_MOD;
+	vdd->prm_irqst_reg	= OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
+	vdd->read_reg		= omap3_voltage_read_reg;
+	vdd->write_reg		= omap3_voltage_write_reg;
+	vdd->volt_scale		= volt_scale_nop;
+
+	/* Init the plist */
+	spin_lock_init(&vdd->user_lock);
+	plist_head_init(&vdd->user_list, &vdd->user_lock);
+
+	/* Init the DVFS mutex */
+	mutex_init(&vdd->scaling_mutex);
+
+	return 0;
+}
+
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 {
@@ -1908,13 +1996,33 @@ int __init omap_voltage_late_init(void)
 }
 
 /**
+ * AM35x - Empty initialization of voltage controller
+ */
+static void __init am3517_vc_init(struct omap_vdd_info *vdd)
+{
+}
+
+/**
+ * AM35x - Empty initialization of voltage processor
+ */
+static void __init am3517_vp_init(struct omap_vdd_info *vdd)
+{
+}
+
+/**
  * omap_voltage_early_init()- Volatage driver early init
  */
 static int __init omap_voltage_early_init(void)
 {
 	int i;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		vdd_info		= am3517_vdd_info;
+		nr_scalable_vdd		= AM3517_NR_SCALABLE_VDD;
+		vc_init			= am3517_vc_init;
+		vp_init			= am3517_vp_init;
+		vdd_data_configure	= am3517_vdd_data_configure;
+	} else if (cpu_is_omap34xx()) {
 		vdd_info = omap3_vdd_info;
 		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
 		vc_init = omap3_vc_init;
-- 
1.7.2.2

