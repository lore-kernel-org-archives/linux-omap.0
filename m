From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 06/20] mfd: bcm590xx: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:15:46 +0100
Message-ID: <20160411091546.GT4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-7-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-7-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Matt Porter <mporter@linaro.org>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Matt Porter <mporter@linaro.org>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/bcm590xx.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> index 320aaef..0d76d69 100644
> --- a/drivers/mfd/bcm590xx.c
> +++ b/drivers/mfd/bcm590xx.c
> @@ -82,8 +82,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2=
c_pri,
>  		goto err;
>  	}
> =20
> -	ret =3D mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
> -			      ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
> +				   ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&i2c_pri->dev, "failed to add sub-devices: %d\n", ret);
>  		goto err;
> @@ -96,12 +96,6 @@ err:
>  	return ret;
>  }
> =20
> -static int bcm590xx_i2c_remove(struct i2c_client *i2c)
> -{
> -	mfd_remove_devices(&i2c->dev);
> -	return 0;
> -}
> -
>  static const struct of_device_id bcm590xx_of_match[] =3D {
>  	{ .compatible =3D "brcm,bcm59056" },
>  	{ }
> @@ -120,7 +114,6 @@ static struct i2c_driver bcm590xx_i2c_driver =3D =
{
>  		   .of_match_table =3D of_match_ptr(bcm590xx_of_match),
>  	},
>  	.probe =3D bcm590xx_i2c_probe,
> -	.remove =3D bcm590xx_i2c_remove,
>  	.id_table =3D bcm590xx_i2c_id,
>  };
>  module_i2c_driver(bcm590xx_i2c_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
