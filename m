From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/14] OMAP2+: powerdomains: move powerdomain static data to
	.c files
Date: Mon, 06 Dec 2010 18:25:10 -0700
Message-ID: <20101207012509.3708.63080.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41225 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab0LGBnv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:51 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Static data should be declared in .c files, not .h files.  It should be
possible to #include .h files at any point without creating multiple
copies of the same data.

We converted the clock data to .c files some time ago.  This patch does
the same for the powerdomain data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |   13 +-
 arch/arm/mach-omap2/io.c                         |   19 ++-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |    7 +
 arch/arm/mach-omap2/powerdomain44xx.c            |    1=20
 arch/arm/mach-omap2/powerdomains.h               |    9 +
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   81 +++++++++++
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h |   22 +++
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   43 ++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   43 ++++--
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   33 ++++-
 arch/arm/mach-omap2/powerdomains_data.c          |  159 --------------=
--------
 arch/arm/plat-omap/include/plat/powerdomain.h    |   13 +-
 12 files changed, 234 insertions(+), 209 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
 rename arch/arm/mach-omap2/{powerdomains24xx.h =3D> powerdomains2xxx_d=
ata.c} (78%)
 rename arch/arm/mach-omap2/{powerdomains34xx.h =3D> powerdomains3xxx_d=
ata.c} (89%)
 rename arch/arm/mach-omap2/{powerdomains44xx.h =3D> powerdomains44xx_d=
ata.c} (93%)
 delete mode 100644 arch/arm/mach-omap2/powerdomains_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index b5c4fe8..609fa78 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -69,13 +69,18 @@ obj-$(CONFIG_ARCH_OMAP3)		+=3D prcm.o cm.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D prcm.o cm4xxx.o
=20
 # OMAP powerdomain framework
-powerdomain-common			+=3D powerdomain.o powerdomains_data.o powerdomai=
n-common.o
+powerdomain-common			+=3D powerdomain.o powerdomain-common.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D $(powerdomain-common) \
-					   powerdomain2xxx_3xxx.o
+					   powerdomain2xxx_3xxx.o \
+					   powerdomains2xxx_data.o \
+					   powerdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D $(powerdomain-common) \
-					   powerdomain2xxx_3xxx.o
+					   powerdomain2xxx_3xxx.o \
+					   powerdomains3xxx_data.o \
+					   powerdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D $(powerdomain-common) \
-					   powerdomain44xx.o
+					   powerdomain44xx.o \
+					   powerdomains44xx_data.o
=20
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clock-common) clock2xxx.o \
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b5b385d..6336044 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -315,16 +315,23 @@ void __init omap2_init_common_hw(struct omap_sdrc=
_params *sdrc_cs0,
 {
 	u8 skip_setup_idle =3D 0;
=20
-	pwrdm_fw_init();
-	clkdm_init(clockdomains_omap, clkdm_autodeps);
-	if (cpu_is_omap242x())
+	if (cpu_is_omap242x()) {
+		omap2xxx_powerdomains_init();
+		clkdm_init(clockdomains_omap, clkdm_autodeps);
 		omap2420_hwmod_init();
-	else if (cpu_is_omap243x())
+	} else if (cpu_is_omap243x()) {
+		omap2xxx_powerdomains_init();
+		clkdm_init(clockdomains_omap, clkdm_autodeps);
 		omap2430_hwmod_init();
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
+		omap3xxx_powerdomains_init();
+		clkdm_init(clockdomains_omap, clkdm_autodeps);
 		omap3xxx_hwmod_init();
-	else if (cpu_is_omap44xx())
+	} else if (cpu_is_omap44xx()) {
+		omap44xx_powerdomains_init();
+		clkdm_init(clockdomains_omap, clkdm_autodeps);
 		omap44xx_hwmod_init();
+	}
=20
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach=
-omap2/powerdomain2xxx_3xxx.c
index 6cdf678..838ac75 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -15,10 +15,15 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+
 #include <plat/prcm.h>
-#include "prm.h"
+
 #include "prm-regbits-34xx.h"
 #include "powerdomains.h"
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "prm-regbits-34xx.h"
+
=20
 /* Common functions across OMAP2 and OMAP3 */
 static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pw=
rst)
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap=
2/powerdomain44xx.c
index 2903c7c..366e869 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+
 #include <plat/powerdomain.h>
 #include <plat/prcm.h>
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/p=
owerdomains.h
index 55cd8e6..f83adaf 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -10,8 +10,8 @@
  * published by the Free Software Foundation.
  */
=20
-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS_H
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS_H
=20
 #include <plat/powerdomain.h>
=20
@@ -24,4 +24,7 @@ extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 b=
ank);
 extern u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
 extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
