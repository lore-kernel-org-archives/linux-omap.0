From: <mythripk@ti.com>
Subject: [PATCH v4 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Fri, 6 Jan 2012 17:52:09 +0530
Message-ID: <1325852530-4829-4-git-send-email-mythripk@ti.com>
References: <1325852530-4829-1-git-send-email-mythripk@ti.com>
 <1325852530-4829-2-git-send-email-mythripk@ti.com>
 <1325852530-4829-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58540 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2AFM3k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:29:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06CTcFE027401
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:29:39 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06CTbsk022442
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 17:59:38 +0530 (IST)
In-Reply-To: <1325852530-4829-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Change the timing match logic, Instead of the statically mapped method
to get the corresponding timings for a given code and mode, move to a
simpler array indexed method. It  will help to scale up to add more
timings when needed.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |  176 +++++++++++++++++-----------------------
 1 files changed, 76 insertions(+), 100 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index f76ae47..309b238 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -58,8 +58,6 @@
 #define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
 #define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
 
-#define OMAP_HDMI_TIMINGS_NB			34
-
 #define HDMI_DEFAULT_REGN 16
 #define HDMI_DEFAULT_REGM2 1
 
@@ -88,7 +86,7 @@ static struct {
  * map it to corresponding CEA or VESA index.
  */
 
-static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {
+static const struct hdmi_config cea_timings[] = {
 { {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI} },
 { {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} },
 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDMI} },
@@ -104,6 +102,8 @@ static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {
 { {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_HDMI} },
 { {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_HDMI} },
 { {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_HDMI} },
+};
+static const struct hdmi_config vesa_timings[] = {
 /* VESA From Here */
 { {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI} },
 { {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI} },
@@ -126,39 +126,6 @@ static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {
 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_DVI} }
 };
 
-/*
- * This is a static mapping array which maps the timing values
- * with corresponding CEA / VESA code
- */
-static const int code_index[OMAP_HDMI_TIMINGS_NB] = {
-	1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17, 29, 31, 35, 32,
-	/* <--15 CEA 17--> vesa*/
-	4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23, 0x10, 0x2A,
-	0X2F, 0x3A, 0X51, 0X52, 0x16, 0x29, 0x39, 0x1B
-};
-
-/*
- * This is reverse static mapping which maps the CEA / VESA code
- * to the corresponding timing values
- */
-static const int code_cea[39] = {
-	-1,  0,  3,  3,  2,  8,  5,  5, -1, -1,
-	-1, -1, -1, -1, -1, -1,  9, 10, 10,  1,
-	7,   6,  6, -1, -1, -1, -1, -1, -1, 11,
-	11, 12, 14, -1, -1, 13, 13,  4,  4
-};
-
-static const int code_vesa[85] = {
-	-1, -1, -1, -1, 15, -1, -1, -1, -1, 16,
-	-1, -1, -1, -1, 17, -1, 23, -1, -1, -1,
-	-1, -1, 29, 18, -1, -1, -1, 32, 19, -1,
-	-1, -1, 21, -1, -1, 22, -1, -1, -1, 20,
-	-1, 30, 24, -1, -1, -1, -1, 25, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, 31, 26, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
-	-1, 27, 28, -1, 33};
-
 static int hdmi_runtime_get(void)
 {
 	int r;
@@ -188,82 +155,83 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int get_timings_index(void)
+static const struct hdmi_config *hdmi_find_timing(
+					const struct hdmi_config *timings_arr,
+					int len)
 {
-	int code;
+	int i;
 
-	if (hdmi.mode == 0)
-		code = code_vesa[hdmi.code];
-	else
-		code = code_cea[hdmi.code];
+	for (i = 0; i < len; i++) {
+		if (timings_arr[i].cm.code == hdmi.code)
+			return &timings_arr[i];
+	}
+	return NULL;
+}
 
-	if (code == -1)	{
-		/* HDMI code 4 corresponds to 640 * 480 VGA */
-		hdmi.code = 4;
-		/* DVI mode 1 corresponds to HDMI 0 to DVI */
-		hdmi.mode = HDMI_DVI;
+static const struct hdmi_config *hdmi_get_timings(void)
+{
+       const struct hdmi_config *arr;
+       int len;
+
+       if (hdmi.mode == HDMI_DVI) {
+               arr = vesa_timings;
+               len = ARRAY_SIZE(vesa_timings);
+       } else {
+               arr = cea_timings;
+               len = ARRAY_SIZE(cea_timings);
+       }
+
+       return hdmi_find_timing(arr, len);
+}
+
+static bool hdmi_timings_compare(struct omap_video_timings *timing1,
+				const struct hdmi_video_timings *timing2)
+{
+	int timing1_vsync, timing1_hsync, timing2_vsync, timing2_hsync;
+
+	if ((timing2->pixel_clock == timing1->pixel_clock) &&
+		(timing2->x_res == timing1->x_res) &&
+		(timing2->y_res == timing1->y_res)) {
+
+		timing2_hsync = timing2->hfp + timing2->hsw + timing2->hbp;
+		timing1_hsync = timing1->hfp + timing1->hsw + timing1->hbp;
+		timing2_vsync = timing2->vfp + timing2->vsw + timing2->vbp;
+		timing1_vsync = timing2->vfp + timing2->vsw + timing2->vbp;
 
-		code = code_vesa[hdmi.code];
+		DSSDBG("timing1_hsync = %d timing1_vsync = %d"\
+			"timing2_hsync = %d timing2_vsync = %d\n",
+			timing1_hsync, timing1_vsync,
+			timing2_hsync, timing2_vsync);
+
+		if ((timing1_hsync == timing2_hsync) &&
+			(timing1_vsync == timing2_vsync)) {
+			return true;
+		}
 	}
-	return code;
+	return false;
 }
 
 static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
 {
-	int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
-	int timing_vsync = 0, timing_hsync = 0;
-	struct hdmi_video_timings temp;
+	int i;
 	struct hdmi_cm cm = {-1};
 	DSSDBG("hdmi_get_code\n");
 
-	for (i = 0; i < OMAP_HDMI_TIMINGS_NB; i++) {
-		temp = cea_vesa_timings[i].timings;
-		if ((temp.pixel_clock == timing->pixel_clock) &&
-			(temp.x_res == timing->x_res) &&
-			(temp.y_res == timing->y_res)) {
-
-			temp_hsync = temp.hfp + temp.hsw + temp.hbp;
-			timing_hsync = timing->hfp + timing->hsw + timing->hbp;
-			temp_vsync = temp.vfp + temp.vsw + temp.vbp;
-			timing_vsync = timing->vfp + timing->vsw + timing->vbp;
-
-			DSSDBG("temp_hsync = %d , temp_vsync = %d"
-				"timing_hsync = %d, timing_vsync = %d\n",
-				temp_hsync, temp_hsync,
-				timing_hsync, timing_vsync);
-
-			if ((temp_hsync == timing_hsync) &&
-					(temp_vsync == timing_vsync)) {
-				code = i;
-				cm.code = code_index[i];
-				if (code < 14)
-					cm.mode = HDMI_HDMI;
-				else
-					cm.mode = HDMI_DVI;
-				DSSDBG("Hdmi_code = %d mode = %d\n",
-					 cm.code, cm.mode);
-				break;
-			 }
+	for (i = 0; i < ARRAY_SIZE(cea_timings); i++) {
+		if (hdmi_timings_compare(timing, &cea_timings[i].timings)) {
+			cm = cea_timings[i].cm;
+			goto end;
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(vesa_timings); i++) {
+		if (hdmi_timings_compare(timing, &vesa_timings[i].timings)) {
+			cm = vesa_timings[i].cm;
+			goto end;
 		}
 	}
 
-	return cm;
-}
+end:	return cm;
 
-static void update_hdmi_timings(struct hdmi_config *cfg,
-		struct omap_video_timings *timings, int code)
-{
-	cfg->timings.x_res = timings->x_res;
-	cfg->timings.y_res = timings->y_res;
-	cfg->timings.hbp = timings->hbp;
-	cfg->timings.hfp = timings->hfp;
-	cfg->timings.hsw = timings->hsw;
-	cfg->timings.vbp = timings->vbp;
-	cfg->timings.vfp = timings->vfp;
-	cfg->timings.vsw = timings->vsw;
-	cfg->timings.pixel_clock = timings->pixel_clock;
-	cfg->timings.vsync_pol = cea_vesa_timings[code].timings.vsync_pol;
-	cfg->timings.hsync_pol = cea_vesa_timings[code].timings.hsync_pol;
 }
 
 unsigned long hdmi_get_pixel_clock(void)
@@ -325,7 +293,8 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 
 static int hdmi_power_on(struct omap_dss_device *dssdev)
 {
-	int r, code = 0;
+	int r;
+	const struct hdmi_config *timing;
 	struct omap_video_timings *p;
 	unsigned long phy;
 
@@ -341,9 +310,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
 
-	code = get_timings_index();
-	update_hdmi_timings(&hdmi.ip_data.cfg, p, code);
-
+	timing = hdmi_get_timings();
+	if (timing == NULL) {
+		/* HDMI code 4 corresponds to 640 * 480 VGA */
+		hdmi.code = 4;
+		/* DVI mode 1 corresponds to HDMI 0 to DVI */
+		hdmi.mode = HDMI_DVI;
+		hdmi.ip_data.cfg = vesa_timings[0];
+	} else {
+		hdmi.ip_data.cfg = *timing;
+	}
 	phy = p->pixel_clock;
 
 	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
-- 
1.7.5.4

