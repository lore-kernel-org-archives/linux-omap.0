From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 2/10] OPP layer and additional cleanups.
Date: Thu, 31 Dec 2009 18:59:09 +0530
Message-ID: <1262266149.20175.178.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbZLaN3R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Moving to list based OPP layer and its new semantics.


diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 9f91ad3..38ba00f 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -2,9 +2,9 @@
  * OMAP OPP Interface
  *
  * Copyright (C) 2009 Texas Instruments Incorporated.
- *	Nishanth Menon
- * Copyright (C) 2009 Deep Root Systems, LLC.
- *	Kevin Hilman
+ * Romit Dasgupta <romit@ti.com>
+ * Derived from the original series of patches by Nishanth Menon &
+ * Kevin Hilman.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,223 +13,88 @@
 #ifndef __ASM_ARM_OMAP_OPP_H
 #define __ASM_ARM_OMAP_OPP_H
 
-extern struct omap_opp *mpu_opps;
-extern struct omap_opp *dsp_opps;
-extern struct omap_opp *l3_opps;
+#ifdef CONFIG_CPU_FREQ
+#include <linux/cpufreq.h>
+#endif
 
-struct omap_opp;
+#define OPP_ENABLED (1 << 0)
+#define OPP_DISABLED (1 << 1)
+#define OPP_H (1 << 2)
+#define OPP_L (1 << 3)
+#define OPP_EQ (1 << 4)
+#define OPP_ALL (OPP_ENABLED | OPP_DISABLED)
 
-/**
- * opp_get_voltage() - Gets the voltage corresponding to an opp
- * @opp:	opp for which voltage has to be returned for
- *
- * Return voltage in micro volt corresponding to the opp, else
- * return 0
+/*
+ * XXX: Pending documentation.
  */
-unsigned long opp_get_voltage(const struct omap_opp *opp);
 
-/**
- * opp_get_freq() - Gets the frequency corresponding to an opp
- * @opp:	opp for which frequency has to be returned for
- *
- * Return frequency in hertz corresponding to the opp, else
- * return 0
- */
-unsigned long opp_get_freq(const struct omap_opp *opp);
+struct omap_opp {
+	struct list_head opp_node;
+	unsigned int enabled:1;
+	unsigned long rate;
+	unsigned long uvolt;
+};
 
-/**
- * opp_get_opp_count() - Get number of opps enabled in the opp list
- * @num:	returns the number of opps
- * @oppl:	opp list
- *
- * This functions returns the number of opps if there are any OPPs enabled,
- * else returns corresponding error value.
- */
-int opp_get_opp_count(struct omap_opp *oppl);
+enum opp_t {
+	OPP_NONE = 0,
+	OPP_MPU,
+	OPP_L3,
+	OPP_DSP,
+};
 
-/**
- * opp_find_freq_exact() - search for an exact frequency
- * @oppl:	OPP list
- * @freq:	frequency to search for
- * @enabled:	enabled/disabled OPP to search for
- *
- * searches for the match in the opp list and returns handle to the matching
- * opp if found, else returns ERR_PTR in case of error and should be handled
- * using IS_ERR.
- *
- * Note enabled is a modifier for the search. if enabled=true, then the match is
- * for exact matching frequency and is enabled. if true, the match is for exact
- * frequency which is disabled.
- */
-struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
-				     unsigned long freq, bool enabled);
+static inline long opp_to_volt(struct omap_opp *opp)
+{
+	return opp ? opp->uvolt : 0;
+}
 
-/* XXX This documentation needs fixing */
+static inline long opp_to_freq(struct omap_opp *opp)
+{
+	return opp ? opp->rate : 0;
+}
 