=20
-#endif /* ARCH_ARM_MACH_OMAP2_POWERDOMAINS */
+extern struct powerdomain wkup_omap2_pwrdm;
+extern struct powerdomain gfx_omap2_pwrdm;
+
+#endif
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/ar=
m/mach-omap2/powerdomains2xxx_3xxx_data.c
new file mode 100644
index 0000000..14c6ef7
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -0,0 +1,81 @@
+/*
+ * OMAP2/3 common powerdomain definitions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H=C3=B6gander
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * To Do List
+ * -> Move the Sleep/Wakeup dependencies from Power Domain framework t=
o
+ *    Clock Domain Framework
+ */
+
+/*
+ * This file contains all of the powerdomains that have some element
+ * of software control for the OMAP24xx and OMAP34xx chips.
+ *
+ * This is not an exhaustive listing of powerdomains on the chips; onl=
y
+ * powerdomains that can be controlled in software.
+ */
+
+/*
+ * The names for the DSP/IVA2 powerdomains are confusing.
+ *
+ * Most OMAP chips have an on-board DSP.
+ *
+ * On the 2420, this is a 'C55 DSP called, simply, the DSP.  Its
+ * powerdomain is called the "DSP power domain."  On the 2430, the
+ * on-board DSP is a 'C64 DSP, now called (along with its hardware
+ * accelerators) the IVA2 or IVA2.1.  Its powerdomain is still called
+ * the "DSP power domain." On the 3430, the DSP is a 'C64 DSP like the
+ * 2430, also known as the IVA2; but its powerdomain is now called the
+ * "IVA2 power domain."
+ *
+ * The 2420 also has something called the IVA, which is a separate ARM
+ * core, and has nothing to do with the DSP/IVA2.
+ *
+ * Ideally the DSP/IVA2 could just be the same powerdomain, but the PR=
CM
+ * address offset is different between the C55 and C64 DSPs.
+ */
+
+#include <plat/powerdomain.h>
+
+#include "prcm-common.h"
+#include "prm.h"
+
+#include "powerdomains.h"
+
+/* OMAP2/3-common powerdomains */
+
+/*
+ * The GFX powerdomain is not present on 3430ES2, but currently we do =
not
+ * have a macro to filter it out at compile-time.
+ */
+struct powerdomain gfx_omap2_pwrdm =3D {
+	.name		  =3D "gfx_pwrdm",
+	.prcm_offs	  =3D GFX_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
+					   CHIP_IS_OMAP3430ES1),
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
+struct powerdomain wkup_omap2_pwrdm =3D {
+	.name		=3D "wkup_pwrdm",
+	.prcm_offs	=3D WKUP_MOD,
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+};
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h b/arch/ar=
m/mach-omap2/powerdomains2xxx_3xxx_data.h
new file mode 100644
index 0000000..45d684a
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
@@ -0,0 +1,22 @@
+/*
+ * OMAP2/3 common powerdomains - prototypes
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
+#define __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
+
+#include <plat/powerdomain.h>
+
+extern struct powerdomain gfx_omap2_pwrdm;
+extern struct powerdomain wkup_omap2_pwrdm;
+
+#endif
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-oma=
p2/powerdomains2xxx_data.c
similarity index 78%
rename from arch/arm/mach-omap2/powerdomains24xx.h
rename to arch/arm/mach-omap2/powerdomains2xxx_data.c
index 775093a..adc85d3 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -1,26 +1,22 @@
 /*
- * OMAP24XX powerdomain definitions
+ * OMAP2XXX powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
- * Debugging and integration fixes by Jouni H=C3=B6gander
+ * Paul Walmsley, Jouni H=C3=B6gander
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
=20
-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
-
-/*
- * N.B. If powerdomains are added or removed from this file, update
- * the array in mach-omap2/powerdomains.h.
- */
+#include <linux/kernel.h>
+#include <linux/init.h>
=20
 #include <plat/powerdomain.h>
