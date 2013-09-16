From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 3/4] arm: omap: display: Create omapvrfb and omapfb devices inside omap_display_init
Date: Mon, 16 Sep 2013 12:48:30 +0530
Message-ID: <1379315911-24634-4-git-send-email-archit@ti.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34625 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab3IPHTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 03:19:36 -0400
In-Reply-To: <1379315911-24634-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Move omapfb and omapvrfb device creation inside the omap_display_init so that
we can correctly create the device based on the presence of omapdss within the
platform.

For example, on a kernel image supporting multiple platforms, omap_init_vrfb and
omap_init_fb will create omapvrfb and omapfb platform devices respectively on a
AM33xx platform even though it doesn't have a VRFB or DSS block.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/display.c | 14 ++++++++++++++
 arch/arm/mach-omap2/display.h |  2 ++
 arch/arm/mach-omap2/fb.c      | 14 +++++++-------
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 8d8ee474..fb66e5a 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -423,6 +423,20 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		return r;
 	}
 
+	/* create vrfb device */
+	r = omap_init_vrfb();
+	if (r < 0) {
+		pr_err("Unable to register omapvrfb device\n");
+		return r;
+	}
+
+	/* create FB device */
+	r = omap_init_fb();
+	if (r < 0) {
+		pr_err("Unable to register omapfb device\n");
+		return r;
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
index e4e8d39..bc7af40 100644
--- a/arch/arm/mach-omap2/display.h
+++ b/arch/arm/mach-omap2/display.h
@@ -27,4 +27,6 @@ struct omap_dss_dispc_dev_attr {
 };
 
 int omap_init_drm(void);
+int omap_init_vrfb(void);
+int omap_init_fb(void);
 #endif
diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 2ca33cc..26e28e9 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -32,6 +32,7 @@
 #include <asm/mach/map.h>
 
 #include "soc.h"
+#include "display.h"
 
 #ifdef CONFIG_OMAP2_VRFB
 
@@ -64,7 +65,7 @@ static const struct resource omap3_vrfb_resources[] = {
 	DEFINE_RES_MEM_NAMED(0xfc000000u, 0x4000000, "vrfb-area-11"),
 };
 
-static int __init omap_init_vrfb(void)
+int __init omap_init_vrfb(void)
 {
 	struct platform_device *pdev;
 	const struct resource *res;
@@ -85,8 +86,8 @@ static int __init omap_init_vrfb(void)
 
 	return PTR_RET(pdev);
 }
-
-omap_arch_initcall(omap_init_vrfb);
+#else
+int __init omap_init_vrfb(void) { return 0; }
 #endif
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -105,11 +106,10 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-static int __init omap_init_fb(void)
+int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
 }
-
-omap_arch_initcall(omap_init_fb);
-
+#else
+int __init omap_init_fb(void) { return 0; }
 #endif
-- 
1.8.1.2

