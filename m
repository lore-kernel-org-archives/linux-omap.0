From: <mythripk@ti.com>
Subject: [PATCH v3 4/4] OMAPDSS: HDMI: remove duplicate code and mode parameter
Date: Wed, 4 Jan 2012 16:39:57 +0530
Message-ID: <1325675397-15241-5-git-send-email-mythripk@ti.com>
References: <1325675397-15241-1-git-send-email-mythripk@ti.com>
 <1325675397-15241-2-git-send-email-mythripk@ti.com>
 <1325675397-15241-3-git-send-email-mythripk@ti.com>
 <1325675397-15241-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab2ADLR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 06:17:28 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q04BHQoj022981
	for <linux-omap@vger.kernel.org>; Wed, 4 Jan 2012 05:17:27 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q04BHPdH008158
	for <linux-omap@vger.kernel.org>; Wed, 4 Jan 2012 16:47:25 +0530 (IST)
In-Reply-To: <1325675397-15241-4-git-send-email-mythripk@ti.com>
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
index 78aa904..4bb7678 100644
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
@@ -163,7 +161,7 @@ static const struct hdmi_config *hdmi_find_timing(
 	const struct hdmi_config *timing = NULL;
 
 	for (i = 0; i < len; i++) {
-		if (timings_arr[i].cm.code == hdmi.code) {
+		if (timings_arr[i].cm.code == hdmi.ip_data.cfg.cm.code) {
 			timing = &timings_arr[i];
 			return timing;
 		}
@@ -176,7 +174,7 @@ static const struct hdmi_config *hdmi_get_timings(void)
        const struct hdmi_config *arr;
        int len;
 
-       if (hdmi.mode == HDMI_DVI) {
+       if (hdmi.ip_data.cfg.cm.mode == HDMI_DVI) {
                arr = vesa_timings;
                len = ARRAY_SIZE(vesa_timings);
        } else {
@@ -314,9 +312,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	if (hdmi_get_timings() == NULL) {
 		/* HDMI code 4 corresponds to 640 * 480 VGA */
-		hdmi.code = 4;
+		hdmi.ip_data.cfg.cm.code = 4;
 		/* DVI mode 1 corresponds to HDMI 0 to DVI */
-		hdmi.mode = HDMI_DVI;
+		hdmi.ip_data.cfg.cm.mode = HDMI_DVI;
 		hdmi.ip_data.cfg = vesa_timings[0];
 	} else {
 		hdmi.ip_data.cfg = *(hdmi_get_timings());
@@ -340,8 +338,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
-	hdmi.ip_data.cfg.cm.code = hdmi.code;
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
@@ -401,8 +397,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	struct hdmi_cm cm;
 
 	cm = hdmi_get_code(&dssdev->panel.timings);
-	hdmi.code = cm.code;
-	hdmi.mode = cm.mode;
+	hdmi.ip_data.cfg.cm.code = cm.code;
+	hdmi.ip_data.cfg.cm.mode = cm.mode;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -668,7 +664,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
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

