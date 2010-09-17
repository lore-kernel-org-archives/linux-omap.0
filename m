From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] opp: introduce library for device-specific OPPs
Date: Thu, 16 Sep 2010 20:29:33 -0500
Message-ID: <1284686973-13993-1-git-send-email-nm@ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, Vishwanath BS <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Roberto
List-Id: linux-omap@vger.kernel.org

SOCs have a standard set of tuples consisting of frequency and
voltage pairs that the device will support per voltage domain.  These
are called Operating Performance Points or OPPs. The actual
definitions of Operating Performance Points varies over silicon within the
same family of devices. For a specific domain, you can have a set of
{frequency, voltage} pairs. As the kernel boots and more information
is available, a set of these are activated based on the precise nature
of device the kernel boots up on. It is interesting to remember that
each IP which belongs to a voltage domain may define their own set of
OPPs on top of this.

To implement an OPP, some sort of power management support is necessary
hence this library enablement depends on CONFIG_PM, however this does
not fit into the core power framework as it is an independent library.
This is hence introduced under lib allowing all architectures to
selectively enable the feature based on thier capabilities.

Contributions include:
Sanjeev Premi for the initial concept:
	http://patchwork.kernel.org/patch/50998/
Kevin Hilman for converting original design to device-based
Kevin Hilman and Paul Walmsey for cleaning up many of the function
abstractions, improvements and data structure handling
Romit Dasgupta for using enums instead of opp pointers
Thara Gopinath, Eduardo Valentin and Vishwanath BS for fixes and
cleanups.
Linus Walleij for recommending this layer be made generic for usage
in other architectures beyond OMAP and ARM.

Discussions and comments from:
http://marc.info/?l=linux-omap&m=126033945313269&w=2
http://marc.info/?l=linux-omap&m=125482970102327&w=2
http://marc.info/?t=125809247500002&r=1&w=2
http://marc.info/?l=linux-omap&m=126025973426007&w=2
http://marc.info/?t=128152609200064&r=1&w=2
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
Cc: Linus Walleij <linus.walleij@stericsson.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
minor notes:
a) Code rebased to linus's tree commit 03a7ab0
b) Looping in get-maintainter.pl list and lkml as per thread of discussion
http://marc.info/?t=128152609200064&r=1&w=2

 Documentation/power/00-INDEX |    2 +
 include/linux/opp.h          |  136 +++++++++++++
 kernel/power/Kconfig         |   14 ++
 lib/Makefile                 |    2 +
 lib/opp.c                    |  440 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 594 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/opp.h
 create mode 100644 lib/opp.c

diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
index fb742c2..45e9d4a 100644
--- a/Documentation/power/00-INDEX
+++ b/Documentation/power/00-INDEX
@@ -14,6 +14,8 @@ interface.txt
 	- Power management user interface in /sys/power
 notifiers.txt
 	- Registering suspend notifiers in device drivers
+opp.txt
+	- Operating Performance Point library
 pci.txt
 	- How the PCI Subsystem Does Power Management
 pm_qos_interface.txt
