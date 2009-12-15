From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [v2 PATCH 4/5] ARM: OMAP4: PM: Adapt the existing OMAP2/3 Clock Domain Frameworks.
Date: Tue, 15 Dec 2009 19:22:56 +0530
Message-ID: <1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
References: <1260885177-25665-1-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-2-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-3-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760191AbZLONxN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 08:53:13 -0500
In-Reply-To: <1260885177-25665-3-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

The introduction of the OMAP4 Clock Domain framework requires
some adaptaions to be done in the earlier files to place the
common and uncommon data in the proper places where they belong.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains.h     |   48 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clockdomains44xx.h |    5 +++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 0e61140..f985e0a 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -7,12 +7,18 @@
  * Written by Paul Walmsley
  */
 
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
 
 #include <plat/clockdomain.h>
 #include "cm.h"
-#include "prm44xx.h"
+#include "prm.h"
 
 /*
  * OMAP2/3-common clockdomains
@@ -23,6 +29,8 @@
  * sys_clkout/sys_clkout2.
  */
 
+#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+
 /* This is an implicit clockdomain - it is never defined as such in TRM */
 static struct clockdomain wkup_clkdm = {
 	.name		= "wkup_clkdm",
@@ -42,6 +50,8 @@ static struct clockdomain cm_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
+#endif
+
 /*
  * 2420-only clockdomains
  */
@@ -365,11 +375,15 @@ static struct clockdomain dpll5_clkdm = {
 
 #endif   /* CONFIG_ARCH_OMAP34XX */
 
+#include "clockdomains44xx.h"
+
 /*
  * Clockdomain-powerdomain hwsup dependencies (34XX only)
  */
 
 static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
+
+#ifdef CONFIG_ARCH_OMAP34XX
 	{
 		.pwrdm	   = { .name = "mpu_pwrdm" },
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -381,17 +395,21 @@ static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
 	{
 		.pwrdm	   = { .name = NULL },
 	}
+#endif
+
 };
 
 /*
- *
+ * List of clockdomain pointers per platform
  */
 
 static struct clockdomain *clockdomains_omap[] = {
 
+#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
 	&wkup_clkdm,
 	&cm_clkdm,
 	&prm_clkdm,
+#endif
 
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,
@@ -434,6 +452,32 @@ static struct clockdomain *clockdomains_omap[] = {
 	&dpll5_clkdm,
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+	&l4_cefuse_44xx_clkdm,
+	&l4_cfg_44xx_clkdm,
+	&tesla_44xx_clkdm,
+	&l3_gfx_44xx_clkdm,
+	&ivahd_44xx_clkdm,
+	&l4_secure_44xx_clkdm,
+	&l4_per_44xx_clkdm,
+	&abe_44xx_clkdm,
+	&l3_init_44xx_clkdm,
+	&mpuss_44xx_clkdm,
+	&mpu0_44xx_clkdm,
+	&mpu1_44xx_clkdm,
+	&l3_emif_44xx_clkdm,
+	&l4_ao_44xx_clkdm,
+	&ducati_44xx_clkdm,
+	&l3_2_44xx_clkdm,
+	&l3_1_44xx_clkdm,
+	&l3_d2d_44xx_clkdm,
+	&iss_44xx_clkdm,
+	&l3_dss_44xx_clkdm,
+	&l4_wkup_44xx_clkdm,
+	&emu_sys_44xx_clkdm,
+	&l3_dma_44xx_clkdm,
+#endif
+
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains44xx.h b/arch/arm/mach-omap2/clockdomains44xx.h
index 2f23d38..6fc55e4 100644
--- a/arch/arm/mach-omap2/clockdomains44xx.h
+++ b/arch/arm/mach-omap2/clockdomains44xx.h
@@ -18,6 +18,11 @@
  * published by the Free Software Foundation.
  */
 
+/*
+ * To-Do List
+ * -> Populate the Sleep/Wakeup dependencies for the domains
+ */
+
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
 
-- 
1.5.4.7

