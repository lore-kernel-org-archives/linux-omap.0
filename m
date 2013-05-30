From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/32] OMAPDSS: add videomode conversion support
Date: Thu, 30 May 2013 12:34:40 +0300
Message-ID: <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37452 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030349Ab3E3Jfr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:47 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add helper functions to convert between omapdss specific video timings
and the common videomode.

Eventually omapdss will be changed to use only the common video timings,
and these helper functions will make the transition easier.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig   |  1 +
 drivers/video/omap2/dss/display.c | 69 +++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h           |  7 ++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index cb0f145..8f70a83 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,5 +1,6 @@
 menuconfig OMAP2_DSS
         tristate "OMAP2+ Display Subsystem support"
+	select VIDEOMODE_HELPERS
         help
 	  OMAP2+ Display Subsystem support.
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 0aa8ad8..72ac058 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -219,3 +219,72 @@ void omap_dss_stop_device(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omap_dss_stop_device);
 
+void videomode_to_omap_video_timings(const struct videomode *vm,
+		struct omap_video_timings *ovt)
+{
+	memset(ovt, 0, sizeof(*ovt));
+
+	ovt->pixel_clock = vm->pixelclock / 1000;
+	ovt->x_res = vm->hactive;
+	ovt->hbp = vm->hback_porch;
+	ovt->hfp = vm->hfront_porch;
+	ovt->hsw = vm->hsync_len;
+	ovt->y_res = vm->vactive;
+	ovt->vbp = vm->vback_porch;
+	ovt->vfp = vm->vfront_porch;
+	ovt->vsw = vm->vsync_len;
+
+	ovt->vsync_level = vm->flags & DISPLAY_FLAGS_VSYNC_HIGH ?
+		OMAPDSS_SIG_ACTIVE_HIGH :
+		OMAPDSS_SIG_ACTIVE_LOW;
+	ovt->hsync_level = vm->flags & DISPLAY_FLAGS_HSYNC_HIGH ?
+		OMAPDSS_SIG_ACTIVE_HIGH :
+		OMAPDSS_SIG_ACTIVE_LOW;
+	ovt->de_level = vm->flags & DISPLAY_FLAGS_DE_HIGH ?
+		OMAPDSS_SIG_ACTIVE_HIGH :
+		OMAPDSS_SIG_ACTIVE_HIGH;
+	ovt->data_pclk_edge = vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
+		OMAPDSS_DRIVE_SIG_RISING_EDGE :
+		OMAPDSS_DRIVE_SIG_FALLING_EDGE;
+
+	ovt->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+}
+EXPORT_SYMBOL(videomode_to_omap_video_timings);
+
+void omap_video_timings_to_videomode(const struct omap_video_timings *ovt,
+		struct videomode *vm)
+{
+	memset(vm, 0, sizeof(*vm));
+
+	vm->pixelclock = ovt->pixel_clock * 1000;
+
+	vm->hactive = ovt->x_res;
+	vm->hback_porch = ovt->hbp;
+	vm->hfront_porch = ovt->hfp;
+	vm->hsync_len = ovt->hsw;
+	vm->vactive = ovt->y_res;
+	vm->vback_porch = ovt->vbp;
+	vm->vfront_porch = ovt->vfp;
+	vm->vsync_len = ovt->vsw;
+
+	if (ovt->hsync_level == OMAPDSS_SIG_ACTIVE_HIGH)
+		vm->flags |= DISPLAY_FLAGS_HSYNC_HIGH;
+	else
+		vm->flags |= DISPLAY_FLAGS_HSYNC_LOW;
+
+	if (ovt->vsync_level == OMAPDSS_SIG_ACTIVE_HIGH)
+		vm->flags |= DISPLAY_FLAGS_VSYNC_HIGH;
+	else
+		vm->flags |= DISPLAY_FLAGS_VSYNC_LOW;
+
+	if (ovt->de_level == OMAPDSS_SIG_ACTIVE_HIGH)
+		vm->flags |= DISPLAY_FLAGS_DE_HIGH;
+	else
+		vm->flags |= DISPLAY_FLAGS_DE_LOW;
+
+	if (ovt->data_pclk_edge == OMAPDSS_DRIVE_SIG_RISING_EDGE)
+		vm->flags |= DISPLAY_FLAGS_PIXDATA_POSEDGE;
+	else
+		vm->flags |= DISPLAY_FLAGS_PIXDATA_NEGEDGE;
+}
+EXPORT_SYMBOL(omap_video_timings_to_videomode);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f747266..6c422f7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -23,6 +23,8 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 
+#include <video/videomode.h>
+
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
 #define DISPC_IRQ_EVSYNC_EVEN		(1 << 2)
@@ -767,6 +769,11 @@ const char *omapdss_get_default_display_name(void);
 int omap_dss_start_device(struct omap_dss_device *dssdev);
 void omap_dss_stop_device(struct omap_dss_device *dssdev);
 
+void videomode_to_omap_video_timings(const struct videomode *vm,
+		struct omap_video_timings *ovt);
+void omap_video_timings_to_videomode(const struct omap_video_timings *ovt,
+		struct videomode *vm);
+
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
-- 
1.8.1.2

