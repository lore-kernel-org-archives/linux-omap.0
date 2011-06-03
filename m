From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/27] OMAP: DSS2: Add FEAT_VENC_REQUIRES_TV_DAC_CLK
Date: Fri,  3 Jun 2011 13:00:21 +0300
Message-ID: <1307095237-14805-12-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42695 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754023Ab1FCKBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:23 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP3430 requires an 96MHz clock to VENC's DAC, but no other OMAP needs
it.

Add a new feature, FEAT_VENC_REQUIRES_TV_DAC_CLK, which tells if the
clock is needed on this platform, and use that feature in venc.c to
decide if the clock needs enabling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    3 ++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/venc.c         |   16 ++++++++++------
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 1c18888..a588380 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -286,7 +286,8 @@ static const struct omap_dss_features omap3430_dss_features = {
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
-		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC,
+		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC |
+		FEAT_VENC_REQUIRES_TV_DAC_CLK,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 07b346f..3058e24 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -51,6 +51,7 @@ enum dss_feat_id {
 	FEAT_HDMI_CTS_SWMODE		= 1 << 19,
 	FEAT_HANDLE_UV_SEPARATE         = 1 << 20,
 	FEAT_ATTR2                      = 1 << 21,
+	FEAT_VENC_REQUIRES_TV_DAC_CLK	= 1 << 22,
 };
 
 /* DSS register field id */
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 980f919..15b4431 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -38,6 +38,7 @@
 #include <plat/cpu.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 /* Venc registers */
 #define VENC_REV_ID				0x00
@@ -382,12 +383,15 @@ static void venc_reset(void)
 
 static void venc_enable_clocks(int enable)
 {
-	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK |
-				DSS_CLK_VIDFCK);
-	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK |
-				DSS_CLK_VIDFCK);
+	if (enable) {
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
+		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
+			dss_clk_enable(DSS_CLK_VIDFCK);
+	} else {
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
+		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
+			dss_clk_disable(DSS_CLK_VIDFCK);
+	}
 }
 
 static const struct venc_config *venc_timings_to_config(
-- 
1.7.4.1

