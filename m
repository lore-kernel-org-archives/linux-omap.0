From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] Powerdomains: add OMAP2/3 common powerdomains
Date: Thu, 10 Apr 2008 08:46:27 -0600
Message-ID: <20080410153344.047996986@pwsan.com>
References: <20080410144624.246788469@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47226 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbYDJRPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:15:15 -0400
Content-Disposition: inline; filename=add_common_powerdomains.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add powerdomains common to both OMAP2 and OMAP3 (WKUP and GFX/SGX), and
modify mach-omap2/io.c to initialize the powerdomain code on boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/io.c           |    4 -
 arch/arm/mach-omap2/pm.c           |    2=20
 arch/arm/mach-omap2/powerdomains.h |  144 ++++++++++++++++++++++++++++=
+++++++++
 arch/arm/mach-omap2/prm.h          |    3=20
 4 files changed, 150 insertions(+), 3 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/io.c	2008-04-10 07:54:33.000000=
000 -0600
+++ linux-omap/arch/arm/mach-omap2/io.c	2008-04-10 07:54:34.000000000 -=
0600
@@ -29,6 +29,8 @@
=20
 #include <asm/arch/powerdomain.h>
=20
+#include "powerdomains.h"
+
 extern void omap_sram_init(void);
 extern int omap2_clk_init(void);
 extern void omap2_check_revision(void);
@@ -190,7 +192,7 @@
 void __init omap2_init_common_hw(void)
 {
 	omap2_mux_init();
-	pwrdm_init(NULL);
+	pwrdm_init(powerdomains_omap);
 	omap2_clk_init();
 	omap2_init_memory();
 	gpmc_init();
Index: linux-omap/arch/arm/mach-omap2/pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2008-04-10 07:54:33.000000=
000 -0600
+++ linux-omap/arch/arm/mach-omap2/pm.c	2008-04-10 07:54:34.000000000 -=
0600
@@ -651,7 +651,7 @@
 	__raw_writel(OMAP24XX_AUTOIDLE, OMAP24XX_PRCM_SYSCONFIG);
=20
 	/* Set all domain wakeup dependencies */
-	prm_write_mod_reg(OMAP_EN_WKUP, MPU_MOD, PM_WKDEP);
+	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, CORE_MOD, PM_WKDEP);
Index: linux-omap/arch/arm/mach-omap2/powerdomains.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/powerdomains.h	2008-04-10 07:55:34.0=
00000000 -0600
@@ -0,0 +1,144 @@
+/*
+ * OMAP2/3 common powerdomain definitions
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
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
+
+/*
+ * This file contains all of the powerdomains that have some element
+ * of software control for the OMAP24xx and OMAP34XX chips.
+ *
+ * A few notes:
+ *
+ * This is not an exhaustive listing of powerdomains on the chips; onl=
y
+ * powerdomains that can be controlled in software.
+ *
+ * A useful validation rule for struct powerdomain:
+ * Any powerdomain referenced by a wkdep_srcs or sleepdep_srcs array
+ * must have a dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are real=
ly
+ * just software-controllable dependencies.  Non-software-controllable
+ * dependencies do exist, but they are not encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ */
+
+/*
+ * The names for the DSP/IVA2 powerdomains are confusing.
+ *
+ * Most OMAP chips have an on-board DSP.
+ *
+ * On the 2420, this is a 'C55 DSP called, simply, the DSP.  Its
+ * powerdomain is called the "DSP power domain."  On the 2430, the
+ * on-board DSP is a 'C64 DSP, now called the IVA2 or IVA2.1.  Its
+ * powerdomain is still called the "DSP power domain."	On the 3430,
+ * the DSP is a 'C64 DSP like the 2430, also known as the IVA2; but
+ * its powerdomain is now called the "IVA2 power domain."
+ *
+ * The 2420 also has something called the IVA, which is a separate ARM
+ * core, and has nothing to do with the DSP/IVA2.
+ *
+ * Ideally the DSP/IVA2 could just be the same powerdomain, but the PR=
CM
+ * address offset is different between the C55 and C64 DSPs.
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP s=
hift
+ * value are the same for all powerdomains: 2
+ */
+
+/*
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+#include <asm/arch/powerdomain.h>
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "cm.h"
+
+/* Forward declarations - so powerdomain dependencies can be encoded *=
/
+
+static struct powerdomain gfx_pwrdm;
+static struct powerdomain wkup_pwrdm;
+
+static struct powerdomain core_24xx_pwrdm;
+static struct powerdomain mpu_24xx_pwrdm;
+static struct powerdomain mpu_34xx_pwrdm;
+static struct powerdomain iva2_pwrdm;
+
+
+/* OMAP2/3-common powerdomains and wakeup dependencies */
+
+/*
+ * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
+ * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
+ * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ */
+static struct pwrdm_dep gfx_sgx_wkdeps[] =3D {
+	{ .pwrdm =3D &core_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &iva2_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
+	{ .pwrdm =3D &mpu_24xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP24XX },
+	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
+	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP24XX | CHIP_IS_=
OMAP3430 },
+	{ NULL },
+};
+
+/*
+ * OMAP2/3 common powerdomains
+ */
+
+/* XXX add sleepdeps for this powerdomain : 3430*/
+
+/*
+ * The GFX powerdomain is not present on 3430ES2, but currently we do =
not
+ * have a macro to filter it out at compile-time.
+ */
+static struct powerdomain gfx_pwrdm =3D {
+	.name		  =3D "gfx_pwrdm",
+	.prcm_offs	  =3D GFX_MOD,
+	.omap_chip	  =3D CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430ES1,
+	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
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
+static struct powerdomain wkup_pwrdm =3D {
+	.name		=3D "wkup_pwrdm",
+	.prcm_offs	=3D WKUP_MOD,
+	.omap_chip	=3D CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430,
+	.dep_bit	=3D OMAP_EN_WKUP_SHIFT,
+};
+
+
+
+/* As powerdomains are added or removed above, this list must also be =
changed */
+static struct powerdomain *powerdomains_omap[] __initdata =3D {
+
+	&gfx_pwrdm,
+	&wkup_pwrdm,
+
+	NULL
+};
+
+
+#endif
Index: linux-omap/arch/arm/mach-omap2/prm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/prm.h	2008-04-10 07:54:33.00000=
0000 -0600
+++ linux-omap/arch/arm/mach-omap2/prm.h	2008-04-10 07:54:34.000000000 =
-0600
@@ -323,7 +323,8 @@
  * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
  *	 PM_WKDEP_PER
  */
-#define OMAP_EN_WKUP					(1 << 4)
+#define OMAP_EN_WKUP_SHIFT				4
+#define OMAP_EN_WKUP_MASK				(1 << 4)
=20
 /*
  * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,

--=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
