From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/09] OMAP PM srf implementation
Date: Tue, 8 Jul 2008 17:09:26 +0530
Message-ID: <030b01c8e0ef$46c859c0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58800 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbYGHLjf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdR46001873
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:33 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxJ005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:26 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the SRF calls into OMAP PM skeleton layer developed by Paul Walmsley

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/Makefile            |    3 
 arch/arm/mach-omap2/clockdomain.c       |    7 
 arch/arm/mach-omap2/io.c                |    4 
 arch/arm/plat-omap/Kconfig              |   16 +
 arch/arm/plat-omap/Makefile             |    3 
 arch/arm/plat-omap/omap-pm-srf.c        |  464 ++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/powerdomain.h |    1 
 7 files changed, 497 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	2008-07-07 15:05:50.562925276 +0530
@@ -0,0 +1,464 @@
+/*
+ * omap-pm-srf.c - OMAP power management interface implemented
+ * using Shared resource framework
+ *
+ * This code implements the OMAP power management interface to drivers,
+ * CPUIdle, CPUFreq, and DSP bridge.
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Amish Lakhani, Tony Lindgren, Rajendra Nayak, Sakari
+ * Poussa, Veeramanikandan Raju, Igor Stoppa, Paul Walmsley, Richard
+ * Woodruff
+ *
+ * Interfaces defined by Paul Walmsley
+ * Updated with SRF calls by Rajendra Nayak
+ */
+
+#undef DEBUG
+
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+
+#include <asm/arch/omap-pm.h>
+#include <asm/arch/powerdomain.h>
+#include <asm/arch/resource.h>
+/*
+#include <asm/arch/tiocp.h>
+*/
+
+#define LAT_RES_POSTAMBLE "_latency"
+char latency_res_name[30];
+/* lat_name_mutex protects latency_res_name*/
+static DEFINE_MUTEX(lat_name_mutex);
+
+
+/**
+ * get_lat_res_name - gets the latency resource name given a power domain name
+ * @pwrdm_name: Name of the power domain.
+ *
+ * Returns a pointer to the latency resource name.
+ */
+static char *get_lat_res_name(const char *pwrdm_name)
+{
+	strcpy(latency_res_name, "");
+	if (!(in_atomic() || irqs_disabled()))
+		mutex_lock(&lat_name_mutex);
+	WARN_ON(strlen(pwrdm_name) + strlen(LAT_RES_POSTAMBLE) >
+					 sizeof(latency_res_name));
+	strcpy(latency_res_name, pwrdm_name);
+	strcat(latency_res_name, LAT_RES_POSTAMBLE);
+	if (!(in_atomic() || irqs_disabled()))
+		mutex_unlock(&lat_name_mutex);
+	return latency_res_name;
+}
+
+void omap_pm_exit(void)
+{
+	return;
+}
+
+/*
+ * Device-driver-originated constraints (via board-*.c files)
+ */
+
+/**
+ * omap_pm_set_max_cpu_lat - set maximum CPU interrupt latency for this device
+ * @dev: struct device *
+ * @t: maximum interrupt latency in microseconds
+ *
+ * Request that the maximum interrupt latency for this device
+ * 'dev' should be no greater than 't' microseconds.  "Interrupt latency"
+ * in this case is defined as the elapsed time from the occurrence of a
+ * hardware or timer interrupt to the time when the device driver has
+ * completed executing any code necessary to avoid underflow conditions,
+ * etc.
+ *
+ * It is intended that underlying PM code will use this information to
+ * determine what power state to put the MPU powerdomain into, and
+ * possibly the CORE powerdomain as well, since interrupt handling
+ * code currently runs from SDRAM.  Advanced PM or board*.c code may
+ * also configure interrupt controller priorities, OCP bus priorities,
+ * CPU speed(s), etc.
+ *
+ * This function will not affect device wakeup latency, e.g., time
+ * elapsed from when a device driver enables a hardware device with
+ * clk_enable(), to when the device is ready for register access or
+ * other use.  To control this device wakeup latency, use
+ * set_max_dev_wakeup_lat()
+ *
+ * Multiple calls to set_max_cpu_lat() will replace the previous t
+ * value for this device.  To remove the latency target for this device,
+ * call with t = -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_cpu_lat(struct device *dev, long t)
+{
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t == -1) {
+		pr_debug("OMAP PM: remove max CPU latency constraint: "
+			 "dev %p\n", dev);
+		resource_release("mpu_latency", dev);
+	} else {
+		pr_debug("OMAP PM: add max CPU latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+		resource_request("mpu_latency", dev, t);
+	}
+}
+
+/**
+ * omap_pm_set_min_bus_tput - set minimum bus throughput needed by device
+ * @dev: struct device *
+ * @bus: struct bus_type * to set the minimum throughput for this device
+ * @r: minimum throughput (in KiB/s)
+ *
+ * Request that the minimum data throughput on bus 'bus' available to
+ * this device be no less than 'r' KiB/s.  The struct bus * parameter
+ * is necessary since some devices may be connected to multiple buses,
+ * e.g., on OMAP, L3 and one of the L4 buses.
+ *
+ * It is intended that the OMAP PM or bus code will use this
+ * information to set the bus clock to run at the lowest possible
+ * speed that satisfies all current system users.  The PM or bus code
+ * will adjust the estimate based on its model of the bus, so device
+ * driver authors should attempt to specify an accurate quantity for their
+ * device use case, and let the PM or bus code overestimate the numbers
+ * as necessary to handle request/response latency, other competing users
+ * on the system, etc.
+ *
+ * Multiple calls to set_min_bus_throughput() will replace the
+ * previous rate value for this device.  To remove the bus throughput
+ * restriction for this device, call with r = 0.
+ *
+ * No return value.
+ */
+void omap_pm_set_min_bus_tput(struct device *dev, struct bus_type *bus,
+				    unsigned long r)
+{
+	if (!dev) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (r == 0)
+		pr_debug("OMAP PM: remove min bus tput constraint: "
+			 "dev %p for bus %s\n", dev, bus->name);
+	else
+		pr_debug("OMAP PM: add min bus tput constraint: "
+			 "dev %p for bus %s: rate %ld KiB\n", dev,
+			 bus->name, r);
+
+	/*
+	 * This code should model the bus and compute the required
+	 * bus frequency, convert that to a VDD2 OPP ID, then set the VDD2
+	 * OPP appropriately.
+	 *
+	 * TI CDP code can call constraint_set here on the VDD2 OPP.
+	 */
+}
+
+/**
+ * omap_pm_set_max_dev_wakeup_lat - set the maximum device enable latency
+ * @dev: struct device *
+ * @t: maximum device wakeup latency in microseconds
+ *
+ * Request that the maximum amount of time necessary for a device to
+ * become accessible after its clocks are enabled should be no greater
+ * than 't' microseconds.  Specifically, this represents the time from
+ * when a device driver enables device clocks with clk_enable(), to
+ * when the register reads and writes on the device will succeed.
+ * This function should be called before clk_disable() is called,
+ * since the power state transition decision may be made during
+ * clk_disable().
+ *
+ * It is intended that underlying PM code will use this information to
+ * determine what power state to put the powerdomain enclosing this device
+ * into.
+ *
+ * This function will not affect MPU interrupt latency for this device.
+ * To set that, use set_max_cpu_lat().
+ *
+ * Multiple calls to set_max_dev_wakeup_lat() will replace the
+ * previous wakeup latency values for this device.  To remove the wakeup
+ * latency restriction for this device, call with t = -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
+{
+	/* struct tiocp *tiocp_dev; */
+	struct powerdomain *pwrdm_dev;
+	char *res_name;
+
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	/* Look for the devices Power Domain */
+	/* TODO: Put this back in once tiocp layer is available
+	tiocp_dev = container_of(dev, struct tiocp, dev);
+	pwrdm_dev = tiocp_dev->pwrdm;
+	*/
+
+	if (t == -1) {
+		pr_debug("OMAP PM: remove max device latency constraint: "
+			 "dev %p\n", dev);
+		res_name = get_lat_res_name(pwrdm_dev->name);
+		resource_release(res_name, dev);
+	} else {
+		pr_debug("OMAP PM: add max device latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+		res_name = get_lat_res_name(pwrdm_dev->name);
+		resource_request(res_name, dev, t);
+	}
+
+}
+
+/**
+ * omap_pm_set_max_dma_lat - set the maximum DMA transfer start latency
+ * @dev: struct device *
+ * @t: maximum DMA transfer start latency in microseconds
+ *
+ * Request that the maximum DMA transfer start latency for this device
+ * 'dev' should be no greater than 't' microseconds.  "DMA transfer
+ * start latency" here is defined as the elapsed time from when a
+ * device (e.g., McBSP) requests that a DMA transfer start or continue,
+ * to the time at which data starts to flow into that device from the
+ * DMA controller.
+ *
+ * It is intended that underlying PM code will use this information to
+ * determine what power state to put the CORE powerdomain into.
+ *
+ * Since DMA transfers may not involve the MPU, this function will not
+ * affect MPU wakeup latency.  Use set_max_cpu_lat() to do so.
+ * Similarly, this function will not affect device wakeup latency --
+ * use set_max_dev_wakeup_lat() to affect that.
+ *
+ * Multiple calls to set_max_dma_lat() will replace the previous t
+ * value for this device.  To remove the maximum DMA latency for this
+ * device, call with t = -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_dma_lat(struct device *dev, long t)
+{
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t == -1) {
+		pr_debug("OMAP PM: remove max DMA latency constraint: "
+			 "dev %p\n", dev);
+		resource_release("core_latency", dev);
+	} else {
+		pr_debug("OMAP PM: add max DMA latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+		resource_request("core_latency", dev, t);
+	}
+}
+
+
+/*
+ * DSP Bridge-specific constraints
+ */
+
+/**
+ * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Bridge
+ * @opp_id: target DSP OPP ID
+ *
+ * Set a minimum OPP ID for the DSP.  This is intended to be called
+ * only from the DSP Bridge MPU-side driver.  Unfortunately, the only
+ * information that code receives from the DSP/BIOS load estimator is the
+ * target OPP ID; hence, this interface.  No return value.
+ */
+void omap_pm_dsp_set_min_opp(u8 opp_id)
+{
+	if (opp_id == 0) {
+		WARN_ON(1);
+		return;
+	}
+
+	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
+
+	/*
+	 *
+	 * For l-o dev tree, our VDD1 clk is keyed on OPP ID, so we
+	 * can just test to see which is higher, the CPU's desired OPP
+	 * ID or the DSP's desired OPP ID, and use whichever is
+	 * highest.
+	 *
+	 * In CDP12.14+, the VDD1 OPP custom clock that controls the DSP
+	 * rate is keyed on MPU speed, not the OPP ID.  So we need to
+	 * map the OPP ID to the MPU speed for use with clk_set_rate()
+	 * if it is higher than the current OPP clock rate.
+	 *
+	 */
+}
+
+/**
+ * omap_pm_dsp_get_opp - report the current DSP OPP ID
+ *
+ * Report the current OPP for the DSP.  Since on OMAP3, the DSP and
+ * MPU share a single voltage domain, the OPP ID returned back may
+ * represent a higher DSP speed than the OPP requested via
+ * omap_pm_dsp_set_min_opp().
+ *
+ * Returns the current VDD1 OPP ID, or 0 upon error.
+ */
+u8 omap_pm_dsp_get_opp(void)
+{
+	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
+
+	/*
+	 * For l-o dev tree, call clk_get_rate() on VDD1 OPP clock
+	 *
+	 * CDP12.14+:
+	 * Call clk_get_rate() on the OPP custom clock, map that to an
+	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
+	 */
+
+	return 0;
+}
+
+/*
+ * CPUFreq-originated constraint
+ *
+ * In the future, this should be handled by custom OPP clocktype
+ * functions.
+ */
+
+/**
+ * omap_pm_cpu_get_freq_table - return a cpufreq_frequency_table array ptr
+ *
+ * Provide a frequency table usable by CPUFreq for the current chip/board.
+ * Returns a pointer to a struct cpufreq_frequency_table array or NULL
+ * upon error.
+ */
+struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
+{
+	pr_debug("OMAP PM: CPUFreq request for frequency table\n");
+
+	return NULL;
+}
+
+/**
+ * omap_pm_cpu_set_freq - set the current minimum MPU frequency
+ * @f: MPU frequency in Hz
+ *
+ * Set the current minimum CPU frequency.  The actual CPU frequency
+ * used could end up higher if the DSP requested a higher OPP.
+ * Intended to be called by plat-omap/cpu_omap.c:omap_target().  No
+ * return value.
+ */
+void omap_pm_cpu_set_freq(unsigned long f)
+{
+	if (f == 0) {
+		WARN_ON(1);
+		return;
+	}
+
+	pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\n",
+		 f);
+
+	/*
+	 * For l-o dev tree, determine whether MPU freq or DSP OPP id
+	 * freq is higher.  Find the OPP ID corresponding to the
+	 * higher frequency.  Call clk_round_rate() and clk_set_rate()
+	 * on the OPP custom clock.
+	 *
+	 * CDP should just be able to set the VDD1 OPP clock rate here.
+	 */
+}
+
+/**
+ * omap_pm_cpu_get_freq - report the current CPU frequency
+ *
+ * Returns the current MPU frequency, or 0 upon error.
+ */
+unsigned long omap_pm_cpu_get_freq(void)
+{
+	pr_debug("OMAP PM: CPUFreq requests current CPU frequency\n");
+
+	/*
+	 * Call clk_get_rate() on the mpu_ck.
+	 */
+
+	return 0;
+}
+
+struct device omap_pm_dev;
+
+/*
+ * Powerdomain usecounting hooks
+ */
+
+/**
+ * omap_pm_pwrdm_active - indicate that a power domain has become active
+ * @pwrdm: struct powerdomain *
+ *
+ * Notify the OMAP PM layer that the power domain 'pwrdm' has become active,
+ * presumably due to a device driver enabling an underlying clock.  This
+ * function is intended to be called by a clockdomain node in the clock
+ * framework.  No return value.
+ */
+void omap_pm_pwrdm_active(struct powerdomain *pwrdm)
+{
+	char *res_name;
+
+	if (!pwrdm) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
+			 !strcmp(pwrdm->name, "core_pwrdm"))
+		return;
+
+	pr_debug("OMAP PM: powerdomain %s is becoming active\n", pwrdm->name);
+
+	res_name = get_lat_res_name(pwrdm->name);
+	/* Request for a zero latency which puts the Power Domain in ON state*/
+	resource_request(res_name, &omap_pm_dev, 0);
+	return;
+}
+
+/**
+ * omap_pm_pwrdm_inactive - indicate that a power domain has become inactive
+ * @pwrdm: struct powerdomain *
+ *
+ * Notify the OMAP PM layer that the power domain 'pwrdm' has become
+ * inactive, presumably due to a device driver disabling an underlying
+ * clock.  This function is intended to be called by a clockdomain
+ * node in the clock framework.  No return value.
+ */
+void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm)
+{
+	char *res_name;
+
+	if (!pwrdm) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (!strcmp(pwrdm->name, "wkup_pwrdm") ||
+			!strcmp(pwrdm->name, "core_pwrdm"))
+		return;
+
+	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
+		 pwrdm->name);
+
+	res_name = get_lat_res_name(pwrdm->name);
+	/* Release the latency requested */
+	resource_release(res_name, &omap_pm_dev);
+	return;
+}
Index: linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clockdomain.c	2008-07-07 15:05:45.628084511 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c	2008-07-07 15:05:50.562925276 +0530
@@ -35,6 +35,7 @@
 
 #include <asm/arch/powerdomain.h>
 #include <asm/arch/clockdomain.h>
