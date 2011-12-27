From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 24/29] OMAPDSS: Writeback: Use panel driver ops to configure mirroring rotation and buffer size
Date: Tue, 27 Dec 2011 18:07:07 +0530
Message-ID: <1324989432-3625-25-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0MkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:40:04 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add rotation and mirroring ops to writeback panel driver. Use these ops to
get/set wb info.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |   79 +++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 82d601c..215958e 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -287,9 +287,83 @@ static int writeback_panel_resume(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static int writeback_panel_rotate(struct omap_dss_device *dssdev, u8 rotate)
+{
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.rotation = rotate;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set rotation %d\n", rotate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 writeback_panel_get_rotate(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	return info.rotation;
+}
+
+static int writeback_panel_mirror(struct omap_dss_device *dssdev, bool mirror)
+{
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.mirror = mirror;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set mirror %d\n", mirror);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool writeback_panel_get_mirror(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	return info.mirror;
+}
+
 static void writeback_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.buf_width = timings->x_res;
+	info.buf_height = timings->y_res;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set timings %d, %d\n",
+			timings->x_res, timings->y_res);
+		return;
+	}
+
 	dssdev->panel.timings.x_res = timings->x_res;
 	dssdev->panel.timings.y_res = timings->y_res;
 }
@@ -315,6 +389,11 @@ static struct omap_dss_driver writeback_panel_driver = {
 	.suspend = writeback_panel_suspend,
 	.resume = writeback_panel_resume,
 
+	.set_rotate = writeback_panel_rotate,
+	.get_rotate = writeback_panel_get_rotate,
+	.set_mirror = writeback_panel_mirror,
+	.get_mirror = writeback_panel_get_mirror,
+
 	.set_timings = writeback_panel_set_timings,
 	.get_timings = writeback_panel_get_timings,
 	.check_timings = writeback_panel_check_timings,
-- 
1.7.4.1

