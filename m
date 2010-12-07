From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/14] OMAP2+: clockdomains: move clockdomain static data to
	.c files
Date: Mon, 06 Dec 2010 18:25:11 -0700
Message-ID: <20101207012510.3708.52087.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41228 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab0LGBoF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:44:05 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Static data should be declared in .c files, not .h files.  It should be
possible to #include .h files at any point without creating multiple
copies of the same data.

We converted the clock data to .c files some time ago.  This patch does
the same for the clockdomain data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                     |   10 +++-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   58 +++-----------=
--------
 arch/arm/mach-omap2/clockdomains44xx_data.c      |   42 ++++++++++++++=
--
 arch/arm/mach-omap2/io.c                         |   10 ++--
 arch/arm/plat-omap/include/plat/clockdomain.h    |   11 +++-
 5 files changed, 66 insertions(+), 65 deletions(-)
 rename arch/arm/mach-omap2/{clockdomains.h =3D> clockdomains2xxx_3xxx_=
data.c} (95%)
 rename arch/arm/mach-omap2/{clockdomains44xx.h =3D> clockdomains44xx_d=
ata.c} (90%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 609fa78..78a2a5d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -10,8 +10,7 @@ omap-2-3-common				=3D irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				=3D omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				=3D clock.o clock_common_data.o \
-					  clockdomain.o clkt_dpll.o \
-					  clkt_clksel.o
+					  clkt_dpll.o clkt_clksel.o
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(hwmod-common)
@@ -82,6 +81,13 @@ obj-$(CONFIG_ARCH_OMAP4)		+=3D $(powerdomain-common)=
 \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
=20
+# PRCM clockdomain control
+obj-$(CONFIG_ARCH_OMAP2)		+=3D clockdomain.o \
+					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D clockdomain.o \
+					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D clockdomain.o \
+					   clockdomains44xx_data.o
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clock-common) clock2xxx.o \
 					   clkt2xxx_sys.o \
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/c=
lockdomains2xxx_3xxx_data.c
similarity index 95%
rename from arch/arm/mach-omap2/clockdomains.h
rename to arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 2a3b10a..8dadf75 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2008-2009 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  *
- * Written by Paul Walmsley and Jouni H=C3=B6gander
+ * Paul Walmsley, Jouni H=C3=B6gander
  *
  * This file contains clockdomains and clockdomain wakeup/sleep
  * dependencies for the OMAP2/3 chips.  Some notes:
@@ -32,8 +32,8 @@
  *    from the Power domain framework
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
+#include <linux/kernel.h>
+#include <linux/io.h>
=20
 #include <plat/clockdomain.h>
 #include "cm.h"
