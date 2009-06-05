From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP: omap_hwmod: call omap_hwmod initialization at boot
Date: Fri, 05 Jun 2009 04:19:45 -0600
Message-ID: <20090605101943.32500.64082.stgit@localhost.localdomain>
References: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47682 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZFEKUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:33 -0400
In-Reply-To: <20090605101635.32500.63083.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Connect the omap_hwmod code to the kernel boot.  Create some basic
interconnect and device structures for OMAP2/3 chips.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c              |   17 +++
 arch/arm/mach-omap2/omap_hwmod_2420.h |  140 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430.h |  142 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_34xx.h |  167 +++++++++++++++++++++++++++++++++
 4 files changed, 465 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2420.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2430.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index deb309a..8f19623 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,12 +34,16 @@
 #include "clock.h"
 
 #include <mach/powerdomain.h>
-
 #include "powerdomains.h"
 
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
 
+#include <mach/omap_hwmod.h>
+#include "omap_hwmod_2420.h"
+#include "omap_hwmod_2430.h"
+#include "omap_hwmod_34xx.h"
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -198,11 +202,22 @@ void __init omap2_map_common_io(void)
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 {
+	struct omap_hwmod **hwmods = NULL;
+
+	if (cpu_is_omap2420())
+		hwmods = omap2420_hwmods;
+	else if (cpu_is_omap2430())
+		hwmods = omap2430_hwmods;
+	else if (cpu_is_omap34xx())
+		hwmods = omap34xx_hwmods;
+
+	omap_hwmod_init(hwmods);
 	omap2_mux_init();
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 	omap_serial_early_init();
+	omap_hwmod_late_init();
 	omap2_sdrc_init(sp);
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420.h b/arch/arm/mach-omap2/omap_hwmod_2420.h
new file mode 100644
index 0000000..8b93c74
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2420.h
@@ -0,0 +1,140 @@
+/*
+ * omap_hwmod_2420.h - hardware modules present on the OMAP2420 chips
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX handle crossbar/shared link difference for L3?
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2420_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2420_H
+
+#ifdef CONFIG_ARCH_OMAP2420
+
+#include <mach/omap_hwmod.h>
+#include <mach/irqs.h>
+#include <mach/cpu.h>
+#include <mach/dma.h>
+
+#include "prm-regbits-24xx.h"
+
+static struct omap_hwmod omap2420_mpu_hwmod;
+static struct omap_hwmod omap2420_l3_hwmod;
+static struct omap_hwmod omap2420_l4_core_hwmod;
+
+/* L3 -> L4_CORE interface */
+static struct omap_hwmod_ocp_if omap2420_l3__l4_core = {
+	.master	= &omap2420_l3_hwmod,
+	.slave	= &omap2420_l4_core_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* MPU -> L3 interface */
+static struct omap_hwmod_ocp_if omap2420_mpu__l3 = {
+	.master = &omap2420_mpu_hwmod,
+	.slave	= &omap2420_l3_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l3_slaves[] = {
+	&omap2420_mpu__l3,
+};
+
+/* Master interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
+	&omap2420_l3__l4_core,
+};
+
+/* L3 */
+static struct omap_hwmod omap2420_l3_hwmod = {
+	.name		= "l3_hwmod",
+	.masters	= omap2420_l3_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
+	.slaves		= omap2420_l3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+static struct omap_hwmod omap2420_l4_wkup_hwmod;
+
+/* L4_CORE -> L4_WKUP interface */
+static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
+	.master	= &omap2420_l4_core_hwmod,
+	.slave	= &omap2420_l4_wkup_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Slave interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
+	&omap2420_l3__l4_core,
+};
+
+/* Master interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
+	&omap2420_l4_core__l4_wkup,
+};
+
+/* L4 CORE */
+static struct omap_hwmod omap2420_l4_core_hwmod = {
+	.name		= "l4_core_hwmod",
+	.masters	= omap2420_l4_core_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
+	.slaves		= omap2420_l4_core_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_core_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l4_wkup_slaves[] = {
+	&omap2420_l4_core__l4_wkup,
+};
+
+/* Master interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap2420_l4_wkup_masters[] = {
+};
+
+/* L4 WKUP */
+static struct omap_hwmod omap2420_l4_wkup_hwmod = {
+	.name		= "l4_wkup_hwmod",
+	.masters	= omap2420_l4_wkup_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
+	.slaves		= omap2420_l4_wkup_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_wkup_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* Master interfaces on the MPU device */
+static struct omap_hwmod_ocp_if *omap2420_mpu_masters[] = {
+	&omap2420_mpu__l3,
+};
+
+/* MPU */
+static struct omap_hwmod omap2420_mpu_hwmod = {
+	.name		= "mpu_hwmod",
+	.main_clk	= { .name = "mpu_ck" },
+	.masters	= omap2420_mpu_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_mpu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+static __initdata struct omap_hwmod *omap2420_hwmods[] = {
+	&omap2420_l3_hwmod,
+	&omap2420_l4_core_hwmod,
+	&omap2420_l4_wkup_hwmod,
+	&omap2420_mpu_hwmod,
+	NULL,
+};
+
+#else
+# define omap2420_hwmods		0
+#endif
+
+#endif
+
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
new file mode 100644
index 0000000..24e3521
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -0,0 +1,142 @@
+/*
+ * omap_hwmod_2430.h - hardware modules present on the OMAP2430 chips
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX handle crossbar/shared link difference for L3?
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2430_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD2430_H
+
+#ifdef CONFIG_ARCH_OMAP2430
+
+#include <mach/omap_hwmod.h>
+#include <mach/irqs.h>
+#include <mach/cpu.h>
+#include <mach/dma.h>
+
+#include "prm-regbits-24xx.h"
+
+static struct omap_hwmod omap2430_mpu_hwmod;
+static struct omap_hwmod omap2430_l3_hwmod;
+static struct omap_hwmod omap2430_l4_core_hwmod;
+
+/* L3 -> L4_CORE interface */
+static struct omap_hwmod_ocp_if omap2430_l3__l4_core = {
+	.master	= &omap2430_l3_hwmod,
+	.slave	= &omap2430_l4_core_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* MPU -> L3 interface */
+static struct omap_hwmod_ocp_if omap2430_mpu__l3 = {
+	.master = &omap2430_mpu_hwmod,
+	.slave	= &omap2430_l3_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l3_slaves[] = {
+	&omap2430_mpu__l3,
+};
+
+/* Master interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
+	&omap2430_l3__l4_core,
+};
+
+/* L3 */
+static struct omap_hwmod omap2430_l3_hwmod = {
+	.name		= "l3_hwmod",
+	.masters	= omap2430_l3_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
+	.slaves		= omap2430_l3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+static struct omap_hwmod omap2430_l4_wkup_hwmod;
+static struct omap_hwmod omap2430_mmc1_hwmod;
+static struct omap_hwmod omap2430_mmc2_hwmod;
+
+/* L4_CORE -> L4_WKUP interface */
+static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
+	.master	= &omap2430_l4_core_hwmod,
+	.slave	= &omap2430_l4_wkup_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Slave interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
+	&omap2430_l3__l4_core,
+};
+
+/* Master interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
+	&omap2430_l4_core__l4_wkup,
+};
+
+/* L4 CORE */
+static struct omap_hwmod omap2430_l4_core_hwmod = {
+	.name		= "l4_core_hwmod",
+	.masters	= omap2430_l4_core_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
+	.slaves		= omap2430_l4_core_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_core_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
+	&omap2430_l4_core__l4_wkup,
+};
+
+/* Master interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
+};
+
+/* L4 WKUP */
+static struct omap_hwmod omap2430_l4_wkup_hwmod = {
+	.name		= "l4_wkup_hwmod",
+	.masters	= omap2430_l4_wkup_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
+	.slaves		= omap2430_l4_wkup_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_wkup_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* Master interfaces on the MPU device */
+static struct omap_hwmod_ocp_if *omap2430_mpu_masters[] = {
+	&omap2430_mpu__l3,
+};
+
+/* MPU */
+static struct omap_hwmod omap2430_mpu_hwmod = {
+	.name		= "mpu_hwmod",
+	.main_clk	= { .name = "mpu_ck" },
+	.masters	= omap2430_mpu_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_mpu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+static __initdata struct omap_hwmod *omap2430_hwmods[] = {
+	&omap2430_l3_hwmod,
+	&omap2430_l4_core_hwmod,
+	&omap2430_l4_wkup_hwmod,
+	&omap2430_mpu_hwmod,
+	NULL,
+};
+
+#else
+# define omap2430_hwmods		0
+#endif
+
+#endif
+
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
new file mode 100644
index 0000000..f936e11
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -0,0 +1,167 @@
+/*
+ * omap_hwmod_34xx.h - hardware modules present on the OMAP34xx chips
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
+
+#ifdef CONFIG_ARCH_OMAP34XX
+
+#include <mach/omap_hwmod.h>
+#include <mach/irqs.h>
+#include <mach/cpu.h>
+#include <mach/dma.h>
+
+#include "prm-regbits-34xx.h"
+
+static struct omap_hwmod omap34xx_mpu_hwmod;
+static struct omap_hwmod omap34xx_l3_hwmod;
+static struct omap_hwmod omap34xx_l4_core_hwmod;
+static struct omap_hwmod omap34xx_l4_per_hwmod;
+
+/* L3 -> L4_CORE interface */
+static struct omap_hwmod_ocp_if omap34xx_l3__l4_core = {
+	.master	= &omap34xx_l3_hwmod,
+	.slave	= &omap34xx_l4_core_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L3 -> L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l3__l4_per = {
+	.master = &omap34xx_l3_hwmod,
+	.slave	= &omap34xx_l4_per_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* MPU -> L3 interface */
+static struct omap_hwmod_ocp_if omap34xx_mpu__l3 = {
+	.master = &omap34xx_mpu_hwmod,
+	.slave	= &omap34xx_l3_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l3_slaves[] = {
+	&omap34xx_mpu__l3,
+};
+
+/* Master interfaces on the L3 interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l3_masters[] = {
+	&omap34xx_l3__l4_core,
+	&omap34xx_l3__l4_per,
+};
+
+/* L3 */
+static struct omap_hwmod omap34xx_l3_hwmod = {
+	.name		= "l3_hwmod",
+	.masters	= omap34xx_l3_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_l3_masters),
+	.slaves		= omap34xx_l3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_l3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+static struct omap_hwmod omap34xx_l4_wkup_hwmod;
+
+/* L4_CORE -> L4_WKUP interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
+	.master	= &omap34xx_l4_core_hwmod,
+	.slave	= &omap34xx_l4_wkup_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Slave interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_core_slaves[] = {
+	&omap34xx_l3__l4_core,
+};
+
+/* Master interfaces on the L4_CORE interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_core_masters[] = {
+	&omap34xx_l4_core__l4_wkup,
+};
+
+/* L4 CORE */
+static struct omap_hwmod omap34xx_l4_core_hwmod = {
+	.name		= "l4_core_hwmod",
+	.masters	= omap34xx_l4_core_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_l4_core_masters),
+	.slaves		= omap34xx_l4_core_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_l4_core_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Slave interfaces on the L4_PER interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_per_slaves[] = {
+	&omap34xx_l3__l4_per,
+};
+
+/* Master interfaces on the L4_PER interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_per_masters[] = {
+};
+
+/* L4 PER */
+static struct omap_hwmod omap34xx_l4_per_hwmod = {
+	.name		= "l4_per_hwmod",
+	.masters	= omap34xx_l4_per_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_l4_per_masters),
+	.slaves		= omap34xx_l4_per_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_l4_per_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_slaves[] = {
+	&omap34xx_l4_core__l4_wkup,
+};
+
+/* Master interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_masters[] = {
+};
+
+/* L4 WKUP */
+static struct omap_hwmod omap34xx_l4_wkup_hwmod = {
+	.name		= "l4_wkup_hwmod",
+	.masters	= omap34xx_l4_wkup_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_l4_wkup_masters),
+	.slaves		= omap34xx_l4_wkup_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_l4_wkup_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* Master interfaces on the MPU device */
+static struct omap_hwmod_ocp_if *omap34xx_mpu_masters[] = {
+	&omap34xx_mpu__l3,
+};
+
+/* MPU */
+static struct omap_hwmod omap34xx_mpu_hwmod = {
+	.name		= "mpu_hwmod",
+	.main_clk	= { .name = "arm_fck" },
+	.masters	= omap34xx_mpu_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_mpu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
+	&omap34xx_l3_hwmod,
+	&omap34xx_l4_core_hwmod,
+	&omap34xx_l4_per_hwmod,
+	&omap34xx_l4_wkup_hwmod,
+	&omap34xx_mpu_hwmod,
+	NULL,
+};
+
+#else
+# define omap34xx_hwmods		0
+#endif
+
+#endif
+
+


