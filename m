From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 3/7] OMAP: DSS2: Introduce omap_channel as a omap_dss_device parameter
Date: Mon,  8 Nov 2010 17:54:21 +0530
Message-ID: <1289219065-1362-4-git-send-email-archit@ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37572 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab0KHMXq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:23:46 -0500
In-Reply-To: <1289219065-1362-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

A new member 'channel' is introduced in omap_dss_device structure to determine
which channel the panel uses. The dispc functions used by interface drivers
(dsi, sdi etc) will use this member to differentiate between the 2 channels.

The following dispc functions are changed to incorporate channel as an argument:
	-dispc_enable_fifohandcheck()
	-dispc_set_lcd_size()
	-dispc_set_parallel_interface_mode()
	-dispc_set_tft_data_lines()
	-dispc_set_lcd_display_type()
	-dispc_set_lcd_timings()

The calls to these functions from the interface drivers have been changed to
incorporate the new channel argument.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/dispc.c           |   49 ++++++++++++++++-------------
 drivers/video/omap2/dss/dpi.c             |   11 +++---
 drivers/video/omap2/dss/dsi.c             |   13 ++++---
 drivers/video/omap2/dss/dss.h             |   19 ++++++-----
 drivers/video/omap2/dss/rfbi.c            |   19 ++++++-----
 drivers/video/omap2/dss/sdi.c             |   14 +++++---
 7 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 586944d..3e6eec1 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -434,6 +434,7 @@ struct omap_dss_device {
 	struct omap_overlay_manager *manager;
 
 	enum omap_dss_display_state state;
+	enum omap_channel channel;
 
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 493e0f9..2ea1a7a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -939,13 +939,13 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
 	enable_clocks(0);
 }
 
-void dispc_set_lcd_size(u16 width, u16 height)
+void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 {
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_LCD(OMAP_DSS_CHANNEL_LCD), val);
+	dispc_write_reg(DISPC_SIZE_LCD(channel), val);
 	enable_clocks(0);
 }
 
@@ -1888,16 +1888,16 @@ void dispc_pck_free_enable(bool enable)
 	enable_clocks(0);
 }
 
-void dispc_enable_fifohandcheck(bool enable)
+void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD),
-		enable ? 1 : 0, 16, 16);
+	REG_FLD_MOD(DISPC_CONFIG(channel), enable ? 1 : 0, 16, 16);
 	enable_clocks(0);
 }
 
 
-void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
+void dispc_set_lcd_display_type(enum omap_channel channel,
+		enum omap_lcd_display_type type)
 {
 	int mode;
 
@@ -1916,7 +1916,7 @@ void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), mode, 3, 3);
+	REG_FLD_MOD(DISPC_CONTROL(channel), mode, 3, 3);
 	enable_clocks(0);
 }
 
@@ -2040,7 +2040,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 }
 
 
-void dispc_set_tft_data_lines(u8 data_lines)
+void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
 	int code;
 
@@ -2063,11 +2063,12 @@ void dispc_set_tft_data_lines(u8 data_lines)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), code, 9, 8);
+	REG_FLD_MOD(DISPC_CONTROL(channel), code, 9, 8);
 	enable_clocks(0);
 }
 
-void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
+void dispc_set_parallel_interface_mode(enum omap_channel channel,
+		enum omap_parallel_interface_mode mode)
 {
 	u32 l;
 	int stallmode;
@@ -2097,13 +2098,15 @@ void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
 
 	enable_clocks(1);
 
-	l = dispc_read_reg(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD));
+	l = dispc_read_reg(DISPC_CONTROL(channel));
 
 	l = FLD_MOD(l, stallmode, 11, 11);
-	l = FLD_MOD(l, gpout0, 15, 15);
-	l = FLD_MOD(l, gpout1, 16, 16);
 
-	dispc_write_reg(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), l);
+	if (channel == OMAP_DSS_CHANNEL_LCD) {
+		l = FLD_MOD(l, gpout0, 15, 15);
+		l = FLD_MOD(l, gpout1, 16, 16);
+	}
+	dispc_write_reg(DISPC_CONTROL(channel), l);
 
 	enable_clocks(0);
 }
