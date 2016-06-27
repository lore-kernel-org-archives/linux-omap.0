From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] mfd: tps65218: Remove redundant read wrapper
Date: Mon, 27 Jun 2016 13:23:31 +0100
Message-ID: <20160627122331.GB24377@dell>
References: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
 <1467025305-13464-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467025305-13464-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Jun 2016, Keerthy wrote:

> Currently read directly calls the repmap read function. Hence
> remove the redundant wrapper and use regmap read wherever
> needed.
>=20
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/tps65218.c                 | 16 +---------------
>  drivers/regulator/tps65218-regulator.c |  3 ++-
>  include/linux/mfd/tps65218.h           |  2 --
>  3 files changed, 3 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 80b9dc3..f20a531 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -34,20 +34,6 @@
>  #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
> =20
>  /**
> - * tps65218_reg_read: Read a single tps65218 register.
> - *
> - * @tps: Device to read from.
> - * @reg: Register to read.
> - * @val: Contians the value
> - */
> -int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
> -			unsigned int *val)
> -{
> -	return regmap_read(tps->regmap, reg, val);
> -}
> -EXPORT_SYMBOL_GPL(tps65218_reg_read);
> -

What about the calls in the GPIO and Misc drivers?

> -/**
>   * tps65218_reg_write: Write a single tps65218 register.
>   *
>   * @tps65218: Device to write to.
> @@ -93,7 +79,7 @@ static int tps65218_update_bits(struct tps65218 *tp=
s, unsigned int reg,
>  	int ret;
>  	unsigned int data;
> =20
> -	ret =3D tps65218_reg_read(tps, reg, &data);
> +	ret =3D regmap_read(tps->regmap, reg, &data);
>  	if (ret) {
>  		dev_err(tps->dev, "Read from reg 0x%x failed\n", reg);
>  		return ret;
> diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulat=
or/tps65218-regulator.c
> index a5e5634..679ab2f 100644
> --- a/drivers/regulator/tps65218-regulator.c
> +++ b/drivers/regulator/tps65218-regulator.c
> @@ -22,6 +22,7 @@
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/of_regulator.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> @@ -224,7 +225,7 @@ static int tps65218_pmic_get_current_limit(struct=
 regulator_dev *dev)
>  	unsigned int index;
>  	struct tps65218 *tps =3D rdev_get_drvdata(dev);
> =20
> -	retval =3D tps65218_reg_read(tps, dev->desc->csel_reg, &index);
> +	retval =3D regmap_read(tps->regmap, dev->desc->csel_reg, &index);
>  	if (retval < 0)
>  		return retval;
> =20
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps6521=
8.h
> index d58f3b5..7c9241f 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -276,8 +276,6 @@ struct tps65218 {
>  	struct regmap *regmap;
>  };
> =20
> -int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
> -					unsigned int *val);
>  int tps65218_reg_write(struct tps65218 *tps, unsigned int reg,
>  			unsigned int val, unsigned int level);
>  int tps65218_set_bits(struct tps65218 *tps, unsigned int reg,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
