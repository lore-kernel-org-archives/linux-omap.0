From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAPDSS: DSI: Fix HSDIV related PLL info in dsi_dump_clocks()
Date: Mon, 12 Dec 2011 11:47:41 +0530
Message-ID: <1323670663-17793-2-git-send-email-archit@ti.com>
References: <1323670663-17793-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39414 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1LLGS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 01:18:27 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC6IRMB027178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:27 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pBC6IQjK006776
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:26 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC6IQJu011523
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:26 -0600 (CST)
In-Reply-To: <1323670663-17793-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The clock names of DSI_PLL_HSDIV_DISPC and DSI_PLL_HSDIV_DSI was made
dynamic based on the current value of DISPC and DSI FCLK sources. This
doesn't need to be done since we are just interested in the clock names,
and not the current clock sources for DISPC and DSI FCLKs.

Use only the generic and omap specific names for the DSI PLL's HSDIV
clocks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4dc98b6..511ae2a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1734,17 +1734,19 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 	seq_printf(s,	"CLKIN4DDR\t%-16luregm %u\n",
 			cinfo->clkin4ddr, cinfo->regm);
 
-	seq_printf(s,	"%s (%s)\t%-16luregm_dispc %u\t(%s)\n",
-			dss_get_generic_clk_source_name(dispc_clk_src),
-			dss_feat_get_clk_source_name(dispc_clk_src),
+	seq_printf(s,	"DSI_PLL_HSDIV_DISPC (%s)\t%-16luregm_dispc %u\t(%s)\n",
+			dss_feat_get_clk_source_name(dsi_module == 0 ?
+				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
+				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC),
 			cinfo->dsi_pll_hsdiv_dispc_clk,
 			cinfo->regm_dispc,
 			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
-	seq_printf(s,	"%s (%s)\t%-16luregm_dsi %u\t(%s)\n",
-			dss_get_generic_clk_source_name(dsi_clk_src),
-			dss_feat_get_clk_source_name(dsi_clk_src),
+	seq_printf(s,	"DSI_PLL_HSDIV_DSI (%s)\t%-16luregm_dsi %u\t(%s)\n",
+			dss_feat_get_clk_source_name(dsi_module == 0 ?
+				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
+				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI),
 			cinfo->dsi_pll_hsdiv_dsi_clk,
 			cinfo->regm_dsi,
 			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
-- 
1.7.4.1

