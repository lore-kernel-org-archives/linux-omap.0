From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 13/13] OMAPDSS: VENC: Add a get_timing function for VENC interface
Date: Thu, 9 Aug 2012 17:19:49 +0530
Message-ID: <1344512989-4071-14-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241Ab2HILwJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 07:52:09 -0400
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add function omapdss_venc_get_timing() which returns the timings
maintained by the VENC interface driver in it's driver data. This is just used
once by the driver during it's probe. This prevents the need for the panel
driver to configure default timings in it's probe.

Int the VENC interface's probe, the timings field is set to PAL as a default
value. The get_timing op makes more sense for interfaces which can be configured
to a default timing.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    2 ++
 drivers/video/omap2/dss/venc.c       |   13 +++++++++++++
 drivers/video/omap2/dss/venc_panel.c |   11 +++++------
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 69b6ab9..3fe76c0 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -474,6 +474,8 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev);
 void omapdss_venc_display_disable(struct omap_dss_device *dssdev);
 void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
+void omapdss_venc_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index d96025e..42f97ac 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -579,6 +579,18 @@ void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
 	mutex_unlock(&venc.venc_lock);
 }
 
+void omapdss_venc_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	DSSDBG("venc_set_timings\n");
+
+	mutex_lock(&venc.venc_lock);
+
+	*timings = venc.timings;
+
+	mutex_unlock(&venc.venc_lock);
+}
+
 int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -768,6 +780,7 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 	mutex_init(&venc.venc_lock);
 
 	venc.wss_data = 0;
+	venc.timings = omap_dss_pal_timings;
 
 	venc_mem = platform_get_resource(venc.pdev, IORESOURCE_MEM, 0);
 	if (!venc_mem) {
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index 350b0d9..fe9958d 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -84,14 +84,13 @@ static DEVICE_ATTR(output_type, S_IRUGO | S_IWUSR,
 
 static int venc_panel_probe(struct omap_dss_device *dssdev)
 {
+	struct omap_video_timings timings;
+
 	mutex_init(&venc_panel.lock);
 
-	/* set initial timings to PAL */
-	dssdev->panel.timings = (struct omap_video_timings)
-		{ 720, 574, 13500, 64, 12, 68, 5, 5, 41,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			true,
-		};
+	omapdss_venc_get_timings(dssdev, &timings);
+
+	dssdev->panel.timings = timings;
 
 	return device_create_file(&dssdev->dev, &dev_attr_output_type);
 }
-- 
1.7.9.5

