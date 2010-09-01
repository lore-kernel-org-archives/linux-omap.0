From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/2] OMAP: omap_device: make all devices a child of a new omap_bus device
Date: Wed,  1 Sep 2010 10:37:42 -0700
Message-ID: <1283362662-8383-2-git-send-email-khilman@deeprootsystems.com>
References: <1283362662-8383-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55602 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab0IARhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 13:37:47 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2955620pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 10:37:47 -0700 (PDT)
In-Reply-To: <1283362662-8383-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

From: Kevin Hilman <khilman@ti.com>

In order to help differentiate omap_devices from normal
platform_devices, make them all a parent of a new omap_bus device.

Then, in order to determine if a platform_device is also an
omap_device, checking the parent is all that is needed.

Users of this feature are the runtime PM core for OMAP, where we need
to know if a device being passed in is an omap_device or not in order
to know whether to call the omap_device API with it.

In addition, all omap_devices will now show up under /sys/devices/omap
instead of /sys/devices/platform

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
since v1:
- misc. cleanup as suggested by Thara.  But, chose to leave out 
  the handling of a failed device_register(), since the failure
  of a parent-less device_register() is extrememly unlikely and
  is not handled for the platform_bus either.  


 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index bad4c3d..26d0c10 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -36,6 +36,8 @@
 
 #include <plat/omap_hwmod.h>
 
+extern struct device omap_bus;
+
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
 #define OMAP_DEVICE_STATE_ENABLED	1
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7f05f49..8b8f006 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -465,6 +465,7 @@ int omap_device_register(struct omap_device *od)
 {
 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
 
+	od->pdev.dev.parent = &omap_bus;
 	return platform_device_register(&od->pdev);
 }
 
@@ -737,3 +738,13 @@ int omap_device_enable_clocks(struct omap_device *od)
 	/* XXX pass along return value here? */
 	return 0;
 }
+
+struct device omap_bus = {
+	.init_name	= "omap",
+};
+
+static int __init omap_device_init(void)
+{
+	return device_register(&omap_bus);
+}
+core_initcall(omap_device_init);
-- 
1.7.2.1

