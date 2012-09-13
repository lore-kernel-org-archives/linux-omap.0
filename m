From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 7/7] ARM: OMAP: Add DT support for timer driver
Date: Thu, 13 Sep 2012 18:31:31 -0500
Message-ID: <1347579091-3794-8-git-send-email-jon-hunter@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50064 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759058Ab2IMXcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 19:32:03 -0400
In-Reply-To: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

In order to add device-tree support to the timer driver the following changes
were made ...

1. Allocate system timers (used for clock-events and clock-source) based upon
   timer properties rather than using an hard-coded timer instance ID. To allow
   this a new helper function called omap_dmtimer_find_by_property() has been
   added for finding a timer with the particular properties in the device-tree
   blob. Please note that this is an internal helper function for system timers
   only to find a timer in the device-tree blob. This cannot be used by device
   drivers, another API has been added for that (see below). Timers that are
   allocated for system timers are dynamically disabled at boot time by adding
   a status property with the value "disabled" to the timer's device-tree node.

   Please note that when allocating system timers we now pass a timer ID and
   timer property. The timer ID is only be used for allocating a timer when
   booting without device-tree. Once device-tree migration is complete, all
   the timer ID references will be removed.

2. If DT blob is present, then let device-tree create the timer devices
   dynamically.

3. When device-tree is present the "id" field in the platform_device structure
   (pdev->id) is initialised to -1 and hence cannot be used to identify a timer
   instance. Due to this the following changes were made ...
   a). The API omap_dm_timer_request_specific() is not supported when using
       device-tree, because it uses the device ID to request a specific timer.
       This function will return an error if called when device-tree is present.
       Users of this API should use omap_dm_timer_request_by_cap() instead.
   b). When removing the DMTIMER driver, the timer "id" was used to identify the
       timer instance. The remove function has been modified to use the device
       name instead of the "id".

4. When device-tree is present the platform_data structure will be NULL and so
   check for this.

5. The OMAP timer device tree binding has the following optional parameters ...
   a). ti,timer-alwon  --> Timer is in an always-on power domain
   b). ti,timer-dsp    --> Timer can generate an interrupt to the on-chip DSP
   c). ti,timer-pwm    --> Timer can generate a PWM output
   d). ti,timer-secure --> Timer is reserved on a secure OMAP device
   Search for the above parameters and set the appropriate timer attribute
   flags.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c  |   96 +++++++++++++++++++++++++++++++++---------
 arch/arm/plat-omap/dmtimer.c |   41 +++++++++++++++---
 2 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 60d43c8..d1c7771 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -58,16 +58,20 @@
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
 
+#define TIMER_PROP_ALWON	"ti,timer-alwon"
+
 #ifdef CONFIG_OMAP_32K_TIMER
 #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
 #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
 #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
 #define OMAP3_SECURE_TIMER	12
+#define TIMER_PROP_SECURE	"ti,timer-secure"
 #else
 #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
 #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
 #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
 #define OMAP3_SECURE_TIMER	1
+#define TIMER_PROP_SECURE	TIMER_PROP_ALWON
 #endif
 
 /* Clockevent code */
@@ -171,20 +175,63 @@ void __init omap_dmtimer_init(void)
 	}
 }
 
+/**
+ * omap_dmtimer_find_by_property - find timer in device-tree by property
+ *
+ * Helper function for finding a timer to be used as kernel system timer
+ * using device-tree. Optionally, the property argument can be used to
+ * select a timer with a specific property. Once a timer is found then
+ * mark the timer node in device-tree as disabled to prevent the kernel
+ * from registering this timer and so no other device can use it.
+ */
+static const char * __init omap_dmtimer_find_by_property(const char *property)
+{
+	struct device_node *np;
+	const char *oh_name;
+
+	for_each_matching_node(np, omap_timer_match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		if (property && !of_get_property(np, property, NULL))
+			continue;
+
+		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+		if (oh_name) {
+			prom_add_property(np, &timer_disabled);
+			return oh_name;
+		}
+	}
+
+	return NULL;
+}
+
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 						int gptimer_id,
-						const char *fck_source)
+						const char *fck_source,
+						const char *property)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
+	const char *oh_name;
 	struct omap_hwmod *oh;
 	struct resource irq_rsrc, mem_rsrc;
 	size_t size;
 	int res = 0;
 	int r;
 
-	sprintf(name, "timer%d", gptimer_id);
-	omap_hwmod_setup_one(name);
-	oh = omap_hwmod_lookup(name);
+	oh_name = name;
+
+	if (of_have_populated_dt())
+		oh_name = omap_dmtimer_find_by_property(property);
+	else
+		sprintf(name, "timer%d", gptimer_id);
+
+	if (!oh_name)
+		return -ENODEV;
+
+	omap_hwmod_setup_one(oh_name);
+	oh = omap_hwmod_lookup(oh_name);
+
 	if (!oh)
 		return -ENODEV;
 
