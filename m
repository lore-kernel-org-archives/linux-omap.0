From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/15] OMAPDSS: HDMI5: use common AVI infoframe support
Date: Tue, 24 Jun 2014 13:03:52 +0300
Message-ID: <1403604240-16738-8-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57837 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbaFXKEU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:20 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using OMAP specific AVI infoframe structs, use the common one
from include/linux/hdmi.h.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 122 +++++++++++++++--------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index 7528c7a42aa5..d46cb13b06bf 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -290,7 +290,6 @@ void hdmi5_core_dump(struct hdmi_core_data *core, struct seq_file *s)
 }
 
 static void hdmi_core_init(struct hdmi_core_vid_config *video_cfg,
-			struct hdmi_core_infoframe_avi *avi_cfg,
 			struct hdmi_config *cfg)
 {
 	DSSDBG("hdmi_core_init\n");
@@ -314,25 +313,6 @@ static void hdmi_core_init(struct hdmi_core_vid_config *video_cfg,
 				cfg->timings.vfp + cfg->timings.vbp;
 	video_cfg->v_fc_config.cm.mode = cfg->cm.mode;
 	video_cfg->v_fc_config.timings.interlace = cfg->timings.interlace;
-
-	/* info frame */
-	avi_cfg->db1_format = 0;
-	avi_cfg->db1_active_info = 0;
-	avi_cfg->db1_bar_info_dv = 0;
-	avi_cfg->db1_scan_info = 0;
-	avi_cfg->db2_colorimetry = 0;
-	avi_cfg->db2_aspect_ratio = 0;
-	avi_cfg->db2_active_fmt_ar = 0;
-	avi_cfg->db3_itc = 0;
-	avi_cfg->db3_ec = 0;
-	avi_cfg->db3_q_range = 0;
-	avi_cfg->db3_nup_scaling = 0;
-	avi_cfg->db4_videocode = 0;
-	avi_cfg->db5_pixel_repeat = 0;
-	avi_cfg->db6_7_line_eoftop = 0;
-	avi_cfg->db8_9_line_sofbottom = 0;
-	avi_cfg->db10_11_pixel_eofleft = 0;
-	avi_cfg->db12_13_pixel_sofright = 0;
 }
 
 /* DSS_HDMI_CORE_VIDEO_CONFIG */
@@ -440,22 +420,55 @@ static void hdmi_core_config_video_sampler(struct hdmi_core_data *core)
 
 static void hdmi_core_aux_infoframe_avi_config(struct hdmi_core_data *core)
 {
+	struct hdmi_avi_infoframe *frame = &core->avi_infoframe;
 	void __iomem *base = core->base;
-	struct hdmi_core_infoframe_avi avi = core->avi_cfg;
-
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF0, avi.db1_format, 1, 0);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF0, avi.db1_active_info, 6, 6);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF0, avi.db1_bar_info_dv, 3, 2);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF0, avi.db1_scan_info, 5, 4);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF1, avi.db2_colorimetry, 7, 6);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF1, avi.db2_aspect_ratio, 5, 4);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF1, avi.db2_active_fmt_ar, 3, 0);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF2, avi.db3_itc, 7, 7);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF2, avi.db3_ec, 6, 4);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF2, avi.db3_q_range, 3, 2);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVICONF2, avi.db3_nup_scaling, 1, 0);
-	REG_FLD_MOD(base, HDMI_CORE_FC_AVIVID, avi.db4_videocode, 6, 0);
-	REG_FLD_MOD(base, HDMI_CORE_FC_PRCONF, avi.db5_pixel_repeat, 3, 0);
+	u8 data[HDMI_INFOFRAME_SIZE(AVI)];
+	u8 *ptr;
+	unsigned y, a, b, s;
+	unsigned c, m, r;
+	unsigned itc, ec, q, sc;
+	unsigned vic;
+	unsigned yq, cn, pr;
+
+	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
+
+	ptr = data + HDMI_INFOFRAME_HEADER_SIZE;
+
+	y = (ptr[0] >> 5) & 0x3;
+	a = (ptr[0] >> 4) & 0x1;
+	b = (ptr[0] >> 2) & 0x3;
+	s = (ptr[0] >> 0) & 0x3;
+
+	c = (ptr[1] >> 6) & 0x3;
+	m = (ptr[1] >> 4) & 0x3;
+	r = (ptr[1] >> 0) & 0x3;
+
+	itc = (ptr[2] >> 7) & 0x1;
+	ec = (ptr[2] >> 4) & 0x7;
+	q = (ptr[2] >> 2) & 0x3;
+	sc = (ptr[2] >> 0) & 0x3;
+
+	vic = ptr[3];
+
+	yq = (ptr[4] >> 6) & 0x3;
+	cn = (ptr[4] >> 4) & 0x3;
+	pr = (ptr[4] >> 0) & 0xf;
+
+	hdmi_write_reg(base, HDMI_CORE_FC_AVICONF0,
+		(a << 6) | (s << 4) | (b << 2) | (y << 0));
+
+	hdmi_write_reg(base, HDMI_CORE_FC_AVICONF1,
+		(c << 6) | (m << 4) | (r << 0));
+
+	hdmi_write_reg(base, HDMI_CORE_FC_AVICONF2,
+		(itc << 7) | (ec << 4) | (q << 2) | (sc << 0));
+
+	hdmi_write_reg(base, HDMI_CORE_FC_AVIVID, vic);
+
+	hdmi_write_reg(base, HDMI_CORE_FC_AVICONF3,
+		(yq << 2) | (cn << 0));
+
+	REG_FLD_MOD(base, HDMI_CORE_FC_PRCONF, pr, 3, 0);
 }
 
 static void hdmi_core_csc_config(struct hdmi_core_data *core,
@@ -497,7 +510,7 @@ static void hdmi_core_configure_range(struct hdmi_core_data *core)
 
 	/* support limited range with 24 bit color depth for now */
 	csc_coeff = csc_table_deepcolor[0];
-	core->avi_cfg.db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_LR;
+	core->avi_infoframe.quantization_range = HDMI_QUANTIZATION_RANGE_LIMITED;
 
 	hdmi_core_csc_config(core, csc_coeff);
 	hdmi_core_aux_infoframe_avi_config(core);
@@ -591,11 +604,11 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct omap_video_timings video_timing;
 	struct hdmi_video_format video_format;
 	struct hdmi_core_vid_config v_core_cfg;
-	struct hdmi_core_infoframe_avi *avi_cfg = &core->avi_cfg;
+	struct hdmi_avi_infoframe *avi_infoframe = &core->avi_infoframe;
 
 	hdmi_core_mask_interrupts(core);
 
-	hdmi_core_init(&v_core_cfg, avi_cfg, cfg);
+	hdmi_core_init(&v_core_cfg, cfg);
 
 	hdmi_wp_init_vid_fmt_timings(&video_format, &video_timing, cfg);
 
@@ -624,25 +637,20 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	/*
 	 * configure packet info frame video see doc CEA861-D page 65
 	 */
-	avi_cfg->db1_format = HDMI_INFOFRAME_AVI_DB1Y_RGB;
-	avi_cfg->db1_active_info =
-			HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
-	avi_cfg->db1_bar_info_dv = HDMI_INFOFRAME_AVI_DB1B_NO;
-	avi_cfg->db1_scan_info = HDMI_INFOFRAME_AVI_DB1S_0;
-	avi_cfg->db2_colorimetry = HDMI_INFOFRAME_AVI_DB2C_NO;
-	avi_cfg->db2_aspect_ratio = HDMI_INFOFRAME_AVI_DB2M_NO;
-	avi_cfg->db2_active_fmt_ar = HDMI_INFOFRAME_AVI_DB2R_SAME;
-	avi_cfg->db3_itc = HDMI_INFOFRAME_AVI_DB3ITC_NO;
-	avi_cfg->db3_ec = HDMI_INFOFRAME_AVI_DB3EC_XVYUV601;
-	avi_cfg->db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_DEFAULT;
-	avi_cfg->db3_nup_scaling = HDMI_INFOFRAME_AVI_DB3SC_NO;
-	avi_cfg->db4_videocode = cfg->cm.code;
-	avi_cfg->db5_pixel_repeat = HDMI_INFOFRAME_AVI_DB5PR_NO;
-	avi_cfg->db6_7_line_eoftop = 0;
-	avi_cfg->db8_9_line_sofbottom = 0;
-	avi_cfg->db10_11_pixel_eofleft = 0;
-	avi_cfg->db12_13_pixel_sofright = 0;
-
+	hdmi_avi_infoframe_init(avi_infoframe);
+	avi_infoframe->colorspace = HDMI_COLORSPACE_RGB;
+	avi_infoframe->scan_mode = HDMI_SCAN_MODE_NONE;
+	avi_infoframe->colorimetry = HDMI_COLORIMETRY_NONE;
+	avi_infoframe->picture_aspect = HDMI_PICTURE_ASPECT_NONE;
+	avi_infoframe->active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
+	avi_infoframe->itc = 0;
+	avi_infoframe->extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+	avi_infoframe->quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
+	avi_infoframe->nups = HDMI_NUPS_UNKNOWN;
+	avi_infoframe->video_code = cfg->cm.code;
+	avi_infoframe->ycc_quantization_range = HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+	avi_infoframe->content_type = HDMI_CONTENT_TYPE_NONE;
+	avi_infoframe->pixel_repeat = 0;
 	hdmi_core_aux_infoframe_avi_config(core);
 
 	hdmi_core_enable_video_path(core);
-- 
1.9.1

