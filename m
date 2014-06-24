From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/15] OMAPDSS: HDMI4: add support to set infoframe & HDMI mode
Date: Tue, 24 Jun 2014 13:03:57 +0300
Message-ID: <1403604240-16738-13-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39619 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaFXKE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 06:04:28 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using hardcoded AVI infoframe, and a custom HDMI/DVI mode
selection based in internal videomode tables, add support to set the
infoframe and HDMI/DVI mode.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c      | 47 +++++++++-------------
 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 62 +++++++++---------------------
 2 files changed, 38 insertions(+), 71 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 626aad2bef46..342ddb47811a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -281,29 +281,11 @@ static int hdmi_display_check_timing(struct omap_dss_device *dssdev,
 static void hdmi_display_set_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct hdmi_cm cm;
-	const struct hdmi_config *t;
-
 	mutex_lock(&hdmi.lock);
 
-	cm = hdmi_get_code(timings);
-	hdmi.cfg.cm = cm;
-
-	t = hdmi_get_timings(cm.mode, cm.code);
-	if (t != NULL) {
-		hdmi.cfg = *t;
-
-		dispc_set_tv_pclk(t->timings.pixelclock);
-	} else {
-		hdmi.cfg.timings = *timings;
-		hdmi.cfg.cm.code = 0;
-		hdmi.cfg.cm.mode = HDMI_DVI;
-
-		dispc_set_tv_pclk(timings->pixelclock);
-	}
+	hdmi.cfg.timings = *timings;
 
-	DSSDBG("using mode: %s, code %d\n", hdmi.cfg.cm.mode == HDMI_DVI ?
-			"DVI" : "HDMI", hdmi.cfg.cm.code);
+	dispc_set_tv_pclk(timings->pixelclock);
 
 	mutex_unlock(&hdmi.lock);
 }
@@ -311,14 +293,7 @@ static void hdmi_display_set_timing(struct omap_dss_device *dssdev,
 static void hdmi_display_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	const struct hdmi_config *cfg;
-	struct hdmi_cm cm = hdmi.cfg.cm;
-
-	cfg = hdmi_get_timings(cm.mode, cm.code);
-	if (cfg == NULL)
-		cfg = hdmi_default_timing();
-
-	memcpy(timings, &cfg->timings, sizeof(cfg->timings));
+	*timings = hdmi.cfg.timings;
 }
 
 static void hdmi_dump_regs(struct seq_file *s)
@@ -615,6 +590,20 @@ static int hdmi_audio_config(struct omap_dss_device *dssdev,
 }
 #endif
 
+static int hdmi_set_infoframe(struct omap_dss_device *dssdev,
+		const struct hdmi_avi_infoframe *avi)
+{
+	hdmi.cfg.infoframe = *avi;
+	return 0;
+}
+
+static int hdmi_set_hdmi_mode(struct omap_dss_device *dssdev,
+		bool hdmi_mode)
+{
+	hdmi.cfg.hdmi_dvi_mode = hdmi_mode ? HDMI_HDMI : HDMI_DVI;
+	return 0;
+}
+
 static const struct omapdss_hdmi_ops hdmi_ops = {
 	.connect		= hdmi_connect,
 	.disconnect		= hdmi_disconnect,
@@ -627,6 +616,8 @@ static const struct omapdss_hdmi_ops hdmi_ops = {
 	.get_timings		= hdmi_display_get_timings,
 
 	.read_edid		= hdmi_read_edid,
+	.set_infoframe		= hdmi_set_infoframe,
+	.set_hdmi_mode		= hdmi_set_hdmi_mode,
 
 	.audio_enable		= hdmi_audio_enable,
 	.audio_disable		= hdmi_audio_disable,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index dbdbc5836d51..4ad39cfce254 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -197,8 +197,7 @@ int hdmi4_read_edid(struct hdmi_core_data *core, u8 *edid, int len)
 	return l;
 }
 
-static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-			struct hdmi_core_packet_enable_repeat *repeat_cfg)
+static void hdmi_core_init(struct hdmi_core_video_config *video_cfg)
 {
 	DSSDBG("Enter hdmi_core_init\n");
 
@@ -209,16 +208,6 @@ static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 	video_cfg->pkt_mode = HDMI_PACKETMODERESERVEDVALUE;
 	video_cfg->hdmi_dvi = HDMI_DVI;
 	video_cfg->tclk_sel_clkmult = HDMI_FPLL10IDCK;
-
-	/* packet enable and repeat */
-	repeat_cfg->audio_pkt = 0;
-	repeat_cfg->audio_pkt_repeat = 0;
-	repeat_cfg->avi_infoframe = 0;
-	repeat_cfg->avi_infoframe_repeat = 0;
-	repeat_cfg->gen_cntrl_pkt = 0;
-	repeat_cfg->gen_cntrl_pkt_repeat = 0;
-	repeat_cfg->generic_pkt = 0;
-	repeat_cfg->generic_pkt_repeat = 0;
 }
 
 static void hdmi_core_powerdown_disable(struct hdmi_core_data *core)
