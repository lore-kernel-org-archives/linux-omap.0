From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Thu, 23 Apr 2015 07:39:53 -0700
Message-ID: <20150423143952.GR18048@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
 <5538D3B6.7060305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5538D3B6.7060305@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150423 04:13]:
> On 04/21/2015 07:08 PM, Tony Lindgren wrote:
> > @@ -438,11 +447,30 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
> >   		writel_relaxed(ctrl, reg);
> >   		bank->context.ctrl = ctrl;
> >   	}
> > +
> > +	if (is_irq) {
> > +		omap_set_gpio_direction(bank, offset, 1);
> > +		bank->irq_usage |= BIT(offset);
> > +	} else {
> > +		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> > +		bank->mod_usage |= BIT(offset);
> > +	}
> 
> The OMAP GPIO driver implements two Core interfaces IRQ-chip and GPIO-chip which, in general,
> more or less independent. 
> 
> So, I don't think, that it's good to mix GPIO-IRQ-chip specific code with GPIO-chip code.
> And this even don't really correspond the purpose of omap_enable_gpio_module() :( and might
> introduce misunderstanding of code. The worst thing is that future fixes in IRQ-chip may 
> affect on on GPIO-chip and vise versa :(

Hmm I'm thinking omap_enable/disable_gpio_module() eventually becomes
our runtime_resume/suspend(). Currently the enabling and disabling is
buggy for GPIO for some corner cases.. AFAIK the only difference between
enabling GPIO vs GPIO-IRQ is the calling of omap_set_gpio_direction
vs omap_set_gpio_triggering. Or at least that's the way it should be
unless I'm missing something?
 
> Could we keep omap_xxx_gpio_module() functions responsible only for GPIO bank PM and
> enabling/disabling?

If you're thinking about just thinking about having separate wrappers around
it like this::

static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
					bool is_irq)
{
	...
}

static void omap_enable_gpio((struct gpio_bank *bank, unsigned offset)
{
	omap_enable_gpio_module(bpio_bank, offset, 0);
}

static void omap_enable_gpio_irq((struct gpio_bank *bank, unsigned offset)
{
	omap_enable_gpio_module(bpio_bank, offset, 1);
}

Then yes makes sense to me. Or do you have something else in mind?

Regards,

Tony
