From: <mythripk@ti.com>
Subject: [PATCH v2 1/5] OMAPDSS: HDMI: Move the comments in avi infoframe
Date: Thu, 22 Sep 2011 13:37:42 +0530
Message-ID: <1316678866-17749-2-git-send-email-mythripk@ti.com>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1IVIPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 04:15:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8M8FlwJ028489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 03:15:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8M8FlY1011456
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 13:45:47 +0530 (IST)
In-Reply-To: <1316678866-17749-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Move the comments in AVI infoframe structure above each parameter
to align with other comments in the header file

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   34 ++++++++++++++--------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 929de88..de1e199 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -455,40 +455,40 @@ struct hdmi_core_video_config {
  * details about infoframe databytes
  */
 struct hdmi_core_infoframe_avi {
+	/* Y0, Y1 rgb,yCbCr */
 	u8	db1_format;
-		/* Y0, Y1 rgb,yCbCr */
+	/* A0  Active information Present */
 	u8	db1_active_info;
-		/* A0  Active information Present */
+	/* B0, B1 Bar info data valid */
 	u8	db1_bar_info_dv;
-		/* B0, B1 Bar info data valid */
+	/* S0, S1 scan information */
 	u8	db1_scan_info;
-		/* S0, S1 scan information */
+	/* C0, C1 colorimetry */
 	u8	db2_colorimetry;
-		/* C0, C1 colorimetry */
+	/* M0, M1 Aspect ratio (4:3, 16:9) */
 	u8	db2_aspect_ratio;
-		/* M0, M1 Aspect ratio (4:3, 16:9) */
+	/* R0...R3 Active format aspect ratio */
 	u8	db2_active_fmt_ar;
-		/* R0...R3 Active format aspect ratio */
+	/* ITC IT content. */
 	u8	db3_itc;
-		/* ITC IT content. */
+	/* EC0, EC1, EC2 Extended colorimetry */
 	u8	db3_ec;
-		/* EC0, EC1, EC2 Extended colorimetry */
+	/* Q1, Q0 Quantization range */
 	u8	db3_q_range;
-		/* Q1, Q0 Quantization range */
+	/* SC1, SC0 Non-uniform picture scaling */
 	u8	db3_nup_scaling;
-		/* SC1, SC0 Non-uniform picture scaling */
+	/* VIC0..6 Video format identification */
 	u8	db4_videocode;
-		/* VIC0..6 Video format identification */
+	/* PR0..PR3 Pixel repetition factor */
 	u8	db5_pixel_repeat;
-		/* PR0..PR3 Pixel repetition factor */
+	/* Line number end of top bar */
 	u16	db6_7_line_eoftop;
-		/* Line number end of top bar */
+	/* Line number start of bottom bar */
 	u16	db8_9_line_sofbottom;
-		/* Line number start of bottom bar */
+	/* Pixel number end of left bar */
 	u16	db10_11_pixel_eofleft;
-		/* Pixel number end of left bar */
+	/* Pixel number start of right bar */
 	u16	db12_13_pixel_sofright;
-		/* Pixel number start of right bar */
 };
 /*
  * Refer to section 8.2 in HDMI 1.3 specification for
-- 
1.7.5.4

