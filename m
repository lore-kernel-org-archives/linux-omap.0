From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 19/33] ARM: OMAP2+: CM: move SoC specific init calls within a generic API
Date: Fri, 13 Feb 2015 18:12:38 +0200
Message-ID: <1423843973-6050-17-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43371 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbbBMQOP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 11:14:15 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This gets rid of need for some exported driver APIs, and simplifies the
initialization of the CM driver. Done in preparation to make CM a
separate driver. The init data is now also passed to the SoC specific
implementations, allowing future expansion to add feature flags etc.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c     |    3 +--
 arch/arm/mach-omap2/cm2xxx.h     |    2 +-
 arch/arm/mach-omap2/cm33xx.c     |    3 +--
 arch/arm/mach-omap2/cm33xx.h     |    3 ++-
 arch/arm/mach-omap2/cm3xxx.c     |    3 +--
 arch/arm/mach-omap2/cm3xxx.h     |    2 +-
 arch/arm/mach-omap2/cm44xx.h     |    2 +-
 arch/arm/mach-omap2/cm_common.c  |   35 +++++++++++++++++++++++++----------
 arch/arm/mach-omap2/cminst44xx.c |    3 +--
 arch/arm/mach-omap2/io.c         |   14 +++++---------
 arch/arm/mach-omap2/prm_common.c |    8 +++++++-
 11 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index f18c844..3e5fd35 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -393,9 +393,8 @@ static struct cm_ll_data omap2xxx_cm_ll_data = {
 	.wait_module_ready	= &omap2xxx_cm_wait_module_ready,
 };
 
-int __init omap2xxx_cm_init(void)
+int __init omap2xxx_cm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_cm_base_init();
 	return cm_register(&omap2xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 83b6c59..7b8c79c 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -63,7 +63,7 @@ extern u32 omap2xxx_cm_get_core_pll_config(void);
 extern void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
 					 u32 mdm);
 
-extern int __init omap2xxx_cm_init(void);
+int __init omap2xxx_cm_init(const struct omap_prcm_init_data *data);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 4c5038c..3e85214 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -373,9 +373,8 @@ static struct cm_ll_data am33xx_cm_ll_data = {
 	.module_disable		= &am33xx_cm_module_disable,
 };
 
-int __init am33xx_cm_init(void)
+int __init am33xx_cm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_cm_base_init();
 	return cm_register(&am33xx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 046b4b2..a91f7d2 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -19,6 +19,7 @@
 
 #include "cm.h"
 #include "cm-regbits-33xx.h"
+#include "prcm-common.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
@@ -374,6 +375,6 @@
 
 
 #ifndef __ASSEMBLER__
-int am33xx_cm_init(void);
+int am33xx_cm_init(const struct omap_prcm_init_data *data);
 #endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 8e91f38..f7b64c2 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -671,9 +671,8 @@ static struct cm_ll_data omap3xxx_cm_ll_data = {
 	.wait_module_ready	= &omap3xxx_cm_wait_module_ready,
 };
 
