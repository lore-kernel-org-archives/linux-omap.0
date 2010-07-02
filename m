From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 20/20] OMAP: PM constraints: add omap_pm_set_min_clk_rate()
Date: Fri, 02 Jul 2010 09:30:06 -0600
Message-ID: <20100702152958.6221.35036.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45316 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912Ab0GBPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:06 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Imre Deak <imre.deak@nokia.com>

Add omap_pm_set_min_clk_rate().  This constraint is meant for use by
device drivers to translate a certain device-specific performance
constraint (e.g., "minimum polygons per second") to a clock rate for
the driver's device, given the driver's intimate knowledge of the
device hardware (e.g., device type, device hardware revision, firmware
revision, etc.)  From a general PM core perspective, clock rate is
probably the closest general analog to "performance" that is
available, but the exact mapping from a use-case-specific performance
constraint to clock rate must be done by the driver.  Drivers intended for
upstream merging shouldn't hardcode specific clock rates in their code
without basing those rates on some performance criteria requested through
the driver's subsystem (ideally, from userspace).

Imre Deak <imre.deak@nokia.com> described the need and use-case for
this constraint, and discussed the implementation - thanks, Imre.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/plat-omap/include/plat/omap-pm.h |   61 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c         |   27 +++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 3d468ba..728fbb9 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -16,6 +16,7 @@
 
 #include <linux/device.h>
 #include <linux/cpufreq.h>
+#include <linux/clk.h>
 
 #include "powerdomain.h"
 
@@ -212,6 +213,66 @@ int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 int omap_pm_set_max_sdma_lat(struct device *dev, long t);
 
 
+/**
+ * omap_pm_set_min_clk_rate - set minimum clock rate requested by @dev
+ * @dev: struct device * requesting the constraint
+ * @clk: struct clk * to set the minimum rate constraint on
+ * @r: minimum rate in Hz
+ *
+ * Request that the minimum clock rate on the device @dev's clk @clk
+ * be no less than @r Hz.
+ *
+ * It is expected that the OMAP PM code will use this information to
+ * find an OPP or clock setting that will satisfy this clock rate
+ * constraint, along with any other applicable system constraints on
+ * the clock rate or corresponding voltage, etc.
+ *
+ * omap_pm_set_min_clk_rate() differs from the clock code's
+ * clk_set_rate() in that it considers other constraints before taking
+ * any hardware action, and may change a system OPP rather than just a
+ * clock rate.  clk_set_rate() is intended to be a low-level
+ * interface.
+ *
+ * omap_pm_set_min_clk_rate() is easily open to abuse.  A better API
+ * would be something like "omap_pm_set_min_dev_performance()";
+ * however, there is no easily-generalizable concept of performance
+ * that applies to all devices.  Only a device (and possibly the
+ * device subsystem) has both the subsystem-specific knowledge, and
+ * the hardware IP block-specific knowledge, to translate a constraint
+ * on "touchscreen sampling accuracy" or "number of pixels or polygons
+ * rendered per second" to a clock rate.  This translation can be
+ * dependent on the hardware IP block's revision, or firmware version,
+ * and the driver is the only code on the system that has this
+ * information and can know how to translate that into a clock rate.
+ *
+ * The intended use-case for this function is for userspace or other
+ * kernel code to communicate a particular performance requirement to
+ * a subsystem; then for the subsystem to communicate that requirement
+ * to something that is meaningful to the device driver; then for the
+ * device driver to convert that requirement to a clock rate, and to
+ * then call omap_pm_set_min_clk_rate().
+ *
+ * Users of this function (such as device drivers) should not simply
+ * call this function with some high clock rate to ensure "high
+ * performance."  Rather, the device driver should take a performance
+ * constraint from its subsystem, such as "render at least X polygons
+ * per second," and use some formula or table to convert that into a
+ * clock rate constraint given the hardware type and hardware
+ * revision.  Device drivers or subsystems should not assume that they
+ * know how to make a power/performance tradeoff - some device use
+ * cases may tolerate a lower-fidelity device function for lower power
+ * consumption; others may demand a higher-fidelity device function,
+ * no matter what the power consumption.
+ *
+ * Multiple calls to omap_pm_set_min_clk_rate() will replace the
+ * previous rate value for the device @dev.  To remove the minimum clock
+ * rate constraint for the device, call with r = 0.
+ *
+ * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
+ * is not satisfiable, or 0 upon success.
+ */
+int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r);
+
 /*
  * DSP Bridge-specific constraints
  */
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index b0414f9..e129ce8 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -149,6 +149,33 @@ int omap_pm_set_max_sdma_lat(struct device *dev, long t)
 	return 0;
 }
 
+int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
+{
+	if (!dev || !c || r < 0) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	if (r == 0)
+		pr_debug("OMAP PM: remove min clk rate constraint: "
+			 "dev %s\n", dev_name(dev));
+	else
+		pr_debug("OMAP PM: add min clk rate constraint: "
+			 "dev %s, rate = %ld Hz\n", dev_name(dev), r);
+
+	/*
+	 * Code in a real implementation should keep track of these
+	 * constraints on the clock, and determine the highest minimum
+	 * clock rate.  It should iterate over each OPP and determine
+	 * whether the OPP will result in a clock rate that would
+	 * satisfy this constraint (and any other PM constraint in effect
+	 * at that time).  Once it finds the lowest-voltage OPP that
+	 * meets those conditions, it should switch to it, or return
+	 * an error if the code is not capable of doing so.
+	 */
+
+	return 0;
+}
 
 /*
  * DSP Bridge-specific constraints


