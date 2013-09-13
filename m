From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 14:44:36 +0530
Message-ID: <1379063679-4869-2-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45369 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab3IMJP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 05:15:58 -0400
In-Reply-To: <1379063679-4869-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>

Move omapdrm device creation inside the omap_display_init so that we can
correctly create the device based on the presence of omapdss.

Originally worked on by Andy Gross.

Cc: Andy Gross <andygro@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/Makefile  |  4 ---
 arch/arm/mach-omap2/display.c | 55 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/drm.c     | 67 -------------------------------------------
 3 files changed, 55 insertions(+), 71 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/drm.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ff2c162..f73b6a5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
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
index 03a0516..d097d23 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -18,11 +18,13 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/platform_data/omap_drm.h>
 
 #include <video/omapdss.h>
 #include "omap_hwmod.h"
@@ -102,6 +104,52 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initconst = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+#if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
+
+static struct omap_drm_platform_data platform_drm_data;
+
+static struct platform_device drm_device = {
+	.dev = {
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &platform_drm_data,
+	},
+	.name = "omapdrm",
+	.id = 0,
+};
+
+static struct platform_device *omap_drm_device = &drm_device;
+#else
+static struct platform_device *omap_drm_device;
+#endif
+
+static int __init omapdrm_init(void)
+{
+	int r = 0;
+
+	/* create DRM and DMM device */
+	if (omap_drm_device != NULL) {
+		struct omap_hwmod *oh = NULL;
+		struct platform_device *pdev;
+
+		/* lookup and populate the DMM information, if present - OMAP4+ */
+		oh = omap_hwmod_lookup("dmm");
+		if (oh) {
+			pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
+			WARN(IS_ERR(pdev),
+				"Could not build omap_device for %s\n",
+				oh->name);
+		}
+
+		platform_drm_data.omaprev = GET_OMAP_TYPE;
+
+		r = platform_device_register(omap_drm_device);
+		if (r < 0)
+			pr_err("Unable to register omapdrm device\n");
+	}
+
+	return r;
+}
+
 static void __init omap4_tpd12s015_mux_pads(void)
 {
 	omap_mux_init_signal("hdmi_cec",
@@ -416,6 +464,13 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 	}
 
+	/* create DRM and DMM device */
+	r = omapdrm_init();
+	if (r < 0) {
+		pr_err("Unable to register omapdrm device\n");
+		return r;
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
deleted file mode 100644
index 59a4af7..0000000
--- a/arch/arm/mach-omap2/drm.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * DRM/KMS device registration for TI OMAP platforms
- *
- * Copyright (C) 2012 Texas Instruments
- * Author: Rob Clark <rob.clark@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_data/omap_drm.h>
-
-#include "soc.h"
-#include "omap_device.h"
-#include "omap_hwmod.h"
-
-#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
-
-static struct omap_drm_platform_data platform_data;
-
-static struct platform_device omap_drm_device = {
-	.dev = {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &platform_data,
-	},
-	.name = "omapdrm",
-	.id = 0,
-};
-
-static int __init omap_init_drm(void)
-{
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
-	platform_data.omaprev = GET_OMAP_TYPE;
-
-	return platform_device_register(&omap_drm_device);
-
-}
-
-omap_arch_initcall(omap_init_drm);
-
-#endif
-- 
1.8.1.2

