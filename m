From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 33/83] dmaengine: omap-dma: Fix memory leak when terminating running transfer
Date: Mon, 27 Apr 2015 23:32:04 +0200
Message-ID: <c38aa9bba28f912bf2eaea861c0ddf541af75606.1430159990.git.jslaby@suse.cz>
References: <3426bb8de3a655aa6668e92ee92eb35f0db86582.1430159990.git.jslaby@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <3426bb8de3a655aa6668e92ee92eb35f0db86582.1430159990.git.jslaby@suse.cz>
In-Reply-To: <cover.1430159990.git.jslaby@suse.cz>
References: <cover.1430159990.git.jslaby@suse.cz>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/dma/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ec3fc4fd9160..b94a37630e36 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -487,6 +487,7 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		omap_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
2.3.5
