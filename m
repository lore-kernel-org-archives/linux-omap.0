From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 14/20] mfd: rt5033: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:31:49 +0100
Message-ID: <20160411093149.GE7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-15-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-15-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Ingi Kim <ingi2.kim@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Ingi Kim <ingi2.kim@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
> - Collected reviewed by.
>=20
>  drivers/mfd/rt5033.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> index 2b95485..9bd089c 100644
> --- a/drivers/mfd/rt5033.c
> +++ b/drivers/mfd/rt5033.c
> @@ -97,9 +97,9 @@ static int rt5033_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
> =20
> -	ret =3D mfd_add_devices(rt5033->dev, -1, rt5033_devs,
> -			ARRAY_SIZE(rt5033_devs), NULL, 0,
> -			regmap_irq_get_domain(rt5033->irq_data));
> +	ret =3D devm_mfd_add_devices(rt5033->dev, -1, rt5033_devs,
> +				   ARRAY_SIZE(rt5033_devs), NULL, 0,
> +				   regmap_irq_get_domain(rt5033->irq_data));
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "Failed to add RT5033 child devices.\n");
>  		return ret;
> @@ -110,13 +110,6 @@ static int rt5033_i2c_probe(struct i2c_client *i=
2c,
>  	return 0;
>  }
> =20
> -static int rt5033_i2c_remove(struct i2c_client *i2c)
> -{
> -	mfd_remove_devices(&i2c->dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id rt5033_i2c_id[] =3D {
>  	{ "rt5033", },
>  	{ }
> @@ -135,7 +128,6 @@ static struct i2c_driver rt5033_driver =3D {
>  		.of_match_table =3D of_match_ptr(rt5033_dt_match),
>  	},
>  	.probe =3D rt5033_i2c_probe,
> -	.remove =3D rt5033_i2c_remove,
>  	.id_table =3D rt5033_i2c_id,
>  };
>  module_i2c_driver(rt5033_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
