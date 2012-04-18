From: jean.pihet@newoldbits.com
Subject: [PATCH 2/2] ARM: OMAP: PM: remove the latency related functions from the API
Date: Wed, 18 Apr 2012 15:55:14 +0200
Message-ID: <1334757314-29325-3-git-send-email-j-pihet@ti.com>
References: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37925 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2DRNzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:55:36 -0400
Received: by wibhr17 with SMTP id hr17so619652wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:55:34 -0700 (PDT)
In-Reply-To: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Remove the following functions from the OMAP PM API:
 omap_pm_set_max_mpu_wakeup_lat
 omap_pm_set_max_dev_wakeup_lat
 omap_pm_set_max_sdma_lat
and updated the kernel Documentation accordingly.

The generic per-device PM QoS functions shall be used instead of the
OMAP PM API, cf. include/linux/pm_qos.h and
Documentation/power/pm_qos_interface.txt.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 Documentation/arm/OMAP/omap_pm            |   68 ++++++--------------
 arch/arm/plat-omap/include/plat/omap-pm.h |   99 -----------------------------
 arch/arm/plat-omap/omap-pm-noop.c         |   88 -------------------------
 3 files changed, 21 insertions(+), 234 deletions(-)

diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
index 9012bb0..90f67a3 100644
--- a/Documentation/arm/OMAP/omap_pm
+++ b/Documentation/arm/OMAP/omap_pm
@@ -5,8 +5,19 @@ The OMAP PM interface
 This document describes the temporary OMAP PM interface.  Driver
 authors use these functions to communicate minimum latency or
 throughput constraints to the kernel power management code.
+
 Over time, the intention is to merge features from the OMAP PM
 interface into the Linux PM QoS code.
+The following PM QoS features already migrated to the PM QoS framework:
+- PM QoS CPU and DMA latency: used to specify the maximum allowed wake-up
+  latency for the CPU,
+- per device PM QoS latency: used to specifiy the maximum allowed wake-up
+  latency for a given device.
+
+Please refer to the corresponding header file and kernel documentation
+for the PM QoS framework, respectively at include/linux/pm_qos.h and
+Documentation/power/pm_qos_interface.txt.
+
 
 Drivers need to express PM parameters which:
 
@@ -29,21 +40,12 @@ Drivers need to express PM parameters which:
 
 
 This document proposes the OMAP PM interface, including the following
-five power management functions for driver code:
-
-1. Set the maximum MPU wakeup latency:
-   (*pdata->set_max_mpu_wakeup_lat)(struct device *dev, unsigned long t)
+power management functions for driver code:
 
-2. Set the maximum device wakeup latency:
-   (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t)
-
-3. Set the maximum system DMA transfer start latency (CORE pwrdm):
-   (*pdata->set_max_sdma_lat)(struct device *dev, long t)
-
-4. Set the minimum bus throughput needed by a device:
+1. Set the minimum bus throughput needed by a device:
    (*pdata->set_min_bus_tput)(struct device *dev, u8 agent_id, unsigned long r)
 
-5. Return the number of times the device has lost context
+2. Return the number of times the device has lost context
    (*pdata->get_dev_context_loss_count)(struct device *dev)
 
 
@@ -55,10 +57,12 @@ The OMAP PM layer is intended to be temporary
 ---------------------------------------------
 
 The intention is that eventually the Linux PM QoS layer should support
-the range of power management features present in OMAP3.  As this
-happens, existing drivers using the OMAP PM interface can be modified
+the range of power management features present in OMAP3. As this
+happens, existing drivers using the OMAP PM interface shall be modified
 to use the Linux PM QoS code; and the OMAP PM interface can disappear.
 
+The set_min_bus_tput function shall be converted to a throughput PM QoS
+framework.
 
 Driver usage of the OMAP PM functions
 -------------------------------------
@@ -66,39 +70,9 @@ Driver usage of the OMAP PM functions
 As the 'pdata' in the above examples indicates, these functions are
 exposed to drivers through function pointers in driver .platform_data
 structures.  The function pointers are initialized by the board-*.c
