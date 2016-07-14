From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/7] dmaengine: omap-dma: Simplify omap_dma_callback
Date: Thu, 14 Jul 2016 15:42:38 +0300
Message-ID: <20160714124242.7579-4-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Flatten the indentation level of the function which gives better view on
the cases we handle here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f7b0b0c668fb..6d134252ed61 100644
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
-				vchan_cookie_complete(&d->vd);
-				omap_dma_start_desc(c);
-			}
-		} else {
+		if (c->cyclic) {
 			vchan_cyclic_callback(&d->vd);
+		} else if (c->sgidx == d->sglen) {
+			vchan_cookie_complete(&d->vd);
+			omap_dma_start_desc(c);
+		} else {
+			omap_dma_start_sg(c, d);
 		}
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
-- 
2.9.1
