From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] v4.4-rc1 GPIO regression on OMAP1
Date: Thu, 19 Nov 2015 23:02:34 +0200
Message-ID: <20151119210234.GF18138@blackmetal.musicnaut.iki.fi>
References: <20151117214212.GB18138@blackmetal.musicnaut.iki.fi>
 <564C75FE.5000303@ti.com>
 <20151118183106.GC18138@blackmetal.musicnaut.iki.fi>
 <564DB931.8090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564DB931.8090904@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Nov 19, 2015 at 01:57:37PM +0200, Grygorii Strashko wrote:
> On 11/18/2015 08:31 PM, Aaro Koskinen wrote:
> > On Wed, Nov 18, 2015 at 02:58:38PM +0200, Grygorii Strashko wrote:
> >> On 11/17/2015 11:42 PM, Aaro Koskinen wrote:
> >>> Amstrad E3 computer (OMAP1) boot crashes early with v4.4-rc1. Bisected to:
> >>>
> >>> 	450fa54cfd66e3dda6eda26256637ee8928af12a is the first bad commit
> >>> 	commit 450fa54cfd66e3dda6eda26256637ee8928af12a
> >>> 	Author: Grygorii Strashko <grygorii.strashko@ti.com>
> >>> 	Date:   Fri Sep 25 12:28:03 2015 -0700
> >>> 	
> >>> 	    gpio: omap: convert to use generic irq handler
> >>
> >> Could you check pls if below change will solve this issue, pls?
> >>
> >> iff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >> index 56d2d02..2905e0d 100644
> >> --- a/drivers/gpio/gpio-omap.c
> >> +++ b/drivers/gpio/gpio-omap.c
> >> @@ -1129,7 +1129,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank,
> >> struct irq_chip *irqc)
> >>          }
> >>
> >>          ret = gpiochip_irqchip_add(&bank->chip, irqc,
> >> -                                  irq_base, handle_bad_irq,
> >> +                                  irq_base, handle_simple_irq,
> >>                                     IRQ_TYPE_NONE);
> > 
> 
> Thanks for testing it. But I'd like to ask you for more help here if possible :)
> Above change is expected to fix the OMAP1 boot, but looking at the OMAP GPIO code
> I think that MPUIO IRQ are not working :( and this functionality has been broken 
> long time ago - commit "gpio: omap: convert to use generic irq handler" has just 
> made hidden issue visible.
> (I've found only one OMAP1 board which uses MPUIO GPIO as IRQ (board-osk.c)).
> 
> So, could I ask you to test another change instead of previous one?
> 
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1122,8 +1122,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>         /* MPUIO is a bit different, reading IRQ status clears it */
>         if (bank->is_mpuio) {
>                 irqc->irq_ack = dummy_irq_chip.irq_ack;
> -               irqc->irq_mask = irq_gc_mask_set_bit;
> -               irqc->irq_unmask = irq_gc_mask_clr_bit;
>                 if (!bank->regs->wkup_en)
>                         irqc->irq_set_wake = NULL;
>         }

This fixes the boot crash issue as well...

> In my opinion real test will be
> - request(any MPUIO GPIO IRQ, IRQF_TRIGGER_LOW/HIGH), 
> - trigger MPUIO GPIO IRQ
> - free(MPUIO GPIO IRQ)

...but I don't think I can cover that with my boards (E3/770)?

Anyone willing to donate a 5912 OSK?

A.