-/**
- * opp_find_freq_floor() - Search for an rounded freq
- * @oppl:	Starting list
- * @freq:	Start frequency
- *
- * Search for the lower *enabled* OPP from a starting freq
- * from a start opp list.
- *
- * Returns *opp and *freq is populated with the next match, else
- * returns NULL opp if found, else returns ERR_PTR in case of error.
- *
- * Example usages:
- *	* find match/next lowest available frequency
- *	freq = 350000;
- *	opp = opp_find_freq_floor(oppl, &freq)))
- *	if (IS_ERR(opp))
- *		pr_err ("unable to find a lower frequency\n");
- *	else
- *		pr_info("match freq = %ld\n", freq);
- *
- *	* print all supported frequencies in descending order *
- *	opp = oppl;
- *	freq = ULONG_MAX;
- *	while (!IS_ERR(opp = opp_find_freq_floor(opp, &freq)) {
- *		pr_info("freq = %ld\n", freq);
- *		freq--; * for next lower match *
- *	}
- *
- * NOTE: if we set freq as ULONG_MAX and search low, we get the
- * highest enabled frequency
- */
-struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
-				     unsigned long *freq);
+static inline unsigned int opp_is_valid(struct omap_opp *opp)
+{
+	return opp ? opp->enabled : 0;
+}
 
-/* XXX This documentation needs fixing */
+extern struct omap_opp *find_opp_by_freq(enum opp_t, unsigned long,
+						unsigned long);
 
-/**
- * opp_find_freq_ceil() - Search for an rounded freq
- * @oppl:	Starting list
- * @freq:	Start frequency
- *
- * Search for the higher *enabled* OPP from a starting freq
- * from a start opp list.
- *
- * Returns *opp and *freq is populated with the next match, else
- * returns NULL opp if found, else returns ERR_PTR in case of error.
- *
- * Example usages:
- *	* find match/next highest available frequency
- *	freq = 350000;
- *	opp = opp_find_freq_ceil(oppl, &freq))
- *	if (IS_ERR(opp))
- *		pr_err ("unable to find a higher frequency\n");
- *	else
- *		pr_info("match freq = %ld\n", freq);
- *
- *	* print all supported frequencies in ascending order *
- *	opp = oppl;
- *	freq = 0;
- *	while (!IS_ERR(opp = opp_find_freq_ceil(opp, &freq)) {
- *		pr_info("freq = %ld\n", freq);
- *		freq++; * for next higher match *
- *	}
- */
-struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq);
+extern unsigned int get_opp_count(enum opp_t, unsigned long);
 
+extern int opp_add(enum opp_t, struct omap_opp *, unsigned long);
+extern int opp_del(enum opp_t, struct omap_opp *);
 
-/**
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
+extern int create_opp_list(enum opp_t, struct omap_opp *);
 
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
+static inline void opp_enable(struct omap_opp *opp)
+{
+	opp ? opp->enabled = 1 : 0;
+	return;
 }
 
-/**
- * opp_init_list() - Initialize an opp list from the opp definitions
- * @opp_defs:	Initial opp definitions to create the list.
- *
- * This function creates a list of opp definitions and returns a handle.
- * This list can be used to further validation/search/modifications. New
- * opp entries can be added to this list by using opp_add().
- *
- * In the case of error, ERR_PTR is returned to the caller and should be
- * appropriately handled with IS_ERR.
- */
-struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs);
-
-/**
- * opp_add()  - Add an OPP table from a table definitions
- * @oppl:	List to add the OPP to
- * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
- *
- * This function adds an opp definition to the opp list and returns
- * a handle representing the new OPP list. This handle is then used for further
- * validation, search, modification operations on the OPP list.
- *
- * This function returns the pointer to the allocated list through oppl if
- * success, else corresponding ERR_PTR value. Caller should NOT free the oppl.
- * opps_defs can be freed after use.
- *
- * NOTE: caller should assume that on success, oppl is probably populated with
- * a new handle and the new handle should be used for further referencing
- */
-struct omap_opp *opp_add(struct omap_opp *oppl,
-			 const struct omap_opp_def *opp_def);
+static inline void opp_disable(struct omap_opp *opp)
+{
+	opp ? opp->enabled = 0 : 0;
+	return;
+}
 
