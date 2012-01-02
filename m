From: <mythripk@ti.com>
Subject: [PATCH v2 2/4] OMAPDSS: HDMI: update static timing table
Date: Mon, 2 Jan 2012 14:14:54 +0530
Message-ID: <1325493896-26355-3-git-send-email-mythripk@ti.com>
References: <1325493896-26355-1-git-send-email-mythripk@ti.com>
 <1325493896-26355-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44368 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab2ABIw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jan 2012 03:52:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q028qOJ0027635
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 02:52:25 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q028qOG5015802
	for <linux-omap@vger.kernel.org>; Mon, 2 Jan 2012 14:22:24 +0530 (IST)
In-Reply-To: <1325493896-26355-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add the vsync polarity, hsync polarity, interlace to hdmi_video_timings.
Remove the now duplicate structure hdmi_timings.
update the static table structure in HDMI with CEA/VESA code and mode.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |   96 ++++++++++++++--------------
 drivers/video/omap2/dss/ti_hdmi.h         |   14 ++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   20 +++---
 3 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c56378c..f76ae47 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -88,42 +88,42 @@ static struct {
  * map it to corresponding CEA or VESA index.
  */
 
-static const struct hdmi_timings cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {
-	{ {640, 480, 25200, 96, 16, 48, 2, 10, 33} , 0 , 0},
-	{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20}, 1, 1},
-	{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1},
-	{ {720, 480, 27027, 62, 16, 60, 6, 9, 30}, 0, 0},
-	{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39}, 0, 0},
-	{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15}, 0, 0},
-	{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19}, 0, 0},
-	{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15}, 1, 1},
-	{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15}, 1, 1},
-	{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36}, 1, 1},
-	{ {720, 576, 27000, 64, 12, 68, 5, 5, 39}, 0, 0},
-	{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39}, 0, 0},
-	{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36}, 1, 1},
-	{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30}, 0, 0},
-	{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36}, 1, 1},
-	/* VESA From Here */
-	{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31}, 0, 0},
-	{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23}, 1, 1},
-	{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23}, 1, 1},
-	{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20}, 1, 0},
-	{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22}, 1, 0},
-	{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18}, 1, 1},
-	{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36}, 1, 1},
-	{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38}, 1, 1},
-	{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29}, 0, 0},
-	{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32}, 1, 0},
-	{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25}, 1, 0},
-	{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30}, 1, 0},
-	{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24}, 1, 1},
-	{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36}, 1, 1},
-	{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12}, 0, 1},
-	{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23}, 0, 1},
-	{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21}, 0, 1},
-	{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14}, 0, 1},
-	{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1}
+static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {
+{ {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI} },
+{ {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} },
+{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDMI} },
+{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15, 1, 1, 1}, {5, HDMI_HDMI} },
+{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15, 0, 0, 1}, {6, HDMI_HDMI} },
+{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36, 1, 1, 0}, {16, HDMI_HDMI} },
+{ {720, 576, 27000, 64, 12, 68, 5, 5, 39, 0, 0, 0}, {17, HDMI_HDMI} },
+{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20, 1, 1, 0}, {19, HDMI_HDMI} },
+{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15, 1, 1, 1}, {20, HDMI_HDMI} },
+{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19, 0, 0, 1}, {21, HDMI_HDMI} },
+{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39, 0, 0, 0}, {29, HDMI_HDMI} },
+{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36, 1, 1, 0}, {31, HDMI_HDMI} },
+{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_HDMI} },
+{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_HDMI} },
+{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_HDMI} },
+/* VESA From Here */
+{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI} },
+{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI} },
+{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23, 1, 1, 0}, {0xE, HDMI_DVI} },
+{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20, 1, 0, 0}, {0x17, HDMI_DVI} },
+{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22, 1, 0, 0}, {0x1C, HDMI_DVI} },
+{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18, 1, 1, 0}, {0x27, HDMI_DVI} },
+{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36, 1, 1, 0}, {0x20, HDMI_DVI} },
+{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38, 1, 1, 0}, {0x23, HDMI_DVI} },
+{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29, 0, 0, 0}, {0x10, HDMI_DVI} },
+{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32, 1, 0, 0}, {0x2A, HDMI_DVI} },
+{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25, 1, 0, 0}, {0x2F, HDMI_DVI} },
+{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30, 1, 0, 0}, {0x3A, HDMI_DVI} },
+{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24, 1, 1, 0}, {0x51, HDMI_DVI} },
+{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36, 1, 1, 0}, {0x52, HDMI_DVI} },
+{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12, 0, 1, 0}, {0x16, HDMI_DVI} },
+{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23, 0, 1, 0}, {0x29, HDMI_DVI} },
+{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21, 0, 1, 0}, {0x39, HDMI_DVI} },
+{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14, 0, 1, 0}, {0x1B, HDMI_DVI} },
+{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_DVI} }
 };
 
 /*
@@ -253,23 +253,23 @@ static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
 static void update_hdmi_timings(struct hdmi_config *cfg,
 		struct omap_video_timings *timings, int code)
 {
-	cfg->timings.timings.x_res = timings->x_res;
-	cfg->timings.timings.y_res = timings->y_res;
-	cfg->timings.timings.hbp = timings->hbp;
-	cfg->timings.timings.hfp = timings->hfp;
-	cfg->timings.timings.hsw = timings->hsw;
-	cfg->timings.timings.vbp = timings->vbp;
-	cfg->timings.timings.vfp = timings->vfp;
-	cfg->timings.timings.vsw = timings->vsw;
-	cfg->timings.timings.pixel_clock = timings->pixel_clock;
-	cfg->timings.vsync_pol = cea_vesa_timings[code].vsync_pol;
-	cfg->timings.hsync_pol = cea_vesa_timings[code].hsync_pol;
+	cfg->timings.x_res = timings->x_res;
+	cfg->timings.y_res = timings->y_res;
+	cfg->timings.hbp = timings->hbp;
+	cfg->timings.hfp = timings->hfp;
+	cfg->timings.hsw = timings->hsw;
+	cfg->timings.vbp = timings->vbp;
+	cfg->timings.vfp = timings->vfp;
+	cfg->timings.vsw = timings->vsw;
+	cfg->timings.pixel_clock = timings->pixel_clock;
+	cfg->timings.vsync_pol = cea_vesa_timings[code].timings.vsync_pol;
+	cfg->timings.hsync_pol = cea_vesa_timings[code].timings.hsync_pol;
 }
 
 unsigned long hdmi_get_pixel_clock(void)
 {
 	/* HDMI Pixel Clock in Mhz */
