From: <mythripk@ti.com>
Subject: [PATCH 1/2] OMAPDSS: HDMI: Make Wrapper function non-static
Date: Fri, 9 Mar 2012 18:27:58 +0530
Message-ID: <1331297879-14622-2-git-send-email-mythripk@ti.com>
References: <1331297879-14622-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38629 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223Ab2CINFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 08:05:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q29D4xgd010129
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 07:04:59 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q29D4vRS020746
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 18:34:58 +0530 (IST)
In-Reply-To: <1331297879-14622-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

HDMI wrapper is same across OMAP4 and OMAP5, so the wrapper
functions can be re-used. Thus making wrapper functions as non-static.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   10 +++++-----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    9 +++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index bc55528..7ccac68 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -721,7 +721,7 @@ static void hdmi_core_av_packet_config(struct hdmi_ip_data *ip_data,
 		(repeat_cfg.generic_pkt_repeat));
 }
 
-static void hdmi_wp_init(struct omap_video_timings *timings,
+void hdmi_wp_init(struct omap_video_timings *timings,
 			struct hdmi_video_format *video_fmt)
 {
 	pr_debug("Enter hdmi_wp_init\n");
@@ -744,7 +744,7 @@ void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, bool start)
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, start, 31, 31);
 }
 
-static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
+void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
 	struct omap_video_timings *timings, struct hdmi_config *param)
 {
 	pr_debug("Enter hdmi_wp_video_init_format\n");
@@ -760,7 +760,7 @@ static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
 	timings->vsw = param->timings.vsw;
 }
 
-static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
+void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
 		struct hdmi_video_format *video_fmt)
 {
 	u32 l = 0;
@@ -773,7 +773,7 @@ static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_SIZE, l);
 }
 
-static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
+void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
 {
 	u32 r;
 	pr_debug("Enter hdmi_wp_video_config_interface\n");
@@ -786,7 +786,7 @@ static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, r);
 }
 
-static void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
+void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
 		struct omap_video_timings *timings)
 {
 	u32 timing_h = 0;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index efa6f29..c18f415 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -542,4 +542,13 @@ void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
 void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_format *aud_fmt);
 #endif
+void hdmi_wp_video_config_timing(struct hdmi_ip_data *ip_data,
+				struct omap_video_timings *timings);
+void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data);
+void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
+				struct hdmi_video_format *video_fmt);
+void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
+		struct omap_video_timings *timings, struct hdmi_config *param);
+void hdmi_wp_init(struct omap_video_timings *timings,
+			struct hdmi_video_format *video_fmt);
 #endif
-- 
1.7.5.4

