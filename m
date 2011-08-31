From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/12] OMAP: DSS2: HDMI: implement detect()
Date: Wed, 31 Aug 2011 16:23:20 +0300
Message-ID: <1314797003-17638-10-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51347 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755798Ab1HaNXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:51 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement detect() by checking the hot plug detect status.

The implementation is not very good, as it always turns on the HDMI
output to get the detection working. HDMI driver needs improvements so
that we could enable only core parts of it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h              |    1 +
 drivers/video/omap2/dss/hdmi.c             |   18 ++++++++++++++++++
 drivers/video/omap2/dss/hdmi_omap4_panel.c |   25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6102b80..dd7dc19 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -493,6 +493,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
+bool omapdss_hdmi_detect(void);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 55edbd2..e8a977e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1148,6 +1148,24 @@ int omapdss_hdmi_read_edid(u8 *buf, int len)
 	return r;
 }
 
+bool omapdss_hdmi_detect(void)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	r = hdmi_runtime_get();
+	BUG_ON(r);
+
+	/* HPD */
+	r = REG_GET(HDMI_CORE_SYS_SYS_STAT, 1, 1);
+
+	hdmi_runtime_put();
+	mutex_unlock(&hdmi.lock);
+
+	return r == 1;
+}
+
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
index ffea8d3..c859421 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <video/omapdss.h>
+#include <linux/slab.h>
 
 #include "dss.h"
 
@@ -198,6 +199,29 @@ err:
 	return r;
 }
 
+static bool hdmi_detect(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		r = omapdss_hdmi_display_enable(dssdev);
+		if (r)
+			goto err;
+	}
+
+	r = omapdss_hdmi_detect();
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
+			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+		omapdss_hdmi_display_disable(dssdev);
+err:
+	mutex_unlock(&hdmi.hdmi_lock);
+
+	return r;
+}
+
 static struct omap_dss_driver hdmi_driver = {
 	.probe		= hdmi_panel_probe,
 	.remove		= hdmi_panel_remove,
@@ -209,6 +233,7 @@ static struct omap_dss_driver hdmi_driver = {
 	.set_timings	= hdmi_set_timings,
 	.check_timings	= hdmi_check_timings,
 	.read_edid	= hdmi_read_edid,
+	.detect		= hdmi_detect,
 	.driver			= {
 		.name   = "hdmi_panel",
 		.owner  = THIS_MODULE,
-- 
1.7.4.1

