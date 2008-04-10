From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] Powerdomains: add OMAP2 powerdomains
Date: Thu, 10 Apr 2008 08:46:28 -0600
Message-ID: <20080410153344.157299727@pwsan.com>
References: <20080410144624.246788469@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47227 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbYDJRPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:15:15 -0400
Content-Disposition: inline; filename=add_omap2_powerdomains.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add OMAP2-specific powerdomains.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/powerdomains.h     |   16 ++-
 arch/arm/mach-omap2/powerdomains24xx.h |  176 ++++++++++++++++++++++++=
+++++++++
 arch/arm/mach-omap2/prm-regbits-24xx.h |   12 +-
 3 files changed, 199 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/powerdomains.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/powerdomains.h	2008-04-10 07:55=
:34.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/powerdomains.h	2008-04-10 07:58:09.0=
00000000 -0600
@@ -79,7 +79,6 @@
 static struct powerdomain mpu_34xx_pwrdm;
 static struct powerdomain iva2_pwrdm;
=20
-
 /* OMAP2/3-common powerdomains and wakeup dependencies */
=20
 /*
@@ -96,6 +95,11 @@
 	{ NULL },
 };
=20
+/* Include 24XX-specific powerdomains (which may reference the above w=
kdeps) */
+
+#include "powerdomains24xx.h"
+
+
 /*
  * OMAP2/3 common powerdomains
  */
@@ -137,6 +141,16 @@
 	&gfx_pwrdm,
 	&wkup_pwrdm,
=20
+#ifdef CONFIG_ARCH_OMAP24XX
+	&dsp_pwrdm,
+	&mpu_24xx_pwrdm,
+	&core_24xx_pwrdm,
+#endif
+
+#ifdef CONFIG_ARCH_OMAP243X
+	&mdm_pwrdm,
+#endif
+
 	NULL
 };
=20
Index: linux-omap/arch/arm/mach-omap2/powerdomains24xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/powerdomains24xx.h	2008-04-10 07:58:=
23.000000000 -0600
@@ -0,0 +1,176 @@
+/*
+ * OMAP24XX powerdomain definitions
+ *
+ * Copyright (C) 2007-8 Texas Instruments, Inc.
+ * Copyright (C) 2007-8 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ * Debugging and integration fixes by Jouni H=C3=B6gander
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
+
+/*
+ * N.B. If powerdomains are added or removed from this file, update
+ * the array in mach-omap2/powerdomains.h.
+ */
+
+#include <asm/arch/powerdomain.h>
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+/* Forward declarations - so powerdomain dependencies can be encoded *=
/
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct powerdomain dsp_pwrdm;
+static struct powerdomain mpu_24xx_pwrdm;
+static struct powerdomain core_24xx_pwrdm;
+static struct powerdomain iva2_pwrdm;
+static struct powerdomain mdm_pwrdm;
+#endif
+
+
+/* 24XX powerdomains and dependencies */
+
+
+#ifdef CONFIG_ARCH_OMAP24XX
+
+
+/* Wakeup dependency source arrays */
+
+/*
+ * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
+ * 2430 PM_WKDEP_MDM: same as above
+ */
+static struct pwrdm_dep dsp_mdm_24xx_wkdeps[] =3D {
+	{ .pwrdm =3D &core_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &mpu_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2430 adds MDM
+ */
+static struct pwrdm_dep mpu_24xx_wkdeps[] =3D {
+	{ .pwrdm =3D &core_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &dsp_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &mdm_pwrdm,		.omap_chip =3D CHIP_IS_OMAP2430 },
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
+ * 2430 adds MDM
+ */
+static struct pwrdm_dep core_24xx_wkdeps[] =3D {
+	{ .pwrdm =3D &dsp_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &gfx_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &mpu_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &mdm_pwrdm,		.omap_chip =3D CHIP_IS_OMAP2430 },
+	{ NULL },
+};
+
+
+/* Powerdomains */
+
+static struct powerdomain dsp_pwrdm =3D {
+	.name		  =3D "dsp_pwrdm",
+	.prcm_offs	  =3D OMAP24XX_DSP_MOD,
+	.omap_chip	  =3D CHIP_IS_OMAP24XX,
+	.dep_bit	  =3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	  =3D dsp_mdm_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain mpu_24xx_pwrdm =3D {
+	.name		  =3D "mpu_pwrdm",
+	.prcm_offs	  =3D MPU_MOD,
+	.omap_chip	  =3D CHIP_IS_OMAP24XX,
+	.dep_bit	  =3D OMAP24XX_EN_MPU_SHIFT,
+	.wkdep_srcs	  =3D mpu_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain core_24xx_pwrdm =3D {
+	.name		  =3D "core_pwrdm",
+	.prcm_offs	  =3D CORE_MOD,
+	.omap_chip	  =3D CHIP_IS_OMAP24XX,
+	.wkdep_srcs	  =3D core_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.dep_bit	  =3D OMAP24XX_EN_CORE_SHIFT,
+	.banks		  =3D 3,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
+		[1] =3D PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
+		[2] =3D PWRSTS_OFF_RET,	 /* MEM3RETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
+		[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+		[2] =3D PWRSTS_OFF_RET_ON, /* MEM3ONSTATE */
+	},
+};
+
+#endif	   /* CONFIG_ARCH_OMAP24XX */
+
+
+
+/*
+ * 2430-specific powerdomains
+ */
+
+#ifdef CONFIG_ARCH_OMAP2430
+
+/* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
+
+/* Another case of bit name collisions between several registers: EN_M=
DM */
+static struct powerdomain mdm_pwrdm =3D {
+	.name		  =3D "mdm_pwrdm",
+	.prcm_offs	  =3D OMAP2430_MDM_MOD,
+	.omap_chip	  =3D CHIP_IS_OMAP2430,
+	.dep_bit	  =3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+	.wkdep_srcs	  =3D dsp_mdm_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+#endif     /* CONFIG_ARCH_OMAP2430 */
+
+
+#endif
Index: linux-omap/arch/arm/mach-omap2/prm-regbits-24xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/prm-regbits-24xx.h	2008-04-10 0=
7:54:32.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/prm-regbits-24xx.h	2008-04-10 07:55:=
56.000000000 -0600
@@ -29,8 +29,10 @@
 #define OMAP24XX_WKUP1_EN				(1 << 0)
=20
 /* PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_DSP, PM_WKDEP_MDM shared bits =
*/
-#define OMAP24XX_EN_MPU					(1 << 1)
-#define OMAP24XX_EN_CORE				(1 << 0)
+#define OMAP24XX_EN_MPU_SHIFT				1
+#define OMAP24XX_EN_MPU_MASK				(1 << 1)
+#define OMAP24XX_EN_CORE_SHIFT 				0
+#define OMAP24XX_EN_CORE_MASK				(1 << 0)
=20
 /*
  * PM_PWSTCTRL_MPU, PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM
@@ -140,8 +142,10 @@
 /* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" instead */
=20
 /* PM_WKDEP_MPU specific bits */
-#define OMAP2430_PM_WKDEP_MPU_EN_MDM			(1 << 5)
-#define OMAP24XX_PM_WKDEP_MPU_EN_DSP			(1 << 2)
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT		5
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM_MASK		(1 << 5)
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT		2
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP_MASK		(1 << 2)
=20
 /* PM_EVGENCTRL_MPU specific bits */
=20

--=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
