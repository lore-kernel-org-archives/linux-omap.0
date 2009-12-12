From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 02/10 V5] omap3: pm: introduce opp accessor functions
Date: Fri, 11 Dec 2009 23:00:29 -0600
Message-ID: <1260594031-17268-2-git-send-email-nm@ti.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
 <1260594031-17268-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369AbZLLFAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 00:00:32 -0500
In-Reply-To: <1260594031-17268-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Sanjeev Premi <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Modifies the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/
Discussions and comments from:
http://marc.info/?l=linux-omap&m=126033945313269&w=2
http://marc.info/?l=linux-omap&m=125482970102327&w=2
http://marc.info/?t=125809247500002&r=1&w=2
http://marc.info/?l=linux-omap&m=126025973426007&w=2
incorporated.

OMAP SOCs have a standard set of tuples consisting of frequency and
voltage pairs that the device will support per voltage domain. This
is called Operating Points or OPP. The actual definitions of OMAP
Operating Points varies over silicon within the same family of
devices. For a specific domain, you can have a set of
{frequency, voltage} pairs. As the kernel boots and more information
is available, a set of these are activated based on the precise
nature of device the kernel boots up on. It is interesting to
remember that each IP which belongs to a voltage domain may define
their own set of OPPs on top of this.

This introduces a common handling OPP mechanism accross all OMAPs.
As a start this is introduced for OMAP3 and intends to replace
current OMAP3 opp handling mechanism.

Note:
fields of struct omap_opp is currently exposed due to the necessity
that SRF and SR logic directly indexes the structure array fields.
The goal however, is to make the direct usage of omap_opp deprecated
and move to using these accessor functions. The usage in SRF and SR
indexes based on opp_id and hence opp_id is marked deprecated to
generate build warnings at least. Further, this usage necessitates
need of terminator entries at the start and end of opp_* tables which
are dynamically allocated.

The accessor function definitions were collaborated with Kevin, and
doing justice here, this implementation could not go with some of
the better suggestions from kevin due to constraint imposed by SRF
and SR. A better and more optimal implementation is definitely
possible once SRF and SR are cleanedup/replaced.

NOTE: OPP is a concept that can be used in all OMAPs, it is hence
introduced under plat-omap

