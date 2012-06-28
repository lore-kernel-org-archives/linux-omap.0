From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 3/4] OMAPDSS: Add LCD3 overlay manager and Clock and IRQ support
Date: Thu, 28 Jun 2012 15:11:29 +0530
Message-ID: <68b956780a0fb7dcf64e162996d34e291374a23b.1340874806.git.cmahapatra@ti.com>
References: <cover.1340874806.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46119 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab2F1Jlg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:41:36 -0400
In-Reply-To: <cover.1340874806.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The support feature for LCD3 manager has been added into the DSS features
structure. LCD3 panel has registers as DISPC_CONTROL3 and DISPC_CONFIG3 just
like those in LCD and LCD2 panels. These registers control the Display
Controller (DISPC) module for LCD3 output. The three LCDs support Display Serial
Interface (DSI), Remote Frame Buffer Interface (RFBI) and Parallel CMOS Output
Interface (DPI). These LCDs can be connected through parallel output interface
using DISPC and RFBI or DPI. For serial interface DSS uses DSI.

The LCD3 panel, just like LCD and LCD2 panels, has a clock switch in DSS_CTRL
register which has been enabled. The clock switch chooses between DSS_CLK and
DPLL_DSI1_C_CLK1 as source for LCD3_CLK. New IRQs as DISPC_IRQ_VSYNC3,
DISPC_IRQ_FRAMEDONE3, DISPC_IRQ_ACBIAS_COUNT_STAT3 and DISPC_IRQ_SYNC_LOST3 have
been added specific to the new manager.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   48 ++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dispc.h        |    2 +
 drivers/video/omap2/dss/dss.c          |   12 +++++--
 drivers/video/omap2/dss/dss_features.h |    5 ++-
 drivers/video/omap2/dss/manager.c      |    4 ++
 drivers/video/omap2/dss/overlay.c      |   14 ++++++++-
 include/video/omapdss.h                |    5 +++
 7 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6c16b81..644ff53 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -191,6 +191,23 @@ static const struct {
 			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG2,  16, 16 },
 		},
 	},
+	[OMAP_DSS_CHANNEL_LCD3] = {
+		.name		= "LCD3",
+		.vsync_irq	= DISPC_IRQ_VSYNC3,
+		.framedone_irq	= DISPC_IRQ_FRAMEDONE3,
+		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST3,
+		.reg_desc	= {
+			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL3,  0,  0 },
+			[DISPC_MGR_FLD_STNTFT]		= { DISPC_CONTROL3,  3,  3 },
+			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL3,  5,  5 },
+			[DISPC_MGR_FLD_TFTDATALINES]	= { DISPC_CONTROL3,  9,  8 },
+			[DISPC_MGR_FLD_STALLMODE]	= { DISPC_CONTROL3, 11, 11 },
+			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG3,  10, 10 },
+			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG3,  11, 11 },
+			[DISPC_MGR_FLD_CPR]		= { DISPC_CONFIG3,  15, 15 },
+			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG3,  16, 16 },
+		},
+	},
 };
 
 static void _omap_dispc_set_irqs(void);
@@ -240,6 +257,10 @@ static void dispc_save_context(void)
 		SR(CONTROL2);
 		SR(CONFIG2);
 	}
+	if (dss_has_feature(FEAT_MGR_LCD3)) {
+		SR(CONTROL3);
+		SR(CONFIG3);
+	}
 
 	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
 		SR(DEFAULT_COLOR(i));
@@ -353,6 +374,8 @@ static void dispc_restore_context(void)
 		RR(GLOBAL_ALPHA);
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		RR(CONFIG2);
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		RR(CONFIG3);
 
 	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
 		RR(DEFAULT_COLOR(i));
@@ -438,6 +461,8 @@ static void dispc_restore_context(void)
 	RR(CONTROL);
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		RR(CONTROL2);
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		RR(CONTROL3);
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 
@@ -477,7 +502,8 @@ void dispc_runtime_put(void)
 static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 {
 	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
+			channel == OMAP_DSS_CHANNEL_LCD2 ||
+			channel == OMAP_DSS_CHANNEL_LCD3)
 		return true;
 	else
 		return false;
@@ -868,6 +894,15 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 			chan = 0;
 			chan2 = 1;
 			break;
+		case OMAP_DSS_CHANNEL_LCD3:
+			if (dss_has_feature(FEAT_MGR_LCD3)) {
+				chan = 0;
+				chan2 = 2;
+			} else {
+				BUG();
+				return;
+			}
+			break;
 		default:
 			BUG();
 			return;
@@ -903,7 +938,14 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 
 	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
