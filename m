From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 06/11] OMAP2/3 PM: create the OMAP PM interface and add a
	default OMAP PM no-op layer
Date: Tue, 18 Aug 2009 14:56:27 +0300
Message-ID: <20090818115626.14171.38445.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Karthik Dasu <karthik-dp-l0cyMroinI0@public.gmane.org>, Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>, Igor Stoppa <igor.stoppa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Veeramanikandan Raju <veera-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Jouni =?utf-8?b?SMO2Z2FuZGVy?= <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sakari Poussa <sakari.poussa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Sawant <sawant-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The interface provides device drivers, CPUFreq, and DSPBridge with a
means of controlling OMAP power management parameters that are not yet
supported by the Linux PM PMQoS interface.  Copious documentation is
in the patch in Documentation/arm/OMAP/omap_pm and the interface
header file, arch/arm/plat-omap/include/mach/omap-pm.h.

Thanks to Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> for adding CORE (VDD2) OPP
support and moving the OPP table initialization earlier in the event
that the clock code needs them.  Thanks to Tero Kristo
<tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> for fixing the parameter check in
omap_pm_set_min_bus_tput().  Jouni signed off on Tero's patch.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jouni H=C3=B6gander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Stoppa <igor.stoppa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
Cc: Anand Sawant <sawant-l0cyMroinI0@public.gmane.org>
Cc: Sakari Poussa <sakari.poussa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Veeramanikandan Raju <veera-l0cyMroinI0@public.gmane.org>
Cc: Karthik Dasu <karthik-dp-l0cyMroinI0@public.gmane.org>
---
 Documentation/arm/OMAP/omap_pm            |  129 ++++++++++++
 arch/arm/mach-omap2/io.c                  |    4=20
 arch/arm/plat-omap/Kconfig                |   13 +
 arch/arm/plat-omap/Makefile               |    1=20
 arch/arm/plat-omap/include/mach/omap-pm.h |  301 +++++++++++++++++++++=
++++++++
 arch/arm/plat-omap/omap-pm-noop.c         |  296 +++++++++++++++++++++=
++++++++
 6 files changed, 744 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/OMAP/omap_pm
 create mode 100644 arch/arm/plat-omap/include/mach/omap-pm.h
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c

diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/om=
ap_pm
new file mode 100644
index 0000000..5389440
--- /dev/null
+++ b/Documentation/arm/OMAP/omap_pm
@@ -0,0 +1,129 @@
+
+The OMAP PM interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This document describes the temporary OMAP PM interface.  Driver
+authors use these functions to communicate minimum latency or
+throughput constraints to the kernel power management code.
+Over time, the intention is to merge features from the OMAP PM
+interface into the Linux PM QoS code.
+
+Drivers need to express PM parameters which:
+
+- support the range of power management parameters present in the TI S=
RF;
+
+- separate the drivers from the underlying PM parameter
+  implementation, whether it is the TI SRF or Linux PM QoS or Linux
+  latency framework or something else;
+
+- specify PM parameters in terms of fundamental units, such as
+  latency and throughput, rather than units which are specific to OMAP
+  or to particular OMAP variants;
+
+- allow drivers which are shared with other architectures (e.g.,
+  DaVinci) to add these constraints in a way which won't affect non-OM=
AP
+  systems,
+
+- can be implemented immediately with minimal disruption of other
+  architectures.
+
+
+This document proposes the OMAP PM interface, including the following
+five power management functions for driver code:
+
+1. Set the maximum MPU wakeup latency:
+   (*pdata->set_max_mpu_wakeup_lat)(struct device *dev, unsigned long =
t)
+
+2. Set the maximum device wakeup latency:
+   (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long =
t)
+
+3. Set the maximum system DMA transfer start latency (CORE pwrdm):
+   (*pdata->set_max_sdma_lat)(struct device *dev, long t)
+
+4. Set the minimum bus throughput needed by a device:
+   (*pdata->set_min_bus_tput)(struct device *dev, u8 agent_id, unsigne=
d long r)
+
+5. Return the number of times the device has lost context
+   (*pdata->get_dev_context_loss_count)(struct device *dev)
+
+
+Further documentation for all OMAP PM interface functions can be
+found in arch/arm/plat-omap/include/mach/omap-pm.h.
+
+
+The OMAP PM layer is intended to be temporary
+---------------------------------------------
+
+The intention is that eventually the Linux PM QoS layer should support
+the range of power management features present in OMAP3.  As this
+happens, existing drivers using the OMAP PM interface can be modified
+to use the Linux PM QoS code; and the OMAP PM interface can disappear.
+
+
+Driver usage of the OMAP PM functions
+-------------------------------------
+
+As the 'pdata' in the above examples indicates, these functions are
+exposed to drivers through function pointers in driver .platform_data
+structures.  The function pointers are initialized by the board-*.c
+files to point to the corresponding OMAP PM functions:
+.set_max_dev_wakeup_lat will point to
+omap_pm_set_max_dev_wakeup_lat(), etc.  Other architectures which do
+not support these functions should leave these function pointers set
+to NULL.  Drivers should use the following idiom:
+
+        if (pdata->set_max_dev_wakeup_lat)
+            (*pdata->set_max_dev_wakeup_lat)(dev, t);
+
+The most common usage of these functions will probably be to specify
+the maximum time from when an interrupt occurs, to when the device
+becomes accessible.  To accomplish this, driver writers should use the
+set_max_mpu_wakeup_lat() function to to constrain the MPU wakeup
+latency, and the set_max_dev_wakeup_lat() function to constrain the
+device wakeup latency (from clk_enable() to accessibility).  For
+example,
+
+        /* Limit MPU wakeup latency */
+        if (pdata->set_max_mpu_wakeup_lat)
+            (*pdata->set_max_mpu_wakeup_lat)(dev, tc);
+
+        /* Limit device powerdomain wakeup latency */
+        if (pdata->set_max_dev_wakeup_lat)
+            (*pdata->set_max_dev_wakeup_lat)(dev, td);
+
+        /* total wakeup latency in this example: (tc + td) */
+
+The PM parameters can be overwritten by calling the function again
+with the new value.  The settings can be removed by calling the
+function with a t argument of -1 (except in the case of
+set_max_bus_tput(), which should be called with an r argument of 0).
+
+The fifth function above, omap_pm_get_dev_context_loss_count(),
+is intended as an optimization to allow drivers to determine whether t=
he
+device has lost its internal context.  If context has been lost, the
+driver must restore its internal context before proceeding.
+
+
+Other specialized interface functions
+-------------------------------------
+
+The five functions listed above are intended to be usable by any
+device driver.  DSPBridge and CPUFreq have a few special requirements.
+DSPBridge expresses target DSP performance levels in terms of OPP IDs.
+CPUFreq expresses target MPU performance levels in terms of MPU
+frequency.  The OMAP PM interface contains functions for these
+specialized cases to convert that input information (OPPs/MPU
+frequency) into the form that the underlying power management
+implementation needs:
+
+6. (*pdata->dsp_get_opp_table)(void)
+
+7. (*pdata->dsp_set_min_opp)(u8 opp_id)
+
+8. (*pdata->dsp_get_opp)(void)
+
+9. (*pdata->cpu_get_freq_table)(void)
+
+10. (*pdata->cpu_set_freq)(unsigned long f)
+
+11. (*pdata->cpu_get_freq)(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e9b9bcb..4bfe873 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -36,6 +36,7 @@
 #ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready *=
/
 #include "clock.h"
=20
+#include <mach/omap-pm.h>
 #include <mach/powerdomain.h>
=20
 #include "powerdomains.h"
@@ -281,9 +282,12 @@ void __init omap2_init_common_hw(struct omap_sdrc_=
params *sdrc_cs0,
 {
 	omap2_mux_init();
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is rea=
dy */
+	/* The OPP tables have to be registered before a clk init */
+	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 	_omap2_init_reprogram_sdrc();
 #endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index efe85d0..5bb07c2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -183,6 +183,19 @@ config OMAP_SERIAL_WAKE
 	  to data on the serial RX line. This allows you to wake the
 	  system from serial console.
=20
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
 endmenu
=20
 endif
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a832795..86ca86f 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -25,3 +25,4 @@ obj-y +=3D $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) +=3D mailbox.o
=20
+obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
\ No newline at end of file
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-=
omap/include/mach/omap-pm.h
new file mode 100644
index 0000000..3ee41d7
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -0,0 +1,301 @@
+/*
+ * omap-pm.h - OMAP power management interface
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * Interface developed by (in alphabetical order): Karthik Dasu, Jouni
+ * H=C3=B6gander, Tony Lindgren, Rajendra Nayak, Sakari Poussa,
+ * Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul Walmsley,
+ * Richard Woodruff
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
+/**
+ * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
+ * @rate: target clock rate
+ * @opp_id: OPP ID
+ * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
+ *
+ * Operating performance point data.  Can vary by OMAP chip and board.
+ */
+struct omap_opp {
+	unsigned long rate;
+	u8 opp_id;
+	u16 min_vdd;
+};
+
+extern struct omap_opp *mpu_opps;
+extern struct omap_opp *dsp_opps;
+extern struct omap_opp *l3_opps;
+
+/*
+ * agent_id values for use with omap_pm_set_min_bus_tput():
+ *
+ * OCP_INITIATOR_AGENT is only valid for devices that can act as
+ * initiators -- it represents the device's L3 interconnect
+ * connection.  OCP_TARGET_AGENT represents the device's L4
+ * interconnect connection.
+ */
+#define OCP_TARGET_AGENT		1
+#define OCP_INITIATOR_AGENT		2
+
+/**
+ * omap_pm_if_early_init - OMAP PM init code called before clock fw in=
it
+ * @mpu_opp_table: array ptr to struct omap_opp for MPU
+ * @dsp_opp_table: array ptr to struct omap_opp for DSP
+ * @l3_opp_table : array ptr to struct omap_opp for CORE
+ *
+ * Initialize anything that must be configured before the clock
+ * framework starts.  The "_if_" is to avoid name collisions with the
+ * PM idle-loop code.
+ */
+int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
+				 struct omap_opp *dsp_opp_table,
+				 struct omap_opp *l3_opp_table);
+
+/**
+ * omap_pm_if_init - OMAP PM init code called after clock fw init
+ *
+ * The main initialization code.  OPP tables are passed in here.  The
+ * "_if_" is to avoid name collisions with the PM idle-loop code.
+ */
+int __init omap_pm_if_init(void);
+
+/**
+ * omap_pm_if_exit - OMAP PM exit code
+ *
+ * Exit code; currently unused.  The "_if_" is to avoid name
+ * collisions with the PM idle-loop code.
+ */
+void omap_pm_if_exit(void);
+
+/*
+ * Device-driver-originated constraints (via board-*.c files, platform=
_data)
+ */
+
+
+/**
+ * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
+ * @dev: struct device * requesting the constraint
+ * @t: maximum MPU wakeup latency in microseconds
+ *
+ * Request that the maximum interrupt latency for the MPU to be no
+ * greater than 't' microseconds. "Interrupt latency" in this case is
+ * defined as the elapsed time from the occurrence of a hardware or
+ * timer interrupt to the time when the device driver's interrupt
+ * service routine has been entered by the MPU.
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
+ * Multiple calls to set_max_mpu_wakeup_lat() will replace the
+ * previous t value.  To remove the latency target for the MPU, call
+ * with t =3D -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
+
+
+/**
+ * omap_pm_set_min_bus_tput - set minimum bus throughput needed by dev=
ice
+ * @dev: struct device * requesting the constraint
+ * @tbus_id: interconnect to operate on (OCP_{INITIATOR,TARGET}_AGENT)
+ * @r: minimum throughput (in KiB/s)
+ *
+ * Request that the minimum data throughput on the OCP interconnect
+ * attached to device 'dev' interconnect agent 'tbus_id' be no less
+ * than 'r' KiB/s.
+ *
+ * It is expected that the OMAP PM or bus code will use this
+ * information to set the interconnect clock to run at the lowest
+ * possible speed that satisfies all current system users.  The PM or
+ * bus code will adjust the estimate based on its model of the bus, so
+ * device driver authors should attempt to specify an accurate
+ * quantity for their device use case, and let the PM or bus code
+ * overestimate the numbers as necessary to handle request/response
+ * latency, other competing users on the system, etc.  On OMAP2/3, if
+ * a driver requests a minimum L4 interconnect speed constraint, the
+ * code will also need to add an minimum L3 interconnect speed
+ * constraint,
+ *
+ * Multiple calls to set_min_bus_tput() will replace the previous rate
+ * value for this device.  To remove the interconnect throughput
+ * restriction for this device, call with r =3D 0.
+ *
+ * No return value.
+ */
+void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigne=
d long r);
+
+
+/**
+ * omap_pm_set_max_dev_wakeup_lat - set the maximum device enable late=
ncy
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
+ * determine what power state to put the powerdomain enclosing this
+ * device into.
+ *
+ * Multiple calls to set_max_dev_wakeup_lat() will replace the
+ * previous wakeup latency values for this device.  To remove the wake=
up
+ * latency restriction for this device, call with t =3D -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
+
+
+/**
+ * omap_pm_set_max_sdma_lat - set the maximum system DMA transfer star=
t latency
+ * @dev: struct device *
+ * @t: maximum DMA transfer start latency in microseconds
+ *
+ * Request that the maximum system DMA transfer start latency for this
+ * device 'dev' should be no greater than 't' microseconds.  "DMA
+ * transfer start latency" here is defined as the elapsed time from
+ * when a device (e.g., McBSP) requests that a system DMA transfer
+ * start or continue, to the time at which data starts to flow into
+ * that device from the system DMA controller.
+ *
+ * It is intended that underlying PM code will use this information to
+ * determine what power state to put the CORE powerdomain into.
+ *
+ * Since system DMA transfers may not involve the MPU, this function
+ * will not affect MPU wakeup latency.  Use set_max_cpu_lat() to do
+ * so.  Similarly, this function will not affect device wakeup latency
+ * -- use set_max_dev_wakeup_lat() to affect that.
+ *
+ * Multiple calls to set_max_sdma_lat() will replace the previous t
+ * value for this device.  To remove the maximum DMA latency for this
+ * device, call with t =3D -1.
+ *
+ * No return value.
+ */
+void omap_pm_set_max_sdma_lat(struct device *dev, long t);
+
+
+/*
+ * DSP Bridge-specific constraints
+ */
+
+/**
+ * omap_pm_dsp_get_opp_table - get OPP->DSP clock frequency table
+ *
+ * Intended for use by DSPBridge.  Returns an array of OPP->DSP clock
+ * frequency entries.  The final item in the array should have .rate =3D
+ * .opp_id =3D 0.
+ */
+const struct omap_opp *omap_pm_dsp_get_opp_table(void);
+
+/**
+ * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Br=
idge
+ * @opp_id: target DSP OPP ID
+ *
+ * Set a minimum OPP ID for the DSP.  This is intended to be called
+ * only from the DSP Bridge MPU-side driver.  Unfortunately, the only
+ * information that code receives from the DSP/BIOS load estimator is =
the
+ * target OPP ID; hence, this interface.  No return value.
+ */
+void omap_pm_dsp_set_min_opp(u8 opp_id);
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
+u8 omap_pm_dsp_get_opp(void);
+
+
+/*
+ * CPUFreq-originated constraint
+ *
+ * In the future, this should be handled by custom OPP clocktype
+ * functions.
+ */
+
+/**
+ * omap_pm_cpu_get_freq_table - return a cpufreq_frequency_table array=
 ptr
+ *
+ * Provide a frequency table usable by CPUFreq for the current chip/bo=
ard.
+ * Returns a pointer to a struct cpufreq_frequency_table array or NULL
+ * upon error.
+ */
+struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void);
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
+void omap_pm_cpu_set_freq(unsigned long f);
+
+/**
+ * omap_pm_cpu_get_freq - report the current CPU frequency
+ *
+ * Returns the current MPU frequency, or 0 upon error.
+ */
+unsigned long omap_pm_cpu_get_freq(void);
+
+
+/*
+ * Device context loss tracking
+ */
+
+/**
+ * omap_pm_get_dev_context_loss_count - return count of times dev has =
lost ctx
+ * @dev: struct device *
+ *
+ * This function returns the number of times that the device @dev has
+ * lost its internal context.  This generally occurs on a powerdomain
+ * transition to OFF.  Drivers use this as an optimization to avoid re=
storing
+ * context if the device hasn't lost it.  To use, drivers should initi=
ally
+ * call this in their context save functions and store the result.  Ea=
rly in
+ * the driver's context restore function, the driver should call this =
function
+ * again, and compare the result to the stored counter.  If they diffe=
r, the
+ * driver must restore device context.   If the number of context loss=
es
+ * exceeds the maximum positive integer, the function will wrap to 0 a=
nd
+ * continue counting.  Returns the number of context losses for this d=
evice,
+ * or -EINVAL upon error.
+ */
+int omap_pm_get_dev_context_loss_count(struct device *dev);
+
+
+#endif
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/oma=
p-pm-noop.c
new file mode 100644
index 0000000..e98f0a2
--- /dev/null
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -0,0 +1,296 @@
+/*
+ * omap-pm-noop.c - OMAP power management interface - dummy version
+ *
+ * This code implements the OMAP power management interface to
+ * drivers, CPUIdle, CPUFreq, and DSP Bridge.  It is strictly for
+ * debug/demonstration use, as it does nothing but printk() whenever a
+ * function is called (when DEBUG is defined, below)
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * Interface developed by (in alphabetical order):
+ * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veerama=
nikandan
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
+
+#include <mach/powerdomain.h>
+
+struct omap_opp *dsp_opps;
+struct omap_opp *mpu_opps;
+struct omap_opp *l3_opps;
+
+/*
+ * Device-driver-originated constraints (via board-*.c files)
+ */
+
+void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
+{
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t =3D=3D -1)
+		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
+			 "dev %s\n", dev_name(dev));
+	else
+		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
+			 "dev %s, t =3D %ld usec\n", dev_name(dev), t);
+
+	/*
+	 * For current Linux, this needs to map the MPU to a
+	 * powerdomain, then go through the list of current max lat
+	 * constraints on the MPU and find the smallest.  If
+	 * the latency constraint has changed, the code should
+	 * recompute the state to enter for the next powerdomain
+	 * state.
+	 *
+	 * TI CDP code can call constraint_set here.
+	 */
+}
+
+void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigne=
d long r)
+{
+	if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
+	    agent_id !=3D OCP_TARGET_AGENT)) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (r =3D=3D 0)
+		pr_debug("OMAP PM: remove min bus tput constraint: "
+			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
+	else
+		pr_debug("OMAP PM: add min bus tput constraint: "
+			 "dev %s for agent_id %d: rate %ld KiB\n",
+			 dev_name(dev), agent_id, r);
+
+	/*
+	 * This code should model the interconnect and compute the
+	 * required clock frequency, convert that to a VDD2 OPP ID, then
+	 * set the VDD2 OPP appropriately.
+	 *
+	 * TI CDP code can call constraint_set here on the VDD2 OPP.
+	 */
+}
+
+void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
+{
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t =3D=3D -1)
+		pr_debug("OMAP PM: remove max device latency constraint: "
+			 "dev %s\n", dev_name(dev));
+	else
+		pr_debug("OMAP PM: add max device latency constraint: "
+			 "dev %s, t =3D %ld usec\n", dev_name(dev), t);
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
+}
+
+void omap_pm_set_max_sdma_lat(struct device *dev, long t)
+{
+	if (!dev || t < -1) {
+		WARN_ON(1);
+		return;
+	};
+
+	if (t =3D=3D -1)
+		pr_debug("OMAP PM: remove max DMA latency constraint: "
+			 "dev %s\n", dev_name(dev));
+	else
+		pr_debug("OMAP PM: add max DMA latency constraint: "
+			 "dev %s, t =3D %ld usec\n", dev_name(dev), t);
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
+const struct omap_opp *omap_pm_dsp_get_opp_table(void)
+{
+	pr_debug("OMAP PM: DSP request for OPP table\n");
+
+	/*
+	 * Return DSP frequency table here:  The final item in the
+	 * array should have .rate =3D .opp_id =3D 0.
+	 */
+
+	return NULL;
+}
+
+void omap_pm_dsp_set_min_opp(u8 opp_id)
+{
+	if (opp_id =3D=3D 0) {
+		WARN_ON(1);
+		return;
+	}
+
+	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id)=
;
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
+
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
+struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
+{
+	pr_debug("OMAP PM: CPUFreq request for frequency table\n");
+
+	/*
+	 * Return CPUFreq frequency table here: loop over
+	 * all VDD1 clkrates, pull out the mpu_ck frequencies, build
+	 * table
+	 */
+
+	return NULL;
+}
+
+void omap_pm_cpu_set_freq(unsigned long f)
+{
+	if (f =3D=3D 0) {
+		WARN_ON(1);
+		return;
+	}
+
+	pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\n"=
,
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
+ * Device context loss tracking
+ */
+
+int omap_pm_get_dev_context_loss_count(struct device *dev)
+{
+	if (!dev) {
+		WARN_ON(1);
+		return -EINVAL;
+	};
+
+	pr_debug("OMAP PM: returning context loss count for dev %s\n",
+		 dev_name(dev));
+
+	/*
+	 * Map the device to the powerdomain.  Return the powerdomain
+	 * off counter.
+	 */
+
+	return 0;
+}
+
+
+/* Should be called before clk framework init */
+int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
+				 struct omap_opp *dsp_opp_table,
+				 struct omap_opp *l3_opp_table)
+{
+	mpu_opps =3D mpu_opp_table;
+	dsp_opps =3D dsp_opp_table;
+	l3_opps =3D l3_opp_table;
+	return 0;
+}
+
+/* Must be called after clock framework is initialized */
+int __init omap_pm_if_init(void)
+{
+	return 0;
+}
+
+void omap_pm_if_exit(void)
+{
+	/* Deallocate CPUFreq frequency table here */
+}
+


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
