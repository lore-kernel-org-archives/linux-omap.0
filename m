From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/11] OMAP hwmod: convert header files with static
	allocations into C files
Date: Mon, 22 Feb 2010 21:50:48 -0700
Message-ID: <20100223045045.18888.36620.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60255 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0BWE5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:39 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Code should be able to #include any header file without the fear that
the header file will go allocating memory.  This is a coding style
issue, similar to commit 82e9bd588563c4e22ebb55b684ebec7e310cc715.
Move the existing hwmod data from .h files to .c files.

While here, convert "omap34xx" to "omap3xxx" in the hwmod files, since
most of these structures should be reusable across all OMAP3 chips.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile                 |    5 +
 arch/arm/mach-omap2/io.c                     |   21 +--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   29 ++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   29 ++--
 arch/arm/mach-omap2/omap_hwmod_34xx.h        |  167 ------------------=
-------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  174 ++++++++++++++++++=
++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +
 7 files changed, 226 insertions(+), 207 deletions(-)
 rename arch/arm/mach-omap2/{omap_hwmod_2420.h =3D> omap_hwmod_2420_dat=
a.c} (86%)
 rename arch/arm/mach-omap2/{omap_hwmod_2430.h =3D> omap_hwmod_2430_dat=
a.c} (86%)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 679df5d..4aa621d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -66,6 +66,11 @@ obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clock-common) clock=
44xx_data.o \
 obj-$(CONFIG_ARCH_OMAP2420)		+=3D opp2420_data.o
 obj-$(CONFIG_ARCH_OMAP2430)		+=3D opp2430_data.o
=20
+# hwmod data
+obj-$(CONFIG_ARCH_OMAP2420)		+=3D omap_hwmod_2420_data.o
+obj-$(CONFIG_ARCH_OMAP2430)		+=3D omap_hwmod_2430_data.o
+obj-$(CONFIG_ARCH_OMAP34XX)		+=3D omap_hwmod_3xxx_data.o
+
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+=3D emu.o
=20
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1b951af..c3223b6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -46,9 +46,6 @@
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
 #include <plat/omap_hwmod.h>
-#include "omap_hwmod_2420.h"
-#include "omap_hwmod_2430.h"
-#include "omap_hwmod_34xx.h"
=20
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -305,21 +302,17 @@ static int __init _omap2_init_reprogram_sdrc(void=
)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
-	struct omap_hwmod **hwmods =3D NULL;
-
-	if (cpu_is_omap2420())
-		hwmods =3D omap2420_hwmods;
-	else if (cpu_is_omap2430())
-		hwmods =3D omap2430_hwmods;
-	else if (cpu_is_omap34xx())
-		hwmods =3D omap34xx_hwmods;
-
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is rea=
dy */
-	/* The OPP tables have to be registered before a clk init */
-	omap_hwmod_init(hwmods);
+	if (cpu_is_omap242x())
+		omap2420_hwmod_init();
+	else if (cpu_is_omap243x())
+		omap2430_hwmod_init();
+	else if (cpu_is_omap34xx())
+		omap3xxx_hwmod_init();
 	omap2_mux_init();
+	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 #endif
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420.h b/arch/arm/mach-omap=
2/omap_hwmod_2420_data.c
similarity index 86%
rename from arch/arm/mach-omap2/omap_hwmod_2420.h
rename to arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 5932c1d..a1c5839 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1,7 +1,7 @@
 /*
- * omap_hwmod_2420.h - hardware modules present on the OMAP2420 chips
+ * omap_hwmod_2420_data.c - hardware modules present on the OMAP2420 c=
hips
  *
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Nokia Corporation
  * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modif=
y
@@ -9,13 +9,8 @@
  * published by the Free Software Foundation.
  *
  * XXX handle crossbar/shared link difference for L3?
- *
+ * XXX these should be marked initdata for multi-OMAP kernels
  */
-#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2420_H
-#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2420_H
-
-#ifdef CONFIG_ARCH_OMAP2420
-
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 #include <plat/cpu.h>
@@ -23,6 +18,15 @@
=20
 #include "prm-regbits-24xx.h"
