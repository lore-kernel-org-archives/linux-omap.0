From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/13] dmaengine: edma: check for echan->edesc => NULL in
 edma_dma_pause()
Date: Mon, 29 Sep 2014 20:06:45 +0200
Message-ID: <1412014009-13315-10-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: tony@atomide.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, balbi@ti.com, vinod.koul@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

I added book keeping of whether or not the 8250-dma driver has an RX
transfer pending or not so we don't BUG here if it calls
dmaengine_pause() on a channel which has not a pending transfer. Guess
what, this is not enough.
The following can be triggered with a busy RX channel and hackbench in
background:
- DMA transfer completes. The callback is delayed via
  vchan_cookie_complete() into a tasklet so it das not happen asap.
- hackbench keeps the system busy so the tasklet does not run "soon".
- the UART collected enough data and generates an "timeout"-interrupt.
  Since 8250-dma *thinks* the DMA-transfer is still pending it tries to
  cancel it via invoking dmaengine_pause() first. This causes the segfault
  because echan->edesc is NULL now that the transfer completed (however
  the callback did not run yet).

With this patch we don't BUG in the scenario described.

Cc: vinod.koul@intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/dma/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7b65633f495e..123f578d6dd3 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -288,7 +288,7 @@ static int edma_slave_config(struct edma_chan *echan,
 static int edma_dma_pause(struct edma_chan *echan)
 {
 	/* Pause/Resume only allowed with cyclic mode */
-	if (!echan->edesc->cyclic)
+	if (!echan->edesc || !echan->edesc->cyclic)
 		return -EINVAL;
 
 	edma_pause(echan->ch_num);
-- 
2.1.0
