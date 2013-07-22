From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] pinctrl: single: Add hardware specific hooks for IRQ
 and GPIO wake-up events
Date: Mon, 22 Jul 2013 23:44:22 +0200
Message-ID: <CACRpkdZNGHRJX3_HRCAfKgrRGLMVbqNzFBfu7wP-3YrhOUESkw@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
	<20130607205040.16513.36794.stgit@localhost>
	<CAN1soZznJ1YxWhaFZ4rhQx+uk3aCigAcVeuLpOU+3oPzmfXF6w@mail.gmail.com>
	<20130610153637.GK8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33413 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517Ab3GVVoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 17:44:23 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so9570524oag.41
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 14:44:22 -0700 (PDT)
In-Reply-To: <20130610153637.GK8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Mon, Jun 10, 2013 at 5:36 PM, Tony Lindgren <tony@atomide.com> wrote:

> At least on omaps, each board typically has at least one device
> configured as wake-up capable from deeper idle modes. In the
> deeper idle modes the normal interrupt wake-up path won't work
> as the logic is powered off and separate wake-up hardware is
> available either via IO ring or GPIO hardware.

What I do not understand is why the irq_set_wake() should
not fall through to that IO ring / GPIO hardware.

For example: a composite GPIO+irqchip driver should surely
set the wake up for a certain line for irq_set_wake()?

> The wake-up
> event can be device specific, or may need to be dynamically
> remuxed to GPIO input for wake-up events. When the wake-up
> event happens, it's IRQ need to be called so the device won't
> lose interrupts.

I recognize this hardware type. The name I use for these
things are "latent interrupts".

What I think is that they should maybe be modeled as
irqchip from end to end, so that we don't orthogonally use
any pinctrl states to set this up.

> Allow supporting IRQ and GPIO wake-up events if a hardware
> spefific module is registered for the enable and disable

s/spefific/specific

> calls.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
(...)
> +- interrrupts : the interrupt that a function may have for a wake-up event

interrupts

> +
> +- gpios: the gpio that a function may have for a wake-up event

Is this a GPIO property or a pin property?

"wake up" is not supported by the GPIO subsystem is it?
Not in <linux/gpio.h> atleast.

This smells like shoehorning pin config stuff into the GPIO
subsystem again which is a no-no :-)

> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> @@ -1183,6 +1241,24 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
>         } else {
>                 *num_maps = 1;
>         }
> +
> +       if (pcs->flags & PCS_HAS_FUNCTION_IRQ)
> +               function->irq = irq_of_parse_and_map(np, 0);
> +
> +       if (pcs->flags & PCS_HAS_FUNCTION_GPIO) {
> +               function->gpio = of_get_gpio(np, 0);
> +               if (function->gpio > 0 && !function->irq) {
> +                       if (gpio_is_valid(function->gpio))
> +                               function->irq = gpio_to_irq(function->gpio);
> +               }
> +       }
> +
> +       if (function->irq > 0 && pcs->soc && pcs->soc->reg_init) {
> +               res = pcs_parse_wakeup(pcs, np, function);
> +               if (res)
> +                       goto free_pingroups;
> +       }

So this thing here. Instead of introducing a cross reference to the
IRQ and GPIO here and

> + * @irq:       optional irq specified for wake-up for example
> + * @gpio:      optional gpio specified for wake-up for example
> + * @node:      optional list
> + */
> +struct pcs_reg {
> +       unsigned (*read)(void __iomem *reg);
> +       void (*write)(unsigned val, void __iomem *reg);
> +       void __iomem *reg;
> +       unsigned val;
> +       int irq;
> +       int gpio;
> +       struct list_head node;
> +};
> +
> +#define PCS_HAS_FUNCTION_GPIO   (1 << 2)
> +#define PCS_HAS_FUNCTION_IRQ    (1 << 1)
>  #define PCS_HAS_PINCONF         (1 << 0)
>
>  /**
>   * struct pcs_soc - SoC specific interface to pinctrl-single
>   * @data:      SoC specific data pointer
>   * @flags:     mask of PCS_HAS_xxx values
> + * @reg_init:  SoC specific register init function
> + * @enable:    SoC specific enable function
> + * @disable:   SoC specific disable function
>   */
>  struct pcs_soc {
>         void *data;
>         unsigned flags;
> +       int (*reg_init)(const struct pcs_soc *soc, struct pcs_reg *r);
> +       int (*enable)(const struct pcs_soc *soc, struct pcs_reg *r);
> +       void (*disable)(const struct pcs_soc *soc, struct pcs_reg *r);

Then these quirks and sub-modules ...

Why can't the irqchip/GPIO driver call down to this driver
instead?

Yours,
Linus Walleij
