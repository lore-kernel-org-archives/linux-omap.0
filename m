From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] serial: 8250: 8250_omap: Fix throttling when DMA is
 enabled
Date: Thu, 8 Feb 2018 18:25:42 +0530
Message-ID: <20180208125542.15649-3-vigneshr@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180208125542.15649-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

omap_8250_throttle() is called when tty RX buffer is about to overflow
and can no longer keep up with the rate at which UART is receiving data.
So, the expectation of this callback, is that UART stops RX and asserts
HW flow control to signal the sender to stop sending more data.
omap_8250_throttle() disables RX FIFO interrupts thus FIFO is no longer
serviced, leading to assertion of flow control once RX FIFO is full.
But, this does not work when DMA is enabled as driver keeps queuing new
RX DMA request in completion handler without brothering about throttling
request made by the higher layer.
This patch introduces a flag that can be used to determine whether or
not to queue next RX DMA request based on throttling request.

Without this patch, tty buffer overflows are reported at higher
baudrates.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 57f6eba47f44..624b501fd253 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -114,6 +114,7 @@ struct omap8250_priv {
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
+	bool throttled;
 };
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -692,6 +693,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 static void omap_8250_throttle(struct uart_port *port)
 {
+	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
@@ -700,6 +702,7 @@ static void omap_8250_throttle(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	serial_out(up, UART_IER, up->ier);
+	priv->throttled = true;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
@@ -738,12 +741,16 @@ static int omap_8250_rs485_config(struct uart_port *port,
 
 static void omap_8250_unthrottle(struct uart_port *port)
 {
+	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	pm_runtime_get_sync(port->dev);
 
 	spin_lock_irqsave(&port->lock, flags);
+	priv->throttled = false;
+	if (up->dma)
+		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -788,6 +795,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 static void __dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
+	struct omap8250_priv *priv = p->port.private_data;
 	struct uart_8250_dma *dma = p->dma;
 	struct dma_tx_state     state;
 	unsigned long flags;
@@ -805,7 +813,8 @@ static void __dma_rx_complete(void *param)
 		return;
 	}
 	__dma_rx_do_complete(p);
-	omap_8250_rx_dma(p);
+	if (!priv->throttled)
+		omap_8250_rx_dma(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
-- 
2.16.1
