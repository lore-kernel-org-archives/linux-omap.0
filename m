From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 10/11] OMAP: omap_hwmod: call omap_hwmod init at boot;
	create interconnects
Date: Tue, 18 Aug 2009 14:56:31 +0300
Message-ID: <20090818115630.14171.18958.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51920 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797AbZHRL6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 07:58:53 -0400
In-Reply-To: <20090818115147.14171.55785.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Connect the omap_hwmod code to the kernel boot.  Create some basic
interconnect and device structures for OMAP2/3 chips.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c              |   17 +++
 arch/arm/mach-omap2/omap_hwmod.c      |    3 -
 arch/arm/mach-omap2/omap_hwmod_2420.h |  141 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430.h |  143 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_34xx.h |  168 +++++++++++++++++++++++++++++++++
 5 files changed, 469 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2420.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2430.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 470b1d1..7574b6f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -39,12 +39,16 @@
 
 #include <mach/omap-pm.h>
 #include <mach/powerdomain.h>
-
 #include "powerdomains.h"
 
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
 #endif
+#include <mach/omap_hwmod.h>
+#include "omap_hwmod_2420.h"
+#include "omap_hwmod_2430.h"
+#include "omap_hwmod_34xx.h"
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -281,6 +285,16 @@ static int __init _omap2_init_reprogram_sdrc(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
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
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
@@ -289,6 +303,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 	omap_serial_early_init();
+	omap_hwmod_late_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 	_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d1ef3ef..2324e0c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -765,8 +765,7 @@ static int _reset(struct omap_hwmod *oh)
 		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
 		     oh->name, MAX_MODULE_RESET_WAIT);
 	else
-		pr_debug("omap_hwmod: %s: reset in %d usec\n", oh->name,
-			 MAX_MODULE_RESET_WAIT);
+		pr_debug("omap_hwmod: %s: reset in %d usec\n", oh->name, c);
 
 	/*
 	 * XXX add _HWMOD_STATE_WEDGED for modules that don't come back from
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420.h b/arch/arm/mach-omap2/omap_hwmod_2420.h
new file mode 100644
index 0000000..767e496
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2420.h
@@ -0,0 +1,141 @@
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
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "mpu_ck",
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
index 0000000..a412be6
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -0,0 +1,143 @@
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
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "mpu_ck",
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
index 0000000..1e069f8
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -0,0 +1,168 @@
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
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "arm_fck",
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


