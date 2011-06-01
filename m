From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP: PM: omap_device: fix device power domain callbacks
Date: Tue, 31 May 2011 17:04:54 -0700
Message-ID: <1306886694-11092-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37352 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758505Ab1FAAE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 20:04:58 -0400
Received: by pzk9 with SMTP id 9so2258493pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 17:04:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsely <paul@pwsan.com>

After commit 4d27e9dcff00a6425d779b065ec8892e4f391661 (PM: Make power
domain callbacks take precedence over subsystem ones), the power
domain callbacks need to call the driver callbacks instead of relying
on the default subsystem (in this case, platform_bus) to handle the
driver callbacks.

Validated on 3430/n900, 3530/Overo.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Will be queued in my for_3.0/pm-fixes branch unless there are objections.

 arch/arm/plat-omap/omap_device.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index a37b8eb..49fc0df 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -84,6 +84,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -539,20 +540,34 @@ int omap_early_device_register(struct omap_device *od)
 static int _od_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
+
+	ret = pm_generic_runtime_suspend(dev);
+
+	if (!ret)
+		omap_device_idle(pdev);
+
+	return ret;
+}
 
-	return omap_device_idle(pdev);
+static int _od_runtime_idle(struct device *dev)
+{
+	return pm_generic_runtime_idle(dev);
 }
 
 static int _od_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 
-	return omap_device_enable(pdev);
+	omap_device_enable(pdev);
+
+	return pm_generic_runtime_resume(dev);
 }
 
 static struct dev_power_domain omap_device_power_domain = {
 	.ops = {
 		.runtime_suspend = _od_runtime_suspend,
+		.runtime_idle = _od_runtime_idle,
 		.runtime_resume = _od_runtime_resume,
 		USE_PLATFORM_PM_SLEEP_OPS
 	}
-- 
1.7.4