-/**
- * opp_enable() - Enable a specific OPP
- * @opp:	Pointer to opp
- *
- * Enables a provided opp. If the operation is valid, this returns 0, else the
- * corresponding error value.
- *
- * OPP used here is from the the opp_is_valid/opp_has_freq or other search
- * functions
- */
-int opp_enable(struct omap_opp *opp);
+extern void dump_list(enum opp_t);
 
-/**
- * opp_disable() - Disable a specific OPP
- * @opp:	Pointer to opp
- *
- * Disables a provided opp. If the operation is valid, this returns 0, else the
- * corresponding error value.
- *
- * OPP used here is from the the opp_is_valid/opp_has_freq or other search
- * functions
+/*
+ * Initialization wrapper used to define an OPP.
  */
-int opp_disable(struct omap_opp *opp);
 
-struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
-						  u8 opp_id);
-u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
+#define OMAP_OPP_DEF(_enabled, _freq, _uv)		\
+{							\
+	.enabled	= _enabled,			\
+	.rate		= _freq,			\
+	.uvolt		= _uv,				\
+}
 
-void opp_init_cpufreq_table(struct omap_opp *opps,
-			    struct cpufreq_frequency_table **table);
 
+#ifdef CONFIG_CPU_FREQ
+extern void opp_init_cpufreq_table(struct cpufreq_frequency_table **);
+#endif
 
 #endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 4fe1933..afcd469 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -2,7 +2,9 @@
  * OMAP OPP Interface
  *
  * Copyright (C) 2009 Texas Instruments Incorporated.
- *	Nishanth Menon
+ * Romit Dasgupta <romit@ti.com>
+ * Derived from the original series of patches by
+ * Nishanth Menon & Kevin Hilman.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,318 +13,362 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
 #include <linux/cpufreq.h>
 
 #include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
 
-/**
- * struct omap_opp - OMAP OPP description structure
- * @enabled:	true/false - marking this OPP as enabled/disabled
- * @rate:	Frequency in hertz
- * @opp_id:	(DEPRECATED) opp identifier
- * @u_volt:     minimum microvolts DC required for this OPP to function
- *
- * This structure stores the OPP information for a given domain.
- * Due to legacy reasons, this structure is currently exposed and
- * will soon be removed elsewhere and will only be used as a handle
- * from the OPP internal referencing mechanism
- */
-struct omap_opp {
-	bool enabled;
-	unsigned long rate;
-	unsigned long u_volt;
-	u8 opp_id;
+/* For 3xxx we have MPU, DSP & L3 OPPs */
+#ifdef CONFIG_ARCH_OMAP3
+#define NUM_OPP_TYPES 3
+#else
+#error "define the OPP types for OMAP type"
+#endif
+
+struct opp_list {
+	struct list_head opp_head;
+	struct mutex opp_mtx;
+	enum opp_t id;
 };
 
 /*
- * DEPRECATED: Meant to detect end of opp array
- * This is meant to help co-exist with current SRF etc
- * TODO: REMOVE!
+ * Will hold OPPs for MPU, L3, DSP etc.
+ * This has been statically allocated as OPP types
+ * are known for eachy platform. However individual OPPs
+ * can be dynamically introduced or revoked.
  */
-#define OPP_TERM(opp) (!(opp)->rate && !(opp)->u_volt && !(opp)->enabled)
+static struct opp_list opp_types[NUM_OPP_TYPES];
 
-unsigned long opp_get_voltage(const struct omap_opp *opp)
+static struct opp_list *get_slot(void)
 {
-	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return 0;
+	struct opp_list *arr = opp_types;
+	int i;
+
+	for (i = 0; i < NUM_OPP_TYPES; i++)
+		if (arr->id == OPP_NONE)
+			break;
+		else
+			arr++;
+
+	if (i == NUM_OPP_TYPES)
+		return NULL;
+	else {
+		INIT_LIST_HEAD(&arr->opp_head);
+		mutex_init(&arr->opp_mtx);
+		return arr;
 	}
-	return opp->u_volt;
 }
 
-unsigned long opp_get_freq(const struct omap_opp *opp)
+static void put_slot(struct opp_list *arr)
 {
-	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return 0;
-	}
-	return opp->rate;
+	arr->id = OPP_NONE;
 }
 
