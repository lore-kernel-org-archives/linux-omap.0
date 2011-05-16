From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/4] OMAP: DSS2: DSI: Remove DISPC pixel clock related info in dsi_dump_clocks()
Date: Mon, 16 May 2011 15:17:06 +0530
Message-ID: <1305539229-28560-2-git-send-email-archit@ti.com>
References: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39536 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab1EPJmT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 05:42:19 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gJd4002895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:19 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4G9gIl6021691
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:18 -0500 (CDT)
In-Reply-To: <1305539229-28560-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dsi_dump_clocks() prints lck and pck rates for the DISPC channel which it is
connected to. Remove this since it is already printed by dispc_dump_clocks()
in debugfs.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 85ec3d6..091b318 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1726,11 +1726,6 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 
 	seq_printf(s,	"LP_CLK\t\t%lu\n", cinfo->lp_clk);
 
-	seq_printf(s,	"VP_CLK\t\t%lu\n"
-			"VP_PCLK\t\t%lu\n",
-			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD),
-			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD));
-
 	enable_clocks(0);
 }
 
-- 
1.7.1

