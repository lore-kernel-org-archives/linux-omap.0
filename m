From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Wed, 15 Sep 2010 14:56:36 -0700
Message-ID: <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42616 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0IOV4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:56:47 -0400
Received: by pzk34 with SMTP id 34so193347pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 14:56:45 -0700 (PDT)
In-Reply-To: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Nishanth Menon <nm@ti.com>

OMAP SOCs have a standard set of tuples consisting of frequency and
voltage pairs that the device will support per voltage domain.  These
are called Operating Performance Points or OPPs. The actual
definitions of OMAP Operating Points varies over silicon within the
same family of devices. For a specific domain, you can have a set of
{frequency, voltage} pairs. As the kernel boots and more information
is available, a set of these are activated based on the precise nature
of device the kernel boots up on. It is interesting to remember that
each IP which belongs to a voltage domain may define their own set of
OPPs on top of this.

This introduces a common handling OPP mechanism accross all OMAPs.
As a start this is used for OMAP3.

Note: OPP is a concept that can be used in all OMAPs, it is hence
introduced under plat-omap

Contributions include:
Sanjeev Premi for the initial concept:
	http://patchwork.kernel.org/patch/50998/
Kevin Hilman for converting original design to device-based
Kevin Hilman and Paul Walmsey for cleaning up many of the function
abstractions, improvements and data structure handling
Romit Dasgupta for using enums instead of opp pointers
Thara Gopinath, Eduardo Valentin and Vishwanath BS for fixes and
cleanups.

Discussions and comments from:
http://marc.info/?l=linux-omap&m=126033945313269&w=2
http://marc.info/?l=linux-omap&m=125482970102327&w=2
http://marc.info/?t=125809247500002&r=1&w=2
http://marc.info/?l=linux-omap&m=126025973426007&w=2
incorporated.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Roberto Granados Dorado <x0095451@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 Documentation/arm/OMAP/omap_pm        |   83 ++++++
 arch/arm/plat-omap/Makefile           |    5 +
 arch/arm/plat-omap/include/plat/opp.h |  145 +++++++++++
 arch/arm/plat-omap/opp.c              |  461 +++++++++++++++++++++++++++++++++
 4 files changed, 694 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/opp.c

diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
index 5389440..6527cdf 100644
--- a/Documentation/arm/OMAP/omap_pm
+++ b/Documentation/arm/OMAP/omap_pm
@@ -127,3 +127,86 @@ implementation needs:
 10. (*pdata->cpu_set_freq)(unsigned long f)
 
 11. (*pdata->cpu_get_freq)(void)
