From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/6] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Tue, 28 Jun 2016 11:56:58 +0100
Message-ID: <20160628105658.GA17585@dell>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
 <1467105729-28249-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467105729-28249-6-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, Keerthy wrote:

> mfd_add_devices enables parsing device tree nodes without compatibles
> for regulators and gpio modules. Replace of_platform_populate with
> mfd_add_devices. mfd_cell currently is populated with regulators,
> gpio and powerbutton.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Changes in v4:
>=20
>   * Regrouped the mfd cells better.
>=20
>  drivers/mfd/tps65218.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

=46or my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index f20a531..f13c8d9 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -33,6 +33,18 @@
> =20
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
> =20
> +static const struct mfd_cell tps65218_cells[] =3D {
> +	{
> +		.name =3D "tps65218-pwrbutton",
> +		.of_compatible =3D "ti,tps65218-pwrbutton",
> +	},
> +	{
> +		.name =3D "tps65218-gpio",
> +		.of_compatible =3D "ti,tps65218-gpio",
> +	},
> +	{ .name =3D "tps65218-regulator", },
> +};
> +
>  /**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
> @@ -236,8 +248,10 @@ static int tps65218_probe(struct i2c_client *cli=
ent,
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D of_platform_populate(client->dev.of_node, NULL, NULL,
> -				   &client->dev);
> +	ret =3D mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cel=
ls,
> +			      ARRAY_SIZE(tps65218_cells), NULL, 0,
> +			      regmap_irq_get_domain(tps->irq_data));
> +
>  	if (ret < 0)
>  		goto err_irq;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
