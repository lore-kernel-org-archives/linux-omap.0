From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 1/1] OMAP3: PM: Fix compilation issue of omap opp layer functions
Date: Tue, 19 Jan 2010 15:58:06 +0200
Message-ID: <1263909486-30967-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39242 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0ASN6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:58:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch removes the compilation error when compiling
kernel with CONFIG_PM=N. The problem was that omap3_pm_init_opp_table
was not defined if CONFIG_PM=N.

Besides, OMAP OPP layer functions now have dependencies of CONFIG_PM
and CONFIG_CPU_FREQ.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/pm.h              |    6 ++
 arch/arm/mach-omap2/pm34xx.c          |    4 +
 arch/arm/plat-omap/Makefile           |    4 +
 arch/arm/plat-omap/include/plat/opp.h |  143 +++++++++++++++++++++++++--------
 4 files changed, 122 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d257225..6c67d7f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
  * Initialize the basic opp table here, board files could choose to modify opp
  * table after the basic initialization
  */
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_FREQ)
 extern void omap3_pm_init_opp_table(void);
+#else
+static inline void omap3_pm_init_opp_table(void)
+{
+}
+#endif
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8d91549..1862027 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -113,6 +113,7 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
+#ifdef CONFIG_CPU_FREQ
 static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
 	/* OPP1 */
 	OMAP_OPP_DEF(true, 125000000, 975000),
@@ -188,6 +189,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	/* Terminator */
 	OMAP_OPP_DEF(0, 0, 0)
 };
+#endif
 
 static inline void omap3_per_save_context(void)
 {
@@ -1351,6 +1353,7 @@ static void __init configure_vc(void)
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
+#ifdef CONFIG_CPU_FREQ
 void __init omap3_pm_init_opp_table(void)
 {
 	int i;
@@ -1379,6 +1382,7 @@ void __init omap3_pm_init_opp_table(void)
 		BUG_ON(IS_ERR(omap3_rate_tables[i]));
 	}
 }
+#endif
 
 static int __init omap3_pm_early_init(void)
 {
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index b0c5b31..cc414de 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,7 +15,11 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # OPP support in (OMAP3+ only at the moment)
 # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
 # PMIC is selected.
+ifdef CONFIG_PM
+ifdef CONFIG_CPU_FREQ
 obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
+endif
+endif
 
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 9f91ad3..b8d2593 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -17,6 +17,43 @@ extern struct omap_opp *mpu_opps;
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
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_FREQ)
 struct omap_opp;
 
 /**
@@ -134,41 +171,6 @@ struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq);
 
 
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
@@ -230,6 +232,77 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
 void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table);
+#else
+static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
+{
+	return 0;
+}
 
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
+
+static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
+{
+	return 0;
+}
+
+static inline void opp_init_cpufreq_table(struct omap_opp *opps,
+			    struct cpufreq_frequency_table **table)
+{
+}
 
+#endif
 #endif		/* __ASM_ARM_OMAP_OPP_H */
-- 
1.6.5.7.g9ecb2

