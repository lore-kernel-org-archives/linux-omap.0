From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Add initial support
Date: Tue, 2 Aug 2011 15:31:48 +0300
Message-ID: <20110802123147.GE7951@legolas.emea.dhcp.ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:58634 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754336Ab1HBMbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 08:31:52 -0400
Received: by mail-ey0-f177.google.com with SMTP id 6so5464168eyh.36
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 05:31:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 02, 2011 at 02:28:41PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> TWL6040 IC provides analog high-end audio codec functions for
> handset applications. It contains several audio analog inputs
> and outputs as well as vibrator support. It's connected to the
> host processor via PDM interface for audio data communication.
> The audio modules are controlled by internal registers that
> can be accessed by I2C and PDM interface.
>=20
> TWL6040 MFD will be registered as a child of TWL-CORE, and will
> have two children of its own: twl6040-codec and twl6040-vibra.
>=20
> This driver is based on TWL4030 and WM8350 MFD drivers.
>=20
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/irqs.h |   12 +-
>  drivers/mfd/Kconfig                    |    6 +
>  drivers/mfd/Makefile                   |    1 +
>  drivers/mfd/twl-core.c                 |    4 +-
>  drivers/mfd/twl6040-codec.c            |  587 ++++++++++++++++++++++++++=
++++++
>  drivers/mfd/twl6040-irq.c              |  205 +++++++++++
>  include/linux/i2c/twl.h                |    1 +
>  include/linux/mfd/twl6040-codec.h      |  260 ++++++++++++++
>  8 files changed, 1072 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/mfd/twl6040-codec.c
>  create mode 100644 drivers/mfd/twl6040-irq.c
>  create mode 100644 include/linux/mfd/twl6040-codec.h
>=20
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/=
include/plat/irqs.h
> index 5a25098..2cfba51 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -407,11 +407,19 @@
>  #endif
>  #define TWL6030_IRQ_END		(TWL6030_IRQ_BASE + TWL6030_BASE_NR_IRQS)
> =20
> +#define TWL6040_CODEC_IRQ_BASE	TWL6030_IRQ_END
> +#ifdef CONFIG_TWL6040_CODEC
> +#define TWL6040_CODEC_NR_IRQS	6
> +#else
> +#define TWL6040_CODEC_NR_IRQS	0
> +#endif
> +#define TWL6040_CODEC_IRQ_END	(TWL6040_CODEC_IRQ_BASE + TWL6040_CODEC_NR=
_IRQS)

since this is a new driver, please don't pullute this header and use
irq_alloc_descs() instead ?!?