diff --git a/include/linux/opp.h b/include/linux/opp.h
new file mode 100644
index 0000000..94a552b
--- /dev/null
+++ b/include/linux/opp.h
@@ -0,0 +1,136 @@
+/*
+ * Generic OPP Interface
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
+#ifndef __ASM_OPP_H
+#define __ASM_OPP_H
+
+#include <linux/err.h>
+#include <linux/cpufreq.h>
+
+/**
+ * struct opp_def - Generic OPP Definition
+ * @freq:	Frequency in hertz corresponding to this OPP
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @enabled:	True/false - is this OPP enabled/disabled by default
+ *
+ * SOCs have a standard set of tuples consisting of frequency and voltage
+ * pairs that the device will support per voltage domain. This is called
+ * Operating Performance Points or OPP. The actual definitions of Operating
+ * Performance Points varies over silicon within the same family of devices.
+ * For a specific domain, you can have a set of {frequency, voltage} pairs
+ * and this is denoted by an array of opp_def. As the kernel boots and more
+ * information is available, a set of these are activated based on the precise
+ * nature of device the kernel boots up on. It is interesting to remember that
+ * each IP which belongs to a voltage domain may define their own set of OPPs
+ * on top of this - but this is handled by the appropriate driver.
+ */
+struct opp_def {
+	unsigned long freq;
+	unsigned long u_volt;
+
+	bool enabled;
+};
+
+/*
+ * Initialization wrapper used to define an OPP.
+ * To point at the end of a terminator of a list of OPPs,
+ * use OPP_DEF(0, 0, 0)
+ */
+#define OPP_DEF(_enabled, _freq, _uv)	\
+{						\
+	.enabled	= _enabled,		\
+	.freq		= _freq,		\
+	.u_volt		= _uv,			\
+}
+
+struct opp;
+
+#ifdef CONFIG_PM
+
+unsigned long opp_get_voltage(const struct opp *opp);
+
+unsigned long opp_get_freq(const struct opp *opp);
+
+int opp_get_opp_count(struct device *dev);
+
+struct opp *opp_find_freq_exact(struct device *dev, unsigned long freq,
+				bool enabled);
+
+struct opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
+
+struct opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
+
+int opp_add(struct device *dev, const struct opp_def *opp_def);
+
+int opp_enable(struct opp *opp);
+
+int opp_disable(struct opp *opp);
+
+void opp_init_cpufreq_table(struct device *dev,
+			    struct cpufreq_frequency_table **table);
+#else
+static inline unsigned long opp_get_voltage(const struct opp *opp)
+{
+	return 0;
+}
+
+static inline unsigned long opp_get_freq(const struct opp *opp)
+{
+	return 0;
+}
+
+static inline int opp_get_opp_count(struct device *dev)
+{
+	return 0;
+}
+
+static inline struct opp *opp_find_freq_exact(struct device *dev,
+				     unsigned long freq, bool enabled)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct opp *opp_find_freq_floor(struct device *dev,
+					unsigned long *freq)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct opp *opp_find_freq_ceil(struct device *dev,
+					unsigned long *freq)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline int opp_add(struct device *dev, const struct opp_def *opp_def)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline int opp_enable(struct opp *opp)
+{
+	return 0;
+}
+
+static inline int opp_disable(struct opp *opp)
+{
+	return 0;
+}
+
+static inline void opp_init_cpufreq_table(struct device *dev,
+			    struct cpufreq_frequency_table **table)
+{
+}
+
+#endif		/* CONFIG_PM */
+#endif		/* __ASM_OPP_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ca6066a..634eab6 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -242,3 +242,17 @@ config PM_OPS
 	bool
 	depends on PM_SLEEP || PM_RUNTIME
 	default y
+
+config PM_OPP
+	bool "Enable Operating Performance Point(OPP) Layer library"
+	depends on PM
+	---help---
+	  SOCs have a standard set of tuples consisting of frequency and
+	  voltage pairs that the device will support per voltage domain. This
+	  is called Operating Performance Point or OPP. The actual definitions
+	  of OPP varies over silicon within the same family of devices.
+
+	  OPP layer organizes the data internally using device pointers
+	  representing individual voltage domains and provides SOC
+	  implementations a ready to use framework to manage OPPs.
+	  For more information, read <file:Documentation/power/opp.txt>
diff --git a/lib/Makefile b/lib/Makefile
index e6a3763..0114fcf 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -88,6 +88,8 @@ obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
 