-/**
- * opp_find_by_opp_id - look up OPP by OPP ID (deprecated)
- * @opps: pointer to an array of struct omap_opp
- *
- * Returns the struct omap_opp pointer corresponding to the given OPP
- * ID @opp_id, or returns NULL on error.
- */
-struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
-						  u8 opp_id)
+static struct opp_list *exists(enum opp_t id)
 {
+	struct opp_list *arr = opp_types;
 	int i = 0;
 
-	if (!opps || !opp_id)
+	if (!id)
 		return NULL;
 
-	while (!OPP_TERM(&opps[i])) {
-		if (opps[i].enabled && (opps[i].opp_id == opp_id))
-			return &opps[i];
-
-		i++;
+	for (i = 0; i < NUM_OPP_TYPES; i++) {
+		if (id == arr->id)
+			return arr;
+		arr++;
 	}
+	return NULL;
+}
+
+#define __OPP_NOLOCK (1 << 31)
 
+static struct omap_opp *_find_opp_by_freq_eq(struct list_head *head,
+						unsigned long freq)
+{
+	struct omap_opp *opp;
+
+	list_for_each_entry(opp, head, opp_node)
+		if (opp->rate == freq)
+			return opp;
 	return NULL;
 }
 
-u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
+static struct omap_opp *_find_first_enabled_h(struct list_head *head,
+						struct omap_opp *opp)
 {
-	return opp->opp_id;
+	while (!opp->enabled && opp->opp_node.prev != head)
+		opp = list_entry(opp->opp_node.prev, struct omap_opp,
+					opp_node);
+
+	if (opp->opp_node.prev == head && !opp->enabled)
+		return NULL;
+	else
+		return opp;
 }
 
-int opp_get_opp_count(struct omap_opp *oppl)
+static struct omap_opp *_find_first_enabled_l(struct list_head *head,
+						struct omap_opp *opp)
 {
-	u8 n = 0;
+	while (!opp->enabled && opp->opp_node.next != head)
+		opp = list_entry(opp->opp_node.next, struct omap_opp,
+					opp_node);
 
-	if (unlikely(!oppl || IS_ERR(oppl))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return -EINVAL;
-	}
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled)
-			n++;
-		oppl++;
-	}
-	return n;
+	if (opp->opp_node.next == head && !opp->enabled)
+		return NULL;
+	else
+		return opp;
 }
 
-struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
-				     unsigned long freq, bool enabled)
+static struct omap_opp *_find_opp_by_freq_h(struct list_head *head,
+						unsigned long freq,
+						unsigned long flags)
 {
-	if (unlikely(!oppl || IS_ERR(oppl))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
+	struct omap_opp *opp = NULL;
 
-	while (!OPP_TERM(oppl)) {
-		if ((oppl->rate == freq) && (oppl->enabled == enabled))
+	list_for_each_entry(opp, head, opp_node)
+		if (opp->rate > freq) {
+			if (opp->opp_node.prev == head)
+				return NULL;
 			break;
-		oppl++;
-	}
+		}
+	opp = list_entry(opp->opp_node.prev, struct omap_opp, opp_node);
 
-	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
+	if (flags & OPP_ENABLED)
+		opp = _find_first_enabled_h(head, opp);
+
+	return opp;
 }
 
-struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
+static struct omap_opp *_find_opp_by_freq_l(struct list_head *head,
+						unsigned long freq,
+						unsigned long flags)
 {
-	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
+	struct omap_opp *opp = NULL;
 
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled && oppl->rate >= *freq)
+	list_for_each_entry_reverse(opp, head, opp_node)
+		if (opp->rate < freq) {
+			if (opp->opp_node.next == head)
+				return NULL;
 			break;
+		}
 
-		oppl++;
-	}
+	opp = list_entry(opp->opp_node.next, struct omap_opp, opp_node);
+
+	if (flags & OPP_ENABLED)
+		opp = _find_first_enabled_l(head, opp);
 
