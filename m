From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC RESEND 4/4] ARM: OMAP: Add DT support for timer driver
Date: Fri, 13 Jul 2012 17:26:53 -0500
Message-ID: <1342218413-30116-5-git-send-email-jon-hunter@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44233 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab2GMW3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 18:29:35 -0400
In-Reply-To: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

In order to add device-tree support to the timer driver the following changes
were made ...

1. If DT blob is present, then let HWMOD create the timer devices dynamically.
2. When device-tree is present the "id" field in the platform_device structure
   (pdev->id) is initialised to -1 and the timer instance is looked-up using the
   device tree alias mechanism. Therefore, avoid using "pdev-id" in the driver
   and use "timer->id" which will be initialised correctly regardless of whether
   device tree is present.
3. When device-tree is present the platform_data structure will be NULL and so
   check for this.
4. The OMAP timer device tree binding optional parameters ...
	a. ti,timer-alwon  --> Timer is in an always-on power domain
	b. ti,timer-pwn    --> Timer can generate a PWM output
   Search for the above parameters and set the appropriate timer attribute
   flags.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c  |    4 ++++
 arch/arm/plat-omap/dmtimer.c |   32 ++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e3b9931..ad5b29a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -473,6 +473,10 @@ static int __init omap2_dm_timer_init(void)
 {
 	int ret;
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	ret = omap_hwmod_for_each_by_class("timer", omap_timer_init, NULL);
 	if (unlikely(ret)) {
 		pr_err("%s: device registration failed.\n", __func__);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 626ad8c..5a51b67 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -40,6 +40,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
@@ -123,7 +125,7 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	omap_dm_timer_enable(timer);
-	if (timer->pdev->id != 1) {
+	if (timer->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
@@ -214,7 +216,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(t, &omap_timer_list, node) {
-		if (t->pdev->id == id && !t->reserved) {
+		if (t->id == id && !t->reserved) {
 			timer = t;
 			timer->reserved = 1;
 			break;
@@ -414,7 +416,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	 * use the clock framework to set the parent clock. To be removed
 	 * once OMAP1 migrated to using clock framework for dmtimers
 	 */
-	if (pdata->set_timer_src)
+	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
 	fclk = clk_get(&timer->pdev->dev, "fck");
@@ -695,7 +697,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata) {
+	if (!pdata && !dev->of_node) {
 		dev_err(dev, "%s: no platform data.\n", __func__);
 		return -ENODEV;
 	}
@@ -724,11 +726,21 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	timer->id = pdev->id;
+	if (dev->of_node) {
+		timer->id = of_alias_get_id(dev->of_node, "timer");
+
+		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
+			timer->capability |= OMAP_TIMER_ALWON;
+		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
+			timer->capability |= OMAP_TIMER_HAS_PWM;
+	} else {
+		timer->id = pdev->id;
+		timer->capability = pdata->timer_capability;
+	}
+
 	timer->irq = irq->start;
 	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
@@ -778,11 +790,19 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id omap_timer_match[] = {
+	{ .compatible = "ti,omap3-timer", },
+	{ .compatible = "ti,omap2-timer", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_timer_match);
+
 static struct platform_driver omap_dm_timer_driver = {
 	.probe  = omap_dm_timer_probe,
 	.remove = __devexit_p(omap_dm_timer_remove),
 	.driver = {
 		.name   = "omap_timer",
+		.of_match_table = of_match_ptr(omap_timer_match),
 	},
 };
 
-- 
1.7.9.5

