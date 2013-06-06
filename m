From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Thu, 6 Jun 2013 08:53:41 -0700
Message-ID: <20130606155341.GL3331@atomide.com>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
 <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com>
 <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50204 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751353Ab3FFPx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 11:53:56 -0400
Content-Disposition: inline
In-Reply-To: <20130605223355.EDC113E10E4@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>

* Grant Likely <grant.likely@secretlab.ca> [130605 15:39]:
> On Mon, 20 May 2013 10:46:21 -0700, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [130516 14:50]:
> > > * Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
> > > > On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
> > > > > * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
> > > > > > I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
> > > > > > 
> > > > > > [    2.264221] retu-mfd 2-0001: Retu v3.2 found
> > > > > > [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
> > > > > > [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
> > > > > > 
> > > > > > The error is coming from regmap code. According to git bisect, it is
> > > > > > caused by:
> > > > > > 
> > > > > > 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
> > > > > > 	Author: Jon Hunter <jon-hunter@ti.com>
> > > > > > 	Date:   Fri Mar 1 11:22:47 2013 -0600
> > > > > > 
> > > > > > 	    gpio/omap: convert gpio irq domain to linear mapping
> > > > > > 
> > > > > > The commit does not anymore revert cleanly, and I haven't yet tried
> > > > > > crafting a manual revert, so any fix proposals/ideas are welcome...
> > > > > 
> > > > > Hmm this might be a bit trickier to fix. Obviously the real solution
> > > > > is to convert omap1 to SPARSE_IRQ like we did for omap2+.
> > > > > 
> > > > > For the -rc cycle, it might be possible to fix this by adding a
> > > > > different irq_to_gpio() and gpio_to_irq() functions for omap1.
> > > > 
> > > > The commit reverts cleanly if we also revert
> > > > 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
> > > > service routine), which seems to be just some minor optimization. The
> > > > result is below, and with it 770 works again.
> > > 
> > > Hmm in this case it seems that we should just fix it rather than go back
> > > to the old code, so let's take a look at that first.
> > 
> > Does the following fix it for you or do we need to fix something else
> > there too?
> > 
> 
> Hi Tony,
> 
> Do you want me to apply this fix? It sounds like it solves the symptoms,
> but I'd like to know more about what the root cause is.
> 
> Send me your s-o-b line and I'll apply the patch

Yes sorry was meaning to send it as a proper patch, but got distracted.
Please go ahead and apply it thanks:

Signed-off-by: Tony Lindgren <tony@atomide.com>

 
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1094,6 +1094,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
> >  	const struct omap_gpio_platform_data *pdata;
> >  	struct resource *res;
> >  	struct gpio_bank *bank;
> > +	int irq_base;
> >  
> >  	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
> >  
> > @@ -1135,11 +1136,23 @@ static int omap_gpio_probe(struct platform_device *pdev)
> >  				pdata->get_context_loss_count;
> >  	}
> >  
> > -
> > -	bank->domain = irq_domain_add_linear(node, bank->width,
> > -					     &irq_domain_simple_ops, NULL);
> > -	if (!bank->domain)
> > +	/*
> > +	 * REVISIT: Once we have omap1 supporting  SPARSE_IRQ, we can drop
> > +	 * irq_alloc_descs() and irq_domain_add_legacy() and just do:
> > +	 *
> > +	 * bank->domain = irq_domain_add_linear(node, bank->width,
> > +	 *				     &irq_domain_simple_ops, NULL);
> > +	 * if (!bank->domain)
> > +	 *	return -ENODEV;
> > +	 */
> > +	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
> > +	if (irq_base < 0) {
> > +		dev_err(dev, "Couldn't allocate IRQ numbers\n");
> >  		return -ENODEV;
> > +	}
> > +
> > +	bank->domain = irq_domain_add_legacy(node, bank->width, irq_base,
> > +					     0, &irq_domain_simple_ops, NULL);
> >  
> >  	if (bank->regs->set_dataout && bank->regs->clr_dataout)
> >  		bank->set_dataout = _set_gpio_dataout_reg;
> 
> -- 
> Grant Likely, B.Sc, P.Eng.
> Secret Lab Technologies, Ltd.
