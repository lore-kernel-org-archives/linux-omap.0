From: Archit Taneja <archit@ti.com>
Subject: [RFC 06/17] OMAPDSS: DPI displays: Take care of panel timings in the driver itself
Date: Wed, 1 Aug 2012 16:01:17 +0530
Message-ID: <1343817088-29645-7-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39534 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab2HAKdU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:33:20 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The timings maintained in omap_dss_device(dssdev->panel.timings) should be
maintained by the panel driver itself. It's the panel drivers responsibility
to update it if a new set of timings is to be configured. The DPI interface
driver shouldn't be responsible of updating the panel timings, it's responsible
of maintianing it's own copy of timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |    2 ++
 drivers/video/omap2/displays/panel-tfp410.c        |    1 +
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 ++
 drivers/video/omap2/dss/dpi.c                      |    1 -
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 5e70313..e773594 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -698,6 +698,8 @@ static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	omapdss_dpi_set_timings(dssdev, timings);
+
+	dssdev->panel.timings = *timings;
 }
 
 static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index c6f9503..9397236 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -234,6 +234,7 @@ static void tfp410_set_timings(struct omap_dss_device *dssdev,
 
 	mutex_lock(&ddata->lock);
 	omapdss_dpi_set_timings(dssdev, timings);
+	dssdev->panel.timings = *timings;
 	mutex_unlock(&ddata->lock);
 }
 
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index ecb163e..3f47f5f 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -483,6 +483,8 @@ static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	omapdss_dpi_set_timings(dssdev, timings);
+
+	dssdev->panel.timings = *timings;
 }
 
 static int tpo_td043_check_timings(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 96dd1a4..6c43d80 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -304,7 +304,6 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 	mutex_lock(&dpi.lock);
 
 	dpi.timings = *timings;
-	dssdev->panel.timings = *timings;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = dispc_runtime_get();
-- 
1.7.9.5

