From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/17] OMAPDSS: Remove passive matrix LCD support (part 4)
Date: Tue, 26 Jun 2012 15:06:41 +0530
Message-ID: <1340703414-1915-6-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab2FZJib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:38:31 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove configuration of Ac-bias pins

Ac-bias pins need to be configured only for passive matrix displays. Remove
acbi and acb fields in omap_dss_device and their configuration in panel
drivers. Don't program these fields in DISP_POL_FREQo register any more.

The panel driver for sharp-ls037v7dw01, and the panel config for
Innolux AT070TN8 in generic dpi panel driver set acb to a non zero value. This
is most likely carried over from the old omapfb driver which supported passive
matrix displays.

Cc: Thomas Weber <weber@corscience.de> 
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |   23 --------------------
 drivers/video/omap2/displays/panel-picodlp.c       |    1 -
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 -
 drivers/video/omap2/dss/dispc.c                    |   14 +++++-------
 drivers/video/omap2/dss/dpi.c                      |    3 +--
 drivers/video/omap2/dss/dss.h                      |    2 +-
 drivers/video/omap2/dss/sdi.c                      |    3 +--
 7 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 3e47490..fe7e48c 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -40,10 +40,6 @@
 struct panel_config {
 	struct omap_video_timings timings;
 
-	int acbi;	/* ac-bias pin transitions per interrupt */
-	/* Unit: line clocks */
-	int acb;	/* ac-bias pin frequency */
-
 	enum omap_panel_config config;
 
 	int power_on_delay;
@@ -74,8 +70,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 3,
 			.vbp		= 2,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 50,
@@ -99,8 +93,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 1,
 			.vbp		= 1,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x28,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 50,
 		.power_off_delay	= 100,
@@ -123,8 +115,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 2,
 			.vbp		= 2,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC |
 						OMAP_DSS_LCD_ONOFF,
@@ -149,8 +139,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 10,
 			.vbp		= 12 - 10,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
@@ -173,8 +161,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 4,
 			.vbp		= 11,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
@@ -197,8 +183,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 2,
 			.vbp		= 2,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 0,
@@ -222,8 +206,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 12,
 			.vbp		= 25,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x28,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
@@ -325,8 +307,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 1,
 			.vbp		= 1,
 		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC,
 		.power_on_delay		= 0,
@@ -369,7 +349,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 12,
 			.vbp		= 23,
 		},
-		.acb			= 0x0,
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
 
@@ -562,8 +541,6 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.config = panel_config->config;
 	dssdev->panel.timings = panel_config->timings;
-	dssdev->panel.acb = panel_config->acb;
-	dssdev->panel.acbi = panel_config->acbi;
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 44627f9..91e44c6 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -416,7 +416,6 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.config = OMAP_DSS_LCD_ONOFF | OMAP_DSS_LCD_IHS |
 				OMAP_DSS_LCD_IVS;
-	dssdev->panel.acb = 0x0;
 	dssdev->panel.timings = pico_ls_timings;
 
 	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 98a0ff5..8070b88 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -87,7 +87,6 @@ static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 	int r;
 
 	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
-	dssdev->panel.acb = 0x28;
 	dssdev->panel.timings = sharp_ls_timings;
 
 	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 01c81a7..d974be9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3077,13 +3077,12 @@ static void dispc_dump_regs(struct seq_file *s)
 }
 
 static void _dispc_mgr_set_pol_freq(enum omap_channel channel, bool onoff,
-		bool rf, bool ieo, bool ipc, bool ihs, bool ivs, u8 acbi,
-		u8 acb)
+		bool rf, bool ieo, bool ipc, bool ihs, bool ivs)
 {
 	u32 l = 0;
 
-	DSSDBG("onoff %d rf %d ieo %d ipc %d ihs %d ivs %d acbi %d acb %d\n",
-			onoff, rf, ieo, ipc, ihs, ivs, acbi, acb);
+	DSSDBG("onoff %d rf %d ieo %d ipc %d ihs %d ivs %d\n",
+			onoff, rf, ieo, ipc, ihs, ivs);
 
 	l |= FLD_VAL(onoff, 17, 17);
 	l |= FLD_VAL(rf, 16, 16);
@@ -3091,22 +3090,19 @@ static void _dispc_mgr_set_pol_freq(enum omap_channel channel, bool onoff,
 	l |= FLD_VAL(ipc, 14, 14);
 	l |= FLD_VAL(ihs, 13, 13);
 	l |= FLD_VAL(ivs, 12, 12);
-	l |= FLD_VAL(acbi, 11, 8);
-	l |= FLD_VAL(acb, 7, 0);
 
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 }
 
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
-		enum omap_panel_config config, u8 acbi, u8 acb)
+		enum omap_panel_config config)
 {
 	_dispc_mgr_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
 			(config & OMAP_DSS_LCD_RF) != 0,
 			(config & OMAP_DSS_LCD_IEO) != 0,
 			(config & OMAP_DSS_LCD_IPC) != 0,
 			(config & OMAP_DSS_LCD_IHS) != 0,
-			(config & OMAP_DSS_LCD_IVS) != 0,
-			acbi, acb);
+			(config & OMAP_DSS_LCD_IVS) != 0);
 }
 
 /* with fck as input clock rate, find dispc dividers that produce req_pck */
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 018be20..d8cc440 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -148,8 +148,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r = 0;
 
-	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
-			dssdev->panel.acbi, dssdev->panel.acb);
+	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config);
 
 	if (dpi_use_dsi_pll(dssdev))
 		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ffbff49..d64f894 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -415,7 +415,7 @@ void dispc_mgr_set_lcd_type_tft(enum omap_channel channel);
 void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
-		enum omap_panel_config config, u8 acbi, u8 acb);
+		enum omap_panel_config config);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 unsigned long dispc_core_clk_rate(void);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 1a369de..5268fdb 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -80,8 +80,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 
-	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
-			dssdev->panel.acbi, dssdev->panel.acb);
+	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config);
 
 	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
 	if (r)
-- 
1.7.9.5

