From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/27] mfd: Export OF module alias information in missing
 drivers
Date: Mon, 10 Aug 2015 13:48:41 +0100
Message-ID: <20150810124841.GF3249@x1>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
 <1438273132-20926-17-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438273132-20926-17-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 30 Jul 2015, Javier Martinez Canillas wrote:

> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So technically there's no need for a driver to export
> the OF table since currently it's not used.
>=20
> In fact, the I2C device ID table is mandatory for I2C drivers since
> a i2c_device_id is passed to the driver's probe function even if the
> I2C core used the OF table to match the driver.
>=20
> And since the I2C core uses different tables, OF-only drivers needs t=
o
> have duplicated data that has to be kept in sync and also the dev nod=
e
> compatible manufacturer prefix is stripped when reporting the MODALIA=
S.
>=20
> To avoid the above, the I2C core behavior may be changed in the futur=
e
> to not require an I2C device table for OF-only drivers and report the
> OF module alias. So, it's better to also export the OF table to preve=
nt
> breaking module autoloading if that happens.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
>=20
>  drivers/mfd/rt5033.c   | 1 +
>  drivers/mfd/tps65217.c | 1 +
>  drivers/mfd/tps65218.c | 1 +
>  3 files changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> index db395a6c52bc..d60f91619c4a 100644
> --- a/drivers/mfd/rt5033.c
> +++ b/drivers/mfd/rt5033.c
> @@ -124,6 +124,7 @@ static const struct of_device_id rt5033_dt_match[=
] =3D {
>  	{ .compatible =3D "richtek,rt5033", },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, rt5033_dt_match);
> =20
>  static struct i2c_driver rt5033_driver =3D {
>  	.driver =3D {
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index bc455feb42be..55add0453ae9 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -156,6 +156,7 @@ static const struct of_device_id tps65217_of_matc=
h[] =3D {
>  	{ .compatible =3D "ti,tps65217", .data =3D (void *)TPS65217 },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, tps65217_of_match);
> =20
>  static int tps65217_probe(struct i2c_client *client,
>  				const struct i2c_device_id *ids)
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index cb38d725250f..80b9dc363cd8 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -211,6 +211,7 @@ static const struct of_device_id of_tps65218_matc=
h_table[] =3D {
>  	{ .compatible =3D "ti,tps65218", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
> =20
>  static int tps65218_probe(struct i2c_client *client,
>  				const struct i2c_device_id *ids)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
