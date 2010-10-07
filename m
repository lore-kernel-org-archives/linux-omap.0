From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH] OMAP3: DSS2: DSI: Remove extra iounmap in error path
Date: Thu,  7 Oct 2010 16:58:04 +0530
Message-ID: <1286450884-3597-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760320Ab0JGL2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 07:28:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

iounmap is already done in label err2: so extra iounmap in
the error handling path could be removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b3fa3a7..aa4f7a5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3274,7 +3274,6 @@ int dsi_init(struct platform_device *pdev)
 
 	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
-		iounmap(dsi.base);
 		DSSERR("can't get VDDS_DSI regulator\n");
 		r = PTR_ERR(dsi.vdds_dsi_reg);
 		goto err2;
-- 
1.6.3.3

