From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/15] OMAPDSS: HDMI: remove custom avi infoframe
Date: Tue, 24 Jun 2014 13:03:53 +0300
Message-ID: <1403604240-16738-9-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39613 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbaFXKEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 06:04:21 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We now use the common AVI infoframe support, so the OMAP specific AVI
infoframe code can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 90 ------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6cd4a755b0ac..e20fe5f70479 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -179,54 +179,6 @@ enum hdmi_audio_mclk_mode {
 	HDMI_AUDIO_MCLK_192FS = 7
 };
 
-/* INFOFRAME_AVI_ and INFOFRAME_AUDIO_ definitions */
-enum hdmi_core_infoframe {
-	HDMI_INFOFRAME_AVI_DB1Y_RGB = 0,
-	HDMI_INFOFRAME_AVI_DB1Y_YUV422 = 1,
-	HDMI_INFOFRAME_AVI_DB1Y_YUV444 = 2,
-	HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF = 0,
-	HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_ON =  1,
-	HDMI_INFOFRAME_AVI_DB1B_NO = 0,
-	HDMI_INFOFRAME_AVI_DB1B_VERT = 1,
-	HDMI_INFOFRAME_AVI_DB1B_HORI = 2,
-	HDMI_INFOFRAME_AVI_DB1B_VERTHORI = 3,
-	HDMI_INFOFRAME_AVI_DB1S_0 = 0,
-	HDMI_INFOFRAME_AVI_DB1S_1 = 1,
-	HDMI_INFOFRAME_AVI_DB1S_2 = 2,
-	HDMI_INFOFRAME_AVI_DB2C_NO = 0,
-	HDMI_INFOFRAME_AVI_DB2C_ITU601 = 1,
-	HDMI_INFOFRAME_AVI_DB2C_ITU709 = 2,
-	HDMI_INFOFRAME_AVI_DB2C_EC_EXTENDED = 3,
-	HDMI_INFOFRAME_AVI_DB2M_NO = 0,
-	HDMI_INFOFRAME_AVI_DB2M_43 = 1,
-	HDMI_INFOFRAME_AVI_DB2M_169 = 2,
-	HDMI_INFOFRAME_AVI_DB2R_SAME = 8,
-	HDMI_INFOFRAME_AVI_DB2R_43 = 9,
-	HDMI_INFOFRAME_AVI_DB2R_169 = 10,
-	HDMI_INFOFRAME_AVI_DB2R_149 = 11,
-	HDMI_INFOFRAME_AVI_DB3ITC_NO = 0,
-	HDMI_INFOFRAME_AVI_DB3ITC_YES = 1,
-	HDMI_INFOFRAME_AVI_DB3EC_XVYUV601 = 0,
-	HDMI_INFOFRAME_AVI_DB3EC_XVYUV709 = 1,
-	HDMI_INFOFRAME_AVI_DB3Q_DEFAULT = 0,
-	HDMI_INFOFRAME_AVI_DB3Q_LR = 1,
-	HDMI_INFOFRAME_AVI_DB3Q_FR = 2,
-	HDMI_INFOFRAME_AVI_DB3SC_NO = 0,
-	HDMI_INFOFRAME_AVI_DB3SC_HORI = 1,
-	HDMI_INFOFRAME_AVI_DB3SC_VERT = 2,
-	HDMI_INFOFRAME_AVI_DB3SC_HORIVERT = 3,
-	HDMI_INFOFRAME_AVI_DB5PR_NO = 0,
-	HDMI_INFOFRAME_AVI_DB5PR_2 = 1,
-	HDMI_INFOFRAME_AVI_DB5PR_3 = 2,
-	HDMI_INFOFRAME_AVI_DB5PR_4 = 3,
-	HDMI_INFOFRAME_AVI_DB5PR_5 = 4,
-	HDMI_INFOFRAME_AVI_DB5PR_6 = 5,
-	HDMI_INFOFRAME_AVI_DB5PR_7 = 6,
-	HDMI_INFOFRAME_AVI_DB5PR_8 = 7,
-	HDMI_INFOFRAME_AVI_DB5PR_9 = 8,
-	HDMI_INFOFRAME_AVI_DB5PR_10 = 9,
-};
-
 struct hdmi_cm {
 	int	code;
 	int	mode;
@@ -299,47 +251,6 @@ struct hdmi_core_audio_config {
 	bool					en_spdif;
 };
 
-/*
- * Refer to section 8.2 in HDMI 1.3 specification for
- * details about infoframe databytes
- */
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
-
 struct hdmi_wp_data {
 	void __iomem *base;
 };
@@ -360,7 +271,6 @@ struct hdmi_phy_data {
 struct hdmi_core_data {
 	void __iomem *base;
 
-	struct hdmi_core_infoframe_avi avi_cfg;
 	struct hdmi_avi_infoframe avi_infoframe;
 };
 
-- 
1.9.1

