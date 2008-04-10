From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] Clockdomains: encode OMAP2/3 clockdomains
Date: Thu, 10 Apr 2008 10:25:35 -0600
Message-ID: <20080410163626.143952707@pwsan.com>
References: <20080410162532.097381890@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34130 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbYDJRRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:17:47 -0400
Content-Disposition: inline; filename=add_24xx_34xx_clockdomains.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add clockdomain definitions for OMAP24xx and OMAP34xx chips.  


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clockdomains.h    |  283 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-24xx.h |   24 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h |   42 +++--
 arch/arm/mach-omap2/io.c              |    4 
 arch/arm/mach-omap2/pm.c              |   12 -
 drivers/dsp/dspgateway/dsp_core.c     |    2 
 6 files changed, 342 insertions(+), 25 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clockdomains.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/clockdomains.h	2008-04-10 10:15:48.000000000 -0600
@@ -0,0 +1,283 @@
+/*
+ * OMAP2/3 clockdomains
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
+
+#include <asm/arch/clockdomain.h>
+
+/*
+ * OMAP2/3-common clockdomains
+ */
+
+/* This is an implicit clockdomain - it is never defined as such in TRM */
+static struct clockdomain wkup_clkdm = {
+	.name		= "wkup_clkdm",
+	.pwrdm_name	= "wkup_pwrdm",
+	.omap_chip	= CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430,
+};
+
+/*
+ * 2420-only clockdomains
+ */
+
+#if defined(CONFIG_ARCH_OMAP2420)
+
+static struct clockdomain mpu_2420_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm_name	= "mpu_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
+	.omap_chip	= CHIP_IS_OMAP24XX,
+};
+
+#endif  /* CONFIG_ARCH_OMAP2420 */
+
+
+/*
+ * 2430-only clockdomains
+ */
+
+#if defined(CONFIG_ARCH_OMAP2430)
+
+static struct clockdomain mpu_2430_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm_name	= "mpu_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
+	.omap_chip	= CHIP_IS_OMAP24XX,
+};
+
+static struct clockdomain mdm_clkdm = {
+	.name		= "mdm_clkdm",
+	.pwrdm_name	= "mdm_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
+	.omap_chip	= CHIP_IS_OMAP2430,
+};
+
+#endif    /* CONFIG_ARCH_OMAP2430 */
+
+
+/*
+ * 24XX-only clockdomains
+ */
+
+#if defined(CONFIG_ARCH_OMAP24XX)
+
+static struct clockdomain dsp_clkdm = {
+	.name		= "dsp_clkdm",
+	.pwrdm_name	= "dsp_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
+	.omap_chip	= CHIP_IS_OMAP24XX,
+};
+
+static struct clockdomain gfx_24xx_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm_name	= "gfx_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
+	.omap_chip	= CHIP_IS_OMAP24XX,
+};
+
+static struct clockdomain core_l3_24xx_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain core_l4_24xx_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain dss_24xx_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
+	.omap_chip	= CHIP_IS_OMAP24XX,
+};
+
+#endif   /* CONFIG_ARCH_OMAP24XX */
+
+
+/*
+ * 34xx clockdomains
+ */
+
+#if defined(CONFIG_ARCH_OMAP34XX)
+
+static struct clockdomain mpu_34xx_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm_name	= "mpu_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain neon_clkdm = {
+	.name		= "neon_clkdm",
+	.pwrdm_name	= "neon_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain iva2_clkdm = {
+	.name		= "iva2_clkdm",
+	.pwrdm_name	= "iva2_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain gfx_3430es1_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm_name	= "gfx_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430ES1,
+};
+
+static struct clockdomain sgx_clkdm = {
+	.name		= "sgx_clkdm",
+	.pwrdm_name	= "sgx_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430ES2,
+};
+
+static struct clockdomain d2d_clkdm = {
+	.name		= "d2d_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430ES1,
+};
+
+static struct clockdomain core_l3_34xx_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain core_l4_34xx_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm_name	= "core_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain dss_34xx_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm_name	= "dss_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain cam_clkdm = {
+	.name		= "cam_clkdm",
+	.pwrdm_name	= "cam_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain usbhost_clkdm = {
+	.name		= "usbhost_clkdm",
+	.pwrdm_name	= "usbhost_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430ES2,
+};
+
+static struct clockdomain per_clkdm = {
+	.name		= "per_clkdm",
+	.pwrdm_name	= "per_pwrdm",
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+static struct clockdomain emu_clkdm = {
+	.name		= "emu_clkdm",
+	.pwrdm_name	= "emu_pwrdm",
+	.flags		= CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
+	.omap_chip	= CHIP_IS_OMAP3430,
+};
+
+#endif   /* CONFIG_ARCH_OMAP34XX */
+
+/*
+ * Clockdomain-powerdomain hwsup dependencies (34XX only)
+ */
+
+static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
+	{ .pwrdm_name = "mpu_pwrdm",	.omap_chip = CHIP_IS_OMAP3430 },
+	{ .pwrdm_name = "iva2_pwrdm",	.omap_chip = CHIP_IS_OMAP3430 },
+	{ NULL }
+};
+
+/*
+ *
+ */
+
+static struct clockdomain *clockdomains_omap[] = {
+
+	&wkup_clkdm,
+
+#ifdef CONFIG_ARCH_OMAP2420
+	&mpu_2420_clkdm,
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+	&mpu_2430_clkdm,
+	&mdm_clkdm,
+#endif
+
+#ifdef CONFIG_ARCH_OMAP24XX
+	&dsp_clkdm,
+	&gfx_24xx_clkdm,
+	&core_l3_24xx_clkdm,
+	&core_l4_24xx_clkdm,
+	&dss_24xx_clkdm,
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+	&mpu_34xx_clkdm,
+	&neon_clkdm,
+	&iva2_clkdm,
+	&gfx_3430es1_clkdm,
+	&sgx_clkdm,
+	&d2d_clkdm,
+	&core_l3_34xx_clkdm,
+	&core_l4_34xx_clkdm,
+	&dss_34xx_clkdm,
+	&cam_clkdm,
+	&usbhost_clkdm,
+	&per_clkdm,
+	&emu_clkdm,
+#endif
+
+	NULL,
+};
+
+#endif
Index: linux-omap/arch/arm/mach-omap2/cm-regbits-24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm-regbits-24xx.h	2008-04-10 08:15:41.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm-regbits-24xx.h	2008-04-10 09:53:22.000000000 -0600
@@ -63,7 +63,8 @@
 #define OMAP24XX_CLKSEL_MPU_MASK			(0x1f << 0)
 
 /* CM_CLKSTCTRL_MPU */
