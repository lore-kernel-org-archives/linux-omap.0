From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP: PM: Fix boot with OMAP_SMARTREFLEX and OMAP_PM_NONE
Date: Tue, 28 Apr 2009 12:37:47 +0300
Message-ID: <1240911467-12269-3-git-send-email-ext-roger.quadros@nokia.com>
References: <1240911467-12269-1-git-send-email-ext-roger.quadros@nokia.com>
 <1240911467-12269-2-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40963 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbZD1Jij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 05:38:39 -0400
In-Reply-To: <1240911467-12269-2-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, ext-roger.quadros@nokia.com

Return sane values for all *_get_opp() and *_get_freq() functions with
OMAP_PM_NONE selected.
Other modules e.g. Smartreflex will be requiring sane values of OPP
and CPU Frequency irrespective of the PM layer being used.

Added file arch/arm/plat-omap/omap-pm-none.c

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/Makefile              |    1 +
 arch/arm/plat-omap/Makefile               |    2 +
 arch/arm/plat-omap/common.c               |    5 --
 arch/arm/plat-omap/include/mach/omap-pm.h |   52 +++++++++++++++++---
 arch/arm/plat-omap/omap-pm-none.c         |   74 +++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-none.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b82df3f..383ed61 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
 obj-$(CONFIG_OMAP_PM_NOOP)		+=  resource34xx.o
+obj-$(CONFIG_OMAP_PM_NONE)		+=  resource34xx.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 038cdaf..20ac1b3 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o \
 				resource.o
 obj-$(CONFIG_OMAP_PM_SRF) += omap-pm-srf.o \
 				resource.o
+obj-$(CONFIG_OMAP_PM_NONE) += omap-pm-none.o \
+				resource.o
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 634ca39..4c9fdd0 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -46,11 +46,6 @@ int omap_bootloader_tag_len;
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 
-#ifdef CONFIG_OMAP_PM_NONE
-struct omap_opp *mpu_opps;
-struct omap_opp *dsp_opps;
-struct omap_opp *l3_opps;
-#endif
 
 #ifdef CONFIG_OMAP_BOOT_TAG
 
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-omap/include/mach/omap-pm.h
index f690a05..3edb665 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -58,13 +58,9 @@ extern struct omap_opp *l3_opps;
  * framework starts.  The "_if_" is to avoid name collisions with the
  * PM idle-loop code.
  */
-#ifdef CONFIG_OMAP_PM_NONE
-#define omap_pm_if_early_init(a, b, c) 0
-#else
 int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
 				 struct omap_opp *dsp_opp_table,
 				 struct omap_opp *l3_opp_table);
-#endif
 
 /**
  * omap_pm_if_init - OMAP PM init code called after clock fw init
@@ -72,11 +68,7 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
  * The main initialization code.  OPP tables are passed in here.  The
  * "_if_" is to avoid name collisions with the PM idle-loop code.
  */
-#ifdef CONFIG_OMAP_PM_NONE
-#define omap_pm_if_init() 0
-#else
 int __init omap_pm_if_init(void);
