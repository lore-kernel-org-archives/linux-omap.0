From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/10] mfd: tps65218: Remove redundant read wrapper
Date: Tue, 28 Jun 2016 08:00:55 +0100
Message-ID: <20160628070055.GF6720@dell>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467093980-11458-2-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, Keerthy wrote:

> Currently read directly calls the repmap read function. Hence
> remove the redundant wrapper and use regmap read wherever
> needed.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Changes in v3:
>=20
>   * Cleaned up tps65218-pwrbutton and gpio drivers to remove
>     tps65218_reg_read instances.
>=20
>  drivers/gpio/gpio-tps65218.c            |  3 ++-
>  drivers/input/misc/tps65218-pwrbutton.c |  3 ++-
>  drivers/mfd/tps65218.c                  | 16 +---------------
>  drivers/regulator/tps65218-regulator.c  |  3 ++-
>  include/linux/mfd/tps65218.h            |  2 --
>  5 files changed, 7 insertions(+), 20 deletions(-)

I like the idea.  So, as long as the patch is properly build tested:

=46or the MFD part:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps6521=
8.c
> index 0eaeac8..0f9d9bd 100644
> --- a/drivers/gpio/gpio-tps65218.c
> +++ b/drivers/gpio/gpio-tps65218.c
> @@ -16,6 +16,7 @@
>  #include <linux/errno.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/mfd/tps65218.h>
> =20
>  struct tps65218_gpio {
> @@ -30,7 +31,7 @@ static int tps65218_gpio_get(struct gpio_chip *gc, =
unsigned offset)
>  	unsigned int val;
>  	int ret;
> =20
> -	ret =3D tps65218_reg_read(tps65218, TPS65218_REG_ENABLE2, &val);
> +	ret =3D regmap_read(tps65218->regmap, TPS65218_REG_ENABLE2, &val);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/=
misc/tps65218-pwrbutton.c
> index a39b626..2bba8de 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
>  struct tps65218_pwrbutton {
> @@ -36,7 +37,7 @@ static irqreturn_t tps65218_pwr_irq(int irq, void *=
_pwr)
>  	unsigned int reg;
>  	int error;
> =20
> -	error =3D tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
> +	error =3D regmap_read(pwr->tps->regmap, TPS65218_REG_STATUS, &reg);
>  	if (error) {
>  		dev_err(pwr->dev, "can't read register: %d\n", error);
>  		goto out;
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
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