-#define OMAP24XX_AUTOSTATE_MPU				(1 << 0)
+#define OMAP24XX_AUTOSTATE_MPU_SHIFT			0
+#define OMAP24XX_AUTOSTATE_MPU_MASK			(1 << 0)
 
 /* CM_FCLKEN1_CORE specific bits*/
 #define OMAP24XX_EN_TV_SHIFT				2
@@ -238,9 +239,12 @@
 #define OMAP24XX_CLKSEL_GPT2_MASK			(0x3 << 2)
 
 /* CM_CLKSTCTRL_CORE */
-#define OMAP24XX_AUTOSTATE_DSS				(1 << 2)
-#define OMAP24XX_AUTOSTATE_L4				(1 << 1)
-#define OMAP24XX_AUTOSTATE_L3				(1 << 0)
+#define OMAP24XX_AUTOSTATE_DSS_SHIFT			2
+#define OMAP24XX_AUTOSTATE_DSS_MASK			(1 << 2)
+#define OMAP24XX_AUTOSTATE_L4_SHIFT			1
+#define OMAP24XX_AUTOSTATE_L4_MASK			(1 << 1)
+#define OMAP24XX_AUTOSTATE_L3_SHIFT			0
+#define OMAP24XX_AUTOSTATE_L3_MASK			(1 << 0)
 
 /* CM_FCLKEN_GFX */
 #define OMAP24XX_EN_3D_SHIFT				2
@@ -255,7 +259,8 @@
 /* CM_CLKSEL_GFX specific bits */
 
 /* CM_CLKSTCTRL_GFX */
-#define OMAP24XX_AUTOSTATE_GFX				(1 << 0)
+#define OMAP24XX_AUTOSTATE_GFX_SHIFT			0
+#define OMAP24XX_AUTOSTATE_GFX_MASK			(1 << 0)
 
 /* CM_FCLKEN_WKUP specific bits */
 
@@ -367,8 +372,10 @@
 #define OMAP24XX_CLKSEL_DSP_MASK			(0x1f << 0)
 
 /* CM_CLKSTCTRL_DSP */
