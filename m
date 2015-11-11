From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] dmaengine: omap-dma: Clean up the prep_slave_sg sg list walk code
Date: Wed, 11 Nov 2015 12:37:56 +0200
Message-ID: <1447238278-15863-3-git-send-email-peter.ujfalusi@ti.com>
References: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The for_each_sg() macro's last parameter is inteded to be used as counter.
We can use 'i' instead of 'j' within the loop for indexes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 8ed39ce24d46..4afc2c18d451 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -768,7 +768,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	struct scatterlist *sgent;
 	struct omap_desc *d;
 	dma_addr_t dev_addr;
-	unsigned i, j = 0, es, en, frame_bytes;
+	unsigned i, es, en, frame_bytes;
 	u32 burst;
 
 	if (dir == DMA_DEV_TO_MEM) {
@@ -845,13 +845,12 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	en = burst;
 	frame_bytes = es_bytes[es] * en;
 	for_each_sg(sgl, sgent, sglen, i) {
-		d->sg[j].addr = sg_dma_address(sgent);
-		d->sg[j].en = en;
-		d->sg[j].fn = sg_dma_len(sgent) / frame_bytes;
-		j++;
+		d->sg[i].addr = sg_dma_address(sgent);
+		d->sg[i].en = en;
+		d->sg[i].fn = sg_dma_len(sgent) / frame_bytes;
 	}
 
-	d->sglen = j;
+	d->sglen = sglen;
 
 	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
 }
-- 
2.6.2
