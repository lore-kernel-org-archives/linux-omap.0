From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 7/8] dmaengine: omap-dma: Reduce the number of virtual channels
Date: Wed, 8 Apr 2015 16:14:51 +0300
Message-ID: <1428498892-28471-8-git-send-email-peter.ujfalusi@ti.com>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169AbbDHNP6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Apr 2015 09:15:58 -0400
In-Reply-To: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de

Since the mapping between the hardware request lines and channels has been
removed it no longer make sense to have too many channels.
Set the number of channels to match with the number of logical channels
supported by sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 5ece72c30216..66513fc24e83 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1129,7 +1129,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			 OMAP_SDMA_REQUESTS);
 	}
 
-	for (i = 0; i < od->dma_requests; i++) {
+	for (i = 0; i < OMAP_SDMA_CHANNELS; i++) {
 		rc = omap_dma_chan_init(od);
 		if (rc) {
 			omap_dma_free(od);
-- 
2.3.5

