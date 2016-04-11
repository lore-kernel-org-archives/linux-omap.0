From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 18/20] mfd: tps65217: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:32:22 +0100
Message-ID: <20160411093222.GI7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-19-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-19-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Tony Lindgren <tony@atomide.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/tps65217.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index d32b5442..049a6fc 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -205,8 +205,8 @@ static int tps65217_probe(struct i2c_client *clie=
nt,
>  		return ret;
>  	}
> =20
> -	ret =3D mfd_add_devices(tps->dev, -1, tps65217s,
> -			      ARRAY_SIZE(tps65217s), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(tps->dev, -1, tps65217s,
> +				   ARRAY_SIZE(tps65217s), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>  		return ret;
> @@ -235,15 +235,6 @@ static int tps65217_probe(struct i2c_client *cli=
ent,
>  	return 0;
>  }
> =20
> -static int tps65217_remove(struct i2c_client *client)
> -{
> -	struct tps65217 *tps =3D i2c_get_clientdata(client);
> -
> -	mfd_remove_devices(tps->dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tps65217_id_table[] =3D {
>  	{"tps65217", TPS65217},
>  	{ /* sentinel */ }
> @@ -257,7 +248,6 @@ static struct i2c_driver tps65217_driver =3D {
>  	},
>  	.id_table	=3D tps65217_id_table,
>  	.probe		=3D tps65217_probe,
> -	.remove		=3D tps65217_remove,
>  };
> =20
>  static int __init tps65217_init(void)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
