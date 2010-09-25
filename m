From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 08/11] OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
Date: Sat, 25 Sep 2010 18:21:23 +0530
Message-ID: <1285419086-13047-9-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45511 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab0IYMvj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:39 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds dev attributes for smartreflex modules
in the OMAP4 hwmod database. This patch also updates the
smartreflex rev in the smartreflex class data structure
in the OMAP4 hwmod database.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   56 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h  |   12 ++++++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ba3c215..82657b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,8 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/smartreflex.h>
+#include <plat/control.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -474,6 +476,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 	.name = "smartreflex",
 	.sysc = &omap44xx_smartreflex_sysc,
+	.rev  = 2,
 };
 
 /* smartreflex_core */
@@ -505,6 +508,22 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_core,
 };
 
+static u32 omap44xx_sr_core_efuse_offs[] = {
+	OMAP44XX_CONTROL_FUSE_CORE_OPP50, OMAP44XX_CONTROL_FUSE_CORE_OPP100,
+};
+
+static u32 omap44xx_sr_core_test_nvalues[] = {
+	0x0, 0x0
+};
+
+static struct omap_sr_dev_data omap44xx_sr_core_dev_attr = {
+	.efuse_nvalues_offs	= omap44xx_sr_core_efuse_offs,
+	.test_sennenable	= 0x1,
+	.test_senpenable	= 0x1,
+	.test_nvalues		= omap44xx_sr_core_test_nvalues,
+	.vdd_name		= "core"
+};
+
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -518,6 +537,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr	= &omap44xx_sr_core_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -550,6 +570,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_iva,
 };
 
+static u32 omap44xx_sr_iva_efuse_offs[] = {
+	OMAP44XX_CONTROL_FUSE_IVA_OPP50, OMAP44XX_CONTROL_FUSE_IVA_OPP100,
+	OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO,
+};
+
+static u32 omap44xx_sr_iva_test_nvalues[] = {
+	0x0, 0x0, 0x0, 0x0
+};
+
+static struct omap_sr_dev_data omap44xx_sr_iva_dev_attr = {
+	.efuse_nvalues_offs	= omap44xx_sr_iva_efuse_offs,
+	.test_sennenable	= 0x1,
+	.test_senpenable	= 0x1,
+	.test_nvalues		= omap44xx_sr_iva_test_nvalues,
+	.vdd_name		= "iva"
+};
+
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.name		= "smartreflex_iva",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -563,6 +600,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr	= &omap44xx_sr_iva_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -595,6 +633,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_mpu,
 };
 
+static u32 omap44xx_sr_mpu_efuse_offs[] = {
+	OMAP44XX_CONTROL_FUSE_MPU_OPP50, OMAP44XX_CONTROL_FUSE_MPU_OPP100,
+	OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO, OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO,
+};
+
+static u32 omap44xx_sr_mpu_test_nvalues[] = {
+	0x0, 0x0, 0x0, 0x0
+};
+
+static struct omap_sr_dev_data omap44xx_sr_mpu_dev_attr = {
+	.efuse_nvalues_offs	= omap44xx_sr_mpu_efuse_offs,
+	.test_sennenable	= 0x1,
+	.test_senpenable	= 0x1,
+	.test_nvalues		= omap44xx_sr_mpu_test_nvalues,
+	.vdd_name		= "mpu"
+};
+
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -608,6 +663,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr	= &omap44xx_sr_mpu_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 042eb6e..1e8f6ec 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -181,6 +181,18 @@
 #define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
 #define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
 
+/* 44xx control efuse offsets */
+#define OMAP44XX_CONTROL_FUSE_IVA_OPP50		0x22C
+#define OMAP44XX_CONTROL_FUSE_IVA_OPP100	0x22F
+#define OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO	0x232
+#define OMAP44XX_CONTROL_FUSE_IVA_OPPNITRO	0x235
+#define OMAP44XX_CONTROL_FUSE_MPU_OPP50		0x240
+#define OMAP44XX_CONTROL_FUSE_MPU_OPP100	0x243
+#define OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO	0x246
+#define OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO	0x249
+#define OMAP44XX_CONTROL_FUSE_CORE_OPP50	0x254
+#define OMAP44XX_CONTROL_FUSE_CORE_OPP100	0x257
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
-- 
1.7.0.4

