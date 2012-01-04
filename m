From: <mythripk@ti.com>
Subject: [PATCH v3 1/4] OMAPDSS: HDMI: remove duplicate video interface code
Date: Wed, 4 Jan 2012 16:39:54 +0530
Message-ID: <1325675397-15241-2-git-send-email-mythripk@ti.com>
References: <1325675397-15241-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab2ADLR1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jan 2012 06:17:27 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q04BHPfm006143
	for <linux-omap@vger.kernel.org>; Wed, 4 Jan 2012 05:17:26 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q04BHOpT008146
	for <linux-omap@vger.kernel.org>; Wed, 4 Jan 2012 16:47:25 +0530 (IST)
In-Reply-To: <1325675397-15241-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

video interface structure is a duplicate structure with parameters which are
already present in ip_data config structure, Thus removing the structure and
modifying corresponding code.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   31 +++++++---------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    7 ------
 2 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e1a6ce5..403d6fc 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -629,8 +629,7 @@ static void hdmi_core_av_packet_config(struct hdmi_ip_data *ip_data,
 }
 
 static void hdmi_wp_init(struct omap_video_timings *timings,
-			struct hdmi_video_format *video_fmt,
-			struct hdmi_video_interface *video_int)
+			struct hdmi_video_format *video_fmt)
 {
 	pr_debug("Enter hdmi_wp_init\n");
 
@@ -645,12 +644,6 @@ static void hdmi_wp_init(struct omap_video_timings *timings,
 	video_fmt->y_res = 0;
 	video_fmt->x_res = 0;
 
-	video_int->vsp = 0;
-	video_int->hsp = 0;
-
-	video_int->interlacing = 0;
-	video_int->tm = 0; /* HDMI_TIMING_SLAVE */
-
 }
 
 void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
@@ -687,17 +680,16 @@ static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_SIZE, l);
 }
 
-static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data,
-		struct hdmi_video_interface *video_int)
+static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
 {
 	u32 r;
 	pr_debug("Enter hdmi_wp_video_config_interface\n");
 
 	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG);
-	r = FLD_MOD(r, video_int->vsp, 7, 7);
-	r = FLD_MOD(r, video_int->hsp, 6, 6);
-	r = FLD_MOD(r, video_int->interlacing, 3, 3);
-	r = FLD_MOD(r, video_int->tm, 1, 0);
+	r = FLD_MOD(r, ip_data->cfg.timings.vsync_pol, 7, 7);
+	r = FLD_MOD(r, ip_data->cfg.timings.hsync_pol, 6, 6);
+	r = FLD_MOD(r, ip_data->cfg.interlace, 3, 3);
+	r = FLD_MOD(r, 1, 1, 0); /* HDMI_TIMING_MASTER_24BIT */
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, r);
 }
 
@@ -725,15 +717,13 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 	/* HDMI */
 	struct omap_video_timings video_timing;
 	struct hdmi_video_format video_format;
-	struct hdmi_video_interface video_interface;
 	/* HDMI core */
 	struct hdmi_core_infoframe_avi avi_cfg;
 	struct hdmi_core_video_config v_core_cfg;
 	struct hdmi_core_packet_enable_repeat repeat_cfg;
 	struct hdmi_config *cfg = &ip_data->cfg;
 
-	hdmi_wp_init(&video_timing, &video_format,
-		&video_interface);
+	hdmi_wp_init(&video_timing, &video_format);
 
 	hdmi_core_init(&v_core_cfg,
 		&avi_cfg,
@@ -748,12 +738,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 
 	hdmi_wp_video_config_format(ip_data, &video_format);
 
-	video_interface.vsp = cfg->timings.vsync_pol;
-	video_interface.hsp = cfg->timings.hsync_pol;
-	video_interface.interlacing = cfg->interlace;
-	video_interface.tm = 1 ; /* HDMI_TIMING_MASTER_24BIT */
-
-	hdmi_wp_video_config_interface(ip_data, &video_interface);
+	hdmi_wp_video_config_interface(ip_data);
 
 	/*
 	 * configure core video part
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 2040956..914bec6 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -517,13 +517,6 @@ struct hdmi_video_format {
 	u32			x_res;	/* pixel per line */
 };
 
-struct hdmi_video_interface {
-	int	vsp;	/* Vsync polarity */
-	int	hsp;	/* Hsync polarity */
-	int	interlacing;
-	int	tm;	/* Timing mode */
-};
-
 struct hdmi_audio_format {
 	enum hdmi_stereo_channels		stereo_channels;
 	u8					active_chnnls_msk;
-- 
1.7.5.4

