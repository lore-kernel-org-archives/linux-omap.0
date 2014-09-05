From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/18] tty: serial: 8250_dma: optimize the xmit path due to UART_BUG_DMA_TX
Date: Fri,  5 Sep 2014 21:02:47 +0200
Message-ID: <1409943773-7874-13-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Due to UART_BUG_DMA_TX the am335x has to put the first one byte into the
TX FIFO to get things going. If we get to serial8250_tx_dma() via
__dma_tx_complete() then the DMA engine just finished and the FIFO is
full and we can't put the first byte into the TX FIFO as kick start so
we leave with THRI enabled.
The result is that we end up manually filling the FIFO. We could be a
little better at this and try DMA once again. If it works, it works and
if not we do it manually.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 079048db8c81..7111b22de000 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1597,9 +1597,21 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	serial8250_modem_status(up);
 	if ((!up->dma || (up->dma && up->dma->tx_err)) &&
 			(status & UART_LSR_THRE)) {
-		serial8250_tx_chars(up);
-	}
+		if (!up->dma) {
+			serial8250_tx_chars(up);
+		} else {
+			if (uart_tx_stopped(&up->port) ||
+				uart_circ_empty(&up->port.state->xmit)) {
+				serial8250_tx_chars(up);
 
+			} else  {
+				/* try again due to UART_BUG_DMA_TX+full fifo */
+				dma_err = serial8250_tx_dma(up);
+				if (dma_err)
+					serial8250_tx_chars(up);
+			}
+		}
+	}
 	spin_unlock_irqrestore(&port->lock, flags);
 	return 1;
 }
-- 
2.1.0
