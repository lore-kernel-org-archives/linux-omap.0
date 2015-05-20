From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] serial: 8250_omap: provide complete custom startup &
 shutdown callbacks
Date: Wed, 20 May 2015 22:07:35 +0200
Message-ID: <20150520200735.GA7790@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34878 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbETUHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 16:07:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, nsekhar@ti.com, tony@atomide.comm, nm@ti.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org

The currently in-use port->startup and port->shutdown are "okay". The
startup part for instance does the tiny omap extra part and invokes
serial8250_do_startup() for the remaining pieces. The workflow in
serial8250_do_startup() is okay except for the part where UART_RX is
read without a check if there is something to read. I tried to
workaround it in commit 0aa525d11859 ("tty: serial: 8250_core: read only
RX if there is something in the FIFO") but then reverted it later in
commit ca8bb4aefb9 ("serial: 8250: Revert "tty: serial: 8250_core: read
only RX if there is something in the FIFO"").

This is the second attempt to get it to work on older OMAPs without
breaking other chips this time
Peter Hurley suggested to pull in the few needed lines from
serial8250_do_startup() and drop everything else that is not required
including making it simpler like using just request_irq() instead the
chain handler like it is doing now.
So lets try that.

Fixes: ca8bb4aefb93 ("serial: 8250: Revert "tty: serial: 8250_core:
       read only RX if there is something in the FIFO"")
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 82 +++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9289999cb7c6..dce1a23706e8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -562,12 +562,36 @@ static irqreturn_t omap_wake_irq(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+#ifdef CONFIG_SERIAL_8250_DMA
+static int omap_8250_dma_handle_irq(struct uart_port *port);
+#endif
+
+static irqreturn_t omap8250_irq(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int iir;
+	int ret;
+
+#ifdef CONFIG_SERIAL_8250_DMA
+	if (up->dma) {
+		ret = omap_8250_dma_handle_irq(port);
+		return IRQ_RETVAL(ret);
+	}
+#endif
+
+	serial8250_rpm_get(up);
+	iir = serial_port_in(port, UART_IIR);
+	ret = serial8250_handle_irq(port, iir);
+	serial8250_rpm_put(up);
+
+	return IRQ_RETVAL(ret);
+}
+
 static int omap_8250_startup(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
-
 	int ret;
 
 	if (priv->wakeirq) {
@@ -580,10 +604,31 @@ static int omap_8250_startup(struct uart_port *port)
 
 	pm_runtime_get_sync(port->dev);
 
-	ret = serial8250_do_startup(port);
-	if (ret)
+	up->mcr = 0;
+	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
+
+	up->lsr_saved_flags = 0;
+	up->msr_saved_flags = 0;
+
+	if (up->dma) {
+		ret = serial8250_request_dma(up);
+		if (ret) {
+			dev_warn_ratelimited(port->dev,
+					     "failed to request DMA\n");
+			up->dma = NULL;
+		}
+	}
+
+	ret = request_irq(port->irq, omap8250_irq, IRQF_SHARED,
+			  dev_name(port->dev), port);
+	if (ret < 0)
 		goto err;
 
+	up->ier = UART_IER_RLSI | UART_IER_RDI;
+	serial_out(up, UART_IER, up->ier);
+
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
 #endif
@@ -610,8 +655,7 @@ static int omap_8250_startup(struct uart_port *port)
 
 static void omap_8250_shutdown(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
+	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
 
 	flush_work(&priv->qos_work);
@@ -621,11 +665,24 @@ static void omap_8250_shutdown(struct uart_port *port)
 	pm_runtime_get_sync(port->dev);
 
 	serial_out(up, UART_OMAP_WER, 0);
-	serial8250_do_shutdown(port);
+
+	up->ier = 0;
+	serial_out(up, UART_IER, 0);
+
+	if (up->dma)
+		serial8250_release_dma(up);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+	if (up->lcr & UART_LCR_SBC)
+		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
+	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 
+	free_irq(port->irq, port);
 	if (priv->wakeirq)
 		free_irq(priv->wakeirq, port);
 }
@@ -974,6 +1031,13 @@ static inline int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 }
 #endif
 
+static int omap8250_no_handle_irq(struct uart_port *port)
+{
+	/* IRQ has not been requested but handling irq? */
+	WARN_ONCE(1, "Unexpected irq handling before port startup\n");
+	return 0;
+}
+
 static int omap8250_probe(struct platform_device *pdev)
 {
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1075,6 +1139,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(&up, priv);
+	up.port.handle_irq = omap8250_no_handle_irq;
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (pdev->dev.of_node) {
 		/*
@@ -1088,7 +1153,6 @@ static int omap8250_probe(struct platform_device *pdev)
 		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
 		if (ret == 2) {
 			up.dma = &priv->omap8250_dma;
-			up.port.handle_irq = omap_8250_dma_handle_irq;
 			priv->omap8250_dma.fn = the_no_dma_filter_fn;
 			priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
 			priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
-- 
2.1.4

