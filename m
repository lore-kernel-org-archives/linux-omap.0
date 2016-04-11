From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 03/20] mfd: act8945a: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:15:22 +0100
Message-ID: <20160411091522.GQ4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Wenyou Yang <wenyou.yang@atmel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Wenyou Yang <wenyou.yang@atmel.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/act8945a.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
> index 525b546..10c6d2d 100644
> --- a/drivers/mfd/act8945a.c
> +++ b/drivers/mfd/act8945a.c
> @@ -46,8 +46,9 @@ static int act8945a_i2c_probe(struct i2c_client *i2=
c,
> =20
>  	i2c_set_clientdata(i2c, regmap);
> =20
> -	ret =3D mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE, act8945a_de=
vs,
> -			      ARRAY_SIZE(act8945a_devs), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
> +				   act8945a_devs, ARRAY_SIZE(act8945a_devs),
> +				   NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(&i2c->dev, "Failed to add sub devices\n");
>  		return ret;
> @@ -56,13 +57,6 @@ static int act8945a_i2c_probe(struct i2c_client *i=
2c,
>  	return 0;
>  }
> =20
> -static int act8945a_i2c_remove(struct i2c_client *i2c)
> -{
> -	mfd_remove_devices(&i2c->dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id act8945a_i2c_id[] =3D {
>  	{ "act8945a", 0 },
>  	{}
> @@ -81,7 +75,6 @@ static struct i2c_driver act8945a_i2c_driver =3D {
>  		   .of_match_table =3D of_match_ptr(act8945a_of_match),
>  	},
>  	.probe =3D act8945a_i2c_probe,
> -	.remove =3D act8945a_i2c_remove,
>  	.id_table =3D act8945a_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