-	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 1000;
+	return hdmi.ip_data.cfg.timings.pixel_clock * 1000;
 }
 
 static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 2c3443d..3cf5198 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -42,6 +42,7 @@ enum hdmi_clk_refsel {
 	HDMI_REFSEL_SYSCLK = 3
 };
 
+/* HDMI timing structure */
 struct hdmi_video_timings {
 	u16 x_res;
 	u16 y_res;
@@ -53,13 +54,9 @@ struct hdmi_video_timings {
 	u16 vsw;
 	u16 vfp;
 	u16 vbp;
-};
-
-/* HDMI timing structure */
-struct hdmi_timings {
-	struct hdmi_video_timings timings;
-	int vsync_pol;
-	int hsync_pol;
+	bool vsync_pol;
+	bool hsync_pol;
+	bool interlace;
 };
 
 struct hdmi_cm {
@@ -68,8 +65,7 @@ struct hdmi_cm {
 };
 
 struct hdmi_config {
-	struct hdmi_timings timings;
-	u16	interlace;
+	struct hdmi_video_timings timings;
 	struct hdmi_cm cm;
 };
 
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 403d6fc..ccc6254 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -656,15 +656,15 @@ static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
 {
 	pr_debug("Enter hdmi_wp_video_init_format\n");
 
-	video_fmt->y_res = param->timings.timings.y_res;
-	video_fmt->x_res = param->timings.timings.x_res;
-
-	timings->hbp = param->timings.timings.hbp;
-	timings->hfp = param->timings.timings.hfp;
-	timings->hsw = param->timings.timings.hsw;
-	timings->vbp = param->timings.timings.vbp;
-	timings->vfp = param->timings.timings.vfp;
-	timings->vsw = param->timings.timings.vsw;
+	video_fmt->y_res = param->timings.y_res;
+	video_fmt->x_res = param->timings.x_res;
+
+	timings->hbp = param->timings.hbp;
+	timings->hfp = param->timings.hfp;
+	timings->hsw = param->timings.hsw;
+	timings->vbp = param->timings.vbp;
+	timings->vfp = param->timings.vfp;
+	timings->vsw = param->timings.vsw;
 }
 
 static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
@@ -688,7 +688,7 @@ static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
 	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG);
 	r = FLD_MOD(r, ip_data->cfg.timings.vsync_pol, 7, 7);
 	r = FLD_MOD(r, ip_data->cfg.timings.hsync_pol, 6, 6);
-	r = FLD_MOD(r, ip_data->cfg.interlace, 3, 3);
+	r = FLD_MOD(r, ip_data->cfg.timings.interlace, 3, 3);
 	r = FLD_MOD(r, 1, 1, 0); /* HDMI_TIMING_MASTER_24BIT */
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, r);
 }
-- 
1.7.5.4

