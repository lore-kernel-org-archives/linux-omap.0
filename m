From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 21/24] SERIAL: omap: use tx buffer allocation API
Date: Sat, 06 Oct 2012 13:46:07 +0100
Message-ID: <E1TKTlf-0002nm-Pn@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Rather than working around serial_core, use the newly provided buffer
allocation API to allow a saner method to manage this buffer.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b497187..6054fc8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -604,11 +604,6 @@ static int serial_omap_startup(struct uart_port *port)
 
 	up->msr_saved_flags = 0;
 	if (up->use_dma) {
-		free_page((unsigned long)up->port.state->xmit.buf);
-		up->port.state->xmit.buf = dma_alloc_coherent(NULL,
-			UART_XMIT_SIZE,
-			(dma_addr_t *)&(up->uart_dma.tx_buf_dma_phys),
-			0);
 		init_timer(&(up->uart_dma.rx_timer));
 		up->uart_dma.rx_timer.function = serial_omap_rxdma_poll;
 		up->uart_dma.rx_timer.data = up->port.line;
@@ -665,10 +660,6 @@ static void serial_omap_shutdown(struct uart_port *port)
 	if (serial_in(up, UART_LSR) & UART_LSR_DR)
 		(void) serial_in(up, UART_RX);
 	if (up->use_dma) {
-		dma_free_coherent(up->port.dev,
-			UART_XMIT_SIZE,	up->port.state->xmit.buf,
-			up->uart_dma.tx_buf_dma_phys);
-		up->port.state->xmit.buf = NULL;
 		serial_omap_stop_rx(port);
 		dma_free_coherent(up->port.dev,
 			up->uart_dma.rx_buf_size, up->uart_dma.rx_buf,
@@ -680,6 +671,33 @@ static void serial_omap_shutdown(struct uart_port *port)
 	free_irq(up->port.irq, up);
 }
 
+static int serial_omap_alloc_xmit(struct uart_port *port, struct circ_buf *xmit)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	if (up->use_dma) {
+		xmit->buf = dma_alloc_coherent(NULL, UART_XMIT_SIZE,
+				&up->uart_dma.tx_buf_dma_phys, 0);
+	} else {
+		unsigned long page = get_zeroed_page(GFP_KERNEL);
+		xmit->buf = (unsigned char *)page;
+	}
+
+	return xmit->buf ? 0 : -ENOMEM;
+}
+
+static void serial_omap_free_xmit(struct uart_port *port, struct circ_buf *xmit)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	if (up->use_dma) {
+		dma_free_coherent(NULL, UART_XMIT_SIZE,
+				  xmit->buf, up->uart_dma.tx_buf_dma_phys);
+	} else {
+		free_page((unsigned long)xmit->buf);
+	}
+}
+
 static void serial_omap_uart_qos_work(struct work_struct *work)
 {
 	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
@@ -1193,6 +1211,8 @@ static struct uart_ops serial_omap_pops = {
 	.break_ctl	= serial_omap_break_ctl,
 	.startup	= serial_omap_startup,
 	.shutdown	= serial_omap_shutdown,
+	.alloc_xmit	= serial_omap_alloc_xmit,
+	.free_xmit	= serial_omap_free_xmit,
 	.set_termios	= serial_omap_set_termios,
 	.pm		= serial_omap_pm,
 	.type		= serial_omap_type,
-- 
1.7.4.4

