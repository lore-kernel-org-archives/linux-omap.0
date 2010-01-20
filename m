From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 12:39:23 +0200
Message-ID: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23714 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0ATKlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 05:41:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Romit Dasgupta <romit@ti.com>, "\\\"Keski-Saari Juha.1 (EXT-Teleca/Helsinki)\\\"" <ext-juha.1.keski-saari@nokia.com>, Cousson Benoit <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.

With this patch, omap opp layer now has its compilation flags
bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.

A new file has been created to contain cpu freq code related to
OMAP3: cpufreq34xx.c.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/Makefile          |    5 +
 arch/arm/mach-omap2/cpufreq34xx.c     |  133 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap3-opp.h       |   13 +++
 arch/arm/mach-omap2/pm.h              |    6 --
 arch/arm/mach-omap2/pm34xx.c          |  105 ------------------------
 arch/arm/plat-omap/Makefile           |    2 +
 arch/arm/plat-omap/include/plat/opp.h |  145 +++++++++++++++++++++++++--------
 7 files changed, 263 insertions(+), 146 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpufreq34xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ca93f1..22f2afd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -42,6 +42,11 @@ obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)		+= smartreflex.o
 endif
 
+# CPU Frequency
+ifeq ($(CONFIG_CPU_FREQ),y)
+obj-$(CONFIG_ARCH_OMAP3)		+= cpufreq34xx.o
+endif
+
 # PRCM
 obj-$(CONFIG_ARCH_OMAP2)		+= cm.o
 obj-$(CONFIG_ARCH_OMAP3)		+= cm.o
diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
new file mode 100644
index 0000000..07873e8
--- /dev/null
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -0,0 +1,133 @@
+/*
+ * arch/arm/mach-omap2/cpufreq34xx.c
+ * OMAP3 resource init/change_level/validate_level functions
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
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ * History:
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+
+#include <plat/opp.h>
+#include <plat/cpu.h>
+
+static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
+	/* OPP1 */
+	OMAP_OPP_DEF(true, 125000000, 975000),
+	/* OPP2 */
+	OMAP_OPP_DEF(true, 250000000, 1075000),
+	/* OPP3 */
+	OMAP_OPP_DEF(true, 500000000, 1200000),
+	/* OPP4 */
+	OMAP_OPP_DEF(true, 550000000, 1270000),
+	/* OPP5 */
+	OMAP_OPP_DEF(true, 600000000, 1350000),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
+	/* OPP1 */
+	OMAP_OPP_DEF(false, 0, 975000),
+	/* OPP2 */
+	OMAP_OPP_DEF(true, 83000000, 1050000),
+	/* OPP3 */
+	OMAP_OPP_DEF(true, 166000000, 1150000),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
+	/* OPP1 */
+	OMAP_OPP_DEF(true, 90000000, 975000),
+	/* OPP2 */
+	OMAP_OPP_DEF(true, 180000000, 1075000),
+	/* OPP3 */
+	OMAP_OPP_DEF(true, 360000000, 1200000),
+	/* OPP4 */
+	OMAP_OPP_DEF(true, 400000000, 1270000),
+	/* OPP5 */
+	OMAP_OPP_DEF(true, 430000000, 1350000),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
+	/* OPP1 - OPP50 */
+	OMAP_OPP_DEF(true,  300000000, 930000),
+	/* OPP2 - OPP100 */
+	OMAP_OPP_DEF(true,  600000000, 1100000),
+	/* OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF(false, 800000000, 1260000),
+	/* OPP4 - OPP-SB */
+	OMAP_OPP_DEF(false, 1000000000, 1310000),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
+	/* OPP1 - OPP50 */
+	OMAP_OPP_DEF(true, 100000000, 930000),
+	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OMAP_OPP_DEF(true, 200000000, 1137500),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
+	/* OPP1 - OPP50 */
+	OMAP_OPP_DEF(true,  260000000, 930000),
+	/* OPP2 - OPP100 */
+	OMAP_OPP_DEF(true,  520000000, 1100000),
+	/* OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF(false, 660000000, 1260000),
+	/* OPP4 - OPP-SB */
+	OMAP_OPP_DEF(false, 875000000, 1310000),
+	/* Terminator */
+	OMAP_OPP_DEF(0, 0, 0)
+};
+
+void __init omap3_pm_init_opp_table(void)
+{
+	int i;
+	struct omap_opp_def **omap3_opp_def_list;
+	struct omap_opp_def *omap34xx_opp_def_list[] = {
+		omap34xx_mpu_rate_table,
+		omap34xx_l3_rate_table,
+		omap34xx_dsp_rate_table
+	};
+	struct omap_opp_def *omap36xx_opp_def_list[] = {
+		omap36xx_mpu_rate_table,
+		omap36xx_l3_rate_table,
+		omap36xx_dsp_rate_table
+	};
+	struct omap_opp **omap3_rate_tables[] = {
+		&mpu_opps,
+		&l3_opps,
+		&dsp_opps
+	};
+
+	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
+				omap34xx_opp_def_list;
+	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
+		*omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
+		/* We dont want half configured system at the moment */
+		BUG_ON(IS_ERR(omap3_rate_tables[i]));
+	}
+}
+
diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index b47bb44..1ba85fc 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -3,4 +3,17 @@
 
 #include <plat/omap-pm.h>
 
