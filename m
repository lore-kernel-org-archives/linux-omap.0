From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/14] OMAPDSS: DISPC: Add DRA7xx support
Date: Tue, 27 Jan 2015 12:50:39 +0200
Message-ID: <1422355842-11234-12-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60767 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbbA0KvK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:10 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DRA7xx support to DISPC driver. The DISPC block is the same as on
OMAP5, except the PLL's used for clocking are "videoX", not "dsiX".

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 9850d9ef9a9d..48429bab294a 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3037,10 +3037,16 @@ unsigned long dispc_fclk_rate(void)
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		pll = dss_pll_find("dsi0");
+		if (!pll)
+			pll = dss_pll_find("video0");
+
 		r = pll->cinfo.clkout[0];
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 		pll = dss_pll_find("dsi1");
+		if (!pll)
+			pll = dss_pll_find("video1");
+
 		r = pll->cinfo.clkout[0];
 		break;
 	default:
@@ -3069,10 +3075,16 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 			break;
 		case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 			pll = dss_pll_find("dsi0");
+			if (!pll)
+				pll = dss_pll_find("video0");
+
 			r = pll->cinfo.clkout[0];
 			break;
 		case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 			pll = dss_pll_find("dsi1");
+			if (!pll)
+				pll = dss_pll_find("video1");
+
 			r = pll->cinfo.clkout[0];
 			break;
 		default:
@@ -3668,6 +3680,7 @@ static int __init dispc_init_features(struct platform_device *pdev)
 		break;
 
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		src = &omap54xx_dispc_feats;
 		break;
 
@@ -3832,6 +3845,7 @@ static const struct of_device_id dispc_of_match[] = {
 	{ .compatible = "ti,omap3-dispc", },
 	{ .compatible = "ti,omap4-dispc", },
 	{ .compatible = "ti,omap5-dispc", },
+	{ .compatible = "ti,dra7-dispc", },
 	{},
 };
 
-- 
2.2.2

