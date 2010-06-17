From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/12] OMAP2: OPP: update API to be device-based
Date: Wed, 16 Jun 2010 17:17:09 -0700
Message-ID: <1276733833-18510-9-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51676 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab0FQARj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:39 -0400
Received: by mail-pv0-f174.google.com with SMTP id 4so937484pva.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:35 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

The current OPP layer is based on a unique identifier (OPP_MPU,
OPP_DSP, OPP_L3) which is not terribly portable or scalable for future
devices.

Since we'd also like to be able to manage OPPs for any device, this
patch changes the OPP API to be device-based instead of unique-ID
based.  Essentially, this means passing a 'struct device' instead of a
unique ID to determine which set of OPPs to be used.

While making the API change, I also significantly changed the
internal management of OPPs to use a list per-device and within
each per-device struct, a list to manage OPPs.  This resulted in
basically a rewrite of the internals.

Another signifcant change is that I removed the opp_init_list()
function in favor of just using multiple calls to opp_add().  In
combination with the internal list-based implmentation, this permitted
the removal of the need for using termin

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c     |  180 ++++++----------
 arch/arm/plat-omap/include/plat/opp.h |   57 ++---
 arch/arm/plat-omap/opp.c              |  396 ++++++++++++++------------------
 3 files changed, 261 insertions(+), 372 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index b9d75cf..9d453b8 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -1,5 +1,4 @@
 /*
- * arch/arm/mach-omap2/cpufreq34xx.c
  * OMAP3 resource init/change_level/validate_level functions
  *
  * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
@@ -27,111 +26,80 @@
 #include <plat/cpu.h>
 #include "omap3-opp.h"
 
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
+static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
+	/* MPU OPP1 */
+	OMAP_OPP_DEF("mpu", true, 125000000, 975000),
+	/* MPU OPP2 */
+	OMAP_OPP_DEF("mpu", true, 250000000, 1075000),
+	/* MPU OPP3 */
+	OMAP_OPP_DEF("mpu", true, 500000000, 1200000),
+	/* MPU OPP4 */
+	OMAP_OPP_DEF("mpu", true, 550000000, 1270000),
+	/* MPU OPP5 */
+	OMAP_OPP_DEF("mpu", true, 600000000, 1350000),
 
-static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
 	/*
-	 * OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
+	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
 	 * almost the same than the one at 83MHz thus providing very little
 	 * gain for the power point of view. In term of energy it will even
 	 * increase the consumption due to the very negative performance
 	 * impact that frequency will do to the MPU and the whole system in
 	 * general.
 	 */
-	OMAP_OPP_DEF(false, 41500000, 975000),
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
+	OMAP_OPP_DEF("l3", false, 41500000, 975000),
+	/* L3 OPP2 */
+	OMAP_OPP_DEF("l3", true, 83000000, 1050000),
+	/* L3 OPP3 */
+	OMAP_OPP_DEF("l3", true, 166000000, 1150000),
+
+
+	/* DSP OPP1 */
+	OMAP_OPP_DEF("dsp", true, 90000000, 975000),
+	/* DSP OPP2 */
+	OMAP_OPP_DEF("dsp", true, 180000000, 1075000),
+	/* DSP OPP3 */
+	OMAP_OPP_DEF("dsp", true, 360000000, 1200000),
+	/* DSP OPP4 */
+	OMAP_OPP_DEF("dsp", true, 400000000, 1270000),
+	/* DSP OPP5 */
+	OMAP_OPP_DEF("dsp", true, 430000000, 1350000),
 };
