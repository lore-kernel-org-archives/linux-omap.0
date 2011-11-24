From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/13] OMAPDSS: DSI: disable DDR_CLK_ALWAYS_ON when entering ULPS
Date: Thu, 24 Nov 2011 15:29:41 +0200
Message-ID: <1322141381-5395-14-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40224 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756113Ab1KXNaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:22 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

ULPS cannot be entered if the DDR clk is enabled. Thus disable the DDR
clk before entering ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a01a011..9bcb5c2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3544,9 +3544,11 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	if (dsi->ulps_enabled)
 		return 0;
 
+	/* DDR_CLK_ALWAYS_ON */
 	if (REG_GET(dsidev, DSI_CLK_CTRL, 13, 13)) {
-		DSSERR("DDR_CLK_ALWAYS_ON enabled when entering ULPS\n");
-		return -EIO;
+		dsi_if_enable(dsidev, 0);
+		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 13, 13);
+		dsi_if_enable(dsidev, 1);
 	}
 
 	dsi_sync_vc(dsidev, 0);
-- 
1.7.4.1

