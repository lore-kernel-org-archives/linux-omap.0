From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] mfd: as3722: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 10:07:18 +0100
Message-ID: <20160428090718.GN4892@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-2-git-send-email-ldewangan@nvidia.com>
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
> ---
>  drivers/mfd/as3722.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index e1f597f..f87342c 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -385,9 +385,10 @@ static int as3722_i2c_probe(struct i2c_client *i=
2c,
>  		return ret;
> =20
>  	irq_flags =3D as3722->irq_flags | IRQF_ONESHOT;
> -	ret =3D regmap_add_irq_chip(as3722->regmap, as3722->chip_irq,
> -			irq_flags, -1, &as3722_irq_chip,
> -			&as3722->irq_data);
> +	ret =3D devm_regmap_add_irq_chip(as3722->dev, as3722->regmap,
> +				       as3722->chip_irq,
> +				       irq_flags, -1, &as3722_irq_chip,
> +				       &as3722->irq_data);
>  	if (ret < 0) {
>  		dev_err(as3722->dev, "Failed to add regmap irq: %d\n", ret);
>  		return ret;
> @@ -395,33 +396,20 @@ static int as3722_i2c_probe(struct i2c_client *=
i2c,
> =20
>  	ret =3D as3722_configure_pullups(as3722);
>  	if (ret < 0)
> -		goto scrub;
> +		return ret;
> =20
> -	ret =3D mfd_add_devices(&i2c->dev, -1, as3722_devs,
> -			ARRAY_SIZE(as3722_devs), NULL, 0,
> -			regmap_irq_get_domain(as3722->irq_data));
> +	ret =3D devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
> +				   ARRAY_SIZE(as3722_devs), NULL, 0,
> +				   regmap_irq_get_domain(as3722->irq_data));
>  	if (ret) {
>  		dev_err(as3722->dev, "Failed to add MFD devices: %d\n", ret);
> -		goto scrub;
> +		return ret;
>  	}
> =20
>  	device_init_wakeup(as3722->dev, true);
> =20
>  	dev_dbg(as3722->dev, "AS3722 core driver initialized successfully\n=
");
>  	return 0;
> -
> -scrub:
> -	regmap_del_irq_chip(as3722->chip_irq, as3722->irq_data);
> -	return ret;
> -}
> -
> -static int as3722_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct as3722 *as3722 =3D i2c_get_clientdata(i2c);
> -
> -	mfd_remove_devices(as3722->dev);
> -	regmap_del_irq_chip(as3722->chip_irq, as3722->irq_data);
> -	return 0;
>  }
> =20
>  static int __maybe_unused as3722_i2c_suspend(struct device *dev)
> @@ -470,7 +458,6 @@ static struct i2c_driver as3722_i2c_driver =3D {
>  		.pm =3D &as3722_pm_ops,
>  	},
>  	.probe =3D as3722_i2c_probe,
> -	.remove =3D as3722_i2c_remove,
>  	.id_table =3D as3722_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
