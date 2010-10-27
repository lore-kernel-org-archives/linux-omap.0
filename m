From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 5/6] OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
Date: Wed, 27 Oct 2010 21:46:35 +0530
Message-ID: <1288196196-15469-6-git-send-email-thara@ti.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36631 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603Ab0J0QQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 12:16:45 -0400
In-Reply-To: <1288196196-15469-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds dev attributes for smartreflex modules
in the OMAP4 hwmod database. This patch also updates the
smartreflex rev in the smartreflex class data structure
in the OMAP4 hwmod database.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/control.h              |   13 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   56 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index d9b5bed..7061419 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -181,6 +181,19 @@
 #define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
 #define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
 
+/* OMAP44xx control efuse offsets */
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
+
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 959c3f9..5b981aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,11 +22,13 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
 
 #include "cm.h"
 #include "prm-regbits-44xx.h"
+#include "control.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
@@ -1065,6 +1067,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 	.name = "smartreflex",
 	.sysc = &omap44xx_smartreflex_sysc,
+	.rev  = 2,
 };
 
 /* smartreflex_core */
@@ -1096,6 +1099,22 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
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
@@ -1109,6 +1128,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr	= &omap44xx_sr_core_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -1141,6 +1161,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
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
@@ -1154,6 +1191,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr	= &omap44xx_sr_iva_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -1186,6 +1224,23 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
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
@@ -1199,6 +1254,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr	= &omap44xx_sr_mpu_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-- 
1.7.0.4

