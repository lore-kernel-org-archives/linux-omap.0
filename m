From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v2] gpio: omap: make gpio numbering deterministical by
 using of aliases
Date: Thu, 23 Jun 2016 10:54:05 +0200
Message-ID: <CACRpkdYHHLyBTJYPw_pMds0z-BtPPHf7mEcjE2ayTw7jRqNDdA@mail.gmail.com>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de> <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Looping in DT people.

Please send subsequent patches also to devicetree@vger.kernel.org

On Tue, Jun 14, 2016 at 8:57 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can hap=
pen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
>
> To ensure a deterministical numbering use of_alias_get_id to determin=
e
> the base for a given device. If no respective alias exists fall back =
to
> the traditional numbering.
>
> For the unusual case where only a part of the gpio devices have a
> matching alias some of them might fail to probe. But if none of them =
has
> an alias or all, there is no conflict which should be good enough to
> maintain backward compatibility.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-omap.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b98ede78c9d8..4d91792e7266 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1053,9 +1053,26 @@ static int omap_gpio_chip_init(struct gpio_ban=
k *bank, struct irq_chip *irqc)
>                         bank->chip.parent =3D &omap_mpuio_device.dev;
>                 bank->chip.base =3D OMAP_MPUIO(0);
>         } else {
> +               int gpio_alias_id __maybe_unused;
> +
>                 bank->chip.label =3D "gpio";
> -               bank->chip.base =3D gpio;
> +
> +#if defined(CONFIG_OF_GPIO)
> +               /*
> +                * Traditionally the base is given out in first-come-=
first-serve
> +                * order.  This might shuffle the numbering of gpios =
if the
> +                * probe order changes.  So make the base determinist=
ical if the
> +                * device tree specifies alias ids.
> +                */
> +               gpio_alias_id =3D of_alias_get_id(bank->chip.of_node,=
 "gpio");
> +               if (gpio_alias_id >=3D 0)
> +                       bank->chip.base =3D bank->width * gpio_alias_=
id;
> +               else
> +#endif
> +                       bank->chip.base =3D gpio;
>         }
> +
> +

I need:

- A hunk of the patch to hit
  Documentation/devicetree/bindings/gpio/gpio.txt
  and describe the alias usage there

-  an ACK from a DT bindings maintainer for this.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