+obj-$(CONFIG_PM_OPP) += opp.o
+
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
diff --git a/lib/opp.c b/lib/opp.c
new file mode 100644
index 0000000..650c8c3
--- /dev/null
+++ b/lib/opp.c
@@ -0,0 +1,440 @@
+/*
+ * Generic OPP Interface
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
+#include <linux/list.h>
+#include <linux/opp.h>
+
+/**
+ * struct opp - Generic OPP description structure
+ * @node:	list node
+ * @enabled:	true/false - marking this OPP as enabled/disabled
+ * @rate:	Frequency in hertz
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @dev_opp:	contains the device_opp struct
+ *
+ * This structure stores the OPP information for a given domain.
+ */
+struct opp {
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
+ * @dev:	device handle
+ * @opp_list:	list of opps
+ * @opp_count:	num opps
+ * @enabled_opp_count:	how many opps are actually enabled
+ *
+ * This is an internal datastructure maintaining the link to
+ * opps attached to a domain device. This structure is not
+ * meant to be shared with users as it private to opp layer.
+ */
+struct device_opp {
+	struct list_head node;
+
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
+unsigned long opp_get_voltage(const struct opp *opp)
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
+unsigned long opp_get_freq(const struct opp *opp)
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
+ * @dev:	device for which we do this operation
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
+ * @dev:	device for which we do this operation
+ * @freq:	frequency to search for
+ * @enabled:	enabled/disabled OPP to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ *
+ * Note: enabled is a modifier for the search. if enabled=true, then the match
+ * is for exact matching frequency and is enabled. if false, the match is for
+ * exact frequency which is disabled.
+ */
+struct opp *opp_find_freq_exact(struct device *dev,
+				     unsigned long freq, bool enabled)
+{
+	struct device_opp *dev_opp;
+	struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
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
+ * @dev:	device for which we do this operation
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
+ *	opp = opp_find_freq_ceil(dev, &freq))
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
+struct opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq)
+{
+	struct device_opp *dev_opp;
+	struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
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
+ * @dev:	device for which we do this operation
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
+ *	opp = opp_find_freq_floor(dev, &freq)))
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
+struct opp *opp_find_freq_floor(struct device *dev, unsigned long *freq)
+{
+	struct device_opp *dev_opp;
+	struct opp *temp_opp, *opp = ERR_PTR(-ENODEV);
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
+static void opp_populate(struct opp *opp,
+			      const struct opp_def *opp_def)
+{
+	opp->rate = opp_def->freq;
+	opp->enabled = opp_def->enabled;
+	opp->u_volt = opp_def->u_volt;
+}
+
+/**
+ * opp_add()  - Add an OPP table from a table definitions
+ * @dev:	device for which we do this operation
+ * @opp_def:	opp_def to describe the OPP which we want to add.
+ *
+ * This function adds an opp definition to the opp list and returns status.
+ */
+int opp_add(struct device *dev, const struct opp_def *opp_def)
+{
+	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
+	struct opp *opp, *new_opp;
+	struct list_head *head;
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
+		dev_opp->dev = dev;
+		INIT_LIST_HEAD(&dev_opp->opp_list);
+
+		list_add(&dev_opp->node, &dev_opp_list);
+	}
+
+	/* allocate new OPP node */
+	new_opp = kzalloc(sizeof(struct opp), GFP_KERNEL);
+	if (!new_opp) {
+		if (list_empty(&dev_opp->opp_list)) {
+			list_del(&dev_opp->node);
+			kfree(dev_opp);
+		}
+		pr_warning("%s: unable to allocate new opp node\n",
+			__func__);
+		return -ENOMEM;
+	}
+	opp_populate(new_opp, opp_def);
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
+int opp_enable(struct opp *opp)
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
+int opp_disable(struct opp *opp)
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
+ * @dev:	device for which we do this operation
+ * @table:	Cpufreq table returned back to caller
+ *
+ * Generate a cpufreq table for a provided domain - this assumes that the
+ * opp list is already initialized and ready for usage
+ */
+void opp_init_cpufreq_table(struct device *dev,
+			    struct cpufreq_frequency_table **table)
+{
+	struct device_opp *dev_opp;
+	struct opp *opp;
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
1.6.3.3
