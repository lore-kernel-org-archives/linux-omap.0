From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/19] OMAP: DSS2: Add FEAT_DSI_REVERSE_TXCLKESC
Date: Tue, 19 Apr 2011 12:22:09 +0300
Message-ID: <1303204942-25450-7-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56735 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754137Ab1DSJWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:48 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP3430 has RESETDONETXCLKESCx bits in the order following bitnumber
order for lanes 0, 1, 2: 28, 27, 26. OMAP3630 and later have them in
saner order: 24, 25, 26 (and 27, 28 for OMAP4).

This patch adds a dss_feature that can be used to differentiate between
those two orders of RESETDONETXCLKESCx bits.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 5f3a7c4..502a953 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -253,7 +253,7 @@ static struct omap_dss_features omap3430_dss_features = {
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
-		FEAT_DSI_PLL_FREQSEL,
+		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 1093e8d..5668fec 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -45,6 +45,7 @@ enum dss_feat_id {
 	FEAT_DSI_PLL_FREQSEL		= 1 << 14,
 	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
 	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
+	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
 };
 
 /* DSS register field id */
-- 
1.7.1

