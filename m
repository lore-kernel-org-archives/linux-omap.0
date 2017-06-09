From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: lp87565: Add support for GPIO
Date: Fri, 9 Jun 2017 10:36:25 +0200
Message-ID: <CACRpkdZFYSj0=O1PpPzWpcgV+k7WoKCDRPW3fcQ5+B-pDvEWEw@mail.gmail.com>
References: <1496286631-6295-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1496286631-6295-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 1, 2017 at 5:10 AM, Keerthy <j-keerthy@ti.com> wrote:

> Add driver for lp87565 PMIC family GPIOs. Three GPIOs are supported
> and can be configured in Open-drain output or Push-pull output.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

(...)
> The latest version of mfd driver for this pmic is posted:
> https://lkml.org/lkml/2017/5/30/463
(...)
> +config GPIO_LP87565
> +       tristate "TI LP87565 GPIO"
> +       depends on MFD_TI_LP87565

Hm I guess that means I could merge it since it will only compile once
that symbol turns up in the kernel tree.

> +#include <linux/gpio.h>

Please use
#include <linux/gpio/driver.h>
only.

> +#include <linux/mfd/lp87565.h>

Is this API stable enough that I could merge this and count on it to
"just work" once the MFD driver lands?

> +struct lp87565_gpio {
> +       struct gpio_chip chip;
> +       struct lp87565 *lp87565;
> +};

It seems the code would be easier to read if you store the struct regmap *map
pointer here instead of the whole struct lp87565.

But it's no strong preference.

> +static int lp87565_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct lp87565_gpio *gpio = gpiochip_get_data(chip);
> +       int ret, val;
> +
> +       ret = regmap_read(gpio->lp87565->regmap, LP87565_REG_GPIO_IN, &val);
> +       if (ret < 0)
> +               return ret;
> +
> +       return val & BIT(offset);

return !!(val & BIT(offset));

please, so it's clear that we clamp to [0,1].

> +static int lp87565_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct lp87565_gpio *gpio = gpiochip_get_data(gc);
> +       int ret;
> +
> +       switch (offset) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               /* Setup the GPIO*_SEL MUX to GPIO mode */
> +               ret = regmap_update_bits(gpio->lp87565->regmap,
> +                                        LP87565_REG_PIN_FUNCTION,
> +                                        BIT(offset), BIT(offset));

Hm. Hm.

If this IC has several function modes for the pins it should also
be a pin controller... I know it is a lot of upfront code, but... it will
benefit you in the long run. Is it really just these three pins?

Maybe we should merge it into
drivers/pinctrl/pinctrl-lp87565.c so that at least file placement does
not become a problem later?

> +static int lp87565_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
> +                                  unsigned long config)
> +{
> +       struct lp87565_gpio *gpio = gpiochip_get_data(gc);
> +
> +       switch (pinconf_to_config_param(config)) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               return regmap_update_bits(gpio->lp87565->regmap,
> +                                         LP87565_REG_GPIO_CONFIG,
> +                                         BIT(offset +
> +                                             __ffs(LP87565_GOIO1_OD)),
> +                                         BIT(offset +
> +                                             __ffs(LP87565_GOIO1_OD)));
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +               return regmap_update_bits(gpio->lp87565->regmap,
> +                                         LP87565_REG_GPIO_CONFIG,
> +                                         BIT(offset +
> +                                             __ffs(LP87565_GOIO1_OD)), 0);
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}

Nice.

If this was a split GPIO+pin control driver this would just be a call
into the pinctrl back-end from the GPIO controller, like
drivers/pinctrl/intel/pinctrl-intel.c does with just using
gpiochip_generic_config().

> +static int lp87565_gpio_probe(struct platform_device *pdev)
> +{
> +       struct lp87565_gpio *gpio;
> +       int ret;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, gpio);

Is this pointer used anywhere?

> +       gpio->lp87565 = dev_get_drvdata(pdev->dev.parent);

So maybe assign the regmap instead.

Yours,
Linus Walleij