@@ -2139,8 +2142,8 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
 			timings->vfp, timings->vbp);
 }
 
-static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
-				   int vsw, int vfp, int vbp)
+static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
+		int hfp, int hbp, int vsw, int vfp, int vbp)
 {
 	u32 timing_h, timing_v;
 
@@ -2159,13 +2162,14 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
 	}
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_TIMING_H(OMAP_DSS_CHANNEL_LCD), timing_h);
-	dispc_write_reg(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD), timing_v);
+	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
 	enable_clocks(0);
 }
 
 /* change name to mode? */
-void dispc_set_lcd_timings(struct omap_video_timings *timings)
+void dispc_set_lcd_timings(enum omap_channel channel,
+		struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
@@ -2175,10 +2179,11 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 				timings->vfp, timings->vbp))
 		BUG();
 
-	_dispc_set_lcd_timings(timings->hsw, timings->hfp, timings->hbp,
-			timings->vsw, timings->vfp, timings->vbp);
+	_dispc_set_lcd_timings(channel, timings->hsw, timings->hfp,
+			timings->hbp, timings->vsw, timings->vfp,
+			timings->vbp);
 
-	dispc_set_lcd_size(timings->x_res, timings->y_res);
+	dispc_set_lcd_size(channel, timings->x_res, timings->y_res);
 
 	xtot = timings->x_res + timings->hfp + timings->hsw + timings->hbp;
 	ytot = timings->y_res + timings->vfp + timings->vsw + timings->vbp;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..51040dc 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -132,7 +132,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_set_lcd_timings(t);
+	dispc_set_lcd_timings(dssdev->channel, t);
 
 err0:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
@@ -145,10 +145,11 @@ static int dpi_basic_init(struct omap_dss_device *dssdev)
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_BYPASS);
-	dispc_set_lcd_display_type(is_tft ? OMAP_DSS_LCD_DISPLAY_TFT :
-			OMAP_DSS_LCD_DISPLAY_STN);
-	dispc_set_tft_data_lines(dssdev->phy.dpi.data_lines);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+			OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_set_lcd_display_type(dssdev->channel, is_tft ?
+			OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
+	dispc_set_tft_data_lines(dssdev->channel, dssdev->phy.dpi.data_lines);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index aa4f7a5..a4c031e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2888,7 +2888,7 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dss_setup_partial_planes(dssdev, x, y, w, h,
 				enlarge_update_area);
-		dispc_set_lcd_size(*w, *h);
+		dispc_set_lcd_size(dssdev->channel, *w, *h);
 	}
 
 	return 0;
@@ -2947,12 +2947,13 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_lcd_display_type(dssdev->channel, OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_DSI);
-	dispc_enable_fifohandcheck(1);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+			OMAP_DSS_PARALLELMODE_DSI);
+	dispc_enable_fifohandcheck(dssdev->channel, 1);
 
-	dispc_set_tft_data_lines(dssdev->ctrl.pixel_size);
+	dispc_set_tft_data_lines(dssdev->channel, dssdev->ctrl.pixel_size);
 
 	{
 		struct omap_video_timings timings = {
@@ -2964,7 +2965,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			.vbp		= 0,
 		};
 
-		dispc_set_lcd_timings(&timings);
+		dispc_set_lcd_timings(dssdev->channel, &timings);
 	}
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 2bb515c..68f7c42 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -333,9 +333,9 @@ void dispc_disable_sidle(void);
 void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
-void dispc_enable_fifohandcheck(bool enable);
+void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable);
 
-void dispc_set_lcd_size(u16 width, u16 height);
+void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
 u32 dispc_get_plane_fifo_size(enum omap_plane plane);
 void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
@@ -369,9 +369,11 @@ bool dispc_is_channel_enabled(enum omap_channel channel);
 int dispc_enable_plane(enum omap_plane plane, bool enable);
 void dispc_enable_replication(enum omap_plane plane, bool enable);
 