+#include <asm/arch/omap-pm.h>
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
@@ -567,6 +568,9 @@ int omap2_clkdm_clk_enable(struct clockd
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	/*Hook to inform the OMAP PM layer that the pwrdm has become active */
+	omap_pm_pwrdm_active(clkdm->pwrdm);
+
 	return 0;
 }
 
@@ -618,6 +622,9 @@ int omap2_clkdm_clk_disable(struct clock
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	/*Hook to inform the OMAP PM layer that the pwrdm has become inactive */
+	omap_pm_pwrdm_inactive(clkdm->pwrdm);
+
 	return 0;
 }
 
Index: linux-omap-2.6/include/asm-arm/arch-omap/powerdomain.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/powerdomain.h	2008-07-07 15:05:45.627084544 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/powerdomain.h	2008-07-07 15:05:50.562925276 +0530
@@ -148,6 +148,7 @@ int pwrdm_read_next_pwrst(struct powerdo
 int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2008-07-07 15:05:45.628084511 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2008-07-07 15:05:50.563925243 +0530
@@ -29,7 +29,8 @@ obj-$(CONFIG_OMAP_SMARTREFLEX)		+= smart
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o \
+					   resource34xx.o
 
 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
Index: linux-omap-2.6/arch/arm/mach-omap2/io.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/io.c	2008-07-07 15:05:45.628084511 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/io.c	2008-07-07 15:10:41.256548857 +0530
@@ -37,6 +37,7 @@
 
 #include <asm/arch/clockdomain.h>
 #include "clockdomains.h"
+#include "resource34xx.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -200,6 +201,9 @@ void __init omap2_init_common_hw(void)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+#ifdef CONFIG_OMAP_PM_SRF
+	resource_init(resources_omap);
+#endif
 	omap2_init_memory();
 	gpmc_init();
 }
Index: linux-omap-2.6/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/Kconfig	2008-07-07 15:05:45.627084544 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/Kconfig	2008-07-07 15:05:50.563925243 +0530
@@ -247,4 +247,20 @@ config OMAP_SERIAL_WAKE
 
 endmenu
 
+choice
+	prompt "OMAP PM layer selection"
+	depends on ARCH_OMAP
+	default OMAP_PM_NOOP
+
+config OMAP_PM_NONE
+	bool "No PM layer"
+
+config OMAP_PM_NOOP
+	bool "No-op/debug PM layer"
+
+config OMAP_PM_SRF
+	bool "PM layer implemented using SRF"
+
+endchoice
+
 endif
Index: linux-omap-2.6/arch/arm/plat-omap/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/Makefile	2008-07-07 15:05:45.627084544 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/Makefile	2008-07-07 15:05:50.563925243 +0530
@@ -29,3 +29,6 @@ obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
+obj-$(CONFIG_OMAP_PM_SRF) += omap-pm-srf.o \
+			     resource.o

