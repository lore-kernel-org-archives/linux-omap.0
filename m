From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/5] OMAPDSS: RFBI: Maintain copy of number of data lines in driver data
Date: Fri, 10 Aug 2012 16:07:04 +0530
Message-ID: <1344595026-10607-4-git-send-email-archit@ti.com>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45578 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2HJKip (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 06:38:45 -0400
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The RFBI driver currently relies on the omap_dss_device struct to configure the
number of data lines as specified by the panel. This makes the RFBI interface
driver dependent on the omap_dss_device struct.

Make the RFBI driver data maintain it's own data lines field. A panel driver
is expected to call omapdss_rfbi_set_data_lines() to configure the pixel format
before enabling the interface or calling omap_rfbi_configure().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |    7 +++++--
 drivers/video/omap2/dss/rfbi.c            |   13 ++++++++++---
 include/video/omapdss.h                   |    4 +++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index f758378..a67729b 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -151,14 +151,16 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 			BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
 
 	omapdss_rfbi_set_pixel_size(dssdev, 16);
+	omapdss_rfbi_set_data_lines(dssdev, 8);
 
-	omap_rfbi_configure(dssdev, 8);
+	omap_rfbi_configure(dssdev);
 
 	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
 
 	omapdss_rfbi_set_pixel_size(dssdev, 16);
+	omapdss_rfbi_set_data_lines(dssdev, 16);
 
-	omap_rfbi_configure(dssdev, 16);
+	omap_rfbi_configure(dssdev);
 }
 
 static void mipid_transfer(struct spi_device *spi, int cmd, const u8 *wbuf,
@@ -302,6 +304,7 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 	}
 
 	omapdss_rfbi_set_pixel_size(dssdev, dssdev->ctrl.pixel_size);
+	omapdss_rfbi_set_data_lines(dssdev, dssdev->phy.rfbi.data_lines);
 
 	r = omapdss_rfbi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 72d1a8c..a39b1d8 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -113,6 +113,7 @@ static struct {
 	struct semaphore bus_lock;
 
 	int pixel_size;
+	int data_lines;
 } rfbi;
 
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
@@ -772,10 +773,10 @@ static int rfbi_configure(int rfbi_module, int bpp, int lines)
 	return 0;
 }
 
-int omap_rfbi_configure(struct omap_dss_device *dssdev, int data_lines)
+int omap_rfbi_configure(struct omap_dss_device *dssdev)
 {
 	return rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
-			data_lines);
+			rfbi.data_lines);
 }
 EXPORT_SYMBOL(omap_rfbi_configure);
 
@@ -785,6 +786,12 @@ void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev, int pixel_size)
 }
 EXPORT_SYMBOL(omapdss_rfbi_set_pixel_size);
 
+void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
+{
+	rfbi.data_lines = data_lines;
+}
+EXPORT_SYMBOL(omapdss_rfbi_set_data_lines);
+
 int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
 {
@@ -920,7 +927,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 	rfbi_config_lcd_manager(dssdev);
 
 	rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
-			dssdev->phy.rfbi.data_lines);
+			rfbi.data_lines);
 
 	rfbi_set_timings(dssdev->phy.rfbi.channel,
 			 &dssdev->ctrl.rfbi_timings);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5d5335c..e4fcc89 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -773,8 +773,10 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
-int omap_rfbi_configure(struct omap_dss_device *dssdev, int data_lines);
+int omap_rfbi_configure(struct omap_dss_device *dssdev);
 void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev,
 		int pixel_size);
+void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
+		int data_lines);
 
 #endif
-- 
1.7.9.5

