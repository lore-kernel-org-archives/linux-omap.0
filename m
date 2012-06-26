From: Archit Taneja <archit@ti.com>
Subject: [PATCH 16/17] OMAPDSS: HDMI: Remove custom hdmi_video_timings struct
Date: Tue, 26 Jun 2012 15:06:53 +0530
Message-ID: <1340703414-1915-18-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37230 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180Ab2FZJja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:39:30 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mythri P K <mythripk@ti.com>

The hdmi CEA and VESA timings were represented by the struct hdmi_video_timings,
omap_video_timings couldn't be used as it didn't contain the fields hsync/vsync
polarities and interlaced/progressive information.

Remove hdmi_video_timings, and use omap_video_timings instead.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |  241 ++++++++++++++++++++++++-----
 drivers/video/omap2/dss/ti_hdmi.h         |   19 +--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    8 +-
 3 files changed, 213 insertions(+), 55 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 34910bc..46fb1be 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -78,43 +78,214 @@ static struct {
  */
 
 static const struct hdmi_config cea_timings[] = {
-{ {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI} },
-{ {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} },
-{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDMI} },
-{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15, 1, 1, 1}, {5, HDMI_HDMI} },
-{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15, 0, 0, 1}, {6, HDMI_HDMI} },
-{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36, 1, 1, 0}, {16, HDMI_HDMI} },
-{ {720, 576, 27000, 64, 12, 68, 5, 5, 39, 0, 0, 0}, {17, HDMI_HDMI} },
-{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20, 1, 1, 0}, {19, HDMI_HDMI} },
-{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15, 1, 1, 1}, {20, HDMI_HDMI} },
-{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19, 0, 0, 1}, {21, HDMI_HDMI} },
-{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39, 0, 0, 0}, {29, HDMI_HDMI} },
-{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36, 1, 1, 0}, {31, HDMI_HDMI} },
-{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_HDMI} },
-{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_HDMI} },
-{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_HDMI} },
+	{
+		{ 640, 480, 25200, 96, 16, 48, 2, 10, 33,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 1, HDMI_HDMI },
+	},
+	{
+		{ 720, 480, 27027, 62, 16, 60, 6, 9, 30,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 2, HDMI_HDMI },
+	},
+	{
+		{ 1280, 720, 74250, 40, 110, 220, 5, 5, 20,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 4, HDMI_HDMI },
+	},
+	{
+		{ 1920, 540, 74250, 44, 88, 148, 5, 2, 15,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			true, },
+		{ 5, HDMI_HDMI },
+	},
+	{
+		{ 1440, 240, 27027, 124, 38, 114, 3, 4, 15,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			true, },
+		{ 6, HDMI_HDMI },
+	},
+	{
+		{ 1920, 1080, 148500, 44, 88, 148, 5, 4, 36,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 16, HDMI_HDMI },
+	},
+	{
+		{ 720, 576, 27000, 64, 12, 68, 5, 5, 39,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 17, HDMI_HDMI },
+	},
+	{
+		{ 1280, 720, 74250, 40, 440, 220, 5, 5, 20,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 19, HDMI_HDMI },
+	},
+	{
+		{ 1920, 540, 74250, 44, 528, 148, 5, 2, 15,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			true, },
+		{ 20, HDMI_HDMI },
+	},
+	{
+		{ 1440, 288, 27000, 126, 24, 138, 3, 2, 19,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			true, },
+		{ 21, HDMI_HDMI },
+	},
+	{
+		{ 1440, 576, 54000, 128, 24, 136, 5, 5, 39,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 29, HDMI_HDMI },
+	},
+	{
+		{ 1920, 1080, 148500, 44, 528, 148, 5, 4, 36,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 31, HDMI_HDMI },
+	},
+	{
+		{ 1920, 1080, 74250, 44, 638, 148, 5, 4, 36,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 32, HDMI_HDMI },
+	},
+	{
+		{ 2880, 480, 108108, 248, 64, 240, 6, 9, 30,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 35, HDMI_HDMI },
+	},
+	{
+		{ 2880, 576, 108000, 256, 48, 272, 5, 5, 39,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 37, HDMI_HDMI },
+	},
 };
