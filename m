From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common init
Date: Mon, 15 Nov 2010 13:27:39 -0600
Message-ID: <1289849261-29767-2-git-send-email-nm@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab0KOT1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 14:27:44 -0500
In-Reply-To: <[PATCH 0/3 v2] omap: opp: Add opp data>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>

Add OPP data for OMAP34xx and OMAP36xx and initialization functions
to populate OPP tables based on current SoC.
introduce an OMAP generic opp initialization routine which OMAP3
and OMAP4+ SoCs can use to register their OPP definitions.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Warning: http://lkml.org/lkml/2010/11/9/389
Introduces ARCH_HAS_OPP which needs to be enabled as well
for OMAP3 in the Kconfig
v3:
	* added documentation for custom opp modification
	  by board files
	* switched to using device_initcall to autoinitialize the
	  opp tables
v2: https://patchwork.kernel.org/patch/266911/

 Documentation/arm/OMAP/omap_pm     |   26 ++++++
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/opp.c          |  154 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.h |   82 +++++++++++++++++++
 arch/arm/mach-omap2/pm.h           |    9 ++
 6 files changed, 274 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.h

diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
index 5389440..88341f0 100644
--- a/Documentation/arm/OMAP/omap_pm
+++ b/Documentation/arm/OMAP/omap_pm
@@ -127,3 +127,29 @@ implementation needs:
 10. (*pdata->cpu_set_freq)(unsigned long f)
 
 11. (*pdata->cpu_get_freq)(void)
+
+Customizing OPP for platform
+============================
+Defining CONFIG_PM should enable OPP layer for the silicon
+and the registration of OPP table should take place automatically.
+However, in special cases, the default OPP table may need to be
+tweaked, for e.g.:
+ * enable default OPPs which are disabled by default, but which
+   could be enabled on a platform
+ * Disable an unsupported OPP on the platform
+ * Define and add a custom opp table entry
+in these cases, the board file needs to do additional steps as follows:
+arch/arm/mach-omapx/board-xyz.c
+	#include "pm.h"
+	....
+	static void __init omap_xyz_init_irq(void)
+	{
+		....
+		/* Initialize the default table */
+		omapx_opp_init();
+		/* Do customization to the defaults */
+		....
+	}
+NOTE: omapx_opp_init will be omap3_opp_init or as required
+based on the omap family.
+
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ab784bf..93a91ff 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,6 +35,7 @@ config ARCH_OMAP3
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
+ 	select PM_OPP if PM
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..1650a62 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -64,6 +64,8 @@ endif
 
 endif
 
