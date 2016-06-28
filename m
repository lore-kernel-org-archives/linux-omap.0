From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 06/10] gpio: tps65218: Remove the compatible
Date: Tue, 28 Jun 2016 07:52:35 +0100
Message-ID: <20160628065235.GC6720@dell>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467093980-11458-7-git-send-email-j-keerthy@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, Keerthy wrote:

> Remove the individual compatible for the gpio module.
> Introduce id_table and update the driver accordingly
> to parse device tree nodes by just using the mfd compatible.

Aren't there any OF calls in this driver?

You can use the MFD API to pass through compatible strings in order to
interrogate the DT in the normal way.  There isn't usually a reason to
remove DT support just because you start using the MFD API.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/gpio/gpio-tps65218.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps6521=
8.c
> index 0f9d9bd..06fd61f 100644
> --- a/drivers/gpio/gpio-tps65218.c
> +++ b/drivers/gpio/gpio-tps65218.c
> @@ -225,19 +225,19 @@ static int tps65218_gpio_remove(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> -static const struct of_device_id tps65218_dt_match[] =3D {
> -	{ .compatible =3D "ti,tps65218-gpio" },
> -	{  }
> +static const struct platform_device_id tps65218_gpio_id_table[] =3D =
{
> +	{ "tps65218-gpio", },
> +	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(of, tps65218_dt_match);
> +MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
> =20
>  static struct platform_driver tps65218_gpio_driver =3D {
>  	.driver =3D {
>  		.name =3D "tps65218-gpio",
> -		.of_match_table =3D of_match_ptr(tps65218_dt_match)
>  	},
>  	.probe =3D tps65218_gpio_probe,
>  	.remove =3D tps65218_gpio_remove,
> +	.id_table =3D tps65218_gpio_id_table,
>  };
> =20
>  module_platform_driver(tps65218_gpio_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
