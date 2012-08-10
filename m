From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/5] OMAPDSS: DPI: Maitain copy of number of data lines in driver data
Date: Fri, 10 Aug 2012 16:07:05 +0530
Message-ID: <1344595026-10607-5-git-send-email-archit@ti.com>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2HJKit (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 06:38:49 -0400
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DPI driver currently relies on the omap_dss_device struct to configure the
number of data lines as specified by the panel. This makes the DPI interface
driver dependent on the omap_dss_device struct.

Make the DPI driver data maintain it's own data lines field. A panel driver
is expected to call omapdss_dpi_set_data_lines() before enabling the interface.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    1 +
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    1 +
 drivers/video/omap2/displays/panel-picodlp.c       |    1 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 +
 drivers/video/omap2/displays/panel-tfp410.c        |    1 +
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    1 +
 drivers/video/omap2/dss/dpi.c                      |   13 ++++++++++++-
 include/video/omapdss.h                            |    1 +
 9 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index a07e18c..88295c5 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -566,6 +566,7 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 7e52aee..90c1cab 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -56,6 +56,7 @@ static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index e501c40..908fd26 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -176,6 +176,7 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 0d7a8ff..9df8764 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -379,6 +379,7 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	msleep(1000);
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r) {
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 1486a81..1ec3b27 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -143,6 +143,7 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 9397236..4be9a59 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -66,6 +66,7 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 3f47f5f..b5e6dbc 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -338,6 +338,7 @@ static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
 		return 0;
 
 	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
 
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 6c43d80..8c860c0 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -43,6 +43,7 @@ static struct {
 
 	struct omap_video_timings timings;
 	struct dss_lcd_mgr_config mgr_config;
+	int data_lines;
 } dpi;
 
 static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
@@ -176,7 +177,7 @@ static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 	dpi.mgr_config.stallmode = false;
 	dpi.mgr_config.fifohandcheck = false;
 
-	dpi.mgr_config.video_port_width = dssdev->phy.dpi.data_lines;
+	dpi.mgr_config.video_port_width = dpi.data_lines;
 
 	dpi.mgr_config.lcden_sig_polarity = 0;
 
@@ -368,6 +369,16 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(dpi_check_timings);
 
+void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
+{
+	mutex_lock(&dpi.lock);
+
+	dpi.data_lines = data_lines;
+
+	mutex_unlock(&dpi.lock);
+}
+EXPORT_SYMBOL(omapdss_dpi_set_data_lines);
+
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e4fcc89..47f29b7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -760,6 +760,7 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
+void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines);
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

