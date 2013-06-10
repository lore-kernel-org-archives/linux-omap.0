From: Andreas Naumann <anaumann@ultratronik.de>
Subject: [PATCH] omap2 dss: omap_display_init: Dont allow more than the maximum number of displays.
Date: Mon, 10 Jun 2013 09:57:35 +0200
Message-ID: <1370851055-15960-1-git-send-email-anaumann@ultratronik.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dd5612.kasserver.com ([85.13.130.143]:55086 "EHLO
	dd5612.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3FJIH7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 04:07:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Andreas Naumann <anaumann@ultratronik.de>

Currently the maximum number of display is hardcoded in the array omapfb2_device. Made the number a #define and check it in init routine.

Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>
---
Our board supports a lot of panels and we could probably solve this more effectively, but arrays shouldnt silently overflow when using more than 10 displays. Created the patch on 3.1 and tested it there. This one is rebased on todays linux-omap.git
 arch/arm/mach-omap2/display.c       |  5 +++++
 drivers/video/omap2/omapfb/omapfb.h | 10 +++++-----
 include/video/omapdss.h             |  2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ff37be1..6f1a147 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -338,6 +338,11 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		return -ENODEV;
 	}
 
+	if( board_data->num_devices > OMAPFB_MAX_DISPLAY_NUM ){
+		pr_err("Trying to init more displays(%d) than possible.(%d)\n", board_data->num_devices, OMAPFB_MAX_DISPLAY_NUM);
+		return -ENODEV;
+	}
+
 	board_data->version = ver;
 	board_data->dsi_enable_pads = omap_dsi_enable_pads;
 	board_data->dsi_disable_pads = omap_dsi_disable_pads;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 623cd87..00d3fbc 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -96,15 +96,15 @@ struct omapfb2_device {
 	int state;
 
 	unsigned num_fbs;
-	struct fb_info *fbs[10];
-	struct omapfb2_mem_region regions[10];
+	struct fb_info *fbs[OMAPFB_MAX_DISPLAY_NUM];
+	struct omapfb2_mem_region regions[OMAPFB_MAX_DISPLAY_NUM];
 
 	unsigned num_displays;
-	struct omapfb_display_data displays[10];
+	struct omapfb_display_data displays[OMAPFB_MAX_DISPLAY_NUM];
 	unsigned num_overlays;
-	struct omap_overlay *overlays[10];
+	struct omap_overlay *overlays[OMAPFB_MAX_DISPLAY_NUM];
 	unsigned num_managers;
-	struct omap_overlay_manager *managers[10];
+	struct omap_overlay_manager *managers[OMAPFB_MAX_DISPLAY_NUM];
 
 	struct workqueue_struct *auto_update_wq;
 };
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index aeb4e9a..dfb054f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -54,6 +54,8 @@
 #define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 29)
 #define DISPC_IRQ_FRAMEDONE3		(1 << 30)
 
+#define OMAPFB_MAX_DISPLAY_NUM	10
+
 struct omap_dss_device;
 struct omap_overlay_manager;
 struct dss_lcd_mgr_config;
-- 
1.8.2.3

