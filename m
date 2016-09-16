From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Enable burst and data pack for SG
Date: Fri, 16 Sep 2016 13:53:15 +0300
Message-ID: <20160916105315.28320-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@armlinux.org.uk, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Enable the burst and data pack modes for the scatter-gather
in order to improve the throughput of the data transfers.

The improvement has been verified with MMC HS200 mode in
the DRA72 EVM using the iozone tool to compare the read
throughput (in kB/s) with and without burst/pack for
different reclens (in kB).

                              With
    reclen    Baseline   sDMA burst/pack
    ------    --------   ---------------
       64       46568         50820
      128       57564         63413
      256       65634         74937
      512       72427         83483
     1024       74563         84504
     2048       76265         86079
     4096       78045         87335
     8192       78989         88154
    16384       81265         91034

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 1b7f5f32bf74..7ca27d4b1c54 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -904,13 +904,16 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->es = es;
 
 	d->ccr = c->ccr | CCR_SYNC_FRAME;
-	if (dir == DMA_DEV_TO_MEM)
+	if (dir == DMA_DEV_TO_MEM) {
 		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
-	else
+		d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
+	} else {
 		d->ccr |= CCR_DST_AMODE_CONSTANT | CCR_SRC_AMODE_POSTINC;
+		d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
+	}
 
 	d->cicr = CICR_DROP_IE | CICR_BLOCK_IE;
-	d->csdp = es;
+	d->csdp |= es;
 
 	if (dma_omap1()) {
 		d->cicr |= CICR_TOUT_IE;
-- 
2.10.0
