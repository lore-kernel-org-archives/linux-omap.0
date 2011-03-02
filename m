From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] HACK: OMAP: DSS2: Fix OMAP2_DSS_USE_DSI_PLL
Date: Wed, 2 Mar 2011 10:20:15 +0200
Message-ID: <1299054015-1070-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37176 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660Ab1CBIUZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 03:20:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: steve@sakoman.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

When using OMAP2_DSS_USE_DSI_PLL, which selects DSI PLL as source clock
for DISPC, the DSI needs the vdds_dsi regulator. Latest regulator
changes broke this, causing the the code to not acquire the regulator
when using OMAP2_DSS_USE_DSI_PLL.

This patch acquires the vdds_dsi regulator in dsi_pll_init(), fixing the
issue. This is is just a quick hack to get the OMAP2_DSS_USE_DSI_PLL
option working. There shouldn't be any other downside in this solution
than some extra lines of code.

OMAP2_DSS_USE_DSI_PLL is itself a big hack, and should be removed, and
the feature itself should be implemented in a more sane way. However,
the solution is not trivial, and people are using DSI PLL to get more
exact pixel clocks, so this hack is an acceptable temporary solution for
the time being.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c3019d9..6f4f19d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1105,6 +1105,26 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 
 	DSSDBG("PLL init\n");
 
+#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+	/*
+	 * HACK: this is just a quick hack to get the USE_DSI_PLL
+	 * option working. USE_DSI_PLL is itself a big hack, and
+	 * should be removed.
+	 */
+	if (dsi.vdds_dsi_reg == NULL) {
+		struct regulator *vdds_dsi;
+
+		vdds_dsi = regulator_get(&dsi.pdev->dev, "vdds_dsi");
+
+		if (IS_ERR(vdds_dsi)) {
+			DSSERR("can't get VDDS_DSI regulator\n");
+			return PTR_ERR(vdds_dsi);
+		}
+
+		dsi.vdds_dsi_reg = vdds_dsi;
+	}
+#endif
+
 	enable_clocks(1);
 	dsi_enable_pll_clock(1);
 
-- 
1.7.1

