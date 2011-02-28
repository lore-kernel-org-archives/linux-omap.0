From: jean.pihet@newoldbits.com
Subject: [PATCH 2/3] OMAP: implement MPU and DMA wake-up constraints using PM_QOS
Date: Mon, 28 Feb 2011 18:41:23 +0100
Message-ID: <1298914884-16468-3-git-send-email-j-pihet@ti.com>
References: <1298914884-16468-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1B1Rlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 12:41:46 -0500
Received: by eyx24 with SMTP id 24so1380555eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 09:41:44 -0800 (PST)
In-Reply-To: <1298914884-16468-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vishwanath.bs@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement the wake-up constraints using the PM QOS API.

Due to the nature of PM QOS only the MPU and DMA constraints
can be used.
Due to the implementation of cpuidle on OMAP34xx
(in arch/arm/mach-omap2/cpuidle34xx.c) only the global
C-states wakeup latencies are used to determine the next
state of the MPU and CORE power domains.

The PM QOS handle pointer is stored inside the omap_device structure
and so the patch only applies to OMAP devices.

To be replaced by a more generic solution which allows every
device to put a constraint, and which can control all power
domains in the system. This solution is currently under
investigation.

Based on the original patch from Vishwanath,
cf. https://patchwork.kernel.org/patch/327312/

Cc: Vishwanath BS <vishwanath.bs@ti.com>

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-pm.h     |   96 ++++++++++++++-----------
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap-pm-constraints.c      |   80 +++++++++------------
 arch/arm/plat-omap/omap-pm-noop.c             |   70 +++++++++---------
 4 files changed, 124 insertions(+), 123 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index c0a7520..7180473 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/opp.h>
+#include <linux/pm_qos_params.h>
 
 /*
  * agent_id values for use with omap_pm_set_min_bus_tput():
@@ -70,44 +71,6 @@ void omap_pm_if_exit(void);
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
@@ -139,7 +102,6 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
  */
 int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
 
-
 /**
  * omap_pm_set_max_dev_wakeup_lat - set the maximum device enable latency
  * @req_dev: struct device * requesting the constraint, or NULL if none
@@ -169,10 +131,53 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
 int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 				   long t);
 
+/**
+ * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
+ * @qos_request: handle for the constraint
+ * @t: maximum MPU wakeup latency in microseconds
+ *
+ * Request that the maximum interrupt latency for the MPU to be no
+ * greater than @t microseconds. "Interrupt latency" in this case is
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
+ * omap_pm_set_max_dev_wakeup_lat()
+ *
+ * Multiple calls to omap_pm_set_max_mpu_wakeup_lat() will replace the
+ * previous t value.  To remove the latency target for the MPU, call
+ * with t = -1.
+ *
+ * Notes about the qos_request handle:
+ *  - the caller has to first allocate the pm_qos_request_list struct and
+ *    then call pm_qos_add_request(qos_request, PM_QOS_CPU_DMA_LATENCY,
+ *    PM_QOS_DEFAULT_VALUE) in order to initialize the constraint struct.
+ *  - the handle is stored by the caller for later use (update or removal of
+ *    the constraint).
+ *
+ * XXX This constraint will be deprecated soon in favor of the more
+ * general omap_pm_set_max_dev_wakeup_lat()
+ *
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
+ */
+int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list *qos_request,
+				   long t);
 
 /**
  * omap_pm_set_max_sdma_lat - set the maximum system DMA transfer start latency
- * @dev: struct device *
+ * @qos_request: handle for the constraint
  * @t: maximum DMA transfer start latency in microseconds
  *
  * Request that the maximum system DMA transfer start latency for this
@@ -194,11 +199,18 @@ int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
  * value for this device.  To remove the maximum DMA latency for this
  * device, call with t = -1.
  *
+ * Notes about the qos_request handle:
+ *  - the caller has to first allocate the pm_qos_request_list struct and
+ *    then call pm_qos_add_request(qos_request, PM_QOS_CPU_DMA_LATENCY,
+ *    PM_QOS_DEFAULT_VALUE) in order to initialize the constraint struct.
+ *  - the handle is stored by the caller for later use (update or removal of
+ *    the constraint).
+ *
  * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
  * is not satisfiable, or 0 upon success.
  */
