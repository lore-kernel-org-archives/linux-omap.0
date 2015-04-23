From: Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] dmaengine: omap-dma: Fix memory leak when terminating running transfer
Date: Thu, 23 Apr 2015 15:00:32 -0400
Message-ID: <1429815663-25702-56-git-send-email-sasha.levin@oracle.com>
References: <1429815663-25702-1-git-send-email-sasha.levin@oracle.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1429815663-25702-1-git-send-email-sasha.levin@oracle.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 02d88b735f5a60f04dbf6d051b76e1877a0d0844 ]

In omap_dma_start_desc the vdesc->node is removed from the virt-dma
framework managed lists (to be precise from the desc_issued list).
If a terminate_all comes before the transfer finishes the omap_desc will
not be freed up because it is not in any of the lists and we stopped the
DMA channel so the transfer will not going to complete.
There is no special sequence for leaking memory when using cyclic (audio)
transfer: with every start and stop of a cyclic transfer the driver leaks
struct omap_desc worth of memory.

Free up the allocated memory directly in omap_dma_terminate_all() since the
framework will not going to do that for us.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <stable@vger.kernel.org>
CC: <linux-omap@vger.kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/dma/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bbea824..f477f3b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -978,6 +978,7 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
2.1.0
