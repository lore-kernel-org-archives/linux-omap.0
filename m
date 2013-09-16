From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 1/4] arm: omap: drm: Don't build device for DMM
Date: Mon, 16 Sep 2013 12:48:28 +0530
Message-ID: <1379315911-24634-2-git-send-email-archit@ti.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34619 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3IPHTa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 03:19:30 -0400
In-Reply-To: <1379315911-24634-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>

DMM exists on omap4+ platforms, these platforms are always expected to boot with
DT. Remove the current method of searching the dmm hwmod and building an
omap_device for dmm.

For OMAP4, the address and irq data for DMM hwmod(along with other blocks) were
removed, so the current method fails in the dmm driver's probe anyway.

The addition of DMM nodes in DT will ensure that a DMM device is built
correctly.

Cc: Andy Gross <andygro@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/drm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 59a4af7..e6c38cd 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -26,8 +26,6 @@
 #include <linux/platform_data/omap_drm.h>
 
 #include "soc.h"
-#include "omap_device.h"
-#include "omap_hwmod.h"
 
 #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
 
@@ -44,18 +42,6 @@ static struct platform_device omap_drm_device = {
 
 static int __init omap_init_drm(void)
 {
-	struct omap_hwmod *oh = NULL;
-	struct platform_device *pdev;
-
-	/* lookup and populate the DMM information, if present - OMAP4+ */
-	oh = omap_hwmod_lookup("dmm");
-
-	if (oh) {
-		pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
-		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
-			oh->name);
-	}
-
 	platform_data.omaprev = GET_OMAP_TYPE;
 
 	return platform_device_register(&omap_drm_device);
-- 
1.8.1.2

