From: "Basak, Partha" <p-basak2@ti.com>
Subject: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Tue, 3 Aug 2010 19:19:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867Ab0HCNts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 09:49:48 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Resending with the corrected mailing list

Hello Kevin,

I want to draw your attention to an issue the following patch introduces. http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=commitdiff;h=8041359e18e49bf8a3d41f15894db9e476f3a8fc


arch/arm/mach-omap2/pm_bus.c  patch | blob | history 
diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
index 9719a9f..5e453dc 100644 (file)

--- a/arch/arm/mach-omap2/pm_bus.c
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -68,3 +68,51 @@ int platform_pm_runtime_idle(struct device *dev)
 };
 #endif /* CONFIG_PM_RUNTIME */
 
+#ifdef CONFIG_SUSPEND
+int platform_pm_suspend_noirq(struct device *dev)
+{
+       struct device_driver *drv = dev->driver;
+       int ret = 0;
+
+       if (!drv)
+               return 0;
+
+       if (drv->pm) {
+               if (drv->pm->suspend_noirq)
+                       ret = drv->pm->suspend_noirq(dev);
+       }
+
+       /*
+        * The DPM core has done a 'get' to prevent runtime PM
+        * transitions during system PM.  This put is to balance
+        * out that get so that this device can now be runtime
+        * suspended.
+        */
+       pm_runtime_put_sync(dev);
+
+       return ret;
+}
+
+int platform_pm_resume_noirq(struct device *dev)
+{
+       struct device_driver *drv = dev->driver;
+       int ret = 0;
+
+       /* 
+        * This 'get' is to balance the 'put' in the above suspend_noirq
+        * method so that the runtime PM usage counting is in the same
+        * state it was when suspend was called.
+        */
+       pm_runtime_get_sync(dev);
+
+       if (!drv)
+               return 0;
+
+       if (drv->pm) {
+               if (drv->pm->resume_noirq)
+                       ret = drv->pm->resume_noirq(dev);
+       }
+
+       return ret;
+}
+#endif /* CONFIG_SUSPEND */

I believe, it is not correct to call the pm_runtime APIs from interrupt locked context since the underlying functions __pm_runtime_suspend & __pm_runtime_resume enable interrupts and call schedule().

Further, from a s/w layering standpoint, platform-bus is a deeper layer than the Runtime layer, which the runtime layer calls into. So it may not be correct to have this layer calling into pm_runtime(). It should directly call omap_device APIs.

We are facing a similar issue with a few drivers USB, UART & GPIO where, we need to enable/disable clocks & restore/save context in the CPU-Idle path with interrupts locked. 

As we are unable to use Runtime APIs, we are using omap_device APIs directly with the following modification in the .activate_funcion/ deactivate_funcion (example UART driver)

static int uart_idle_hwmod(struct omap_device *od)
{
	if (!irqs_disabled())
		omap_hwmod_idle(od->hwmods[0]);
	else
		_omap_hwmod_idle(od->hwmods[0]);

	return 0;
}

static int uart_enable_hwmod(struct omap_device *od)
{
	if (!irqs_disabled())
		omap_hwmod_enable(od->hwmods[0]);
	else
		_omap_hwmod_enable(od->hwmods[0]);

	return 0;
}

Can you feedback on my observations and comment on the approach taken for these drivers? (We will be posting out the refreshed patches for GPIO, WDT, Timers shortly).

Thanks
Partha
