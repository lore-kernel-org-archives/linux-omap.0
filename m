From: Archit Taneja <archit@ti.com>
Subject: [RFC 14/17] OMAPDSS: SDI: Maintain our own timings field in driver data
Date: Wed, 1 Aug 2012 16:01:25 +0530
Message-ID: <1343817088-29645-15-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48020 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab2HAKd7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:33:59 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The SDI driver currently relies on the timings in omap_dss_device struct to
configure the DISPC accordingly. This makes the SDI interface driver dependent
on the omap_dss_device struct.

Make the SDI driver data maintain it's own timings field. The panel driver is
expected to call omapdss_sdi_set_timings() to set these timings before the panel
is enabled.

Make the SDI panel driver configure the new timings is the omap_dss_device
struct(dssdev->panel.timings). The SDI driver is responsible for maintaining
only it's own copy of timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |    4 ++++
 drivers/video/omap2/dss/sdi.c                  |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 11bdc88..77fe59f 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -600,6 +600,8 @@ static int acx_panel_power_on(struct omap_dss_device *dssdev)
 
 	mutex_lock(&md->mutex);
 
+	omapdss_sdi_set_timings(dssdev, &dssdev->panel.timings);
+
 	r = omapdss_sdi_display_enable(dssdev);
 	if (r) {
 		pr_err("%s sdi enable failed\n", __func__);
@@ -732,6 +734,8 @@ static void acx_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	omapdss_sdi_set_timings(dssdev, timings);
+
+	dssdev->panel.timings = *timings;
 }
 
 static int acx_panel_check_timings(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index d88243f..917816d 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -34,6 +34,7 @@ static struct {
 	struct regulator *vdds_sdi_reg;
 
 	struct dss_lcd_mgr_config mgr_config;
+	struct omap_video_timings timings;
 } sdi;
 
 static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
@@ -52,7 +53,7 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 static int sdi_set_mode(struct omap_dss_device *dssdev)
 {
 	int r;
-	struct omap_video_timings *t = &dssdev->panel.timings;
+	struct omap_video_timings *t = &sdi.timings;
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 	unsigned long pck;
@@ -160,7 +161,7 @@ void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
 {
 	int r;
 
-	dssdev->panel.timings = *timings;
+	sdi.timings = *timings;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = dispc_runtime_get();
-- 
1.7.9.5

