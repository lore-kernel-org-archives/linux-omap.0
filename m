From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/2] dmaengine: omap-dma: Do not suppress interrupts for
 memcpy
Date: Tue, 5 Apr 2016 15:20:21 +0300
Message-ID: <1459858821-25191-3-git-send-email-peter.ujfalusi@ti.com>
References: <1459858821-25191-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459858821-25191-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the client queues up more transfers the driver will not able to move to
the next transfer without knowing that the previous descriptor is
completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 6ea9044d8b71..1e984e18c126 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -955,9 +955,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
 	d->ccr = c->ccr;
 	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
 
-	d->cicr = CICR_DROP_IE;
-	if (tx_flags & DMA_PREP_INTERRUPT)
-		d->cicr |= CICR_FRAME_IE;
+	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
 
 	d->csdp = data_type;
 
-- 
2.8.0
