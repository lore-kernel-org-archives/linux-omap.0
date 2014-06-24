From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/15] OMAPDSS: HDMI5: add support to set infoframe & HDMI mode
Date: Tue, 24 Jun 2014 13:03:58 +0300
Message-ID: <1403604240-16738-14-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbaFXKEa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:30 -0400
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
 drivers/video/fbdev/omap2/dss/hdmi5.c      | 47 ++++++++++++------------------
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 36 +++++++----------------
 2 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index c468b9e1f295..713e35aa9291 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -299,29 +299,11 @@ static int hdmi_display_check_timing(struct omap_dss_device *dssdev,
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
@@ -329,14 +311,7 @@ static void hdmi_display_set_timing(struct omap_dss_device *dssdev,
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
@@ -640,6 +615,20 @@ static int hdmi_audio_config(struct omap_dss_device *dssdev,
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
@@ -652,6 +641,8 @@ static const struct omapdss_hdmi_ops hdmi_ops = {
 	.get_timings		= hdmi_display_get_timings,
 
 	.read_edid		= hdmi_read_edid,
+	.set_infoframe		= hdmi_set_infoframe,
+	.set_hdmi_mode		= hdmi_set_hdmi_mode,
 
 	.audio_enable		= hdmi_audio_enable,
 	.audio_disable		= hdmi_audio_disable,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index d46cb13b06bf..83acbf7a8c89 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -311,7 +311,7 @@ static void hdmi_core_init(struct hdmi_core_vid_config *video_cfg,
 	video_cfg->vblank_osc = 0; /* Always 0 - need to confirm */
 	video_cfg->vblank = cfg->timings.vsw +
 				cfg->timings.vfp + cfg->timings.vbp;
-	video_cfg->v_fc_config.cm.mode = cfg->cm.mode;
+	video_cfg->v_fc_config.hdmi_dvi_mode = cfg->hdmi_dvi_mode;
 	video_cfg->v_fc_config.timings.interlace = cfg->timings.interlace;
 }
 
@@ -378,7 +378,7 @@ static void hdmi_core_video_config(struct hdmi_core_data *core,
 
 	/* select DVI mode */
 	REG_FLD_MOD(base, HDMI_CORE_FC_INVIDCONF,
-			cfg->v_fc_config.cm.mode, 3, 3);
+			cfg->v_fc_config.hdmi_dvi_mode, 3, 3);
 }
 
 static void hdmi_core_config_video_packetizer(struct hdmi_core_data *core)
@@ -418,9 +418,9 @@ static void hdmi_core_config_video_sampler(struct hdmi_core_data *core)
 	REG_FLD_MOD(core->base, HDMI_CORE_TX_INVID0, video_mapping, 4, 0);
 }
 
-static void hdmi_core_aux_infoframe_avi_config(struct hdmi_core_data *core)
+static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
+	struct hdmi_avi_infoframe *frame)
 {
-	struct hdmi_avi_infoframe *frame = &core->avi_infoframe;
 	void __iomem *base = core->base;
 	u8 data[HDMI_INFOFRAME_SIZE(AVI)];
 	u8 *ptr;
@@ -432,6 +432,9 @@ static void hdmi_core_aux_infoframe_avi_config(struct hdmi_core_data *core)
 
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
+	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
+		HDMI_INFOFRAME_SIZE(AVI), false);
+
 	ptr = data + HDMI_INFOFRAME_HEADER_SIZE;
 
 	y = (ptr[0] >> 5) & 0x3;
@@ -510,10 +513,8 @@ static void hdmi_core_configure_range(struct hdmi_core_data *core)
 
 	/* support limited range with 24 bit color depth for now */
 	csc_coeff = csc_table_deepcolor[0];
-	core->avi_infoframe.quantization_range = HDMI_QUANTIZATION_RANGE_LIMITED;
 
 	hdmi_core_csc_config(core, csc_coeff);
-	hdmi_core_aux_infoframe_avi_config(core);
 }
 
 static void hdmi_core_enable_video_path(struct hdmi_core_data *core)
@@ -604,7 +605,6 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct omap_video_timings video_timing;
 	struct hdmi_video_format video_format;
 	struct hdmi_core_vid_config v_core_cfg;
-	struct hdmi_avi_infoframe *avi_infoframe = &core->avi_infoframe;
 
 	hdmi_core_mask_interrupts(core);
 
@@ -621,7 +621,9 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 
 	hdmi_wp_video_config_interface(wp, &video_timing);
 
+	/* support limited range with 24 bit color depth for now */
 	hdmi_core_configure_range(core);
+	cfg->infoframe.quantization_range = HDMI_QUANTIZATION_RANGE_LIMITED;
 
 	/*
 	 * configure core video part, set software reset in the core
@@ -634,24 +636,8 @@ void hdmi5_configure(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	hdmi_core_config_csc(core);
 	hdmi_core_config_video_sampler(core);
 
-	/*
-	 * configure packet info frame video see doc CEA861-D page 65
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
+	if (cfg->hdmi_dvi_mode == HDMI_HDMI)
+		hdmi_core_write_avi_infoframe(core, &cfg->infoframe);
 
 	hdmi_core_enable_video_path(core);
 
-- 
1.9.1