-#define OMAP2420_AUTOSTATE_IVA				(1 << 8)
-#define OMAP24XX_AUTOSTATE_DSP				(1 << 0)
+#define OMAP2420_AUTOSTATE_IVA_SHIFT			8
+#define OMAP2420_AUTOSTATE_IVA_MASK			(1 << 8)
+#define OMAP24XX_AUTOSTATE_DSP_SHIFT			0
+#define OMAP24XX_AUTOSTATE_DSP_MASK			(1 << 0)
 
 /* CM_FCLKEN_MDM */
 /* 2430 only */
@@ -396,6 +403,7 @@
 
 /* CM_CLKSTCTRL_MDM */
 /* 2430 only */
-#define OMAP2430_AUTOSTATE_MDM				(1 << 0)
+#define OMAP2430_AUTOSTATE_MDM_SHIFT			0
+#define OMAP2430_AUTOSTATE_MDM_MASK			(1 << 0)
 
 #endif
Index: linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-04-10 08:15:41.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-04-10 09:53:22.000000000 -0600
@@ -96,7 +96,8 @@
 #define OMAP3430_CLKTRCTRL_IVA2_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_IVA2 */
-#define OMAP3430_CLKACTIVITY_IVA2			(1 << 0)
+#define OMAP3430_CLKACTIVITY_IVA2_SHIFT			0
+#define OMAP3430_CLKACTIVITY_IVA2_MASK			(1 << 0)
 
 /* CM_REVISION specific bits */
 
@@ -140,7 +141,8 @@
 #define OMAP3430_CLKTRCTRL_MPU_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_MPU */
-#define OMAP3430_CLKACTIVITY_MPU			(1 << 0)
+#define OMAP3430_CLKACTIVITY_MPU_SHIFT			0
+#define OMAP3430_CLKACTIVITY_MPU_MASK			(1 << 0)
 
 /* CM_FCLKEN1_CORE specific bits */
 
@@ -300,9 +302,12 @@
 #define OMAP3430_CLKTRCTRL_L3_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_CORE */
-#define OMAP3430ES1_CLKACTIVITY_D2D			(1 << 2)
-#define OMAP3430_CLKACTIVITY_L4				(1 << 1)
-#define OMAP3430_CLKACTIVITY_L3				(1 << 0)
+#define OMAP3430ES1_CLKACTIVITY_D2D_SHIFT		2
+#define OMAP3430ES1_CLKACTIVITY_D2D_MASK		(1 << 2)
+#define OMAP3430_CLKACTIVITY_L4_SHIFT			1
+#define OMAP3430_CLKACTIVITY_L4_MASK			(1 << 1)
+#define OMAP3430_CLKACTIVITY_L3_SHIFT			0
+#define OMAP3430_CLKACTIVITY_L3_MASK			(1 << 0)
 
 /* CM_FCLKEN_GFX */
 #define OMAP3430ES1_EN_3D				(1 << 2)
@@ -323,7 +328,8 @@
 #define OMAP3430ES1_CLKTRCTRL_GFX_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_GFX */
-#define OMAP3430ES1_CLKACTIVITY_GFX			(1 << 0)
+#define OMAP3430ES1_CLKACTIVITY_GFX_SHIFT		0
+#define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
 
 /* CM_FCLKEN_SGX */
 #define OMAP3430ES2_EN_SGX_SHIFT			1
@@ -333,6 +339,14 @@
 #define OMAP3430ES2_CLKSEL_SGX_SHIFT			0
 #define OMAP3430ES2_CLKSEL_SGX_MASK			(0x7 << 0)
 
+/* CM_CLKSTCTRL_SGX */
+#define OMAP3430ES2_CLKTRCTRL_SGX_SHIFT			0
+#define OMAP3430ES2_CLKTRCTRL_SGX_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_SGX */
+#define OMAP3430ES2_CLKACTIVITY_SGX_SHIFT		0
+#define OMAP3430ES2_CLKACTIVITY_SGX_MASK		(1 << 0)
+
 /* CM_FCLKEN_WKUP specific bits */
 #define OMAP3430ES2_EN_USIMOCP_SHIFT			9
 
@@ -498,7 +512,8 @@
 #define OMAP3430_CLKTRCTRL_DSS_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_DSS */
-#define OMAP3430_CLKACTIVITY_DSS			(1 << 0)
+#define OMAP3430_CLKACTIVITY_DSS_SHIFT			0
+#define OMAP3430_CLKACTIVITY_DSS_MASK			(1 << 0)
 
 /* CM_FCLKEN_CAM specific bits */
 
