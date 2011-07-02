From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP4: OPP: add OMAP4460 definitions
Date: Sat, 2 Jul 2011 19:50:47 +0530
Message-ID: <1309616447-9448-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab1GBOTQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 10:19:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p62EJCwD025803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 2 Jul 2011 09:19:14 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p62EJBab005293
	for <linux-omap@vger.kernel.org>; Sat, 2 Jul 2011 19:49:12 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Nishanth Menon <nm@ti.com>

Add OMAP4460 OPP definitions for voltage and frequencies based on
OMAP4460 ES1.0 DM Operating Condition Addendum Version 0.1

The following exceptions are present:
* Smartreflex support is still on experimental mode: the gains and min
  limits are currently pending characterization data. Currently OMAP4430 values
  are used.
* Efuse offset for core OPP100-OV setting is not clear in documentation.
* IVA OPPs beyond OPP100 are disabled due to the delta between max OMAP4460
  current requirements and Phoenix Max supply on VCORE2 in the default
  configuration - boards which have supply which can support this should
  explicitly call opp_enable and enable the same.
* MPU OPPs > OPPTURBO can easily be detected using a efuse burnt - currently
  disabled pending clock changes to support DCC feature.

Pathch is generated against Patch series "[PATCH v2 0/6] OMAP4: Add 4460 base support" from Rajendra.

[nm@ti.com: cleanups and updates from Datamanual]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/control.h                 |    1 +
 arch/arm/mach-omap2/omap_opp_data.h           |    9 ++-
 arch/arm/mach-omap2/opp4xxx_data.c            |   96 ++++++++++++++++++++++---
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   14 +++-
 4 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a016c8b..a41b9a7 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -195,6 +195,7 @@
 #define OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO	0x249
 #define OMAP44XX_CONTROL_FUSE_CORE_OPP50	0x254
 #define OMAP44XX_CONTROL_FUSE_CORE_OPP100	0x257
+#define OMAP44XX_CONTROL_FUSE_CORE_OPP100OV	0x25A
 
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..18a750e 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -89,8 +89,11 @@ extern struct omap_volt_data omap34xx_vddcore_volt_data[];
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap36xx_vddcore_volt_data[];
 
-extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
-extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
-extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
+extern struct omap_volt_data omap443x_vdd_mpu_volt_data[];
+extern struct omap_volt_data omap443x_vdd_iva_volt_data[];
+extern struct omap_volt_data omap443x_vdd_core_volt_data[];
+extern struct omap_volt_data omap446x_vdd_mpu_volt_data[];
+extern struct omap_volt_data omap446x_vdd_iva_volt_data[];
+extern struct omap_volt_data omap446x_vdd_core_volt_data[];
 
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..8c285e4 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 OPP table definitions.
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
  *	Nishanth Menon
  *	Kevin Hilman
  *	Thara Gopinath
@@ -36,7 +36,7 @@
 #define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
 #define OMAP4430_VDD_MPU_OPPNITRO_UV		1375000
 
-struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
+struct omap_volt_data omap443x_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
 	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP100_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP100, 0xf9, 0x16),
 	VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23),
@@ -48,7 +48,7 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 #define OMAP4430_VDD_IVA_OPP100_UV		1188000
 #define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
 
-struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
+struct omap_volt_data omap443x_vdd_iva_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
 	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP100_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP100, 0xf9, 0x16),
 	VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23),
@@ -58,14 +58,14 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
 #define OMAP4430_VDD_CORE_OPP50_UV		1025000
 #define OMAP4430_VDD_CORE_OPP100_UV		1200000
 
-struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
+struct omap_volt_data omap443x_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP50_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),
 	VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP100_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16),
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
 
-static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
+static struct omap_opp_def __initdata omap443x_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
 	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
 	/* MPU OPP2 - OPP100 */
@@ -87,6 +87,82 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* TODO: add DSP, aess, fdif, gpu */
 };
 
