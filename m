From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3 2/2] gpio/omap: auto request GPIO as input if used as
 IRQ via DT
Date: Fri, 28 Jun 2013 10:55:21 +0100
Message-ID: <CACxGe6vAzgiddE5V=H8BZ9OEYVJsZPxeQv6WWQ2L8mghaULjew@mail.gmail.com>
References: <1372276203-21755-1-git-send-email-javier.martinez@collabora.co.uk>
 <1372276203-21755-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40711 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab3F1Jzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jun 2013 05:55:41 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so3807967iec.35
        for <linux-omap@vger.kernel.org>; Fri, 28 Jun 2013 02:55:41 -0700 (PDT)
In-Reply-To: <1372276203-21755-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Wed, Jun 26, 2013 at 8:50 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
> has to be made to initialize the OMAP GPIO bank before a driver
> request the IRQ. Otherwise the call to request_irq() fails.
>
> Drives should not be aware of this neither care wether an IRQ line
> is a GPIO or not. They should just request the IRQ and this has to
> be handled by the irq_chip driver.
>
> With the current OMAP GPIO DT binding, if we define:
>
>     gpio6: gpio@49058000 {
>            compatible = "ti,omap3-gpio";
>            reg = <0x49058000 0x200>;
>            interrupts = <34>;
>            ti,hwmods = "gpio6";
>            gpio-controller;
>            #gpio-cells = <2>;
>            interrupt-controller;
>            #interrupt-cells = <2>;
>     };
>
>            interrupt-parent = <&gpio6>;
>            interrupts = <16 8>;
>
> The GPIO is correctly mapped as an IRQ but a call to gpio_request()
> is never made. Since a call to the custom IRQ domain .map function
> handler is made for each GPIO used as an IRQ, the GPIO can be setup
> and configured as input there automatically.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>
> Changes since v2:
>  - Only make the call to gpio_request_one() conditional in the DT
>    case as suggested by Grant Likely.
>
> Changes since v1:
>   - Split the irq domain mapping function handler and the GPIO
>     request in two different patches.
>
>  drivers/gpio/gpio-omap.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 42f04ff..98848c9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1090,6 +1090,8 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
>                              irq_hw_number_t hwirq)
>  {
>         struct gpio_bank *bank = d->host_data;
> +       int gpio;
> +       int ret;
>
>         if (!bank)
>                 return -EINVAL;
> @@ -1104,6 +1106,15 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
>                 set_irq_flags(virq, IRQF_VALID);
>         }
>
> +       if (of_have_populated_dt()) {
> +               gpio = irq_to_gpio(bank, hwirq);
> +               ret = gpio_request_one(gpio, GPIOF_IN, NULL);
> +               if (ret) {
> +                       dev_err(bank->dev, "Could not request GPIO%d\n", gpio);
> +                       return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 1.7.7.6
>
