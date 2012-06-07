From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 30/31] dmaengine: PL08x: get rid of write only pool_ctr and
 free_txd locking
Date: Thu, 07 Jun 2012 11:55:51 +0100
Message-ID: <E1ScaNb-0003mW-43@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54279 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2FGKz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:55:56 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

The free function says the pl08x lock should be taken before calling
it.  However, the DMA pool allocation/freeing is already properly
locked.  The only thing that would need this is pool_ctr, which
happens to be a write-only variable.

Let's get rid of this, and eliminate any need for additional locking
here.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9297240..a5d85b1 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -247,7 +247,6 @@ struct pl08x_dma_chan {
  * @pd: platform data passed in from the platform/machine
  * @phy_chans: array of data for the physical channels
  * @pool: a pool for the LLI descriptors
- * @pool_ctr: counter of LLIs in the pool
  * @lli_buses: bitmask to or in to LLI pointer selecting AHB port for LLI
  * fetches
  * @mem_buses: set to indicate memory transfers on AHB2.
@@ -262,7 +261,6 @@ struct pl08x_driver_data {
 	struct pl08x_platform_data *pd;
 	struct pl08x_phy_chan *phy_chans;
 	struct dma_pool *pool;
-	int pool_ctr;
 	u8 lli_buses;
 	u8 mem_buses;
 };
@@ -821,8 +819,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		return 0;
 	}
 
-	pl08x->pool_ctr++;
-
 	bd.txd = txd;
 	bd.lli_bus = (pl08x->lli_buses & PL08X_AHB2) ? PL080_LLI_LM_AHB2 : 0;
 	cctl = txd->cctl;
@@ -1038,18 +1034,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	return num_llis;
 }
 
-/* You should call this with the struct pl08x lock held */
 static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 			   struct pl08x_txd *txd)
 {
 	struct pl08x_sg *dsg, *_dsg;
 
-	/* Free the LLI */
 	if (txd->llis_va)
 		dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
-	pl08x->pool_ctr--;
-
 	list_for_each_entry_safe(dsg, _dsg, &txd->dsg_list, node) {
 		list_del(&dsg->node);
 		kfree(dsg);
@@ -1090,8 +1082,6 @@ static void pl08x_desc_free(struct virt_dma_desc *vd)
 {
 	struct pl08x_txd *txd = to_pl08x_txd(&vd->tx);
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(vd->tx.chan);
-	struct pl08x_driver_data *pl08x = plchan->host;
-	unsigned long flags;
 
 	if (!plchan->slave)
 		pl08x_unmap_buffers(txd);
@@ -1099,9 +1089,7 @@ static void pl08x_desc_free(struct virt_dma_desc *vd)
 	if (!txd->done)
 		pl08x_release_mux(plchan);
 
-	spin_lock_irqsave(&pl08x->lock, flags);
 	pl08x_free_txd(plchan->host, txd);
-	spin_unlock_irqrestore(&pl08x->lock, flags);
 }
 
 static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
-- 
1.7.4.4

