From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
Date: Thu, 17 Oct 2013 16:28:20 -0700
Message-ID: <20131017232820.GG15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

With the recent pinctrl-single changes, omaps can treat
wake-up events from deeper idle states as interrupts.

There's a separate "io chain" controller on most omaps
that stays enabled when the device hits off-idle and the
regular interrupt controller is powered off.

Let's add support for the optional second interrupt for
wake-up events. And then serial-omap can manage the
wake-up interrupt from it's runtime PM calls to avoid
spurious interrupts during runtime.

Note that the wake interrupt is board specific as it
uses the UART RX pin, and for omap3, there are six pin
options for UART3 RX pin.

Also Note that the legacy platform based booting handles
the wake-ups in the legacy mux driver and does not need to
pass the wake-up interrupt to the driver.

And finally, to pass the wake-up interrupt in the dts file,
either interrupt-map or the pending interrupts-extended
property needs to be passed. It's probably best to use
interrupts-extended when it's available.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -39,6 +39,7 @@
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_data/serial-omap.h>
@@ -134,7 +135,7 @@ struct uart_omap_port {
 	struct uart_port	port;
 	struct uart_omap_dma	uart_dma;
 	struct device		*dev;
-
+	int			irqs[2];
 	unsigned char		ier;
 	unsigned char		lcr;
 	unsigned char		mcr;
@@ -176,6 +177,8 @@ struct uart_omap_port {
 };
 
 #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
+#define omap_uartirq		(up->irqs[0])
+#define omap_wakeirq		(up->irqs[1])
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -214,10 +217,23 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
+static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
+				       bool enable)
+{
+	if (!omap_wakeirq)
+		return;
+
+	if (enable)
+		enable_irq(omap_wakeirq);
+	else
+		disable_irq(omap_wakeirq);
+}
+
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
+	serial_omap_enable_wakeirq(up, enable);
 	if (!pdata || !pdata->enable_wakeup)
 		return;
 
@@ -689,15 +705,25 @@ static int serial_omap_startup(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned long flags = 0;
-	int retval;
+	int i, retval;
 
 	/*
-	 * Allocate the IRQ
+	 * Allocate the IRQs, the second IRQ is the optional wakeirq
 	 */
-	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
-				up->name, up);
-	if (retval)
-		return retval;
+	for (i = 0; i < ARRAY_SIZE(up->irqs); i++) {
+		if (i == 1 && !omap_wakeirq) {
+			dev_info(up->port.dev, "no wakeirq for uart%d\n",
+				 up->port.line);
+			break;
+		}
+		retval = devm_request_irq(up->port.dev, up->irqs[i],
+					  serial_omap_irq, up->port.irqflags,
+					  up->name, up);
+		if (retval)
+			return retval;
+	}
+	if (omap_wakeirq)
+		disable_irq(omap_wakeirq);
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
@@ -757,6 +783,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned long flags = 0;
+	int i;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->port.line);
 
@@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
 
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
-	free_irq(up->port.irq, up);
+
+	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
+		if (up->irqs[i])
+			devm_free_irq(up->port.dev, up->irqs[i], up);
 }
 
 static void serial_omap_uart_qos_work(struct work_struct *work)
@@ -1570,13 +1600,25 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
-	struct resource		*mem, *irq;
+	struct resource		*mem, *irq = NULL;
 	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
-	int ret;
+	int of_irqs[2], ret, i;
 
+	/* The optional wakeirq may be specified in the board dts file */
 	if (pdev->dev.of_node) {
+		for (i = 0; i < ARRAY_SIZE(up->irqs); i++) {
+			of_irqs[i] = irq_of_parse_and_map(pdev->dev.of_node, i);
+			if (i == 0 && !of_irqs[i])
+				return -EPROBE_DEFER;
+		}
 		omap_up_info = of_get_uart_port_info(&pdev->dev);
 		pdev->dev.platform_data = omap_up_info;
+	} else {
+		irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (!irq) {
+			dev_err(&pdev->dev, "no irq resource?\n");
+			return -ENODEV;
+		}
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1585,12 +1627,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
-	}
-
 	if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
 				pdev->dev.driver->name)) {
 		dev_err(&pdev->dev, "memory region already claimed\n");
@@ -1612,6 +1648,16 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (!up)
 		return -ENOMEM;
 
+	if (pdev->dev.of_node) {
+		up->port.irq = of_irqs[0];
+		for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
+			up->irqs[i] = of_irqs[i];
+	} else {
+		up->port.irq = irq->start;
+		up->irqs[0] = irq->start;
+		up->irqs[1] = 0;
+	}
+
 	if (gpio_is_valid(omap_up_info->DTR_gpio) &&
 	    omap_up_info->DTR_present) {
 		up->DTR_gpio = omap_up_info->DTR_gpio;
@@ -1624,7 +1670,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.dev = &pdev->dev;
 	up->port.type = PORT_OMAP;
 	up->port.iotype = UPIO_MEM;
-	up->port.irq = irq->start;
 
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