+
+OMAP OPP Layer
+==============
+OMAP SOCs have a standard set of tuples consisting of frequency and
+voltage pairs that the device will support per voltage domain. This
+is called Operating Performance Point or OPP. The actual definitions
+of OMAP OPP varies over silicon within the same family of devices.
+For a specific domain, you can have a set of {frequency, voltage}
+pairs. As the kernel boots and more information is available, a set
+of these are activated based on the precise nature of device the kernel
+boots up on. It is interesting to remember that each IP which belongs
+to a voltage domain may define their own set of OPPs on top of this.
+
+OPP layer of its own depends on silicon specific implementation and
+board specific data to finalize on the final set of OPPs available
+in a system
+
+Initial list initialization:
+---------------------------
+The normal initialization sequence is for boardxyz_init_irq to call
+omap2_init_common_hw (for omap2+) and which in turn does the default
+setup required.
+
+Silicon specific initialization: First the OPP layer needs to be told
+to initialize the tables for OMAP3, there are two options here:
+a) If the desire is to use the default tables defined for that silicon,
+the board file does not need to call any initialization function, the
+defaults are setup as part of initialization flow when
+omap2_init_common_hw is called.
+
+b) board files would like to customize the default definition. In this
+case, board file needs to call explicitly prior to table operations.
+the sequence is:
+boardxyz_init_irq()
+{
+	... do things ..
+	omap3_pm_init_opp_table()
+	.. customizations and other things ..
+	omap2_init_common_hw()
+}
+1. omap3_pm_init_opp_table - this in turn calls opp_init_list for all
+OPP types. This is the generic silicon operating points, however, the
+system may have additional features or customizations required. This
+flexibility is provided by the following apis:
+
+Query functions:
+----------------
+Search for OPPs for various cases:
+2. opp_find_freq_exact - exact search function
+3. opp_find_freq_floor - round_up search function
+4. opp_find_freq_ceil - round_down search function
+
+OPP modifier functions:
+----------------------
+This allows opp layer users to add customized OPPs or change the table
+for any need they may have
+5. opp_add - add a new OPP - NOTE: use struct omap_opp_def and define
+the custom OPP with OMAP_OPP_DEF for usage.
+6. opp_enable - enable a disabled OPP
+7. opp_disable - disable an enabled OPP
+
+OPP Data retrieval functions:
+----------------------------
+The following sets of functions are useful for drivers to retrieve
+data stored in opp layer for various functions.
+8. opp_get_voltage - retrieve voltage for an opp
+9. opp_get_freq - get the frequency for an opp
+10. opp_get_opp_count - get number of opps enabled for a domain
+
+Cpufreq table generation:
+------------------------
+11. opp_init_cpufreq_table - this translates the OPP layer's internal
+OPP arrangement into a table understood and operated upon by the
+cpufreq layer.
+
+Data Structures:
+---------------
+struct omap_opp * is a handle structure whose internals are known only
+to the OPP layer and is meant to hide the complexity away from users of
+opp layer.
+
+struct omap_opp_def * is the definitions that users can interface with
+opp layer and is meant to define one OPP.
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9405831..c718a0a 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -12,6 +12,11 @@ obj-  :=
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
+# OPP support in (OMAP3+ only at the moment)
+ifdef CONFIG_PM
+obj-$(CONFIG_ARCH_OMAP3) += opp.o
+endif
+
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
new file mode 100644
index 0000000..997b56e
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -0,0 +1,145 @@
+/*
+ * OMAP OPP Interface
+ *
+ * Copyright (C) 2009-2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *	Romit Dasgupta <romit@ti.com>
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
+#include <linux/err.h>
+#include <linux/cpufreq.h>
+
+#include <plat/common.h>
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
+	bool enabled;
+};
+
+/*
+ * Initialization wrapper used to define an OPP.
+ * To point at the end of a terminator of a list of OPPs,
+ * use OMAP_OPP_DEF(NULL, 0, 0, 0)
+ */
+#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv)	\
+{						\
+	.hwmod_name	= _hwmod_name,		\
+	.enabled	= _enabled,		\
+	.freq		= _freq,		\
+	.u_volt		= _uv,			\
+}
+
+struct omap_opp;
+
+#ifdef CONFIG_PM
+
+unsigned long opp_get_voltage(const struct omap_opp *opp);
+
+unsigned long opp_get_freq(const struct omap_opp *opp);
+
+int opp_get_opp_count(struct device *dev);
+
+struct omap_opp *opp_find_freq_exact(struct device *dev,
+				     unsigned long freq, bool enabled);
+
+struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
+
+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
+
+int opp_add(const struct omap_opp_def *opp_def);
+
+int opp_enable(struct omap_opp *opp);
+
+int opp_disable(struct omap_opp *opp);
+
+void opp_init_cpufreq_table(struct device *dev,
+			    struct cpufreq_frequency_table **table);
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
+						   unsigned long freq,
+						   bool enabled)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
+						   unsigned long *freq)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
+						  unsigned long *freq)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct omap_opp *opp_add(struct omap_opp *oppl,
+				       const struct omap_opp_def *opp_def)
+{
+	return ERR_PTR(-EINVAL);
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
+static inline
+void opp_init_cpufreq_table(struct omap_opp *opps,
+			    struct cpufreq_frequency_table **table)
+{
+}
+
+#endif		/* CONFIG_PM */
+#endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
new file mode 100644
index 0000000..17f93b2
--- /dev/null
+++ b/arch/arm/plat-omap/opp.c
@@ -0,0 +1,461 @@
+/*
+ * OMAP OPP Interface
+ *
+ * Copyright (C) 2009-2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *	Romit Dasgupta <romit@ti.com>
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
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/list.h>
+
+#include <plat/opp.h>
+#include <plat/omap_device.h>
+
+/**
+ * struct omap_opp - OMAP OPP description structure
+ * @enabled:	true/false - marking this OPP as enabled/disabled
+ * @rate:	Frequency in hertz
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @dev_opp:	contains the device_opp struct
+ *
+ * This structure stores the OPP information for a given domain.
+ */
+struct omap_opp {
+	struct list_head node;
+
+	bool enabled;
+	unsigned long rate;
+	unsigned long u_volt;
+
+	struct device_opp *dev_opp;
+};
+
+/**
+ * struct device_opp - Device opp structure
+ * @node:	list node
+ * @oh:		hwmod handle
+ * @dev:	device handle
+ * @opp_list:	list of opps
+ * @opp_count:	num opps
+ * @enabled_opp_count:	how many opps are actually enabled
+ *
+ * This is an internal datastructure maintaining the link to
+ * omap_opps attached to a domain device. This structure is not
+ * meant to be shared with users as it private to opp layer.
+ */
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
+ * @dev:	device pointer used to lookup device OPPs
+ *
+ * Search list of device OPPs for one containing matching device.
+ *
+ * Returns pointer to 'struct device_opp' if found, otherwise -ENODEV or
+ * -EINVAL based on type of error.
+ */
+static struct device_opp *find_device_opp(struct device *dev)
+{
+	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
+
+	if (unlikely(!dev || IS_ERR(dev))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
+		if (tmp_dev_opp->dev == dev) {
+			dev_opp = tmp_dev_opp;
+			break;
+		}
+	}
+
+	return dev_opp;
+}
+
+/**
+ * opp_get_voltage() - Gets the voltage corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * Return voltage in micro volt corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_voltage(const struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return 0;
+	}
+
+	return opp->u_volt;
+}
+
+/**
+ * opp_get_freq() - Gets the frequency corresponding to an opp
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Return frequency in hertz corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_freq(const struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return 0;
+	}
+
+	return opp->rate;
+}
+
+/**
+ * opp_get_opp_count() - Get number of opps enabled in the opp list
+ * @opp_type:	OPP type we want to count
+ *
+ * This functions returns the number of opps if there are any OPPs enabled,
+ * else returns corresponding error value.
+ */
+int opp_get_opp_count(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return -ENODEV;
+
+	return dev_opp->enabled_opp_count;
+}
+
+/**
+ * opp_find_freq_exact() - search for an exact frequency
+ * @opp_type:	OPP type we want to search in.
+ * @freq:	frequency to search for
+ * @enabled:	enabled/disabled OPP to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ *
+ * Note enabled is a modifier for the search. if enabled=true, then the match is
+ * for exact matching frequency and is enabled. if false, the match is for exact
+ * frequency which is disabled.
+ */
+struct omap_opp *opp_find_freq_exact(struct device *dev,
+				     unsigned long freq, bool enabled)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate == freq) {
+			opp = temp_opp;
+			break;
+		}
+	}
+
+	return opp;
+}
+
+/**
+ * opp_find_freq_ceil() - Search for an rounded ceil freq
+ * @opp_type:	OPP type where we want to search in
+ * @freq:	Start frequency
+ *
+ * Search for the matching ceil *enabled* OPP from a starting freq
+ * for a domain.
+ *
+ * Returns *opp and *freq is populated with the match, else
+ * returns NULL opp if no match, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next highest available frequency *
+ *	freq = 350000;
+ *	opp = opp_find_freq_ceil(OPP_MPU, &freq))
+ *	if (IS_ERR(opp))
+ *		pr_err("unable to find a higher frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* print all supported frequencies in ascending order *
+ *	freq = 0; * Search for the lowest enabled frequency *
+ *	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq++; * for next higher match *
+ *	}
+ */
+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate >= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
+			break;
+		}
+	}
+
+	return opp;
+}
+
+/**
+ * opp_find_freq_floor() - Search for an rounded floor freq
+ * @opp_type:	OPP type we want to search in
+ * @freq:	Start frequency
+ *
+ * Search for the matching floor *enabled* OPP from a starting freq
+ * for a domain.
+ *
+ * Returns *opp and *freq is populated with the next match, else
+ * returns NULL opp if no match, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next lowest available frequency
+ *	freq = 350000;
+ *	opp = opp_find_freq_floor(OPP_MPU, &freq)))
+ *	if (IS_ERR(opp))
+ *		pr_err ("unable to find a lower frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* print all supported frequencies in descending order *
+ *	freq = ULONG_MAX; * search highest enabled frequency *
+ *	while (!IS_ERR(opp = opp_find_freq_floor(OPP_MPU, &freq)) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq--; * for next lower match *
+ *	}
+ */
+struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		return opp;
+
+	list_for_each_entry_reverse(temp_opp, &dev_opp->opp_list, node) {
+		if (temp_opp->enabled && temp_opp->rate <= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
+			break;
+		}
+	}
+
+	return opp;
+}
+
+/* wrapper to reuse converting opp_def to opp struct */
+static void omap_opp_populate(struct omap_opp *opp,
+			      const struct omap_opp_def *opp_def)
+{
+	opp->rate = opp_def->freq;
+	opp->enabled = opp_def->enabled;
+	opp->u_volt = opp_def->u_volt;
+}
+
+/**
+ * opp_add()  - Add an OPP table from a table definitions
+ * @opp_def:	omap_opp_def to describe the OPP which we want to add.
+ *
+ * This function adds an opp definition to the opp list and returns status.
+ */
+int opp_add(const struct omap_opp_def *opp_def)
+{
+	struct omap_hwmod *oh;
+	struct device *dev = NULL;
+	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
+	struct omap_opp *opp, *new_opp;
+	struct platform_device *pdev;
+	struct list_head *head;
+
+	/* find the correct hwmod, and device */
+	if (!opp_def->hwmod_name) {
+		pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
+		return -EINVAL;
+	}
+	oh = omap_hwmod_lookup(opp_def->hwmod_name);
+	if (!oh || !oh->od) {
+		pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
+			__func__, opp_def->hwmod_name);
+		return -EINVAL;
+	}
+	pdev = &oh->od->pdev;
+	dev = &oh->od->pdev.dev;
+
+	/* Check for existing list for 'dev' */
+	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
+		if (dev == tmp_dev_opp->dev) {
+			dev_opp = tmp_dev_opp;
+			break;
+		}
+	}
+
+	if (!dev_opp) {
+		/* Allocate a new device OPP table */
+		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
+		if (!dev_opp) {
+			pr_warning("%s: unable to allocate device struct\n",
+				__func__);
+			return -ENOMEM;
+		}
+
+		dev_opp->oh = oh;
+		dev_opp->dev = &oh->od->pdev.dev;
+		INIT_LIST_HEAD(&dev_opp->opp_list);
+
+		list_add(&dev_opp->node, &dev_opp_list);
+	}
+
+	/* allocate new OPP node */
+	new_opp = kzalloc(sizeof(struct omap_opp), GFP_KERNEL);
+	if (!new_opp) {
+		if (list_empty(&dev_opp->opp_list)) {
+			list_del(&dev_opp->node);
+			kfree(dev_opp);
+		}
+		pr_warning("%s: unable to allocate new opp node\n",
+			__func__);
+		return -ENOMEM;
+	}
+	omap_opp_populate(new_opp, opp_def);
+
+	/* Insert new OPP in order of increasing frequency */
+	head = &dev_opp->opp_list;
+	list_for_each_entry_reverse(opp, &dev_opp->opp_list, node) {
+		if (new_opp->rate >= opp->rate) {
+			head = &opp->node;
+			break;
+		}
+	}
+	list_add(&new_opp->node, head);
+	dev_opp->opp_count++;
+	if (new_opp->enabled)
+		dev_opp->enabled_opp_count++;
+
+	return 0;
+}
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
+int opp_enable(struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!opp->enabled && opp->dev_opp)
+		opp->dev_opp->enabled_opp_count++;
+
+	opp->enabled = true;
+
+	return 0;
+}
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
+int opp_disable(struct omap_opp *opp)
+{
+	if (unlikely(!opp || IS_ERR(opp))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (opp->enabled && opp->dev_opp)
+		opp->dev_opp->enabled_opp_count--;
+
+	opp->enabled = false;
+
+	return 0;
+}
+
+/**
+ * opp_init_cpufreq_table() - create a cpufreq table for a domain
+ * @opp_type:	OPP type to initialize this list for
+ * @table:	Cpufreq table returned back to caller
+ *
+ * Generate a cpufreq table for a provided domain - this assumes that the
+ * opp list is already initialized and ready for usage
+ */
+void opp_init_cpufreq_table(struct device *dev,
+			    struct cpufreq_frequency_table **table)
+{
+	struct device_opp *dev_opp;
+	struct omap_opp *opp;
+	struct cpufreq_frequency_table *freq_table;
+	int i = 0;
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		pr_warning("%s: unable to find device\n", __func__);
+		return;
+	}
+
+	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
+			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
+	if (!freq_table) {
+		pr_warning("%s: failed to allocate frequency table\n",
+			   __func__);
+		return;
+	}
+
+	list_for_each_entry(opp, &dev_opp->opp_list, node) {
+		if (opp->enabled) {
+			freq_table[i].index = i;
+			freq_table[i].frequency = opp->rate / 1000;
+			i++;
+		}
+	}
+
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	*table = &freq_table[0];
+}
-- 
1.7.2.1

