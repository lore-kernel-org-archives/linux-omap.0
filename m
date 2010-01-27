From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+ powerdomains/clockdomains: prepare for multi-OMAP
 configs
Date: Tue, 26 Jan 2010 20:17:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001262015210.18597@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1902945316-1264562231=:18597"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35254 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab0A0DRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 22:17:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1902945316-1264562231=:18597
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Convert CONFIG_ARCH_OMAP34XX to CONFIG_ARCH_OMAP3, and
CONFIG_ARCH_OMAP24XX to CONFIG_ARCH_OMAP2, in preparation for Tony's
multi-OMAP patches.

While here, update some copyrights, convert instances of "34xx" to
"3xxx" where applicable, and convert preprocessor directives of the
form

    #if defined(CONFIG_ARCH_OMAP2) | defined(CONFIG_ARCH_OMAP3)

to

    #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)

for standardization.

This patch is queued for 2.6.34.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomains.h     |   50 ++++++++++++++++------------=
----
 arch/arm/mach-omap2/powerdomains.h     |   16 +++++-----
 arch/arm/mach-omap2/powerdomains34xx.h |   14 ++++----
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clock=
domains.h
index fb026da..7db6298 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 clockdomains
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=F6gander
  *
@@ -196,9 +196,9 @@ static struct clkdm_dep mdm_2430_wkdeps[] =3D {
 #endif /* CONFIG_ARCH_OMAP2430 */
=20
=20
-/* 34XX-specific possible dependencies */
+/* OMAP3-specific possible dependencies */
=20
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
=20
 /* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
 static struct clkdm_dep per_wkdeps[] =3D {
@@ -251,7 +251,7 @@ static struct clkdm_dep usbhost_wkdeps[] =3D {
 };
=20
 /* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
-static struct clkdm_dep mpu_34xx_wkdeps[] =3D {
+static struct clkdm_dep mpu_3xxx_wkdeps[] =3D {
 =09{
 =09=09.clkdm_name =3D "core_l3_clkdm",
 =09=09.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -349,7 +349,7 @@ static struct clkdm_dep neon_wkdeps[] =3D {
 };
=20
=20
-/* Sleep dependency source arrays for 34xx-specific clkdms - 34XX only */
+/* Sleep dependency source arrays for OMAP3-specific clkdms */
=20
 /* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
 static struct clkdm_dep dss_sleepdeps[] =3D {
@@ -413,7 +413,7 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
 =09{ NULL },
 };
=20
-#endif /* CONFIG_ARCH_OMAP34XX */
+#endif /* CONFIG_ARCH_OMAP3 */
=20
=20
 /*
@@ -425,7 +425,7 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] =3D {
  * sys_clkout/sys_clkout2.
  */
=20
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 /* This is an implicit clockdomain - it is never defined as such in TRM */
 static struct clockdomain wkup_clkdm =3D {
@@ -626,18 +626,18 @@ static struct clockdomain dss_2430_clkdm =3D {
=20
=20
 /*
- * 34xx clockdomains
+ * OMAP3 clockdomains
  */
=20
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP3)
=20
-static struct clockdomain mpu_34xx_clkdm =3D {
+static struct clockdomain mpu_3xxx_clkdm =3D {
 =09.name=09=09=3D "mpu_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "mpu_pwrdm" },
 =09.flags=09=09=3D CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
 =09.clkstctrl_reg=09=3D OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 =09.dep_bit=09=3D OMAP3430_EN_MPU_SHIFT,
-=09.wkdep_srcs=09=3D mpu_34xx_wkdeps,
+=09.wkdep_srcs=09=3D mpu_3xxx_wkdeps,
 =09.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_MPU_MASK,
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -706,10 +706,10 @@ static struct clockdomain d2d_clkdm =3D {
=20
 /*
  * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
  * could cause trouble
  */
-static struct clockdomain core_l3_34xx_clkdm =3D {
+static struct clockdomain core_l3_3xxx_clkdm =3D {
 =09.name=09=09=3D "core_l3_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
 =09.flags=09=09=3D CLKDM_CAN_HWSUP,
@@ -721,10 +721,10 @@ static struct clockdomain core_l3_34xx_clkdm =3D {
=20
 /*
  * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
  * could cause trouble
  */
-static struct clockdomain core_l4_34xx_clkdm =3D {
+static struct clockdomain core_l4_3xxx_clkdm =3D {
 =09.name=09=09=3D "core_l4_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
 =09.flags=09=09=3D CLKDM_CAN_HWSUP,
@@ -735,7 +735,7 @@ static struct clockdomain core_l4_34xx_clkdm =3D {
 };
=20
 /* Another case of bit name collisions between several registers: EN_DSS *=
/
-static struct clockdomain dss_34xx_clkdm =3D {
+static struct clockdomain dss_3xxx_clkdm =3D {
 =09.name=09=09=3D "dss_clkdm",
 =09.pwrdm=09=09=3D { .name =3D "dss_pwrdm" },
 =09.flags=09=09=3D CLKDM_CAN_HWSUP_SWSUP,
@@ -829,12 +829,12 @@ static struct clockdomain dpll5_clkdm =3D {
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
=20
-#endif   /* CONFIG_ARCH_OMAP34XX */
+#endif   /* CONFIG_ARCH_OMAP3 */
=20
 #include "clockdomains44xx.h"
=20
 /*
- * Clockdomain hwsup dependencies (34XX only)
+ * Clockdomain hwsup dependencies (OMAP3 only)
  */
=20
 static struct clkdm_autodep clkdm_autodeps[] =3D {
@@ -857,7 +857,7 @@ static struct clkdm_autodep clkdm_autodeps[] =3D {
=20
 static struct clockdomain *clockdomains_omap[] =3D {
=20
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 =09&wkup_clkdm,
 =09&cm_clkdm,
 =09&prm_clkdm,
@@ -883,16 +883,16 @@ static struct clockdomain *clockdomains_omap[] =3D {
 =09&dss_2430_clkdm,
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP34XX
-=09&mpu_34xx_clkdm,
+#ifdef CONFIG_ARCH_OMAP3
+=09&mpu_3xxx_clkdm,
 =09&neon_clkdm,
 =09&iva2_clkdm,
 =09&gfx_3430es1_clkdm,
 =09&sgx_clkdm,
 =09&d2d_clkdm,
-=09&core_l3_34xx_clkdm,
-=09&core_l4_34xx_clkdm,
-=09&dss_34xx_clkdm,
+=09&core_l3_3xxx_clkdm,
+=09&core_l4_3xxx_clkdm,
+=09&dss_3xxx_clkdm,
 =09&cam_clkdm,
 =09&usbhost_clkdm,
 =09&per_clkdm,
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/power=
domains.h
index faa8fc9..105cbca 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -23,7 +23,7 @@
=20
 /*
  * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34XX chips.
+ * of software control for the OMAP24xx and OMAP34xx chips.
  *
  * This is not an exhaustive listing of powerdomains on the chips; only
  * powerdomains that can be controlled in software.
@@ -60,7 +60,7 @@
=20
 /* OMAP2/3-common powerdomains */
=20
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 /*
  * The GFX powerdomain is not present on 3430ES2, but currently we do not
@@ -94,12 +94,12 @@ static struct powerdomain wkup_omap2_pwrdm =3D {
 /* As powerdomains are added or removed above, this list must also be chan=
ged */
 static struct powerdomain *powerdomains_omap[] __initdata =3D {
=20
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 =09&wkup_omap2_pwrdm,
 =09&gfx_omap2_pwrdm,
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 =09&dsp_pwrdm,
 =09&mpu_24xx_pwrdm,
 =09&core_24xx_pwrdm,
@@ -109,12 +109,12 @@ static struct powerdomain *powerdomains_omap[] __init=
data =3D {
 =09&mdm_pwrdm,
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 =09&iva2_pwrdm,
-=09&mpu_34xx_pwrdm,
+=09&mpu_3xxx_pwrdm,
 =09&neon_pwrdm,
-=09&core_34xx_pre_es3_1_pwrdm,
-=09&core_34xx_es3_1_pwrdm,
+=09&core_3xxx_pre_es3_1_pwrdm,
+=09&core_3xxx_es3_1_pwrdm,
 =09&cam_pwrdm,
 =09&dss_pwrdm,
 =09&per_pwrdm,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/p=
owerdomains34xx.h
index 28228ef..186c013 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -1,8 +1,8 @@
 /*
- * OMAP34XX powerdomain definitions
+ * OMAP3 powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H=F6gander
@@ -32,7 +32,7 @@
  * 34XX-specific powerdomains, dependencies
  */
=20
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
=20
 /*
  * Powerdomains
@@ -59,7 +59,7 @@ static struct powerdomain iva2_pwrdm =3D {
 =09},
 };
=20
-static struct powerdomain mpu_34xx_pwrdm =3D {
+static struct powerdomain mpu_3xxx_pwrdm =3D {
 =09.name=09=09  =3D "mpu_pwrdm",
 =09.prcm_offs=09  =3D MPU_MOD,
 =09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -75,7 +75,7 @@ static struct powerdomain mpu_34xx_pwrdm =3D {
 =09},
 };
=20
-static struct powerdomain core_34xx_pre_es3_1_pwrdm =3D {
+static struct powerdomain core_3xxx_pre_es3_1_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D CORE_MOD,
 =09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -93,7 +93,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm =3D {
 =09},
 };
=20
-static struct powerdomain core_34xx_es3_1_pwrdm =3D {
+static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D CORE_MOD,
 =09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
@@ -243,7 +243,7 @@ static struct powerdomain dpll5_pwrdm =3D {
 };
=20
=20
-#endif    /* CONFIG_ARCH_OMAP34XX */
+#endif    /* CONFIG_ARCH_OMAP3 */
=20
=20
 #endif
--=20
1.6.6.rc2.5.g49666

--155748971-1902945316-1264562231=:18597--
