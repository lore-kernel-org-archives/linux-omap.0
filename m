From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] tty: serial: omap: increase max consoles to 10
Date: Wed, 22 Oct 2014 07:24:37 -0500
Message-ID: <20141022122437.GA9548@kahuna>
References: <1413908616-843-1-git-send-email-nm@ti.com>
 <544764D8.8050804@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865AbaJVMZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2014 08:25:15 -0400
Content-Disposition: inline
In-Reply-To: <544764D8.8050804@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Franklin Cooper Jr." <fcooper@ti.com>

On 10:03-20141022, Sebastian Andrzej Siewior wrote:
> On 10/21/2014 06:23 PM, Nishanth Menon wrote:
> > 
> > The final solution is to transition off to use 8250 driver and no
> > dependency on console structures and move away from omap-serial driver,
> > hence no major cleanups are done for this driver.
> 
> So the shiny new driver works for you, is this what you are saying?

We have to complete our transition over to the new driver to see if we
have any behavior change. We will eventually get there.

> 
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index 18c30ca..4f9cbb6 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -46,7 +46,7 @@
> >  
> >  #include <dt-bindings/gpio/gpio.h>
> >  
> > -#define OMAP_MAX_HSUART_PORTS	6
> > +#define OMAP_MAX_HSUART_PORTS	10
> >  
> >  #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
> 
> Please also add a check in the probe code that "up->port.line" does not
> exceed OMAP_MAX_HSUART_PORTS again. So we leave the probe function with
> an error code instead.

Thanks. yeah - that is a pretty good idea. Will do the same for v2.

-- 
Regards,
Nishanth Menon