Introduces warning:
arch/arm/plat-omap/opp.c: In function 'opp_get_voltage':
arch/arm/plat-omap/opp.c:53: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c: In function 'opp_get_opp_count':
arch/arm/plat-omap/opp.c:76: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c: In function 'opp_find_freq_exact':
arch/arm/plat-omap/opp.c:94: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:96: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:102: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c: In function 'opp_find_freq_approx':
arch/arm/plat-omap/opp.c:115: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:119: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:122: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:130: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c: In function 'omap_opp_populate':
arch/arm/plat-omap/opp.c:143: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:145: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:146: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c: In function 'opp_add':
arch/arm/plat-omap/opp.c:160: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:167: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:191: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/plat-omap/opp.c:194: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:199: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/plat-omap/opp.c: In function 'opp_init_list':
arch/arm/plat-omap/opp.c:236: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)
arch/arm/plat-omap/opp.c:240: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/plat-omap/opp.c:249: warning: 'vsel' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:34)

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Kevin,
I have put your Signed-off-by to ack your contribs. pending
formal confirmation ofcourse.

 arch/arm/plat-omap/Makefile           |    3 +
 arch/arm/plat-omap/include/plat/opp.h |  231 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/opp.c              |  271 +++++++++++++++++++++++++++++++++
 3 files changed, 505 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/opp.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 95f8413..e9cf601 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -12,6 +12,9 @@ obj-  :=
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
+# OPP support in (OMAP3+ only at the moment)
+obj-$(CONFIG_ARCH_OMAP3) += opp.o
+
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
new file mode 100644
index 0000000..5d5d21b
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -0,0 +1,231 @@
+/*
+ * OMAP OPP Interface
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ * Copyright (C) 2009 Deep Root Systems, LLC.
+ *	Kevin Hilman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_OMAP_OPP_H
+#define __ASM_ARM_OMAP_OPP_H
+
+/**
+ * struct omap_opp - OMAP OPP description structure
+ * @enabled:	true/false - marking this OPP as enabled/disabled
+ * @rate:	Frequency in hertz
+ * @opp_id:	(DEPRECATED) opp identifier
+ * @vsel:	Voltage in volt processor level(this usage is
+ *		DEPRECATED to use Voltage in microvolts in future)
+ *		uV = ((vsel * 12.5) + 600) * 1000
+ *
+ * This structure stores the OPP information for a given domain.
+ * Due to legacy reasons, this structure is currently exposed and
+ * will soon be removed elsewhere and will only be used as a handle
+ * from the OPP internal referencing mechanism
+ */
+struct omap_opp {
+	bool enabled;
+	unsigned long rate;
+	u8 __deprecated opp_id;
+	u16 __deprecated vsel;
+};
+
+/**
+ * opp_get_voltage() - Gets the voltage corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * Return voltage in micro volt corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_voltage(const struct omap_opp *opp);
+
+/**
+ * opp_get_freq() - Gets the frequency corresponding to an opp
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Return frequency in hertz corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_freq(const struct omap_opp *opp);
+
+/**
+ * opp_get_opp_count() - Get number of opps enabled in the opp list
+ * @num:	returns the number of opps
+ * @oppl:	opp list
+ *
+ * This functions returns the number of opps if there are any OPPs enabled,
+ * else returns corresponding error value.
+ */
+int opp_get_opp_count(const struct omap_opp *oppl);
+
+/**
+ * opp_find_freq_exact() - search for an exact frequency
+ * @oppl:	OPP list
+ * @freq:	frequency to search for
+ * @enabled:	enabled/disabled OPP to search for
+ *
+ * searches for the match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ *
+ * Note enabled is a modifier for the search. if enabled=true, then the match is
+ * for exact matching frequency and is enabled. if true, the match is for exact
+ * frequency which is disabled.
+ */
+struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+				     unsigned long freq, bool enabled);
+
+#define OPP_SEARCH_HIGH		(0 << 1)
+#define OPP_SEARCH_LOW		(1 << 1)
+/**
+ * opp_find_freq_approx() - Search for an rounded freq
+ * @oppl:	Starting list
+ * @freq:	Start frequency
+ * @dir_flag:	Search direction
+ *		OPP_SEARCH_HIGH - search for next highest freq
+ *		OPP_SEARCH_LOW - search for next lowest freq
+ *
+ * Search for the higher/lower *enabled* OPP from a starting freq
+ * from a start opp list.
+ *
+ * Returns *opp and *freq is populated with the next match,
+ * else returns NULL
+ * opp if found, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next highest available frequency
+ *	freq = 350000;
+ *	opp = opp_find_freq_approx(oppl, &freq, OPP_SEARCH_HIGH)))
+ *	if (IS_ERR(opp))
+ *		pr_err ("unable to find a higher frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* find match/next lowest available frequency
+ *	freq = 350000;
+ *	opp = opp_find_freq_approx(oppl, &freq, OPP_SEARCH_LOW)))
+ *	if (IS_ERR(opp))
+ *		pr_err ("unable to find a lower frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* print all supported frequencies in descending order *
+ *	opp = oppl;
+ *	freq = ULONG_MAX;
+ *	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
+ *		OPP_SEARCH_LOW))) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq--; * for next lower match *
+ *	}
+ *
+ *	* print all supported frequencies in ascending order *
+ *	opp = oppl;
+ *	freq = 0;
+ *	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
+ *			OPP_SEARCH_HIGH))) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq++; * for next higher match *
+ *	}
+ *
+ * NOTE: if we set freq as ULONG_MAX and search low, we get the highest enabled
+ * frequency
+ */
+struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
+				      unsigned long *freq, u8 dir_flag);
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
+/**
+ * opp_init_list() - Initialize an opp list from the opp definitions
+ * @opp_defs:	Initial opp definitions to create the list.
+ *
+ * This function creates a list of opp definitions and returns a handle.
+ * This list can be used to further validation/search/modifications. New
+ * opp entries can be added to this list by using opp_add().
+ *
+ * In the case of error, ERR_PTR is returned to the caller and should be
+ * appropriately handled with IS_ERR.
+ */
+struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs);
+
+/**
+ * opp_add()  - Add an OPP table from a table definitions
+ * @oppl:	List to add the OPP to
+ * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
+ *
+ * This function adds an opp definition to the opp list and returns
+ * a handle representing the new OPP list. This handle is then used for further
+ * validation, search, modification operations on the OPP list.
+ *
+ * This function returns the pointer to the allocated list through oppl if
+ * success, else corresponding ERR_PTR value. Caller should NOT free the oppl.
+ * opps_defs can be freed after use.
+ *
+ * NOTE: caller should assume that on success, oppl is probably populated with
+ * a new handle and the new handle should be used for further referencing
+ */
+struct omap_opp *opp_add(struct omap_opp *oppl,
+			 const struct omap_opp_def *opp_def);
+
+/**
+ * opp_enable() - Enable a specific OPP
+ * @opp:	Pointer to opp
+ *
+ * Enables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int opp_enable(struct omap_opp *opp);
+
+/**
+ * opp_disable() - Disable a specific OPP
+ * @opp:	Pointer to opp
+ *
+ * Disables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int opp_disable(struct omap_opp *opp);
+
+#endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
new file mode 100644
index 0000000..c4dc07b
--- /dev/null
+++ b/arch/arm/plat-omap/opp.c
@@ -0,0 +1,271 @@
+/*
+ * OMAP OPP Interface
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+#include <plat/opp.h>
+
+/*
+ * DEPRECATED: Meant to detect end of opp array
+ * This is meant to help co-exist with current SRF etc
+ * TODO: REMOVE!
+ */
+#define OPP_TERM(opp) (!(opp)->rate && !(opp)->vsel && !(opp)->enabled)
+
+/*
+ * DEPRECATED: Meant to convert vsel value to uVolt
+ * This is meant to help co-exist with current SRF etc
+ * TODO: REMOVE!
+ */
+static inline unsigned long vsel_to_uv(const u8 vsel)
+{
+	return (((vsel * 125) + 6000)) * 100;
+}
+
+/*
+ * DEPRECATED: Meant to convert uVolt to vsel value
+ * This is meant to help co-exist with current SRF etc
+ * TODO: REMOVE!
+ */
+static inline unsigned char uv_to_vsel(unsigned long uV)
+{
+	return ((uV / 100) - 6000) / 125;
+}
+
+unsigned long opp_get_voltage(const struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return 0;
+	}
+	return vsel_to_uv(opp->vsel);
+}
+
+unsigned long opp_get_freq(const struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return 0;
+	}
+	return opp->rate;
+}
+
+int opp_get_opp_count(const struct omap_opp *oppl)
+{
+	struct omap_opp *opp;
+	u8 n = 0;
+
+	if (unlikely(!oppl || IS_ERR(oppl))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return -EINVAL;
+	}
+	opp = (struct omap_opp *)oppl;
+	opp++;			/* skip initial terminator */
+	while (!OPP_TERM(opp)) {
+		if (opp->enabled)
+			n++;
+		opp++;
+	}
+	return n;
+}
+
+struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+				     unsigned long freq, bool enabled)
+{
+	struct omap_opp *opp = (struct omap_opp *)oppl;
+
+	if (unlikely(!oppl || IS_ERR(oppl))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	/* skip initial terminator */
+	if (OPP_TERM(opp))
+		opp++;
+	while (!OPP_TERM(opp)) {
+		if ((opp->rate == freq) && (opp->enabled == enabled))
+			break;
+		opp++;
+	}
+
+	return OPP_TERM(opp) ? ERR_PTR(-ENOENT) : opp;
+}
+
+struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
+				      unsigned long *freq, u8 dir_flag)
+{
+	struct omap_opp *opp = (struct omap_opp *)oppl;
+
+	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	/* skip initial terminator */
+	if (OPP_TERM(opp)) {
+		opp++;
+		/* If searching init list for a high val, skip to very top */
+		if (dir_flag == OPP_SEARCH_LOW)
+			while (!OPP_TERM(opp + 1))
+				opp++;
+	}
+	while (!OPP_TERM(opp)) {
+		if (opp->enabled &&
+		    (((dir_flag == OPP_SEARCH_HIGH) && (opp->rate >= *freq)) ||
+		     ((dir_flag == OPP_SEARCH_LOW) && (opp->rate <= *freq))))
+			break;
+		opp += (dir_flag == OPP_SEARCH_LOW) ? -1 : 1;
+	}
+
+	if (OPP_TERM(opp))
+		return ERR_PTR(-ENOENT);
+
+	*freq = opp->rate;
+	return opp;
+}
+
+/* wrapper to reuse converting opp_def to opp struct */
+static void omap_opp_populate(struct omap_opp *opp,
+			      const struct omap_opp_def *opp_def)
+{
+	opp->rate = opp_def->freq;
+	opp->enabled = opp_def->enabled;
+	opp->vsel = uv_to_vsel(opp_def->u_volt);
+	/* round off to higher voltage */
+	if (opp_def->u_volt > vsel_to_uv(opp->vsel))
+		opp->vsel++;
+}
+
+struct omap_opp *opp_add(struct omap_opp *oppl,
+			 const struct omap_opp_def *opp_def)
+{
+	struct omap_opp *opp, *oppt, *oppr;
+	u8 n, i, ins;
+
+	if (unlikely(!oppl || IS_ERR(oppl) || !opp_def || IS_ERR(opp_def))) {
+		pr_err("%s: Invalid params being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	/* need a start terminator.. */
+	if (unlikely(!OPP_TERM(oppl))) {
+		pr_err("%s: Expected a start terminator!!\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	n = 0;
+	opp = oppl;
+	opp++;
+	while (!OPP_TERM(opp)) {
+		n++;
+		opp++;
+	}
+	/* lets now reallocate memory */
+	oppr = kmalloc(sizeof(struct omap_opp) * (n + 3), GFP_KERNEL);
+	if (!oppr) {
+		pr_err("%s: No memory for new opp array\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Simple insertion sort */
+	opp = oppl;
+	oppt = oppr;
+	ins = 0;
+	i = 0;
+	do {
+		if (ins || opp->rate < opp_def->freq) {
+			memcpy(oppt, opp, sizeof(struct omap_opp));
+			opp++;
+		} else {
+			omap_opp_populate(oppt, opp_def);
+			ins++;
+		}
+		oppt->opp_id = i;
+		oppt++;
+		i++;
+	} while (!OPP_TERM(opp));
+
+	/* If nothing got inserted, this belongs to the end */
+	if (!ins) {
+		omap_opp_populate(oppt, opp_def);
+		oppt->opp_id = i;
+		oppt++;
+	}
+	/* Put the terminator back on */
+	memcpy(oppt, opp, sizeof(struct omap_opp));
+
+	/* Free the old list */
+	kfree(oppl);
+
+	return oppr;
+}
+
+struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
+{
+	struct omap_opp_def *t = (struct omap_opp_def *)opp_defs;
+	struct omap_opp *opp, *oppl;
+	u8 n = 0, i = 1;
+
+	if (unlikely(!opp_defs || IS_ERR(opp_defs))) {
+		pr_err("%s: Invalid params being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	/* Grab a count */
+	while (t->enabled || t->freq || t->u_volt) {
+		n++;
+		t++;
+	}
+
+	oppl = kmalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
+	if (!oppl) {
+		pr_err("%s: No memory for opp array\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+	opp = oppl;
+	/* Setup start terminator - SRF depends on this for indexing :( */
+	opp->rate = 0;
+	opp->enabled = 0;
+	opp->vsel = 0;
+	opp++;
+	while (n) {
+		omap_opp_populate(opp, opp_defs);
+		opp->opp_id = i;
+		n--;
+		opp++;
+		opp_defs++;
+		i++;
+	}
+	/* Setup terminator - this is for our search algos */
+	opp->rate = 0;
+	opp->enabled = 0;
+	opp->vsel = 0;
+	return oppl;
+}
+
+int opp_enable(struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return -EINVAL;
+	}
+	opp->enabled = true;
+	return 0;
+}
+
+int opp_disable(struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return -EINVAL;
+	}
+	opp->enabled = false;
+	return 0;
+}
-- 
1.6.3.3