@@ -89,8 +89,6 @@ static struct clkdm_dep gfx_sgx_wkdeps[] =3D {
=20
 /* 24XX-specific possible dependencies */
=20
-#ifdef CONFIG_ARCH_OMAP2
-
 /* Wakeup dependency source arrays */
=20
 /* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
@@ -170,8 +168,6 @@ static struct clkdm_dep core_24xx_wkdeps[] =3D {
 	{ NULL },
 };
=20
-#endif
-
=20
 /* 2430-specific possible wakeup dependencies */
=20
@@ -430,8 +426,6 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
  * sys_clkout/sys_clkout2.
  */
=20
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
 /* This is an implicit clockdomain - it is never defined as such in TR=
M */
 static struct clockdomain wkup_clkdm =3D {
 	.name		=3D "wkup_clkdm",
@@ -452,8 +446,6 @@ static struct clockdomain cm_clkdm =3D {
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
=20
-#endif
-
 /*
  * 2420-only clockdomains
  */
@@ -836,8 +828,6 @@ static struct clockdomain dpll5_clkdm =3D {
=20
 #endif   /* CONFIG_ARCH_OMAP3 */
=20
-#include "clockdomains44xx.h"
-
 /*
  * Clockdomain hwsup dependencies (OMAP3 only)
  */
@@ -856,17 +846,10 @@ static struct clkdm_autodep clkdm_autodeps[] =3D =
{
 	}
 };
=20
-/*
- * List of clockdomain pointers per platform
- */
-
-static struct clockdomain *clockdomains_omap[] =3D {
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+static struct clockdomain *clockdomains_omap2[] __initdata =3D {
 	&wkup_clkdm,
 	&cm_clkdm,
 	&prm_clkdm,
-#endif
=20
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,
@@ -908,35 +891,10 @@ static struct clockdomain *clockdomains_omap[] =3D=
 {
 	&dpll4_clkdm,
 	&dpll5_clkdm,
 #endif
-
-#ifdef CONFIG_ARCH_OMAP4
-	&l4_cefuse_44xx_clkdm,
-	&l4_cfg_44xx_clkdm,
-	&tesla_44xx_clkdm,
-	&l3_gfx_44xx_clkdm,
-	&ivahd_44xx_clkdm,
-	&l4_secure_44xx_clkdm,
-	&l4_per_44xx_clkdm,
-	&abe_44xx_clkdm,
-	&l3_instr_44xx_clkdm,
-	&l3_init_44xx_clkdm,
-	&mpuss_44xx_clkdm,
-	&mpu0_44xx_clkdm,
-	&mpu1_44xx_clkdm,
-	&l3_emif_44xx_clkdm,
-	&l4_ao_44xx_clkdm,
-	&ducati_44xx_clkdm,
-	&l3_2_44xx_clkdm,
-	&l3_1_44xx_clkdm,
-	&l3_d2d_44xx_clkdm,
-	&iss_44xx_clkdm,
-	&l3_dss_44xx_clkdm,
-	&l4_wkup_44xx_clkdm,
-	&emu_sys_44xx_clkdm,
-	&l3_dma_44xx_clkdm,
-#endif
-
 	NULL,
 };
=20
-#endif
+void __init omap2_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap2, clkdm_autodeps);
+}
diff --git a/arch/arm/mach-omap2/clockdomains44xx.h b/arch/arm/mach-oma=
p2/clockdomains44xx_data.c
similarity index 90%
rename from arch/arm/mach-omap2/clockdomains44xx.h
rename to arch/arm/mach-omap2/clockdomains44xx_data.c
index 7e5ba0f..c847a8b 100644
--- a/arch/arm/mach-omap2/clockdomains44xx.h
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -23,12 +23,15 @@
  * -> Populate the Sleep/Wakeup dependencies for the domains
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
+#include <linux/kernel.h>
+#include <linux/io.h>
=20
 #include <plat/clockdomain.h>
=20
-#if defined(CONFIG_ARCH_OMAP4)
+#include "cm44xx.h"
+#include "prm44xx.h"
+#include "cm-regbits-44xx.h"
+#include "prm-regbits-44xx.h"
=20
 static struct clockdomain l4_cefuse_44xx_clkdm =3D {
 	.name		  =3D "l4_cefuse_clkdm",
@@ -245,6 +248,35 @@ static struct clockdomain l3_dma_44xx_clkdm =3D {
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
=20
-#endif
+static struct clockdomain *clockdomains_omap44xx[] __initdata =3D {
+	&l4_cefuse_44xx_clkdm,
+	&l4_cfg_44xx_clkdm,
+	&tesla_44xx_clkdm,
+	&l3_gfx_44xx_clkdm,
+	&ivahd_44xx_clkdm,
+	&l4_secure_44xx_clkdm,
+	&l4_per_44xx_clkdm,
+	&abe_44xx_clkdm,
+	&l3_instr_44xx_clkdm,
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
+	NULL,
+};
=20
-#endif
+void __init omap44xx_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap44xx, NULL);
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6336044..d05638ac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -42,8 +42,6 @@
 #include <plat/powerdomain.h>
=20
 #include <plat/clockdomain.h>
-#include "clockdomains.h"
-
 #include <plat/omap_hwmod.h>
=20
 /*
@@ -317,19 +315,19 @@ void __init omap2_init_common_hw(struct omap_sdrc=
_params *sdrc_cs0,
=20
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
 		omap2xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap44xx_clockdomains_init();
 		omap44xx_hwmod_init();
 	}
=20
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/p=
lat-omap/include/plat/clockdomain.h
index ba0a6c0..a5f8579 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -4,18 +4,22 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX This should be moved to mach-omap2/ at the earliest opportunity=
=2E
  */
=20
 #ifndef __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
 #define __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
=20
+#include <linux/init.h>
+
 #include <plat/powerdomain.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -138,4 +142,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)=
;
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk=
);
=20
+extern void __init omap2_clockdomains_init(void);
+extern void __init omap44xx_clockdomains_init(void);
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
