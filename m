From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 15:55:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424E7@dbde02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
 <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35741 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0IPK0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 06:26:06 -0400
In-Reply-To: <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Thursday, September 16, 2010 3:27 AM
>>To: linux-omap@vger.kernel.org
>>Cc: linux-arm-kernel@lists.infradead.org
>>Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
>>
>>From: Nishanth Menon <nm@ti.com>
>>
>>OMAP SOCs have a standard set of tuples consisting of frequency and
>>voltage pairs that the device will support per voltage domain.  These
>>are called Operating Performance Points or OPPs. The actual
>>definitions of OMAP Operating Points varies over silicon within the
>>same family of devices. For a specific domain, you can have a set of
>>{frequency, voltage} pairs. As the kernel boots and more information
>>is available, a set of these are activated based on the precise nature
>>of device the kernel boots up on. It is interesting to remember that
>>each IP which belongs to a voltage domain may define their own set of
>>OPPs on top of this.
>>
>>This introduces a common handling OPP mechanism accross all OMAPs.
>>As a start this is used for OMAP3.
>>
>>Note: OPP is a concept that can be used in all OMAPs, it is hence
>>introduced under plat-omap
>>
>>Contributions include:
>>Sanjeev Premi for the initial concept:
>>	http://patchwork.kernel.org/patch/50998/
>>Kevin Hilman for converting original design to device-based
>>Kevin Hilman and Paul Walmsey for cleaning up many of the function
>>abstractions, improvements and data structure handling
>>Romit Dasgupta for using enums instead of opp pointers
>>Thara Gopinath, Eduardo Valentin and Vishwanath BS for fixes and
>>cleanups.
>>
>>Discussions and comments from:
>>http://marc.info/?l=linux-omap&m=126033945313269&w=2
>>http://marc.info/?l=linux-omap&m=125482970102327&w=2
>>http://marc.info/?t=125809247500002&r=1&w=2
>>http://marc.info/?l=linux-omap&m=126025973426007&w=2
>>incorporated.
>>
>>Cc: Benoit Cousson <b-cousson@ti.com>
>>Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
>>Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
>>Cc: Roberto Granados Dorado <x0095451@ti.com>
>>Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
>>Cc: Tero Kristo <Tero.Kristo@nokia.com>
>>Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
>>Cc: Paul Walmsley <paul@pwsan.com>
>>Cc: Romit Dasgupta <romit@ti.com>
>>Cc: Sanjeev Premi <premi@ti.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>Cc: Vishwanath BS <vishwanath.bs@ti.com>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>> Documentation/arm/OMAP/omap_pm        |   83 ++++++
>> arch/arm/plat-omap/Makefile           |    5 +
>> arch/arm/plat-omap/include/plat/opp.h |  145 +++++++++++
>> arch/arm/plat-omap/opp.c              |  461 +++++++++++++++++++++++++++++++++
>> 4 files changed, 694 insertions(+), 0 deletions(-)
>> create mode 100644 arch/arm/plat-omap/include/plat/opp.h
>> create mode 100644 arch/arm/plat-omap/opp.c
>>
>>diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
>>index 5389440..6527cdf 100644
>>--- a/Documentation/arm/OMAP/omap_pm
>>+++ b/Documentation/arm/OMAP/omap_pm
>>@@ -127,3 +127,86 @@ implementation needs:
>> 10. (*pdata->cpu_set_freq)(unsigned long f)
>>
>> 11. (*pdata->cpu_get_freq)(void)
>>+
>>+OMAP OPP Layer
>>+==============
>>+OMAP SOCs have a standard set of tuples consisting of frequency and
>>+voltage pairs that the device will support per voltage domain. This
>>+is called Operating Performance Point or OPP. The actual definitions
>>+of OMAP OPP varies over silicon within the same family of devices.
>>+For a specific domain, you can have a set of {frequency, voltage}
>>+pairs. As the kernel boots and more information is available, a set
>>+of these are activated based on the precise nature of device the kernel
>>+boots up on. It is interesting to remember that each IP which belongs
>>+to a voltage domain may define their own set of OPPs on top of this.
>>+
>>+OPP layer of its own depends on silicon specific implementation and
>>+board specific data to finalize on the final set of OPPs available
>>+in a system
>>+
>>+Initial list initialization:
>>+---------------------------
>>+The normal initialization sequence is for boardxyz_init_irq to call
>>+omap2_init_common_hw (for omap2+) and which in turn does the default
>>+setup required.
>>+
>>+Silicon specific initialization: First the OPP layer needs to be told
>>+to initialize the tables for OMAP3, there are two options here:
>>+a) If the desire is to use the default tables defined for that silicon,
>>+the board file does not need to call any initialization function, the
>>+defaults are setup as part of initialization flow when
>>+omap2_init_common_hw is called.
>>+
>>+b) board files would like to customize the default definition. In this
>>+case, board file needs to call explicitly prior to table operations.
>>+the sequence is:
>>+boardxyz_init_irq()
>>+{
>>+	... do things ..
>>+	omap3_pm_init_opp_table()
>>+	.. customizations and other things ..
>>+	omap2_init_common_hw()
>>+}
>>+1. omap3_pm_init_opp_table - this in turn calls opp_init_list for all
>>+OPP types. This is the generic silicon operating points, however, the
>>+system may have additional features or customizations required. This
>>+flexibility is provided by the following apis:
>>+
>>+Query functions:
>>+----------------
>>+Search for OPPs for various cases:
>>+2. opp_find_freq_exact - exact search function
>>+3. opp_find_freq_floor - round_up search function
>>+4. opp_find_freq_ceil - round_down search function
>>+
>>+OPP modifier functions:
>>+----------------------
>>+This allows opp layer users to add customized OPPs or change the table
>>+for any need they may have
>>+5. opp_add - add a new OPP - NOTE: use struct omap_opp_def and define
>>+the custom OPP with OMAP_OPP_DEF for usage.
>>+6. opp_enable - enable a disabled OPP
>>+7. opp_disable - disable an enabled OPP
>>+
>>+OPP Data retrieval functions:
>>+----------------------------
>>+The following sets of functions are useful for drivers to retrieve
>>+data stored in opp layer for various functions.
>>+8. opp_get_voltage - retrieve voltage for an opp
>>+9. opp_get_freq - get the frequency for an opp
>>+10. opp_get_opp_count - get number of opps enabled for a domain
>>+
>>+Cpufreq table generation:
>>+------------------------
>>+11. opp_init_cpufreq_table - this translates the OPP layer's internal
>>+OPP arrangement into a table understood and operated upon by the
>>+cpufreq layer.
>>+
>>+Data Structures:
>>+---------------
>>+struct omap_opp * is a handle structure whose internals are known only
>>+to the OPP layer and is meant to hide the complexity away from users of
>>+opp layer.
>>+
>>+struct omap_opp_def * is the definitions that users can interface with
>>+opp layer and is meant to define one OPP.
>>diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>>index 9405831..c718a0a 100644
>>--- a/arch/arm/plat-omap/Makefile
>>+++ b/arch/arm/plat-omap/Makefile
>>@@ -12,6 +12,11 @@ obj-  :=
>> # OCPI interconnect support for 1710, 1610 and 5912
>> obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>>
>>+# OPP support in (OMAP3+ only at the moment)
>>+ifdef CONFIG_PM
>>+obj-$(CONFIG_ARCH_OMAP3) += opp.o
>>+endif
>>+
>> # omap_device support (OMAP2+ only at the moment)
>> obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
>> obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
>>diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>>new file mode 100644
>>index 0000000..997b56e
>>--- /dev/null
>>+++ b/arch/arm/plat-omap/include/plat/opp.h
>>@@ -0,0 +1,145 @@
>>+/*
>>+ * OMAP OPP Interface
>>+ *
>>+ * Copyright (C) 2009-2010 Texas Instruments Incorporated.
>>+ *	Nishanth Menon
>>+ *	Romit Dasgupta <romit@ti.com>
>>+ * Copyright (C) 2009 Deep Root Systems, LLC.
>>+ *	Kevin Hilman
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License version 2 as
>>+ * published by the Free Software Foundation.
>>+ */
>>+#ifndef __ASM_ARM_OMAP_OPP_H
>>+#define __ASM_ARM_OMAP_OPP_H
>>+
>>+#include <linux/err.h>
>>+#include <linux/cpufreq.h>
>>+
>>+#include <plat/common.h>
>>+
>>+/**
>>+ * struct omap_opp_def - OMAP OPP Definition
>>+ * @hwmod_name:	Name of the hwmod for this domain
>>+ * @freq:	Frequency in hertz corresponding to this OPP
>>+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
>>+ * @enabled:	True/false - is this OPP enabled/disabled by default
>>+ *
>>+ * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
>>+ * pairs that the device will support per voltage domain. This is called
>>+ * Operating Points or OPP. The actual definitions of OMAP Operating Points
>>+ * varies over silicon within the same family of devices. For a specific
>>+ * domain, you can have a set of {frequency, voltage} pairs and this is denoted
>>+ * by an array of omap_opp_def. As the kernel boots and more information is
>>+ * available, a set of these are activated based on the precise nature of
>>+ * device the kernel boots up on. It is interesting to remember that each IP
>>+ * which belongs to a voltage domain may define their own set of OPPs on top
>>+ * of this - but this is handled by the appropriate driver.
>>+ */
>>+struct omap_opp_def {
>>+	char *hwmod_name;
>>+
>>+	unsigned long freq;
>>+	unsigned long u_volt;
>>+
>>+	bool enabled;
>>+};
>>+
>>+/*
>>+ * Initialization wrapper used to define an OPP.
>>+ * To point at the end of a terminator of a list of OPPs,
>>+ * use OMAP_OPP_DEF(NULL, 0, 0, 0)
>>+ */
>>+#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv)	\
>>+{						\
>>+	.hwmod_name	= _hwmod_name,		\
>>+	.enabled	= _enabled,		\
>>+	.freq		= _freq,		\
>>+	.u_volt		= _uv,			\
>>+}
>>+
>>+struct omap_opp;
>>+
>>+#ifdef CONFIG_PM
>>+
>>+unsigned long opp_get_voltage(const struct omap_opp *opp);
>>+
>>+unsigned long opp_get_freq(const struct omap_opp *opp);
>>+
>>+int opp_get_opp_count(struct device *dev);
>>+
>>+struct omap_opp *opp_find_freq_exact(struct device *dev,
>>+				     unsigned long freq, bool enabled);
>>+
>>+struct omap_opp *opp_find_freq_floor(struct device *dev, unsigned long *freq);
>>+
>>+struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
>>+
>>+int opp_add(const struct omap_opp_def *opp_def);
>>+
>>+int opp_enable(struct omap_opp *opp);
>>+
>>+int opp_disable(struct omap_opp *opp);
>>+
>>+void opp_init_cpufreq_table(struct device *dev,
>>+			    struct cpufreq_frequency_table **table);
>>+#else

