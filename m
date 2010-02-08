From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 02/17] OMAP: DSS2: DSI: remove auto-update perf measurement
Date: Mon,  8 Feb 2010 17:57:26 +0200
Message-ID: <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26866 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0BHPzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:10 -0500
In-Reply-To: <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Remove performance measurement for auto-update. Auto-update and thus
performance measurement cannot be supported after the driver change where
the control is moved to display drivers.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   81 +++++------------------------------------
 1 files changed, 9 insertions(+), 72 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 74df72b..a6ea8c8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -261,8 +261,6 @@ static struct
 #ifdef DEBUG
 	ktime_t perf_setup_time;
 	ktime_t perf_start_time;
-	ktime_t perf_start_time_auto;
-	int perf_measure_frames;
 #endif
 	int debug_read;
 	int debug_write;
@@ -338,12 +336,6 @@ static void dsi_perf_mark_start(void)
 	dsi.perf_start_time = ktime_get();
 }
 
-static void dsi_perf_mark_start_auto(void)
-{
-	dsi.perf_measure_frames = 0;
-	dsi.perf_start_time_auto = ktime_get();
-}
-
 static void dsi_perf_show(const char *name)
 {
 	ktime_t t, setup_time, trans_time;
@@ -374,72 +366,19 @@ static void dsi_perf_show(const char *name)
 		dsi.active_update_region.h *
 		dsi.active_update_region.device->ctrl.pixel_size / 8;
 
-	if (dsi.update_mode == OMAP_DSS_UPDATE_AUTO) {
-		static u32 s_total_trans_us, s_total_setup_us;
-		static u32 s_min_trans_us = 0xffffffff, s_min_setup_us;
-		static u32 s_max_trans_us, s_max_setup_us;
-		const int numframes = 100;
-		ktime_t total_time_auto;
-		u32 total_time_auto_us;
-
-		dsi.perf_measure_frames++;
-
-		if (setup_us < s_min_setup_us)
-			s_min_setup_us = setup_us;
-
-		if (setup_us > s_max_setup_us)
-			s_max_setup_us = setup_us;
-
-		s_total_setup_us += setup_us;
-
-		if (trans_us < s_min_trans_us)
-			s_min_trans_us = trans_us;
-
-		if (trans_us > s_max_trans_us)
-			s_max_trans_us = trans_us;
-
-		s_total_trans_us += trans_us;
-
-		if (dsi.perf_measure_frames < numframes)
-			return;
-
-		total_time_auto = ktime_sub(t, dsi.perf_start_time_auto);
-		total_time_auto_us = (u32)ktime_to_us(total_time_auto);
-
-		printk(KERN_INFO "DSI(%s): %u fps, setup %u/%u/%u, "
-				"trans %u/%u/%u\n",
-				name,
-				1000 * 1000 * numframes / total_time_auto_us,
-				s_min_setup_us,
-				s_max_setup_us,
-				s_total_setup_us / numframes,
-				s_min_trans_us,
-				s_max_trans_us,
-				s_total_trans_us / numframes);
-
-		s_total_setup_us = 0;
-		s_min_setup_us = 0xffffffff;
-		s_max_setup_us = 0;
-		s_total_trans_us = 0;
-		s_min_trans_us = 0xffffffff;
-		s_max_trans_us = 0;
-		dsi_perf_mark_start_auto();
-	} else {
-		printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
-				"%u bytes, %u kbytes/sec\n",
-				name,
-				setup_us,
-				trans_us,
-				total_us,
-				1000*1000 / total_us,
-				total_bytes,
-				total_bytes * 1000 / total_us);
-	}
+	printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
+			"%u bytes, %u kbytes/sec\n",
+			name,
+			setup_us,
+			trans_us,
+			total_us,
+			1000*1000 / total_us,
+			total_bytes,
+			total_bytes * 1000 / total_us);
 }
 #else
 #define dsi_perf_mark_setup()
 #define dsi_perf_mark_start()
-#define dsi_perf_mark_start_auto()
 #define dsi_perf_show(x)
 #endif
 
@@ -2931,8 +2870,6 @@ static int dsi_set_update_mode(struct omap_dss_device *dssdev,
 
 			dsi_set_update_region(dssdev, 0, 0, w, h);
 
-			dsi_perf_mark_start_auto();
-
 			wake_up(&dsi.waitqueue);
 		}
 	}
-- 
1.6.5

