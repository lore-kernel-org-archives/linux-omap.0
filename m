From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC/PATCH] OMAP PM interface
Date: Tue, 29 Apr 2008 01:32:14 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804290119480.5853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33408 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbYD2HcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 03:32:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.poussa@nokia.com, sawant@ti.com, karthik-dp@ti.com, igor.stoppa@nokia.com, tony@atomide.com, r-woodruff2@ti.com, veera@ti.com, rnayak@ti.com


Hello,

This message proposes a power management interface (the "OMAP PM 
interface") for the linux-omap kernel tree.  It includes a general device 
driver PM interface, along with some specialized interfaces for CPUFreq, 
DSP/Bridge, and the powerdomain/clockdomain code.  This message focuses on 
the general device driver portion, since it is most relevant to the larger 
community of OMAP device driver developers.

To summarize, this interface is intended to allow drivers to take
advantage of OMAP power management features:

- without locking drivers into a particular underlying implementation;

- without adding constraints that are specific to particular OMAP 
  variants; and

- without affecting other architectures.


The device driver portion of the interface currently covers the
following four types of PM constraints:

1. Set the maximum MPU interrupt response latency (MPU pwrdm);

2. Set the maximum DMA transfer start latency (CORE pwrdm);

3. Set the minimum bus throughput needed by a device;

4. Set the maximum device wakeup latency.

These are described in more detail below, along with a detailed rationale.


Included below is a 'no-op' implementation that documents the
interface and emits debug messages.  TI has also developed an initial
implementation of the OMAP PM interface that relies on the Shared
Resource Framework.  And also under development is an implementation
of the OMAP PM code that uses the existing Linux PM QOS code.

This interface was created by reviewing the current constraints in use
by drivers in the TI CDP 12.14 tree and reformulating the underlying
intention in terms of measurable quantities (latency or throughput).
It is a collaborative product of many people from Nokia and TI:
Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa,
Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul Walmsley, and
Richard Woodruff.


Comments welcomed,

- Paul



Existing PM interfaces are currently not ideal for OMAP
-------------------------------------------------------

There are currently two PM interfaces in use with publicly-distributed
OMAP Linux code: the TI Shared Resource Framework (SRF) and the
Linux PM QOS parameters code.  Neither interface is ideal for Linux
OMAP code, for reasons described below.

TI Shared Resource Framework:

The TI CDP 12.14 tree drivers currently use the TI Shared Resource
Framework (SRF) to control chip power management.  Use of the SRF
allowed TI to get the drivers up and running quickly with considerable
power savings; and the SRF provided debugging support.  However, many
of the SRF parameters are specified in OMAP-specific terms, such as
target OPPs, rather than in terms of actual latency or throughput
requirements.  OPPs change depending on OMAP silicon revisions or OMAP
types, and are meaningless for other architectures, so drivers shared
between OMAP and other architectures would also have to #ifdef out the
SRF constraints.

Linux PM QOS parameters:

As of February, the mainline Linux kernel contains code that is
somewhat similar to the SRF: the Linux PM QOS parameters code, located
in kernel/pm_qos_params.c.  (This code replaced the latency management
code that was present in earlier kernels.)  Ideally, OMAP drivers
would be able to use this Linux PM QOS code directly, but the current
PM QOS code has some drawbacks:

- It combines some power management parameters that should be kept
  separate for maximum power savings on OMAP3.  For example, in the PM
  QOS code, CPU and DMA wakeup latency are combined into one
  parameter; but on OMAP3, these are distinct parameters.  The Linux
  PM QOS code also combines all network power management knobs into
  two non-device-specific parameters.  OMAP2/3 systems can have
  different network devices with different power management
  requirements - for example, a wired Ethernet interface may have
  different latency and throughput constraints than a wireless Ethernet
  interface.

- It does not yet cover all of the power management capabilities of
  the OMAP3 architecture.  It does not express latency constraints on
  a per-device or per-powerdomain basis; it only covers
  cpu_dma_latency and network throughput and latency, which would not
  cover most of the OMAP3 devices.

The result is that drivers using the current Linux PM QOS layer
directly are unlikely to reach the same level of power efficiency as
driver code using the Shared Resource Framework.

To summarize, the SRF provides significant power savings, but
expresses power constraints in an OMAP- and silicon-revision-specific
way; and the PM QOS layer expresses PM constraints in a cross-platform
manner (in terms of fundamental physical units), but does not support
per-powerdomain constraints and does not cover many of the OMAP power
management features.


An alternative: the OMAP PM interface
-------------------------------------

We need a way for driver code to express PM parameters which:

- supports the range of power management parameters present in the TI SRF;

- separates the drivers from the underlying PM parameter
  implementation, whether it is the TI SRF or Linux PM QOS or Linux
  latency framework or something else;

- specifies PM parameters in terms of fundamental units, such as
  latency and throughput, rather than units which are specific to OMAP
  or to particular OMAP variants;

- allows drivers which are shared with other architectures (e.g.,
  DaVinci) to add these constraints in a way which won't affect non-OMAP
  systems,

- can be implemented immediately with minimal disruption of other
  architectures.


We therefore propose the OMAP PM interface, including the following
four power management functions for driver code:

1. Set the maximum MPU interrupt response latency (MPU pwrdm):
   pdata->set_max_intr_lat(struct device *dev, long t)

2. Set the maximum DMA transfer start latency (CORE pwrdm):
   pdata->set_max_dma_lat(struct device *dev, long t)

3. Set the minimum bus throughput needed by a device:
   pdata->set_min_bus_tput(struct device *dev, struct bus *bus, unsigned long r)

4. Set the maximum device wakeup latency:
   pdata->set_max_dev_wakeup_lat(struct device *dev, unsigned long t)


These functions are extensively documented in the no-op OMAP PM layer 
below.


Driver usage of the OMAP PM functions
-------------------------------------

As the 'pdata' in the above examples indicates, we expose these
functions to drivers through function pointers in driver
.platform_data structures.  The function pointers are initialized by
the board-*.c files to point to the corresponding OMAP PM functions:
.set_max_cpu_lat will point to omap_pm_set_max_cpu_lat(), etc.  Other
architectures which do not support these functions should leave these
function pointers set to NULL.  So drivers should use the following
idiom:

        if (pdata->set_max_cpu_lat)
            pdata->set_max_cpu_lat(dev, t);

The most common usage of these functions will probably be to specify
the maximum time from when an interrupt occurs, to when the device
becomes accessible.  To accomplish this, driver writers should use
both the set_max_cpu_lat() function (which constrains the MPU wakeup
latency) and the set_max_dev_wakeup_lat() function (which constrains
the device wakeup latency (from clk_enable() to accessibility).  For
example,

        if (pdata->set_max_cpu_lat)
            pdata->set_max_cpu_lat(dev, t);
        if (pdata->set_max_dev_wakeup_lat)
            pdata->set_max_dev_wakeup_lat(dev, t);

These PM parameters can be overwritten by calling the function again
with the new value.  The settings can be removed by calling the
function with a t argument of -1 (except in the case of
set_max_bus_tput(), which should be called with an r argument of 0).


Other specialized interface functions
-------------------------------------

The four functions listed above are intended to be usable by any
device driver.  DSP Bridge and CPUFreq, however, have special
requirements.  DSP Bridge expresses target DSP performance levels in
terms of OPP IDs.  CPUFreq expresses target MPU performance levels in
terms of MPU frequency.  So the OMAP PM interface contains functions
for these specialized cases to convert that input information
(OPPs/MPU frequency) into whatever form the underlying power
management implementation needs.  Additionally, there are also
functions for the clockdomain layer to use to indicate that a
powerdomain should wake up or be put to sleep.

These functions are not discussed in this summary, but are documented
in the included sample code.


The OMAP PM layer is intended to be temporary
---------------------------------------------

It's likely that in time, the Linux PM QOS layer will support the
range of power management features present in OMAP3.  As this happens,
existing drivers using the OMAP PM interface can be modified to use
the Linux PM QOS code.


-----------------------------------------------------------------------------

Patch follows.

---

 arch/arm/mach-omap2/io.c            |    3 
 arch/arm/plat-omap/Kconfig          |   13 +
 arch/arm/plat-omap/Makefile         |    1 
 arch/arm/plat-omap/omap-pm-noop.c   |  452 +++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/omap-pm.h |   42 +++
 5 files changed, 511 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c
 create mode 100644 include/asm-arm/arch-omap/omap-pm.h


diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa319a5..2b4c204 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,6 +34,8 @@
 #include <asm/arch/clockdomain.h>
 #include "clockdomains.h"
 
+#include <asm/arch/omap-pm.h>
+
 extern void omap_sram_init(void);
 extern int omap2_clk_init(void);
 extern void omap2_check_revision(void);
@@ -198,6 +200,7 @@ void __init omap2_init_common_hw(void)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+	omap_pm_init();
 	omap2_init_memory();
 	gpmc_init();
 }
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ba858a8..d8e8485 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -226,4 +226,17 @@ config OMAP_SERIAL_WAKE
 
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
+endchoice
+
 endif
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a3f1f5c..09d195b 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
\ No newline at end of file
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
new file mode 100644
index 0000000..c19b561
--- /dev/null
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -0,0 +1,452 @@
+/*
+ * omap-pm-noop.c - OMAP power management interface - dummy version
+ *
+ * This code implements the OMAP power management interface to drivers,
+ * CPUIdle, CPUFreq, and DSP bridge.  It is strictly for debug/demonstration
+ * use, as it does nothing but printk() whenever a function is called (when
+ * DEBUG is defined, below)
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Amish Lakhani, Tony Lindgren, Rajendra Nayak, Sakari
+ * Poussa, Veeramanikandan Raju, Igor Stoppa, Paul Walmsley, Richard
+ * Woodruff
+ *
+ * Written by Paul Walmsley
+ */
+
+#undef DEBUG
+
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+
+#include <asm/arch/omap-pm.h>
+
+#include <asm/arch/powerdomain.h>
+
+static int __init omap_pm_init(void)
+{
+	/*
+	 * Allocate and build CPUFreq frequency table here: loop over
+	 * all VDD1 clkrates, pull out the mpu_ck frequencies, build
+	 * table
+	 */
+
+	return 0;
+}
+arch_initcall(omap_pm_init);
+
+void omap_pm_exit(void)
+{
+	/* Deallocate CPUFreq frequency table here */
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
+	if (t == -1)
+		pr_debug("OMAP PM: remove max CPU latency constraint: "
+			 "dev %p\n", dev);
+	else
+		pr_debug("OMAP PM: add max CPU latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+
+	/*
+	 * For current Linux PM QOS params,
+	 * this code should scan the list of maximum CPU and DMA
+	 * latencies and select the smallest, then set cpu_dma_latency
+	 * pm_qos_param accordingly.
+	 *
+	 * For future Linux PM QOS params, with separate CPU and DMA
+	 * latency params, this code should just set the cpu_latency param.
+	 *
+	 * TI CDP code can call constraint_set here.
+	 */
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
+ * Multiple calls to set_min_bus_tput() will replace the
+ * previous rate value for this device.  To remove the bus throughput
+ * restriction for this device, call with r = 0.
+ *
+ * No return value.
+ */
+void omap_pm_set_min_bus_tput(struct device *dev, struct bus_type *bus,
+			      unsigned long r)
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
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t == -1)
+		pr_debug("OMAP PM: remove max device latency constraint: "
+			 "dev %p\n", dev);
+	else
+		pr_debug("OMAP PM: add max device latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+
+	/*
+	 * For current Linux, this needs to map the device to a
+	 * powerdomain, then go through the list of current max lat
+	 * constraints on that powerdomain and find the smallest.  If
+	 * the latency constraint has changed, the code should
+	 * recompute the state to enter for the next powerdomain
+	 * state.  Conceivably, this code should also determine
+	 * whether to actually disable the device clocks or not,
+	 * depending on how long it takes to re-enable the clocks.
+	 *
+	 * TI CDP code can call constraint_set here.
+	 */
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
+	if (t == -1)
+		pr_debug("OMAP PM: remove max DMA latency constraint: "
+			 "dev %p\n", dev);
+	else
+		pr_debug("OMAP PM: add max DMA latency constraint: "
+			 "dev %p, t = %ld usec\n", dev, t);
+
+	/*
+	 * For current Linux PM QOS params, this code should scan the
+	 * list of maximum CPU and DMA latencies and select the
+	 * smallest, then set cpu_dma_latency pm_qos_param
+	 * accordingly.
+	 *
+	 * For future Linux PM QOS params, with separate CPU and DMA
+	 * latency params, this code should just set the dma_latency param.
+	 *
+	 * TI CDP code can call constraint_set here.
+	 */
+
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
+	if (!pwrdm) {
+		WARN_ON(1);
+		return;
+	};
+
+	pr_debug("OMAP PM: powerdomain %s is becoming active\n", pwrdm->name);
+
+	/*
+	 * CDP code apparently will need these for the enable_power_domain()
+	 * and disable_power_domain() functions.
+	 */
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
+	if (!pwrdm) {
+		WARN_ON(1);
+		return;
+	};
+
+	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
+		 pwrdm->name);
+
+	/*
+	 * CDP code apparently will need these for the enable_power_domain()
+	 * and disable_power_domain() functions.
+	 */
+}
+
+
diff --git a/include/asm-arm/arch-omap/omap-pm.h b/include/asm-arm/arch-omap/omap-pm.h
new file mode 100644
index 0000000..020dcf6
--- /dev/null
+++ b/include/asm-arm/arch-omap/omap-pm.h
@@ -0,0 +1,42 @@
+/*
+ * omap-pm-noop.h - OMAP power management interface
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Amish Lakhani, Tony Lindgren, Rajendra Nayak, Sakari
+ * Poussa, Veeramanikandan Raju, Igor Stoppa, Paul Walmsley, Richard
+ * Woodruff
+ *
+ * Written by Paul Walmsley
+ */
+
+#ifndef ASM_ARM_ARCH_OMAP_OMAP_PM_H
+#define ASM_ARM_ARCH_OMAP_OMAP_PM_H
+
+#include <linux/device.h>
+#include <linux/cpufreq.h>
+
+#include "powerdomain.h"
+
+void omap_pm_exit(void);
+
+void omap_pm_set_max_cpu_lat(struct device *dev, long t);
+void omap_pm_set_min_bus_tput(struct device *dev, struct bus_type *bus,
+			      unsigned long r);
+void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
+void omap_pm_set_max_dma_lat(struct device *dev, long t);
+
+void omap_pm_dsp_set_min_opp(u8 opp_id);
+u8 omap_pm_dsp_get_opp(void);
+
+struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
+void omap_pm_cpu_set_freq(unsigned long f);
+unsigned long omap_pm_cpu_get_freq(void);
+
+void omap_pm_pwrdm_active(struct powerdomain *pwrdm);
+void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm);
+
+
+#endif