=20
+/*
+ * OMAP2420 hardware module integration data
+ *
+ * ALl of the data in this section should be autogeneratable from the
+ * TI hardware database or other technical documentation.  Data that
+ * is driver-specific or driver-kernel integration-specific belongs
+ * elsewhere.
+ */
+
 static struct omap_hwmod omap2420_mpu_hwmod;
 static struct omap_hwmod omap2420_l3_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
@@ -131,10 +135,9 @@ static __initdata struct omap_hwmod *omap2420_hwmo=
ds[] =3D {
 	NULL,
 };
=20
-#else
-# define omap2420_hwmods		0
-#endif
-
-#endif
+int __init omap2420_hwmod_init(void)
+{
+	return omap_hwmod_init(omap2420_hwmods);
+}
=20
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap=
2/omap_hwmod_2430_data.c
similarity index 86%
rename from arch/arm/mach-omap2/omap_hwmod_2430.h
rename to arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 91f79c0..ed2de79 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1,7 +1,7 @@
 /*
- * omap_hwmod_2430.h - hardware modules present on the OMAP2430 chips
+ * omap_hwmod_2430_data.c - hardware modules present on the OMAP2430 c=
hips
  *
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Nokia Corporation
  * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modif=
y
@@ -9,13 +9,8 @@
  * published by the Free Software Foundation.
  *
  * XXX handle crossbar/shared link difference for L3?
- *
+ * XXX these should be marked initdata for multi-OMAP kernels
  */
-#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2430_H
-#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2430_H
-
-#ifdef CONFIG_ARCH_OMAP2430
-
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 #include <plat/cpu.h>
@@ -23,6 +18,15 @@
=20
 #include "prm-regbits-24xx.h"
=20
+/*
+ * OMAP2430 hardware module integration data
+ *
+ * ALl of the data in this section should be autogeneratable from the
+ * TI hardware database or other technical documentation.  Data that
+ * is driver-specific or driver-kernel integration-specific belongs
+ * elsewhere.
+ */
+
 static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_l3_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
@@ -133,10 +137,9 @@ static __initdata struct omap_hwmod *omap2430_hwmo=
ds[] =3D {
 	NULL,
 };
