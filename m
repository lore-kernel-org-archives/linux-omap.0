From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 4/4] arm: omap: display: Create omap_vout device inside omap_display_init
Date: Mon, 16 Sep 2013 12:48:31 +0530
Message-ID: <1379315911-24634-5-git-send-email-archit@ti.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab3IPHUI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 03:20:08 -0400
In-Reply-To: <1379315911-24634-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Move omap_vout device creation inside the omap_display_init so that we can
correctly create the device based on the presence of omapdss within the
platform.

For example, on a kernel image supporting multiple platforms, omap_init_vout
will create a omapdrm platform device on a AM33xx platform even though it
doesn't have a DSS block.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/devices.c | 10 +++++-----
 arch/arm/mach-omap2/display.c |  7 +++++++
 arch/arm/mach-omap2/display.h |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3c1279f..520a4be 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -37,6 +37,7 @@
 #include "mux.h"
 #include "control.h"
 #include "devices.h"
+#include "display.h"
 
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
@@ -504,13 +505,13 @@ static struct platform_device omap_vout_device = {
 	.resource 	= &omap_vout_resource[0],
 	.id		= -1,
 };
-static void omap_init_vout(void)
+
+int __init omap_init_vout(void)
 {
-	if (platform_device_register(&omap_vout_device) < 0)
-		printk(KERN_ERR "Unable to register OMAP-VOUT device\n");
+	return platform_device_register(&omap_vout_device);
 }
 #else
-static inline void omap_init_vout(void) {}
+int __init omap_init_vout(void) { return 0; }
 #endif
 
 #if IS_ENABLED(CONFIG_WL12XX)
@@ -576,7 +577,6 @@ static int __init omap2_init_devices(void)
 	}
 	omap_init_sti();
 	omap_init_rng();
-	omap_init_vout();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index fb66e5a..a4e536b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -437,6 +437,13 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		return r;
 	}
 
+	/* create V4L2 display device */
+	r = omap_init_vout();
+	if (r < 0) {
+		pr_err("Unable to register omap_vout device\n");
+		return r;
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
index bc7af40..f3d2ce4 100644
--- a/arch/arm/mach-omap2/display.h
+++ b/arch/arm/mach-omap2/display.h
@@ -29,4 +29,5 @@ struct omap_dss_dispc_dev_attr {
 int omap_init_drm(void);
 int omap_init_vrfb(void);
 int omap_init_fb(void);
+int omap_init_vout(void);
 #endif
-- 
1.8.1.2