+	if (dss_has_feature(FEAT_MGR_LCD3)) {
+		if (FLD_GET(val, 31, 30) == 0)
+			channel = FLD_GET(val, shift, shift);
+		else if (FLD_GET(val, 31, 30) == 1)
+			channel = OMAP_DSS_CHANNEL_LCD2;
+		else
+			channel = OMAP_DSS_CHANNEL_LCD3;
+	} else if (dss_has_feature(FEAT_MGR_LCD2)) {
 		if (FLD_GET(val, 31, 30) == 0)
 			channel = FLD_GET(val, shift, shift);
 		else
@@ -3588,6 +3630,8 @@ static void _omap_dispc_initialize_irq(void)
 	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST3;
 	if (dss_feat_get_num_ovls() > 3)
 		dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
 
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 420c980..92d8a9b 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -36,6 +36,8 @@
 #define DISPC_CONTROL2			0x0238
 #define DISPC_CONFIG2			0x0620
 #define DISPC_DIVISOR			0x0804
+#define DISPC_CONTROL3                  0x0848
+#define DISPC_CONFIG3                   0x084C
 
 /* DISPC overlay registers */
 #define DISPC_OVL_BA0(n)		(DISPC_OVL_BASE(n) + \
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7706323..4c351e5 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -388,7 +388,8 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
-		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD2);
+		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD2 &&
+		       channel != OMAP_DSS_CHANNEL_LCD3);
 		b = 1;
 		dsidev = dsi_get_dsidev_from_id(1);
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
@@ -398,10 +399,12 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		return;
 	}
 
-	pos = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 12;
+	pos = channel == OMAP_DSS_CHANNEL_LCD ? 0 :
+	     (channel == OMAP_DSS_CHANNEL_LCD2 ? 12 : 19);
 	REG_FLD_MOD(DSS_CONTROL, b, pos, pos);	/* LCDx_CLK_SWITCH */
 
-	ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
+	ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 :
+	    (channel == OMAP_DSS_CHANNEL_LCD2 ? 1 : 2);
 	dss.lcd_clk_source[ix] = clk_src;
 }
 
@@ -418,7 +421,8 @@ enum omap_dss_clk_source dss_get_dsi_clk_source(int dsi_module)
 enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 {
 	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
-		int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
+		int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 :
+			(channel == OMAP_DSS_CHANNEL_LCD2 ? 1 : 2);
 		return dss.lcd_clk_source[ix];
 	} else {
 		/* LCD_CLK source is the same as DISPC_FCLK source for
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index bdf469f..996ffcb 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -24,9 +24,9 @@
 #include "ti_hdmi.h"
 #endif
 
-#define MAX_DSS_MANAGERS	3
+#define MAX_DSS_MANAGERS	4
 #define MAX_DSS_OVERLAYS	4
-#define MAX_DSS_LCD_MANAGERS	2
+#define MAX_DSS_LCD_MANAGERS	3
 #define MAX_NUM_DSI		2
 
 /* DSS has feature id */
@@ -36,6 +36,7 @@ enum dss_feat_id {
 	FEAT_PCKFREEENABLE,
 	FEAT_FUNCGATED,
 	FEAT_MGR_LCD2,
+	FEAT_MGR_LCD3,
 	FEAT_LINEBUFFERSPLIT,
 	FEAT_ROWREPEATENABLE,
 	FEAT_RESIZECONF,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index bb602a2..a51eb06 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -541,6 +541,10 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			mgr->name = "lcd2";
 			mgr->id = OMAP_DSS_CHANNEL_LCD2;
 			break;
+		case 3:
+			mgr->name = "lcd3";
+			mgr->id = OMAP_DSS_CHANNEL_LCD3;
+			break;
 		}
 
 		mgr->set_device = &dss_mgr_set_device;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index b0ba60f..898ceed 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -528,14 +528,24 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	struct omap_overlay_manager *lcd_mgr;
 	struct omap_overlay_manager *tv_mgr;
 	struct omap_overlay_manager *lcd2_mgr = NULL;
+	struct omap_overlay_manager *lcd3_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
 
 	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD);
 	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_TV);
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD2);
-
-	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		lcd3_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD3);
+
+	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD3) {
+		if (!lcd3_mgr->device || force) {
+			if (lcd3_mgr->device)
+				lcd3_mgr->unset_device(lcd3_mgr);
+			lcd3_mgr->set_device(lcd3_mgr, dssdev);
+			mgr = lcd3_mgr;
+		}
+	} else if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
 		if (!lcd2_mgr->device || force) {
 			if (lcd2_mgr->device)
 				lcd2_mgr->unset_device(lcd2_mgr);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cf4f716..2f9fff4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -48,6 +48,10 @@
 #define DISPC_IRQ_FRAMEDONEWB		(1 << 23)
 #define DISPC_IRQ_FRAMEDONETV		(1 << 24)
 #define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
+#define DISPC_IRQ_FRAMEDONE3		(1 << 26)
+#define DISPC_IRQ_VSYNC3		(1 << 27)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 28)
+#define DISPC_IRQ_SYNC_LOST3		(1 << 29)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
@@ -173,6 +177,7 @@ enum omap_dss_overlay_managers {
 	OMAP_DSS_OVL_MGR_LCD,
 	OMAP_DSS_OVL_MGR_TV,
 	OMAP_DSS_OVL_MGR_LCD2,
+	OMAP_DSS_OVL_MGR_LCD3,
 };
 
 enum omap_dss_rotation_type {
-- 
1.7.1