+obj-$(CONFIG_PM_OPP)		+= opp.o
+
 # PRCM
 obj-$(CONFIG_ARCH_OMAP2)		+= cm.o
 obj-$(CONFIG_ARCH_OMAP3)		+= cm.o
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
new file mode 100644
index 0000000..79c711c
--- /dev/null
+++ b/arch/arm/mach-omap2/opp.c
@@ -0,0 +1,154 @@
+/*
+ *  OMAP SoC specific OPP wrapper function
+ *
+ * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
+ *	Kevin Hilman
+ * Copyright (C) 2010 Nokia Corporation.
+ *      Eduardo Valentin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/opp.h>
+
+#include <plat/cpu.h>
+#include <plat/omap_device.h>
+
+#include "pm.h"
+
+/**
+ * struct omap_opp_def - OMAP OPP Definition
+ * @hwmod_name:	Name of the hwmod for this domain
+ * @freq:	Frequency in hertz corresponding to this OPP
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @enabled:	True/false - is this OPP enabled/disabled by default
+ *
+ * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
+ * pairs that the device will support per voltage domain. This is called
+ * Operating Points or OPP. The actual definitions of OMAP Operating Points
+ * varies over silicon within the same family of devices. For a specific
+ * domain, you can have a set of {frequency, voltage} pairs and this is denoted
+ * by an array of omap_opp_def. As the kernel boots and more information is
+ * available, a set of these are activated based on the precise nature of
+ * device the kernel boots up on. It is interesting to remember that each IP
+ * which belongs to a voltage domain may define their own set of OPPs on top
+ * of this - but this is handled by the appropriate driver.
+ */
+struct omap_opp_def {
+	char *hwmod_name;
+
+	unsigned long freq;
+	unsigned long u_volt;
+
+	bool default_available;
+};
+
+/*
+ * Initialization wrapper used to define an OPP for OMAP variants.
+ */
+#define OPP_INITIALIZER(_hwmod_name, _enabled, _freq, _uv)	\
+{								\
+	.hwmod_name	= _hwmod_name,				\
+	.default_available	= _enabled,			\
+	.freq		= _freq,				\
+	.u_volt		= _uv,					\
+}
+
+/* Temp variable to allow multiple calls */
+static u8 __initdata omap_table_init;
+
+/**
+ * omap_init_opp_table() - Initialize opp table as per the CPU type
+ * @opp_def:		opp default list for this silicon
+ * @opp_def_size:	number of opp entries for this silicon
+ *
+ * Register the initial OPP table with the OPP library based on the CPU
+ * type.
+ */
+static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
+		u32 opp_def_size)
+{
+	int i, r;
+
+	if (!opp_def || !opp_def_size) {
+		pr_err("%s: invalid params!\n", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allow multiple calls, but initialize only if not already initalized
+	 * even if the previous call failed, coz, no reason we'd succeed again
+	 */
+	if (omap_table_init)
+		return 0;
+	omap_table_init = 1;
+
+	/* Lets now register with OPP library */
+	for (i = 0; i < opp_def_size; i++) {
+		struct omap_hwmod *oh;
+		struct device *dev;
+
+		if (!opp_def->hwmod_name) {
+			pr_err("%s: NULL name of omap_hwmod, failing [%d].\n",
+				__func__, i);
+			return -EINVAL;
+		}
+		oh = omap_hwmod_lookup(opp_def->hwmod_name);
+		if (!oh || !oh->od) {
+			pr_warn("%s: no hwmod or odev for %s, [%d] "
+				"cannot add OPPs.\n", __func__,
+				opp_def->hwmod_name, i);
+			return -EINVAL;
+		}
+		dev = &oh->od->pdev.dev;
+
+		r = opp_add(dev, opp_def->freq, opp_def->u_volt);
+		if (r) {
+			dev_err(dev, "%s: add OPP %ld failed for %s [%d] "
+				"result=%d\n",
+			       __func__, opp_def->freq,
+			       opp_def->hwmod_name, i, r);
+		} else {
+			if (!opp_def->default_available)
+				r = opp_disable(dev, opp_def->freq);
+			if (r)
+				dev_err(dev, "%s: disable %ld failed for %s "
+					"[%d] result=%d\n",
+					__func__, opp_def->freq,
+					opp_def->hwmod_name, i, r);
+		}
+		opp_def++;
+	}
+
+	return 0;
+}
+
+/* omap3 opps */
+#include "opp3xxx_data.h"
+/**
+ * omap3_opp_init() - initialize omap3 opp table
+ */
+int __init omap3_opp_init(void)
+{
+	int r = -ENODEV;
+
+	if (!cpu_is_omap34xx())
+		return r;
+
+	if (cpu_is_omap3630())
+		r = omap_init_opp_table(omap36xx_opp_def_list,
+			ARRAY_SIZE(omap36xx_opp_def_list));
+	else
+		r = omap_init_opp_table(omap34xx_opp_def_list,
+			ARRAY_SIZE(omap34xx_opp_def_list));
+
+	return r;
+}
+device_initcall(omap3_opp_init);
+
diff --git a/arch/arm/mach-omap2/opp3xxx_data.h b/arch/arm/mach-omap2/opp3xxx_data.h
new file mode 100644
index 0000000..2ce36a2
--- /dev/null
+++ b/arch/arm/mach-omap2/opp3xxx_data.h
@@ -0,0 +1,82 @@
+/*
+ * OMAP3 OPP table definitions.
+ *
+ * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *	Kevin Hilman
+ * Copyright (C) 2010 Nokia Corporation.
+ *      Eduardo Valentin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_PLAT_OPP_OMAP3XXX_H__
+#define __ASM_PLAT_OPP_OMAP3XXX_H__
+
+static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
+	/* MPU OPP1 */
+	OPP_INITIALIZER("mpu", true, 125000000, 975000),
+	/* MPU OPP2 */
+	OPP_INITIALIZER("mpu", true, 250000000, 1075000),
+	/* MPU OPP3 */
+	OPP_INITIALIZER("mpu", true, 500000000, 1200000),
+	/* MPU OPP4 */
+	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
+	/* MPU OPP5 */
+	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
+
+	/*
+	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
+	 * almost the same than the one at 83MHz thus providing very little
+	 * gain for the power point of view. In term of energy it will even
+	 * increase the consumption due to the very negative performance
+	 * impact that frequency will do to the MPU and the whole system in
+	 * general.
+	 */
+	OPP_INITIALIZER("l3_main", false, 41500000, 975000),
+	/* L3 OPP2 */
+	OPP_INITIALIZER("l3_main", true, 83000000, 1050000),
+	/* L3 OPP3 */
+	OPP_INITIALIZER("l3_main", true, 166000000, 1150000),
+
+
+	/* DSP OPP1 */
+	OPP_INITIALIZER("iva", true, 90000000, 975000),
+	/* DSP OPP2 */
+	OPP_INITIALIZER("iva", true, 180000000, 1075000),
+	/* DSP OPP3 */
+	OPP_INITIALIZER("iva", true, 360000000, 1200000),
+	/* DSP OPP4 */
+	OPP_INITIALIZER("iva", true, 400000000, 1270000),
+	/* DSP OPP5 */
+	OPP_INITIALIZER("iva", true, 430000000, 1350000),
+};
+
+static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OPP_INITIALIZER("mpu", true,  300000000, 1012500),
+	/* MPU OPP2 - OPP100 */
+	OPP_INITIALIZER("mpu", true,  600000000, 1200000),
+	/* MPU OPP3 - OPP-Turbo */
+	OPP_INITIALIZER("mpu", false, 800000000, 1325000),
+	/* MPU OPP4 - OPP-SB */
+	OPP_INITIALIZER("mpu", false, 1000000000, 1375000),
+
+	/* L3 OPP1 - OPP50 */
+	OPP_INITIALIZER("l3_main", true, 100000000, 1000000),
+	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OPP_INITIALIZER("l3_main", true, 200000000, 1200000),
+
+	/* DSP OPP1 - OPP50 */
+	OPP_INITIALIZER("iva", true,  260000000, 1012500),
+	/* DSP OPP2 - OPP100 */
+	OPP_INITIALIZER("iva", true,  520000000, 1200000),
+	/* DSP OPP3 - OPP-Turbo */
+	OPP_INITIALIZER("iva", false, 660000000, 1325000),
+	/* DSP OPP4 - OPP-SB */
+	OPP_INITIALIZER("iva", false, 800000000, 1375000),
+};
+
+#endif		/* __ASM_PLAT_OPP_OMAP3XXX_H__ */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..2031f15 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -20,6 +20,15 @@ extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
+#if defined(CONFIG_PM_OPP)
+extern int omap3_opp_init(void);
+#else
+static inline int omap3_opp_init(void)
+{
+	return -EINVAL;
+}
+#endif
+
 struct cpuidle_params {
 	u8  valid;
 	u32 sleep_latency;
-- 
1.6.3.3

