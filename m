From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/15] OMAPDSS: HDMI: remove the unused code
Date: Tue, 24 Jun 2014 13:03:59 +0300
Message-ID: <1403604240-16738-15-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbaFXKEb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:31 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We no longer need the horrible driver internal videmode tables, which
were used to decide if a given videomode is a HDMI or DVI mode. So
remove all related code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h        |  11 -
 drivers/video/fbdev/omap2/dss/hdmi_common.c | 316 ----------------------------
 2 files changed, 327 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index e3956defc1c3..262771b9b76b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -179,11 +179,6 @@ enum hdmi_audio_mclk_mode {
 	HDMI_AUDIO_MCLK_192FS = 7
 };
 
-struct hdmi_cm {
-	int	code;
-	int	mode;
-};
-
 struct hdmi_video_format {
 	enum hdmi_packing_mode	packing_mode;
 	u32			y_res;	/* Line per panel */
@@ -192,7 +187,6 @@ struct hdmi_video_format {
 
 struct hdmi_config {
 	struct omap_video_timings timings;
-	struct hdmi_cm cm;
 	struct hdmi_avi_infoframe infoframe;
 	enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
 };
@@ -272,8 +266,6 @@ struct hdmi_phy_data {
 
 struct hdmi_core_data {
 	void __iomem *base;
-
-	struct hdmi_avi_infoframe avi_infoframe;
 };
 
 static inline void hdmi_write_reg(void __iomem *base_addr, const u32 idx,
@@ -339,9 +331,6 @@ int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy);
 int hdmi_phy_parse_lanes(struct hdmi_phy_data *phy, const u32 *lanes);
 
 /* HDMI common funcs */
-const struct hdmi_config *hdmi_default_timing(void);
-const struct hdmi_config *hdmi_get_timings(int mode, int code);
-struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing);
 int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	struct hdmi_phy_data *phy);
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 9a2c39cf297f..7d5f1039de9f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -1,18 +1,4 @@
 
-/*
- * Logic for the below structure :
- * user enters the CEA or VESA timings by specifying the HDMI/DVI code.
- * There is a correspondence between CEA/VESA timing and code, please
- * refer to section 6.3 in HDMI 1.3 specification for timing code.
- *
- * In the below structure, cea_vesa_timings corresponds to all OMAP4
- * supported CEA and VESA timing values.code_cea corresponds to the CEA
- * code, It is used to get the timing from cea_vesa_timing array.Similarly
- * with code_vesa. Code_index is used for back mapping, that is once EDID
- * is read from the TV, EDID is parsed to find the timing values and then
- * map it to corresponding CEA or VESA index.
- */
-
 #define DSS_SUBSYS_NAME "HDMI"
 
 #include <linux/kernel.h>
@@ -22,308 +8,6 @@
 
 #include "hdmi.h"
 
-static const struct hdmi_config cea_timings[] = {
-	{
-		{ 640, 480, 25200000, 96, 16, 48, 2, 10, 33,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 1, HDMI_HDMI },
-	},
-	{
-		{ 720, 480, 27027000, 62, 16, 60, 6, 9, 30,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 2, HDMI_HDMI },
-	},
-	{
-		{ 1280, 720, 74250000, 40, 110, 220, 5, 5, 20,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 4, HDMI_HDMI },
-	},
-	{
-		{ 1920, 540, 74250000, 44, 88, 148, 5, 2, 15,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			true, },
-		{ 5, HDMI_HDMI },
-	},
-	{
-		{ 1440, 240, 27027000, 124, 38, 114, 3, 4, 15,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			true, },
-		{ 6, HDMI_HDMI },
-	},
-	{
-		{ 1920, 1080, 148500000, 44, 88, 148, 5, 4, 36,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 16, HDMI_HDMI },
-	},
-	{
-		{ 720, 576, 27000000, 64, 12, 68, 5, 5, 39,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 17, HDMI_HDMI },
-	},
-	{
-		{ 1280, 720, 74250000, 40, 440, 220, 5, 5, 20,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 19, HDMI_HDMI },
-	},
-	{
-		{ 1920, 540, 74250000, 44, 528, 148, 5, 2, 15,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			true, },
-		{ 20, HDMI_HDMI },
-	},
-	{
-		{ 1440, 288, 27000000, 126, 24, 138, 3, 2, 19,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			true, },
-		{ 21, HDMI_HDMI },
-	},
-	{
-		{ 1440, 576, 54000000, 128, 24, 136, 5, 5, 39,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 29, HDMI_HDMI },
-	},
-	{
-		{ 1920, 1080, 148500000, 44, 528, 148, 5, 4, 36,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 31, HDMI_HDMI },
-	},
-	{
-		{ 1920, 1080, 74250000, 44, 638, 148, 5, 4, 36,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 32, HDMI_HDMI },
-	},
-	{
-		{ 2880, 480, 108108000, 248, 64, 240, 6, 9, 30,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 35, HDMI_HDMI },
-	},
-	{
-		{ 2880, 576, 108000000, 256, 48, 272, 5, 5, 39,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 37, HDMI_HDMI },
-	},
-};
-
-static const struct hdmi_config vesa_timings[] = {
-/* VESA From Here */
-	{
-		{ 640, 480, 25175000, 96, 16, 48, 2, 11, 31,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 4, HDMI_DVI },
-	},
-	{
-		{ 800, 600, 40000000, 128, 40, 88, 4, 1, 23,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 9, HDMI_DVI },
-	},
-	{
-		{ 848, 480, 33750000, 112, 16, 112, 8, 6, 23,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0xE, HDMI_DVI },
-	},
-	{
-		{ 1280, 768, 79500000, 128, 64, 192, 7, 3, 20,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x17, HDMI_DVI },
-	},
-	{
-		{ 1280, 800, 83500000, 128, 72, 200, 6, 3, 22,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x1C, HDMI_DVI },
-	},
-	{
-		{ 1360, 768, 85500000, 112, 64, 256, 6, 3, 18,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x27, HDMI_DVI },
-	},
-	{
-		{ 1280, 960, 108000000, 112, 96, 312, 3, 1, 36,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x20, HDMI_DVI },
-	},
-	{
-		{ 1280, 1024, 108000000, 112, 48, 248, 3, 1, 38,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x23, HDMI_DVI },
-	},
-	{
-		{ 1024, 768, 65000000, 136, 24, 160, 6, 3, 29,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x10, HDMI_DVI },
-	},
-	{
-		{ 1400, 1050, 121750000, 144, 88, 232, 4, 3, 32,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x2A, HDMI_DVI },
-	},
-	{
-		{ 1440, 900, 106500000, 152, 80, 232, 6, 3, 25,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x2F, HDMI_DVI },
-	},
-	{
-		{ 1680, 1050, 146250000, 176 , 104, 280, 6, 3, 30,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
-			false, },
-		{ 0x3A, HDMI_DVI },
-	},
-	{
-		{ 1366, 768, 85500000, 143, 70, 213, 3, 3, 24,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x51, HDMI_DVI },
-	},
-	{
-		{ 1920, 1080, 148500000, 44, 148, 80, 5, 4, 36,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x52, HDMI_DVI },
-	},
-	{
-		{ 1280, 768, 68250000, 32, 48, 80, 7, 3, 12,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x16, HDMI_DVI },
-	},
-	{
-		{ 1400, 1050, 101000000, 32, 48, 80, 4, 3, 23,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x29, HDMI_DVI },
-	},
-	{
-		{ 1680, 1050, 119000000, 32, 48, 80, 6, 3, 21,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x39, HDMI_DVI },
-	},
-	{
-		{ 1280, 800, 79500000, 32, 48, 80, 6, 3, 14,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x1B, HDMI_DVI },
-	},
-	{
-		{ 1280, 720, 74250000, 40, 110, 220, 5, 5, 20,
-			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x55, HDMI_DVI },
-	},
-	{
-		{ 1920, 1200, 154000000, 32, 48, 80, 6, 3, 26,
-			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
-			false, },
-		{ 0x44, HDMI_DVI },
-	},
-};
-
-const struct hdmi_config *hdmi_default_timing(void)
-{
-	return &vesa_timings[0];
-}
-
-static const struct hdmi_config *hdmi_find_timing(int code,
-			const struct hdmi_config *timings_arr, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (timings_arr[i].cm.code == code)
-			return &timings_arr[i];
-	}
-
-	return NULL;
-}
-
-const struct hdmi_config *hdmi_get_timings(int mode, int code)
-{
-	const struct hdmi_config *arr;
-	int len;
-
-	if (mode == HDMI_DVI) {
-		arr = vesa_timings;
-		len = ARRAY_SIZE(vesa_timings);
-	} else {
-		arr = cea_timings;
-		len = ARRAY_SIZE(cea_timings);
-	}
-
-	return hdmi_find_timing(code, arr, len);
-}
-
-static bool hdmi_timings_compare(struct omap_video_timings *timing1,
-			const struct omap_video_timings *timing2)
-{
-	int timing1_vsync, timing1_hsync, timing2_vsync, timing2_hsync;
-
-	if ((DIV_ROUND_CLOSEST(timing2->pixelclock, 1000000) ==
-			DIV_ROUND_CLOSEST(timing1->pixelclock, 1000000)) &&
-		(timing2->x_res == timing1->x_res) &&
-		(timing2->y_res == timing1->y_res)) {
-
-		timing2_hsync = timing2->hfp + timing2->hsw + timing2->hbp;
-		timing1_hsync = timing1->hfp + timing1->hsw + timing1->hbp;
-		timing2_vsync = timing2->vfp + timing2->vsw + timing2->vbp;
-		timing1_vsync = timing1->vfp + timing1->vsw + timing1->vbp;
-
-		DSSDBG("timing1_hsync = %d timing1_vsync = %d"\
-			"timing2_hsync = %d timing2_vsync = %d\n",
-			timing1_hsync, timing1_vsync,
-			timing2_hsync, timing2_vsync);
-
-		if ((timing1_hsync == timing2_hsync) &&
-			(timing1_vsync == timing2_vsync)) {
-			return true;
-		}
-	}
-	return false;
-}
-
-struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
-{
-	int i;
-	struct hdmi_cm cm = {-1};
-	DSSDBG("hdmi_get_code\n");
-
-	for (i = 0; i < ARRAY_SIZE(cea_timings); i++) {
-		if (hdmi_timings_compare(timing, &cea_timings[i].timings)) {
-			cm = cea_timings[i].cm;
-			goto end;
-		}
-	}
-	for (i = 0; i < ARRAY_SIZE(vesa_timings); i++) {
-		if (hdmi_timings_compare(timing, &vesa_timings[i].timings)) {
-			cm = vesa_timings[i].cm;
-			goto end;
-		}
-	}
-
-end:
-	return cm;
-}
-
 int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	struct hdmi_phy_data *phy)
 {
-- 
1.9.1

