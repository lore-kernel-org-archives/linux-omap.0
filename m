From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/27] OMAP: change get_context_loss_count ret value to int
Date: Fri,  3 Jun 2011 13:00:11 +0300
Message-ID: <1307095237-14805-2-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41956 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab1FCKBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:03 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

get_context_loss_count functions return context loss count as u32, and
zero means an error. However, zero is also returned when context has
never been lost and could also be returned when the context loss count
has wrapped and goes to zero.

Change the functions to return an int, with negative value meaning an
error.

OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
hsmmc code handles the returned value as an int, with negative value
meaning an error, this patch actually fixes hsmmc code also.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c              |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |   14 ++++++++++----
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   24 +++++++++++++++++-------
 arch/arm/plat-omap/omap_device.c              |    2 +-
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e034294..4f0d554 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2332,7 +2332,7 @@ ohsps_unlock:
  * Returns the context loss count of the powerdomain assocated with @oh
  * upon success, or zero if no powerdomain exists for @oh.
  */
-u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
+int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 {
 	struct powerdomain *pwrdm;
 	int ret = 0;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9af0847..9d53a34 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -935,16 +935,16 @@ int pwrdm_post_transition(void)
  * @pwrdm: struct powerdomain * to wait for
  *
  * Context loss count is the sum of powerdomain off-mode counter, the
- * logic off counter and the per-bank memory off counter.  Returns 0
+ * logic off counter and the per-bank memory off counter.  Returns negative
  * (and WARNs) upon error, otherwise, returns the context loss count.
  */
-u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
+int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 {
 	int i, count;
 
 	if (!pwrdm) {
 		WARN(1, "powerdomain: %s: pwrdm is null\n", __func__);
-		return 0;
+		return -ENODEV;
 	}
 
 	count = pwrdm->state_counter[PWRDM_POWER_OFF];
@@ -953,7 +953,13 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 	for (i = 0; i < pwrdm->banks; i++)
 		count += pwrdm->ret_mem_off_counter[i];
 
-	pr_debug("powerdomain: %s: context loss count = %u\n",
+	/*
+	 * Context loss count has to be a non-negative value. Clear the sign
+	 * bit to get a value range from 0 to INT_MAX.
+	 */
+	count &= INT_MAX;
+
+	pr_debug("powerdomain: %s: context loss count = %d\n",
 		 pwrdm->name, count);
 
 	return count;
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index d23d979..012827f 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -207,7 +207,7 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
-u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
+int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index c0a7520..68df031 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -350,9 +350,9 @@ unsigned long omap_pm_cpu_get_freq(void);
  * driver must restore device context.   If the number of context losses
  * exceeds the maximum positive integer, the function will wrap to 0 and
  * continue counting.  Returns the number of context losses for this device,
- * or zero upon error.
+ * or negative value upon error.
  */
-u32 omap_pm_get_dev_context_loss_count(struct device *dev);
+int omap_pm_get_dev_context_loss_count(struct device *dev);
 
 void omap_pm_enable_off_mode(void);
 void omap_pm_disable_off_mode(void);
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..70d31d0 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -107,7 +107,7 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
-u32 omap_device_get_context_loss_count(struct platform_device *pdev);
+int omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..8658e2d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -598,7 +598,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
-u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
+int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index b0471bb2..3dc3801 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -27,7 +27,7 @@
 #include <plat/omap_device.h>
 
 static bool off_mode_enabled;
-static u32 dummy_context_loss_counter;
+static int dummy_context_loss_counter;
 
 /*
  * Device-driver-originated constraints (via board-*.c files)
@@ -311,22 +311,32 @@ void omap_pm_disable_off_mode(void)
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-u32 omap_pm_get_dev_context_loss_count(struct device *dev)
+int omap_pm_get_dev_context_loss_count(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 count;
+	int count;
 
 	if (WARN_ON(!dev))
-		return 0;
+		return -ENODEV;
 
 	if (dev->parent == &omap_device_parent) {
 		count = omap_device_get_context_loss_count(pdev);
 	} else {
 		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter; device %s should be converted to omap_device",
 			  dev_name(dev));
-		if (off_mode_enabled)
-			dummy_context_loss_counter++;
+
 		count = dummy_context_loss_counter;
+
+		if (off_mode_enabled) {
+			count++;
+			/*
+			 * Context loss count has to be a non-negative value.
+			 * Clear the sign bit to get a value range from 0 to
+			 * INT_MAX.
+			 */
+			count &= INT_MAX;
+			dummy_context_loss_counter = count;
+		}
 	}
 
 	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
@@ -337,7 +347,7 @@ u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 
 #else
 
-u32 omap_pm_get_dev_context_loss_count(struct device *dev)
+int omap_pm_get_dev_context_loss_count(struct device *dev)
 {
 	return dummy_context_loss_counter;
 }
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..9753f71 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -310,7 +310,7 @@ static void _add_optional_clock_clkdev(struct omap_device *od,
  * return the context loss counter for that hwmod, otherwise return
  * zero.
  */
-u32 omap_device_get_context_loss_count(struct platform_device *pdev)
+int omap_device_get_context_loss_count(struct platform_device *pdev)
 {
 	struct omap_device *od;
 	u32 ret = 0;
-- 
1.7.4.1