-files to point to the corresponding OMAP PM functions:
-.set_max_dev_wakeup_lat will point to
-omap_pm_set_max_dev_wakeup_lat(), etc.  Other architectures which do
-not support these functions should leave these function pointers set
-to NULL.  Drivers should use the following idiom:
-
-        if (pdata->set_max_dev_wakeup_lat)
-            (*pdata->set_max_dev_wakeup_lat)(dev, t);
-
-The most common usage of these functions will probably be to specify
-the maximum time from when an interrupt occurs, to when the device
-becomes accessible.  To accomplish this, driver writers should use the
-set_max_mpu_wakeup_lat() function to to constrain the MPU wakeup
-latency, and the set_max_dev_wakeup_lat() function to constrain the
-device wakeup latency (from clk_enable() to accessibility).  For
-example,
-
-        /* Limit MPU wakeup latency */
-        if (pdata->set_max_mpu_wakeup_lat)
-            (*pdata->set_max_mpu_wakeup_lat)(dev, tc);
-
-        /* Limit device powerdomain wakeup latency */
-        if (pdata->set_max_dev_wakeup_lat)
-            (*pdata->set_max_dev_wakeup_lat)(dev, td);
-
-        /* total wakeup latency in this example: (tc + td) */
-
-The PM parameters can be overwritten by calling the function again
-with the new value.  The settings can be removed by calling the
-function with a t argument of -1 (except in the case of
-set_max_bus_tput(), which should be called with an r argument of 0).
-
-The fifth function above, omap_pm_get_dev_context_loss_count(),
+files to point to the corresponding OMAP PM functions.
+
+The omap_pm_get_dev_context_loss_count() function
 is intended as an optimization to allow drivers to determine whether the
 device has lost its internal context.  If context has been lost, the
 driver must restore its internal context before proceeding.
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 67faa7b..a3ece28 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -62,44 +62,6 @@ void omap_pm_if_exit(void);
  * Device-driver-originated constraints (via board-*.c files, platform_data)
  */
 
-
-/**
- * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
- * @dev: struct device * requesting the constraint
- * @t: maximum MPU wakeup latency in microseconds
- *
- * Request that the maximum interrupt latency for the MPU to be no
- * greater than @t microseconds. "Interrupt latency" in this case is
- * defined as the elapsed time from the occurrence of a hardware or
- * timer interrupt to the time when the device driver's interrupt
- * service routine has been entered by the MPU.
- *
- * It is intended that underlying PM code will use this information to
- * determine what power state to put the MPU powerdomain into, and
- * possibly the CORE powerdomain as well, since interrupt handling
- * code currently runs from SDRAM.  Advanced PM or board*.c code may
- * also configure interrupt controller priorities, OCP bus priorities,
- * CPU speed(s), etc.
- *
- * This function will not affect device wakeup latency, e.g., time
- * elapsed from when a device driver enables a hardware device with
- * clk_enable(), to when the device is ready for register access or
- * other use.  To control this device wakeup latency, use
- * omap_pm_set_max_dev_wakeup_lat()
- *
- * Multiple calls to omap_pm_set_max_mpu_wakeup_lat() will replace the
- * previous t value.  To remove the latency target for the MPU, call
- * with t = -1.
- *
- * XXX This constraint will be deprecated soon in favor of the more
- * general omap_pm_set_max_dev_wakeup_lat()
- *
- * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
- * is not satisfiable, or 0 upon success.
- */
-int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
-
-
 /**
  * omap_pm_set_min_bus_tput - set minimum bus throughput needed by device
  * @dev: struct device * requesting the constraint
@@ -131,67 +93,6 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
  */
 int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
 
