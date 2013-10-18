From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Add support for optional wake-up
 interrupt
Date: Fri, 18 Oct 2013 15:56:07 -0700
Message-ID: <20131018225606.GT15154@atomide.com>
References: <20131017232820.GG15154@atomide.com>
 <20131018161916.GF18921@gimli>
 <20131018163740.GP15154@atomide.com>
 <20131018164535.GQ15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131018164535.GQ15154@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131018 09:45]:
> * Tony Lindgren <tony@atomide.com> [131018 09:38]:
> > * Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > > > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
> > > >  
> > > >  	pm_runtime_mark_last_busy(up->dev);
> > > >  	pm_runtime_put_autosuspend(up->dev);
> > > > -	free_irq(up->port.irq, up);
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> > > > +		if (up->irqs[i])
> > > > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> > > 
> > > do you need this at all if you're using devm_* ?
> > 
> > So it seems, startup and shutdown are managed by serial_core and
> > that's what at least clps711x.c serial driver is doing.
> 
> And that means devm_* in this case does not really help us
> here..
> 
> I guess we could keep the IRQ requested from probe, but
> there's probably a reason why it's done in startup/shutdown.
> 
> So I'll just drop the devm_* changes for now.

Here's an updated simplified version. I also got rid of the
for loops as the wake-up interrupt is optional and it made the
code a bit of a pain to read.

Regards,

Tony


8< ----------------------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 16 Oct 2013 10:27:28 -0700
Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt

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
@@ -134,6 +135,7 @@ struct uart_omap_port {
 	struct uart_port	port;
 	struct uart_omap_dma	uart_dma;
 	struct device		*dev;
+	int			wakeirq;
 
 	unsigned char		ier;
 	unsigned char		lcr;
@@ -214,10 +216,23 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
+static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
+				       bool enable)
+{
+	if (!up->wakeirq)
+		return;
+
+	if (enable)
+		enable_irq(up->wakeirq);
+	else
+		disable_irq(up->wakeirq);
+}
+
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
+	serial_omap_enable_wakeirq(up, enable);
 	if (!pdata || !pdata->enable_wakeup)
 		return;
 
@@ -699,6 +714,20 @@ static int serial_omap_startup(struct uart_port *port)
 	if (retval)
 		return retval;
 
+	/* Optional wake-up IRQ */
+	if (up->wakeirq) {
+		retval = request_irq(up->wakeirq, serial_omap_irq,
+				     up->port.irqflags, up->name, up);
+		if (retval) {
+			free_irq(up->port.irq, up);
+			return retval;
+		}
+		disable_irq(up->wakeirq);
+	} else {
+		dev_info(up->port.dev, "no wakeirq for uart%d\n",
+			 up->port.line);
+	}
+
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
 	pm_runtime_get_sync(up->dev);
@@ -787,6 +816,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	free_irq(up->port.irq, up);
+	if (up->wakeirq)
+		free_irq(up->wakeirq, up);
 }
 
 static void serial_omap_uart_qos_work(struct work_struct *work)
@@ -1572,11 +1603,23 @@ static int serial_omap_probe(struct platform_device *pdev)
 	struct uart_omap_port	*up;
 	struct resource		*mem, *irq;
 	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
-	int ret;
+	int ret, uartirq = 0, wakeirq = 0;
 
+	/* The optional wakeirq may be specified in the board dts file */
 	if (pdev->dev.of_node) {
+		uartirq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+		if (!uartirq)
+			return -EPROBE_DEFER;
+		wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
 		omap_up_info = of_get_uart_port_info(&pdev->dev);
 		pdev->dev.platform_data = omap_up_info;
+	} else {
+		irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (!irq) {
+			dev_err(&pdev->dev, "no irq resource?\n");
+			return -ENODEV;
+		}
+		uartirq = irq->start;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1585,12 +1628,6 @@ static int serial_omap_probe(struct platform_device *pdev)
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
@@ -1624,7 +1661,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.dev = &pdev->dev;
 	up->port.type = PORT_OMAP;
 	up->port.iotype = UPIO_MEM;
-	up->port.irq = irq->start;
+	up->port.irq = uartirq;
+	up->wakeirq = wakeirq;
 
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
