From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 10:08:03 +0100
Message-ID: <20160428090803.GO4892@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
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
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max77686.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 7a0457e..7b68ed7 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -230,38 +230,24 @@ static int max77686_i2c_probe(struct i2c_client=
 *i2c,
>  		return -ENODEV;
>  	}
> =20
> -	ret =3D regmap_add_irq_chip(max77686->regmap, max77686->irq,
> -				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> -				  IRQF_SHARED, 0, irq_chip,
> -				  &max77686->irq_data);
> +	ret =3D devm_regmap_add_irq_chip(&i2c->dev, max77686->regmap,
> +				       max77686->irq,
> +				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +				       IRQF_SHARED, 0, irq_chip,
> +				       &max77686->irq_data);
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
>  		return ret;
>  	}
> =20
> -	ret =3D mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, =
NULL);
> +	ret =3D devm_mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL=
,
> +				   0, NULL);
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> -		goto err_del_irqc;
> +		return ret;
>  	}
> =20
>  	return 0;
> -
> -err_del_irqc:
> -	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
> -
> -	return ret;
> -}
> -
> -static int max77686_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct max77686_dev *max77686 =3D i2c_get_clientdata(i2c);
> -
> -	mfd_remove_devices(max77686->dev);
> -
> -	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
> -
> -	return 0;
>  }
> =20
>  static const struct i2c_device_id max77686_i2c_id[] =3D {
> @@ -317,7 +303,6 @@ static struct i2c_driver max77686_i2c_driver =3D =
{
>  		   .of_match_table =3D of_match_ptr(max77686_pmic_dt_match),
>  	},
>  	.probe =3D max77686_i2c_probe,
> -	.remove =3D max77686_i2c_remove,
>  	.id_table =3D max77686_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
