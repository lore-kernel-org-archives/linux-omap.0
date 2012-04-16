From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/6] OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lcd size
Date: Mon, 16 Apr 2012 12:53:42 +0530
Message-ID: <1334561027-28569-2-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56324 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab2DPHYZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 03:24:25 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The RFBI driver uses dispc_mgr_set_lcd_size() to set the width and height of
the LCD manager. Replace this to use dispc_mgr_set_lcd_timings(), pass dummy
blanking parameters like done in the DSI driver.

This prevents the need to export dispc_mgr_set_lcd_size(), and use a common
function to set lcd timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    3 ++-
 drivers/video/omap2/dss/dss.h   |    1 -
 drivers/video/omap2/dss/rfbi.c  |   24 ++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bddd64b..c6ac161 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -983,7 +983,8 @@ static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
 
-void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
+static void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width,
+		u16 height)
 {
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7080f5f..e8dea74 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -430,7 +430,6 @@ void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
 
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
-void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 788a0ef..97b6c4a 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -304,13 +304,23 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
+	struct omap_video_timings timings = {
+		.hsw		= 1,
+		.hfp		= 1,
+		.hbp		= 1,
+		.vsw		= 1,
+		.vfp		= 0,
+		.vbp		= 0,
+		.x_res		= width,
+		.y_res		= height,
+	};
 
 	/*BUG_ON(callback == 0);*/
 	BUG_ON(rfbi.framedone_callback != NULL);
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_mgr_set_lcd_size(dssdev->manager->id, width, height);
+	dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
 
 	dispc_mgr_enable(dssdev->manager->id, true);
 
@@ -766,6 +776,16 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
 {
 	u16 dw, dh;
+	struct omap_video_timings timings = {
+		.hsw		= 1,
+		.hfp		= 1,
+		.hbp		= 1,
+		.vsw		= 1,
+		.vfp		= 0,
+		.vbp		= 0,
+		.x_res		= *w,
+		.y_res		= *h,
+	};
 
 	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
@@ -784,7 +804,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
+	dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
 
 	return 0;
 }
-- 
1.7.5.4

