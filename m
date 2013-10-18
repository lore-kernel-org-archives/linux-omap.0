From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Add support for optional wake-up
 interrupt
Date: Fri, 18 Oct 2013 09:45:35 -0700
Message-ID: <20131018164535.GQ15154@atomide.com>
References: <20131017232820.GG15154@atomide.com>
 <20131018161916.GF18921@gimli>
 <20131018163740.GP15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47312 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753043Ab3JRQpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 12:45:40 -0400
Content-Disposition: inline
In-Reply-To: <20131018163740.GP15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [131018 09:38]:
> * Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
> > >  
> > >  	pm_runtime_mark_last_busy(up->dev);
> > >  	pm_runtime_put_autosuspend(up->dev);
> > > -	free_irq(up->port.irq, up);
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> > > +		if (up->irqs[i])
> > > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> > 
> > do you need this at all if you're using devm_* ?
> 
> So it seems, startup and shutdown are managed by serial_core and
> that's what at least clps711x.c serial driver is doing.

And that means devm_* in this case does not really help us
here..

I guess we could keep the IRQ requested from probe, but
there's probably a reason why it's done in startup/shutdown.

So I'll just drop the devm_* changes for now.

Regards,

Tony
