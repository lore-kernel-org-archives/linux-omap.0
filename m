From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/7] mfd: sec: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 10:10:01 +0100
Message-ID: <20160428091001.GA19259@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-6-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-6-git-send-email-ldewangan@nvidia.com>
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
> CC: Sangbeom Kim <sbkim73@samsung.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: linux-samsung-soc@vger.kernel.org
> ---
>  drivers/mfd/sec-core.c | 20 +++-----------------
>  drivers/mfd/sec-irq.c  | 14 +++++---------
>  2 files changed, 8 insertions(+), 26 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index 400e1d7..ca6b80d 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -481,29 +481,16 @@ static int sec_pmic_probe(struct i2c_client *i2=
c,
>  		/* If this happens the probe function is problem */
>  		BUG();
>  	}
> -	ret =3D mfd_add_devices(sec_pmic->dev, -1, sec_devs, num_sec_devs, =
NULL,
> -			      0, NULL);
> +	ret =3D devm_mfd_add_devices(sec_pmic->dev, -1, sec_devs, num_sec_d=
evs,
> +				   NULL, 0, NULL);
>  	if (ret)
> -		goto err_mfd;
> +		return ret;
> =20
>  	device_init_wakeup(sec_pmic->dev, sec_pmic->wakeup);
>  	sec_pmic_configure(sec_pmic);
>  	sec_pmic_dump_rev(sec_pmic);
> =20
>  	return ret;
> -
> -err_mfd:
> -	sec_irq_exit(sec_pmic);
> -	return ret;
> -}
> -
> -static int sec_pmic_remove(struct i2c_client *i2c)
> -{
> -	struct sec_pmic_dev *sec_pmic =3D i2c_get_clientdata(i2c);
> -
> -	mfd_remove_devices(sec_pmic->dev);
> -	sec_irq_exit(sec_pmic);
> -	return 0;
>  }
> =20
>  static void sec_pmic_shutdown(struct i2c_client *i2c)
> @@ -583,7 +570,6 @@ static struct i2c_driver sec_pmic_driver =3D {
>  		   .of_match_table =3D of_match_ptr(sec_dt_match),
>  	},
>  	.probe =3D sec_pmic_probe,
> -	.remove =3D sec_pmic_remove,
>  	.shutdown =3D sec_pmic_shutdown,
>  	.id_table =3D sec_pmic_id,
>  };
> diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
> index d77de43..5eb59c233d5 100644
> --- a/drivers/mfd/sec-irq.c
> +++ b/drivers/mfd/sec-irq.c
> @@ -483,10 +483,11 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>  		return -EINVAL;
>  	}
> =20
> -	ret =3D regmap_add_irq_chip(sec_pmic->regmap_pmic, sec_pmic->irq,
> -			  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -			  sec_pmic->irq_base, sec_irq_chip,
> -			  &sec_pmic->irq_data);
> +	ret =3D devm_regmap_add_irq_chip(sec_pmic->dev, sec_pmic->regmap_pm=
ic,
> +				       sec_pmic->irq,
> +				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				       sec_pmic->irq_base, sec_irq_chip,
> +				       &sec_pmic->irq_data);
>  	if (ret !=3D 0) {
>  		dev_err(sec_pmic->dev, "Failed to register IRQ chip: %d\n", ret);
>  		return ret;
> @@ -500,8 +501,3 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
> =20
>  	return 0;
>  }
> -
> -void sec_irq_exit(struct sec_pmic_dev *sec_pmic)
> -{
> -	regmap_del_irq_chip(sec_pmic->irq, sec_pmic->irq_data);
> -}

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
