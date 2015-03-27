From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] dmaengine: omap-dma: Fix memory leak when terminating running transfer
Date: Fri, 27 Mar 2015 13:35:52 +0200
Message-ID: <1427456155-28990-3-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56198 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbbC0Lge (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Mar 2015 07:36:34 -0400
In-Reply-To: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, linux-omap@vger.kernel.org

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
---
 drivers/dma/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 1e646d6c8230..6a4c378ee432 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1002,6 +1002,7 @@ static int omap_dma_terminate_all(struct dma_chan *chan)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
2.3.3

