From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/3] tty: serial: 8250 introduce mctrl_gpio helpers
Date: Fri, 28 Jul 2017 13:36:46 +0300
Message-ID: <1501238206.29303.277.camel@linux.intel.com>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
         <20170728064004.GI10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170728064004.GI10026-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2017-07-27 at 23:40 -0700, Tony Lindgren wrote:
> * yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170727
> 06:18]:
> > From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > 
> > This patch series aims to reintroduce the  mctrl_gpio helpers for
> > 8250
> > UARTs.
> > 
> > There are some UARTs that use GPIO signals as a wakeup-sourse.
> > The first patch addresses this issue and tries to destinguish GPIO
> > usage
> > via searching for "wakeup-sourse" property. Though it must be
> > decided whether
> > this property is secure to use for this purpose.
> 
> The wakeup-source part you should be able to handle pretty much
> out of box with Linux generic wakeirqs if configured. See for example
> drivers/i2c/i2c-core.c for the dev_pm_set_dedicated_wake_irq() part.

Here are 3 cases:
1) out-of-band interrupt (usually GPIO) which can be wake source;
2) in-band interrupt (have not seen this for UART, though it's supported
by tty framework for a long time AFAIU);
3) special case when Out-of-band interrupt uses the pin in UART pool of
pins.

We are talking here about case 3).

> As long as the 8250 driver has runtime PM implemented

As you remember it has not (the ugly hack which is used right now is not
correct implementation of RPM).

>  it will wake
> up the 8250 device.

See above, in case 3) we would be able to achieve that when pin mode is
switched to GPIO and back. I don't remember if OMAP uses this approach.

> This should work just fine also with am335x gpios, just configure the
> secondary wakeup gpio interrupt using interrupts-extended in device
> tree. Typically the interrupts are named "irq" and "wakeup". And if
> the
> pin is used as gpio, you can just dev_pm_clear_wake_irq() during
> runtime.

I think this one is not related to case 3).

> If having issues, we're still missing the wakeirq level configuration,
> the patch below should do the trick there.

>  	err = request_threaded_irq(irq, NULL,
> handle_threaded_wake_irq,
> -				   IRQF_ONESHOT, dev_name(dev),
> wirq);
> +				   irq_get_trigger_type(irq) |
> IRQF_ONESHOT,

This is not needed if you use DT or ACPI and framework (serial in this
case) checks for interrupt correctly.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
