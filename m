From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 25 May 2011 11:31:02 +0300
Message-ID: <1306312262.2062.16.camel@deskari>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	 <1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	 <1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
	 <87lixv1x3s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42880 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab1EYIbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 04:31:08 -0400
Received: by eyf5 with SMTP id 5so3160410eyf.15
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 01:31:05 -0700 (PDT)
In-Reply-To: <87lixv1x3s.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-05-24 at 16:45 -0700, Kevin Hilman wrote:
> Hi Tomi,
> 
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > On Wed, 2011-05-18 at 17:41 +0300, Tomi Valkeinen wrote:
> >> On Wed, 2011-05-18 at 16:24 +0200, Kevin Hilman wrote:
> >> 
> >> > Looking closer at the code, a zero return happens only when
> >> > 
> >> > 1) no hwmod associated to omap_device
> >> > 2) no power domain associated to hwmod
> >> > 3) power domain has not (yet) lost context
> >> > 
> >> > None of these are actually error conditions per-se, and in all cases, it
> >> > indidates that context has not been lost (or we can't tell if context
> >> > has been lost.) 
> >> 
> >> If the pm code cannot tell whether the context has been lost or not, the
> >> driver must assume it has been lost, do you agree? If so, the driver
> >> must handle zero return value differently, and always restore context.
> >> 
> >> > So I think the current code is correct.
> >> 
> >> How is it correct if it returns an error even if no error has happened
> >> =)? Either the code or the documentation is wrong.
> >> 
> >> How about the wrap-around case? Does the loss count go back to zero?
> >
> > Any conclusion on this?
> 
> Sorry for the lag... been travelling, and finally back home...
> 
> You're right, the code is just wrong here and would lead to strange
> return value checking in the callers to be correct.
> 
> I think the best fix for this problem is to use a signed return value
> which can wrap as expected, and then use return negative error codes
> (e.g. -ENODEV).
> 
> Care to send a patch?  or do you have any other suggestions for a fix?

Here's a patch. I'm not quite sure in what situations the functions
should return an error, but the code now returns -ENODEV if:

- device pointer given by the driver to
omap_pm_get_dev_context_loss_count() is NULL

- pwrdomain pointer given to pwrdm_get_context_loss_count() is NULL,
which should never happen, as the caller of that function already checks
the pwrdomain pointer

 Tomi


>From 11ce3b3bd1f5aac44aae7ab05725d77bc9ca3b42 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 25 May 2011 11:06:41 +0300
Subject: [PATCH] OMAP: change get_context_loss_count ret value to int

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
---
 arch/arm/mach-omap2/omap_hwmod.c              |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |   10 ++++++----
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   18 +++++++++++-------
 arch/arm/plat-omap/omap_device.c              |    2 +-
 8 files changed, 24 insertions(+), 18 deletions(-)

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
index 9af0847..83166f5 100644
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
@@ -953,7 +953,9 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 	for (i = 0; i < pwrdm->banks; i++)
 		count += pwrdm->ret_mem_off_counter[i];
 
-	pr_debug("powerdomain: %s: context loss count = %u\n",
+	count &= 0x7fffffff;
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
index b0471bb2..5bf7195 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -27,7 +27,7 @@
 #include <plat/omap_device.h>
 
 static bool off_mode_enabled;
-static u32 dummy_context_loss_counter;
+static int dummy_context_loss_counter;
 
 /*
  * Device-driver-originated constraints (via board-*.c files)
@@ -311,22 +311,26 @@ void omap_pm_disable_off_mode(void)
 
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
+			count = (count + 1) & 0x7fffffff;
+			dummy_context_loss_counter = count;
+		}
 	}
 
 	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
@@ -337,7 +341,7 @@ u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 
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