> diff --git a/drivers/mfd/twl6040-codec.c b/drivers/mfd/twl6040-codec.c
> new file mode 100644
> index 0000000..a40cd07
> --- /dev/null
> +++ b/drivers/mfd/twl6040-codec.c
> @@ -0,0 +1,587 @@
> +/*
> + * MFD driver for TWL6040 codec submodule
> + *
> + * Authors:	Misael Lopez Cruz <misael.lopez@ti.com>
> + *		Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> + *
> + * Copyright:	(C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/twl6040-codec.h>
> +
> +static struct platform_device *twl6040_dev;

this is useless, see below.

> +int twl6040_reg_read(struct twl6040 *twl6040, unsigned int reg)
> +{
> +	int ret;
> +	u8 val =3D 0;
> +
> +	mutex_lock(&twl6040->io_mutex);
> +	ret =3D twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
> +	if (ret < 0) {
> +		mutex_unlock(&twl6040->io_mutex);
> +		return ret;
> +	}
> +	mutex_unlock(&twl6040->io_mutex);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(twl6040_reg_read);

EXPORT_SYMBOL_GPL(), all users of this should be GPL so we have access
to the code. Ditto to all below.

> +int twl6040_reg_write(struct twl6040 *twl6040, unsigned int reg, u8 val)
> +{
> +	int ret;
> +
> +	mutex_lock(&twl6040->io_mutex);
> +	ret =3D twl_i2c_write_u8(TWL_MODULE_AUDIO_VOICE, val, reg);
> +	mutex_unlock(&twl6040->io_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6040_reg_write);
> +
> +int twl6040_set_bits(struct twl6040 *twl6040, unsigned int reg, u8 mask)
> +{
> +	int ret;
> +	u8 val;
> +
> +	mutex_lock(&twl6040->io_mutex);
> +	ret =3D twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
> +	if (ret)
> +		goto out;
> +
> +	val |=3D mask;
> +	ret =3D twl_i2c_write_u8(TWL_MODULE_AUDIO_VOICE, val, reg);
> +out:
> +	mutex_unlock(&twl6040->io_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6040_set_bits);
> +
> +int twl6040_clear_bits(struct twl6040 *twl6040, unsigned int reg, u8 mas=
k)
> +{
> +	int ret;
> +	u8 val;
> +
> +	mutex_lock(&twl6040->io_mutex);
> +	ret =3D twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, reg);
> +	if (ret)
> +		goto out;
> +
> +	val &=3D ~mask;
> +	ret =3D twl_i2c_write_u8(TWL_MODULE_AUDIO_VOICE, val, reg);
> +out:
> +	mutex_unlock(&twl6040->io_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6040_clear_bits);
> +
> +/* twl6040 codec manual power-up sequence */
> +static int twl6040_power_up(struct twl6040 *twl6040)
> +{
> +	u8 ldoctl, ncpctl, lppllctl;
> +	int ret;
> +
> +	/* enable high-side LDO, reference system and internal oscillator */
> +	ldoctl =3D TWL6040_HSLDOENA | TWL6040_REFENA | TWL6040_OSCENA;
> +	ret =3D twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +	if (ret)
> +		return ret;
> +	usleep_range(10000, 10500);
> +
> +	/* enable negative charge pump */
> +	ncpctl =3D TWL6040_NCPENA;
> +	ret =3D twl6040_reg_write(twl6040, TWL6040_REG_NCPCTL, ncpctl);
> +	if (ret)
> +		goto ncp_err;
> +	usleep_range(1000, 1500);
> +
> +	/* enable low-side LDO */
> +	ldoctl |=3D TWL6040_LSLDOENA;
> +	ret =3D twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +	if (ret)
> +		goto lsldo_err;
> +	usleep_range(1000, 1500);
> +
> +	/* enable low-power PLL */
> +	lppllctl =3D TWL6040_LPLLENA;
> +	ret =3D twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +	if (ret)
> +		goto lppll_err;
> +	usleep_range(5000, 5500);
> +
> +	/* disable internal oscillator */
> +	ldoctl &=3D ~TWL6040_OSCENA;
> +	ret =3D twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +	if (ret)
> +		goto osc_err;
> +
> +	return 0;
> +
> +osc_err:
> +	lppllctl &=3D ~TWL6040_LPLLENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +lppll_err:
> +	ldoctl &=3D ~TWL6040_LSLDOENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +lsldo_err:
> +	ncpctl &=3D ~TWL6040_NCPENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_NCPCTL, ncpctl);
> +ncp_err:
> +	ldoctl &=3D ~(TWL6040_HSLDOENA | TWL6040_REFENA | TWL6040_OSCENA);
> +	twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +
> +	return ret;
> +}
> +
> +/* twl6040 codec manual power-down sequence */
> +static void twl6040_power_down(struct twl6040 *twl6040)
> +{
> +	u8 ncpctl, ldoctl, lppllctl;
> +
> +	ncpctl =3D twl6040_reg_read(twl6040, TWL6040_REG_NCPCTL);
> +	ldoctl =3D twl6040_reg_read(twl6040, TWL6040_REG_LDOCTL);
> +	lppllctl =3D twl6040_reg_read(twl6040, TWL6040_REG_LPPLLCTL);
> +
> +	/* enable internal oscillator */
> +	ldoctl |=3D TWL6040_OSCENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +	usleep_range(1000, 1500);
> +
> +	/* disable low-power PLL */
> +	lppllctl &=3D ~TWL6040_LPLLENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +
> +	/* disable low-side LDO */
> +	ldoctl &=3D ~TWL6040_LSLDOENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +
> +	/* disable negative charge pump */
> +	ncpctl &=3D ~TWL6040_NCPENA;
> +	twl6040_reg_write(twl6040, TWL6040_REG_NCPCTL, ncpctl);
> +
> +	/* disable high-side LDO, reference system and internal oscillator */
> +	ldoctl &=3D ~(TWL6040_HSLDOENA | TWL6040_REFENA | TWL6040_OSCENA);
> +	twl6040_reg_write(twl6040, TWL6040_REG_LDOCTL, ldoctl);
> +}
> +
> +static irqreturn_t twl6040_naudint_handler(int irq, void *data)
> +{
> +	struct twl6040 *twl6040 =3D data;
> +	u8 intid;
> +
> +	intid =3D twl6040_reg_read(twl6040, TWL6040_REG_INTID);
> +
> +	if (intid & TWL6040_READYINT)
> +		complete(&twl6040->ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int twl6040_power_up_completion(struct twl6040 *twl6040,
> +				       int naudint)
> +{
> +	int time_left;
> +	u8 intid;
> +
> +	time_left =3D wait_for_completion_timeout(&twl6040->ready,
> +						msecs_to_jiffies(144));

should this be interruptible ?

> +	if (!time_left) {
> +		intid =3D twl6040_reg_read(twl6040, TWL6040_REG_INTID);
> +		if (!(intid & TWL6040_READYINT)) {
> +			dev_err(&twl6040_dev->dev,

you have twl6040 as argument to this function, meaning:

dev_err(twl6040->dev,

should work just fine.

> +int twl6040_power(struct twl6040 *twl6040, int on)
> +{
> +	int audpwron =3D twl6040->audpwron;
> +	int naudint =3D twl6040->irq;
> +	int ret =3D 0;
> +
> +	mutex_lock(&twl6040->mutex);
> +
> +	if (on) {
> +		/* already powered-up */
> +		if (twl6040->power_count++)
> +			goto out;
> +
> +		if (gpio_is_valid(audpwron)) {
> +			/* use AUDPWRON line */
> +			gpio_set_value(audpwron, 1);
> +			/* wait for power-up completion */
> +			ret =3D twl6040_power_up_completion(twl6040, naudint);
> +			if (ret) {
> +				dev_err(&twl6040_dev->dev,

ditto here and all below.

> +					"automatic power-down failed\n");
> +				twl6040->power_count =3D 0;
> +				goto out;
> +			}
> +		} else {
> +			/* use manual power-up sequence */
> +			ret =3D twl6040_power_up(twl6040);
> +			if (ret) {
> +				dev_err(&twl6040_dev->dev,
> +					"manual power-up failed\n");
> +				twl6040->power_count =3D 0;
> +				goto out;
> +			}
> +		}
> +		twl6040->pll =3D TWL6040_LPPLL_ID;
> +		twl6040->sysclk =3D 19200000;
> +	} else {
> +		/* already powered-down */
> +		if (!twl6040->power_count) {
> +			dev_err(&twl6040_dev->dev,
> +				"device is already powered-off\n");
> +			ret =3D -EPERM;
> +			goto out;
> +		}
> +
> +		if (--twl6040->power_count)
> +			goto out;
> +
> +		if (gpio_is_valid(audpwron)) {
> +			/* use AUDPWRON line */
> +			gpio_set_value(audpwron, 0);
> +
> +			/* power-down sequence latency */
> +			udelay(500);
> +		} else {
> +			/* use manual power-down sequence */
> +			twl6040_power_down(twl6040);
> +		}
> +		twl6040->pll =3D TWL6040_NOPLL_ID;
> +		twl6040->sysclk =3D 0;
> +	}
> +
> +out:
> +	mutex_unlock(&twl6040->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6040_power);

should this function be a ->runtime_resume/suspend method ? Then
children would simply pm_runtime_get_sync() and this would be called by
the pm runtime framework. Does it make sense ?

> +int twl6040_is_powered(struct twl6040 *twl6040)
> +{
> +	return twl6040->power_count;
> +}
> +EXPORT_SYMBOL(twl6040_is_powered);

I'm not sure this should be needed. You allocate your children yourself,
so they will only probe after this has succesfully probed, rendering
this unneeded, right ?

> +int twl6040_set_pll(struct twl6040 *twl6040, enum twl6040_pll_id id,
> +		    unsigned int freq_in, unsigned int freq_out)
> +{
> +	u8 hppllctl, lppllctl;
> +	int ret =3D 0;
> +
> +	mutex_lock(&twl6040->mutex);
> +
> +	hppllctl =3D twl6040_reg_read(twl6040, TWL6040_REG_HPPLLCTL);
> +	lppllctl =3D twl6040_reg_read(twl6040, TWL6040_REG_LPPLLCTL);
> +
> +	switch (id) {
> +	case TWL6040_LPPLL_ID:
> +		/* low-power PLL divider */
> +		switch (freq_out) {
> +		case 17640000:
> +			lppllctl |=3D TWL6040_LPLLFIN;
> +			break;
> +		case 19200000:
> +			lppllctl &=3D ~TWL6040_LPLLFIN;
> +			break;
> +		default:
> +			dev_err(&twl6040_dev->dev,

also don't need that global static pointer. twl6040->dev. Ditto all
below

> +				"freq_out %d not supported\n", freq_out);
> +			ret =3D -EINVAL;
> +			goto pll_out;
> +		}
> +		twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +
> +		switch (freq_in) {
> +		case 32768:
> +			lppllctl |=3D TWL6040_LPLLENA;
> +			twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL,
> +					  lppllctl);
> +			mdelay(5);
> +			lppllctl &=3D ~TWL6040_HPLLSEL;
> +			twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL,
> +					  lppllctl);
> +			hppllctl &=3D ~TWL6040_HPLLENA;
> +			twl6040_reg_write(twl6040, TWL6040_REG_HPPLLCTL,
> +					  hppllctl);
> +			break;
> +		default:
> +			dev_err(&twl6040_dev->dev,
> +				"freq_in %d not supported\n", freq_in);
> +			ret =3D -EINVAL;
> +			goto pll_out;
> +		}
> +
> +		twl6040->pll =3D TWL6040_LPPLL_ID;
> +		break;
> +	case TWL6040_HPPLL_ID:
> +		/* high-performance PLL can provide only 19.2 MHz */
> +		if (freq_out !=3D 19200000) {
> +			dev_err(&twl6040_dev->dev,
> +				"freq_out %d not supported\n", freq_out);
> +			ret =3D -EINVAL;
> +			goto pll_out;
> +		}
> +
> +		hppllctl &=3D ~TWL6040_MCLK_MSK;
> +
> +		switch (freq_in) {
> +		case 12000000:
> +			/* PLL enabled, active mode */
> +			hppllctl |=3D TWL6040_MCLK_12000KHZ |
> +				    TWL6040_HPLLENA;
> +			break;
> +		case 19200000:
> +			/*
> +			 * PLL disabled
> +			 * (enable PLL if MCLK jitter quality
> +			 *  doesn't meet specification)
> +			 */
> +			hppllctl |=3D TWL6040_MCLK_19200KHZ;
> +			break;
> +		case 26000000:
> +			/* PLL enabled, active mode */
> +			hppllctl |=3D TWL6040_MCLK_26000KHZ |
> +				    TWL6040_HPLLENA;
> +			break;
> +		case 38400000:
> +			/* PLL enabled, active mode */
> +			hppllctl |=3D TWL6040_MCLK_38400KHZ |
> +				    TWL6040_HPLLENA;
> +			break;
> +		default:
> +			dev_err(&twl6040_dev->dev,
> +				"freq_in %d not supported\n", freq_in);
> +			ret =3D -EINVAL;
> +			goto pll_out;
> +		}
> +
> +		/* enable clock slicer to ensure input waveform is square */
> +		hppllctl |=3D TWL6040_HPLLSQRENA;
> +
> +		twl6040_reg_write(twl6040, TWL6040_REG_HPPLLCTL, hppllctl);
> +		udelay(500);
> +		lppllctl |=3D TWL6040_HPLLSEL;
> +		twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +		lppllctl &=3D ~TWL6040_LPLLENA;
> +		twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL, lppllctl);
> +
> +		twl6040->pll =3D TWL6040_HPPLL_ID;
> +		break;
> +	default:
> +		dev_err(&twl6040_dev->dev, "unknown pll id %d\n", id);
> +		ret =3D -EINVAL;
> +		goto pll_out;
> +	}
> +
> +	twl6040->sysclk =3D freq_out;
> +
> +pll_out:
> +	mutex_unlock(&twl6040->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(twl6040_set_pll);
> +
> +enum twl6040_pll_id twl6040_get_pll(struct twl6040 *twl6040)
> +{
> +	return twl6040->pll;
> +}
> +EXPORT_SYMBOL(twl6040_get_pll);
> +
> +unsigned int twl6040_get_sysclk(struct twl6040 *twl6040)
> +{
> +	return twl6040->sysclk;
> +}
> +EXPORT_SYMBOL(twl6040_get_sysclk);

these three above look like they should be done via clk framework ??

> +static int __devinit twl6040_probe(struct platform_device *pdev)
> +{
> +	struct twl4030_codec_data *pdata =3D pdev->dev.platform_data;
> +	struct twl6040 *twl6040;
> +	struct mfd_cell *cell =3D NULL;
> +	int ret, children =3D 0;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Platform data is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	twl6040 =3D kzalloc(sizeof(struct twl6040), GFP_KERNEL);

sizeof(*twl6040) would allow to change the type without need to patch
this line. It's what's generally done on most drivers.

> +	if (!twl6040)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, twl6040);
> +
> +	twl6040_dev =3D pdev;

this is useless.

> +	twl6040->dev =3D &pdev->dev;
> +	twl6040->audpwron =3D pdata->audpwron_gpio;
> +	twl6040->irq =3D pdata->naudint_irq;
> +	twl6040->irq_base =3D pdata->irq_base;
> +
> +	mutex_init(&twl6040->mutex);
> +	mutex_init(&twl6040->io_mutex);
> +	init_completion(&twl6040->ready);
> +
> +	twl6040->rev =3D twl6040_reg_read(twl6040, TWL6040_REG_ASICREV);
> +
> +	if (gpio_is_valid(twl6040->audpwron)) {
> +		ret =3D gpio_request(twl6040->audpwron, "audpwron");
> +		if (ret)
> +			goto gpio1_err;
> +
> +		ret =3D gpio_direction_output(twl6040->audpwron, 0);
> +		if (ret)
> +			goto gpio2_err;
> +	}

what if gpio isn't valid ? Does it make sense to continue ? Is the GPIO
poweron pin a "must-have" or can you tie that pin to Vcc (or ground,
depending if it's active high or low) and have it working ?

> +	/* ERRATA: Automatic power-up is not possible in ES1.0 */
> +	if (twl6040_get_rev(twl6040) =3D=3D TWL6040_REV_ES1_0)
> +		twl6040->audpwron =3D -EINVAL;
> +
> +	if (twl6040->irq) {
> +		/* codec interrupt */
> +		ret =3D twl6040_irq_init(twl6040);
> +		if (ret)
> +			goto gpio2_err;
> +
> +		ret =3D twl6040_request_irq(twl6040, TWL6040_IRQ_READY,

this is really wrong. Didn't we agree on using tradicional
request_threaded_irq() here ? Also, the IRQ number should be passed via
struct resource.

> +					  twl6040_naudint_handler, 0,
> +					  "twl6040_irq_ready", twl6040);
> +		if (ret) {
> +			dev_err(twl6040->dev, "READY IRQ request failed: %d\n",
> +				ret);
> +			goto irq_err;
> +		}
> +	}
> +
> +	/* dual-access registers controlled by I2C only */
> +	twl6040_set_bits(twl6040, TWL6040_REG_ACCCTL, TWL6040_I2CSEL);
> +
> +	if (pdata->audio) {
> +		cell =3D &twl6040->cells[children];
> +		cell->name =3D "twl6040-codec";
> +		cell->platform_data =3D pdata->audio;
> +		cell->pdata_size =3D sizeof(*pdata->audio);
> +		children++;
> +	}
> +
> +	if (pdata->vibra) {
> +		cell =3D &twl6040->cells[children];
> +		cell->name =3D "twl6040-vibra";
> +		cell->platform_data =3D pdata->vibra;
> +		cell->pdata_size =3D sizeof(*pdata->vibra);
> +		children++;
> +	}
> +
> +	if (children) {
> +		ret =3D mfd_add_devices(&pdev->dev, pdev->id, twl6040->cells,
> +				      children, NULL, 0);
> +		if (ret)
> +			goto mfd_err;
> +	} else {
> +		dev_err(&pdev->dev, "No platform data found for children\n");
> +		ret =3D -ENODEV;
> +		goto mfd_err;
> +	}
> +
> +	return 0;
> +
> +mfd_err:
> +	if (twl6040->irq)
> +		twl6040_free_irq(twl6040, TWL6040_IRQ_READY, twl6040);
> +irq_err:
> +	if (twl6040->irq)
> +		twl6040_irq_exit(twl6040);
> +gpio2_err:
> +	if (gpio_is_valid(twl6040->audpwron))
> +		gpio_free(twl6040->audpwron);
> +gpio1_err:
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(twl6040);
> +	twl6040_dev =3D NULL;
> +	return ret;
> +}
> +
> +static int __devexit twl6040_remove(struct platform_device *pdev)
> +{
> +	struct twl6040 *twl6040 =3D platform_get_drvdata(pdev);
> +
> +	if (twl6040_is_powered(twl6040))
> +		twl6040_power(twl6040, 0);

disabling it twice, shouldn't be a problem, so this is also useless
check.

> +	if (gpio_is_valid(twl6040->audpwron))
> +		gpio_free(twl6040->audpwron);
> +
> +	twl6040_free_irq(twl6040, TWL6040_IRQ_READY, twl6040);

this has to be passed via struct resource.

> +	if (twl6040->irq)
> +		twl6040_irq_exit(twl6040);
> +
> +	mfd_remove_devices(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(twl6040);
> +	twl6040_dev =3D NULL;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver twl6040_driver =3D {
> +	.probe		=3D twl6040_probe,
> +	.remove		=3D __devexit_p(twl6040_remove),
> +	.driver		=3D {
> +		.owner	=3D THIS_MODULE,
> +		.name	=3D "twl6040-audio",
> +	},
> +};
> +
> +static int __devinit twl6040_init(void)
> +{
> +	return platform_driver_register(&twl6040_driver);
> +}
> +module_init(twl6040_init);
> +
> +static void __devexit twl6040_exit(void)
> +{
> +	platform_driver_unregister(&twl6040_driver);
> +}
> +
> +module_exit(twl6040_exit);
> +
> +MODULE_DESCRIPTION("TWL6040 MFD");
> +MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
> +MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:twl6040-audio");
> diff --git a/drivers/mfd/twl6040-irq.c b/drivers/mfd/twl6040-irq.c
> new file mode 100644
> index 0000000..ac776be
> --- /dev/null
> +++ b/drivers/mfd/twl6040-irq.c
> @@ -0,0 +1,205 @@
> +/*
> + * Interrupt controller support for TWL6040
> + *
> + * Author:     Misael Lopez Cruz <misael.lopez@ti.com>
> + *
> + * Copyright:   (C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/twl6040-codec.h>
> +
> +struct twl6040_irq_data {
> +	int mask;
> +	int status;
> +};
> +
> +static struct twl6040_irq_data twl6040_irqs[] =3D {
> +	{
> +		.mask =3D TWL6040_THMSK,
> +		.status =3D TWL6040_THINT,
> +	},
> +	{
> +		.mask =3D TWL6040_PLUGMSK,
> +		.status =3D TWL6040_PLUGINT | TWL6040_UNPLUGINT,
> +	},
> +	{
> +		.mask =3D TWL6040_HOOKMSK,
> +		.status =3D TWL6040_HOOKINT,
> +	},
> +	{
> +		.mask =3D TWL6040_HFMSK,
> +		.status =3D TWL6040_HFINT,
> +	},
> +	{
> +		.mask =3D TWL6040_VIBMSK,
> +		.status =3D TWL6040_VIBINT,
> +	},
> +	{
> +		.mask =3D TWL6040_READYMSK,
> +		.status =3D TWL6040_READYINT,
> +	},
> +};
> +
> +static inline
> +struct twl6040_irq_data *irq_to_twl6040_irq(struct twl6040 *twl6040,
> +					    int irq)
> +{
> +	return &twl6040_irqs[irq - twl6040->irq_base];
> +}
> +
> +static void twl6040_irq_lock(struct irq_data *data)
> +{
> +	struct twl6040 *twl6040 =3D irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&twl6040->irq_mutex);
> +}
> +
> +static void twl6040_irq_sync_unlock(struct irq_data *data)
> +{
> +	struct twl6040 *twl6040 =3D irq_data_get_irq_chip_data(data);
> +
> +	/* write back to hardware any change in irq mask */
> +	if (twl6040->irq_masks_cur !=3D twl6040->irq_masks_cache) {
> +		twl6040->irq_masks_cache =3D twl6040->irq_masks_cur;
> +		twl6040_reg_write(twl6040, TWL6040_REG_INTMR,
> +				  twl6040->irq_masks_cur);
> +	}
> +
> +	mutex_unlock(&twl6040->irq_mutex);
> +}
> +
> +static void twl6040_irq_enable(struct irq_data *data)
> +{
> +	struct twl6040 *twl6040 =3D irq_data_get_irq_chip_data(data);
> +	struct twl6040_irq_data *irq_data =3D irq_to_twl6040_irq(twl6040,
> +							       data->irq);
> +
> +	twl6040->irq_masks_cur &=3D ~irq_data->mask;
> +}
> +
> +static void twl6040_irq_disable(struct irq_data *data)
> +{
> +	struct twl6040 *twl6040 =3D irq_data_get_irq_chip_data(data);
> +	struct twl6040_irq_data *irq_data =3D irq_to_twl6040_irq(twl6040,
> +							       data->irq);
> +
> +	twl6040->irq_masks_cur |=3D irq_data->mask;
> +}
> +
> +static struct irq_chip twl6040_irq_chip =3D {
> +	.name			=3D "twl6040",
> +	.irq_bus_lock		=3D twl6040_irq_lock,
> +	.irq_bus_sync_unlock	=3D twl6040_irq_sync_unlock,
> +	.irq_enable		=3D twl6040_irq_enable,
> +	.irq_disable		=3D twl6040_irq_disable,
> +};
> +
> +static irqreturn_t twl6040_irq_thread(int irq, void *data)
> +{
> +	struct twl6040 *twl6040 =3D data;
> +	u8 intid;
> +	int i;
> +
> +	intid =3D twl6040_reg_read(twl6040, TWL6040_REG_INTID);

what's available on this register ?? Are the status fields above bit
positions ? If so you can change this:

> +	/* apply masking and report (backwards to handle READYINT first) */
> +	for (i =3D ARRAY_SIZE(twl6040_irqs) - 1; i >=3D 0; i--) {
> +		if (twl6040->irq_masks_cur & twl6040_irqs[i].mask)
> +			intid &=3D ~twl6040_irqs[i].status;
> +		if (intid & twl6040_irqs[i].status)
> +			handle_nested_irq(twl6040->irq_base + i);
> +	}

into something like this:

	while (intid) {
		unsigned long pending =3D __ffs(intid);
		unsigned long irq;

		intid &=3D ~BIT(pending);
		irq =3D pending + twl6040->irq_base;
		handle_nested_irq(irq);
	}

and that twl6040_irq_data structure can go into the bin.

> +	/* ack unmasked irqs */
> +	twl6040_reg_write(twl6040, TWL6040_REG_INTID, intid);

I believe IRQ subsystem will handle this for you on your irq_ack() +
bus_sync_unlock() methods, right ? So you should provide them.

> +	return IRQ_HANDLED;
> +}
> +
> +int twl6040_irq_init(struct twl6040 *twl6040)
> +{
> +	int cur_irq, ret;
> +	u8 val;
> +
> +	mutex_init(&twl6040->irq_mutex);
> +
> +	/* mask the individual interrupt sources */
> +	twl6040->irq_masks_cur =3D TWL6040_ALLINT_MSK;
> +	twl6040->irq_masks_cache =3D TWL6040_ALLINT_MSK;
> +	twl6040_reg_write(twl6040, TWL6040_REG_INTMR, TWL6040_ALLINT_MSK);
> +
> +	if (!twl6040->irq) {
> +		dev_warn(twl6040->dev,
> +			 "no interrupt specified, no interrupts\n");
> +		twl6040->irq_base =3D 0;
> +		return 0;
> +	}
> +
> +	if (!twl6040->irq_base) {

base should be allocated here with irq_alloc_descs()

> +		dev_err(twl6040->dev,
> +			"no interrupt base specified, no interrupts\n");
> +		return 0;
> +	}
> +
> +	/* Register them with genirq */
> +	for (cur_irq =3D twl6040->irq_base;
> +	     cur_irq < twl6040->irq_base + ARRAY_SIZE(twl6040_irqs);
> +	     cur_irq++) {
> +		irq_set_chip_data(cur_irq, twl6040);
> +		irq_set_chip_and_handler(cur_irq, &twl6040_irq_chip,
> +					 handle_level_irq);
> +		irq_set_nested_thread(cur_irq, 1);
> +
> +		/* ARM needs us to explicitly flag the IRQ as valid
> +		 * and will set them noprobe when we do so. */

multiline comment style is wrong here.

> +#ifdef CONFIG_ARM
> +		set_irq_flags(cur_irq, IRQF_VALID);
> +#else
> +		irq_set_noprobe(cur_irq);
> +#endif
> +	}
> +
> +	ret =3D request_threaded_irq(twl6040->irq, NULL, twl6040_irq_thread,
> +				   IRQF_ONESHOT, "twl6040", twl6040);

I'm not sure you need IRQF_ONESHOT here, but that can be changed later.

> +	if (ret) {
> +		dev_err(twl6040->dev, "failed to request IRQ %d: %d\n",
> +			twl6040->irq, ret);
> +		return ret;
> +	}
> +
> +	/* reset interrupts */
> +	val =3D twl6040_reg_read(twl6040, TWL6040_REG_INTID);
> +
> +	/* interrupts cleared on write */
> +	twl6040_clear_bits(twl6040, TWL6040_REG_ACCCTL, TWL6040_INTCLRMODE);

you should do these two before request_threaded_irq(), you might have a
real IRQ which will be missed.

> +	return 0;
> +}
> +EXPORT_SYMBOL(twl6040_irq_init);

EXPORT_SYMBOL_GPL()

> +void twl6040_irq_exit(struct twl6040 *twl6040)
> +{
> +	if (twl6040->irq)

this check should always be true. You only call this on error path of
probe() and exit path.

> +		free_irq(twl6040->irq, twl6040);
> +}
> +EXPORT_SYMBOL(twl6040_irq_exit);

EXPORT_SYMBOL_GPL()

--=20
balbi

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJON+4zAAoJEAv8Txj19kN1Bz4H/RWsYyqMcJXqMOljYbYxD+Zk
K1Fo1jUZ8HrV2lqRuY+ieMLrgfycEJOiYvHwOw3RXYJwEI1xVMv4ZJhXenJcn1JQ
0y8RhIh7BVatJPi9LYvFrYQs118eYKVeieHQEDRBuQZbyizKEzrvZ4PvUY58FRzE
25Rwxg6dA+qNIWhc6NHFzPzJyyFOcLzXay+dD4QoWqLCTz/0nmwi90JnTL+ZF4zN
bAtZcIJg2lILEZIowyoynEgk86gNmSU1LarS0gR9E15AVTwIBDWjVpxT3cgWTij5
FP4Bd5dfP3Gq6cRT9n067w8I1KHc2AGsWg/pU24XMxgPCrLU4yd+1SElxPiQK1Q=
=hUYA
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
