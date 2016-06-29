From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v4 3/3] gpio: lp873x: Add support for General Purpose
 Outputs
Date: Wed, 29 Jun 2016 18:10:08 +0530
Message-ID: <5773C1A8.2070504@ti.com>
References: <1467192604-29149-1-git-send-email-j-keerthy@ti.com>
 <1467192604-29149-4-git-send-email-j-keerthy@ti.com>
 <CAKDJKT7mO0eHZEP5PZmRe-Aez41ThA7r5S4NNMg6RZqJkQUcuA@mail.gmail.com>
 <CAKDJKT4yNAO6OdYTtWQ3W-aNvvFb46p8=g02grvz07af-jTjyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAKDJKT4yNAO6OdYTtWQ3W-aNvvFb46p8=g02grvz07af-jTjyw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, robh+dt@kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On Wednesday 29 June 2016 04:15 PM, Manish Badarkhe wrote:
> Hi Keerthy,
>
> sorry ignore my last two comments in previous mail.
>
> On Wed, Jun 29, 2016 at 4:13 PM, Manish Badarkhe
> <badarkhe.manish@gmail.com> wrote:
>> Hi Keerthy
>>
>> Some minor comment
>>
>>> +static int lp873x_gpio_direction_output(struct gpio_chip *chip,
>>> +                                       unsigned int offset, int value)
>>> +{
>>> +       struct lp873x_gpio *gpio = gpiochip_get_data(chip);
>>> +
>>> +       /* Set the initial value */
>>> +       regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
>>> +                          BIT(offset * 4), value ? BIT(offset * 4) : 0);
>>> +
>>> +       return 0;
>>> +}
>
>   Error needs to be return, this function always return 0.

Yes! I can just do:

return regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
                           BIT(offset * 4), value ? BIT(offset * 4) : 0);

>
>   Regards
>   Manish Badarkhe
>
