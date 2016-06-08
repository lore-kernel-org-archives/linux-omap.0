From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/8] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Wed, 8 Jun 2016 16:50:25 +0100
Message-ID: <20160608155025.GB14888@dell>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462945691-904-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikita@compulab.co.il, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 11 May 2016, Keerthy wrote:

> mfd_add_devices enables parsing device tree nodes without compatibles
> for child nodes. Replace of_platform_populate with mfd_add_devices.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/tps65218.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index f20a531..b8b3a58 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -33,6 +33,10 @@
> =20
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
> =20
> +static const struct mfd_cell tps65218_cells[] =3D {
> +	{ .name =3D "tps65218-regulator", },
> +};

What other devices does the TPS65218 consist of?

>  /**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
> @@ -236,8 +240,10 @@ static int tps65218_probe(struct i2c_client *cli=
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
