From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] serial: omap: Add support for optional wake-up
Date: Thu, 24 Oct 2013 11:33:00 +0100
Message-ID: <20131024103300.6023FC4039D@trevor.secretlab.ca>
References: <20131022134947.GK15154@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:60847 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab3JXKdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 06:33:07 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so768515bkb.1
        for <linux-omap@vger.kernel.org>; Thu, 24 Oct 2013 03:33:05 -0700 (PDT)
In-Reply-To: <20131022134947.GK15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On Tue, 22 Oct 2013 06:49:48 -0700, Tony Lindgren <tony@atomide.com> wrote:
> With the recent pinctrl-single changes, omaps can treat
> wake-up events from deeper idle states as interrupts.
> 
> There's a separate "io chain" controller on most omaps
> that stays enabled when the device hits off-idle and the
> regular interrupt controller is powered off.
> 
> Let's add support for the optional second interrupt for
> wake-up events. And then serial-omap can manage the
> wake-up interrupt from it's runtime PM calls to avoid
> spurious interrupts during runtime.
> 
> Note that the wake interrupt is board specific as it
> uses the UART RX pin, and for omap3, there are six pin
> options for UART3 RX pin.
> 
> Also Note that the legacy platform based booting handles
> the wake-ups in the legacy mux driver and does not need to
> pass the wake-up interrupt to the driver.
> 
> And finally, to pass the wake-up interrupt in the dts file,
> either interrupt-map or the pending interrupts-extended
> property needs to be passed. It's probably best to use
> interrupts-extended when it's available.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Updated to simplify based on the review comments.
> 
> Greg, care to queue this for v3.13 if not too late?
> 
> This removes a dependency for omaps for having runtime
> PM working with serial port using device tree, so we
> can start moving to device tree only booting for omap3
> for v3.14.
> 
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -39,6 +39,7 @@
>  #include <linux/irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_data/serial-omap.h>
> @@ -134,6 +135,7 @@ struct uart_omap_port {
>  	struct uart_port	port;
>  	struct uart_omap_dma	uart_dma;
>  	struct device		*dev;
> +	int			wakeirq;
>  
>  	unsigned char		ier;
>  	unsigned char		lcr;
> @@ -214,10 +216,23 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
>  	return pdata->get_context_loss_count(up->dev);
>  }
>  
> +static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
> +				       bool enable)
> +{
> +	if (!up->wakeirq)
> +		return;
> +
> +	if (enable)
> +		enable_irq(up->wakeirq);
> +	else
> +		disable_irq(up->wakeirq);
> +}
> +
>  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
>  {
>  	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
>  
> +	serial_omap_enable_wakeirq(up, enable);
>  	if (!pdata || !pdata->enable_wakeup)
>  		return;
>  
> @@ -699,6 +714,20 @@ static int serial_omap_startup(struct uart_port *port)
>  	if (retval)
>  		return retval;
>  
> +	/* Optional wake-up IRQ */
> +	if (up->wakeirq) {
> +		retval = request_irq(up->wakeirq, serial_omap_irq,
> +				     up->port.irqflags, up->name, up);
> +		if (retval) {
> +			free_irq(up->port.irq, up);
> +			return retval;
> +		}
> +		disable_irq(up->wakeirq);
> +	} else {
> +		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +			 up->port.line);
> +	}
> +
>  	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
>  
>  	pm_runtime_get_sync(up->dev);
> @@ -787,6 +816,8 @@ static void serial_omap_shutdown(struct uart_port *port)
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  	free_irq(up->port.irq, up);
> +	if (up->wakeirq)
> +		free_irq(up->wakeirq, up);
>  }
>  
>  static void serial_omap_uart_qos_work(struct work_struct *work)
> @@ -1572,11 +1603,23 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	struct uart_omap_port	*up;
>  	struct resource		*mem, *irq;
>  	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
> -	int ret;
> +	int ret, uartirq = 0, wakeirq = 0;
>  
> +	/* The optional wakeirq may be specified in the board dts file */
>  	if (pdev->dev.of_node) {
> +		uartirq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +		if (!uartirq)
> +			return -EPROBE_DEFER;
> +		wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
>  		omap_up_info = of_get_uart_port_info(&pdev->dev);
>  		pdev->dev.platform_data = omap_up_info;
> +	} else {
> +		irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +		if (!irq) {
> +			dev_err(&pdev->dev, "no irq resource?\n");
> +			return -ENODEV;
> +		}
> +		uartirq = irq->start;

Ugh. This is such a hack. platform_get_irq() should just work for DT and
non-DT. There is no way around it right now, but we need to get the code
in place to resolve IRQs late so that drivers don't need these special
cases.

g.