+#include "powerdomains2xxx_3xxx_data.h"
+#include "powerdomains.h"
=20
 #include "prcm-common.h"
 #include "prm.h"
@@ -30,8 +26,6 @@
=20
 /* 24XX powerdomains and dependencies */
=20
-#ifdef CONFIG_ARCH_OMAP2
-
 /* Powerdomains */
=20
 static struct powerdomain dsp_pwrdm =3D {
@@ -82,9 +76,6 @@ static struct powerdomain core_24xx_pwrdm =3D {
 	},
 };
=20
-#endif	   /* CONFIG_ARCH_OMAP2 */
-
-
=20
 /*
  * 2430-specific powerdomains
@@ -111,5 +102,25 @@ static struct powerdomain mdm_pwrdm =3D {
=20
 #endif     /* CONFIG_ARCH_OMAP2430 */
=20
+/* As powerdomains are added or removed above, this list must also be =
changed */
+static struct powerdomain *powerdomains_omap2xxx[] __initdata =3D {
=20
+	&wkup_omap2_pwrdm,
+	&gfx_omap2_pwrdm,
+
+#ifdef CONFIG_ARCH_OMAP2
+	&dsp_pwrdm,
+	&mpu_24xx_pwrdm,
+	&core_24xx_pwrdm,
 #endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+	&mdm_pwrdm,
+#endif
+	NULL
+};
+
+void __init omap2xxx_powerdomains_init(void)
+{
+	pwrdm_init(powerdomains_omap2xxx, &omap2_pwrdm_operations);
+}
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-oma=
p2/powerdomains3xxx_data.c
similarity index 89%
rename from arch/arm/mach-omap2/powerdomains34xx.h
rename to arch/arm/mach-omap2/powerdomains3xxx_data.c
index fa90486..4335dbb 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -4,23 +4,19 @@
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  * Copyright (C) 2007-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
- * Debugging and integration fixes by Jouni H=C3=B6gander
+ * Paul Walmsley, Jouni H=C3=B6gander
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
=20
-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
-
-/*
- * N.B. If powerdomains are added or removed from this file, update
- * the array in mach-omap2/powerdomains.h.
- */
+#include <linux/kernel.h>
+#include <linux/init.h>
=20
 #include <plat/powerdomain.h>
+#include "powerdomains2xxx_3xxx_data.h"
+#include "powerdomains.h"
=20
 #include "prcm-common.h"
 #include "prm.h"