-
-static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
-	/* OPP1 - OPP50 */
-	OMAP_OPP_DEF(true,  300000000, 930000),
-	/* OPP2 - OPP100 */
-	OMAP_OPP_DEF(true,  600000000, 1100000),
-	/* OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF(false, 800000000, 1260000),
-	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 1000000000, 1350000),
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
-	OMAP_OPP_DEF(false, 800000000, 1350000),
-	/* Terminator */
-	OMAP_OPP_DEF(0, 0, 0)
+static u32 omap34xx_opp_def_size = ARRAY_SIZE(omap34xx_opp_def_list);
+
+static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OMAP_OPP_DEF("mpu", true,  300000000, 930000),
+	/* MPU OPP2 - OPP100 */
+	OMAP_OPP_DEF("mpu", true,  600000000, 1100000),
+	/* MPU OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("mpu", false, 800000000, 1260000),
+	/* MPU OPP4 - OPP-SB */
+	OMAP_OPP_DEF("mpu", false, 1000000000, 1350000),
+
+	/* L3 OPP1 - OPP50 */
+	OMAP_OPP_DEF("l3", true, 100000000, 930000),
+	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OMAP_OPP_DEF("l3", true, 200000000, 1137500),
+
+	/* DSP OPP1 - OPP50 */
+	OMAP_OPP_DEF("dsp", true,  260000000, 930000),
+	/* DSP OPP2 - OPP100 */
+	OMAP_OPP_DEF("dsp", true,  520000000, 1100000),
+	/* DSP OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("dsp", false, 660000000, 1260000),
+	/* DSP OPP4 - OPP-SB */
+	OMAP_OPP_DEF("dsp", false, 800000000, 1350000),
 };
+static u32 omap36xx_opp_def_size = ARRAY_SIZE(omap36xx_opp_def_list);
 
 /* Temp variable to allow multiple calls */
 static u8 __initdata omap3_table_init;
 
 int __init omap3_pm_init_opp_table(void)
 {
+	struct omap_opp_def *opp_def, *omap3_opp_def_list;
+	u32 omap3_opp_def_size;
 	int i, r;
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
-	enum opp_t omap3_opps[] = {
-		OPP_MPU,
-		OPP_L3,
-		OPP_DSP
-	};
 
 	/*
 	 * Allow multiple calls, but initialize only if not already initalized
@@ -142,34 +110,18 @@ int __init omap3_pm_init_opp_table(void)
 	omap3_table_init = 1;
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
-				omap34xx_opp_def_list;
+		omap34xx_opp_def_list;
+	omap3_opp_def_size = cpu_is_omap3630() ? omap36xx_opp_def_size :
+		omap34xx_opp_def_size;
 
-	for (i = 0; i < ARRAY_SIZE(omap3_opps); i++) {
-		r = opp_init_list(omap3_opps[i], omap3_opp_def_list[i]);
+	opp_def = omap3_opp_def_list;
+	for (i = 0; i < omap3_opp_def_size; i++) {
+		r = opp_add(opp_def++);
 		if (r)
-			break;
-	}
-	if (!r)
-		return 0;
-
-	/* Cascading error handling - disable all enabled OPPs */
-	pr_err("%s: Failed to register %d OPP type\n", __func__,
-		omap3_opps[i]);
-	i--;
-	while (i != -1) {
-		struct omap_opp *opp;
-		unsigned long freq = 0;
-
-		do {
-			opp = opp_find_freq_ceil(omap3_opps[i], &freq);
-			if (IS_ERR(opp))
-				break;
-			opp_disable(opp);
-			freq++;
-		} while (1);
-		i--;
+			pr_err("unable to add OPP %ld Hz for %s\n",
+			       opp_def->freq, opp_def->hwmod_name);
 	}
 
-	return r;
+	return 0;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 9f569e3..29e3d03 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -17,16 +17,7 @@
 #include <linux/err.h>
 #include <linux/cpufreq.h>
 
-#ifdef CONFIG_ARCH_OMAP3
-enum opp_t {
-	OPP_MPU,
-	OPP_L3,
-	OPP_DSP,
-	OPP_TYPES_MAX
-};
-#else
-#error "You need to populate the OPP types for OMAP chip type."
-#endif
+#include <plat/common.h>
 
 /**
  * struct omap_opp_def - OMAP OPP Definition
@@ -46,9 +37,12 @@ enum opp_t {
  * of this - but this is handled by the appropriate driver.
  */
 struct omap_opp_def {
-	bool enabled;
+	char *hwmod_name;
+
 	unsigned long freq;
 	unsigned long u_volt;
+
+	bool enabled;
 };
 
 /*
@@ -56,8 +50,9 @@ struct omap_opp_def {
  * To point at the end of a terminator of a list of OPPs,
  * use OMAP_OPP_DEF(0, 0, 0)
  */
-#define OMAP_OPP_DEF(_enabled, _freq, _uv)	\
+#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv)	\
 {						\
+	.hwmod_name	= _hwmod_name,		\
 	.enabled	= _enabled,		\
 	.freq		= _freq,		\
 	.u_volt		= _uv,			\
@@ -71,30 +66,26 @@ unsigned long opp_get_voltage(const struct omap_opp *opp);
 
 unsigned long opp_get_freq(const struct omap_opp *opp);
 
-int opp_get_opp_count(enum opp_t opp_type);
+int opp_get_opp_count(struct device *dev);
 
-struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
+struct omap_opp *opp_find_freq_exact(struct device *dev,
 				     unsigned long freq, bool enabled);
 
-struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq);
-
-struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq);
+struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
 
