From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 02/10 V3] omap3: pm: introduce opp accessor functions
Date: Tue, 24 Nov 2009 22:09:11 -0600
Message-ID: <1259122159-1583-3-git-send-email-nm@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42819 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934453AbZKYEJ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 23:09:26 -0500
In-Reply-To: <1259122159-1583-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Sanjeev Premi <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Modifies the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/
Discussions and comments from:
http://marc.info/?l=linux-omap&m=125482970102327&w=2
http://marc.info/?t=125809247500002&r=1&w=2
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

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/Makefile           |    3 +
 arch/arm/plat-omap/include/plat/opp.h |  208 ++++++++++++++++++++++++++
 arch/arm/plat-omap/opp.c              |  260 +++++++++++++++++++++++++++++++++
 3 files changed, 471 insertions(+), 0 deletions(-)
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
index 0000000..d8ae2d3
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -0,0 +1,208 @@
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
+	u8 opp_id __deprecated;
+	u16 vsel;
+};
+
+/**
+ * opp_get_voltage - Gets the voltage corresponding to an opp
+ * @u_volt:	Voltage in microvolts corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * Return 0 and the voltage in micro volt corresponding to the opp,
+ * else return the corresponding error value.
+ */
+int opp_get_voltage(u32 *u_volt, const struct omap_opp *opp);
+
+/**
+ * opp_get_freq - Gets the frequency corresponding to an opp
+ * @freq:	Frequency in hertz corresponding to an opp
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Return 0 and the frequency in hertz corresponding to the opp,
+ * else return the corresponding error value.
+ */
+int opp_get_freq(unsigned long *freq, const struct omap_opp *opp);
+
+/**
+ * opp_is_valid - Verifies if a given frequency is enabled in the opp list
+ * @opp:	Pointer to opp returned if opp match is achieved
+ * @oppl:	opp list
+ * @freq:	Frequency in hertz to check for
+ *
+ * Searches the OPP list to find if the provided frequency is an enabled
+ * frequency. If a match is achieved, it returns 0 and the pointer to the opp
+ * is returned, else a corresponding error value is returned.
+ */
+int opp_is_valid(struct omap_opp **opp, const struct omap_opp *oppl,
+		const unsigned long freq);
+
+/**
+ * opp_has_freq - Checks if a frequency is exists(enabled/disabled) in opp list
+ * @opp:	Pointer to opp returned if opp match is achieved
+ * @oppl:	opp list
+ * @freq:	Frequency in hertz to check for
+ *
+ * Searches the OPP list to find a frequency. This is a more generic function
+ * than the opp_is_valid since it searches for both enabled/disabled
+ * frequencies.
+ *
+ * This function may be used by detection logic to enable a disabled OPP as
+ * all other search functions work on enabled OPPs only.
+ */
+int opp_has_freq(struct omap_opp **opp, const struct omap_opp *oppl,
+		const unsigned long freq);
+
+/**
+ * opp_get_opp_count - Get number of opps enabled in the opp list
+ * @num:	returns the number of opps
+ * @oppl:	opp list
+ *
+ * This functions returns 0 and the number of opps are updated in num if
+ * success, else returns corresponding error value.
+ */
+int opp_get_opp_count(u8 *num, const struct omap_opp *oppl);
+
+/**
+ * opp_get_higher_opp - search for the next highest opp in the list
+ * @opp:	pointer to the opp
+ * @freq:	frequency to start the search on
+ * @oppl:	opp list to search on
+ *
+ * Searches for the higher *enabled* OPP than a starting freq/opp
+ * Decision of start condition:
+ *	if *opp is NULL, *freq is checked (usually the start condition)
+ *	if *opp is populated, *freq is ignored
+ * Returns 0 and *opp and *freq is populated with the next highest match,
+ * else returns corresponding error value.
+ *
+ * Example usage:
+ *	* print a all frequencies ascending order *
+ *	unsigned long freq = 0;
+ *	struct omap_opp *opp = NULL;
+ *	while(!opp_get_higher_opp(&opp, &freq, oppl))
+ *		pr_info("%ld ", freq);
+ * NOTE: if we set freq as 0, we get the lowest enabled frequency
+ */
+int opp_get_higher_opp(struct omap_opp **opp, unsigned long *freq,
+			const struct omap_opp *oppl);
+
+/**
+ * opp_get_lower_opp - search for the next lower opp in the list
+ * @opp:	pointer to the opp
+ * @freq:	frequency to start the search on
+ * @oppl:	opp list to search on
+ *
+ * Search for the lower *enabled* OPP than a starting freq/opp
+ * Decision of start condition:
+ *	if *opp is NULL, *freq is checked (usually the start condition)
+ *	if *opp is populated, *freq is ignored
+ * Returns 0 and *opp and *freq is populated with the next lowest match,
+ * else returns corresponding error value.
+ *
+ * Example usage:
+ *	* print a all frequencies in descending order *
+ *	unsigned long freq = ULONG_MAX;
+ *	struct omap_opp *opp = NULL;
+ *	while(!opp_get_lower_opp(&opp, &freq, oppl))
+ *		pr_info("%ld ", freq);
+ * NOTE: if we set freq as ULONG_MAX, we get the highest enabled frequency
+ */
+int opp_get_lower_opp(struct omap_opp **opp, unsigned long *freq,
+			const struct omap_opp *oppl);
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
+	u32 u_volt;
+};
+
+/**
+ * opp_init - Initialize an OPP table from the initial table definition
+ * @oppl:	Returned back to caller as the opp list to reference the OPP
+ * @opp_defs:	Array of omap_opp_def to describe the OPP. This list should be
+ *		0 terminated.
+ *
+ * This function creates the internal datastructure representing the OPP list
+ * from an initial definition table. this handle is then used for further
+ * validation, search, modification operations on the OPP list.
+ *
+ * This function returns 0 and the pointer to the allocated list through oppl if
+ * success, else corresponding error value. Caller should NOT free the oppl.
+ * opps_defs can be freed after use.
+ */
+int __init opp_init(struct omap_opp **oppl,
+		const struct omap_opp_def *opp_defs);
+
+/**
+ * opp_enable - Enable a specific OPP
+ * @opp:	pointer to opp
+ *
+ * Enables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int __init opp_enable(struct omap_opp *opp);
+
+/**
+ * opp_disable - Disable a specific OPP
+ * @opp:	pointer to opp
+ *
+ * Disables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int __init opp_disable(struct omap_opp *opp);
+
+#endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
new file mode 100644
index 0000000..23929b8
--- /dev/null
+++ b/arch/arm/plat-omap/opp.c
@@ -0,0 +1,260 @@
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
+int opp_get_voltage(u32 *u_volt, const struct omap_opp *opp)
+{
+	if (unlikely(!u_volt || !opp || !opp->enabled)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	*u_volt = vsel_to_uv(opp->vsel);
+	return 0;
+}
+
+int opp_get_freq(unsigned long *freq, const struct omap_opp *opp)
+{
+	if (unlikely(!freq || !opp || !opp->enabled)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	*freq = opp->rate;
+	return 0;
+}
+
+/* find the opp for a frequency */
+static struct omap_opp *find_opp_freq(const struct omap_opp *oppl,
+				      const unsigned long freq)
+{
+	struct omap_opp *opp = (struct omap_opp *)oppl;
+	opp++;			/* skip initial terminator */
+	while (!OPP_TERM(opp) && (opp->rate != freq))
+		opp++;
+
+	return (opp->rate == freq) ? opp : NULL;
+
+}
+
+int opp_is_valid(struct omap_opp **opp, const struct omap_opp *oppl,
+		 const unsigned long freq)
+{
+	struct omap_opp *t;
+	if (unlikely(!opp || !oppl)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	t = find_opp_freq(oppl, freq);
+	if (!t || !t->enabled || OPP_TERM(t))
+		return -EINVAL;
+	*opp = t;
+	return 0;
+}
+
+int opp_has_freq(struct omap_opp **opp, const struct omap_opp *oppl,
+		 const unsigned long freq)
+{
+	struct omap_opp *t;
+	if (unlikely(!opp || !oppl)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	t = find_opp_freq(oppl, freq);
+	if (!t || OPP_TERM(t))
+		return -EINVAL;
+	*opp = t;
+	return 0;
+}
+
+int opp_get_opp_count(u8 *num, const struct omap_opp *oppl)
+{
+	struct omap_opp *opp = (struct omap_opp *)oppl;
+	u8 n = 0;
+	if (unlikely(!num || !oppl)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	opp++;			/* skip initial terminator */
+	while (!OPP_TERM(opp)) {
+		if (opp->enabled)
+			n++;
+		opp++;
+	}
+	*num = n;
+	return 0;
+}
+
+int opp_get_higher_opp(struct omap_opp **opp, unsigned long *freq,
+		       const struct omap_opp *oppl)
+{
+	struct omap_opp *t;
+	unsigned long f;
+
+	if (unlikely((!freq && !opp) || !oppl)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	/* Handle start condition */
+	if (!*opp) {
+		t = (struct omap_opp *)oppl;
+		t++;		/* skip init terminator */
+		f = *freq;
+	} else {
+		t = *opp;
+		f = t->rate;
+	}
+	while (!OPP_TERM(t)) {
+		if (t->enabled && (t->rate > f))
+			break;
+		t++;
+	}
+	if (OPP_TERM(t))
+		return -EINVAL;
+	*opp = t;
+	*freq = t->rate;
+	return 0;
+}
+
+int opp_get_lower_opp(struct omap_opp **opp, unsigned long *freq,
+		      const struct omap_opp *oppl)
+{
+	struct omap_opp *t;
+	unsigned long f;
+
+	if (unlikely((!freq && !opp) || !oppl)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	/* Handle start condition */
+	if (!*opp) {
+		t = (struct omap_opp *)oppl;
+		t++;		/* skip initial terminator */
+		/* seek to top - need to search top bottom */
+		while (!OPP_TERM(t + 1))
+			t++;
+		f = *freq;
+	} else {
+		t = *opp;
+		f = t->rate;
+	}
+
+	do {
+		if (t->enabled && (t->rate < f))
+			break;
+		t--;
+	} while (!OPP_TERM(t));
+
+	/* Check if we did not match */
+	if (!t->enabled || t->rate >= f)
+		return -EINVAL;
+
+	*opp = t;
+	*freq = t->rate;
+	return 0;
+}
+
+int __init opp_init(struct omap_opp **oppl, const struct omap_opp_def *opp_defs)
+{
+	struct omap_opp_def *t = (struct omap_opp_def *)opp_defs;
+	struct omap_opp *opp;
+	u8 n = 0, i = 1;
+	if (unlikely(*oppl || !opp_defs)) {
+		pr_err("Invalid params being passed\n");
+		return -EINVAL;
+	}
+	/* Grab a count */
+	while (t->enabled || t->freq || t->u_volt) {
+		n++;
+		t++;
+	}
+
+	opp = kmalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
+	if (!opp) {
+		pr_err("No memory for opp array\n");
+		return -ENOMEM;
+	}
+	*oppl = opp;
+	/* Setup start terminator - SRF depends on this for indexing :( */
+	opp->rate = 0;
+	opp->enabled = 0;
+	opp->vsel = 0;
+	opp++;
+	while (n) {
+		opp->rate = opp_defs->freq;
+		opp->enabled = opp_defs->enabled;
+		opp->opp_id = i;
+		opp->vsel = uv_to_vsel(opp_defs->u_volt);
+		/* round off to higher voltage */
+		if (opp_defs->u_volt > vsel_to_uv(opp->vsel))
+			opp->vsel++;
+		n--;
+		opp++;
+		opp_defs++;
+		i++;
+	}
+	/* Setup terminator - this is for our search algos */
+	opp->rate = 0;
+	opp->enabled = 0;
+	opp->vsel = 0;
+	return 0;
+}
+
+int __init opp_enable(struct omap_opp *opp)
+{
+	if (unlikely(!opp)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	opp->enabled = true;
+	return 0;
+}
+
+int __init opp_disable(struct omap_opp *opp)
+{
+	if (unlikely(!opp)) {
+		pr_err("Invalid parameters being passed\n");
+		return -EINVAL;
+	}
+	opp->enabled = false;
+	return 0;
+}
-- 
1.6.3.3

