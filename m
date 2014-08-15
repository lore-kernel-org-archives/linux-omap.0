From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/15] dmaengine: omap-dma: complete the transfer on terminate_all
Date: Fri, 15 Aug 2014 19:42:37 +0200
Message-ID: <1408124563-31541-10-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

The rx path of the 8250_dma user in the RX-timeout case:
- it starts the RX transfer
- if the rx-timeout interrupt occurs, it dmaengine_pause() the transfer
- step two is dmaengine_terminate_all() on this channel.
- the rx interrupt occurs, it does not start the RX-transfer because
  according to dmaengine_tx_status() the status of the current transfer
  is still DMA_IN_PROGRESS because the earlier dmaengine_terminate_all()
  did not reset this.

To fix this problem, the patch adds dma_cookie_complete() "complete" the
current cookie.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/dma/omap-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index b19f04f..81ede01 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -970,6 +970,12 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 
 	/* Prevent this channel being scheduled */
 	spin_lock(&d->lock);
+	if (!c->desc && !list_empty(&c->node)) {
+		struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
+
+		if (vd)
+			dma_cookie_complete(&vd->tx);
+	}
 	list_del_init(&c->node);
 	spin_unlock(&d->lock);
 
@@ -979,6 +985,7 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		dma_cookie_complete(&c->desc->vd.tx);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
2.0.1

