From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Mon, 4 May 2015 08:38:31 -0700
Message-ID: <20150504153830.GG24469@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
 <5538D3B6.7060305@linaro.org>
 <20150423143952.GR18048@atomide.com>
 <55400243.4040504@linaro.org>
 <20150429142626.GA10572@atomide.com>
 <55427E3B.2090408@linaro.org>
 <20150430211254.GC24469@atomide.com>
 <5544FB09.5020604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48957 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbbEDPif (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 11:38:35 -0400
Content-Disposition: inline
In-Reply-To: <5544FB09.5020604@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>

* Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150502 09:29]:
> Hi Tony,
> 
> On 05/01/2015 12:12 AM, Tony Lindgren wrote:
> > * Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150430 12:12]:
> >> On 04/29/2015 05:26 PM, Tony Lindgren wrote:
> >>>
> >>> In general removing 30 lines of duplicate code to fix freeing
> >>> of resources makes sense :) I'd rather do that than add more similar
> >>> code to fix it for sure. That will make further changes easier too.
> >>
> >> Unfortunately I'm not sure ( at least not for this driver.
> >> Future fixes most probably will eat all these removed lines and
> >> will just add anther "if else" but in different places (see description or corner case below).
> >>
> >> In my opinion, It might be better to review each interface function first as for GPIO chip
> >> as for GPIOIRQ chip and ensure that they are doing exactly what need to be done
> >> (as part this job - get rid of over-optimized functions like omap_reset_gpio or
> >> omap_gpio_init_irq). And after that do further optimization.
> > 
> > In general I agree that a minimal fix is preferred. Unfortunately in
> > this case "fixing" it gets us deeper into the mess with BANK_USED :)
> >   
> >> --- a/drivers/gpio/gpio-omap.c
> >> +++ b/drivers/gpio/gpio-omap.c
> >> @@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
> >>          unsigned long flags;
> >>          unsigned offset = d->hwirq;
> >>   
> >> -       if (!BANK_USED(bank))
> >> -               pm_runtime_get_sync(bank->dev);
> >> -
> >>          if (type & ~IRQ_TYPE_SENSE_MASK)
> >>                  return -EINVAL;
> >>   
> >> @@ -498,13 +495,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
> >>                  (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
> >>                  return -EINVAL;
> >>   
> >> +       if (!BANK_USED(bank))
> >> +               pm_runtime_get_sync(bank->dev);
> >> +
> >>          spin_lock_irqsave(&bank->lock, flags);
> >>          retval = omap_set_gpio_triggering(bank, offset, type);
> >> -       omap_gpio_init_irq(bank, offset);
> >> -       if (!omap_gpio_is_input(bank, offset)) {
> >> -               spin_unlock_irqrestore(&bank->lock, flags);
> >> -               return -EINVAL;
> >> -       }
> >>          spin_unlock_irqrestore(&bank->lock, flags);
> >>   
> >>          if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> >> @@ -512,6 +507,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
> >>          else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> >>                  __irq_set_handler_locked(d->irq, handle_edge_irq);
> >>   
> >> +       if (!BANK_USED(bank))
> >> +               pm_runtime_put(bank->dev);
> >> +
> >>          return retval;
> >>   }
> > 
> > Hmm I don't think we can remove the call to omap_gpio_init_irq as with
> > request_irq there's nothing ensuring the GPIO line is configured in
> > the device tree case for example?
> > 
> > And then removing the check for omap_gpio_is_input is not good.. We
> > should just call omap_set_gpio_direction to set it to input instead
> > like I'm doing.
> 
> I think, We can remove all these calls from omap_gpio_irq_type() because
> the following call sequence is executed when IRQ is requested:
> 
>  request_threaded_irq() - or - __irq_set_handler(is_chained==true)
>  __setup_irq()
>  irq_startup()
>  desc->irq_data.chip->irq_startup()
>  omap_gpio_irq_startup()
>    omap_gpio_init_irq()
>    omap_gpio_unmask_irq()
> 
> The check for omap_gpio_is_input should be done in startup omap_gpio_irq_startup()
> in case if GPIO was requested before, and if not - GPIO should be configured as input.
> (we just need to continue reviewing process as for me)

Oh OK. Yes it seems that with omap_gpio_irq_startup we can now
remove the omap_enable_gpio_module and omap_set_gpio_direction
calls from omap_gpio_irq_type.

> > And looking at it more, omap_set_gpio_triggering can fail so we should
> > check the return value (also with my patch). And if that fails, then we
> > currently need a flag to keep track if we enabled the bank in
> > omap_gpio_irq_type or not.. So piling up yet more BANK_USED tinkering.
> > 
> > I still think we're better of just removing it all. Below is my patch
> > updated with the omap_set_gpio_triggering error handling. We can just
> > make omap_enable_gpio_module return a value, it might provide us with
> > more info where things go wrong :)
> > 
> >> There is another corner case :) - easy to reproduce
> >> and it's present in old code.
> >>
> >> GPIOn is used as IRQ by some dev:
> >> - in my case PCF8575.INT ->  gpio6.11
> >> - PCFx driver knows nothing about type of IRQ line (GPIO or not)
> >>    so it doesn't request gpio and just do request_irq()
> >>
> >> If I'll export gpio6.11 through sysfs and then unxeport it
> >> then IRQs from PCFx will not be received any more.
> >>
> >> Seems omap_reset_gpio has to be split for GPIO and GPIO-IRQ cases.
> > 
> > OK, that sounds like a separate fix though if I understand your
> > right. We should not allow exporting GPIOs to sysfs if they are
> > being used.
> 
> Why not? It's good for IRQ debugging at least, but changing of GPIO
> direction should be prohibited.

Well the sysfs interface should behave in a consistent way both for
GPIOs and interrupts. I believe reserved GPIOs are not exported to
sysfs at all currently. I don't have a problem making them read-only
though.

Regards,

Tony
