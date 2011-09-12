From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 04/15] OMAP: DSS2: HDMI: implement read_edid()
Date: Mon, 12 Sep 2011 12:13:27 +0300
Message-ID: <1315818818-18733-5-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56240 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754239Ab1ILJOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:00 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Implement read_edid() for HDMI by implementing necessary functions to
hdmi.c and to hdmi_omap4_panel.c.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h             |    1 +
 drivers/video/omap2/dss/hdmi.c            |   19 ++++++++++++-
 drivers/video/omap2/dss/hdmi_panel.c      |   24 +++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   41 +++++++++++++++-------------
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 48bba53..2e7799c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -494,6 +494,7 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
+int omapdss_hdmi_read_edid(u8 *buf, int len);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index f503aa4..8a04ee1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -372,7 +372,7 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 	if (!hdmi.edid_set)
 		ret = hdmi.ip_data.ops->read_edid(&hdmi.ip_data, hdmi.edid,
 						HDMI_EDID_MAX_LENGTH);
-	if (!ret) {
+	if (ret > 0) {
 		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
 			/* search for timings of default resolution */
 			get_edid_timing_data(hdmi.edid);
@@ -587,6 +587,23 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	}
 }
 
+int omapdss_hdmi_read_edid(u8 *buf, int len)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	r = hdmi_runtime_get();
+	BUG_ON(r);
+
+	r = hdmi.ip_data.ops->read_edid(&hdmi.ip_data, buf, len);
+
+	hdmi_runtime_put();
+	mutex_unlock(&hdmi.lock);
+
+	return r;
+}
+
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 8c851e6..624f170 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -185,6 +185,29 @@ err:
 	return r;
 }
 
+static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
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
+	r = omapdss_hdmi_read_edid(buf, len);
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
@@ -195,6 +218,7 @@ static struct omap_dss_driver hdmi_driver = {
 	.get_timings	= hdmi_get_timings,
 	.set_timings	= hdmi_set_timings,
 	.check_timings	= hdmi_check_timings,
+	.read_edid	= hdmi_read_edid,
 	.driver			= {
 		.name   = "hdmi_panel",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 403c662..d4cdfc2 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -370,29 +370,32 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 {
 	int r = 0, n = 0, i = 0;
 	int max_ext_blocks = (max_length / 128) - 1;
+	int len;
 
 	r = hdmi_core_ddc_edid(ip_data, pedid, 0);
-	if (r) {
+	if (r)
 		return r;
-	} else {
-		n = pedid[0x7e];
 
-		/*
-		 * README: need to comply with max_length set by the caller.
-		 * Better implementation should be to allocate necessary
-		 * memory to store EDID according to nb_block field found
-		 * in first block
-		 */
-		if (n > max_ext_blocks)
-			n = max_ext_blocks;
+	len = 128;
+	n = pedid[0x7e];
 
-		for (i = 1; i <= n; i++) {
-			r = hdmi_core_ddc_edid(ip_data, pedid, i);
-			if (r)
-				return r;
-		}
+	/*
+	 * README: need to comply with max_length set by the caller.
+	 * Better implementation should be to allocate necessary
+	 * memory to store EDID according to nb_block field found
+	 * in first block
+	 */
+	if (n > max_ext_blocks)
+		n = max_ext_blocks;
+
+	for (i = 1; i <= n; i++) {
+		r = hdmi_core_ddc_edid(ip_data, pedid, i);
+		if (r)
+			return r;
+		len += 128;
 	}
-	return 0;
+
+	return len;
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-- 
1.7.4.1