+#define OMAP4460_VDD_MPU_OPP50_UV		1025000
+#define OMAP4460_VDD_MPU_OPP100_UV		1200000
+#define OMAP4460_VDD_MPU_OPPTURBO_UV		1313000
+#define OMAP4460_VDD_MPU_OPPNITRO_UV		1375000
+
+struct omap_volt_data omap446x_vdd_mpu_volt_data[] = {
+	VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPP50_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPP100_UV, OMAP44XX_CONTROL_FUSE_MPU_OPP100, 0xf9, 0x16),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPPNITRO_UV, OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO, 0xfa, 0x27),
+	VOLT_DATA_DEFINE(0, 0, 0, 0),
+};
+
+#define OMAP4460_VDD_IVA_OPP50_UV		1025000
+#define OMAP4460_VDD_IVA_OPP100_UV		1200000
+#define OMAP4460_VDD_IVA_OPPTURBO_UV		1313000
+#define OMAP4460_VDD_IVA_OPPNITRO_UV		1375000
+
+struct omap_volt_data omap446x_vdd_iva_volt_data[] = {
+	VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPP50_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPP100_UV, OMAP44XX_CONTROL_FUSE_IVA_OPP100, 0xf9, 0x16),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPPTURBO_UV, OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPPNITRO_UV, OMAP44XX_CONTROL_FUSE_IVA_OPPNITRO, 0xfa, 0x23),
+	VOLT_DATA_DEFINE(0, 0, 0, 0),
+};
+
+#define OMAP4460_VDD_CORE_OPP50_UV		1025000
+#define OMAP4460_VDD_CORE_OPP100_UV		1200000
+#define OMAP4460_VDD_CORE_OPP100_OV_UV		1250000
+
+struct omap_volt_data omap446x_vdd_core_volt_data[] = {
+	VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP50_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP100_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16),
+	VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP100_OV_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP100OV, 0xf9, 0x16),
+	VOLT_DATA_DEFINE(0, 0, 0, 0),
+};
+
+static struct omap_opp_def __initdata omap446x_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OPP_INITIALIZER("mpu", true, 350000000, OMAP4460_VDD_MPU_OPP50_UV),
+	/* MPU OPP2 - OPP100 */
+	OPP_INITIALIZER("mpu", true, 700000000, OMAP4460_VDD_MPU_OPP100_UV),
+	/* MPU OPP3 - OPP-Turbo */
+	OPP_INITIALIZER("mpu", true, 920000000, OMAP4460_VDD_MPU_OPPTURBO_UV),
+	/*
+	 * MPU OPP4 - OPP-Nitro + Disabled as the reference schematics
+	 * recommends TPS623631 - confirm and enable the opp in board file
+	 * XXX: May be we should enable these based on mpu capability and
+	 * Exception board files disable it...
+	 */
+	OPP_INITIALIZER("mpu", false, 1200000000, OMAP4460_VDD_MPU_OPPNITRO_UV),
+	/* MPU OPP4 - OPP-Nitro SpeedBin */
+	OPP_INITIALIZER("mpu", false, 1500000000, OMAP4460_VDD_MPU_OPPNITRO_UV),
+	/* L3 OPP1 - OPP50 */
+	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4460_VDD_CORE_OPP50_UV),
+	/* L3 OPP2 - OPP100 */
+	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4460_VDD_CORE_OPP100_UV),
+	/* IVA OPP1 - OPP50 */
+	OPP_INITIALIZER("iva", true, 133000000, OMAP4460_VDD_IVA_OPP50_UV),
+	/* IVA OPP2 - OPP100 */
+	OPP_INITIALIZER("iva", true, 266100000, OMAP4460_VDD_IVA_OPP100_UV),
+	/*
+	 * IVA OPP3 - OPP-Turbo + Disabled as the reference schematics
+	 * recommends Phoenix VCORE2 which can supply only 600mA - so the ones
+	 * above this OPP frequency, even though OMAP is capable, should be
+	 * enabled by board file which is sure of the chip power capability
+	 */
+	OPP_INITIALIZER("iva", false, 332000000, OMAP4460_VDD_IVA_OPPTURBO_UV),
+	/* IVA OPP4 - OPP-Nitro */
+	OPP_INITIALIZER("iva", false, 430000000, OMAP4460_VDD_IVA_OPPNITRO_UV),
+	/* IVA OPP5 - OPP-Nitro SpeedBin*/
+	OPP_INITIALIZER("iva", false, 500000000, OMAP4460_VDD_IVA_OPPNITRO_UV),
+
+	/* TODO: add DSP, aess, fdif, gpu */
+};
+
 /**
  * omap4_opp_init() - initialize omap4 opp table
  */
@@ -96,10 +172,12 @@ int __init omap4_opp_init(void)
 
 	if (!cpu_is_omap44xx())
 		return r;
-
-	r = omap_init_opp_table(omap44xx_opp_def_list,
-			ARRAY_SIZE(omap44xx_opp_def_list));
-
+	if (cpu_is_omap443x())
+		r = omap_init_opp_table(omap443x_opp_def_list,
+			ARRAY_SIZE(omap443x_opp_def_list));
+	else if (cpu_is_omap446x())
+		r = omap_init_opp_table(omap446x_opp_def_list,
+			ARRAY_SIZE(omap446x_opp_def_list));
 	return r;
 }
 device_initcall(omap4_opp_init);
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index cb64996..f516cfe 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -91,9 +91,17 @@ static int __init omap44xx_voltage_early_init(void)
 	 * XXX Will depend on the process, validation, and binning
 	 * for the currently-running IC
 	 */
-	omap4_vdd_mpu_info.volt_data = omap44xx_vdd_mpu_volt_data;
-	omap4_vdd_iva_info.volt_data = omap44xx_vdd_iva_volt_data;
-	omap4_vdd_core_info.volt_data = omap44xx_vdd_core_volt_data;
+	if (cpu_is_omap443x()) {
+		omap4_vdd_mpu_info.volt_data = omap443x_vdd_mpu_volt_data;
+		omap4_vdd_iva_info.volt_data = omap443x_vdd_iva_volt_data;
+		omap4_vdd_core_info.volt_data = omap443x_vdd_core_volt_data;
+	} else if (cpu_is_omap446x()) {
+		omap4_vdd_mpu_info.volt_data = omap446x_vdd_mpu_volt_data;
+		omap4_vdd_iva_info.volt_data = omap446x_vdd_iva_volt_data;
+		omap4_vdd_core_info.volt_data = omap446x_vdd_core_volt_data;
+	} else {
+		return -ENODATA;
+	}
 
 	return omap_voltage_early_init(prm_mod, prm_irqst_ocp_mod,
 				       omap4_vdd_info,
-- 
1.7.0.4