-int __init omap3xxx_cm_init(void)
+int __init omap3xxx_cm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_cm_base_init();
 	return cm_register(&omap3xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 734a858..bc444e2 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -72,7 +72,7 @@ extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
 extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
 
-extern int __init omap3xxx_cm_init(void);
+int __init omap3xxx_cm_init(const struct omap_prcm_init_data *data);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index ad6e263..309a4c9 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -23,6 +23,6 @@
 #define OMAP4_CM_CLKSTCTRL				0x0000
 #define OMAP4_CM_STATICDEP				0x0004
 
-int omap4_cm_init(void);
+int omap4_cm_init(const struct omap_prcm_init_data *data);
 
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index ec12953..03a52ca 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -20,6 +20,7 @@
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
+#include "cm33xx.h"
 #include "cm44xx.h"
 #include "clock.h"
 
@@ -37,6 +38,7 @@ void __iomem *cm_base;
 void __iomem *cm2_base;
 
 #define CM_NO_CLOCKS		0x1
+#define CM_SINGLE_INSTANCE	0x2
 
 /**
  * omap2_set_globals_cm - set the CM/CM2 base addresses (for early use)
@@ -218,21 +220,26 @@ int cm_unregister(struct cm_ll_data *cld)
 	return 0;
 }
 
-static struct omap_prcm_init_data cm_data = {
+static struct omap_prcm_init_data cm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM1,
+	.init = omap4_cm_init,
 };
 
-static struct omap_prcm_init_data cm2_data = {
+static struct omap_prcm_init_data cm2_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM2,
+	.init = omap4_cm_init,
 };
 
-static struct omap_prcm_init_data omap2_prcm_data = {
+static struct omap_prcm_init_data omap2_prcm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM1,
-	.flags = CM_NO_CLOCKS,
+	.init = omap2xxx_cm_init,
+	.flags = CM_NO_CLOCKS | CM_SINGLE_INSTANCE,
 };
 
-static struct omap_prcm_init_data omap3_cm_data = {
+static struct omap_prcm_init_data omap3_cm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM1,
+	.init = omap3xxx_cm_init,
+	.flags = CM_SINGLE_INSTANCE,
 
 	/*
 	 * IVA2 offset is negative value, must offset the cm_base address
@@ -241,17 +248,19 @@ static struct omap_prcm_init_data omap3_cm_data = {
 	.offset = -OMAP3430_IVA2_MOD,
 };
 
-static struct omap_prcm_init_data am3_prcm_data = {
+static struct omap_prcm_init_data am3_prcm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM1,
-	.flags = CM_NO_CLOCKS,
+	.flags = CM_NO_CLOCKS | CM_SINGLE_INSTANCE,
+	.init = am33xx_cm_init,
 };
 
-static struct omap_prcm_init_data am4_prcm_data = {
+static struct omap_prcm_init_data am4_prcm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_CM1,
-	.flags = CM_NO_CLOCKS,
+	.flags = CM_NO_CLOCKS | CM_SINGLE_INSTANCE,
+	.init = omap4_cm_init,
 };
 
-static struct of_device_id omap_cm_dt_match_table[] = {
+static struct of_device_id omap_cm_dt_match_table[] __initdata = {
 	{ .compatible = "ti,omap2-prcm", .data = &omap2_prcm_data },
 	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
 	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
@@ -293,6 +302,12 @@ int __init omap2_cm_base_init(void)
 			cm2_base = mem + data->offset;
 
 		data->mem = mem;
+
+		data->np = np;
+
+		if (data->init && (data->flags & CM_SINGLE_INSTANCE ||
+				   (cm_base && cm2_base)))
+			data->init(data);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 4aed22d..2c0e07e 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -514,9 +514,8 @@ static struct cm_ll_data omap4xxx_cm_ll_data = {
 	.module_disable		= &omap4_cminst_module_disable,
 };
 
-int __init omap4_cm_init(void)
+int __init omap4_cm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_cm_base_init();
 	omap_cm_base_init();
 
 	return cm_register(&omap4xxx_cm_ll_data);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a4a88ae..5e100ed 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -387,7 +387,6 @@ void __init omap2420_init_early(void)
 	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2_prcm_base_init();
-	omap2xxx_cm_init();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
 	omap242x_clockdomains_init();
@@ -414,7 +413,6 @@ void __init omap2430_init_early(void)
 	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2_prcm_base_init();
-	omap2xxx_cm_init();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
 	omap243x_clockdomains_init();
@@ -454,8 +452,11 @@ void __init omap3_init_early(void)
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap2_prcm_base_init();
-	omap3xxx_prm_init(NULL);
-	omap3xxx_cm_init();
+	/* XXX: remove these once OMAP3 is DT only */
+	if (!of_have_populated_dt()) {
+		omap3xxx_prm_init(NULL);
+		omap3xxx_cm_init(NULL);
+	}
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -569,7 +570,6 @@ void __init am33xx_init_early(void)
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap2_prcm_base_init();
-	am33xx_cm_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
 	am33xx_hwmod_init();
@@ -592,7 +592,6 @@ void __init am43xx_init_early(void)
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap2_prcm_base_init();
-	omap4_cm_init();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
@@ -618,7 +617,6 @@ void __init omap4430_init_early(void)
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap2_prcm_base_init();
-	omap4_cm_init();
 	omap4_pm_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
@@ -648,7 +646,6 @@ void __init omap5_init_early(void)
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
-	omap4_cm_init();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
 	omap54xx_clockdomains_init();
@@ -675,7 +672,6 @@ void __init dra7xx_init_early(void)
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	dra7xxx_check_revision();
-	omap4_cm_init();
 	dra7xx_powerdomains_init();
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 0fc2da9..b828352 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -725,7 +725,13 @@ int __init omap2_prm_base_init(void)
 
 int __init omap2_prcm_base_init(void)
 {
-	return omap2_prm_base_init();
+	int ret;
+
+	ret = omap2_prm_base_init();
+	if (ret)
+		return ret;
+
+	return omap2_cm_base_init();
 }
 
 /**
-- 
1.7.9.5