+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
-int  __init opp_init_list(enum opp_t opp_type,
-			 const struct omap_opp_def *opp_defs);
-
-int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def);
+int opp_add(const struct omap_opp_def *opp_def);
 
 int opp_enable(struct omap_opp *opp);
 
 int opp_disable(struct omap_opp *opp);
 
-struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
+struct omap_opp *__deprecated opp_find_by_opp_id(struct device *dev,
 						  u8 opp_id);
 u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
-void opp_init_cpufreq_table(enum opp_t opp_type,
+void opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
 #else
 static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
@@ -113,31 +104,26 @@ static inline int opp_get_opp_count(struct omap_opp *oppl)
 }
 
 static inline struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
-				     unsigned long freq, bool enabled)
+						   unsigned long freq,
+						   bool enabled)
 {
 	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
-				     unsigned long *freq)
+						   unsigned long *freq)
 {
 	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
-					unsigned long *freq)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline
-struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
+						  unsigned long *freq)
 {
 	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_add(struct omap_opp *oppl,
-			 const struct omap_opp_def *opp_def)
+				       const struct omap_opp_def *opp_def)
 {
 	return ERR_PTR(-EINVAL);
 }
@@ -152,7 +138,7 @@ static inline int opp_disable(struct omap_opp *opp)
 	return 0;
 }
 
-static inline struct omap_opp * __deprecated
+static inline struct omap_opp *__deprecated
 opp_find_by_opp_id(struct omap_opp *opps, u8 opp_id)
 {
 	return ERR_PTR(-EINVAL);
@@ -163,7 +149,8 @@ static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 	return 0;
 }
 
-static inline void opp_init_cpufreq_table(struct omap_opp *opps,
+static inline
+void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table)
 {
 }
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 4833e2d..0273497 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -16,9 +16,12 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/list.h>
 
 #include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
+#include <plat/omap_device.h>
 
 /**
  * struct omap_opp - OMAP OPP description structure
@@ -30,17 +33,50 @@
  * This structure stores the OPP information for a given domain.
  */
 struct omap_opp {
+	struct list_head node;
+
 	bool enabled;
 	unsigned long rate;
 	unsigned long u_volt;
 	u8 opp_id;
+
+	struct device_opp *dev_opp;  /* containing device_opp struct */
 };
 
-/* This maintains pointers to the start of each OPP array. */
-static struct omap_opp *_opp_list[OPP_TYPES_MAX];
+struct device_opp {
+	struct list_head node;
+
+	struct omap_hwmod *oh;
+	struct device *dev;
+
+	struct list_head opp_list;
+	u32 opp_count;
+	u32 enabled_opp_count;
+};
+
+static LIST_HEAD(dev_opp_list);
+
+/**
+ * find_device_opp() - find device_opp struct using device pointer
+ * @dev: device pointer used to lookup device OPPs
+ *
+ * Search list of device OPPs for one containing matching device.
+ *
+ * Returns pointer to 'struct device_opp' if found, otherwise -ENODEV.
+ */
+static struct device_opp *find_device_opp(struct device *dev)
+{
+	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
+
+	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
+		if (tmp_dev_opp->dev == dev) {
+			dev_opp = tmp_dev_opp;
+			break;
+		}
+	}
 
-/* Detect end of opp array */
-#define OPP_TERM(opp) (!(opp)->rate && !(opp)->u_volt && !(opp)->enabled)
+	return dev_opp;
+}
 
 /**
  * opp_get_voltage() - Gets the voltage corresponding to an opp
@@ -55,6 +91,7 @@ unsigned long opp_get_voltage(const struct omap_opp *opp)
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return 0;
 	}
+
 	return opp->u_volt;
 }
 
@@ -71,6 +108,7 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return 0;
 	}
+
 	return opp->rate;
 }
 
@@ -82,27 +120,24 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
  * Returns the struct omap_opp pointer corresponding to the given OPP
  * ID @opp_id, or returns NULL on error.
  */
-struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
+struct omap_opp * __deprecated opp_find_by_opp_id(struct device *dev,
 						  u8 opp_id)
 {
-	struct omap_opp *opps;
-	int i = 0;
-
-	if (unlikely(opp_type >= OPP_TYPES_MAX || !opp_id))
-		return ERR_PTR(-EINVAL);
-	opps = _opp_list[opp_type];
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
 
-	if (!opps)
-		return ERR_PTR(-ENOENT);
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
 
-	while (!OPP_TERM(&opps[i])) {
-		if (opps[i].enabled && (opps[i].opp_id == opp_id))
-			return &opps[i];
-
-		i++;
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->opp_id == opp_id) {
+			opp = temp_opp;
+			break;
+		}
 	}
 
-	return ERR_PTR(-ENOENT);
+	return opp;
 }
 
 /**
@@ -117,6 +152,7 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 		pr_err("%s: Invalid parameter being passed\n", __func__);
 		return 0;
 	}
+
 	return opp->opp_id;
 }
 
@@ -127,26 +163,15 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
  * This functions returns the number of opps if there are any OPPs enabled,
  * else returns corresponding error value.
  */
-int opp_get_opp_count(enum opp_t opp_type)
+int opp_get_opp_count(struct device *dev)
 {
-	u8 n = 0;
-	struct omap_opp *oppl;
+	struct device_opp *dev_opp;
 
-	if (unlikely(opp_type >= OPP_TYPES_MAX)) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return -EINVAL;
-	}
-
-	oppl = _opp_list[opp_type];
-	if (!oppl)
-		return -ENOENT;
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return -ENODEV;
 
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled)
-			n++;
-		oppl++;
-	}
-	return n;
+	return dev_opp->enabled_opp_count;
 }
 
 /**
@@ -163,28 +188,24 @@ int opp_get_opp_count(enum opp_t opp_type)
  * for exact matching frequency and is enabled. if false, the match is for exact
  * frequency which is disabled.
  */
-struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
+struct omap_opp *opp_find_freq_exact(struct device *dev,
 				     unsigned long freq, bool enabled)
 {
-	struct omap_opp *oppl;
-
-	if (unlikely(opp_type >= OPP_TYPES_MAX)) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-
-	oppl = _opp_list[opp_type];
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
 
-	if (!oppl)
-		return ERR_PTR(-ENOENT);
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
 
-	while (!OPP_TERM(oppl)) {
-		if ((oppl->rate == freq) && (oppl->enabled == enabled))
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate == freq) {
+			opp = temp_opp;
 			break;
-		oppl++;
+		}
 	}
 
-	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
+	return opp;
 }
 
 /**
@@ -214,33 +235,24 @@ struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
  *		freq++; * for next higher match *
  *	}
  */
-struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq)
+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq)
 {
-	struct omap_opp *oppl;
-
-	if (unlikely(opp_type >= OPP_TYPES_MAX || !freq ||
-		 IS_ERR(freq))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
 
-	oppl = _opp_list[opp_type];
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
 
-	if (!oppl)
-		return ERR_PTR(-ENOENT);
-
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled && oppl->rate >= *freq)
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate >= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
 			break;
-		oppl++;
+		}
 	}
 
-	if (OPP_TERM(oppl))
-		return ERR_PTR(-ENOENT);
-
-	*freq = oppl->rate;
-
-	return oppl;
+	return opp;
 }
 
 /**
@@ -270,36 +282,24 @@ struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq)
  *		freq--; * for next lower match *
  *	}
  */
-struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq)
+struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
 {
-	struct omap_opp *prev_opp, *oppl;
-
-	if (unlikely(opp_type >= OPP_TYPES_MAX || !freq ||
-		 IS_ERR(freq))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-	oppl = _opp_list[opp_type];
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
 
-	if (!oppl)
-		return ERR_PTR(-ENOENT);
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
 
-	prev_opp = oppl;
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled) {
-			if (oppl->rate > *freq)
-				break;
-			prev_opp = oppl;
+	list_for_each_entry_reverse(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate <= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
+			break;
 		}
-		oppl++;
 	}
 
-	if (prev_opp->rate > *freq)
-		return ERR_PTR(-ENOENT);
-
-	*freq = prev_opp->rate;
-
-	return prev_opp;
+	return opp;
 }
 
 /* wrapper to reuse converting opp_def to opp struct */