=20
-#else
-# define omap2430_hwmods		0
-#endif
-
-#endif
+int __init omap2430_hwmod_init(void)
+{
+	return omap_hwmod_init(omap2430_hwmods);
+}
=20
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap=
2/omap_hwmod_34xx.h
deleted file mode 100644
index 4aea5b9..0000000
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * omap_hwmod_34xx.h - hardware modules present on the OMAP34xx chips
- *
- * Copyright (C) 2009 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
-#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
-
-#ifdef CONFIG_ARCH_OMAP34XX
-
-#include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
-#include <plat/cpu.h>
-#include <plat/dma.h>
-
-#include "prm-regbits-34xx.h"
-
-static struct omap_hwmod omap34xx_mpu_hwmod;
-static struct omap_hwmod omap34xx_l3_hwmod;
-static struct omap_hwmod omap34xx_l4_core_hwmod;
-static struct omap_hwmod omap34xx_l4_per_hwmod;
-
-/* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap34xx_l3__l4_core =3D {
-	.master	=3D &omap34xx_l3_hwmod,
-	.slave	=3D &omap34xx_l4_core_hwmod,
-	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L3 -> L4_PER interface */
-static struct omap_hwmod_ocp_if omap34xx_l3__l4_per =3D {
-	.master =3D &omap34xx_l3_hwmod,
-	.slave	=3D &omap34xx_l4_per_hwmod,
-	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap34xx_mpu__l3 =3D {
-	.master =3D &omap34xx_mpu_hwmod,
-	.slave	=3D &omap34xx_l3_hwmod,
-	.user	=3D OCP_USER_MPU,
-};
-
-/* Slave interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l3_slaves[] =3D {
-	&omap34xx_mpu__l3,
-};
-
-/* Master interfaces on the L3 interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l3_masters[] =3D {
-	&omap34xx_l3__l4_core,
-	&omap34xx_l3__l4_per,
-};
-
-/* L3 */
-static struct omap_hwmod omap34xx_l3_hwmod =3D {
-	.name		=3D "l3_hwmod",
-	.masters	=3D omap34xx_l3_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap34xx_l3_masters),
-	.slaves		=3D omap34xx_l3_slaves,
-	.slaves_cnt	=3D ARRAY_SIZE(omap34xx_l3_slaves),
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-};
-
-static struct omap_hwmod omap34xx_l4_wkup_hwmod;
-
-/* L4_CORE -> L4_WKUP interface */
-static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup =3D {
-	.master	=3D &omap34xx_l4_core_hwmod,
-	.slave	=3D &omap34xx_l4_wkup_hwmod,
-	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* Slave interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_core_slaves[] =3D {
-	&omap34xx_l3__l4_core,
-};
-
-/* Master interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_core_masters[] =3D {
-	&omap34xx_l4_core__l4_wkup,
-};
-
-/* L4 CORE */
-static struct omap_hwmod omap34xx_l4_core_hwmod =3D {
-	.name		=3D "l4_core_hwmod",
-	.masters	=3D omap34xx_l4_core_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap34xx_l4_core_masters),
-	.slaves		=3D omap34xx_l4_core_slaves,
-	.slaves_cnt	=3D ARRAY_SIZE(omap34xx_l4_core_slaves),
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-};
-
-/* Slave interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_per_slaves[] =3D {
-	&omap34xx_l3__l4_per,
-};
-
-/* Master interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_per_masters[] =3D {
-};
-
-/* L4 PER */
-static struct omap_hwmod omap34xx_l4_per_hwmod =3D {
-	.name		=3D "l4_per_hwmod",
-	.masters	=3D omap34xx_l4_per_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap34xx_l4_per_masters),
-	.slaves		=3D omap34xx_l4_per_slaves,
-	.slaves_cnt	=3D ARRAY_SIZE(omap34xx_l4_per_slaves),
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-};
-
-/* Slave interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_slaves[] =3D {
-	&omap34xx_l4_core__l4_wkup,
-};
-
-/* Master interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_masters[] =3D {
-};
-
-/* L4 WKUP */
-static struct omap_hwmod omap34xx_l4_wkup_hwmod =3D {
-	.name		=3D "l4_wkup_hwmod",
-	.masters	=3D omap34xx_l4_wkup_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap34xx_l4_wkup_masters),
-	.slaves		=3D omap34xx_l4_wkup_slaves,
-	.slaves_cnt	=3D ARRAY_SIZE(omap34xx_l4_wkup_slaves),
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-};
-
-/* Master interfaces on the MPU device */
-static struct omap_hwmod_ocp_if *omap34xx_mpu_masters[] =3D {
-	&omap34xx_mpu__l3,
-};
-
-/* MPU */
-static struct omap_hwmod omap34xx_mpu_hwmod =3D {
-	.name		=3D "mpu_hwmod",
-	.main_clk	=3D "arm_fck",
-	.masters	=3D omap34xx_mpu_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap34xx_mpu_masters),
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static __initdata struct omap_hwmod *omap34xx_hwmods[] =3D {
-	&omap34xx_l3_hwmod,
-	&omap34xx_l4_core_hwmod,
-	&omap34xx_l4_per_hwmod,
-	&omap34xx_l4_wkup_hwmod,
-	&omap34xx_mpu_hwmod,
-	NULL,
-};
-
-#else
-# define omap34xx_hwmods		0
-#endif
-
-#endif
-
-
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
new file mode 100644
index 0000000..8d4b686
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -0,0 +1,174 @@
+/*
+ * omap_hwmod_3xxx_data.c - hardware modules present on the OMAP3xxx c=
hips
+ *
+ * Copyright (C) 2009-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The data in this file should be completely autogeneratable from
+ * the TI hardware database or other technical documentation.
+ *
+ * XXX these should be marked initdata for multi-OMAP kernels
+ */
+#include <plat/omap_hwmod.h>
+#include <mach/irqs.h>
+#include <plat/cpu.h>
+#include <plat/dma.h>
+
+#include "prm-regbits-34xx.h"
+
+/*
+ * OMAP3xxx hardware module integration data
+ *
+ * ALl of the data in this section should be autogeneratable from the
+ * TI hardware database or other technical documentation.  Data that
+ * is driver-specific or driver-kernel integration-specific belongs
+ * elsewhere.
+ */
+
+static struct omap_hwmod omap3xxx_mpu_hwmod;
+static struct omap_hwmod omap3xxx_l3_hwmod;
+static struct omap_hwmod omap3xxx_l4_core_hwmod;
+static struct omap_hwmod omap3xxx_l4_per_hwmod;
+
+/* L3 -> L4_CORE interface */
+static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core =3D {
+	.master	=3D &omap3xxx_l3_hwmod,
+	.slave	=3D &omap3xxx_l4_core_hwmod,
+	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L3 -> L4_PER interface */
+static struct omap_hwmod_ocp_if omap3xxx_l3__l4_per =3D {
+	.master =3D &omap3xxx_l3_hwmod,
+	.slave	=3D &omap3xxx_l4_per_hwmod,
+	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* MPU -> L3 interface */
+static struct omap_hwmod_ocp_if omap3xxx_mpu__l3 =3D {
+	.master =3D &omap3xxx_mpu_hwmod,
+	.slave	=3D &omap3xxx_l3_hwmod,
+	.user	=3D OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l3_slaves[] =3D {
+	&omap3xxx_mpu__l3,
+};
+
+/* Master interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] =3D {
+	&omap3xxx_l3__l4_core,
+	&omap3xxx_l3__l4_per,
+};
+
+/* L3 */
+static struct omap_hwmod omap3xxx_l3_hwmod =3D {
+	.name		=3D "l3_hwmod",
+	.masters	=3D omap3xxx_l3_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l3_masters),
+	.slaves		=3D omap3xxx_l3_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l3_slaves),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+
+/* L4_CORE -> L4_WKUP interface */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup =3D {
+	.master	=3D &omap3xxx_l4_core_hwmod,
+	.slave	=3D &omap3xxx_l4_wkup_hwmod,
+	.user	=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Slave interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] =3D {
+	&omap3xxx_l3__l4_core,
+};
+
+/* Master interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] =3D {
+	&omap3xxx_l4_core__l4_wkup,
+};
+
+/* L4 CORE */
+static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
+	.name		=3D "l4_core_hwmod",
+	.masters	=3D omap3xxx_l4_core_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_core_masters),
+	.slaves		=3D omap3xxx_l4_core_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_core_slaves),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Slave interfaces on the L4_PER interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] =3D {
+	&omap3xxx_l3__l4_per,
+};
+
+/* Master interfaces on the L4_PER interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] =3D {
+};
+
+/* L4 PER */
+static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
+	.name		=3D "l4_per_hwmod",
+	.masters	=3D omap3xxx_l4_per_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_per_masters),
+	.slaves		=3D omap3xxx_l4_per_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_per_slaves),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] =3D {
+	&omap3xxx_l4_core__l4_wkup,
+};
+
+/* Master interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] =3D {
+};
+
+/* L4 WKUP */
+static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
+	.name		=3D "l4_wkup_hwmod",
+	.masters	=3D omap3xxx_l4_wkup_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
+	.slaves		=3D omap3xxx_l4_wkup_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Master interfaces on the MPU device */
+static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] =3D {
+	&omap3xxx_mpu__l3,
+};
+
+/* MPU */
+static struct omap_hwmod omap3xxx_mpu_hwmod =3D {
+	.name		=3D "mpu_hwmod",
+	.main_clk	=3D "arm_fck",
+	.masters	=3D omap3xxx_mpu_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_mpu_masters),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
+	&omap3xxx_l3_hwmod,
+	&omap3xxx_l4_core_hwmod,
+	&omap3xxx_l4_per_hwmod,
+	&omap3xxx_l4_wkup_hwmod,
+	&omap3xxx_mpu_hwmod,
+	NULL,
+};
+
+int __init omap3xxx_hwmod_init(void)
+{
+	return omap_hwmod_init(omap3xxx_hwmods);
+}
+
+
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index de4d042..d2241fc 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -504,4 +504,12 @@ int omap_hwmod_set_clockact_none(struct omap_hwmod=
 *oh);
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
=20
+/*
+ * Chip variant-specific hwmod init routines - XXX should be converted
+ * to use initcalls once the initial boot ordering is straightened out
+ */
+extern int omap2420_hwmod_init(void);
+extern int omap2430_hwmod_init(void);
+extern int omap3xxx_hwmod_init(void);
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
