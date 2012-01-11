From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP3: fix build on !CONFIG_IOMMU_API
Date: Wed, 11 Jan 2012 15:28:11 +0200
Message-ID: <1326288491-25146-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41592 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab2AKN3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 08:29:08 -0500
Received: by wibhm14 with SMTP id hm14so354766wib.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jan 2012 05:29:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Arik Nemtsov <arik@wizery.com>, Raja Govindraj <govindraj.raja@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

omap3isp depends on CONFIG_IOMMU_API, so avoid registering its
device (and defining its configuration structs) on !CONFIG_IOMMU_API.

This is generally nice to have, but more importantly, it fixes:

arch/arm/plat-omap/include/plat/iommu.h: In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:135: error: 'struct
dev_archdata' has no member named 'iommu'
arch/arm/mach-omap2/devices.c: In function 'omap3_init_camera':
arch/arm/mach-omap2/devices.c:222: error: 'struct dev_archdata' has no
member named 'iommu'
make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Which happens because while setting up the omap3isp device we try
to access the (now nonexistent) iommu member of dev_archdata.

Compile tested with omap2plus_defconfig on today's:

commit e343a895a9f342f239c5e3c5ffc6c0b1707e6244
Merge: 06792c4 193a667
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jan 10 18:04:27 2012 -0800

    Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost

Reported-by: Govindraj Raja <govindraj.raja@ti.com>
Reported-by: Arik Nemtsov <arik@wizery.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Sorry guys, my bad.

 arch/arm/mach-omap2/devices.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 46dfd1a..0b510ad 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,7 +28,6 @@
 #include <plat/board.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
-#include <plat/iommu.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -128,6 +127,10 @@ static struct platform_device omap2cam_device = {
 };
 #endif
 
+#if defined(CONFIG_IOMMU_API)
+
+#include <plat/iommu.h>
+
 static struct resource omap3isp_resources[] = {
 	{
 		.start		= OMAP3430_ISP_BASE,
@@ -224,6 +227,15 @@ int omap3_init_camera(struct isp_platform_data *pdata)
 	return platform_device_register(&omap3isp_device);
 }
 
+#else /* !CONFIG_IOMMU_API */
+
+int omap3_init_camera(struct isp_platform_data *pdata)
+{
+	return 0;
+}
+
+#endif
+
 static inline void omap_init_camera(void)
 {
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
-- 
1.7.5.4

