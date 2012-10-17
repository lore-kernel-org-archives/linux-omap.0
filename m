From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/9] OMAPDSS: combine LCD related config into one func
Date: Wed, 17 Oct 2012 14:20:30 +0300
Message-ID: <1350472835-28727-5-git-send-email-tomi.valkeinen@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46650 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539Ab2JQLUq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 07:20:46 -0400
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Dispc has a bunch of functions used to configure output related
parameters:

- dispc_mgr_set_io_pad_mode
- dispc_mgr_enable_stallmode
- dispc_mgr_enable_fifohandcheck
- dispc_mgr_set_clock_div
- dispc_mgr_set_tft_data_lines
- dispc_lcd_enable_signal_polarity
- dispc_mgr_set_lcd_type_tft

These are all called together, and the configuration values are taken
from struct dss_lcd_mgr_config.

Instead of exposing those individual dispc functions, create a new one,
dispc_mgr_set_lcd_config(), which is used to configure the above
parameters from values in struct dss_lcd_mgr_config.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   18 ++----------------
 drivers/video/omap2/dss/dispc.c |   29 +++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h   |    8 ++------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 29ce5a8..ae9f70d 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -666,22 +666,8 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 	dispc_mgr_set_timings(mgr->id, &mp->timings);
 
 	/* lcd_config parameters */
-	if (dss_mgr_is_lcd(mgr->id)) {
-		dispc_mgr_set_io_pad_mode(mp->lcd_config.io_pad_mode);
-
-		dispc_mgr_enable_stallmode(mgr->id, mp->lcd_config.stallmode);
-		dispc_mgr_enable_fifohandcheck(mgr->id,
-			mp->lcd_config.fifohandcheck);
-
-		dispc_mgr_set_clock_div(mgr->id, &mp->lcd_config.clock_info);
-
-		dispc_mgr_set_tft_data_lines(mgr->id,
-			mp->lcd_config.video_port_width);
-
-		dispc_lcd_enable_signal_polarity(mp->lcd_config.lcden_sig_polarity);
-
-		dispc_mgr_set_lcd_type_tft(mgr->id);
-	}
+	if (dss_mgr_is_lcd(mgr->id))
+		dispc_mgr_set_lcd_config(mgr->id, &mp->lcd_config);
 
 	mp->extra_info_dirty = false;
 	if (mp->updating)
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4dfc90a..d3c58eb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2769,7 +2769,7 @@ bool dispc_wb_is_enabled(void)
 	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
 }
 
-void dispc_lcd_enable_signal_polarity(bool act_high)
+static void dispc_lcd_enable_signal_polarity(bool act_high)
 {
 	if (!dss_has_feature(FEAT_LCDENABLEPOL))
 		return;
@@ -2793,13 +2793,13 @@ void dispc_pck_free_enable(bool enable)
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
 }
 
-void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable)
+static void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_FIFOHANDCHECK, enable);
 }
 
 
-void dispc_mgr_set_lcd_type_tft(enum omap_channel channel)
+static void dispc_mgr_set_lcd_type_tft(enum omap_channel channel)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_STNTFT, 1);
 }
@@ -2855,7 +2855,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 	}
 }
 
-void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
+static void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
 	int code;
 
@@ -2880,7 +2880,7 @@ void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 	mgr_fld_write(channel, DISPC_MGR_FLD_TFTDATALINES, code);
 }
 
-void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
+static void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
 {
 	u32 l;
 	int gpout0, gpout1;
@@ -2909,11 +2909,28 @@ void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
 	dispc_write_reg(DISPC_CONTROL, l);
 }
 
-void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable)
+static void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_STALLMODE, enable);
 }
 
+void dispc_mgr_set_lcd_config(enum omap_channel channel,
+		const struct dss_lcd_mgr_config *config)
+{
+	dispc_mgr_set_io_pad_mode(config->io_pad_mode);
+
+	dispc_mgr_enable_stallmode(channel, config->stallmode);
+	dispc_mgr_enable_fifohandcheck(channel, config->fifohandcheck);
+
+	dispc_mgr_set_clock_div(channel, &config->clock_info);
+
+	dispc_mgr_set_tft_data_lines(channel, config->video_port_width);
+
+	dispc_lcd_enable_signal_polarity(config->lcden_sig_polarity);
+
+	dispc_mgr_set_lcd_type_tft(channel);
+}
+
 static bool _dispc_mgr_size_ok(u16 width, u16 height)
 {
 	return width <= dss_feat_get_param_max(FEAT_PARAM_MGR_WIDTH) &&
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index eaf0856..8447871 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -435,7 +435,6 @@ void dispc_runtime_put(void);
 void dispc_enable_sidle(void);
 void dispc_disable_sidle(void);
 
-void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
 void dispc_enable_fifomerge(bool enable);
@@ -462,7 +461,6 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
 
-void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
@@ -470,10 +468,8 @@ void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
-void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode);
-void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
-void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
-void dispc_mgr_set_lcd_type_tft(enum omap_channel channel);
+void dispc_mgr_set_lcd_config(enum omap_channel channel,
+		const struct dss_lcd_mgr_config *config);
 void dispc_mgr_set_timings(enum omap_channel channel,
 		const struct omap_video_timings *timings);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
-- 
1.7.9.5

