From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 19/20] mfd: tps65910: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:32:31 +0100
Message-ID: <20160411093231.GJ7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-20-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-20-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and remove
> the call of mfd_remove_devices() from .remove callback to remove
> MFD child-devices. This is done by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Tony Lindgren <tony@atomide.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
>=20
>  drivers/mfd/tps65910.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index f7ab115..8086e5d 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -510,10 +510,10 @@ static int tps65910_i2c_probe(struct i2c_client=
 *i2c,
>  		pm_power_off =3D tps65910_power_off;
>  	}
> =20
> -	ret =3D mfd_add_devices(tps65910->dev, -1,
> -			      tps65910s, ARRAY_SIZE(tps65910s),
> -			      NULL, 0,
> -			      regmap_irq_get_domain(tps65910->irq_data));
> +	ret =3D devm_mfd_add_devices(tps65910->dev, -1,
> +				   tps65910s, ARRAY_SIZE(tps65910s),
> +				   NULL, 0,
> +				   regmap_irq_get_domain(tps65910->irq_data));
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "mfd_add_devices failed: %d\n", ret);
>  		tps65910_irq_exit(tps65910);
> @@ -528,7 +528,6 @@ static int tps65910_i2c_remove(struct i2c_client =
*i2c)
>  	struct tps65910 *tps65910 =3D i2c_get_clientdata(i2c);
> =20
>  	tps65910_irq_exit(tps65910);
> -	mfd_remove_devices(tps65910->dev);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
