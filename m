From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH v3 6/7] omap3: Export omap3isp platform device structure
Date: Thu, 25 Nov 2010 03:54:37 +0100
Message-ID: <1290653678-15556-7-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53703 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab0KYCyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 21:54:35 -0500
In-Reply-To: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.ailus@maxwell.research.nokia.com

From: Stanimir Varbanov <svarbanov@mm-sol.com>

The omap3isp platform device requires platform data. As the data can be
provided by a kernel module, the device can't be registered during arch
initialization.

Remove the omap3isp platform device registration from
omap_init_camera(), and export the platform device structure to let
board code register/unregister it.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/devices.c |   18 ++++++++++++++++--
 arch/arm/mach-omap2/devices.h |   17 +++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/devices.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d5da345..c2275d3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -34,6 +34,8 @@
 #include "mux.h"
 #include "control.h"
 
+#include "devices.h"
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -144,16 +146,28 @@ static struct resource omap3isp_resources[] = {
 	}
 };
 
-static struct platform_device omap3isp_device = {
+static void omap3isp_release(struct device *dev)
+{
+	/* Zero the device structure to avoid re-initialization complaints from
+	 * kobject when the device will be re-registered.
+	 */
+	memset(dev, 0, sizeof(*dev));
+	dev->release = omap3isp_release;
+}
+
+struct platform_device omap3isp_device = {
 	.name		= "omap3isp",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(omap3isp_resources),
 	.resource	= omap3isp_resources,
+	.dev = {
+		.release	= omap3isp_release,
+	},
 };
+EXPORT_SYMBOL_GPL(omap3isp_device);
 
 static inline void omap_init_camera(void)
 {
-	platform_device_register(&omap3isp_device);
 }
 #else
 static inline void omap_init_camera(void)
diff --git a/arch/arm/mach-omap2/devices.h b/arch/arm/mach-omap2/devices.h
new file mode 100644
index 0000000..f312d49
--- /dev/null
+++ b/arch/arm/mach-omap2/devices.h
@@ -0,0 +1,17 @@
+/*
+ * arch/arm/mach-omap2/devices.h
+ *
+ * OMAP2 platform device setup/initialization
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP_DEVICES_H
+#define __ARCH_ARM_MACH_OMAP_DEVICES_H
+
+extern struct platform_device omap3isp_device;
+
+#endif
-- 
1.7.2.2

