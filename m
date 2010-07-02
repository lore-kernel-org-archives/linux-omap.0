From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 19/20] OMAP: PM constraints: add return values;
 add requesting device param to omap_pm_set_max_dev_wakeup_lat()
Date: Fri, 02 Jul 2010 09:29:58 -0600
Message-ID: <20100702152951.6221.74187.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45318 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758914Ab0GBPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:06 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add return values to the PM constraint functions.  This allows the PM
core to provide feedback to the caller if a constraint is not
possible.  Update the one upstream user of omap_pm_set_max_mpu_wakeup_lat()
to add a compatibility wrapper, needed until the driver is changed.

Update some of the documentation to conform more closely to kerneldoc style.

Add an additional device parameter to omap_pm_set_max_dev_wakeup_lat()
to identify the device requesting the constraint.  This is so repeated calls
to omap_pm_set_max_dev_wakeup_lat() with the same requesting device can
override the device's previously-set constraint.  Also, it allows the PM
core to make a decision as to whether or not the constraint should be
satisfied, based on the caller's identity.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/i2c.c                  |   12 +++++
 arch/arm/plat-omap/include/plat/omap-pm.h |   69 ++++++++++++++++-------------
 arch/arm/plat-omap/omap-pm-noop.c         |   34 +++++++++-----
 3 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index eec2b49..a5ce4f0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -138,6 +138,16 @@ static inline int omap1_i2c_add_bus(struct platform_device *pdev, int bus_id)
 	return platform_device_register(pdev);
 }
 
+/*
+ * XXX This function is a temporary compatibility wrapper - only
+ * needed until the I2C driver can be converted to call
+ * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
+ */
+static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
+{
+	omap_pm_set_max_mpu_wakeup_lat(dev, t);
+}
+
 static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
 {
 	struct resource *res;
@@ -168,7 +178,7 @@ static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
 		struct omap_i2c_bus_platform_data *pd;
 
 		pd = pdev->dev.platform_data;
-		pd->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat;
+		pd->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	}
 
 	return platform_device_register(pdev);
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 3ee41d7..3d468ba 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -1,8 +1,8 @@
 /*
  * omap-pm.h - OMAP power management interface
  *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
  * Paul Walmsley
  *
  * Interface developed by (in alphabetical order): Karthik Dasu, Jouni
@@ -89,7 +89,7 @@ void omap_pm_if_exit(void);
  * @t: maximum MPU wakeup latency in microseconds
  *
  * Request that the maximum interrupt latency for the MPU to be no
- * greater than 't' microseconds. "Interrupt latency" in this case is
+ * greater than @t microseconds. "Interrupt latency" in this case is
  * defined as the elapsed time from the occurrence of a hardware or
  * timer interrupt to the time when the device driver's interrupt
  * service routine has been entered by the MPU.
@@ -105,15 +105,19 @@ void omap_pm_if_exit(void);
  * elapsed from when a device driver enables a hardware device with
  * clk_enable(), to when the device is ready for register access or
  * other use.  To control this device wakeup latency, use
- * set_max_dev_wakeup_lat()
+ * omap_pm_set_max_dev_wakeup_lat()
  *
- * Multiple calls to set_max_mpu_wakeup_lat() will replace the
+ * Multiple calls to omap_pm_set_max_mpu_wakeup_lat() will replace the
  * previous t value.  To remove the latency target for the MPU, call
  * with t = -1.
  *
- * No return value.
+ * XXX This constraint will be deprecated soon in favor of the more
+ * general omap_pm_set_max_dev_wakeup_lat()
+ *
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
  */
-void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
+int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
 
 
 /**
@@ -123,8 +127,8 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
  * @r: minimum throughput (in KiB/s)
  *
  * Request that the minimum data throughput on the OCP interconnect
- * attached to device 'dev' interconnect agent 'tbus_id' be no less
- * than 'r' KiB/s.
+ * attached to device @dev interconnect agent @tbus_id be no less
+ * than @r KiB/s.
  *
  * It is expected that the OMAP PM or bus code will use this
  * information to set the interconnect clock to run at the lowest
@@ -138,40 +142,44 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
  * code will also need to add an minimum L3 interconnect speed
  * constraint,
  *
- * Multiple calls to set_min_bus_tput() will replace the previous rate
- * value for this device.  To remove the interconnect throughput
- * restriction for this device, call with r = 0.
+ * Multiple calls to omap_pm_set_min_bus_tput() will replace the
+ * previous rate value for this device.  To remove the interconnect
+ * throughput restriction for this device, call with r = 0.
  *
- * No return value.
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
  */
