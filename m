From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 15/20] mfd: sky81452: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:31:56 +0100
Message-ID: <20160411093156.GF7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-16-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-16-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Gyungoh Yoo <jack.yoo@skyworksinc.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/sky81452.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
> index b0c9b04..30a2a67 100644
> --- a/drivers/mfd/sky81452.c
> +++ b/drivers/mfd/sky81452.c
> @@ -64,19 +64,14 @@ static int sky81452_probe(struct i2c_client *clie=
nt,
>  	cells[1].platform_data =3D pdata->regulator_init_data;
>  	cells[1].pdata_size =3D sizeof(*pdata->regulator_init_data);
> =20
> -	ret =3D mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells), NULL, 0,=
 NULL);
> +	ret =3D devm_mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells),
> +				   NULL, 0, NULL);
>  	if (ret)
>  		dev_err(dev, "failed to add child devices. err=3D%d\n", ret);
> =20
>  	return ret;
>  }
> =20
> -static int sky81452_remove(struct i2c_client *client)
> -{
> -	mfd_remove_devices(&client->dev);
> -	return 0;
> -}
> -
>  static const struct i2c_device_id sky81452_ids[] =3D {
>  	{ "sky81452" },
>  	{ }
> @@ -97,7 +92,6 @@ static struct i2c_driver sky81452_driver =3D {
>  		.of_match_table =3D of_match_ptr(sky81452_of_match),
>  	},
>  	.probe =3D sky81452_probe,
> -	.remove =3D sky81452_remove,
>  	.id_table =3D sky81452_ids,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
