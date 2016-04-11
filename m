From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 04/20] mfd: as3711: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:15:30 +0100
Message-ID: <20160411091530.GR4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-5-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-5-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/as3711.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
> index 09e1483..67b1241 100644
> --- a/drivers/mfd/as3711.c
> +++ b/drivers/mfd/as3711.c
> @@ -189,22 +189,14 @@ static int as3711_i2c_probe(struct i2c_client *=
client,
>  		as3711_subdevs[AS3711_BACKLIGHT].pdata_size =3D 0;
>  	}
> =20
> -	ret =3D mfd_add_devices(as3711->dev, -1, as3711_subdevs,
> -			      ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(as3711->dev, -1, as3711_subdevs,
> +				   ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
>  	if (ret < 0)
>  		dev_err(&client->dev, "add mfd devices failed: %d\n", ret);
> =20
>  	return ret;
>  }
> =20
> -static int as3711_i2c_remove(struct i2c_client *client)
> -{
> -	struct as3711 *as3711 =3D i2c_get_clientdata(client);
> -
> -	mfd_remove_devices(as3711->dev);
> -	return 0;
> -}
> -
>  static const struct i2c_device_id as3711_i2c_id[] =3D {
>  	{.name =3D "as3711", .driver_data =3D 0},
>  	{}
> @@ -218,7 +210,6 @@ static struct i2c_driver as3711_i2c_driver =3D {
>  		   .of_match_table =3D of_match_ptr(as3711_of_match),
>  	},
>  	.probe =3D as3711_i2c_probe,
> -	.remove =3D as3711_i2c_remove,
>  	.id_table =3D as3711_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
