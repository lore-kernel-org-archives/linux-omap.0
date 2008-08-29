From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 14/15] OMAP3 camera driver: OMAP34XXCAM: Camera Base Address.
Date: Fri, 29 Aug 2008 18:34:17 -0500
Message-ID: <A24693684029E5489D1D202277BE89441191E335@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbYH2XeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 19:34:23 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7TNYHgZ003918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:34:22 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7TNYHok019394
	for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 18:34:17 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sergio Aguirre <saaguirre@ti.com>

ARM: OMAP: OMAP34XXCAM: Camera Base Address.

Adding OMAP 3 Camera registers base address, and Platform Device.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Sameer Venkatraman <sameerv@ti.com>
Signed-off-by: Mohit Jalori <mjalori@ti.com>
---
 arch/arm/plat-omap/include/mach-omap2/devices.c              |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat-omap/include/mach/omap34xx.h |    1 +
 2 files changed, 27 insertions(+)

--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -63,6 +63,7 @@
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
 
 #endif
 
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -50,6 +50,32 @@
 {
 	platform_device_register(&omap_cam_device);
 }
+
+#elif defined(CONFIG_VIDEO_OMAP3) || defined(CONFIG_VIDEO_OMAP3_MODULE)
+
+static struct resource cam_resources[] = {
+	{
+		.start		= OMAP34XX_CAMERA_BASE,
+		.end		= OMAP34XX_CAMERA_BASE + 0x1B70,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_34XX_CAM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap_cam_device = {
+	.name		= "omap34xxcam",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(cam_resources),
+	.resource	= cam_resources,
+};
+
+static inline void omap_init_camera(void)
+{
+	platform_device_register(&omap_cam_device);
+}
 #else
 static inline void omap_init_camera(void)
 {
