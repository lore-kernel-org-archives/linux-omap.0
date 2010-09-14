From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/2] OMAP: omap_device: make all devices a child of a new parent device
Date: Tue, 14 Sep 2010 11:41:54 -0700
Message-ID: <1284489714-14705-2-git-send-email-khilman@deeprootsystems.com>
References: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45711 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab0INSmA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 14:42:00 -0400
Received: by pwi3 with SMTP id 3so2552594pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 11:41:59 -0700 (PDT)
In-Reply-To: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

From: Kevin Hilman <khilman@ti.com>

In order to help differentiate omap_devices from normal
platform_devices, make them all a parent of a new common parent
device.

Then, in order to determine if a platform_device is also an
omap_device, checking the parent is all that is needed.

Users of this feature are the runtime PM core for OMAP, where we need
to know if a device being passed in is an omap_device or not in order
to know whether to call the omap_device API with it.

In addition, all omap_devices will now show up under /sys/devices/omap
instead of /sys/devices/platform

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Changes since v1:
- renamed the device from omap_bus to omap_parent_device to be more
  clear that this is not a bus.

 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index bad4c3d..28e2d1a 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -36,6 +36,8 @@
 
 #include <plat/omap_hwmod.h>
 
+extern struct device omap_device_parent;
+
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
 #define OMAP_DEVICE_STATE_ENABLED	1
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7f05f49..8215b1b 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -465,6 +465,7 @@ int omap_device_register(struct omap_device *od)
 {
 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
 
+	od->pdev.dev.parent = &omap_device_parent;
 	return platform_device_register(&od->pdev);
 }
 
@@ -737,3 +738,14 @@ int omap_device_enable_clocks(struct omap_device *od)
 	/* XXX pass along return value here? */
 	return 0;
 }
+
+struct device omap_device_parent = {
+	.init_name	= "omap",
+	.parent         = &platform_bus,
+};
+
+static int __init omap_device_init(void)
+{
+	return device_register(&omap_device_parent);
+}
+core_initcall(omap_device_init);
-- 
1.7.2.1

