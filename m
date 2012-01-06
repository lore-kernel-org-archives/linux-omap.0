From: <mythripk@ti.com>
Subject: [PATCH v4 4/4] OMAPDSS: HDMI: remove duplicate code and mode parameter
Date: Fri, 6 Jan 2012 17:52:10 +0530
Message-ID: <1325852530-4829-5-git-send-email-mythripk@ti.com>
References: <1325852530-4829-1-git-send-email-mythripk@ti.com>
 <1325852530-4829-2-git-send-email-mythripk@ti.com>
 <1325852530-4829-3-git-send-email-mythripk@ti.com>
 <1325852530-4829-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58542 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab2AFM3l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:29:41 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06CTdbA027402
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:29:40 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06CTdQq022452
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 17:59:39 +0530 (IST)
In-Reply-To: <1325852530-4829-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

code and mode parameters are already a part of the ip_data structure
so no need to keep the same parameters again in hdmi global structure.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 309b238..0caa1bb 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -66,8 +66,6 @@ static struct {
 	struct omap_display_platform_data *pdata;
 	struct platform_device *pdev;
 	struct hdmi_ip_data ip_data;
-	int code;
-	int mode;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -162,7 +160,7 @@ static const struct hdmi_config *hdmi_find_timing(
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (timings_arr[i].cm.code == hdmi.code)
+		if (timings_arr[i].cm.code == hdmi.ip_data.cfg.cm.code)
 			return &timings_arr[i];
 	}
 	return NULL;
@@ -173,7 +171,7 @@ static const struct hdmi_config *hdmi_get_timings(void)
        const struct hdmi_config *arr;
        int len;
 
-       if (hdmi.mode == HDMI_DVI) {
+       if (hdmi.ip_data.cfg.cm.mode == HDMI_DVI) {
                arr = vesa_timings;
                len = ARRAY_SIZE(vesa_timings);
        } else {
@@ -313,9 +311,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	timing = hdmi_get_timings();
 	if (timing == NULL) {
 		/* HDMI code 4 corresponds to 640 * 480 VGA */
-		hdmi.code = 4;
+		hdmi.ip_data.cfg.cm.code = 4;
 		/* DVI mode 1 corresponds to HDMI 0 to DVI */
-		hdmi.mode = HDMI_DVI;
+		hdmi.ip_data.cfg.cm.mode = HDMI_DVI;
 		hdmi.ip_data.cfg = vesa_timings[0];
 	} else {
 		hdmi.ip_data.cfg = *timing;
@@ -339,8 +337,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
-	hdmi.ip_data.cfg.cm.code = hdmi.code;
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
@@ -400,8 +396,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	struct hdmi_cm cm;
 
 	cm = hdmi_get_code(&dssdev->panel.timings);
-	hdmi.code = cm.code;
-	hdmi.mode = cm.mode;
+	hdmi.ip_data.cfg.cm.code = cm.code;
+	hdmi.ip_data.cfg.cm.mode = cm.mode;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -667,7 +663,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 static int hdmi_audio_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	if (!hdmi.mode) {
+	if (!hdmi.ip_data.cfg.cm.mode) {
 		pr_err("Current video settings do not support audio.\n");
 		return -EIO;
 	}
-- 
1.7.5.4