@@ -522,7 +537,8 @@
 #define OMAP3430_CLKTRCTRL_CAM_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_CAM */
-#define OMAP3430_CLKACTIVITY_CAM			(1 << 0)
+#define OMAP3430_CLKACTIVITY_CAM_SHIFT			0
+#define OMAP3430_CLKACTIVITY_CAM_MASK			(1 << 0)
 
 /* CM_FCLKEN_PER specific bits */
 
@@ -598,7 +614,8 @@
 #define OMAP3430_CLKTRCTRL_PER_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_PER */
-#define OMAP3430_CLKACTIVITY_PER			(1 << 0)
+#define OMAP3430_CLKACTIVITY_PER_SHIFT			0
+#define OMAP3430_CLKACTIVITY_PER_MASK			(1 << 0)
 
 /* CM_CLKSEL1_EMU */
 #define OMAP3430_DIV_DPLL4_SHIFT			24
@@ -623,7 +640,8 @@
 #define OMAP3430_CLKTRCTRL_EMU_MASK			(0x3 << 0)
 
 /* CM_CLKSTST_EMU */
-#define OMAP3430_CLKACTIVITY_EMU			(1 << 0)
+#define OMAP3430_CLKACTIVITY_EMU_SHIFT			0
+#define OMAP3430_CLKACTIVITY_EMU_MASK			(1 << 0)
 
 /* CM_CLKSEL2_EMU specific bits */
 #define OMAP3430_CORE_DPLL_EMU_MULT_SHIFT		8
@@ -673,6 +691,8 @@
 #define OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT		0
 #define OMAP3430ES2_CLKTRCTRL_USBHOST_MASK		(3 << 0)
 
-
+/* CM_CLKSTST_USBHOST */
+#define OMAP3430ES2_CLKACTIVITY_USBHOST_SHIFT		0
+#define OMAP3430ES2_CLKACTIVITY_USBHOST_MASK		(1 << 0)
 
 #endif
Index: linux-omap/arch/arm/mach-omap2/io.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/io.c	2008-04-10 09:53:04.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/io.c	2008-04-10 09:53:22.000000000 -0600
@@ -31,6 +31,9 @@
 
 #include "powerdomains.h"
 
+#include <asm/arch/clockdomain.h>
+#include "clockdomains.h"
+
 extern void omap_sram_init(void);
 extern int omap2_clk_init(void);
 extern void omap2_check_revision(void);
@@ -193,6 +196,7 @@
 {
 	omap2_mux_init();
 	pwrdm_init(powerdomains_omap);
+	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 	omap2_init_memory();
 	gpmc_init();
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2008-04-10 09:53:04.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/pm.c	2008-04-10 09:53:22.000000000 -0600
@@ -679,12 +679,14 @@
 			  GFX_MOD, PM_PWSTCTRL);
 
 	/* Enable clock auto control for all domains */
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_MPU, MPU_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_DSS | OMAP24XX_AUTOSTATE_L4 |
-			 OMAP24XX_AUTOSTATE_L3,
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_MPU_MASK, MPU_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_DSS_MASK |
+			 OMAP24XX_AUTOSTATE_L4_MASK |
+			 OMAP24XX_AUTOSTATE_L3_MASK,
 			 CORE_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_GFX, GFX_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP2420_AUTOSTATE_IVA | OMAP24XX_AUTOSTATE_DSP,
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_GFX_MASK, GFX_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(OMAP2420_AUTOSTATE_IVA_MASK |
+			 OMAP24XX_AUTOSTATE_DSP_MASK,
 			 OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
 
 	/* Enable clock autoidle for all domains */
Index: linux-omap/drivers/dsp/dspgateway/dsp_core.c
===================================================================
--- linux-omap.orig/drivers/dsp/dspgateway/dsp_core.c	2008-04-10 08:15:41.000000000 -0600
+++ linux-omap/drivers/dsp/dspgateway/dsp_core.c	2008-04-10 09:53:22.000000000 -0600
@@ -467,7 +467,7 @@
 	cm_set_mod_reg_bits(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD,
 			    CM_AUTOIDLE);
 
-	cm_set_mod_reg_bits(OMAP24XX_AUTOSTATE_DSP, OMAP24XX_DSP_MOD,
+	cm_set_mod_reg_bits(OMAP24XX_AUTOSTATE_DSP_MASK, OMAP24XX_DSP_MOD,
 			    CM_CLKSTCTRL);
 
 	clk_enable(dsp_fck_handle);

-- 

