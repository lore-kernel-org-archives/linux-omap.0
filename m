From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Add support for optional wake-up
 interrupt
Date: Fri, 18 Oct 2013 09:37:40 -0700
Message-ID: <20131018163740.GP15154@atomide.com>
References: <20131017232820.GG15154@atomide.com>
 <20131018161916.GF18921@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131018161916.GF18921@gimli>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/gpio.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/platform_data/serial-omap.h>
> > @@ -134,7 +135,7 @@ struct uart_omap_port {
> >  	struct uart_port	port;
> >  	struct uart_omap_dma	uart_dma;
> >  	struct device		*dev;
> > -
> > +	int			irqs[2];
> >  	unsigned char		ier;
> >  	unsigned char		lcr;
> >  	unsigned char		mcr;
> > @@ -176,6 +177,8 @@ struct uart_omap_port {
> >  };
> >  
> >  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> > +#define omap_uartirq		(up->irqs[0])
> > +#define omap_wakeirq		(up->irqs[1])
> >  
> >  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
> >  
> > @@ -214,10 +217,23 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
> >  	return pdata->get_context_loss_count(up->dev);
> >  }
> >  
> > +static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
> > +				       bool enable)
> > +{
> > +	if (!omap_wakeirq)
> > +		return;
> 
> can we drop the pointless obfuscation ?

Hmm care to specify what exactly you have in mind here? The wakeirq
is optional so we need to check for it.

Do you mean get rid of serial_omap_enable_wakeirq() or get rid of
the defines for omap_uartirq and omap_wakeirq?

> > @@ -689,15 +705,25 @@ static int serial_omap_startup(struct uart_port *port)
> >  {
> >  	struct uart_omap_port *up = to_uart_omap_port(port);
> >  	unsigned long flags = 0;
> > -	int retval;
> > +	int i, retval;
> >  
> >  	/*
> > -	 * Allocate the IRQ
> > +	 * Allocate the IRQs, the second IRQ is the optional wakeirq
> >  	 */
> > -	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
> > -				up->name, up);
> > -	if (retval)
> > -		return retval;
> > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++) {
> > +		if (i == 1 && !omap_wakeirq) {
> > +			dev_info(up->port.dev, "no wakeirq for uart%d\n",
> > +				 up->port.line);
> > +			break;
> > +		}
> > +		retval = devm_request_irq(up->port.dev, up->irqs[i],
> > +					  serial_omap_irq, up->port.irqflags,
> > +					  up->name, up);
> 
> conversion to devm_* should be done as another patch, it seems.

OK, I'll separate the devm_* changes from this patch. It's seems
that we're currently mostly devm_*, so let's do that first.
 
> > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
> >  
> >  	pm_runtime_mark_last_busy(up->dev);
> >  	pm_runtime_put_autosuspend(up->dev);
> > -	free_irq(up->port.irq, up);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> > +		if (up->irqs[i])
> > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> 
> do you need this at all if you're using devm_* ?

So it seems, startup and shutdown are managed by serial_core and
that's what at least clps711x.c serial driver is doing.

Regards,

Tony
