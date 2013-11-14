From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Thu, 14 Nov 2013 11:45:51 +0200
Message-ID: <52849BCF.6060203@ti.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com> <1384396537-3486-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1384396537-3486-6-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/14/2013 04:35 AM, Tony Lindgren wrote:
> Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
> states in private data) improved things in general, but caused a
> regression for setting the GPIO output direction.
>=20
> The change reorganized twl_direction_out() and twl_set() and swapped
> the function names around in the process. While doing that, a bug got
> introduced that's not obvious while reading the patch as it appears
> as no change to the code.
>=20
> The bug is we now call function twl4030_set_gpio_dataout() twice in
> both twl_direction_out() and twl_set(). Instead, we should first
> call twl_direction_out() in twl_direction_out() followed by
> twl4030_set_gpio_dataout() in twl_set().
>=20
> This regression probably has gone unnoticed for a long time as the
> bootloader may have set the GPIO direction properly in many cases.
> This fixes at least the LCD panel not turning on omap3 LDP for
> example.

Thanks for catching this. I have a recollection that I have tested the =
GPIO
and it appeared to be working fine..

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>=20
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.
>=20
> ---
>  drivers/gpio/gpio-twl4030.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.=
c
> index 0c7e891..5738d5a 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -354,17 +354,18 @@ static void twl_set(struct gpio_chip *chip, uns=
igned offset, int value)
>  static int twl_direction_out(struct gpio_chip *chip, unsigned offset=
, int value)
>  {
>  	struct gpio_twl4030_priv *priv =3D to_gpio_twl4030(chip);
> +	int ret =3D -EINVAL;
> =20
>  	mutex_lock(&priv->mutex);
>  	if (offset < TWL4030_GPIO_MAX)
> -		twl4030_set_gpio_dataout(offset, value);
> +		ret =3D twl4030_set_gpio_direction(offset, 0);
> =20
>  	priv->direction |=3D BIT(offset);
>  	mutex_unlock(&priv->mutex);
> =20
>  	twl_set(chip, offset, value);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
