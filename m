From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
Date: Fri, 7 Sep 2012 10:28:09 -0700
Message-ID: <20120907172809.GB1303@atomide.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
 <331ABD5ECB02734CA317220B2BBEABC13EA291F9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2IGR2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 13:28:14 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA291F9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

* AnilKumar, Chimata <anilkumar@ti.com> [120906 20:27]:
> Hi Tony,
> 
> On Fri, Sep 07, 2012 at 00:28:32, Tony Lindgren wrote:
> > Request pins using pinctrl framework. Only show a warning
> > on error as some boards set the pins in the bootloader
> > even if CONFIG_PINCTRL is enabled.
> > 
> > Cc: linux-serial@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
> >  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> > index 1a52725..0f4de14 100644
> > --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> > +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> > @@ -106,6 +106,7 @@ struct uart_omap_port {
> >  	struct uart_port	port;
> >  	struct uart_omap_dma	uart_dma;
> >  	struct platform_device	*pdev;
> > +	struct pinctrl		*pins;
> >  
> >  	unsigned char		ier;
> >  	unsigned char		lcr;
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index d3cda0c..068e88c 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> >  
> >  #include <plat/dma.h>
> >  #include <plat/dmtimer.h>
> > @@ -1492,6 +1493,13 @@ static int serial_omap_probe(struct platform_device *pdev)
> >  		goto err_port_line;
> >  	}
> >  
> > +	up->pins = pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(up->pins)) {
> > +		dev_warn(&pdev->dev, "did not get pins for uart%i error: %li\n",
> > +			 up->port.line, PTR_ERR(up->pins));
> > +		up->pins = NULL;
> > +	}
> > +
> >  	sprintf(up->name, "OMAP UART%d", up->port.line);
> >  	up->port.mapbase = mem->start;
> >  	up->port.membase = devm_ioremap(&pdev->dev, mem->start,
> > @@ -1570,6 +1578,8 @@ static int serial_omap_remove(struct platform_device *dev)
> >  		pm_runtime_disable(&up->pdev->dev);
> >  		uart_remove_one_port(&serial_omap_reg, &up->port);
> >  		pm_qos_remove_request(&up->pm_qos_request);
> > +		if (up->pins)
> > +			pinctrl_put(up->pins);
> 
> I think this can be removed if we use devm_pinctrl_get_select_default()
> above.

Yeah will do, I was initially thinking that would cause issues remuxing
pins back to safe mode on unload, but we can still do that in
serial_omap_remove().

Regards,

Tony
