From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/16] OMAPFB: remove remaining OMAP arch checks
Date: Tue, 24 Jan 2012 12:00:31 +0200
Message-ID: <1327399231-20826-17-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:58062 "HELO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755824Ab2AXKBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:15 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the old omapfb driver is only omap1 display driver, there's no
need to check if the arch is omap1. This patch removes the few remaining
checks for the arch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/Makefile      |    6 ++----
 drivers/video/omap/omapfb.h      |    4 ----
 drivers/video/omap/omapfb_main.c |    3 +--
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 7965375..1927faf 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -4,11 +4,9 @@
 
 obj-$(CONFIG_FB_OMAP) += omapfb.o
 
-objs-yy := omapfb_main.o
+objs-yy := omapfb_main.o lcdc.o
 
-objs-y$(CONFIG_ARCH_OMAP1) += lcdc.o
-
-objs-$(CONFIG_ARCH_OMAP1)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += sossi.o
+objs-y$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += sossi.o
 
 objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 
diff --git a/drivers/video/omap/omapfb.h b/drivers/video/omap/omapfb.h
index 07fe498..2921d20 100644
--- a/drivers/video/omap/omapfb.h
+++ b/drivers/video/omap/omapfb.h
@@ -47,11 +47,7 @@
 
 struct omapfb_device;
 
-#ifdef CONFIG_ARCH_OMAP1
 #define OMAPFB_PLANE_NUM		1
-#else
-#define OMAPFB_PLANE_NUM		3
-#endif
 
 struct omapfb_mem_region {
 	u32		paddr;
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 3d2e147..f54b463 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1741,8 +1741,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 #ifdef CONFIG_FB_OMAP_DMA_TUNE
 	/* Set DMA priority for EMIFF access to highest */
-	if (cpu_class_is_omap1())
-		omap_set_dma_priority(0, OMAP_DMA_PORT_EMIFF, 15);
+	omap_set_dma_priority(0, OMAP_DMA_PORT_EMIFF, 15);
 #endif
 
 	r = ctrl_change_mode(fbdev->fb_info[0]);
-- 
1.7.4.1