-void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
+int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
 
 
 /**
  * omap_pm_set_max_dev_wakeup_lat - set the maximum device enable latency
- * @dev: struct device *
+ * @req_dev: struct device * requesting the constraint, or NULL if none
+ * @dev: struct device * to set the constraint one
  * @t: maximum device wakeup latency in microseconds
  *
- * Request that the maximum amount of time necessary for a device to
- * become accessible after its clocks are enabled should be no greater
- * than 't' microseconds.  Specifically, this represents the time from
- * when a device driver enables device clocks with clk_enable(), to
- * when the register reads and writes on the device will succeed.
- * This function should be called before clk_disable() is called,
- * since the power state transition decision may be made during
- * clk_disable().
+ * Request that the maximum amount of time necessary for a device @dev
+ * to become accessible after its clocks are enabled should be no
+ * greater than @t microseconds.  Specifically, this represents the
+ * time from when a device driver enables device clocks with
+ * clk_enable(), to when the register reads and writes on the device
+ * will succeed.  This function should be called before clk_disable()
+ * is called, since the power state transition decision may be made
+ * during clk_disable().
  *
  * It is intended that underlying PM code will use this information to
  * determine what power state to put the powerdomain enclosing this
  * device into.
  *
- * Multiple calls to set_max_dev_wakeup_lat() will replace the
- * previous wakeup latency values for this device.  To remove the wakeup
- * latency restriction for this device, call with t = -1.
+ * Multiple calls to omap_pm_set_max_dev_wakeup_lat() will replace the
+ * previous wakeup latency values for this device.  To remove the
+ * wakeup latency restriction for this device, call with t = -1.
  *
- * No return value.
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
  */
-void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
+int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
+				   long t);
 
 
 /**
@@ -198,9 +206,10 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
  * value for this device.  To remove the maximum DMA latency for this
  * device, call with t = -1.
  *
- * No return value.
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
  */
-void omap_pm_set_max_sdma_lat(struct device *dev, long t);
+int omap_pm_set_max_sdma_lat(struct device *dev, long t);
 
 
 /*
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 186bca8..b0414f9 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -34,11 +34,11 @@ struct omap_opp *l3_opps;
  * Device-driver-originated constraints (via board-*.c files)
  */
 
-void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
+int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 {
 	if (!dev || t < -1) {
-		WARN_ON(1);
-		return;
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
 	};
 
 	if (t == -1)
@@ -58,14 +58,16 @@ void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
 	 *
 	 * TI CDP code can call constraint_set here.
 	 */
+
+	return 0;
 }
 
-void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
+int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
 	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
 	    agent_id != OCP_TARGET_AGENT)) {
-		WARN_ON(1);
-		return;
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
 	};
 
 	if (r == 0)
@@ -83,13 +85,16 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 	 *
 	 * TI CDP code can call constraint_set here on the VDD2 OPP.
 	 */
+
+	return 0;
 }
 
-void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
+int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
+				   long t)
 {
-	if (!dev || t < -1) {
-		WARN_ON(1);
-		return;
+	if (!req_dev || !dev || t < -1) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
 	};
 
 	if (t == -1)
@@ -111,13 +116,15 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
 	 *
 	 * TI CDP code can call constraint_set here.
 	 */
+
+	return 0;
 }
 
-void omap_pm_set_max_sdma_lat(struct device *dev, long t)
+int omap_pm_set_max_sdma_lat(struct device *dev, long t)
 {
 	if (!dev || t < -1) {
-		WARN_ON(1);
-		return;
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
 	};
 
 	if (t == -1)
@@ -139,6 +146,7 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long t)
 	 * TI CDP code can call constraint_set here.
 	 */
 
+	return 0;
 }
 
 


