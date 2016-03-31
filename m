From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Thu, 31 Mar 2016 10:41:56 +0200
Message-ID: <8737r7ght7.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It has been observed that the TX-DMA can stall if termios changes
occur while a TX-DMA operation is in progress. Previously this was
handled by allowing set_termios to return immediately and deferring
the change until the operation is completed. Now set_termios will
block until the operation is completed, proceed with the changes,
then schedule any pending next operation.

Commit message and forward port by John Ogness.

Tested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Patch against next-20160331.

 drivers/tty/serial/8250/8250_omap.c |   57 ++++++++++++++++----------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6f76051..9459b4d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -100,9 +100,9 @@ struct omap8250_priv {
 	u8 wer;
 	u8 xon;
 	u8 xoff;
-	u8 delayed_restore;
 	u16 quot;
 
+	wait_queue_head_t termios_wait;
 	bool is_suspending;
 	int wakeirq;
 	int wakeups_enabled;
@@ -257,18 +257,6 @@ static void omap8250_update_mdr1(struct uart_8250_port *up,
 static void omap8250_restore_regs(struct uart_8250_port *up)
 {
 	struct omap8250_priv *priv = up->port.private_data;
-	struct uart_8250_dma	*dma = up->dma;
-
-	if (dma && dma->tx_running) {
-		/*
-		 * TCSANOW requests the change to occur immediately however if
-		 * we have a TX-DMA operation in progress then it has been
-		 * observed that it might stall and never complete. Therefore we
-		 * delay DMA completes to prevent this hang from happen.
-		 */
-		priv->delayed_restore = 1;
-		return;
-	}
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, UART_EFR_ECB);
@@ -310,6 +298,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
 }
 
+static void omap_8250_dma_tx_complete(void *param);
 /*
  * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
  * some differences in how we want to handle flow control.
@@ -320,6 +309,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = up->port.private_data;
+	struct uart_8250_dma *dma = up->dma;
+	unsigned int complete_dma = 0;
 	unsigned char cval = 0;
 	unsigned int baud;
 
@@ -430,7 +421,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	priv->scr = OMAP_UART_SCR_RX_TRIG_GRANU1_MASK | OMAP_UART_SCR_TX_EMPTY |
 		OMAP_UART_SCR_TX_TRIG_GRANU1_MASK;
 
-	if (up->dma)
+	if (dma)
 		priv->scr |= OMAP_UART_SCR_DMAMODE_1 |
 			OMAP_UART_SCR_DMAMODE_CTL;
 
@@ -460,6 +451,24 @@ static void omap_8250_set_termios(struct uart_port *port,
 			priv->efr |= OMAP_UART_SW_TX;
 		}
 	}
+
+	if (dma && dma->tx_running) {
+		/*
+		 * TCSANOW requests the change to occur immediately, however
+		 * if we have a TX-DMA operation in progress then it has been
+		 * observed that it might stall and never complete. Therefore
+		 * we wait until DMA completes to prevent this hang from
+		 * happening.
+		 */
+
+		dma->tx_running = 2;
+
+		spin_unlock_irq(&up->port.lock);
+		wait_event_interruptible(priv->termios_wait,
+					 dma->tx_running == 3);
+		spin_lock_irq(&up->port.lock);
+		complete_dma = 1;
+	}
 	omap8250_restore_regs(up);
 
 	spin_unlock_irq(&up->port.lock);
@@ -475,6 +484,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
+	if (complete_dma)
+		omap_8250_dma_tx_complete(up);
 }
 
 /* same as 8250 except that we may have extra flow bits set in EFR */
@@ -893,17 +904,18 @@ static void omap_8250_dma_tx_complete(void *param)
 
 	spin_lock_irqsave(&p->port.lock, flags);
 
+	if (dma->tx_running == 2) {
+		dma->tx_running = 3;
+		wake_up(&priv->termios_wait);
+		goto out;
+	}
+
 	dma->tx_running = 0;
 
 	xmit->tail += dma->tx_size;
 	xmit->tail &= UART_XMIT_SIZE - 1;
 	p->port.icount.tx += dma->tx_size;
 
-	if (priv->delayed_restore) {
-		priv->delayed_restore = 0;
-		omap8250_restore_regs(p);
-	}
-
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
@@ -923,7 +935,7 @@ static void omap_8250_dma_tx_complete(void *param)
 		p->ier |= UART_IER_THRI;
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
-
+out:
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
 
@@ -1088,6 +1100,10 @@ static inline int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 {
 	return -EINVAL;
 }
+
+static void omap_8250_dma_tx_complete(void *param)
+{
+}
 #endif
 
 static int omap8250_no_handle_irq(struct uart_port *port)
@@ -1241,6 +1257,7 @@ static int omap8250_probe(struct platform_device *pdev)
 			priv->omap8250_dma.rx_size = RX_TRIGGER;
 			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
 			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
+			init_waitqueue_head(&priv->termios_wait);
 
 			if (of_machine_is_compatible("ti,am33xx"))
 				priv->habit |= OMAP_DMA_TX_KICK;
-- 
1.7.10.4