-	if (OPP_TERM(oppl))
-		return ERR_PTR(-ENOENT);
+	return opp;
+}
+
+struct omap_opp *_find_opp_by_freq(struct opp_list *oppl,
+					unsigned long freq,
+					unsigned long flags)
+{
+	struct omap_opp *opp = NULL;
 
-	*freq = oppl->rate;
+	if (!(flags & __OPP_NOLOCK))
+		mutex_lock(&oppl->opp_mtx);
 
-	return oppl;
+	if (list_empty(&oppl->opp_head))
+		goto unlock;
+
+	if (flags & OPP_EQ) {
+		opp = _find_opp_by_freq_eq(&oppl->opp_head, freq);
+		if ((flags & OPP_ENABLED) && !opp_is_valid(opp))
+			opp = NULL;
+	} else if (flags & OPP_L) {
+		opp = _find_opp_by_freq_l(&oppl->opp_head, freq, flags);
+	} else if (flags & OPP_H)
+		opp = _find_opp_by_freq_h(&oppl->opp_head, freq, flags);
+
+unlock:
+	if (!(flags & __OPP_NOLOCK))
+		mutex_unlock(&oppl->opp_mtx);
+
+	return opp;
+}
+
+struct omap_opp *find_opp_by_freq(enum opp_t id, unsigned long freq,
+					unsigned long flags)
+{
+	struct opp_list *oppl;
+	oppl = exists(id);
+	BUG_ON(!oppl);
+	return _find_opp_by_freq(oppl, freq, flags);
 }
 
-struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl, unsigned long *freq)
+static unsigned int _get_opp_count(struct opp_list *oppl, unsigned long flags)
 {
-	struct omap_opp *prev_opp = oppl;
+	struct omap_opp *opp;
+	unsigned int enabled = 0, total = 0;
+
+	mutex_lock(&oppl->opp_mtx);
 
-	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
+	list_for_each_entry(opp, &oppl->opp_head, opp_node) {
+		if (flags & OPP_ENABLED && opp->enabled)
+			enabled++;
+		total++;
 	}
 
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled) {
-			if (oppl->rate > *freq)
-				break;
+	mutex_unlock(&oppl->opp_mtx);
 
-			prev_opp = oppl;
-		}
+	if (flags & OPP_ENABLED)
+		return enabled;
+	else
+		return total;
+}
 
-		oppl++;
-	}
+unsigned int get_opp_count(enum opp_t id, unsigned long flags)
+{
+	struct opp_list *oppl;
 
-	if (prev_opp->rate > *freq)
-		return ERR_PTR(-ENOENT);
+	oppl = exists(id);
+	BUG_ON(!oppl);
+	return _get_opp_count(oppl, flags);
+}
 
-	*freq = prev_opp->rate;
+static int _opp_del(struct opp_list *oppl, struct omap_opp *opp)
+{
+	mutex_lock(&oppl->opp_mtx);
+	list_del(&opp->opp_node);
+	mutex_unlock(&oppl->opp_mtx);
+	kfree(opp);
 
-	return oppl;
+	return 0;
 }
 
-/* wrapper to reuse converting opp_def to opp struct */
-static void omap_opp_populate(struct omap_opp *opp,
-			      const struct omap_opp_def *opp_def)
+int opp_del(enum opp_t id, struct omap_opp *opp)
 {
-	opp->rate = opp_def->freq;
-	opp->enabled = opp_def->enabled;
-	opp->u_volt = opp_def->u_volt;
+	struct opp_list *oppl;
+
+	oppl = exists(id);
+	BUG_ON(!oppl || !opp);
+
+	return _opp_del(oppl, opp);
 }
 