-int omap_pm_set_max_sdma_lat(struct device *dev, long t);
-
+int omap_pm_set_max_sdma_lat(struct pm_qos_request_list *qos_request,
+			     long t);
 
 /**
  * omap_pm_set_min_clk_rate - set minimum clock rate requested by @dev
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..8826295 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -73,6 +73,7 @@ struct omap_device {
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
+	struct pm_qos_request_list	*pm_qos_request;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
index c8b4e4c..66366b1 100644
--- a/arch/arm/plat-omap/omap-pm-constraints.c
+++ b/arch/arm/plat-omap/omap-pm-constraints.c
@@ -28,38 +28,10 @@
 static bool off_mode_enabled;
 static u32 dummy_context_loss_counter;
 
+
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
@@ -118,33 +90,47 @@ int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 	return 0;
 }
 
-int omap_pm_set_max_sdma_lat(struct device *dev, long t)
+int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list *qos_request,
+				   long t)
 {
-	if (!dev || t < -1) {
+	/*
+	 * The current state is: use PM QOS with the PM_QOS_CPU_DMA_LATENCY
+	 * as pm_qos class. PM QOS records and sorts the constraints.
+	 * Cpuidle is using PM QOS to retrieve the strongest constraint
+	 * from the list, then changes the MPU and CORE power domains
+	 * states to honor the constraint.
+	 * Note that only MPU and CORE power domains states are affected.
+	 *
+	 * This shall use omap_pm_set_max_dev_wakeup_lat with the MPU
+	 * as the device to put the constraints on
+	 */
+	if (!qos_request || t < -1) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
 	};
 
-	if (t == -1)
-		pr_debug("OMAP PM: remove max DMA latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+	if (t == -1) {
+		pm_qos_update_request(qos_request, PM_QOS_DEFAULT_VALUE);
+		pr_debug("OMAP PM: remove max MPU wakeup latency "
+			 "constraint\n");
+	} else {
+		pm_qos_update_request(qos_request, t);
+		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
+			 "t=%ld us\n", t);
+	}
+
+	return 0;
+}
 
+int omap_pm_set_max_sdma_lat(struct pm_qos_request_list *qos_request, long t)
+{
 	/*
-	 * For current Linux PM QOS params, this code should scan the
-	 * list of maximum CPU and DMA latencies and select the
-	 * smallest, then set cpu_dma_latency pm_qos_param
-	 * accordingly.
-	 *
-	 * For future Linux PM QOS params, with separate CPU and DMA
-	 * latency params, this code should just set the dma_latency param.
+	 * Currently identical to omap_pm_set_max_mpu_wakeup_lat.
 	 *
-	 * TI CDP code can call constraint_set here.
+	 * This shall use omap_pm_set_max_dev_wakeup_lat with the SDMA
+	 * as device to put the constraints on
 	 */
-
-	return 0;
+	return omap_pm_set_max_mpu_wakeup_lat(qos_request, t);
 }
 
 int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index b0471bb2..10b39b1 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -29,38 +29,10 @@
 static bool off_mode_enabled;
 static u32 dummy_context_loss_counter;
 
+
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
@@ -119,19 +91,49 @@ int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 	return 0;
 }
 
-int omap_pm_set_max_sdma_lat(struct device *dev, long t)
+int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list *qos_request,
+				   long t)
 {
-	if (!dev || t < -1) {
+	if (!qos_request || t < -1) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
 	};
 
 	if (t == -1)
-		pr_debug("OMAP PM: remove max DMA latency constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove max MPU wakeup latency "
+			 "constraint\n");
+	else
+		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
+			 "t=%ld us\n", t);
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
+
+	return 0;
+}
+
+int omap_pm_set_max_sdma_lat(struct pm_qos_request_list *qos_request,
+			     long t)
+{
+	if (!qos_request || t < -1) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	};
+
+	if (t == -1)
+		pr_debug("OMAP PM: remove max DMA latency "
+			 "constraint\n");
 	else
 		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+			 "t=%ld us\n", t);
 
 	/*
 	 * For current Linux PM QOS params, this code should scan the
-- 
1.7.2.3

