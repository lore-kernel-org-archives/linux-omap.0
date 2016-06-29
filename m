From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH v4 3/3] gpio: lp873x: Add support for General Purpose Outputs
Date: Wed, 29 Jun 2016 16:13:38 +0530
Message-ID: <CAKDJKT7mO0eHZEP5PZmRe-Aez41ThA7r5S4NNMg6RZqJkQUcuA@mail.gmail.com>
References: <1467192604-29149-1-git-send-email-j-keerthy@ti.com> <1467192604-29149-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1467192604-29149-4-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, robh+dt@kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Keerthy

Some minor comment

> +static int lp873x_gpio_direction_output(struct gpio_chip *chip,
> +                                       unsigned int offset, int value)
> +{
> +       struct lp873x_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /* Set the initial value */
> +       regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
> +                          BIT(offset * 4), value ? BIT(offset * 4) : 0);
> +
> +       return 0;
> +}

Error needs to be return, this function always return 0.

> +
> +static int lp873x_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct lp873x_gpio *gpio = gpiochip_get_data(chip);
> +       int ret, val;
> +
> +       ret = regmap_read(gpio->lp873->regmap, LP873X_REG_GPO_CTRL, &val);
> +       if (ret < 0)
> +               return ret;
> +
> +       return val & BIT(offset * 4);
> +}
> +
> +static void lp873x_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +                           int value)
> +{
> +       struct lp873x_gpio *gpio = gpiochip_get_data(chip);
> +
> +       regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
> +                          BIT(offset * 4), value ? BIT(offset * 4) : 0);
> +}
> +
> +static int lp873x_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct lp873x_gpio *gpio = gpiochip_get_data(gc);
> +       int ret;
> +
> +       switch (offset) {
> +       case 0:
> +               /* No MUX Set up Needed for GPO */
> +               break;
> +       case 1:
> +               /* Setup the CLKIN_PIN_SEL MUX to GPO2 */
> +               ret = regmap_update_bits(gpio->lp873->regmap, LP873X_REG_CONFIG,
> +                                        LP873X_CONFIG_CLKIN_PIN_SEL, 0);
> +               if (ret)
> +                       return ret;
> +
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}

Error needs to be return, this function always return 0. Only default
returns error here which is unlikely condition.

> +
> +
> +static int lp873x_gpio_set_single_ended(struct gpio_chip *gc,
> +                                       unsigned int offset,
> +                                       enum single_ended_mode mode)
> +{
> +       struct lp873x_gpio *gpio = gpiochip_get_data(gc);
> +
> +       switch (mode) {
> +       case LINE_MODE_OPEN_DRAIN:
> +               return regmap_update_bits(gpio->lp873->regmap,
> +                                         LP873X_REG_GPO_CTRL,
> +                                         BIT(offset * 4 + 2),
> +                                         BIT(offset * 4 + 2));
> +       case LINE_MODE_PUSH_PULL:
> +               return regmap_update_bits(gpio->lp873->regmap,
> +                                         LP873X_REG_GPO_CTRL,
> +                                         BIT(offset * 4 + 2), 0);
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}

Error needs to be return, this function always return 0. Only default
returns error here which is unlikely condition.

Regards
Manish Badarkhe
