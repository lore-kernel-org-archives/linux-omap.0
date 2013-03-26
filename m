From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/26] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Tue, 26 Mar 2013 15:33:34 +0200
Message-ID: <1364304836-18134-5-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55853 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934238Ab3CZNeh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:37 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When using DT, dss device does not have platform data. However,
dss_get_ctx_loss_count() uses dss device's platform data to find the
get_ctx_loss_count function pointer.

To fix this, change dss_get_ctx_loss_count() needs to be changed to get
the platform data from the omapdss device, which is a "virtual" device
and always has platform data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index fdd32e8..62db201 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -157,7 +157,8 @@ static void dss_restore_context(void)
 
 int dss_get_ctx_loss_count(void)
 {
-	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
+	struct platform_device *core_pdev = dss_get_core_pdev();
+	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
 	int cnt;
 
 	if (!board_data->get_context_loss_count)
-- 
1.7.10.4

