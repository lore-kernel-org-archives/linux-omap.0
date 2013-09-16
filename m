From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 2/4] arm: omap: display: Create omapdrm device inside omap_display_init
Date: Mon, 16 Sep 2013 12:48:29 +0530
Message-ID: <1379315911-24634-3-git-send-email-archit@ti.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34623 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab3IPHTd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 03:19:33 -0400
In-Reply-To: <1379315911-24634-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>

Move omapdrm device creation inside the omap_display_init so that we can
correctly create the device based on the presence of omapdss within the
platform.

For example, on a kernel image supporting multiple platforms, omap_init_drm
will create a omapdrm platform device on a AM33xx platform even though it
doesn't have a DSS block.

Originally worked on by Andy Gross.

Cc: Andy Gross <andygro@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/Makefile  |  6 +-----
 arch/arm/mach-omap2/display.c |  7 +++++++
 arch/arm/mach-omap2/display.h |  1 +
 arch/arm/mach-omap2/drm.c     | 10 +++++-----
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ff2c162..cc84b25 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -8,7 +8,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
-	 omap_device.o sram.o
+	 omap_device.o sram.o drm.o
 
 omap-2-3-common				= irq.o
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
@@ -229,10 +229,6 @@ endif
 # OMAP2420 MSDI controller integration support ("MMC")
 obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
 
-ifneq ($(CONFIG_DRM_OMAP),)
-obj-y					+= drm.o
-endif
-
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 03a0516..8d8ee474 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -416,6 +416,13 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 	}
 
+	/* create DRM device */
+	r = omap_init_drm();
+	if (r < 0) {
+		pr_err("Unable to register omapdrm device\n");
+		return r;
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
index b871b017..e4e8d39 100644
--- a/arch/arm/mach-omap2/display.h
+++ b/arch/arm/mach-omap2/display.h
@@ -26,4 +26,5 @@ struct omap_dss_dispc_dev_attr {
 	bool	has_framedonetv_irq;
 };
 
+int omap_init_drm(void);
 #endif
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index e6c38cd..facd740 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -26,8 +26,9 @@
 #include <linux/platform_data/omap_drm.h>
 
 #include "soc.h"
+#include "display.h"
 
-#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
+#if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
 
 static struct omap_drm_platform_data platform_data;
 
@@ -40,14 +41,13 @@ static struct platform_device omap_drm_device = {
 	.id = 0,
 };
 
-static int __init omap_init_drm(void)
+int __init omap_init_drm(void)
 {
 	platform_data.omaprev = GET_OMAP_TYPE;
 
 	return platform_device_register(&omap_drm_device);
 
 }
-
-omap_arch_initcall(omap_init_drm);
-
+#else
+int __init omap_init_drm(void) { return 0; }
 #endif
-- 
1.8.1.2

