From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH V03 1/5] dmaengine: core: Skip mask matching when it is not provided to private_candidate
Date: Mon, 14 Dec 2015 22:47:38 +0200
Message-ID: <1450126062-8063-2-git-send-email-peter.ujfalusi@ti.com>
References: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

If mask is NULL skip the mask matching against the DMA device capabilities.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index daf54a39bcc7..6311e1fc80be 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 {
 	struct dma_chan *chan;
 
-	if (!__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
 		pr_debug("%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
-- 
2.6.4
