From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 03/10] input: tps65218-pwrbutton: Add
 platform_device_id table
Date: Tue, 28 Jun 2016 07:49:48 +0100
Message-ID: <20160628064948.GB6720@dell>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, Keerthy wrote:

> platform_device_id table is needed for adding the tps65218-pwrbutton
> module to the mfd_cell array.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/input/misc/tps65218-pwrbutton.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/=
misc/tps65218-pwrbutton.c
> index 2bba8de..a0cb7d2 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -113,12 +113,19 @@ static const struct of_device_id of_tps65218_pw=
r_match[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
> =20
> +static const struct platform_device_id tps65218_pwrbtn_id_table[] =3D=
 {
> +	{ "tps65218-pwrbutton", },
> +	{ /* sentinel */ }
> +}

Missing ';'.  Did you build test this?

> +MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
> +
>  static struct platform_driver tps65218_pwron_driver =3D {
>  	.probe	=3D tps65218_pwron_probe,
>  	.driver	=3D {
>  		.name	=3D "tps65218_pwrbutton",
>  		.of_match_table =3D of_tps65218_pwr_match,
>  	},
> +	.id_table =3D tps65218_pwrbtn_id_table,
>  };
>  module_platform_driver(tps65218_pwron_driver);
> =20

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
