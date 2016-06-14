From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Tue, 14 Jun 2016 14:18:08 +0300
Message-ID: <575FE7F0.6090200@ti.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hi Uwe,

On 06/14/2016 01:03 PM, Uwe Kleine-K=F6nig wrote:
> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can hap=
pen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
>=20
> To ensure a deterministical numbering use of_alias_get_id to determin=
e
> the number base for a given device. If no respective alias exists fal=
l
> back to the traditional numbering.
>=20
> For the unusual case where only a part of the gpio devices have a
> matching alias some of them might fail to probe. But if none of them =
has
> an alias or all, there is no conflict which should be good enough to
> maintain backward compatibility.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> if you're happy with this patch I can follow up and add the respectiv=
e
> aliases to the device trees.
>=20

Thanks for the patch.
I have no objection to the idea of the patch, but there are some commen=
ts.

>=20
>   drivers/gpio/gpio-omap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b98ede78c9d8..6814245a54aa 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_bank=
 *bank, struct irq_chip *irqc)
>   	static int gpio;
>   	int irq_base =3D 0;
>   	int ret;
> +	int gpio_alias_id;
>  =20
>   	/*
>   	 * REVISIT eventually switch from OMAP-specific gpio structs
> @@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_ban=
k *bank, struct irq_chip *irqc)
>   		bank->chip.label =3D "gpio";
>   		bank->chip.base =3D gpio;

I think, the gpio base correction should be done here

>   	}
> +
> +	/*
> +	 * Traditionally the base is given out in first-come-first-serve or=
der.
> +	 * This might shuffle the numbering of gpios if the probe order cha=
nges.
> +	 * So make the base deterministical if the device tree specifies al=
ias
> +	 * ids.
> +	 */
> +	gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
> +	if (gpio_alias_id >=3D 0)
> +		bank->chip.base =3D bank->width * gpio_alias_id;
> +

Unfortunately, this driver is still used by non-DT platforms, so above =
code will
 break build if !OF && !OF_GPIO

I think, right way would be to get alias_id in .probe(), then calc base=
 and save it
in struct gpio_bank. Then use it here to fixup GPIO base if positive.

>   	bank->chip.ngpio =3D bank->width;
>  =20
>   	ret =3D gpiochip_add_data(&bank->chip, bank);
>=20


--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
