From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 20/20] mfd: wm8400: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:32:41 +0100
Message-ID: <20160411093241.GK7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-21-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-21-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: patches@opensource.wolfsonmicro.com
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Collected acks.
>=20
>  drivers/mfd/wm8400-core.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
> index 3bd44a4..9fd8230 100644
> --- a/drivers/mfd/wm8400-core.c
> +++ b/drivers/mfd/wm8400-core.c
> @@ -70,7 +70,7 @@ static int wm8400_register_codec(struct wm8400 *wm8=
400)
>  		.pdata_size =3D sizeof(*wm8400),
>  	};
> =20
> -	return mfd_add_devices(wm8400->dev, -1, &cell, 1, NULL, 0, NULL);
> +	return devm_mfd_add_devices(wm8400->dev, -1, &cell, 1, NULL, 0, NUL=
L);
>  }
> =20
>  /*
> @@ -111,7 +111,7 @@ static int wm8400_init(struct wm8400 *wm8400,
>  	ret =3D wm8400_register_codec(wm8400);
>  	if (ret !=3D 0) {
>  		dev_err(wm8400->dev, "Failed to register codec\n");
> -		goto err_children;
> +		return ret;
>  	}
> =20
>  	if (pdata && pdata->platform_init) {
> @@ -119,21 +119,12 @@ static int wm8400_init(struct wm8400 *wm8400,
>  		if (ret !=3D 0) {
>  			dev_err(wm8400->dev, "Platform init failed: %d\n",
>  				ret);
> -			goto err_children;
> +			return ret;
>  		}
>  	} else
>  		dev_warn(wm8400->dev, "No platform initialisation supplied\n");
> =20
>  	return 0;
> -
> -err_children:
> -	mfd_remove_devices(wm8400->dev);
> -	return ret;
> -}
> -
> -static void wm8400_release(struct wm8400 *wm8400)
> -{
> -	mfd_remove_devices(wm8400->dev);
>  }
> =20
>  static const struct regmap_config wm8400_regmap_config =3D {
> @@ -176,15 +167,6 @@ static int wm8400_i2c_probe(struct i2c_client *i=
2c,
>  	return wm8400_init(wm8400, dev_get_platdata(&i2c->dev));
>  }
> =20
> -static int wm8400_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct wm8400 *wm8400 =3D i2c_get_clientdata(i2c);
> -
> -	wm8400_release(wm8400);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id wm8400_i2c_id[] =3D {
>         { "wm8400", 0 },
>         { }
> @@ -196,7 +178,6 @@ static struct i2c_driver wm8400_i2c_driver =3D {
>  		.name =3D "WM8400",
>  	},
>  	.probe    =3D wm8400_i2c_probe,
> -	.remove   =3D wm8400_i2c_remove,
>  	.id_table =3D wm8400_i2c_id,
>  };
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
