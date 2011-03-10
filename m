From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 3/7] OMAP: PM CONSTRAINTS: implement wake-up latency constraints
Date: Thu, 10 Mar 2011 18:47:23 +0100
Message-ID: <1299779247-20511-4-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49858 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1CJRrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:47 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so2236471wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:46 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

Implement the wake-up latency constraints using an internal
unified function _set_dev_constraint at OMAP PM level,
which calls the corresponding function at omap device level.

The actual constraints management code is at the omap device level.

Note: the bus throughput function is implemented but currently is
a no-op.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/omap-pm-constraints.c |  174 ++++++++++++++++--------------
 1 files changed, 91 insertions(+), 83 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
index c8b4e4c..c6735da 100644
--- a/arch/arm/plat-omap/omap-pm-constraints.c
+++ b/arch/arm/plat-omap/omap-pm-constraints.c
@@ -24,6 +24,7 @@
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
+#include <plat/common.h>
 
 static bool off_mode_enabled;
 static u32 dummy_context_loss_counter;
@@ -32,119 +33,126 @@ static u32 dummy_context_loss_counter;
  * Device-driver-originated constraints (via board-*.c files)
  */
 
-int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
+/*
+ * Generic function to omap_device layer for the constraints API.
+ */
+static int _set_dev_constraint(enum omap_pm_constraint_class class,
+			       struct device *req_dev, struct device *dev,
+			       long t)
 {
-	if (!dev || t < -1) {
+	int ret = 0;
+
+	if (!req_dev || !dev || t < -1) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
-	};
-
-	if (t == -1)
-		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
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
+	/* Try to catch non omap_device for dev */
+	if (dev->parent == &omap_device_parent) {
+		if (t == -1)
+			pr_debug("OMAP PM: remove constraint of class %d "
+				 "from req_dev %s on dev %s\n",
+				 class, dev_name(req_dev), dev_name(dev));
+		else
+			pr_debug("OMAP PM: add constraint of class %d "
+				 "from req_dev %s on dev %s, t = %ld\n",
+				 class, dev_name(req_dev), dev_name(dev), t);
+
+		/* Call the omap_device API */
+		ret = omap_device_set_dev_constraint(class, req_dev, dev, t);
+	} else {
+		pr_err("OMAP-PM set_wakeup_lat: Error: platform device "
+		       "not valid\n");
+		return -EINVAL;
+	}
 
-	return 0;
+	return ret;
 }
 
+/*
+ * omap_pm_set_min_bus_tput - set/release bus throughput constraints
+ */
 int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
+	long t;
+	struct device *req_dev = NULL;
+
 	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
 	    agent_id != OCP_TARGET_AGENT)) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
 	};
 
+	/*
+	 * This code calls the generic omap_device API function
+	 * _set_dev_constraint with the class OMAP_PM_CONSTRAINT_THROUGHPUT.
+	 * _set_dev_constraint should manage the constraints lists and call
+	 * the appropriate low level code that models the interconnect,
+	 * computes the required clock frequency, converts that to a VDD2
+	 * OPP ID and sets the VDD2 OPP appropriately.
+	 */
+
+	/*
+	 * A value of r == 0 removes the constraint. Convert it to the
+	 * generic _set_dev_constraint convention (-1 for constraint removal)
+	 */
 	if (r == 0)
-		pr_debug("OMAP PM: remove min bus tput constraint: "
-			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
+		t = -1;
 	else
-		pr_debug("OMAP PM: add min bus tput constraint: "
-			 "dev %s for agent_id %d: rate %ld KiB\n",
-			 dev_name(dev), agent_id, r);
+		t = r;
 
 	/*
-	 * This code should model the interconnect and compute the
-	 * required clock frequency, convert that to a VDD2 OPP ID, then
-	 * set the VDD2 OPP appropriately.
-	 *
-	 * TI CDP code can call constraint_set here on the VDD2 OPP.
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
 
-	return 0;
+	return _set_dev_constraint(OMAP_PM_CONSTRAINT_THROUGHPUT,
+				   req_dev, dev, t);
 }
 
+/*
+ * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up latency
+ * constraints
+ */
 int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 				   long t)
 {
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
+	return _set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT, req_dev,
+				   dev, t);
 }
 
-int omap_pm_set_max_sdma_lat(struct device *dev, long t)
+/*
+ * omap_pm_set_max_mpu_wakeup_lat - set/release MPU wake-up latency
+ * constraints
+ *
+ * Maps to _set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_LAT
+ * as constraint class and the MPU device as constraints target.
+ */
+int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long t)
 {
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
+	return _set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT, req_dev,
+				   omap2_get_mpuss_device(), t);
+}
 
-	return 0;
+/*
+ * omap_pm_set_max_sdma_lat - set/release SDMA start latency
+ * constraints
+ *
+ * Currently maps to _set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_LAT
+ * as constraint class and the L3 device as constraints target.
+ */
+int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
+{
+	return _set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT, req_dev,
+				   omap2_get_l3_device(), t);
 }
 
 int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
-- 
1.7.2.3