-#endif
 
 /**
  * omap_pm_if_exit - OMAP PM exit code
@@ -121,7 +113,11 @@ void omap_pm_if_exit(void);
  *
  * No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t) { }
+#else
 void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
+#endif
 
 
 /**
@@ -152,7 +148,11 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
  *
  * No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r) { }
+#else
 void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
+#endif
 
 
 /**
@@ -179,7 +179,11 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
  *
  * No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t) { }
+#else
 void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
+#endif
 
 
 /**
@@ -208,7 +212,11 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
  *
  * No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_set_max_sdma_lat(struct device *dev, long t) { }
+#else
 void omap_pm_set_max_sdma_lat(struct device *dev, long t);
+#endif
 
 
 /*
@@ -222,7 +230,11 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long t);
  * frequency entries.  The final item in the array should have .rate =
  * .opp_id = 0.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline const struct omap_opp *omap_pm_dsp_get_opp_table(void) { return NULL; }
+#else
 const struct omap_opp *omap_pm_dsp_get_opp_table(void);
+#endif
 
 /**
  * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Bridge
@@ -233,7 +245,11 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void);
  * information that code receives from the DSP/BIOS load estimator is the
  * target OPP ID; hence, this interface.  No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_dsp_set_min_opp(u8 opp_id) { }
+#else
 void omap_pm_dsp_set_min_opp(u8 opp_id);
+#endif
 
 /**
  * omap_pm_dsp_get_opp - report the current DSP OPP ID
@@ -279,7 +295,11 @@ u8 omap_pm_vdd2_get_opp(void);
  * Returns a pointer to a struct cpufreq_frequency_table array or NULL
  * upon error.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void) { return NULL; }
+#else
 struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
+#endif
 
 /**
  * omap_pm_cpu_set_freq - set the current minimum MPU frequency
@@ -290,7 +310,11 @@ struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
  * Intended to be called by plat-omap/cpu_omap.c:omap_target().  No
  * return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_cpu_set_freq(unsigned long f) { }
+#else
 void omap_pm_cpu_set_freq(unsigned long f);
+#endif
 
 /**
  * omap_pm_cpu_get_freq - report the current CPU frequency
@@ -320,7 +344,11 @@ unsigned long omap_pm_cpu_get_freq(void);
  * continue counting.  Returns the number of context losses for this device,
  * or -EINVAL upon error.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline int omap_pm_get_dev_context_loss_count(struct device *dev) { return 0; }
+#else
 int omap_pm_get_dev_context_loss_count(struct device *dev);
+#endif
 
 
 /*
@@ -336,7 +364,11 @@ int omap_pm_get_dev_context_loss_count(struct device *dev);
  * function is intended to be called by the clockdomain code, not by drivers.
  * No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_pwrdm_active(struct powerdomain *pwrdm) { }
+#else
 void omap_pm_pwrdm_active(struct powerdomain *pwrdm);
+#endif
 
 
 /**
@@ -348,6 +380,10 @@ void omap_pm_pwrdm_active(struct powerdomain *pwrdm);
  * clock.  This function is intended to be called by the clockdomain
  * code, not by drivers.  No return value.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+static inline void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm) { }
+#else
 void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm);
+#endif
 
 #endif
diff --git a/arch/arm/plat-omap/omap-pm-none.c b/arch/arm/plat-omap/omap-pm-none.c
new file mode 100644
index 0000000..a47f037
--- /dev/null
+++ b/arch/arm/plat-omap/omap-pm-none.c
@@ -0,0 +1,74 @@
+/*
+ * omap-pm-none.c - OMAP power management interface - PM_NONE version
+ *
+ * This code implements the OMAP power management interface to
+ * drivers, CPUIdle, CPUFreq, and DSP Bridge.
+ * It implements a dummy interface for setting/changing resources
+ * but it returns valid values while querying CPU frequncy and DSP OPP.
+ *
+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veeramanikandan
+ * Raju, Anand Sawant, Igor Stoppa, Paul Walmsley, Richard Woodruff
+ */
+
+#undef DEBUG
+
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+
+/* Interface documentation is in mach/omap-pm.h */
+#include <mach/omap-pm.h>
+#include <mach/resource.h>
+#include <mach/powerdomain.h>
+
+struct omap_opp *dsp_opps;
+struct omap_opp *mpu_opps;
+struct omap_opp *l3_opps;
+
+u8 omap_pm_dsp_get_opp(void)
+{
+	return resource_get_level("vdd1_opp");
+}
+
+u8 omap_pm_vdd1_get_opp(void)
+{
+	return resource_get_level("vdd1_opp");
+}
+
+u8 omap_pm_vdd2_get_opp(void)
+{
+	return resource_get_level("vdd2_opp");
+}
+
+unsigned long omap_pm_cpu_get_freq(void)
+{
+	return resource_get_level("mpu_freq");
+}
+
+/*
+ * Should be called before clk framework since clk fw will call
+ * omap_pm_pwrdm_{in,}active()
+ */
+int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
+				 struct omap_opp *dsp_opp_table,
+				 struct omap_opp *l3_opp_table)
+{
+	mpu_opps = mpu_opp_table;
+	dsp_opps = dsp_opp_table;
+	l3_opps = l3_opp_table;
+	return 0;
+}
+
+/* Must be called after clock framework is initialized */
+int __init omap_pm_if_init(void)
+{
+	resource_init(resources_omap);
+	return 0;
+}
+
+void omap_pm_if_exit(void)
+{
+	/* Deallocate CPUFreq frequency table here */
+}
+
-- 
1.6.0.4

