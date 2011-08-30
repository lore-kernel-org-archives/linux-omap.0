From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/10] OMAP: DSS2: DSI: Represent L4 and VP as sources of VC instead of modes
Date: Tue, 30 Aug 2011 16:21:27 +0530
Message-ID: <1314701495-11247-3-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1H3KxO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:14 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArDiL000540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UArDdJ021069
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:13 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArDGX025061
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:13 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The enum type dsi_vc_mode is a bit misleading as L4 slave port and video port
are sources to VC rather than the mode of operation. Rename then enum type and
its members. Merge dsi_vc_config_vp() and dsi_vc_config_l4() into a single
function called dsi_vc_config_source() which takes dsi_vc_source enum as an
extra argument.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   72 ++++++++++++-----------------------------
 1 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6735e0c..bdc2c9d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -217,9 +217,9 @@ enum fifo_size {
 	DSI_FIFO_SIZE_128	= 4,
 };
 
-enum dsi_vc_mode {
-	DSI_VC_MODE_L4 = 0,
-	DSI_VC_MODE_VP,
+enum dsi_vc_source {
+	DSI_VC_SOURCE_L4 = 0,
+	DSI_VC_SOURCE_VP,
 };
 
 enum dsi_lane {
@@ -272,7 +272,7 @@ struct dsi_data {
 	struct regulator *vdds_dsi_reg;
 
 	struct {
-		enum dsi_vc_mode mode;
+		enum dsi_vc_source source;
 		struct omap_dss_device *dssdev;
 		enum fifo_size fifo_size;
 		int vc_id;
@@ -2672,10 +2672,10 @@ static int dsi_sync_vc(struct platform_device *dsidev, int channel)
 	if (!dsi_vc_is_enabled(dsidev, channel))
 		return 0;
 
-	switch (dsi->vc[channel].mode) {
-	case DSI_VC_MODE_VP:
+	switch (dsi->vc[channel].source) {
+	case DSI_VC_SOURCE_VP:
 		return dsi_sync_vc_vp(dsidev, channel);
-	case DSI_VC_MODE_L4:
+	case DSI_VC_SOURCE_L4:
 		return dsi_sync_vc_l4(dsidev, channel);
 	default:
 		BUG();
@@ -2729,43 +2729,12 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 	dsi_write_reg(dsidev, DSI_VC_CTRL(channel), r);
 }
 
-static int dsi_vc_config_l4(struct platform_device *dsidev, int channel)
+static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
+		enum dsi_vc_source source)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	if (dsi->vc[channel].mode == DSI_VC_MODE_L4)
-		return 0;
-
-	DSSDBGF("%d", channel);
-
-	dsi_sync_vc(dsidev, channel);
-
-	dsi_vc_enable(dsidev, channel, 0);
-
-	/* VC_BUSY */
-	if (wait_for_bit_change(dsidev, DSI_VC_CTRL(channel), 15, 0) != 0) {
-		DSSERR("vc(%d) busy when trying to config for L4\n", channel);
-		return -EIO;
-	}
-
-	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 1, 1); /* SOURCE, 0 = L4 */
-
-	/* DCS_CMD_ENABLE */
-	if (dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC))
-		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 30, 30);
-
-	dsi_vc_enable(dsidev, channel, 1);
-
-	dsi->vc[channel].mode = DSI_VC_MODE_L4;
-
-	return 0;
-}
-
-static int dsi_vc_config_vp(struct platform_device *dsidev, int channel)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	if (dsi->vc[channel].mode == DSI_VC_MODE_VP)
+	if (dsi->vc[channel].source == source)
 		return 0;
 
 	DSSDBGF("%d", channel);
@@ -2780,21 +2749,22 @@ static int dsi_vc_config_vp(struct platform_device *dsidev, int channel)
 		return -EIO;
 	}
 
-	/* SOURCE, 1 = video port */
-	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 1, 1);
+	/* SOURCE, 0 = L4, 1 = video port */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), source, 1, 1);
 
 	/* DCS_CMD_ENABLE */
-	if (dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC))
-		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 30, 30);
+	if (dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC)) {
+		bool enable = source == DSI_VC_SOURCE_VP;
+		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), enable, 30, 30);
+	}
 
 	dsi_vc_enable(dsidev, channel, 1);
 
-	dsi->vc[channel].mode = DSI_VC_MODE_VP;
+	dsi->vc[channel].source = source;
 
 	return 0;
 }
 
-
 void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable)
 {
@@ -3010,7 +2980,7 @@ static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
 		return -EINVAL;
 	}
 
-	dsi_vc_config_l4(dsidev, channel);
+	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_L4);
 
 	dsi_vc_write_long_header(dsidev, channel, data_type, len, ecc);
 
@@ -3069,7 +3039,7 @@ static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
 				channel,
 				data_type, data & 0xff, (data >> 8) & 0xff);
 
-	dsi_vc_config_l4(dsidev, channel);
+	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_L4);
 
 	if (FLD_GET(dsi_read_reg(dsidev, DSI_VC_CTRL(channel)), 16, 16)) {
 		DSSERR("ERROR FIFO FULL, aborting transfer\n");
@@ -3657,7 +3627,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
 			x, y, w, h);
 
-	dsi_vc_config_vp(dsidev, channel);
+	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_VP);
 
 	bytespp	= dssdev->ctrl.pixel_size / 8;
 	bytespl = w * bytespp;
@@ -4383,7 +4353,7 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	/* DSI VCs initialization */
 	for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
-		dsi->vc[i].mode = DSI_VC_MODE_L4;
+		dsi->vc[i].source = DSI_VC_SOURCE_L4;
 		dsi->vc[i].dssdev = NULL;
 		dsi->vc[i].vc_id = 0;
 	}
-- 
1.7.1

