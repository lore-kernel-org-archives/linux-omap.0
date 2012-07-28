From: Rob Clark <rob.clark@linaro.org>
Subject: [RFC 2/3] omap2+: use dss_dispc hwmod for omapdrm
Date: Fri, 27 Jul 2012 20:07:53 -0500
Message-ID: <1343437674-24246-3-git-send-email-rob.clark@linaro.org>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46849 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2G1BIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 21:08:42 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5089501obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 18:08:41 -0700 (PDT)
In-Reply-To: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

We need this so that platform_get_irq() works when drm core sets up the
irq handling.

Signed-off-by: Rob Clark <rob@ti.com>
---
 arch/arm/mach-omap2/drm.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4ab7b6a..f7a2444 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -33,18 +33,6 @@
 #include <plat/drm.h>
 
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
-
-static struct omap_drm_platform_data omapdrm_platdata;
-
-static struct platform_device omap_drm_device = {
-		.dev = {
-			.coherent_dma_mask = DMA_BIT_MASK(32),
-			.platform_data = &omapdrm_platdata,
-		},
-		.name = "omapdrm",
-		.id = 0,
-};
-
 static int __init omap_init_drm(void)
 {
 	struct omap_hwmod *oh = NULL;
@@ -60,8 +48,16 @@ static int __init omap_init_drm(void)
 			oh->name);
 	}
 
-	return platform_device_register(&omap_drm_device);
+	/* lookup and populate DSS information: */
+	oh = omap_hwmod_lookup("dss_dispc");
+	pdev = omap_device_build("omapdrm", -1, oh, NULL, 0, NULL, 0,
+			false);
+	WARN(IS_ERR(pdev), "Could not build omap_device for omapdrm\n");
 
+	if (!pdev)
+		return -EINVAL;
+
+	return 0;
 }
 
 arch_initcall(omap_init_drm);
@@ -69,12 +65,14 @@ arch_initcall(omap_init_drm);
 void __init omapdrm_reserve_vram(void)
 {
 #ifdef CONFIG_CMA
+#if 0 /* TODO add this back for omap3 */
 	/*
 	 * Create private 32MiB contiguous memory area for omapdrm.0 device
 	 * TODO revisit size.. if uc/wc buffers are allocated from CMA pages
 	 * then the amount of memory we need goes up..
 	 */
 	dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0, 0);
+#endif
 #else
 #  warning "CMA is not enabled, there may be limitations about scanout buffer allocations on OMAP3 and earlier"
 #endif
-- 
1.7.9.5

