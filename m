From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/20] OMAPDSS: DPI: use output->recommended_channel
Date: Fri, 8 Mar 2013 13:51:47 +0200
Message-ID: <1362743515-10152-13-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57874 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697Ab3CHLwW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:22 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use output's recommended_channel instead of dssdev->channel in DPI
driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index fb38019..eba6b87 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -448,7 +448,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
-	dsidev = dpi_get_dsidev(dssdev->channel);
+	dsidev = dpi_get_dsidev(dpi.output.recommended_channel);
 
 	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
 		dsidev = NULL;
-- 
1.7.10.4

