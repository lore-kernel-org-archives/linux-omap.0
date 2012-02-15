From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP: remove omap_device_parent
Date: Wed, 15 Feb 2012 11:58:30 -0800
Message-ID: <1329335910-27243-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:51428 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909Ab2BOT57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 14:57:59 -0500
Received: by mail-pw0-f52.google.com with SMTP id jt11so2258038pbb.39
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 11:57:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Currently all omap_devices are forced to have the dummy device
'omap_device_parent' as a parent.  This was used to distinguish
omap_devices from "normal" platform_devices in the OMAP PM core code.

Now that we implement the PM core using PM domains, this is no longer
needed.

This also frees up omap_devices to have a more complex parent/child
relationships.

The only in-tree user of omap_device_parent was the OMAP PM layer
to handle lost-context count for omap_devices.  That was converted
to use the presence of the omap_device_pm_domain instead.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |    2 +-
 arch/arm/plat-omap/omap_device.c              |   12 ++----------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 51423d2..d93ac93 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -36,7 +36,7 @@
 
 #include <plat/omap_hwmod.h>
 
-extern struct device omap_device_parent;
+extern struct dev_pm_domain omap_device_pm_domain;
 
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 3dc3801..5a97b4d 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -319,7 +319,7 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 	if (WARN_ON(!dev))
 		return -ENODEV;
 
-	if (dev->parent == &omap_device_parent) {
+	if (dev->pm_domain == &omap_device_pm_domain) {
 		count = omap_device_get_context_loss_count(pdev);
 	} else {
 		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter; device %s should be converted to omap_device",
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index e8d9869..3643900 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -320,8 +320,6 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
 }
 
 
-static struct dev_pm_domain omap_device_pm_domain;
-
 /**
  * omap_device_build_from_dt - build an omap_device with multiple hwmods
  * @pdev_name: name of the platform_device driver to use
@@ -799,7 +797,7 @@ static int _od_resume_noirq(struct device *dev)
 #define _od_resume_noirq NULL
 #endif
 
-static struct dev_pm_domain omap_device_pm_domain = {
+struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   _od_runtime_idle)
@@ -821,7 +819,6 @@ static int omap_device_register(struct platform_device *pdev)
 {
 	pr_debug("omap_device: %s: registering\n", pdev->name);
 
-	pdev->dev.parent = &omap_device_parent;
 	pdev->dev.pm_domain = &omap_device_pm_domain;
 	return platform_device_add(pdev);
 }
@@ -1130,11 +1127,6 @@ int omap_device_enable_clocks(struct omap_device *od)
 	return 0;
 }
 
-struct device omap_device_parent = {
-	.init_name	= "omap",
-	.parent         = &platform_bus,
-};
-
 static struct notifier_block platform_nb = {
 	.notifier_call = _omap_device_notifier_call,
 };
@@ -1142,6 +1134,6 @@ static struct notifier_block platform_nb = {
 static int __init omap_device_init(void)
 {
 	bus_register_notifier(&platform_bus_type, &platform_nb);
-	return device_register(&omap_device_parent);
+	return 0;
 }
 core_initcall(omap_device_init);
-- 
1.7.9

