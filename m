From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/7] mfd: rc5t583: Use devm_mfd_add_devices and
 devm_request_threaded_irq
Date: Thu, 28 Apr 2016 10:08:47 +0100
Message-ID: <20160428090847.GP4892@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-5-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461241558-26983-5-git-send-email-ldewangan@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: milo.kim@ti.com, cw00.choi@samsung.com, k.kozlowski@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 21 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for adding MFD child devices and
> devm_request_threaded_irq() for IRQ registration.
>=20
> This reduces the need of remove callback for removing MFD child
> devices and unregistering IRQ.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/mfd/rc5t583-irq.c | 11 ++---------
>  drivers/mfd/rc5t583.c     | 24 +++---------------------
>  2 files changed, 5 insertions(+), 30 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/rc5t583-irq.c b/drivers/mfd/rc5t583-irq.c
> index 3f8812d..f8dde59 100644
> --- a/drivers/mfd/rc5t583-irq.c
> +++ b/drivers/mfd/rc5t583-irq.c
> @@ -389,17 +389,10 @@ int rc5t583_irq_init(struct rc5t583 *rc5t583, i=
nt irq, int irq_base)
>  		irq_clear_status_flags(__irq, IRQ_NOREQUEST);
>  	}
> =20
> -	ret =3D request_threaded_irq(irq, NULL, rc5t583_irq, IRQF_ONESHOT,
> -				"rc5t583", rc5t583);
> +	ret =3D devm_request_threaded_irq(rc5t583->dev, irq, NULL, rc5t583_=
irq,
> +					IRQF_ONESHOT, "rc5t583", rc5t583);
>  	if (ret < 0)
>  		dev_err(rc5t583->dev,
>  			"Error in registering interrupt error: %d\n", ret);
>  	return ret;
>  }
> -
> -int rc5t583_irq_exit(struct rc5t583 *rc5t583)
> -{
> -	if (rc5t583->chip_irq)
> -		free_irq(rc5t583->chip_irq, rc5t583);
> -	return 0;
> -}
> diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
> index fc2b2d9..d12243d 100644
> --- a/drivers/mfd/rc5t583.c
> +++ b/drivers/mfd/rc5t583.c
> @@ -252,7 +252,6 @@ static int rc5t583_i2c_probe(struct i2c_client *i=
2c,
>  	struct rc5t583 *rc5t583;
>  	struct rc5t583_platform_data *pdata =3D dev_get_platdata(&i2c->dev)=
;
>  	int ret;
> -	bool irq_init_success =3D false;
> =20
>  	if (!pdata) {
>  		dev_err(&i2c->dev, "Err: Platform data not found\n");
> @@ -284,32 +283,16 @@ static int rc5t583_i2c_probe(struct i2c_client =
*i2c,
>  		/* Still continue with warning, if irq init fails */
>  		if (ret)
>  			dev_warn(&i2c->dev, "IRQ init failed: %d\n", ret);
> -		else
> -			irq_init_success =3D true;
>  	}
> =20
> -	ret =3D mfd_add_devices(rc5t583->dev, -1, rc5t583_subdevs,
> -			      ARRAY_SIZE(rc5t583_subdevs), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(rc5t583->dev, -1, rc5t583_subdevs,
> +				   ARRAY_SIZE(rc5t583_subdevs), NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(&i2c->dev, "add mfd devices failed: %d\n", ret);
> -		goto err_add_devs;
> +		return ret;
>  	}
> =20
>  	return 0;
> -
> -err_add_devs:
> -	if (irq_init_success)
> -		rc5t583_irq_exit(rc5t583);
> -	return ret;
> -}
> -
> -static int  rc5t583_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct rc5t583 *rc5t583 =3D i2c_get_clientdata(i2c);
> -
> -	mfd_remove_devices(rc5t583->dev);
> -	rc5t583_irq_exit(rc5t583);
> -	return 0;
>  }
> =20
>  static const struct i2c_device_id rc5t583_i2c_id[] =3D {
> @@ -324,7 +307,6 @@ static struct i2c_driver rc5t583_i2c_driver =3D {
>  		   .name =3D "rc5t583",
>  		   },
>  	.probe =3D rc5t583_i2c_probe,
> -	.remove =3D rc5t583_i2c_remove,
>  	.id_table =3D rc5t583_i2c_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
