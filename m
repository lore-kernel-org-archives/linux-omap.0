From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/5] OMAPDSS: RFBI: Maintain copy of pixel size in driver data
Date: Fri, 10 Aug 2012 16:07:03 +0530
Message-ID: <1344595026-10607-3-git-send-email-archit@ti.com>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2HJKim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 06:38:42 -0400
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The RFBI driver currently relies on the omap_dss_device struct to receive the
desired pixel size of the panel. This makes the RFBI interface driver dependent
on the omap_dss_device struct.

Make the RFBI driver data maintain it's own pixel format field. A panel driver
is expected to call omapdss_rfbi_set_pixel_size() to configure the pixel format
before enabling the interface or calling omap_rfbi_configure().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   10 ++++++++--
 drivers/video/omap2/dss/rfbi.c            |   21 ++++++++++++++-------
 include/video/omapdss.h                   |    5 +++--
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index e6c1153..f758378 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -150,11 +150,15 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 			BLIZZARD_SRC_WRITE_LCD :
 			BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
 
-	omap_rfbi_configure(dssdev, 16, 8);
+	omapdss_rfbi_set_pixel_size(dssdev, 16);
+
+	omap_rfbi_configure(dssdev, 8);
 
 	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
 
-	omap_rfbi_configure(dssdev, 16, 16);
+	omapdss_rfbi_set_pixel_size(dssdev, 16);
+
+	omap_rfbi_configure(dssdev, 16);
 }
 
 static void mipid_transfer(struct spi_device *spi, int cmd, const u8 *wbuf,
@@ -297,6 +301,8 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 			goto err_plat_en;
 	}
 
+	omapdss_rfbi_set_pixel_size(dssdev, dssdev->ctrl.pixel_size);
+
 	r = omapdss_rfbi_display_enable(dssdev);
 	if (r)
 		goto err_rfbi_en;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 7c08742..72d1a8c 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -111,6 +111,8 @@ static struct {
 	struct omap_dss_device *dssdev[2];
 
 	struct semaphore bus_lock;
+
+	int pixel_size;
 } rfbi;
 
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
@@ -770,13 +772,19 @@ static int rfbi_configure(int rfbi_module, int bpp, int lines)
 	return 0;
 }
 
-int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
-		int data_lines)
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int data_lines)
 {
-	return rfbi_configure(dssdev->phy.rfbi.channel, pixel_size, data_lines);
+	return rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
+			data_lines);
 }
 EXPORT_SYMBOL(omap_rfbi_configure);
 
+void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev, int pixel_size)
+{
+	rfbi.pixel_size = pixel_size;
+}
+EXPORT_SYMBOL(omapdss_rfbi_set_pixel_size);
+
 int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
 {
@@ -877,7 +885,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	/* Do we need fifohandcheck for RFBI? */
 	mgr_config.fifohandcheck = false;
 
-	mgr_config.video_port_width = dssdev->ctrl.pixel_size;
+	mgr_config.video_port_width = rfbi.pixel_size;
 	mgr_config.lcden_sig_polarity = 0;
 
 	dss_mgr_set_lcd_config(dssdev->manager, &mgr_config);
@@ -911,9 +919,8 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 
 	rfbi_config_lcd_manager(dssdev);
 
-	rfbi_configure(dssdev->phy.rfbi.channel,
-			       dssdev->ctrl.pixel_size,
-			       dssdev->phy.rfbi.data_lines);
+	rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
+			dssdev->phy.rfbi.data_lines);
 
 	rfbi_set_timings(dssdev->phy.rfbi.channel,
 			 &dssdev->ctrl.rfbi_timings);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6e33c6f..5d5335c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -773,7 +773,8 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
-int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
-		int data_lines);
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int data_lines);
+void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev,
+		int pixel_size);
 
 #endif
-- 
1.7.9.5

