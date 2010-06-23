From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: PM: use omap_device API for suspend/resume
Date: Wed, 23 Jun 2010 16:37:03 -0700
Message-ID: <1277336224-24826-3-git-send-email-khilman@deeprootsystems.com>
References: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52071 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab0FWXhK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:37:10 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so1604422pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:37:10 -0700 (PDT)
In-Reply-To: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hook into the platform bus methods for suspend and resume and
use the omap_device API to automatically idle and enable the
device on suspend and resume.

This allows device drivers to get rid of direct management of their
clocks in their suspend/resume paths, and let omap_device do it for
them.

We currently use the _noirq (late suspend, early resume) versions of
the suspend/resume methods to ensure that the device is not disabled
too early for any drivers also using the _noirq methods.

NOTE: only works for devices with omap_hwmod support.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm_bus.c |   61 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
index 69acaa5..3787da8 100644
--- a/arch/arm/mach-omap2/pm_bus.c
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -70,3 +70,64 @@ int platform_pm_runtime_idle(struct device *dev)
 };
 #endif /* CONFIG_PM_RUNTIME */
 
+#ifdef CONFIG_SUSPEND
+int platform_pm_suspend_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->suspend_noirq)
+			ret = drv->pm->suspend_noirq(dev);
+	}
+
+	if (omap_device_is_valid(odev)) {
+		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
+			dev_dbg(dev, "no automatic bus-level system resume.\n");
+			return 0;
+		}
+
+		dev_dbg(dev, "%s\n", __func__);
+		omap_device_idle(pdev);
+	} else {
+		dev_dbg(dev, "not an omap_device\n");
+	}
+
+	return ret;
+}
+
+int platform_pm_resume_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int ret = 0;
+
+	if (omap_device_is_valid(odev)) {
+		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
+			dev_dbg(dev, "no automatic bus-level system resume.\n");
+			return 0;
+		}
+
+		dev_dbg(dev, "%s\n", __func__);
+		omap_device_enable(pdev);
+	} else {
+		dev_dbg(dev, "not an omap_device\n");
+	}
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->resume_noirq)
+			ret = drv->pm->resume_noirq(dev);
+	}
+
+	return ret;
+}
+#endif /* CONFIG_SUSPEND */
-- 
1.7.0.2

