From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Thu, 27 May 2010 14:13:18 -0700
Message-ID: <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:64008 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab0E0VN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:26 -0400
Received: by mail-pz0-f176.google.com with SMTP id 6so314656pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:26 -0700 (PDT)
In-Reply-To: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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

