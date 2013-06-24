From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v2 2/2] gpio/omap: auto request GPIO as input if used as
 IRQ via DT
Date: Mon, 24 Jun 2013 15:58:20 +0200
Message-ID: <CAAwP0s3nBUrUfdB9HLKjhyH9u6YnOOV3tFtwDTQRf3tJ74fZ_g@mail.gmail.com>
References: <1371855054-27958-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371855054-27958-3-git-send-email-javier.martinez@collabora.co.uk> <20130624125512.0C5283E0A89@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62622 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab3FXN6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 09:58:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so24914047iec.33
        for <linux-omap@vger.kernel.org>; Mon, 24 Jun 2013 06:58:40 -0700 (PDT)
In-Reply-To: <20130624125512.0C5283E0A89@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

On Mon, Jun 24, 2013 at 2:55 PM, Grant Likely <grant.likely@linaro.org> wrote:
> On Sat, 22 Jun 2013 00:50:54 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
>> When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
>> has to be made to initialize the OMAP GPIO bank before a driver
>> request the IRQ. Otherwise the call to request_irq() fails.
>>
>> Drives should not be aware of this neither care wether an IRQ line
>> is a GPIO or not. They should just request the IRQ and this has to
>> be handled by the irq_chip driver.
>>
>> With the current OMAP GPIO DT binding, if we define:
>>
>>                 gpio6: gpio@49058000 {
>>                         compatible = "ti,omap3-gpio";
>>                         reg = <0x49058000 0x200>;
>>                         interrupts = <34>;
>>                         ti,hwmods = "gpio6";
>>                         gpio-controller;
>>                         #gpio-cells = <2>;
>>                         interrupt-controller;
>>                         #interrupt-cells = <2>;
>>                 };
>>
>>                 interrupt-parent = <&gpio6>;
>>                 interrupts = <16 8>;
>>
>> The GPIO is correctly mapped as an IRQ but a call to gpio_request()
>> is never made. Since a call to the custom IRQ domain .map function
>> handler is made for each GPIO used as an IRQ, the GPIO can be setup
>> and configured as input there automatically.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>
>> Changes since v1:
>>   - Split the irq domain mapping function handler and the GPIO
>>     request in two different patches.
>>
>>  drivers/gpio/gpio-omap.c |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 31cbe65..5ec6a00 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1092,6 +1092,8 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
>>                            irq_hw_number_t hwirq)
>>  {
>>       struct gpio_bank *bank = d->host_data;
>> +     int gpio;
>> +     int ret;
>>
>>       if (!bank)
>>               return -EINVAL;
>> @@ -1106,6 +1108,13 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
>>                                                handle_simple_irq);
>>                       set_irq_flags(virq, IRQF_VALID);
>>               }
>> +
>> +             gpio = irq_to_gpio(bank, hwirq);
>> +             ret = gpio_request_one(gpio, GPIOF_IN, NULL);
>> +             if (ret) {
>> +                     dev_err(bank->dev, "Could not request GPIO%d\n", gpio);
>> +                     return ret;
>> +             }
>
> Following from my comment on patch 1, this is the only bit that you'd
> want to be conditional on the presence of a DT, not the whole block.
>
> g.
>

Hello Grant,

Thanks a lot for your feedback. You are absolutely right, sorry for
not realizing that before.

I'll prepare a v3 of the patch-set addressing your comments and I will
also include a patch that only converts gpio irq domain to linear
mapping for OMAP2+ since Jon's patch was reverted due a regression on
OMAP1 when using linear domain mapping [1].

Thanks a lot and best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2594491/