@@ -313,130 +313,79 @@ static void omap_opp_populate(struct omap_opp *opp,
 
 /**
  * opp_add()  - Add an OPP table from a table definitions
- * @opp_type:	OPP type under which we want to add our new OPP.
- * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
+ * @opp_def:	omap_opp_def to describe the OPP which we want to add.
  *
  * This function adds an opp definition to the opp list and returns status.
  */
-int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
+int opp_add(const struct omap_opp_def *opp_def)
 {
-	struct omap_opp *opp, *oppt, *oppr, *oppl;
-	u8 n, i, ins;
-
-	if (unlikely(opp_type >= OPP_TYPES_MAX || !opp_def ||
-			 IS_ERR(opp_def))) {
-		pr_err("%s: Invalid params being passed\n", __func__);
+	struct omap_hwmod *oh;
+	struct device *dev = NULL;
+	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
+	struct omap_opp *opp, *new_opp;
+	struct platform_device *pdev;
+	struct list_head *head;
+	int i;
+
+	/* find the correct hwmod, and device */
+	if (!opp_def->hwmod_name) {
+		pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
 		return -EINVAL;
 	}
-
-	n = 0;
-	oppl = _opp_list[opp_type];
-
-	if (!oppl)
-		return -ENOENT;
-
-	opp = oppl;
-	while (!OPP_TERM(opp)) {
-		n++;
-		opp++;
-	}
-
-	/*
-	 * Allocate enough entries to copy the original list, plus the new
-	 * OPP, plus the concluding terminator
-	 */
-	oppr = kzalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
-	if (!oppr) {
-		pr_err("%s: No memory for new opp array\n", __func__);
-		return -ENOMEM;
+	oh = omap_hwmod_lookup(opp_def->hwmod_name);
+	if (!oh) {
+		pr_warn("%s: no hwmod for %s, cannot add OPPs.\n",
+			__func__, opp_def->hwmod_name);
+		return -EINVAL;
 	}
+	pdev = &oh->od->pdev;
+	dev = &oh->od->pdev.dev;
 
-	/* Simple insertion sort */
-	opp = _opp_list[opp_type];
-	oppt = oppr;
-	ins = 0;
-	i = 1;
-	do {
-		if (ins || opp->rate < opp_def->freq) {
-			memcpy(oppt, opp, sizeof(struct omap_opp));
-			opp++;
-		} else {
-			omap_opp_populate(oppt, opp_def);
-			ins++;
+	/* Check for existing list for 'dev' */
+	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
+		if (dev == tmp_dev_opp->dev) {
+			dev_opp = tmp_dev_opp;
+			break;
 		}
-		oppt->opp_id = i;
-		oppt++;
-		i++;
-	} while (!OPP_TERM(opp));
-
-	/* If nothing got inserted, this belongs to the end */
-	if (!ins) {
-		omap_opp_populate(oppt, opp_def);
-		oppt->opp_id = i;
-		oppt++;
 	}
 
-	_opp_list[opp_type] = oppr;
+	if (!dev_opp) {
+		/* Allocate a new device OPP table */
+		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
+		if (WARN_ON(!dev_opp))
+			return -ENOMEM;
 
-	/* Terminator implicitly added by kzalloc() */
-
-	/* Free the old list */
-	kfree(oppl);
-
-	return 0;
-}
-
-/**
- * opp_init_list() - Initialize an opp list from the opp definitions
- * @opp_type:	OPP type to initialize this list for.
- * @opp_defs:	Initial opp definitions to create the list.
- *
- * This function creates a list of opp definitions and returns status.
- * This list can be used to further validation/search/modifications. New
- * opp entries can be added to this list by using opp_add().
- *
- * In the case of error, suitable error code is returned.
- */
-int __init opp_init_list(enum opp_t opp_type,
-				 const struct omap_opp_def *opp_defs)
-{
-	struct omap_opp_def *t = (struct omap_opp_def *)opp_defs;
-	struct omap_opp *oppl;
-	u8 n = 0, i = 1;
+		dev_opp->oh = oh;
+		dev_opp->dev = &oh->od->pdev.dev;
+		INIT_LIST_HEAD(&dev_opp->opp_list);
 
-	if (unlikely(opp_type >= OPP_TYPES_MAX || !opp_defs ||
-			 IS_ERR(opp_defs))) {
-		pr_err("%s: Invalid params being passed\n", __func__);
-		return -EINVAL;
-	}
-	/* Grab a count */
-	while (t->enabled || t->freq || t->u_volt) {
-		n++;
-		t++;
+		list_add(&dev_opp->node, &dev_opp_list);
 	}
 
-	/*
-	 * Allocate enough entries to copy the original list, plus the
-	 * concluding terminator
-	 */
-	oppl = kzalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
-	if (!oppl) {
-		pr_err("%s: No memory for opp array\n", __func__);
+	/* allocate new OPP node */
+	new_opp = kzalloc(sizeof(struct omap_opp), GFP_KERNEL);
+	if (WARN_ON(!new_opp))
+		/* FIXME: free dev_opp ? */
 		return -ENOMEM;
-	}
-
+	omap_opp_populate(new_opp, opp_def);
 
-	_opp_list[opp_type] = oppl;
-	while (n) {
-		omap_opp_populate(oppl, opp_defs);
-		oppl->opp_id = i;
-		n--;
-		oppl++;
-		opp_defs++;
-		i++;
+	/* Insert new OPP in order of increasing frequency */
+	head = &dev_opp->opp_list;
+	list_for_each_entry_reverse(opp, &dev_opp->opp_list, node) {
+		if (new_opp->rate >= opp->rate) {
+			head = &opp->node;
+			break;
+		}
 	}
+	list_add(&new_opp->node, head);
+	dev_opp->opp_count++;
+	if (new_opp->enabled)
+		dev_opp->enabled_opp_count++;
 
-	/* Terminator implicitly added by kzalloc() */
+	/* renumber (deprecated) OPP IDs based on new order */
+	i = 0;
+	list_for_each_entry(opp, &dev_opp->opp_list, node)
+		opp->opp_id = i++;
 
 	return 0;
 }
@@ -453,11 +402,18 @@ int __init opp_init_list(enum opp_t opp_type,
  */
 int opp_enable(struct omap_opp *opp)
 {
+	struct device_opp *dev_opp;
+
 	if (unlikely(!opp || IS_ERR(opp))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return -EINVAL;
 	}
+
+	if (!opp->enabled && opp->dev_opp)
+		opp->dev_opp->enabled_opp_count++;
+
 	opp->enabled = true;
+
 	return 0;
 }
 
@@ -477,7 +433,12 @@ int opp_disable(struct omap_opp *opp)
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return -EINVAL;
 	}
+
+	if (opp->enabled && opp->dev_opp)
+		opp->dev_opp->enabled_opp_count--;
+
 	opp->enabled = false;
+
 	return 0;
 }
 
@@ -489,43 +450,32 @@ int opp_disable(struct omap_opp *opp)
  * Generate a cpufreq table for a provided domain - this assumes that the
  * opp list is already initialized and ready for usage
  */
-void opp_init_cpufreq_table(enum opp_t opp_type,
+void opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table)
 {
-	int i = 0, j;
-	int opp_num;
-	struct cpufreq_frequency_table *freq_table;
+	struct device_opp *dev_opp;
 	struct omap_opp *opp;
+	struct cpufreq_frequency_table *freq_table;
+	int i = 0;
 
-	if (opp_type >= OPP_TYPES_MAX) {
-		pr_warning("%s: failed to initialize frequency"
-				"table\n", __func__);
-		return;
-	}
-
-	opp_num = opp_get_opp_count(opp_type);
-	if (opp_num < 0) {
-		pr_err("%s: no opp table?\n", __func__);
+	dev_opp = find_device_opp(dev);
+	if (WARN_ON(!dev_opp))
 		return;
-	}
 
-	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
-			     (opp_num + 1), GFP_ATOMIC);
+	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
+			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
 	if (!freq_table) {
-		pr_warning("%s: failed to allocate frequency"
-				"table\n", __func__);
+		pr_warning("%s: failed to allocate frequency table\n",
+			   __func__);
 		return;
 	}
 
-	opp = _opp_list[opp_type];
-	opp += opp_num;
-	for (j = opp_num; j >= 0; j--) {
+	list_for_each_entry(opp, &dev_opp->opp_list, node) {
 		if (opp->enabled) {
 			freq_table[i].index = i;
 			freq_table[i].frequency = opp->rate / 1000;
 			i++;
 		}
-		opp--;
 	}
 
 	freq_table[i].index = i;
-- 
1.7.0.2