@@ -211,9 +258,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
-	if (omap_dm_timer_reserve_systimer(gptimer_id))
-		return -ENODEV;
+	if (!of_have_populated_dt())
+		if (omap_dm_timer_reserve_systimer(gptimer_id))
+			return -ENODEV;
 
+	/* FIXME: Need to remove hard-coded test on timer ID */
 	if (gptimer_id != 12) {
 		struct clk *src;
 
@@ -223,8 +272,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		} else {
 			res = __omap_dm_timer_set_source(timer->fclk, src);
 			if (IS_ERR_VALUE(res))
-				pr_warning("%s: timer%i cannot set source\n",
-						__func__, gptimer_id);
+				pr_warn("%s: %s cannot set source\n",
+					__func__, oh->name);
 			clk_put(src);
 		}
 	}
@@ -240,11 +289,12 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 }
 
 static void __init omap2_gp_clockevent_init(int gptimer_id,
-						const char *fck_source)
+						const char *fck_source,
+						const char *property)
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
+	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = (void *)&clkev;
@@ -341,7 +391,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL);
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
@@ -375,11 +425,11 @@ static void __init omap2_clocksource_init(int gptimer_id,
 		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
 }
 
-#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
+#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
 				clksrc_nr, clksrc_src)			\
 static void __init omap##name##_timer_init(void)			\
 {									\
-	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
+	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
 }
 
@@ -389,20 +439,23 @@ struct sys_timer omap##name##_timer = {					\
 };
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP2_MPU_SOURCE)
 OMAP_SYS_TIMER(2)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3)
 OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
-			2, OMAP3_MPU_SOURCE)
+			TIMER_PROP_SECURE, 2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3_secure)
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE)
 OMAP_SYS_TIMER(3_am33xx)
 #endif
 
@@ -415,7 +468,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
 
 static void __init omap4_timer_init(void)
 {
-	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
+	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE, TIMER_PROP_ALWON);
 	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
 #ifdef CONFIG_LOCAL_TIMERS
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
@@ -437,7 +490,8 @@ OMAP_SYS_TIMER(4)
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-OMAP_SYS_TIMER_INIT(5, 1, OMAP4_CLKEV_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(5, 1, OMAP4_CLKEV_SOURCE, TIMER_PROP_ALWON,
+		    2, OMAP4_MPU_SOURCE)
 OMAP_SYS_TIMER(5)
 #endif
 
@@ -515,6 +569,10 @@ static int __init omap2_dm_timer_init(void)
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
index 061a0b9..9a4482f 100644
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
@@ -212,6 +214,13 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 	unsigned long flags;
 	int ret = 0;
 
+	/* Requesting timer by ID is not supported when device tree is used */
+	if (of_have_populated_dt()) {
+		pr_warn("%s: Please use omap_dm_timer_request_by_cap()\n",
+			__func__);
+		return NULL;
+	}
+
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(t, &omap_timer_list, node) {
 		if (t->pdev->id == id && !t->reserved) {
@@ -467,7 +476,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	 * use the clock framework to set the parent clock. To be removed
 	 * once OMAP1 migrated to using clock framework for dmtimers
 	 */
-	if (pdata->set_timer_src)
+	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
 	fclk = clk_get(&timer->pdev->dev, "fck");
@@ -748,7 +757,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata) {
+	if (!pdata && !dev->of_node) {
 		dev_err(dev, "%s: no platform data.\n", __func__);
 		return -ENODEV;
 	}
@@ -777,11 +786,23 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	timer->id = pdev->id;
+	if (dev->of_node) {
+		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
+			timer->capability |= OMAP_TIMER_ALWON;
+		if (of_find_property(dev->of_node, "ti,timer-dsp", NULL))
+			timer->capability |= OMAP_TIMER_HAS_DSP_IRQ;
+		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
+			timer->capability |= OMAP_TIMER_HAS_PWM;
+		if (of_find_property(dev->of_node, "ti,timer-secure", NULL))
+			timer->capability |= OMAP_TIMER_SECURE;
+	} else {
+		timer->id = pdev->id;
+		timer->capability = pdata->timer_capability;
+		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
+	}
+
 	timer->irq = irq->start;
-	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
-	timer->capability = pdata->timer_capability;
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
@@ -821,7 +842,8 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(timer, &omap_timer_list, node)
-		if (timer->pdev->id == pdev->id) {
+		if (!strcmp(dev_name(&timer->pdev->dev),
+			    dev_name(&pdev->dev))) {
 			list_del(&timer->node);
 			ret = 0;
 			break;
@@ -831,11 +853,18 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id omap_timer_match[] = {
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

