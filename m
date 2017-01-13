From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/3] serial: 8250: omap: pause DMA only if DMA transfer in progress
Date: Fri, 13 Jan 2017 13:31:59 +0530
Message-ID: <20170113080201.6515-2-vigneshr@ti.com>
References: <20170113080201.6515-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170113080201.6515-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

It is possible that DMA transfer is already complete but, completion
handler is yet to be called, when dmaengine_pause() is called in case of
error condition(like break/rx timeout). This leads to dmaengine_pause()
API to return EINVAL (as descriptor is already NULL) causing
rx_dma_broken flag to be set and effectively disabling RX DMA.
Fix this by calling dmaengine_pause() only when transfer is in progress.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 61ad6c3b20a0..4ad1934ef6ed 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -790,6 +790,7 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct omap8250_priv	*priv = p->port.private_data;
 	struct uart_8250_dma	*dma = p->dma;
+	struct dma_tx_state     state;
 	unsigned long		flags;
 	int ret;
 
@@ -800,10 +801,12 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 		return;
 	}
 
-	ret = dmaengine_pause(dma->rxchan);
-	if (WARN_ON_ONCE(ret))
-		priv->rx_dma_broken = true;
-
+	ret = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	if (ret == DMA_IN_PROGRESS) {
+		ret = dmaengine_pause(dma->rxchan);
+		if (WARN_ON_ONCE(ret))
+			priv->rx_dma_broken = true;
+	}
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
 
 	__dma_rx_do_complete(p);
-- 
2.11.0
