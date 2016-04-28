From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/7] mfd: tps65910: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 10:10:49 +0100
Message-ID: <20160428091049.GB19259@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-7-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-7-git-send-email-ldewangan@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: milo.kim@ti.com, cw00.choi@samsung.com, k.kozlowski@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 21 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for adding MFD child devices and
> devm_regmap_add_irq_chip() for IRQ chip registration.
>=20
> This reduces the error code path and .remove callback for removing
> MFD child devices and deleting IRQ chip data.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/tps65910.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 8086e5d..11cab15 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -252,9 +252,10 @@ static int tps65910_irq_init(struct tps65910 *tp=
s65910, int irq,
>  	}
> =20
>  	tps65910->chip_irq =3D irq;
> -	ret =3D regmap_add_irq_chip(tps65910->regmap, tps65910->chip_irq,
> -		IRQF_ONESHOT, pdata->irq_base,
> -		tps6591x_irqs_chip, &tps65910->irq_data);
> +	ret =3D devm_regmap_add_irq_chip(tps65910->dev, tps65910->regmap,
> +				       tps65910->chip_irq,
> +				       IRQF_ONESHOT, pdata->irq_base,
> +				       tps6591x_irqs_chip, &tps65910->irq_data);
>  	if (ret < 0) {
>  		dev_warn(tps65910->dev, "Failed to add irq_chip %d\n", ret);
>  		tps65910->chip_irq =3D 0;
> @@ -262,13 +263,6 @@ static int tps65910_irq_init(struct tps65910 *tp=
s65910, int irq,
>  	return ret;
>  }
> =20
> -static int tps65910_irq_exit(struct tps65910 *tps65910)
> -{
> -	if (tps65910->chip_irq > 0)
> -		regmap_del_irq_chip(tps65910->chip_irq, tps65910->irq_data);
> -	return 0;
> -}
> -
>  static bool is_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	struct tps65910 *tps65910 =3D dev_get_drvdata(dev);
> @@ -516,22 +510,12 @@ static int tps65910_i2c_probe(struct i2c_client=
 *i2c,
>  				   regmap_irq_get_domain(tps65910->irq_data));
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "mfd_add_devices failed: %d\n", ret);
> -		tps65910_irq_exit(tps65910);
>  		return ret;
>  	}
> =20
>  	return ret;
>  }
> =20
> -static int tps65910_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct tps65910 *tps65910 =3D i2c_get_clientdata(i2c);
> -
> -	tps65910_irq_exit(tps65910);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tps65910_i2c_id[] =3D {
>         { "tps65910", TPS65910 },
>         { "tps65911", TPS65911 },
> @@ -546,7 +530,6 @@ static struct i2c_driver tps65910_i2c_driver =3D =
{
>  		   .of_match_table =3D of_match_ptr(tps65910_of_match),
>  	},
>  	.probe =3D tps65910_i2c_probe,
> -	.remove =3D tps65910_i2c_remove,
>  	.id_table =3D tps65910_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
