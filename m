From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [RFC 4/4] ARM: OMAP: Add DT support for dmtimer driver
Date: Fri, 13 Jul 2012 17:19:35 -0500
Message-ID: <1342217976-29802-6-git-send-email-jon-hunter@ti.com>
References: <1342217976-29802-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342217976-29802-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
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
