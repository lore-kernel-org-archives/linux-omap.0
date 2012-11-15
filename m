From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/32] OMAPDSS: DPI: fix crash with dpi_verify_dsi_pll()
Date: Thu, 15 Nov 2012 17:58:10 +0200
Message-ID: <1352995120-3288-3-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50096 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768077Ab2KOP7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:11 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

If the DSI support has not been compiled in or the SoC doesn't have DSI
hardware, dpi_get_dsidev() returns NULL. This NULL is passed to
dpi_verify_dsi_pll() causing a crash. The bug was added with commit
0e8276ef75f5c7811b038d1d23b2b42c16efc5ac (OMAPDSS: DPI: always use DSI
PLL if available).

Fix this by checking if dsidev is NULL before calling
dpi_verify_dsi_pll().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 1e103b3..c109fa6 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -412,7 +412,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	 */
 	dsidev = dpi_get_dsidev(dssdev->channel);
 
-	if (dpi_verify_dsi_pll(dsidev)) {
+	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
 		dsidev = NULL;
 		DSSWARN("DSI PLL not operational\n");
 	}
-- 
1.7.10.4

