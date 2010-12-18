From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: PM: implement context loss count APIs
Date: Fri, 17 Dec 2010 17:14:14 -0800
Message-ID: <1292634855-14728-2-git-send-email-khilman@deeprootsystems.com>
References: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62654 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381Ab0LRBOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:14:22 -0500
Received: by pva4 with SMTP id 4so204020pva.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 17:14:21 -0800 (PST)
In-Reply-To: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Implement OMAP PM layer omap_pm_get_dev_context_loss_count() API by
creating similar APIs at the omap_device and omap_hwmod levels.  The
omap_hwmod level call is the layer with access to the powerdomain
core, so it is the place where the powerdomain is queried to get the
context loss count.

The new APIs return an unsigned value that can wrap as the
context-loss count grows.  However, the wrapping is not important as
the role of this function is to determine context loss by checking for
any difference in subsequent calls to this function.

Note that these APIs at each level can return zero when no context
loss is detected, or on errors.  This is to avoid returning error
codes which could potentially be mistaken for large context loss
counters.

NOTE: only works for devices which have been converted to use
      omap_device/omap_hwmod.

Longer term, we could possibly remove this API from the OMAP PM layer,
and instead directly use the omap_device level API.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c              |   22 +++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap-pm-noop.c             |   23 +++++++++----------
 arch/arm/plat-omap/omap_device.c              |   28 +++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 81c1097..08da0f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2220,3 +2220,25 @@ ohsps_unlock:
 
 	return ret;
 }
+
+/**
+ * omap_hwmod_get_context_loss_count - get lost context count
+ * @oh: struct omap_hwmod *
+ *
+ * Query the powerdomain of of @oh to get the context loss
+ * count for this device.
+ *
+ * Returns the context loss count of the powerdomain assocated with @oh
+ * upon success, or zero if no powerdomain exists for @oh.
+ */
+u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
+{
+	struct powerdomain *pwrdm;
+	int ret = 0;
+
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	if (pwrdm)
+		ret = pwrdm_get_context_loss_count(pwrdm);
+
+	return ret;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 9870b4f..2f0bee8 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -368,9 +368,9 @@ unsigned long omap_pm_cpu_get_freq(void);
  * driver must restore device context.   If the number of context losses
  * exceeds the maximum positive integer, the function will wrap to 0 and
  * continue counting.  Returns the number of context losses for this device,
- * or -EINVAL upon error.
+ * or zero upon error.
  */
-int omap_pm_get_dev_context_loss_count(struct device *dev);
+u32 omap_pm_get_dev_context_loss_count(struct device *dev);
 
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 28e2d1a..e4c349f 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -107,6 +107,7 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
+u32 omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 62bdb23..3fdb574 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -568,6 +568,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 7578366..f7d1307 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -20,9 +20,11 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
+#include <plat/omap_device.h>
 
 struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
@@ -286,22 +288,19 @@ unsigned long omap_pm_cpu_get_freq(void)
  * Device context loss tracking
  */
 
-int omap_pm_get_dev_context_loss_count(struct device *dev)
+u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 {
-	if (!dev) {
-		WARN_ON(1);
-		return -EINVAL;
-	};
+	struct platform_device *pdev = to_platform_device(dev);
+	u32 count;
 
-	pr_debug("OMAP PM: returning context loss count for dev %s\n",
-		 dev_name(dev));
+	if (WARN_ON(!dev))
+		return 0;
 
-	/*
-	 * Map the device to the powerdomain.  Return the powerdomain
-	 * off counter.
-	 */
+	count = omap_device_get_context_loss_count(pdev);
+	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
+		 dev_name(dev), count);
 
-	return 0;
+	return count;
 }
 
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index abe933c..57adb27 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -280,6 +280,34 @@ static void _add_optional_clock_alias(struct omap_device *od,
 /* Public functions for use by core code */
 
 /**
+ * omap_device_get_context_loss_count - get lost context count
+ * @od: struct omap_device *
+ *
+ * Using the primary hwmod, query the context loss count for this
+ * device.
+ *
+ * Callers should consider context for this device lost any time this
+ * function returns a value different than the value the caller got
+ * the last time it called this function.
+ *
+ * If any hwmods exist for the omap_device assoiated with @pdev,
+ * return the context loss counter for that hwmod, otherwise return
+ * zero.
+ */
+u32 omap_device_get_context_loss_count(struct platform_device *pdev)
+{
+	struct omap_device *od;
+	u32 ret = 0;
+
+	od = _find_by_pdev(pdev);
+
+	if (od->hwmods_cnt)
+		ret = omap_hwmod_get_context_loss_count(od->hwmods[0]);
+
+	return ret;
+}
+
+/**
  * omap_device_count_resources - count number of struct resource entries needed
  * @od: struct omap_device *
  *
-- 
1.7.2.1

