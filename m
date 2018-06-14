From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/10] ARM: OMAP1: ams-delta FIQ: don't use static GPIO numbers
Date: Thu, 14 Jun 2018 10:45:57 +0200
Message-ID: <CACRpkdZj0c+pY7u63SDcUK_i7pPQDkgCgsm2cc37H2uHjZjDFw@mail.gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-6-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180609140224.32606-6-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 9, 2018 at 4:02 PM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> With introduction of GPIO lookup tables to Amstrad Delta board init
> file, semantics of symbols representing OMAP GPIO pins defined in
> <mach/board-ams-delta.h> changed from statically assigned global GPIO
> numbers to hardware pin numbers local to OMAP "gpio-0-15" chip.
>
> This patch modifies deferred FIQ interrupt handler so it no longer uses
> static GPIO numbers in favour of IRQ data descriptors obtained at FIQ
> initialization time from descriptor of the GPIO chip with use of its
> hardware pin numbers.  The chip descriptor is passed from the board
> init file.
>
> As a benefit, the deferred FIQ handler should work faster.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Making the kernel a better place, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +/*
> + * Some drivers may not use GPIO lookup tables but need to be provided
> + * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
> + * drivers may even not use GPIO layer but expect just IRQ numbers.
> + * We could either define GPIO lookup tables then use them on behalf
> + * of those devices, or we can use GPIO driver level methods for
> + * identification of GPIO and IRQ numbers. For the purpose of the latter,
> + * defina a helper function which identifies GPIO chips by their labels.
> + */
> +static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
> +{
> +       char *label = data;
> +
> +       return !strcmp(label, chip->label);
> +}
> +
> +/*
> + * The purpose of this function is to take care of proper initialization of
> + * devices and data structures which depend on GPIO lines provided by OMAP GPIO
> + * banks but their drivers don't use GPIO lookup tables or GPIO layer at all.
> + * The function may be called as soon as OMAP GPIO devices are probed.
> + * Since that happens at postcore_initcall, it can be called successfully
> + * from init_machine or later.
> + * Dependent devices may be registered from within this function or later.
> + */
> +static void __init omap_gpio_deps_init(void)
> +{
> +       struct gpio_chip *chip;
> +
> +       chip = gpiochip_find(OMAP_GPIO_LABEL, gpiochip_match_by_label);
> +       if (!chip) {
> +               pr_err("%s: OMAP GPIO chip not found\n", __func__);
> +               return;
> +       }
> +
> +       ams_delta_init_fiq(chip);
> +}

This is some real stunt work isn't it.

We should really think about ways to get gpiolib more helpful for board
setups like this, but it seems complex.

Yours,
Linus Walleij
