From: Archit Taneja <archit@ti.com>
Subject: [PATCH 08/17] OMAPDSS: DISPC: Remove dispc_mgr_set_pol_freq()
Date: Tue, 26 Jun 2012 15:06:45 +0530
Message-ID: <1340703414-1915-10-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43405 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2FZJi4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:56 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_mgr_set_pol_freq() configures the fields in the register DISPC_POL_FREQo.
All these fields have been moved to omap_video_timings struct, and are now
programmed in dispc_mgr_set_lcd_timings(). These will be configured when timings
are applied via dss_mgr_set_timings().

Remove dispc_mgr_set_pol_freq() and it's calls from the interface drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   29 -----------------------------
 drivers/video/omap2/dss/dpi.c   |    2 --
 drivers/video/omap2/dss/dss.h   |    2 --
 drivers/video/omap2/dss/sdi.c   |    2 --
 4 files changed, 35 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 184d37b..9b22563 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3113,35 +3113,6 @@ static void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_mgr_set_pol_freq(enum omap_channel channel, bool onoff,
-		bool rf, bool ieo, bool ipc, bool ihs, bool ivs)
-{
-	u32 l = 0;
-
-	DSSDBG("onoff %d rf %d ieo %d ipc %d ihs %d ivs %d\n",
-			onoff, rf, ieo, ipc, ihs, ivs);
-
-	l |= FLD_VAL(onoff, 17, 17);
-	l |= FLD_VAL(rf, 16, 16);
-	l |= FLD_VAL(ieo, 15, 15);
-	l |= FLD_VAL(ipc, 14, 14);
-	l |= FLD_VAL(ihs, 13, 13);
-	l |= FLD_VAL(ivs, 12, 12);
-
-	dispc_write_reg(DISPC_POL_FREQ(channel), l);
-}
-
-void dispc_mgr_set_pol_freq(enum omap_channel channel,
-		enum omap_panel_config config)
-{
-	_dispc_mgr_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
-			(config & OMAP_DSS_LCD_RF) != 0,
-			(config & OMAP_DSS_LCD_IEO) != 0,
-			(config & OMAP_DSS_LCD_IPC) != 0,
-			(config & OMAP_DSS_LCD_IHS) != 0,
-			(config & OMAP_DSS_LCD_IVS) != 0);
-}
-
 /* with fck as input clock rate, find dispc dividers that produce req_pck */
 void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index d8cc440..046a6fb 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -148,8 +148,6 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r = 0;
 
-	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config);
-
 	if (dpi_use_dsi_pll(dssdev))
 		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d64f894..3d23a23 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -414,8 +414,6 @@ void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_type_tft(enum omap_channel channel);
 void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
-void dispc_mgr_set_pol_freq(enum omap_channel channel,
-		enum omap_panel_config config);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 unsigned long dispc_core_clk_rate(void);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 9330410..264efd5 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -82,8 +82,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	dssdev->panel.timings.hsync_vsync_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 
-	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config);
-
 	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
 	if (r)
 		goto err_calc_clock_div;
-- 
1.7.9.5

