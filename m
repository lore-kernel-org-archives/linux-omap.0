From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 12/24] SERIAL: omap: fix hardware assisted flow control
Date: Sat, 06 Oct 2012 13:43:04 +0100
Message-ID: <E1TKTii-0002nC-SV@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When the UART device has hardware flow control enabled, it ignores the
MCR RTS bit in the MCR register, and keeps RTS asserted as long as we
continue to read characters from the UART receiver FIFO.  This means
that when the TTY buffers become full, the UART doesn't tell the remote
end to stop sending, which causes the TTY layer to start dropping
characters.

A similar problem exists with software flow control.  We need the FIFO
register to fill when software flow control is enabled to provoke the
UART to send the XOFF character.

Fix this by implementing the throttle/unthrottle callbacks, and use
these to disable receiver interrupts.  This in turn means that the UART
FIFO will fill, which will then cause the UART's hardware to deassert
the RTS signal and/or send the XOFF character, stopping the remote end.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6314827..ab5a5e0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -373,6 +373,34 @@ static void serial_omap_start_tx(struct uart_port *port)
 	omap_start_dma(up->uart_dma.tx_dma_channel);
 }
 
+static void serial_omap_throttle(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+
+	pm_runtime_get_sync(&up->pdev->dev);
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
+}
+
+static void serial_omap_unthrottle(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+
+	pm_runtime_get_sync(&up->pdev->dev);
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
+}
+
 static unsigned int check_modem_status(struct uart_omap_port *up)
 {
 	unsigned int status;
@@ -985,6 +1013,7 @@ static void serial_omap_config_port(struct uart_port *port, int flags)
 	dev_dbg(up->port.dev, "serial_omap_config_port+%d\n",
 							up->port.line);
 	up->port.type = PORT_OMAP;
+	up->port.flags |= UPF_SOFT_FLOW | UPF_HARD_FLOW;
 }
 
 static int
@@ -1181,6 +1210,8 @@ static struct uart_ops serial_omap_pops = {
 	.get_mctrl	= serial_omap_get_mctrl,
 	.stop_tx	= serial_omap_stop_tx,
 	.start_tx	= serial_omap_start_tx,
+	.throttle	= serial_omap_throttle,
+	.unthrottle	= serial_omap_unthrottle,
 	.stop_rx	= serial_omap_stop_rx,
 	.enable_ms	= serial_omap_enable_ms,
 	.break_ctl	= serial_omap_break_ctl,
-- 
1.7.4.4

