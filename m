From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 07/10] OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
Date: Wed, 18 Aug 2010 16:46:28 +0530
Message-ID: <1282130191-9062-8-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41072 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab0HRLQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:16:45 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

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
index 4984976..b249e87 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,8 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/smartreflex.h>
+#include <plat/control.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -475,6 +477,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 	.name = "smartreflex",
 	.sysc = &omap44xx_smartreflex_sysc,
+	.rev  = 2,
 };
 
 /* smartreflex_core */
@@ -506,6 +509,22 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
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
@@ -519,6 +538,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr	= &omap44xx_sr_core_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -551,6 +571,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
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
@@ -564,6 +601,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr	= &omap44xx_sr_iva_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -596,6 +634,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
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
@@ -609,6 +664,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr	= &omap44xx_sr_mpu_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 46e166d..6bf050f 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -224,6 +224,18 @@
 /* 44xx control status register offset */
 #define OMAP44XX_CONTROL_STATUS		0x2c4
 
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
 /* 44xx-only CONTROL_GENERAL register offsets */
 #define OMAP44XX_CONTROL_MMC1			0x628
 #define OMAP44XX_CONTROL_PBIAS_LITE		0x600
-- 
1.7.1.GIT