-struct omap_opp *opp_add(struct omap_opp *oppl,
-			 const struct omap_opp_def *opp_def)
+static int _opp_add(struct opp_list *oppl, struct omap_opp *opp,
+			unsigned long flags)
 {
-	struct omap_opp *opp, *oppt, *oppr;
-	u8 n, i, ins;
+	struct omap_opp *new_opp, *tmp;
 
-	if (unlikely(!oppl || IS_ERR(oppl) || !opp_def || IS_ERR(opp_def))) {
-		pr_err("%s: Invalid params being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
+	new_opp = kzalloc(sizeof(struct omap_opp), flags);
+	if (!new_opp)
+		return -ENOMEM;
 
-	n = 0;
-	opp = oppl;
-	while (!OPP_TERM(opp)) {
-		n++;
-		opp++;
-	}
+	INIT_LIST_HEAD(&new_opp->opp_node);
+	new_opp->enabled = opp->enabled;
+	new_opp->rate = opp->rate;
+	new_opp->uvolt = opp->uvolt;
+
+	mutex_lock(&oppl->opp_mtx);
 
 	/*
-	 * Allocate enough entries to copy the original list, plus the new
-	 * OPP, plus the concluding terminator
+	 * List is always sorted w.r.t. frequency. No duplicates.
 	 */
-	oppr = kzalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
-	if (!oppr) {
-		pr_err("%s: No memory for new opp array\n", __func__);
-		return ERR_PTR(-ENOMEM);
-	}
 
-	/* Simple insertion sort */
-	opp = oppl;
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
+	tmp = _find_opp_by_freq(oppl, opp->rate, OPP_H | __OPP_NOLOCK);
+
+	if (tmp) {
+		if (tmp->rate == opp->rate) {
+			kfree(opp);
+			mutex_unlock(&oppl->opp_mtx);
+			return -EEXIST;
 		}
-		oppt->opp_id = i;
-		oppt++;
-		i++;
-	} while (!OPP_TERM(opp));
+		__list_add(&new_opp->opp_node, &tmp->opp_node,
+				tmp->opp_node.next);
+	} else
+		/*
+		 * If this is the lowest frequency add it to the front of the
+		 * list.
+		 */
+		list_add(&new_opp->opp_node, &oppl->opp_head);
 
-	/* If nothing got inserted, this belongs to the end */
-	if (!ins) {
-		omap_opp_populate(oppt, opp_def);
-		oppt->opp_id = i;
-		oppt++;
-	}
+	mutex_unlock(&oppl->opp_mtx);
 
-	/* Terminator implicitly added by kzalloc() */
+	return 0;
+}
 
-	/* Free the old list */
-	kfree(oppl);
+int opp_add(enum opp_t id, struct omap_opp *opp, unsigned long flags)
+{
+	struct opp_list *oppl;
 
-	return oppr;
+	oppl = exists(id);
+	BUG_ON(!oppl || !opp);
+	return _opp_add(oppl, opp, flags);
 }
 
-struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
+static void __init destroy_opp_list(struct opp_list *oppl)
 {
-	struct omap_opp_def *t = (struct omap_opp_def *)opp_defs;
-	struct omap_opp *opp, *oppl;
-	u8 n = 0, i = 1;
+	struct omap_opp *opp;
 
-	if (unlikely(!opp_defs || IS_ERR(opp_defs))) {
-		pr_err("%s: Invalid params being passed\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-	/* Grab a count */
-	while (t->enabled || t->freq || t->u_volt) {
-		n++;
-		t++;
-	}
+	mutex_lock(&oppl->opp_mtx);
+	list_for_each_entry(opp, &oppl->opp_head, opp_node);
+		kfree(opp);
+	mutex_unlock(&oppl->opp_mtx);
+	return;
+}
 
-	/*
-	 * Allocate enough entries to copy the original list, plus the
-	 * concluding terminator
-	 */
-	oppl = kzalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
-	if (!oppl) {
-		pr_err("%s: No memory for opp array\n", __func__);
-		return ERR_PTR(-ENOMEM);
-	}
+int __init create_opp_list(enum opp_t id, struct omap_opp *oppdefs)
+{
+	int ret = 0, used_slot = 0;
+	struct opp_list *oppl;
 
-	opp = oppl;
-	while (n) {
-		omap_opp_populate(opp, opp_defs);
-		opp->opp_id = i;
-		n--;
-		opp++;
-		opp_defs++;
-		i++;
-	}
+	if (unlikely(!id))
+		return -EINVAL;
 
-	/* Terminator implicitly added by kzalloc() */
+	if (exists(id))
+		return -EEXIST;
 
-	return oppl;
-}
+	oppl = get_slot();
+	BUG_ON(!oppl);
+	oppl->id = id;
 
-int opp_enable(struct omap_opp *opp)
-{
-	if (unlikely(!opp || IS_ERR(opp))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return -EINVAL;
+	while (oppdefs->rate || oppdefs->uvolt) {
+		ret = _opp_add(oppl, oppdefs, GFP_KERNEL);
+		if (ret) {
+			destroy_opp_list(oppl);
+			put_slot(oppl);
+			return ret;
+		}
+		oppdefs++;
+		used_slot = 1;
 	}
-	opp->enabled = true;
-	return 0;
+
+	if (!used_slot)
+		put_slot(oppl);
+
+	return ret;
 }
 
-int opp_disable(struct omap_opp *opp)
+void dump_list(enum opp_t id)
 {
-	if (unlikely(!opp || IS_ERR(opp))) {
-		pr_err("%s: Invalid parameters being passed\n", __func__);
-		return -EINVAL;
-	}
-	opp->enabled = false;
-	return 0;
+	struct omap_opp *opp;
+	struct opp_list *oppl;
+
+	oppl = exists(id);
+	if (oppl)
+		list_for_each_entry(opp, &oppl->opp_head, opp_node)
+			printk(KERN_DEBUG"For OPP list %d, opp:%lu\n", id,
+					opp_to_freq(opp));
+	return;
 }
 
 /* XXX document */
-void opp_init_cpufreq_table(struct omap_opp *opps,
-			    struct cpufreq_frequency_table **table)
+void opp_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
-	int i = 0, j;
-	int opp_num;
+	int i = 0, opp_num;
+	unsigned long freq = ULONG_MAX;
+	struct omap_opp *opp;
 	struct cpufreq_frequency_table *freq_table;
 
-	if (!opps) {
-		pr_warning("%s: failed to initialize frequency"
-				"table\n", __func__);
-		return;
-	}
-
-	opp_num = opp_get_opp_count(opps);
-	if (opp_num < 0) {
+	opp_num = get_opp_count(OPP_MPU, OPP_ENABLED);
+	if (!opp_num) {
 		pr_err("%s: no opp table?\n", __func__);
 		return;
 	}
@@ -335,14 +381,17 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
 		return;
 	}
 
-	for (j = opp_num; j >= 0; j--) {
-		struct omap_opp *opp = &opps[j];
+	opp = find_opp_by_freq(OPP_MPU, freq, OPP_H | OPP_ENABLED);
 
-		if (opp->enabled) {
-			freq_table[i].index = i;
-			freq_table[i].frequency = opp->rate / 1000;
-			i++;
-		}
+	while (opp) {
+		freq_table[i].index = i;
+		freq_table[i].frequency = opp_to_freq(opp) / 1000;
+		i++;
+		/*
+		 * search the next highest frequency.
+		 */
+		freq = opp_to_freq(opp) - 1;
+		opp = find_opp_by_freq(OPP_MPU, freq, OPP_H | OPP_ENABLED);
 	}
 
 	freq_table[i].index = i;