Hello Kevin,

IN case of CONFIG_PM not being defined the else part will cause a compilation break as
the signature of these APIs defined in the else part do not match with the signature in
the if part.

>>+static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline unsigned long opp_get_freq(const struct omap_opp *opp)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline int opp_get_opp_count(struct omap_opp *oppl)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
>>+						   unsigned long freq,
>>+						   bool enabled)
>>+{
>>+	return ERR_PTR(-EINVAL);
>>+}
>>+
>>+static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
>>+						   unsigned long *freq)
>>+{
>>+	return ERR_PTR(-EINVAL);
>>+}
>>+
>>+static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
>>+						  unsigned long *freq)
>>+{
>>+	return ERR_PTR(-EINVAL);
>>+}
>>+
>>+static inline struct omap_opp *opp_add(struct omap_opp *oppl,
>>+				       const struct omap_opp_def *opp_def)
>>+{
>>+	return ERR_PTR(-EINVAL);
>>+}
>>+
>>+static inline int opp_enable(struct omap_opp *opp)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline int opp_disable(struct omap_opp *opp)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline
>>+void opp_init_cpufreq_table(struct omap_opp *opps,
>>+			    struct cpufreq_frequency_table **table)
>>+{
>>+}
>>+
>>+#endif		/* CONFIG_PM */
>>+#endif		/* __ASM_ARM_OMAP_OPP_H */

<snip>

Regards
Thara
