From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 01/13] OMAPDSS: DPI: Maintain our own timings field in driver data
Date: Thu, 9 Aug 2012 17:19:37 +0530
Message-ID: <1344512989-4071-2-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59749 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2HILvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 07:51:21 -0400
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DPI driver currently relies on the timings in omap_dss_device struct to
configure the DISPC accordingly. This makes the DPI interface driver dependent
on the omap_dss_device struct.

Make the DPI driver data maintain it's own timings field. The panel driver is
expected to call dpi_set_timings()(renamed to omapdss_dpi_set_timings) to set
these timings before the panel is enabled.

In the set_timings() op, we still ensure that the omap_dss_device timings
(dssdev->panel.timings) are configured. This will later be configured only by
the DPI panel drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |    4 +++-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    2 ++
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 ++
 drivers/video/omap2/displays/panel-picodlp.c       |    3 +++
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    2 ++
 drivers/video/omap2/displays/panel-tfp410.c        |    4 +++-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    4 +++-
 drivers/video/omap2/dss/dpi.c                      |   11 +++++++----
 include/video/omapdss.h                            |    4 ++--
 9 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 69e78a5..8d4e102 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -565,6 +565,8 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
@@ -726,7 +728,7 @@ static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 
 	mutex_lock(&drv_data->lock);
 
-	dpi_set_timings(dssdev, timings);
+	omapdss_dpi_set_timings(dssdev, timings);
 
 	mutex_unlock(&drv_data->lock);
 }
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 8028077..7e52aee 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -55,6 +55,8 @@ static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index b122b0f..e501c40 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -175,6 +175,8 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 2d35bd3..0d7a8ff 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -377,6 +377,9 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	 * then only i2c commands can be successfully sent to dpp2600
 	 */
 	msleep(1000);
+
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DPI\n");
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index bd86ba9..1486a81 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -142,6 +142,8 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 40cc0cfa..c6f9503 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -65,6 +65,8 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
@@ -231,7 +233,7 @@ static void tfp410_set_timings(struct omap_dss_device *dssdev,
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
 	mutex_lock(&ddata->lock);
-	dpi_set_timings(dssdev, timings);
+	omapdss_dpi_set_timings(dssdev, timings);
 	mutex_unlock(&ddata->lock);
 }
 
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index fa7baa6..ecb163e 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -337,6 +337,8 @@ static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_dpi_display_enable(dssdev);
 	if (r)
 		goto err0;
@@ -480,7 +482,7 @@ static void tpo_td043_remove(struct omap_dss_device *dssdev)
 static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	dpi_set_timings(dssdev, timings);
+	omapdss_dpi_set_timings(dssdev, timings);
 }
 
 static int tpo_td043_check_timings(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index add47fe..96dd1a4 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -41,6 +41,7 @@ static struct {
 
 	struct mutex lock;
 
+	struct omap_video_timings timings;
 	struct dss_lcd_mgr_config mgr_config;
 } dpi;
 
@@ -138,7 +139,7 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 
 static int dpi_set_mode(struct omap_dss_device *dssdev)
 {
-	struct omap_video_timings *t = &dssdev->panel.timings;
+	struct omap_video_timings *t = &dpi.timings;
 	int lck_div = 0, pck_div = 0;
 	unsigned long fck = 0;
 	unsigned long pck;
@@ -293,8 +294,8 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
-void dpi_set_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
+void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
 {
 	int r;
 
@@ -302,7 +303,9 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 
 	mutex_lock(&dpi.lock);
 
+	dpi.timings = *timings;
 	dssdev->panel.timings = *timings;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = dispc_runtime_get();
 		if (r)
@@ -317,7 +320,7 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 
 	mutex_unlock(&dpi.lock);
 }
-EXPORT_SYMBOL(dpi_set_timings);
+EXPORT_SYMBOL(omapdss_dpi_set_timings);
 
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6f7581b..ebf2ebd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -751,8 +751,8 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
-void dpi_set_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
+void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
 
-- 
1.7.9.5

