From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/13] OMAPDSS: DSI: fix lane handling when entering ULPS
Date: Thu, 24 Nov 2011 15:29:39 +0200
Message-ID: <1322141381-5395-12-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42787 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756113Ab1KXNaS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:18 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current code always enters ULPS for 3 lanes. This is not right, as
there could be only 2 lanes used, and on OMAP4 we have 5 lanes.

Fix the code to put all used lanes into ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2b375c6..22055db 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3517,7 +3517,8 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	DECLARE_COMPLETION_ONSTACK(completion);
-	int r;
+	int r, i;
+	unsigned mask;
 
 	DSSDBGF();
 
@@ -3560,10 +3561,16 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	if (r)
 		return r;
 
+	mask = 0;
+
+	for (i = 0; i < dsi->num_lanes_supported; ++i) {
+		if (dsi->lanes[i].function == DSI_LANE_UNUSED)
+			continue;
+		mask |= 1 << i;
+	}
 	/* Assert TxRequestEsc for data lanes and TxUlpsClk for clk lane */
 	/* LANEx_ULPS_SIG2 */
-	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2),
-		7, 5);
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, mask, 9, 5);
 
 	/* flush posted write and wait for SCP interface to finish the write */
 	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
@@ -3579,8 +3586,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 
 	/* Reset LANEx_ULPS_SIG2 */
-	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0 << 0) | (0 << 1) | (0 << 2),
-		7, 5);
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, 0, 9, 5);
 
 	/* flush posted write and wait for SCP interface to finish the write */
 	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
-- 
1.7.4.1

