From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/3] OMAP: bus-level PM: enable use of runtime PM API for suspend/resume
Date: Thu, 24 Jun 2010 16:43:10 -0700
Message-ID: <1277422991-25350-3-git-send-email-khilman@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48367 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0FXXnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:43:17 -0400
Received: by pvg2 with SMTP id 2so587022pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:43:16 -0700 (PDT)
In-Reply-To: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hook into the platform bus methods for suspend and resume and use the
runtime PM API to allow the OMAP runtime PM core (based on
omap_device) to automatically idle and enable the device on suspend
and resume.

This allows device drivers to get rid of direct management of their
clocks in their suspend/resume paths, and let omap_device do it for
them .

We currently use the _noirq (late suspend, early resume) versions of
the suspend/resume methods to ensure that the device is not disabled
too early for any drivers also using the _noirq methods.

NOTE: only works for devices with omap_hwmod support.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm_bus.c |   48 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
index 9719a9f..5e453dc 100644
--- a/arch/arm/mach-omap2/pm_bus.c
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -68,3 +68,51 @@ int platform_pm_runtime_idle(struct device *dev)
 };
 #endif /* CONFIG_PM_RUNTIME */
 
+#ifdef CONFIG_SUSPEND
+int platform_pm_suspend_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
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
+	/*
+	 * The DPM core has done a 'get' to prevent runtime PM
+	 * transitions during system PM.  This put is to balance
+	 * out that get so that this device can now be runtime
+	 * suspended.
+	 */
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
+int platform_pm_resume_noirq(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	/* 
+	 * This 'get' is to balance the 'put' in the above suspend_noirq
+	 * method so that the runtime PM usage counting is in the same
+	 * state it was when suspend was called.
+	 */
+	pm_runtime_get_sync(dev);
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

