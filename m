From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/13] OMAPDSS: DSI: use lane config in dsi_cio_wait_tx_clk_esc_reset
Date: Thu, 24 Nov 2011 15:29:36 +0200
Message-ID: <1322141381-5395-9-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33343 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756083Ab1KXNaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:12 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new lane config in dsi_cio_wait_tx_clk_esc_reset(). This also
extends the function to support 5 lanes on OMAP4, instead of 3 lanes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   47 +++++++++++++++-------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1a209a2..52cf97f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2365,51 +2365,40 @@ static void dsi_cio_disable_lane_override(struct platform_device *dsidev)
 static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	int t;
-	int bits[3];
-	bool in_use[3];
-
-	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
-		bits[0] = 28;
-		bits[1] = 27;
-		bits[2] = 26;
-	} else {
-		bits[0] = 24;
-		bits[1] = 25;
-		bits[2] = 26;
-	}
-
-	in_use[0] = false;
-	in_use[1] = false;
-	in_use[2] = false;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int t, i;
+	bool in_use[DSI_MAX_NR_LANES];
+	static const u8 offsets_old[] = { 28, 27, 26 };
+	static const u8 offsets_new[] = { 24, 25, 26, 27, 28 };
+	const u8 *offsets;
+
+	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC))
+		offsets = offsets_old;
+	else
+		offsets = offsets_new;
 
-	if (dssdev->phy.dsi.clk_lane != 0)
-		in_use[dssdev->phy.dsi.clk_lane - 1] = true;
-	if (dssdev->phy.dsi.data1_lane != 0)
-		in_use[dssdev->phy.dsi.data1_lane - 1] = true;
-	if (dssdev->phy.dsi.data2_lane != 0)
-		in_use[dssdev->phy.dsi.data2_lane - 1] = true;
+	for (i = 0; i < dsi->num_lanes_supported; ++i)
+		in_use[i] = dsi->lanes[i].function != DSI_LANE_UNUSED;
 
 	t = 100000;
 	while (true) {
 		u32 l;
-		int i;
 		int ok;
 
 		l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
 		ok = 0;
-		for (i = 0; i < 3; ++i) {
-			if (!in_use[i] || (l & (1 << bits[i])))
+		for (i = 0; i < dsi->num_lanes_supported; ++i) {
+			if (!in_use[i] || (l & (1 << offsets[i])))
 				ok++;
 		}
 
-		if (ok == 3)
+		if (ok == dsi->num_lanes_supported)
 			break;
 
 		if (--t == 0) {
-			for (i = 0; i < 3; ++i) {
-				if (!in_use[i] || (l & (1 << bits[i])))
+			for (i = 0; i < dsi->num_lanes_supported; ++i) {
+				if (!in_use[i] || (l & (1 << offsets[i])))
 					continue;
 
 				DSSERR("CIO TXCLKESC%d domain not coming " \
-- 
1.7.4.1