@@ -252,8 +248,33 @@ static struct powerdomain dpll5_pwrdm =3D {
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
=20
+/* As powerdomains are added or removed above, this list must also be =
changed */
+static struct powerdomain *powerdomains_omap3xxx[] __initdata =3D {
=20
-#endif    /* CONFIG_ARCH_OMAP3 */
+	&wkup_omap2_pwrdm,
+	&gfx_omap2_pwrdm,
+	&iva2_pwrdm,
+	&mpu_3xxx_pwrdm,
+	&neon_pwrdm,
+	&core_3xxx_pre_es3_1_pwrdm,
+	&core_3xxx_es3_1_pwrdm,
+	&cam_pwrdm,
+	&dss_pwrdm,
+	&per_pwrdm,
+	&emu_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
+	&dpll1_pwrdm,
+	&dpll2_pwrdm,
+	&dpll3_pwrdm,
+	&dpll4_pwrdm,
+	&dpll5_pwrdm,
+#endif
+	NULL
+};
=20
=20
-#endif
+void __init omap3xxx_powerdomains_init(void)
+{
+	pwrdm_init(powerdomains_omap3xxx, &omap3_pwrdm_operations);
+}
diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-oma=
p2/powerdomains44xx_data.c
similarity index 93%
rename from arch/arm/mach-omap2/powerdomains44xx.h
rename to arch/arm/mach-omap2/powerdomains44xx_data.c
index 9c01b55..2512f69 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -19,10 +19,11 @@
  * published by the Free Software Foundation.
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAINS44XX_H
-#define __ARCH_ARM_MACH_OMAP2_POWERDOMAINS44XX_H
+#include <linux/kernel.h>
+#include <linux/init.h>
=20
 #include <plat/powerdomain.h>
+#include "powerdomains.h"
=20
 #include "prcm-common.h"
 #include "cm.h"
@@ -30,8 +31,6 @@
 #include "prm.h"
 #include "prm-regbits-44xx.h"
=20
-#if defined(CONFIG_ARCH_OMAP4)
-
 /* core_44xx_pwrdm: CORE power domain */
 static struct powerdomain core_44xx_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
@@ -314,6 +313,28 @@ static struct powerdomain cefuse_44xx_pwrdm =3D {
  * stdefuse
  */
=20
-#endif
+/* As powerdomains are added or removed above, this list must also be =
changed */
+static struct powerdomain *powerdomains_omap44xx[] __initdata =3D {
+	&core_44xx_pwrdm,
+	&gfx_44xx_pwrdm,
+	&abe_44xx_pwrdm,
+	&dss_44xx_pwrdm,
+	&tesla_44xx_pwrdm,
+	&wkup_44xx_pwrdm,
+	&cpu0_44xx_pwrdm,
+	&cpu1_44xx_pwrdm,
+	&emu_44xx_pwrdm,
+	&mpu_44xx_pwrdm,
+	&ivahd_44xx_pwrdm,
+	&cam_44xx_pwrdm,
+	&l3init_44xx_pwrdm,
+	&l4per_44xx_pwrdm,
+	&always_on_core_44xx_pwrdm,
+	&cefuse_44xx_pwrdm,
+	NULL
+};
=20
-#endif
+void __init omap44xx_powerdomains_init(void)
+{
+	pwrdm_init(powerdomains_omap44xx, &omap4_pwrdm_operations);
+}
diff --git a/arch/arm/mach-omap2/powerdomains_data.c b/arch/arm/mach-om=
ap2/powerdomains_data.c
deleted file mode 100644
index 29690c6..0000000
--- a/arch/arm/mach-omap2/powerdomains_data.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- * OMAP2/3 common powerdomain definitions
- *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
- *
- * Written by Paul Walmsley
- * Debugging and integration fixes by Jouni H=C3=B6gander
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- * To Do List
- * -> Move the Sleep/Wakeup dependencies from Power Domain framework t=
o
- *    Clock Domain Framework
- */
-
-/*
- * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34xx chips.
- *
- * This is not an exhaustive listing of powerdomains on the chips; onl=
y
- * powerdomains that can be controlled in software.
- */
-
-/*
- * The names for the DSP/IVA2 powerdomains are confusing.
- *
- * Most OMAP chips have an on-board DSP.
- *
- * On the 2420, this is a 'C55 DSP called, simply, the DSP.  Its
- * powerdomain is called the "DSP power domain."  On the 2430, the
- * on-board DSP is a 'C64 DSP, now called (along with its hardware
- * accelerators) the IVA2 or IVA2.1.  Its powerdomain is still called
- * the "DSP power domain." On the 3430, the DSP is a 'C64 DSP like the
- * 2430, also known as the IVA2; but its powerdomain is now called the
- * "IVA2 power domain."
- *
- * The 2420 also has something called the IVA, which is a separate ARM
- * core, and has nothing to do with the DSP/IVA2.
- *
- * Ideally the DSP/IVA2 could just be the same powerdomain, but the PR=
CM
- * address offset is different between the C55 and C64 DSPs.
- */
-
-#include <linux/init.h>
-#include <plat/powerdomain.h>
-
-#include "prcm-common.h"
-#include "prm.h"
-#include "cm.h"
-#include "powerdomains24xx.h"
-#include "powerdomains34xx.h"
-#include "powerdomains44xx.h"
-#include "powerdomains.h"
-
-/* OMAP2/3-common powerdomains */
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
-/*
- * The GFX powerdomain is not present on 3430ES2, but currently we do =
not
- * have a macro to filter it out at compile-time.
- */
-static struct powerdomain gfx_omap2_pwrdm =3D {
-	.name		  =3D "gfx_pwrdm",
-	.prcm_offs	  =3D GFX_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					   CHIP_IS_OMAP3430ES1),
-	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
-	.banks		  =3D 1,
-	.pwrsts_mem_ret	  =3D {
-		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
-	},
-	.pwrsts_mem_on	  =3D {
-		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
-	},
-};
-
-static struct powerdomain wkup_omap2_pwrdm =3D {
-	.name		=3D "wkup_pwrdm",
-	.prcm_offs	=3D WKUP_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-};
-
-#endif
-
-
-/* As powerdomains are added or removed above, this list must also be =
changed */
-static struct powerdomain *powerdomains_omap[] __initdata =3D {
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	&wkup_omap2_pwrdm,
-	&gfx_omap2_pwrdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2
-	&dsp_pwrdm,
-	&mpu_24xx_pwrdm,
-	&core_24xx_pwrdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-	&mdm_pwrdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-	&iva2_pwrdm,
-	&mpu_3xxx_pwrdm,
-	&neon_pwrdm,
-	&core_3xxx_pre_es3_1_pwrdm,
-	&core_3xxx_es3_1_pwrdm,
-	&cam_pwrdm,
-	&dss_pwrdm,
-	&per_pwrdm,
-	&emu_pwrdm,
-	&sgx_pwrdm,
-	&usbhost_pwrdm,
-	&dpll1_pwrdm,
-	&dpll2_pwrdm,
-	&dpll3_pwrdm,
-	&dpll4_pwrdm,
-	&dpll5_pwrdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-	&core_44xx_pwrdm,
-	&gfx_44xx_pwrdm,
-	&abe_44xx_pwrdm,
-	&dss_44xx_pwrdm,
-	&tesla_44xx_pwrdm,
-	&wkup_44xx_pwrdm,
-	&cpu0_44xx_pwrdm,
-	&cpu1_44xx_pwrdm,
-	&emu_44xx_pwrdm,
-	&mpu_44xx_pwrdm,
-	&ivahd_44xx_pwrdm,
-	&cam_44xx_pwrdm,
-	&l3init_44xx_pwrdm,
-	&l4per_44xx_pwrdm,
-	&always_on_core_44xx_pwrdm,
-	&cefuse_44xx_pwrdm,
-#endif
-	NULL
-};
-
-void pwrdm_fw_init(void)
-{
-	if (cpu_is_omap24xx())
-		pwrdm_init(powerdomains_omap, &omap2_pwrdm_operations);
-	else if (cpu_is_omap34xx())
-		pwrdm_init(powerdomains_omap, &omap3_pwrdm_operations);
-	else if (cpu_is_omap44xx())
-		pwrdm_init(powerdomains_omap, &omap4_pwrdm_operations);
-}
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/p=
lat-omap/include/plat/powerdomain.h
index 583758c..b79eebb 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -2,17 +2,20 @@
  * OMAP2/3 powerdomain control
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX This should be moved to the mach-omap2/ directory at the earlie=
st
+ * opportunity.
  */
=20
-#ifndef ASM_ARM_ARCH_OMAP_POWERDOMAIN
-#define ASM_ARM_ARCH_OMAP_POWERDOMAIN
+#ifndef ASM_ARM_PLAT_OMAP_INCLUDE_PLAT_POWERDOMAIN
+#define ASM_ARM_PLAT_OMAP_INCLUDE_PLAT_POWERDOMAIN
=20
 #include <linux/types.h>
 #include <linux/list.h>
@@ -206,4 +209,8 @@ int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
=20
+extern void omap2xxx_powerdomains_init(void);
+extern void omap3xxx_powerdomains_init(void);
+extern void omap44xx_powerdomains_init(void);
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
