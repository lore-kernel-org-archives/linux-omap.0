From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on transfer completion
Date: Thu, 14 Jul 2016 15:42:37 +0300
Message-ID: <20160714124242.7579-3-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Before looking for the next descriptor to start, complete the just finished
cookie.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 7d56cd88c9a5..f7b0b0c668fb 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -449,8 +449,8 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 			if (c->sgidx < d->sglen) {
 				omap_dma_start_sg(c, d);
 			} else {
-				omap_dma_start_desc(c);
 				vchan_cookie_complete(&d->vd);
+				omap_dma_start_desc(c);
 			}
 		} else {
 			vchan_cyclic_callback(&d->vd);
-- 
2.9.1
