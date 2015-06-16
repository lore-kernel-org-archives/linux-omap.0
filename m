From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/7] OMAPDSS: fix dss_init_ports error handling
Date: Tue, 16 Jun 2015 13:16:25 +0300
Message-ID: <1434449789-13812-4-git-send-email-tomi.valkeinen@ti.com>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57889 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756832AbbFPKRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 06:17:07 -0400
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The return value of dss_init_ports() is not handled at all, causing
crashes later if the call failed.

This patch adds the error handling, and we also move the call to a
slightly earlier place to make bailing out easier.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 1ce47441efe3..28e6ff053b47 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -1125,6 +1125,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_pll_init;
 
+	r = dss_init_ports(pdev);
+	if (r)
+		goto err_init_ports;
+
 	pm_runtime_enable(&pdev->dev);
 
 	r = dss_runtime_get();
@@ -1149,8 +1153,6 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
-	dss_init_ports(pdev);
-
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -1167,7 +1169,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-
+	dss_uninit_ports(pdev);
+err_init_ports:
 	if (dss.video1_pll)
 		dss_video_pll_uninit(dss.video1_pll);
 
-- 
2.1.4

