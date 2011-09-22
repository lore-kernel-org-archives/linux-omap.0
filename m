From: <mythripk@ti.com>
Subject: [PATCH 1/3] OMAPDSS: HDMI: Move Avi infoframe structure to
Date: Thu, 22 Sep 2011 16:09:10 +0530
Message-ID: <1316687952-27686-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40550 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab1IVKrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 06:47:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MAlDM9013080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 05:47:15 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MAlCxG012133
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 16:17:12 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

With AVI infoframe various parameters of video stream such as
aspect ratio, quantization range, videocode etc will be indicated
from source to sink.Thus AVI information needs to be set/accessed
by the middle ware based on the video content.
Thus this parameter is now moved to the ip_data structure.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |   42 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    8 +++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   40 ---------------------------
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 2c3443d..f28f779 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -112,6 +112,47 @@ struct ti_hdmi_ip_ops {
 
 };
 
+/*
+ * Refer to section 8.2 in HDMI 1.3 specification for
+ * details about infoframe databytes
+ */
+struct hdmi_core_infoframe_avi {
+	/* Y0, Y1 rgb,yCbCr */
+	u8	db1_format;
+	/* A0  Active information Present */
+	u8	db1_active_info;
+	/* B0, B1 Bar info data valid */
+	u8	db1_bar_info_dv;
+	/* S0, S1 scan information */
+	u8	db1_scan_info;
+	/* C0, C1 colorimetry */
+	u8	db2_colorimetry;
+	/* M0, M1 Aspect ratio (4:3, 16:9) */
+	u8	db2_aspect_ratio;
+	/* R0...R3 Active format aspect ratio */
+	u8	db2_active_fmt_ar;
+	/* ITC IT content. */
+	u8	db3_itc;
+	/* EC0, EC1, EC2 Extended colorimetry */
+	u8	db3_ec;
+	/* Q1, Q0 Quantization range */
+	u8	db3_q_range;
+	/* SC1, SC0 Non-uniform picture scaling */
+	u8	db3_nup_scaling;
+	/* VIC0..6 Video format identification */
+	u8	db4_videocode;
+	/* PR0..PR3 Pixel repetition factor */
+	u8	db5_pixel_repeat;
+	/* Line number end of top bar */
+	u16	db6_7_line_eoftop;
+	/* Line number start of bottom bar */
+	u16	db8_9_line_sofbottom;
+	/* Pixel number end of left bar */
+	u16	db10_11_pixel_eofleft;
+	/* Pixel number start of right bar */
+	u16	db12_13_pixel_sofright;
+};
+
 struct hdmi_ip_data {
 	void __iomem	*base_wp;	/* HDMI wrapper */
 	unsigned long	core_sys_offset;
@@ -121,6 +162,7 @@ struct hdmi_ip_data {
 	const struct ti_hdmi_ip_ops *ops;
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
+	struct hdmi_core_infoframe_avi avi_cfg;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e1a6ce5..7b0dcd2 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -534,12 +534,12 @@ static void hdmi_core_video_config(struct hdmi_ip_data *ip_data,
 			HDMI_CORE_SYS_TMDS_CTRL, cfg->tclk_sel_clkmult, 6, 5);
 }
 
-static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data,
-		struct hdmi_core_infoframe_avi info_avi)
+static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data)
 {
 	u32 val;
 	char sum = 0, checksum = 0;
 	void __iomem *av_base = hdmi_av_base(ip_data);
+	struct hdmi_core_infoframe_avi info_avi = ip_data->avi_cfg;
 
 	sum += 0x82 + 0x002 + 0x00D;
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_TYPE, 0x082);
@@ -727,7 +727,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 	struct hdmi_video_format video_format;
 	struct hdmi_video_interface video_interface;
 	/* HDMI core */
-	struct hdmi_core_infoframe_avi avi_cfg;
+	struct hdmi_core_infoframe_avi avi_cfg = ip_data->avi_cfg;
 	struct hdmi_core_video_config v_core_cfg;
 	struct hdmi_core_packet_enable_repeat repeat_cfg;
 	struct hdmi_config *cfg = &ip_data->cfg;
@@ -795,7 +795,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data *ip_data)
 	avi_cfg.db10_11_pixel_eofleft = 0;
 	avi_cfg.db12_13_pixel_sofright = 0;
 
-	hdmi_core_aux_infoframe_avi_config(ip_data, avi_cfg);
+	hdmi_core_aux_infoframe_avi_config(ip_data);
 
 	/* enable/repeat the infoframe */
 	repeat_cfg.avi_infoframe = HDMI_PACKETENABLE;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 2040956..9f383c9 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -450,46 +450,6 @@ struct hdmi_core_video_config {
  * Refer to section 8.2 in HDMI 1.3 specification for
  * details about infoframe databytes
  */
-struct hdmi_core_infoframe_avi {
-	/* Y0, Y1 rgb,yCbCr */
-	u8	db1_format;
-	/* A0  Active information Present */
-	u8	db1_active_info;
-	/* B0, B1 Bar info data valid */
-	u8	db1_bar_info_dv;
-	/* S0, S1 scan information */
-	u8	db1_scan_info;
-	/* C0, C1 colorimetry */
-	u8	db2_colorimetry;
-	/* M0, M1 Aspect ratio (4:3, 16:9) */
-	u8	db2_aspect_ratio;
-	/* R0...R3 Active format aspect ratio */
-	u8	db2_active_fmt_ar;
-	/* ITC IT content. */
-	u8	db3_itc;
-	/* EC0, EC1, EC2 Extended colorimetry */
-	u8	db3_ec;
-	/* Q1, Q0 Quantization range */
-	u8	db3_q_range;
-	/* SC1, SC0 Non-uniform picture scaling */
-	u8	db3_nup_scaling;
-	/* VIC0..6 Video format identification */
-	u8	db4_videocode;
-	/* PR0..PR3 Pixel repetition factor */
-	u8	db5_pixel_repeat;
-	/* Line number end of top bar */
-	u16	db6_7_line_eoftop;
-	/* Line number start of bottom bar */
-	u16	db8_9_line_sofbottom;
-	/* Pixel number end of left bar */
-	u16	db10_11_pixel_eofleft;
-	/* Pixel number start of right bar */
-	u16	db12_13_pixel_sofright;
-};
-/*
- * Refer to section 8.2 in HDMI 1.3 specification for
- * details about infoframe databytes
- */
 struct hdmi_core_infoframe_audio {
 	u8 db1_coding_type;
 	u8 db1_channel_count;
-- 
1.7.5.4

