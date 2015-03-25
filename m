From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v2 01/15] omap3isp: Fix error handling in probe
Date: Thu, 26 Mar 2015 00:57:25 +0200
Message-ID: <1427324259-18438-2-git-send-email-sakari.ailus@iki.fi>
References: <1427324259-18438-1-git-send-email-sakari.ailus@iki.fi>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1427324259-18438-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, pali.rohar@gmail.com, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

The mutex was not destroyed correctly if dma_coerce_mask_and_coherent()
failed for some reason.

Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/omap3isp/isp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index deca809..fb193b6 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2252,7 +2252,7 @@ static int isp_probe(struct platform_device *pdev)
 
 	ret = dma_coerce_mask_and_coherent(isp->dev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		goto error;
 
 	platform_set_drvdata(pdev, isp);
 
-- 
1.7.10.4
