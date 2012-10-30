From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/12] OMAPDSS: fix DSI2 PLL clk names
Date: Tue, 30 Oct 2012 18:10:01 +0200
Message-ID: <1351613409-21186-5-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52987 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933903Ab2J3QK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:26 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_generic_clk_source_names is missing the names for clocks from DSI2
PLL. Add them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 37ee465..a85bd05 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -97,6 +97,8 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI_PLL_HSDIV_DISPC",
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "DSI_PLL_HSDIV_DSI",
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC]	= "DSI_PLL2_HSDIV_DISPC",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "DSI_PLL2_HSDIV_DSI",
 };
 
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
-- 
1.7.10.4

