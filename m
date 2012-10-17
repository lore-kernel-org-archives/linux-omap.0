From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
Date: Wed, 17 Oct 2012 18:34:01 +0300
Message-ID: <1350488043-5053-4-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322Ab2JQPjs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 11:39:48 -0400
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

current omap_device PM implementation defines
omap-specific *_noirq methods but uses the
generic versions for all other PM methods.

As it turns out, if a device decides to implement
non-runtime PM callbacks, we might fall into a
situation where the hwmod is still idled which
will generate an abort exception when we try
to access device's address space while clocks
are still gated.

In order to solve that, we implement all other
methods taking into account that devices might
not implement those, in which case we return
early.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

notice here that it would be far better to avoid the code duplication
and have another function (e.g. _od_generic_suspend/resume) which would
receive pm_message_t and omap_device as arguments so it can decide
what to do.

That can be done on a later version, though.

 arch/arm/plat-omap/omap_device.c | 145 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index cd84eac..60ce750 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -843,16 +843,159 @@ static int _od_resume_noirq(struct device *dev)
 
 	return pm_generic_resume_noirq(dev);
 }
+
+static int _od_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	if (!pm || !pm->suspend)
+		return 0;
+
+	/* Don't attempt suspend on a driver that is not bound */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
+		return 0;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+		omap_device_idle(pdev);
+	od->flags |= OMAP_DEVICE_SUSPENDED;
+
+	return 0;
+}
+
+static int _od_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->resume)
+		return 0;
+
+	if (od->flags & OMAP_DEVICE_SUSPENDED) {
+		od->flags &= ~OMAP_DEVICE_SUSPENDED;
+
+		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+			omap_device_enable(pdev);
+	}
+
+	return pm_generic_resume(dev);
+}
+
+static int _od_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	if (!pm || !pm->freeze)
+		return 0;
+
+	/* Don't attempt late suspend on a driver that is not bound */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
+		return 0;
+
+	ret = pm_generic_freeze(dev);
+	if (ret)
+		return ret;
+
+	if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+		omap_device_idle(pdev);
+	od->flags |= OMAP_DEVICE_SUSPENDED;
+
+	return 0;
+}
+
+static int _od_thaw(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->thaw)
+		return 0;
+
+	if (od->flags & OMAP_DEVICE_SUSPENDED) {
+		od->flags &= ~OMAP_DEVICE_SUSPENDED;
+
+		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+			omap_device_enable(pdev);
+	}
+
+	return pm_generic_thaw(dev);
+}
+
+static int _od_poweroff(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
+
+	if (!pm || !pm->poweroff)
+		return 0;
+
+	/* Don't attempt late suspend on a driver that is not bound */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
+		return 0;
+
+	ret = pm_generic_poweroff(dev);
+	if (ret)
+		return ret;
+
+	if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+		omap_device_idle(pdev);
+	od->flags |= OMAP_DEVICE_SUSPENDED;
+
+	return 0;
+}
+
+static int _od_restore(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->restore)
+		return 0;
+
+	if (od->flags & OMAP_DEVICE_SUSPENDED) {
+		od->flags &= ~OMAP_DEVICE_SUSPENDED;
+
+		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+			omap_device_enable(pdev);
+	}
+
+	return pm_generic_restore(dev);
+}
 #else
 #define _od_suspend_noirq NULL
 #define _od_resume_noirq NULL
+#define _od_suspend NULL
+#define _od_resume NULL
+#define _od_freeze NULL
+#define _od_thaw NULL
+#define _od_poweroff NULL
+#define _od_restore NULL
 #endif
 
 struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   _od_runtime_idle)
-		USE_PLATFORM_PM_SLEEP_OPS
+		.suspend = _od_suspend,
+		.resume = _od_resume,
+		.freeze = _od_freeze,
+		.thaw = _od_thaw,
+		.poweroff = _od_poweroff,
+		.restore = _od_restore,
 		.suspend_noirq = _od_suspend_noirq,
 		.resume_noirq = _od_resume_noirq,
 	}
-- 
1.8.0.rc0

