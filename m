From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 1/4] omap-serial: Get rid of all pdev->id usage
Date: Wed, 14 Dec 2011 17:25:43 +0530
Message-ID: <1323863746-18145-2-git-send-email-rnayak@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab1LNL4N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 06:56:13 -0500
In-Reply-To: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com
Cc: tony@atomide.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com, Rajendra Nayak <rnayak@ti.com>

With Device tree, pdev->id would no longer be Valid.
Hence get rid of all instances of its usage in the
driver. Device tree support for the driver is added
in subsequent patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/tty/serial/omap-serial.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f3ff0ca..a02cc9f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -115,7 +115,7 @@ static void serial_omap_enable_ms(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
-	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->port.line);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	up->ier |= UART_IER_MSI;
@@ -418,7 +418,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	unsigned int ret = 0;
 
 	pm_runtime_get_sync(&up->pdev->dev);
-	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->port.line);
 	spin_lock_irqsave(&up->port.lock, flags);
 	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -436,7 +436,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 	status = check_modem_status(up);
 	pm_runtime_put(&up->pdev->dev);
 
-	dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->port.line);
 
 	if (status & UART_MSR_DCD)
 		ret |= TIOCM_CAR;
@@ -454,7 +454,7 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 	unsigned char mcr = 0;
 
-	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
 	if (mctrl & TIOCM_RTS)
 		mcr |= UART_MCR_RTS;
 	if (mctrl & TIOCM_DTR)
@@ -478,7 +478,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 	unsigned long flags = 0;
 
-	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->port.line);
 	pm_runtime_get_sync(&up->pdev->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (break_state == -1)
@@ -504,7 +504,7 @@ static int serial_omap_startup(struct uart_port *port)
 	if (retval)
 		return retval;
 
-	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	/*
@@ -545,7 +545,7 @@ static int serial_omap_startup(struct uart_port *port)
 			0);
 		init_timer(&(up->uart_dma.rx_timer));
 		up->uart_dma.rx_timer.function = serial_omap_rxdma_poll;
-		up->uart_dma.rx_timer.data = up->pdev->id;
+		up->uart_dma.rx_timer.data = up->port.line;
 		/* Currently the buffer size is 4KB. Can increase it */
 		up->uart_dma.rx_buf = dma_alloc_coherent(NULL,
 			up->uart_dma.rx_buf_size,
@@ -573,7 +573,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 	unsigned long flags = 0;
 
-	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->port.line);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	/*
@@ -883,7 +883,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_put(&up->pdev->dev);
-	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
 }
 
 static void
@@ -893,7 +893,7 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 	unsigned char efr;
 
-	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->port.line);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -932,7 +932,7 @@ static void serial_omap_config_port(struct uart_port *port, int flags)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
 	dev_dbg(up->port.dev, "serial_omap_config_port+%d\n",
-							up->pdev->id);
+							up->port.line);
 	up->port.type = PORT_OMAP;
 }
 
@@ -949,7 +949,7 @@ serial_omap_type(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
-	dev_dbg(up->port.dev, "serial_omap_type+%d\n", up->pdev->id);
+	dev_dbg(up->port.dev, "serial_omap_type+%d\n", up->port.line);
 	return up->name;
 }
 
@@ -1110,7 +1110,7 @@ static struct console serial_omap_console = {
 
 static void serial_omap_add_console_port(struct uart_omap_port *up)
 {
-	serial_omap_console_ports[up->pdev->id] = up;
+	serial_omap_console_ports[up->port.line] = up;
 }
 
 #define OMAP_CONSOLE	(&serial_omap_console)
@@ -1364,7 +1364,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto do_release_region;
 	}
-	sprintf(up->name, "OMAP UART%d", pdev->id);
 	up->pdev = pdev;
 	up->port.dev = &pdev->dev;
 	up->port.type = PORT_OMAP;
@@ -1375,6 +1374,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.fifosize = 64;
 	up->port.ops = &serial_omap_pops;
 	up->port.line = pdev->id;
+	sprintf(up->name, "OMAP UART%d", up->port.line);
 
 	up->port.mapbase = mem->start;
 	up->port.membase = ioremap(mem->start, resource_size(mem));
@@ -1417,7 +1417,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	ui[pdev->id] = up;
+	ui[up->port.line] = up;
 	serial_omap_add_console_port(up);
 
 	ret = uart_add_one_port(&serial_omap_reg, &up->port);
-- 
1.7.1

