From: <mythripk@ti.com>
Subject: [PATCH 4/4] OMAPDSS: HDMI: remove duplicate code and mode parameter
Date: Fri, 11 Nov 2011 18:39:37 +0530
Message-ID: <1321016977-1808-5-git-send-email-mythripk@ti.com>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
 <1321016977-1808-2-git-send-email-mythripk@ti.com>
 <1321016977-1808-3-git-send-email-mythripk@ti.com>
 <1321016977-1808-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab1KKNR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 08:17:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pABDHNe1002971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 07:17:25 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pABDHMSv021994
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 18:47:22 +0530 (IST)
In-Reply-To: <1321016977-1808-4-git-send-email-mythripk@ti.com>
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
index b859350..8d06ce6 100644
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
@@ -161,7 +159,7 @@ static bool hdmi_find_code(const struct hdmi_config *timings_arr,
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (timings_arr[i].cm.code == hdmi.code) {
+		if (timings_arr[i].cm.code == hdmi.ip_data.cfg.cm.code) {
 			*timing = timings_arr[i];
 			return true;
 		}
@@ -174,7 +172,7 @@ static void hdmi_get_timings(struct hdmi_config *timing)
 {
 	int r;
 
-	if (hdmi.mode == 0) {
+	if (hdmi.ip_data.cfg.cm.mode == 0) {
 		r = hdmi_find_code(vesa_timings,
 					ARRAY_SIZE(vesa_timings), timing);
 	} else {
@@ -183,9 +181,9 @@ static void hdmi_get_timings(struct hdmi_config *timing)
 	}
 	if (!r) {
 		/* HDMI code 4 corresponds to 640 * 480 VGA */
-		hdmi.code = 4;
+		hdmi.ip_data.cfg.cm.code = 4;
 		/* DVI mode 1 corresponds to HDMI 0 to DVI */
-		hdmi.mode = HDMI_DVI;
+		hdmi.ip_data.cfg.cm.mode = HDMI_DVI;
 		*timing = vesa_timings[0];
 	}
 }
@@ -335,8 +333,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	hdmi.ip_data.cfg.cm.mode = hdmi.mode;
-	hdmi.ip_data.cfg.cm.code = hdmi.code;
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
@@ -396,8 +392,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	struct hdmi_cm cm;
 
 	cm = hdmi_get_code(&dssdev->panel.timings);
-	hdmi.code = cm.code;
-	hdmi.mode = cm.mode;
+	hdmi.ip_data.cfg.cm.code = cm.code;
+	hdmi.ip_data.cfg.cm.mode = cm.mode;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -663,7 +659,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
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

