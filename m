From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC 3/3] serial: 8250_omap: try to avoid IER_RDI with DMA
Date: Fri, 14 Aug 2015 18:01:04 +0200
Message-ID: <1439568064-7907-3-git-send-email-bigeasy@linutronix.de>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

It has been observed on DRA7-evm that the UART triggers the interrupt and
reading IIR says IIR_NO_INT. It seems that we receive data via RX-DMA
but the interrupt is triggered anyway. I have hardly observed it on
AM335x and not in *that* quantity. On DRA7-evm with continuous transfers
at 3MBaud and CPU running at 1.5Ghz it is possible that the IRQ-core will
close the UART interrupt after "some time" with "nobody cared".

I've seen that by not enabling IER_RDI those spurious interrupts are not
triggered. Also it seems that DMA and RDI cause the "timeout interrupt"
which does not allow RX-DMA to be scheduled even if the FIFO reached the
programmed RX threshold. However without RDI we don't get a notification
if we have less than RX threshold bytes in the FIFO.
This is where we have the rx_dma_wd timer. After programming the RX-DMA
transfer wait HZ / 4 or 250ms for it to complete. If it does not
complete in that time span we cancel the DMA transfer and enable RDI.
RDI will trigger an UART interrupt in case we have bytes in the FIFO.
Once we read bytes manually from the FIFO we enable RX-DMA again
(without RDI) with the same 250ms timeout.

One downside with this approach is that latency sensitive protocols that
transfer less than 48 bytes will have to wait 250ms to complete.

Is there maybe a user interface where one could set small or bulk transfers?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 383f143b6b36..68d03553617b 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -113,6 +113,7 @@ struct omap8250_priv {
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
+	struct timer_list rx_dma_wd;
 };
 
 static u32 uart_read(struct uart_8250_port *up, u32 reg)
@@ -599,6 +600,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	return IRQ_RETVAL(ret);
 }
 
+static void omap8250_rx_dma_wd(unsigned long data);
 static int omap_8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -627,6 +629,10 @@ static int omap_8250_startup(struct uart_port *port)
 			dev_warn_ratelimited(port->dev,
 					     "failed to request DMA\n");
 			up->dma = NULL;
+		} else {
+			init_timer(&priv->rx_dma_wd);
+			priv->rx_dma_wd.function = omap8250_rx_dma_wd;
+			priv->rx_dma_wd.data = (unsigned long) up;
 		}
 	}
 
@@ -635,7 +641,9 @@ static int omap_8250_startup(struct uart_port *port)
 	if (ret < 0)
 		goto err;
 
-	up->ier = UART_IER_RLSI | UART_IER_RDI;
+	up->ier = UART_IER_RLSI;
+	if (!up->dma->rxchan)
+		up->ier |= UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 
 #ifdef CONFIG_PM
@@ -670,6 +678,8 @@ static void omap_8250_shutdown(struct uart_port *port)
 	if (up->dma)
 		up->dma->rx_dma(up, UART_IIR_RX_TIMEOUT);
 
+	del_timer_sync(&priv->rx_dma_wd);
+
 	pm_runtime_get_sync(port->dev);
 
 	serial_out(up, UART_OMAP_WER, 0);
@@ -846,6 +856,9 @@ static int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 	if (dma->rx_running)
 		goto out;
 
+	if (p->ier & UART_IER_RDI)
+		goto out;
+
 	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
 					   dma->rx_size, DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -864,6 +877,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 				   dma->rx_size, DMA_FROM_DEVICE);
 
 	dma_async_issue_pending(dma->rxchan);
+	mod_timer(&priv->rx_dma_wd, jiffies + HZ / 4);
 out:
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
 	return err;
@@ -1044,6 +1058,9 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		dma_err = omap_8250_rx_dma(up, iir);
 		if (dma_err) {
 			status = serial8250_rx_chars(up, status);
+
+			up->ier &= ~UART_IER_RDI;
+			serial_port_out(port, UART_IER, up->ier);
 			omap_8250_rx_dma(up, 0);
 		}
 	}
@@ -1069,6 +1086,20 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void omap8250_rx_dma_wd(unsigned long data)
+{
+	struct uart_8250_port	*up = (void *) data;
+	struct uart_port	*port = &up->port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	omap_8250_rx_dma_flush(up);
+	up->ier |= UART_IER_RDI;
+	serial_port_out(port, UART_IER, up->ier);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static bool the_no_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	return false;
-- 
2.5.0
