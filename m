From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 05/15] OMAP: DSS2: HDMI: remove edid parsing
Date: Mon, 12 Sep 2011 12:13:28 +0300
Message-ID: <1315818818-18733-6-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36295 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754239Ab1ILJOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:02 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

OMAPFB handles EDID parsing now, using the common helper functions in
fbdev. We can remove the EDID parsing from HDMI driver.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c       |  154 ----------------------------------
 drivers/video/omap2/dss/hdmi_panel.c |    8 +--
 2 files changed, 1 insertions(+), 161 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8a04ee1..bf85cba 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -70,9 +70,6 @@ static struct {
 	struct hdmi_ip_data ip_data;
 	int code;
 	int mode;
-	u8 edid[HDMI_EDID_MAX_LENGTH];
-	u8 edid_set;
-	bool custom_set;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -162,8 +159,6 @@ static const int code_vesa[85] = {
 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
 	-1, 27, 28, -1, 33};
 
-static const u8 edid_header[8] = {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0};
-
 static int hdmi_runtime_get(void)
 {
 	int r;
@@ -193,21 +188,6 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void copy_hdmi_to_dss_timings(
-		const struct hdmi_video_timings *hdmi_timings,
-		struct omap_video_timings *timings)
-{
-	timings->x_res = hdmi_timings->x_res;
-	timings->y_res = hdmi_timings->y_res;
-	timings->pixel_clock = hdmi_timings->pixel_clock;
-	timings->hbp = hdmi_timings->hbp;
-	timings->hfp = hdmi_timings->hfp;
-	timings->hsw = hdmi_timings->hsw;
-	timings->vbp = hdmi_timings->vbp;
-	timings->vfp = hdmi_timings->vfp;
-	timings->vsw = hdmi_timings->vsw;
-}
-
 static int get_timings_index(void)
 {
 	int code;
@@ -270,130 +250,6 @@ static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
 	return cm;
 }
 
-static void get_horz_vert_timing_info(int current_descriptor_addrs, u8 *edid ,
-		struct omap_video_timings *timings)
-{
-	/* X and Y resolution */
-	timings->x_res = (((edid[current_descriptor_addrs + 4] & 0xF0) << 4) |
-			 edid[current_descriptor_addrs + 2]);
-	timings->y_res = (((edid[current_descriptor_addrs + 7] & 0xF0) << 4) |
-			 edid[current_descriptor_addrs + 5]);
-
-	timings->pixel_clock = ((edid[current_descriptor_addrs + 1] << 8) |
-				edid[current_descriptor_addrs]);
-
-	timings->pixel_clock = 10 * timings->pixel_clock;
-
-	/* HORIZONTAL FRONT PORCH */
-	timings->hfp = edid[current_descriptor_addrs + 8] |
-			((edid[current_descriptor_addrs + 11] & 0xc0) << 2);
-	/* HORIZONTAL SYNC WIDTH */
-	timings->hsw = edid[current_descriptor_addrs + 9] |
-			((edid[current_descriptor_addrs + 11] & 0x30) << 4);
-	/* HORIZONTAL BACK PORCH */
-	timings->hbp = (((edid[current_descriptor_addrs + 4] & 0x0F) << 8) |
-			edid[current_descriptor_addrs + 3]) -
-			(timings->hfp + timings->hsw);
-	/* VERTICAL FRONT PORCH */
-	timings->vfp = ((edid[current_descriptor_addrs + 10] & 0xF0) >> 4) |
-			((edid[current_descriptor_addrs + 11] & 0x0f) << 2);
-	/* VERTICAL SYNC WIDTH */
-	timings->vsw = (edid[current_descriptor_addrs + 10] & 0x0F) |
-			((edid[current_descriptor_addrs + 11] & 0x03) << 4);
-	/* VERTICAL BACK PORCH */
-	timings->vbp = (((edid[current_descriptor_addrs + 7] & 0x0F) << 8) |
-			edid[current_descriptor_addrs + 6]) -
-			(timings->vfp + timings->vsw);
-
-}
-
-/* Description : This function gets the resolution information from EDID */
-static void get_edid_timing_data(u8 *edid)
-{
-	u8 count;
-	u16 current_descriptor_addrs;
-	struct hdmi_cm cm;
-	struct omap_video_timings edid_timings;
-
-	/* search block 0, there are 4 DTDs arranged in priority order */
-	for (count = 0; count < EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR; count++) {
-		current_descriptor_addrs =
-			EDID_DESCRIPTOR_BLOCK0_ADDRESS +
-			count * EDID_TIMING_DESCRIPTOR_SIZE;
-		get_horz_vert_timing_info(current_descriptor_addrs,
-				edid, &edid_timings);
-		cm = hdmi_get_code(&edid_timings);
-		DSSDBG("Block0[%d] value matches code = %d , mode = %d\n",
-			count, cm.code, cm.mode);
-		if (cm.code == -1) {
-			continue;
-		} else {
-			hdmi.code = cm.code;
-			hdmi.mode = cm.mode;
-			DSSDBG("code = %d , mode = %d\n",
-				hdmi.code, hdmi.mode);
-			return;
-		}
-	}
-	if (edid[0x7e] != 0x00) {
-		for (count = 0; count < EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR;
-			count++) {
-			current_descriptor_addrs =
-			EDID_DESCRIPTOR_BLOCK1_ADDRESS +
-			count * EDID_TIMING_DESCRIPTOR_SIZE;
-			get_horz_vert_timing_info(current_descriptor_addrs,
-						edid, &edid_timings);
-			cm = hdmi_get_code(&edid_timings);
-			DSSDBG("Block1[%d] value matches code = %d, mode = %d",
-				count, cm.code, cm.mode);
-			if (cm.code == -1) {
-				continue;
-			} else {
-				hdmi.code = cm.code;
-				hdmi.mode = cm.mode;
-				DSSDBG("code = %d , mode = %d\n",
-					hdmi.code, hdmi.mode);
-				return;
-			}
-		}
-	}
-
-	DSSINFO("no valid timing found , falling back to VGA\n");
-	hdmi.code = 4; /* setting default value of 640 480 VGA */
-	hdmi.mode = HDMI_DVI;
-}
-
-static void hdmi_read_edid(struct omap_video_timings *dp)
-{
-	int ret = 0, code;
-
-	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
-
-	if (!hdmi.edid_set)
-		ret = hdmi.ip_data.ops->read_edid(&hdmi.ip_data, hdmi.edid,
-						HDMI_EDID_MAX_LENGTH);
-	if (ret > 0) {
-		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
-			/* search for timings of default resolution */
-			get_edid_timing_data(hdmi.edid);
-			hdmi.edid_set = true;
-		}
-	} else {
-		DSSWARN("failed to read E-EDID\n");
-	}
-
-	if (!hdmi.edid_set) {
-		DSSINFO("fallback to VGA\n");
-		hdmi.code = 4; /* setting default value of 640 480 VGA */
-		hdmi.mode = HDMI_DVI;
-	}
-
-	code = get_timings_index();
-
-	copy_hdmi_to_dss_timings(&cea_vesa_timings[code].timings, dp);
-
-}
-
 static void update_hdmi_timings(struct hdmi_config *cfg,
 		struct omap_video_timings *timings, int code)
 {
@@ -479,13 +335,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
 
-	if (!hdmi.custom_set) {
-		DSSDBG("Read EDID as no EDID is not set on poweron\n");
-		hdmi_read_edid(p);
-	}
 	code = get_timings_index();
-	copy_hdmi_to_dss_timings(&cea_vesa_timings[code].timings,
-			&dssdev->panel.timings);
 	update_hdmi_timings(&hdmi.ip_data.cfg, p, code);
 
 	phy = p->pixel_clock;
@@ -547,8 +397,6 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
-
-	hdmi.edid_set = 0;
 }
 
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
@@ -570,8 +418,6 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 {
 	struct hdmi_cm cm;
 
-	hdmi.custom_set = 1;
-
 	cm = hdmi_get_code(&dssdev->panel.timings);
 	hdmi.code = cm.code;
 	hdmi.mode = cm.mode;
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 624f170..79a3a5a 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -40,13 +40,7 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 	dssdev->panel.config = OMAP_DSS_LCD_TFT |
 			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 
-	/*
-	 * Initialize the timings to 640 * 480
-	 * This is only for framebuffer update not for TV timing setting
-	 * Setting TV timing will be done only on enable
-	 */
-	dssdev->panel.timings.x_res = 640;
-	dssdev->panel.timings.y_res = 480;
+	dssdev->panel.timings = (struct omap_video_timings){640, 480, 25175, 96, 16, 48, 2 , 11, 31};
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
 		dssdev->panel.timings.x_res,
-- 
1.7.4.1

