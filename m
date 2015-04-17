From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.10 19/34] dmaengine: omap-dma: Fix memory leak when terminating running transfer
Date: Fri, 17 Apr 2015 15:28:51 +0200
Message-ID: <20150417132554.950483153@linuxfoundation.org>
References: <20150417132553.751904098@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417132553.751904098@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-omap@vger.kernel.org

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit 02d88b735f5a60f04dbf6d051b76e1877a0d0844 upstream.

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
CC: <linux-omap@vger.kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/omap-dma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -487,6 +487,7 @@ static int omap_dma_terminate_all(struct
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
