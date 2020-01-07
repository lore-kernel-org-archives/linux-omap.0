From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] mtd: onenand: omap2: Pass correct flags for prep_dma_memcpy
Date: Tue, 7 Jan 2020 10:45:44 +0200
Message-ID: <20200107084544.18547-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kyungmin.park@samsung.com, miquel.raynal@bootlin.com, aaro.koskinen@iki.fi, vigneshr@ti.com, hns@goldelico.com
Cc: tony@atomide.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The commit converting the driver to DMAengine was missing the flags for
the memcpy prepare call.
It went unnoticed since the omap-dma driver was ignoring them.

Fixes: 3ed6a4d1de2c5 (" mtd: onenand: omap2: Convert to use dmaengine for memcp")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
Hi,

Changes since v1:
- Typo fixed in the commit message
- Added the Tested-by from Aaro and Nikolaus

Aaro reported [1] a failure on omap2-onenand pointing to
4689d35c765c696bdf0535486a990038b242a26b. It looks like the root cause is the
conversion of omap2-onenand to DMAengine which missed the flags.

Basically the client is waiting for a callback without asking for it. This
certainly causes timeout.

I have not tested the patch, but it should fix the issue.

[1] https://lore.kernel.org/lkml/20200103081726.GD15023@darkstar.musicnaut.iki.fi/

Regards,
Peter

 drivers/mtd/nand/onenand/omap2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
index edf94ee54ec7..71a632b815aa 100644
--- a/drivers/mtd/nand/onenand/omap2.c
+++ b/drivers/mtd/nand/onenand/omap2.c
@@ -328,7 +328,8 @@ static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
 	struct dma_async_tx_descriptor *tx;
 	dma_cookie_t cookie;
 
-	tx = dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count, 0);
+	tx = dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count,
+				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!tx) {
 		dev_err(&c->pdev->dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