-
-/**
- * omap_pm_set_max_dev_wakeup_lat - set the maximum device enable latency
- * @req_dev: struct device * requesting the constraint, or NULL if none
- * @dev: struct device * to set the constraint one
- * @t: maximum device wakeup latency in microseconds
- *
- * Request that the maximum amount of time necessary for a device @dev
- * to become accessible after its clocks are enabled should be no
- * greater than @t microseconds.  Specifically, this represents the
- * time from when a device driver enables device clocks with
- * clk_enable(), to when the register reads and writes on the device
- * will succeed.  This function should be called before clk_disable()
- * is called, since the power state transition decision may be made
- * during clk_disable().
- *
- * It is intended that underlying PM code will use this information to
- * determine what power state to put the powerdomain enclosing this
- * device into.
- *
- * Multiple calls to omap_pm_set_max_dev_wakeup_lat() will replace the
- * previous wakeup latency values for this device.  To remove the
- * wakeup latency restriction for this device, call with t = -1.
- *
- * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
- * is not satisfiable, or 0 upon success.
- */
-int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
-				   long t);
-
-
-/**
- * omap_pm_set_max_sdma_lat - set the maximum system DMA transfer start latency
- * @dev: struct device *
- * @t: maximum DMA transfer start latency in microseconds
- *
- * Request that the maximum system DMA transfer start latency for this
- * device 'dev' should be no greater than 't' microseconds.  "DMA
- * transfer start latency" here is defined as the elapsed time from
- * when a device (e.g., McBSP) requests that a system DMA transfer
- * start or continue, to the time at which data starts to flow into
- * that device from the system DMA controller.
- *
- * It is intended that underlying PM code will use this information to
- * determine what power state to put the CORE powerdomain into.
- *
- * Since system DMA transfers may not involve the MPU, this function
- * will not affect MPU wakeup latency.  Use set_max_cpu_lat() to do
- * so.  Similarly, this function will not affect device wakeup latency
- * -- use set_max_dev_wakeup_lat() to affect that.
- *
- * Multiple calls to set_max_sdma_lat() will replace the previous t
- * value for this device.  To remove the maximum DMA latency for this
- * device, call with t = -1.
- *
- * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
- * is not satisfiable, or 0 upon success.
- */
-int omap_pm_set_max_sdma_lat(struct device *dev, long t);
-
-
 /**
  * omap_pm_set_min_clk_rate - set minimum clock rate requested by @dev
  * @dev: struct device * requesting the constraint
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 5a97b4d..e6c59d2 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -33,34 +33,6 @@ static int dummy_context_loss_counter;
  * Device-driver-originated constraints (via board-*.c files)
  */
 
-int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
-{
-	if (!dev || t < -1) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
-		return -EINVAL;
-	};
-
-	if (t == -1)
-		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
-	/*
-	 * For current Linux, this needs to map the MPU to a
-	 * powerdomain, then go through the list of current max lat
-	 * constraints on the MPU and find the smallest.  If
-	 * the latency constraint has changed, the code should
-	 * recompute the state to enter for the next powerdomain
-	 * state.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
-
-	return 0;
-}
-
 int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
 	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
@@ -88,66 +60,6 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 	return 0;
 }
 
-int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
-				   long t)
-{
-	if (!req_dev || !dev || t < -1) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
-		return -EINVAL;
-	};
-
-	if (t == -1)
-		pr_debug("OMAP PM: remove max device latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max device latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
-	/*
-	 * For current Linux, this needs to map the device to a
-	 * powerdomain, then go through the list of current max lat
-	 * constraints on that powerdomain and find the smallest.  If
-	 * the latency constraint has changed, the code should
-	 * recompute the state to enter for the next powerdomain
-	 * state.  Conceivably, this code should also determine
-	 * whether to actually disable the device clocks or not,
-	 * depending on how long it takes to re-enable the clocks.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
-
-	return 0;
-}
-
-int omap_pm_set_max_sdma_lat(struct device *dev, long t)
-{
-	if (!dev || t < -1) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
-		return -EINVAL;
-	};
-
-	if (t == -1)
-		pr_debug("OMAP PM: remove max DMA latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
-	/*
-	 * For current Linux PM QOS params, this code should scan the
-	 * list of maximum CPU and DMA latencies and select the
-	 * smallest, then set cpu_dma_latency pm_qos_param
-	 * accordingly.
-	 *
-	 * For future Linux PM QOS params, with separate CPU and DMA
-	 * latency params, this code should just set the dma_latency param.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
-
-	return 0;
-}
-
 int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
 {
 	if (!dev || !c || r < 0) {
-- 
1.7.7.6

