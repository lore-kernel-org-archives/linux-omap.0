From: jean.pihet@newoldbits.com
Subject: [PATCH 12/13] OMAP: PM CONSTRAINTS: implement the devices wake-up latency constraints
Date: Thu, 28 Jul 2011 10:30:19 +0200
Message-ID: <1311841821-10252-13-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48740 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1G1IbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:31:17 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so1524198wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:31:16 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement the devices wake-up latency constraints using a PM QoS
notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Note: the bus throughput function is implemented but currently is
a no-op. A new PM QoS class for the bus throughput needs to be
added.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-pm.h |  128 ----------------------
 arch/arm/plat-omap/omap-pm-constraints.c  |  169 +++++++++++++----------------
 arch/arm/plat-omap/omap-pm-noop.c         |   89 ---------------
 3 files changed, 75 insertions(+), 311 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 0840df8..d276082 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -62,136 +62,8 @@ void omap_pm_if_exit(void);
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
-/**
- * omap_pm_set_min_bus_tput - set minimum bus throughput needed by device
- * @dev: struct device * requesting the constraint
- * @tbus_id: interconnect to operate on (OCP_{INITIATOR,TARGET}_AGENT)
- * @r: minimum throughput (in KiB/s)
- *
- * Request that the minimum data throughput on the OCP interconnect
- * attached to device @dev interconnect agent @tbus_id be no less
- * than @r KiB/s.
- *
- * It is expected that the OMAP PM or bus code will use this
- * information to set the interconnect clock to run at the lowest
- * possible speed that satisfies all current system users.  The PM or
- * bus code will adjust the estimate based on its model of the bus, so
- * device driver authors should attempt to specify an accurate
- * quantity for their device use case, and let the PM or bus code
- * overestimate the numbers as necessary to handle request/response
- * latency, other competing users on the system, etc.  On OMAP2/3, if
- * a driver requests a minimum L4 interconnect speed constraint, the
- * code will also need to add an minimum L3 interconnect speed
- * constraint,
- *
- * Multiple calls to omap_pm_set_min_bus_tput() will replace the
- * previous rate value for this device.  To remove the interconnect
- * throughput restriction for this device, call with r = 0.
- *
- * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
- * is not satisfiable, or 0 upon success.
- */
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
diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
index c8b4e4c..5e63b04 100644
--- a/arch/arm/plat-omap/omap-pm-constraints.c
+++ b/arch/arm/plat-omap/omap-pm-constraints.c
@@ -17,132 +17,105 @@
 #undef DEBUG
 
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
+#include <plat/common.h>
+#include <plat/omap_hwmod.h>
 
 static bool off_mode_enabled;
 static u32 dummy_context_loss_counter;
 
-/*
- * Device-driver-originated constraints (via board-*.c files)
- */
+static int _pm_qos_dev_wakeup_latency_handler(struct notifier_block *,
+					      unsigned long, void *);
+static struct notifier_block _pm_qos_dev_wakeup_latency_notifier = {
+	.notifier_call	= _pm_qos_dev_wakeup_latency_handler,
+};
 
-int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
+
+static int _apply_dev_wakeup_constraint(void *req, unsigned long new_value)
 {
-	if (!dev || t < -1) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct pm_qos_request *pm_qos_req = req;
+
+	/* Look for the platform device for the constraint target device */
+	pdev = to_platform_device(pm_qos_req->dev);
+
+	/* Try to catch non platform devices */
+	if (pdev->name == NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(pm_qos_req->dev));
 		return -EINVAL;
-	};
+	}
 
-	if (t == -1)
-		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+	/* Find the associated omap_device for dev */
+	od = container_of(pdev, struct omap_device, pdev);
+	if (od->hwmods_cnt != 1) {
+		pr_err("%s: Error: No unique hwmod for device %s\n",
+		       __func__, dev_name(pm_qos_req->dev));
+		return -EINVAL;
+	}
 
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
+	/* Find the primary omap_hwmod for dev */
+	oh = od->hwmods[0];
 
-	return 0;
+	/* Apply the constraint */
+	return omap_hwmod_set_wkup_lat_constraint(oh, pm_qos_req, new_value);
 }
 
-int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
+/* PM QoS classes handlers */
+static int _pm_qos_dev_wakeup_latency_handler(struct notifier_block *nb,
+					      unsigned long new_value,
+					      void *req)
 {
-	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
-	    agent_id != OCP_TARGET_AGENT)) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
-		return -EINVAL;
-	};
-
-	if (r == 0)
-		pr_debug("OMAP PM: remove min bus tput constraint: "
-			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
-	else
-		pr_debug("OMAP PM: add min bus tput constraint: "
-			 "dev %s for agent_id %d: rate %ld KiB\n",
-			 dev_name(dev), agent_id, r);
-
-	/*
-	 * This code should model the interconnect and compute the
-	 * required clock frequency, convert that to a VDD2 OPP ID, then
-	 * set the VDD2 OPP appropriately.
-	 *
-	 * TI CDP code can call constraint_set here on the VDD2 OPP.
-	 */
-
-	return 0;
+	return _apply_dev_wakeup_constraint(req, new_value);
 }
 
-int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
-				   long t)
+/*
+ * omap_pm_set_min_bus_tput - set/release bus throughput constraints
+ * ToDo: currently is a no-op, to be converted to a PM QoS handler
+ * for the TPUT class
+ */
+int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
-	if (!req_dev || !dev || t < -1) {
+	long t;
+	struct device *req_dev = NULL;
+
+	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
+	    agent_id != OCP_TARGET_AGENT)) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
 	};
 
-	if (t == -1)
-		pr_debug("OMAP PM: remove max device latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max device latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
 	/*
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
+	 * A value of r == 0 removes the constraint. Convert it to the
+	 * generic _set_dev_constraint convention (-1 for constraint removal)
 	 */
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
+	if (r == 0)
+		t = -1;
 	else
-		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+		t = r;
 
 	/*
-	 * For current Linux PM QOS params, this code should scan the
-	 * list of maximum CPU and DMA latencies and select the
-	 * smallest, then set cpu_dma_latency pm_qos_param
-	 * accordingly.
-	 *
-	 * For future Linux PM QOS params, with separate CPU and DMA
-	 * latency params, this code should just set the dma_latency param.
-	 *
-	 * TI CDP code can call constraint_set here.
+	 * Assign the device for L3 or L4 interconnect to req_dev,
+	 * based on the value of agent_id
 	 */
+	switch (agent_id) {
+	case OCP_INITIATOR_AGENT:
+		req_dev = omap2_get_l3_device();
+		break;
+	case OCP_TARGET_AGENT:
+		/* Fixme: need the device for L4 interconnect */
+		break;
+	}
 
 	return 0;
 }
@@ -353,7 +326,15 @@ int __init omap_pm_if_early_init(void)
 /* Must be called after clock framework is initialized */
 int __init omap_pm_if_init(void)
 {
-	return 0;
+	int ret;
+
+	ret = pm_qos_add_notifier(PM_QOS_DEV_LATENCY,
+				  &_pm_qos_dev_wakeup_latency_notifier);
+	if (ret)
+		WARN(1, KERN_ERR "Cannot add notifier for "
+			"PM_QOS_DEV_WAKEUP_LATENCY\n");
+
+	return ret;
 }
 
 void omap_pm_if_exit(void)
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index b0471bb2..8ad902f 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -32,35 +32,6 @@ static u32 dummy_context_loss_counter;
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
-
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
@@ -88,66 +59,6 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
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
1.7.2.5