-void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode);
-void dispc_set_tft_data_lines(u8 data_lines);
-void dispc_set_lcd_display_type(enum omap_lcd_display_type type);
+void dispc_set_parallel_interface_mode(enum omap_channel channel,
+		enum omap_parallel_interface_mode mode);
+void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
+void dispc_set_lcd_display_type(enum omap_channel channel,
+		enum omap_lcd_display_type type);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
 void dispc_set_default_color(enum omap_channel channel, u32 color);
@@ -388,7 +390,8 @@ bool dispc_trans_key_enabled(enum omap_channel ch);
 bool dispc_alpha_blending_enabled(enum omap_channel ch);
 
 bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
-void dispc_set_lcd_timings(struct omap_video_timings *timings);
+void dispc_set_lcd_timings(enum omap_channel channel,
+		struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
 unsigned long dispc_lclk_rate(void);
 unsigned long dispc_pclk_rate(void);
@@ -425,8 +428,8 @@ void rfbi_dump_regs(struct seq_file *s);
 
 int rfbi_configure(int rfbi_module, int bpp, int lines);
 void rfbi_enable_rfbi(bool enable);
-void rfbi_transfer_area(u16 width, u16 height,
-			     void (callback)(void *data), void *data);
+void rfbi_transfer_area(enum omap_channel channel, u16 width,
+		u16 height, void (callback)(void *data), void *data);
 void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index bbe6246..08cf3c6 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -301,8 +301,8 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-void rfbi_transfer_area(u16 width, u16 height,
-			     void (callback)(void *data), void *data)
+void rfbi_transfer_area(enum omap_channel channel, u16 width,
+		u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
 
@@ -311,9 +311,9 @@ void rfbi_transfer_area(u16 width, u16 height,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_set_lcd_size(width, height);
+	dispc_set_lcd_size(channel, width, height);
 
-	dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, true);
+	dispc_enable_channel(channel, true);
 
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
@@ -887,7 +887,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dss_setup_partial_planes(dssdev, x, y, w, h, true);
-		dispc_set_lcd_size(*w, *h);
+		dispc_set_lcd_size(dssdev->channel, *w, *h);
 	}
 
 	return 0;
@@ -899,7 +899,7 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 		void (*callback)(void *), void *data)
 {
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		rfbi_transfer_area(w, h, callback, data);
+		rfbi_transfer_area(dssdev->channel, w, h, callback, data);
 	} else {
 		struct omap_overlay *ovl;
 		void __iomem *addr;
@@ -1018,11 +1018,12 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_lcd_display_type(dssdev->channel, OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_RFBI);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+			OMAP_DSS_PARALLELMODE_RFBI);
 
-	dispc_set_tft_data_lines(dssdev->ctrl.pixel_size);
+	dispc_set_tft_data_lines(dssdev->channel, dssdev->ctrl.pixel_size);
 
 	rfbi_configure(dssdev->phy.rfbi.channel,
 			       dssdev->ctrl.pixel_size,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ee07a3c..a011be6 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -35,12 +35,14 @@ static struct {
 	struct regulator *vdds_sdi_reg;
 } sdi;
 
-static void sdi_basic_init(void)
+static void sdi_basic_init(enum omap_channel channel)
+
 {
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_set_parallel_interface_mode(channel,
+			OMAP_DSS_PARALLELMODE_BYPASS);
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
-	dispc_set_tft_data_lines(24);
+	dispc_set_lcd_display_type(channel, OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_tft_data_lines(channel, 24);
 	dispc_lcd_enable_signal_polarity(1);
 }
 
@@ -68,7 +70,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (!sdi.skip_init)
 		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	sdi_basic_init();
+	sdi_basic_init(dssdev->channel);
 
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
@@ -102,7 +104,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_set_lcd_timings(t);
+	dispc_set_lcd_timings(dssdev->channel, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
-- 
1.7.0.4

