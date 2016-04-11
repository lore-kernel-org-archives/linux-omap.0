From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 09/20] mfd: menf21bmc: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:16:16 +0100
Message-ID: <20160411091616.GW4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-10-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-10-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
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
> CC: Andreas Werner <andreas.werner@men.de>
> Reviewed-by: Andreas Werner <andreas.werner@men.de>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
> - Collected reviewed by.
>=20
>  drivers/mfd/menf21bmc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
> index 1c27434..3ad2def 100644
> --- a/drivers/mfd/menf21bmc.c
> +++ b/drivers/mfd/menf21bmc.c
> @@ -96,8 +96,8 @@ menf21bmc_probe(struct i2c_client *client, const st=
ruct i2c_device_id *ids)
>  		return ret;
>  	}
> =20
> -	ret =3D mfd_add_devices(&client->dev, 0, menf21bmc_cell,
> -			      ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(&client->dev, 0, menf21bmc_cell,
> +				   ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed to add BMC sub-devices\n");
>  		return ret;
> @@ -106,12 +106,6 @@ menf21bmc_probe(struct i2c_client *client, const=
 struct i2c_device_id *ids)
>  	return 0;
>  }
> =20
> -static int menf21bmc_remove(struct i2c_client *client)
> -{
> -	mfd_remove_devices(&client->dev);
> -	return 0;
> -}
> -
>  static const struct i2c_device_id menf21bmc_id_table[] =3D {
>  	{ "menf21bmc" },
>  	{ }
> @@ -122,7 +116,6 @@ static struct i2c_driver menf21bmc_driver =3D {
>  	.driver.name	=3D "menf21bmc",
>  	.id_table	=3D menf21bmc_id_table,
>  	.probe		=3D menf21bmc_probe,
> -	.remove		=3D menf21bmc_remove,
>  };
> =20
>  module_i2c_driver(menf21bmc_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