+/**
+ * omap3_pm_init_opp_table - OMAP opp table lookup called after cpu is detected.
+ * Initialize the basic opp table here, board files could choose to modify opp
+ * table after the basic initialization
+ */
+#ifdef CONFIG_CPU_FREQ
+extern void omap3_pm_init_opp_table(void);
+#else
+static inline void omap3_pm_init_opp_table(void)
+{
+}
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d257225..75aa685 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -64,12 +64,6 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 {
 }
 #endif
-/**
- * omap3_pm_init_opp_table - OMAP opp table lookup called after cpu is detected.
- * Initialize the basic opp table here, board files could choose to modify opp
- * table after the basic initialization
- */
-extern void omap3_pm_init_opp_table(void);
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8d91549..6fb075f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -40,7 +40,6 @@
 #include <plat/dmtimer.h>
 #include <plat/usb.h>
 
-#include <plat/opp.h>
 #include <plat/resource.h>
 
 #include <asm/tlbflush.h>
@@ -113,82 +112,6 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
-static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
-	/* OPP1 */
-	OMAP_OPP_DEF(true, 125000000, 975000),
-	/* OPP2 */
-	OMAP_OPP_DEF(true, 250000000, 1075000),
-	/* OPP3 */
-	OMAP_OPP_DEF(true, 500000000, 1200000),
-	/* OPP4 */
-	OMAP_OPP_DEF(true, 550000000, 1270000),
-	/* OPP5 */
-	OMAP_OPP_DEF(true, 600000000, 1350000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
-static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
-	/* OPP1 */
-	OMAP_OPP_DEF(false, 0, 975000),
-	/* OPP2 */
-	OMAP_OPP_DEF(true, 83000000, 1050000),
-	/* OPP3 */
-	OMAP_OPP_DEF(true, 166000000, 1150000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
-static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
-	/* OPP1 */
-	OMAP_OPP_DEF(true, 90000000, 975000),
-	/* OPP2 */
-	OMAP_OPP_DEF(true, 180000000, 1075000),
-	/* OPP3 */
-	OMAP_OPP_DEF(true, 360000000, 1200000),
-	/* OPP4 */
-	OMAP_OPP_DEF(true, 400000000, 1270000),
-	/* OPP5 */
-	OMAP_OPP_DEF(true, 430000000, 1350000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
-static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
-	/* OPP1 - OPP50 */
-	OMAP_OPP_DEF(true,  300000000, 930000),
-	/* OPP2 - OPP100 */
-	OMAP_OPP_DEF(true,  600000000, 1100000),
-	/* OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF(false, 800000000, 1260000),
-	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 1000000000, 1310000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
-static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
-	/* OPP1 - OPP50 */
-	OMAP_OPP_DEF(true, 100000000, 930000),
-	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OMAP_OPP_DEF(true, 200000000, 1137500),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
-static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
-	/* OPP1 - OPP50 */
-	OMAP_OPP_DEF(true,  260000000, 930000),
-	/* OPP2 - OPP100 */
-	OMAP_OPP_DEF(true,  520000000, 1100000),
-	/* OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF(false, 660000000, 1260000),
-	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 875000000, 1310000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
-};
-
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1351,34 +1274,6 @@ static void __init configure_vc(void)
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
-void __init omap3_pm_init_opp_table(void)
-{
-	int i;
-	struct omap_opp_def **omap3_opp_def_list;
-	struct omap_opp_def *omap34xx_opp_def_list[] = {
-		omap34xx_mpu_rate_table,
-		omap34xx_l3_rate_table,
-		omap34xx_dsp_rate_table
-	};
-	struct omap_opp_def *omap36xx_opp_def_list[] = {
-		omap36xx_mpu_rate_table,
-		omap36xx_l3_rate_table,
-		omap36xx_dsp_rate_table
-	};
-	struct omap_opp **omap3_rate_tables[] = {
-		&mpu_opps,
-		&l3_opps,
-		&dsp_opps
-	};
-
-	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
-				omap34xx_opp_def_list;
-	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
-		*omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
-		/* We dont want half configured system at the moment */
-		BUG_ON(IS_ERR(omap3_rate_tables[i]));
-	}
-}
 
 static int __init omap3_pm_early_init(void)
 {
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index b0c5b31..2b9ebf0 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,7 +15,9 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # OPP support in (OMAP3+ only at the moment)
 # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
 # PMIC is selected.
+ifdef CONFIG_CPU_FREQ
 obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
+endif
 
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 9f91ad3..d69d61f 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -13,10 +13,49 @@
 #ifndef __ASM_ARM_OMAP_OPP_H
 #define __ASM_ARM_OMAP_OPP_H
 
+#include <linux/cpufreq.h>
+
 extern struct omap_opp *mpu_opps;
 extern struct omap_opp *dsp_opps;
 extern struct omap_opp *l3_opps;
 
+
+/**
+ * struct omap_opp_def - OMAP OPP Definition
+ * @enabled:	True/false - is this OPP enabled/disabled by default
+ * @freq:	Frequency in hertz corresponding to this OPP
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
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
+	bool enabled;
+	unsigned long freq;
+	unsigned long u_volt;
+};
+
+/*
+ * Initialization wrapper used to define an OPP
+ * to point at the end of a terminator of a list of OPPs,
+ * use OMAP_OPP_DEF(0, 0, 0)
+ */
+#define OMAP_OPP_DEF(_enabled, _freq, _uv)	\
+{						\
+	.enabled	= _enabled,		\
+	.freq		= _freq,		\
+	.u_volt		= _uv,			\
+}
+
+#ifdef CONFIG_CPU_FREQ
 struct omap_opp;
 
 /**
@@ -134,41 +173,6 @@ struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq);
 
 
 /**
- * struct omap_opp_def - OMAP OPP Definition
- * @enabled:	True/false - is this OPP enabled/disabled by default
- * @freq:	Frequency in hertz corresponding to this OPP
- * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
- *
- * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
- * pairs that the device will support per voltage domain. This is called
- * Operating Points or OPP. The actual definitions of OMAP Operating Points
- * varies over silicon within the same family of devices. For a specific
- * domain, you can have a set of {frequency, voltage} pairs and this is denoted
- * by an array of omap_opp_def. As the kernel boots and more information is
- * available, a set of these are activated based on the precise nature of
- * device the kernel boots up on. It is interesting to remember that each IP
- * which belongs to a voltage domain may define their own set of OPPs on top
- * of this - but this is handled by the appropriate driver.
- */
-struct omap_opp_def {
-	bool enabled;
-	unsigned long freq;
-	unsigned long u_volt;
-};
-
-/*
- * Initialization wrapper used to define an OPP
- * to point at the end of a terminator of a list of OPPs,
- * use OMAP_OPP_DEF(0, 0, 0)
- */
-#define OMAP_OPP_DEF(_enabled, _freq, _uv)	\
-{						\
-	.enabled	= _enabled,		\
-	.freq		= _freq,		\
-	.u_volt		= _uv,			\
-}
-
-/**
  * opp_init_list() - Initialize an opp list from the opp definitions
  * @opp_defs:	Initial opp definitions to create the list.
  *
@@ -230,6 +234,77 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
 void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table);
+#else
+static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline unsigned long opp_get_freq(const struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline int opp_get_opp_count(struct omap_opp *oppl)
+{
+	return 0;
+}
+
+static inline struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+				     unsigned long freq, bool enabled)
+{
+	return NULL;
+}
+
+static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
+				     unsigned long *freq)
+{
+	return NULL;
+}
+
+static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
+					unsigned long *freq)
+{
+	return NULL;
+}
+
+static inline
+struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
+{
+	return NULL;
+}
+
+static inline struct omap_opp *opp_add(struct omap_opp *oppl,
+			 const struct omap_opp_def *opp_def)
+{
+	return NULL;
+}
+
+static inline int opp_enable(struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline int opp_disable(struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline struct omap_opp * __deprecated
+opp_find_by_opp_id(struct omap_opp *opps, u8 opp_id)
+{
+	return NULL;
+}
 
+static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline void opp_init_cpufreq_table(struct omap_opp *opps,
+			    struct cpufreq_frequency_table **table)
+{
+}
 
+#endif		/* CONFIG_CPU_FREQ */
 #endif		/* __ASM_ARM_OMAP_OPP_H */
-- 
1.6.5.7.g9ecb2