+
 static const struct hdmi_config vesa_timings[] = {
 /* VESA From Here */
-{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI} },
-{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI} },
-{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23, 1, 1, 0}, {0xE, HDMI_DVI} },
-{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20, 1, 0, 0}, {0x17, HDMI_DVI} },
-{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22, 1, 0, 0}, {0x1C, HDMI_DVI} },
-{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18, 1, 1, 0}, {0x27, HDMI_DVI} },
-{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36, 1, 1, 0}, {0x20, HDMI_DVI} },
-{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38, 1, 1, 0}, {0x23, HDMI_DVI} },
-{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29, 0, 0, 0}, {0x10, HDMI_DVI} },
-{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32, 1, 0, 0}, {0x2A, HDMI_DVI} },
-{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25, 1, 0, 0}, {0x2F, HDMI_DVI} },
-{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30, 1, 0, 0}, {0x3A, HDMI_DVI} },
-{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24, 1, 1, 0}, {0x51, HDMI_DVI} },
-{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36, 1, 1, 0}, {0x52, HDMI_DVI} },
-{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12, 0, 1, 0}, {0x16, HDMI_DVI} },
-{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23, 0, 1, 0}, {0x29, HDMI_DVI} },
-{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21, 0, 1, 0}, {0x39, HDMI_DVI} },
-{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14, 0, 1, 0}, {0x1B, HDMI_DVI} },
-{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_DVI} }
+	{
+		{ 640, 480, 25175, 96, 16, 48, 2, 11, 31,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 4, HDMI_DVI },
+	},
+	{
+		{ 800, 600, 40000, 128, 40, 88, 4, 1, 23,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 9, HDMI_DVI },
+	},
+	{
+		{ 848, 480, 33750, 112, 16, 112, 8, 6, 23,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0xE, HDMI_DVI },
+	},
+	{
+		{ 1280, 768, 79500, 128, 64, 192, 7, 3, 20,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x17, HDMI_DVI },
+	},
+	{
+		{ 1280, 800, 83500, 128, 72, 200, 6, 3, 22,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x1C, HDMI_DVI },
+	},
+	{
+		{ 1360, 768, 85500, 112, 64, 256, 6, 3, 18,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x27, HDMI_DVI },
+	},
+	{
+		{ 1280, 960, 108000, 112, 96, 312, 3, 1, 36,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x20, HDMI_DVI },
+	},
+	{
+		{ 1280, 1024, 108000, 112, 48, 248, 3, 1, 38,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x23, HDMI_DVI },
+	},
+	{
+		{ 1024, 768, 65000, 136, 24, 160, 6, 3, 29,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x10, HDMI_DVI },
+	},
+	{
+		{ 1400, 1050, 121750, 144, 88, 232, 4, 3, 32,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x2A, HDMI_DVI },
+	},
+	{
+		{ 1440, 900, 106500, 152, 80, 232, 6, 3, 25,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x2F, HDMI_DVI },
+	},
+	{
+		{ 1680, 1050, 146250, 176 , 104, 280, 6, 3, 30,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_LOW,
+			false, },
+		{ 0x3A, HDMI_DVI },
+	},
+	{
+		{ 1366, 768, 85500, 143, 70, 213, 3, 3, 24,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x51, HDMI_DVI },
+	},
+	{
+		{ 1920, 1080, 148500, 44, 148, 80, 5, 4, 36,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x52, HDMI_DVI },
+	},
+	{
+		{ 1280, 768, 68250, 32, 48, 80, 7, 3, 12,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x16, HDMI_DVI },
+	},
+	{
+		{ 1400, 1050, 101000, 32, 48, 80, 4, 3, 23,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x29, HDMI_DVI },
+	},
+	{
+		{ 1680, 1050, 119000, 32, 48, 80, 6, 3, 21,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x39, HDMI_DVI },
+	},
+	{
+		{ 1280, 800, 79500, 32, 48, 80, 6, 3, 14,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x1B, HDMI_DVI },
+	},
+	{
+		{ 1280, 720, 74250, 40, 110, 220, 5, 5, 20,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x55, HDMI_DVI },
+	},
 };
 
 static int hdmi_runtime_get(void)
@@ -179,7 +350,7 @@ static const struct hdmi_config *hdmi_get_timings(void)
 }
 
 static bool hdmi_timings_compare(struct omap_video_timings *timing1,
-				const struct hdmi_video_timings *timing2)
+				const struct omap_video_timings *timing2)
 {
 	int timing1_vsync, timing1_hsync, timing2_vsync, timing2_hsync;
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index e734cb4..913c4ca 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -42,30 +42,13 @@ enum hdmi_clk_refsel {
 	HDMI_REFSEL_SYSCLK = 3
 };
 
-/* HDMI timing structure */
-struct hdmi_video_timings {
-	u16 x_res;
-	u16 y_res;
-	/* Unit: KHz */
-	u32 pixel_clock;
-	u16 hsw;
-	u16 hfp;
-	u16 hbp;
-	u16 vsw;
-	u16 vfp;
-	u16 vbp;
-	bool vsync_pol;
-	bool hsync_pol;
-	bool interlace;
-};
-
 struct hdmi_cm {
 	int	code;
 	int	mode;
 };
 
 struct hdmi_config {
-	struct hdmi_video_timings timings;
+	struct omap_video_timings timings;
 	struct hdmi_cm cm;
 };
 
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 4dae1b2..92944ac 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -747,11 +747,15 @@ static void hdmi_wp_video_config_format(struct hdmi_ip_data *ip_data,
 static void hdmi_wp_video_config_interface(struct hdmi_ip_data *ip_data)
 {
 	u32 r;
+	bool vsync_pol, hsync_pol;
 	pr_debug("Enter hdmi_wp_video_config_interface\n");
 
+	vsync_pol = ip_data->cfg.timings.vsync_level == OMAPDSS_SIG_ACTIVE_HIGH;
+	hsync_pol = ip_data->cfg.timings.hsync_level == OMAPDSS_SIG_ACTIVE_HIGH;
+
 	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG);
-	r = FLD_MOD(r, ip_data->cfg.timings.vsync_pol, 7, 7);
-	r = FLD_MOD(r, ip_data->cfg.timings.hsync_pol, 6, 6);
+	r = FLD_MOD(r, vsync_pol, 7, 7);
+	r = FLD_MOD(r, hsync_pol, 6, 6);
 	r = FLD_MOD(r, ip_data->cfg.timings.interlace, 3, 3);
 	r = FLD_MOD(r, 1, 1, 0); /* HDMI_TIMING_MASTER_24BIT */
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, r);
-- 
1.7.9.5

