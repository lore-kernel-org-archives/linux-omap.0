From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
Date: Mon, 22 Aug 2011 11:26:10 +0300
Message-ID: <1314001571-17877-3-git-send-email-tomi.valkeinen@ti.com>
References: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34898 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754230Ab1HVI00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:26 -0400
In-Reply-To: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This reverts commit df5d3ed23cf73ee0763a8963003bda9b69d9620f.

The HDMI clock name has been fixed in HWMOD data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3767323..9353dcf 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1704,9 +1704,9 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 
 	hdmi.sys_clk = clk;
 
-	clk = clk_get(&pdev->dev, "dss_48mhz_clk");
+	clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
-		DSSERR("can't get hdmi_clk\n");
+		DSSERR("can't get fck\n");
 		clk_put(hdmi.sys_clk);
 		return PTR_ERR(clk);
 	}
-- 
1.7.4.1

