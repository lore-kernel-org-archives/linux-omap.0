From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/8] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Mon, 27 Jun 2016 13:23:45 +0100
Message-ID: <20160627122345.GC24377@dell>
References: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
 <1467025305-13464-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467025305-13464-4-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Jun 2016, Keerthy wrote:

> mfd_add_devices enables parsing device tree nodes without compatibles
> for child nodes. Replace of_platform_populate with mfd_add_devices.
> mfd_cell currently is populated with only regulators.
>=20
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>=20
> Changes in v2:
>=20
>   * Updated commit log.
>=20
> As of now only regulators driver is in kernel. The PMIC contains
> a bunch of GPIOs, Over temperature warning / shutdown unit.
>=20
>  drivers/mfd/tps65218.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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
> +
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
