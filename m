From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/19] OMAP: DSS2: DSI: Remove CIO LDO status check
Date: Tue, 19 Apr 2011 12:22:05 +0300
Message-ID: <1303204942-25450-3-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43106 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab1DSJWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:38 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

CIO LDO status check seems to be broken on OMAP3630+ chips, and it's
also quite unclear what LDO status actually tells and when its status
changes.

This patch removes the whole check on the grounds that if there's a
problem with the LDO, we should anyway catch the problem as we check the
CIO power state and CIO reset status.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |    8 --------
 drivers/video/omap2/dss/dss_features.c |    4 ++--
 drivers/video/omap2/dss/dss_features.h |    5 ++---
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d245c5c..013621e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1952,14 +1952,6 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	if (dss_has_feature(FEAT_DSI_LDO_STATUS)) {
-		if (wait_for_bit_change(DSI_COMPLEXIO_CFG1, 21, 1) != 1) {
-			DSSERR("ComplexIO LDO power down.\n");
-			r = -ENODEV;
-			goto err;
-		}
-	}
-
 	dsi_complexio_timings();
 
 	/*
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 6a1b130..5f3a7c4 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -253,7 +253,7 @@ static struct omap_dss_features omap3430_dss_features = {
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
-		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_LDO_STATUS,
+		FEAT_DSI_PLL_FREQSEL,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -273,7 +273,7 @@ static struct omap_dss_features omap3630_dss_features = {
 		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
 		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
 		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG |
-		FEAT_DSI_PLL_FREQSEL |FEAT_DSI_LDO_STATUS,
+		FEAT_DSI_PLL_FREQSEL,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index d03f558..1093e8d 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -43,9 +43,8 @@ enum dss_feat_id {
 	/* DSI-PLL power command 0x3 is not working */
 	FEAT_DSI_PLL_PWR_BUG		= 1 << 13,
 	FEAT_DSI_PLL_FREQSEL		= 1 << 14,
-	FEAT_DSI_LDO_STATUS		= 1 << 15,
-	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 16,
-	FEAT_DSI_VC_OCP_WIDTH		= 1 << 17,
+	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
+	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
 };
 
 /* DSS register field id */
-- 
1.7.1

