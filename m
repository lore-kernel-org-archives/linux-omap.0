From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/6] dmaengine: omap-dma: Simplify omap_dma_callback
Date: Wed, 20 Jul 2016 11:50:28 +0300
Message-ID: <20160720085032.2955-3-peter.ujfalusi@ti.com>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Flatten the indentation level of the function which gives better view on
the cases we handle here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 7d56cd88c9a5..d469f9b820e0 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -445,15 +445,13 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 	spin_lock_irqsave(&c->vc.lock, flags);
 	d = c->desc;
 	if (d) {
-		if (!c->cyclic) {
-			if (c->sgidx < d->sglen) {
-				omap_dma_start_sg(c, d);
-			} else {
-				omap_dma_start_desc(c);
-				vchan_cookie_complete(&d->vd);
-			}
-		} else {
+		if (c->cyclic) {
 			vchan_cyclic_callback(&d->vd);
+		} else if (c->sgidx == d->sglen) {
+			omap_dma_start_desc(c);
+			vchan_cookie_complete(&d->vd);
+		} else {
+			omap_dma_start_sg(c, d);
 		}
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
-- 
2.9.2
