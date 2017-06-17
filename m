From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] serial: 8250: 8250_omap: Fix race b/w dma completion and RX timeout
Date: Sat, 17 Jun 2017 19:22:24 +0530
Message-ID: <20170617135224.31675-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Vignesh R <vigneshr@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

DMA RX completion handler for UART is called from a tasklet and hence
may be delayed depending on the system load. In meanwhile, there may be
RX timeout interrupt which can get serviced first before DMA RX
completion handler is executed for the completed transfer.
omap_8250_rx_dma_flush() which is called on RX timeout interrupt makes
sure that the DMA RX buffer is pushed and then the FIFO is drained and
also queues a new DMA request. But, when DMA RX completion handler
executes, it will erroneously flush the currently queued DMA transfer
which sometimes results in data corruption and double queueing of DMA RX
requests.

Fix this by checking whether RX completion is for the currently queued
transfer or not. And also hold port lock when in DMA completion to avoid
race wrt RX timeout handler preempting it.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

Tested on AM335x, AM437x, DRA74x EVM with lockdep enabled.

 drivers/tty/serial/8250/8250_omap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d81bac98d190..f418808a2062 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -786,8 +786,25 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 
 static void __dma_rx_complete(void *param)
 {
-	__dma_rx_do_complete(param);
-	omap_8250_rx_dma(param);
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->port.lock, flags);
+
+	/*
+	 * If the completion is for the current cookie then handle it,
+	 * else a previous RX timeout flush would have already pushed
+	 * data from DMA buffers, so exit.
+	 */
+	if (dma->rx_cookie != dma->rxchan->completed_cookie) {
+		spin_unlock_irqrestore(&p->port.lock, flags);
+		return;
+	}
+	__dma_rx_do_complete(p);
+	omap_8250_rx_dma(p);
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
 }
 
 static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
-- 
2.13.0
