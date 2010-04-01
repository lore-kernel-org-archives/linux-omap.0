From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce method
Date: Thu, 1 Apr 2010 12:29:16 +0300
Message-ID: <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
	 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:21880 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0DAJhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:37:24 -0400
Received: by fg-out-1718.google.com with SMTP id l26so314780fgb.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Apr 2010 02:37:22 -0700 (PDT)
In-Reply-To: <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 6:35 PM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> OMAP support debouncing of gpio lines, implement
> the method using gpiolib.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> =A0arch/arm/plat-omap/gpio.c | =A0 68 +++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 68 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 76a347b..345ed2c 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -612,6 +612,59 @@ do { =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0__raw_writel(l, base + reg); \
> =A0} while(0)
>
> +/**
> + * _set_gpio_debounce - low level gpio debounce time
> + * @bank: the gpio bank we're acting upon
> + * @gpio: the gpio number on this @gpio
> + * @debounce: debounce time to use
> + *
> + * OMAP's debounce time is in 31us steps so we need
> + * to convert and round up to the closest unit.
> + */
> +static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned debounce)
> +{
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*reg =3D bank->base=
;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l;
> +
> + =A0 =A0 =A0 if (debounce < 32)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 debounce =3D 0x01;
> + =A0 =A0 =A0 else if (debounce > 7936)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 debounce =3D 0xff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 debounce =3D (debounce / 0x1f) - 1;
> +
> + =A0 =A0 =A0 l =3D 1 << get_gpio_index(gpio);
> +
> + =A0 =A0 =A0 if (cpu_is_omap44xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP4_GPIO_DEBOUNCINGTIME;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP24XX_GPIO_DEBOUNCE_VAL;
> +
> + =A0 =A0 =A0 __raw_writel(debounce, reg);
> +
> + =A0 =A0 =A0 reg =3D bank->base;
> + =A0 =A0 =A0 if (cpu_is_omap44xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP4_GPIO_DEBOUNCENABLE;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP24XX_GPIO_DEBOUNCE_EN;
> +
> + =A0 =A0 =A0 val =3D __raw_readl(reg);
> +
> + =A0 =A0 =A0 if (debounce) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D l;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44x=
x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~l;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44x=
x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck)=
;
> + =A0 =A0 =A0 }

Hmh, dbck is shared by the whole GPIO bank, so what happens if someone
calls _set_gpio_debounce(bank, 1, 310) and then
_set_gpio_debounce(bank, 2, 0)? This should leave debounce enabled for
GPIO1, but you'll disable dbck on second call. GPIOs 0-31 share the
same bank.

There is also an issue if somebody calls _set_gpio_debounce(bank, 1,
310) and _set_gpio_debounce(bank, 2, 620), the second call will
override debounce setting of GPIO1 (as it's shared by the whole bank).
This might be not what the user intended, would be useful to detect
this and warn the user.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
