From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] ARM: OMAP2+: Remove unused legacy code for timer
Date: Wed, 31 May 2017 15:51:30 -0700
Message-ID: <20170531225139.30723-3-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 172 ++++++--------------------------------------
 1 file changed, 20 insertions(+), 152 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -252,37 +252,27 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 					 const char **timer_name,
 					 int posted)
 {
-	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	const char *oh_name = NULL;
 	struct device_node *np;
 	struct omap_hwmod *oh;
-	struct resource irq, mem;
 	struct clk *src;
 	int r = 0;
 
-	if (of_have_populated_dt()) {
-		np = omap_get_timer_dt(omap_timer_match, property);
-		if (!np)
-			return -ENODEV;
+	np = omap_get_timer_dt(omap_timer_match, property);
+	if (!np)
+		return -ENODEV;
 
-		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-		if (!oh_name)
-			return -ENODEV;
+	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+	if (!oh_name)
+		return -ENODEV;
 
-		timer->irq = irq_of_parse_and_map(np, 0);
-		if (!timer->irq)
-			return -ENXIO;
+	timer->irq = irq_of_parse_and_map(np, 0);
+	if (!timer->irq)
+		return -ENXIO;
 
-		timer->io_base = of_iomap(np, 0);
+	timer->io_base = of_iomap(np, 0);
 
-		of_node_put(np);
-	} else {
-		if (omap_dm_timer_reserve_systimer(timer->id))
-			return -ENODEV;
-
-		sprintf(name, "timer%d", timer->id);
-		oh_name = name;
-	}
+	of_node_put(np);
 
 	oh = omap_hwmod_lookup(oh_name);
 	if (!oh)
@@ -290,22 +280,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	*timer_name = oh->name;
 
-	if (!of_have_populated_dt()) {
-		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL,
-						   &irq);
-		if (r)
-			return -ENXIO;
-		timer->irq = irq.start;
-
-		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL,
-						   &mem);
-		if (r)
-			return -ENXIO;
-
-		/* Static mapping, never released */
-		timer->io_base = ioremap(mem.start, mem.end - mem.start);
-	}
-
 	if (!timer->io_base)
 		return -ENXIO;
 
@@ -433,18 +407,15 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	const char *oh_name = "counter_32k";
 
 	/*
-	 * If device-tree is present, then search the DT blob
-	 * to see if the 32kHz counter is supported.
+	 * See if the 32kHz counter is supported.
 	 */
-	if (of_have_populated_dt()) {
-		np = omap_get_timer_dt(omap_counter_match, NULL);
-		if (!np)
-			return -ENODEV;
-
-		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-		if (!oh_name)
-			return -ENODEV;
-	}
+	np = omap_get_timer_dt(omap_counter_match, NULL);
+	if (!np)
+		return -ENODEV;
+
+	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+	if (!oh_name)
+		return -ENODEV;
 
 	/*
 	 * First check hwmod data is available for sync32k counter
@@ -462,18 +433,6 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 		return ret;
 	}
 
-	if (!of_have_populated_dt()) {
-		void __iomem *vbase;
-
-		vbase = omap_hwmod_get_mpu_rt_va(oh);
-
-		ret = omap_init_clocksource_32k(vbase);
-		if (ret) {
-			pr_warn("%s: failed to initialize counter_32k as a clocksource (%d)\n",
-					__func__, ret);
-			omap_hwmod_idle(oh);
-		}
-	}
 	return ret;
 }
 
@@ -544,8 +503,7 @@ void __init omap3_gptimer_timer_init(void)
 {
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
-	if (of_have_populated_dt())
-		clocksource_probe();
+	clocksource_probe();
 }
 #endif
 
@@ -689,96 +647,6 @@ void __init omap5_realtime_timer_init(void)
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
 /**
- * omap_timer_init - build and register timer device with an
- * associated timer hwmod
- * @oh:	timer hwmod pointer to be used to build timer device
- * @user:	parameter that can be passed from calling hwmod API
- *
- * Called by omap_hwmod_for_each_by_class to register each of the timer
- * devices present in the system. The number of timer devices is known
- * by parsing through the hwmod database for a given class name. At the
- * end of function call memory is allocated for timer device and it is
- * registered to the framework ready to be proved by the driver.
- */
-static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
-{
-	int id;
-	int ret = 0;
-	char *name = "omap_timer";
-	struct dmtimer_platform_data *pdata;
-	struct platform_device *pdev;
-	struct omap_timer_capability_dev_attr *timer_dev_attr;
-
-	pr_debug("%s: %s\n", __func__, oh->name);
-
-	/* on secure device, do not register secure timer */
-	timer_dev_attr = oh->dev_attr;
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP && timer_dev_attr)
-		if (timer_dev_attr->timer_capability == OMAP_TIMER_SECURE)
-			return ret;
-
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
-		return -ENOMEM;
-	}
-
-	/*
-	 * Extract the IDs from name field in hwmod database
-	 * and use the same for constructing ids' for the
-	 * timer devices. In a way, we are avoiding usage of
-	 * static variable witin the function to do the same.
-	 * CAUTION: We have to be careful and make sure the
-	 * name in hwmod database does not change in which case
-	 * we might either make corresponding change here or
-	 * switch back static variable mechanism.
-	 */
-	sscanf(oh->name, "timer%2d", &id);
-
-	if (timer_dev_attr)
-		pdata->timer_capability = timer_dev_attr->timer_capability;
-
-	pdata->timer_errata = omap_dm_timer_get_errata();
-	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
-
-	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata));
-
-	if (IS_ERR(pdev)) {
-		pr_err("%s: Can't build omap_device for %s: %s.\n",
-			__func__, name, oh->name);
-		ret = -EINVAL;
-	}
-
-	kfree(pdata);
-
-	return ret;
-}
-
-/**
- * omap2_dm_timer_init - top level regular device initialization
- *
- * Uses dedicated hwmod api to parse through hwmod database for
- * given class name and then build and register the timer device.
- */
-static int __init omap2_dm_timer_init(void)
-{
-	int ret;
-
-	/* If dtb is there, the devices will be created dynamically */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
-	ret = omap_hwmod_for_each_by_class("timer", omap_timer_init, NULL);
-	if (unlikely(ret)) {
-		pr_err("%s: device registration failed.\n", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-omap_arch_initcall(omap2_dm_timer_init);
-
-/**
  * omap2_override_clocksource - clocksource override with user configuration
  *
  * Allows user to override default clocksource, using kernel parameter
-- 
2.13.0
