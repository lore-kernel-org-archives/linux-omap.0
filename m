From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 04/10] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Tue, 28 Jun 2016 07:54:43 +0100
Message-ID: <20160628065443.GD6720@dell>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467093980-11458-5-git-send-email-j-keerthy@ti.com>
Sender: linux-input-owner@vger.kernel.org
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
>  drivers/mfd/tps65218.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index f20a531..107d695 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -33,6 +33,15 @@
> =20
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
> =20
> +static const struct mfd_cell tps65218_cells[] =3D {
> +	{ .name =3D "tps65218-regulator", },
> +	{
> +		.name =3D "tps65218-pwrbutton",
> +		.of_compatible =3D "ti,tps65218-pwrbutton",
> +	},
> +	{ .name =3D "tps65218-gpio", },
> +};

If there are no ordering dependencies, please move and group the one
line entries to the bottom of the table.

>  /**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
> @@ -236,8 +245,10 @@ static int tps65218_probe(struct i2c_client *cli=
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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