@@ -283,15 +272,18 @@ static void hdmi_core_video_config(struct hdmi_core_data *core,
 			HDMI_CORE_SYS_TMDS_CTRL, cfg->tclk_sel_clkmult, 6, 5);
 }
 
-static void hdmi_core_aux_infoframe_avi_config(struct hdmi_core_data *core)
+static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
+	struct hdmi_avi_infoframe *frame)
 {
 	void __iomem *av_base = hdmi_av_base(core);
-	struct hdmi_avi_infoframe *frame = &core->avi_infoframe;
 	u8 data[HDMI_INFOFRAME_SIZE(AVI)];
 	int i;
 
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
+	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
+		HDMI_INFOFRAME_SIZE(AVI), false);
+
 	for (i = 0; i < sizeof(data); ++i) {
 		hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_BASE + i * 4,
 			data[i]);
@@ -324,10 +316,9 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	struct hdmi_video_format video_format;
 	/* HDMI core */
 	struct hdmi_core_video_config v_core_cfg;
-	struct hdmi_core_packet_enable_repeat repeat_cfg;
-	struct hdmi_avi_infoframe *avi_infoframe = &core->avi_infoframe;
+	struct hdmi_core_packet_enable_repeat repeat_cfg = { 0 };
 
-	hdmi_core_init(&v_core_cfg, &repeat_cfg);
+	hdmi_core_init(&v_core_cfg);
 
 	hdmi_wp_init_vid_fmt_timings(&video_format, &video_timing, cfg);
 
@@ -350,39 +341,24 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	hdmi_core_powerdown_disable(core);
 
 	v_core_cfg.pkt_mode = HDMI_PACKETMODE24BITPERPIXEL;
-	v_core_cfg.hdmi_dvi = cfg->cm.mode;
+	v_core_cfg.hdmi_dvi = cfg->hdmi_dvi_mode;
 
 	hdmi_core_video_config(core, &v_core_cfg);
 
 	/* release software reset in the core */
 	hdmi_core_swreset_release(core);
 
-	/*
-	 * configure packet
-	 * info frame video see doc CEA861-D page 65
-	 */
-	hdmi_avi_infoframe_init(avi_infoframe);
-	avi_infoframe->colorspace = HDMI_COLORSPACE_RGB;
-	avi_infoframe->scan_mode = HDMI_SCAN_MODE_NONE;
-	avi_infoframe->colorimetry = HDMI_COLORIMETRY_NONE;
-	avi_infoframe->picture_aspect = HDMI_PICTURE_ASPECT_NONE;
-	avi_infoframe->active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
-	avi_infoframe->itc = 0;
-	avi_infoframe->extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
-	avi_infoframe->quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
-	avi_infoframe->nups = HDMI_NUPS_UNKNOWN;
-	avi_infoframe->video_code = cfg->cm.code;
-	avi_infoframe->ycc_quantization_range = HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
-	avi_infoframe->content_type = HDMI_CONTENT_TYPE_NONE;
-	avi_infoframe->pixel_repeat = 0;
-	hdmi_core_aux_infoframe_avi_config(core);
+	if (cfg->hdmi_dvi_mode == HDMI_HDMI) {
+		hdmi_core_write_avi_infoframe(core, &cfg->infoframe);
+
+		/* enable/repeat the infoframe */
+		repeat_cfg.avi_infoframe = HDMI_PACKETENABLE;
+		repeat_cfg.avi_infoframe_repeat = HDMI_PACKETREPEATON;
+		/* wakeup */
+		repeat_cfg.audio_pkt = HDMI_PACKETENABLE;
+		repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
+	}
 
-	/* enable/repeat the infoframe */
-	repeat_cfg.avi_infoframe = HDMI_PACKETENABLE;
-	repeat_cfg.avi_infoframe_repeat = HDMI_PACKETREPEATON;
-	/* wakeup */
-	repeat_cfg.audio_pkt = HDMI_PACKETENABLE;
-	repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
 	hdmi_core_av_packet_config(core, repeat_cfg);
 }
 
-- 
1.9.1

