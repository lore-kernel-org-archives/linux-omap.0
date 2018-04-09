From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Date: Mon, 9 Apr 2018 18:14:33 +0200
Message-ID: <20180409161433.u246evl3p5kppwnk@earth.universe>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
 <20180404145739.7w56gxiebfr2me4p@holly.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnaz3qtfrucvtiyk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404145739.7w56gxiebfr2me4p@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--lnaz3qtfrucvtiyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Apr 04, 2018 at 03:57:39PM +0100, Daniel Thompson wrote:
> On Fri, Mar 30, 2018 at 07:24:12PM +0200, Sebastian Reichel wrote:
> > This adds backlight support for the following TI LMU
> > chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> >=20
> > Signed-off-by: Milo Kim <milo.kim@ti.com>
> > [add LED subsystem support for keyboard backlight and rework DT
>=20
> Milo's mail has be bouncing for a very long time now. Did they really=20
> sign off this code or is this intended to be an authorship credit?

I took over his patches from ~ a year ago and reworked them.

> >  binding according to Rob Herrings feedback]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/video/backlight/Kconfig                 |   7 +
> >  drivers/video/backlight/Makefile                |   3 +
> >  drivers/video/backlight/ti-lmu-backlight-core.c | 666 ++++++++++++++++=
++++++++
> >  drivers/video/backlight/ti-lmu-backlight-data.c | 304 +++++++++++
> >  drivers/video/backlight/ti-lmu-backlight-data.h |  95 ++++
> >  5 files changed, 1075 insertions(+)
> >  create mode 100644 drivers/video/backlight/ti-lmu-backlight-core.c
> >  create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.c
> >  create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.h
> >=20
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/=
Kconfig
> > index 5d2d0d7e8100..27e6c5a0add8 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -427,6 +427,13 @@ config BACKLIGHT_SKY81452
> >  	  To compile this driver as a module, choose M here: the module will
> >  	  be called sky81452-backlight
> > =20
> > +config BACKLIGHT_TI_LMU
> > +	tristate "Backlight driver for TI LMU"
> > +	depends on BACKLIGHT_CLASS_DEVICE && MFD_TI_LMU
> > +	help
> > +	  Say Y to enable the backlight driver for TI LMU devices.
> > +	  This supports LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> > +
> >  config BACKLIGHT_TPS65217
> >  	tristate "TPS65217 Backlight"
> >  	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
> > diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight=
/Makefile
> > index 19da71d518bf..a1132d3dfd4c 100644
> > --- a/drivers/video/backlight/Makefile
> > +++ b/drivers/video/backlight/Makefile
> > @@ -53,6 +53,9 @@ obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+=3D pm8941-wled.o
> >  obj-$(CONFIG_BACKLIGHT_PWM)		+=3D pwm_bl.o
> >  obj-$(CONFIG_BACKLIGHT_SAHARA)		+=3D kb3886_bl.o
> >  obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backlight.o
> > +ti-lmu-backlight-objs			:=3D ti-lmu-backlight-core.o \
> > +					   ti-lmu-backlight-data.o
> > +obj-$(CONFIG_BACKLIGHT_TI_LMU)		+=3D ti-lmu-backlight.o
> >  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
> >  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
> >  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> > diff --git a/drivers/video/backlight/ti-lmu-backlight-core.c b/drivers/=
video/backlight/ti-lmu-backlight-core.c
> > new file mode 100644
> > index 000000000000..a6099581edd7
> > --- /dev/null
> > +++ b/drivers/video/backlight/ti-lmu-backlight-core.c
> > @@ -0,0 +1,666 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2015 Texas Instruments
> > + * Copyright 2018 Sebastian Reichel
> > + *
> > + * TI LMU Backlight driver, based on previous work from
> > + * Milo Kim <milo.kim@ti.com>
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/bitops.h>
> > +#include <linux/device.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/leds.h>
> > +#include <linux/mfd/ti-lmu.h>
> > +#include <linux/mfd/ti-lmu-register.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "ti-lmu-backlight-data.h"
> > +
> > +enum ti_lmu_bl_ctrl_mode {
> > +	BL_REGISTER_BASED,
> > +	BL_PWM_BASED,
> > +};
> > +
> > +enum ti_lmu_bl_type {
> > +	TI_LMU_BL,  /* backlight userspace interface */
> > +	TI_LMU_LED, /* led userspace interface */
> > +};
> > +
> > +enum ti_lmu_bl_ramp_mode {
> > +	BL_RAMP_UP,
> > +	BL_RAMP_DOWN,
> > +};
> > +
> > +#define DEFAULT_PWM_NAME			"lmu-backlight"
> > +#define NUM_DUAL_CHANNEL			2
> > +#define LMU_BACKLIGHT_DUAL_CHANNEL_USED		(BIT(0) | BIT(1))
> > +#define LMU_BACKLIGHT_11BIT_LSB_MASK		(BIT(0) | BIT(1) | BIT(2))
> > +#define LMU_BACKLIGHT_11BIT_MSB_SHIFT		3
> > +
> > +struct ti_lmu_bank {
> > +	struct device *dev;
> > +	int bank_id;
> > +	const struct ti_lmu_bl_cfg *cfg;
> > +	struct ti_lmu *lmu;
> > +	const char *label;
> > +	int leds;
> > +	int current_brightness;
> > +	u32 default_brightness;
> > +	u32 ramp_up_msec;
> > +	u32 ramp_down_msec;
> > +	u32 pwm_period;
> > +	enum ti_lmu_bl_ctrl_mode mode;
> > +	enum ti_lmu_bl_type type;
> > +
> > +	struct notifier_block nb;
> > +
> > +	struct backlight_device *backlight;
> > +	struct led_classdev *led;
> > +};
> > +
> > +static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
> > +{
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	unsigned long enable_time =3D lmu_bank->cfg->reginfo->enable_usec;
> > +	u8 *reg =3D lmu_bank->cfg->reginfo->enable;
> > +	u8 mask =3D BIT(lmu_bank->bank_id);
> > +	u8 val =3D (enable =3D=3D true) ? mask : 0;
> > +	int ret;
> > +
> > +	if (!reg)
> > +		return -EINVAL;
> > +
> > +	ret =3D regmap_update_bits(regmap, *reg, mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (enable_time > 0)
> > +		usleep_range(enable_time, enable_time + 100);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_update_brightness_register(struct ti_lmu_bank *lm=
u_bank,
> > +						       int brightness)
> > +{
> > +	const struct ti_lmu_bl_cfg *cfg =3D lmu_bank->cfg;
> > +	const struct ti_lmu_bl_reg *reginfo =3D cfg->reginfo;
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	u8 reg, val;
> > +	int ret;
> > +
> > +	/*
> > +	 * Brightness register update
> > +	 *
> > +	 * 11 bit dimming: update LSB bits and write MSB byte.
> > +	 *		   MSB brightness should be shifted.
> > +	 *  8 bit dimming: write MSB byte.
> > +	 */
> > +	if (cfg->max_brightness =3D=3D MAX_BRIGHTNESS_11BIT) {
> > +		reg =3D reginfo->brightness_lsb[lmu_bank->bank_id];
> > +		ret =3D regmap_update_bits(regmap, reg,
> > +					 LMU_BACKLIGHT_11BIT_LSB_MASK,
> > +					 brightness);
> > +		if (ret)
> > +			return ret;
> > +
> > +		val =3D brightness >> LMU_BACKLIGHT_11BIT_MSB_SHIFT;
> > +	} else {
> > +		val =3D brightness;
> > +	}
> > +
> > +	reg =3D reginfo->brightness_msb[lmu_bank->bank_id];
> > +	return regmap_write(regmap, reg, val);
> > +}
> > +
> > +static int ti_lmu_bl_pwm_ctrl(struct ti_lmu_bank *lmu_bank, int bright=
ness)
> > +{
> > +	int max_brightness =3D lmu_bank->cfg->max_brightness;
> > +	struct pwm_state state =3D { };
> > +	int ret;
> > +
> > +	if (!lmu_bank->lmu->pwm) {
> > +		dev_err(lmu_bank->dev, "Missing PWM device!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	pwm_init_state(lmu_bank->lmu->pwm, &state);
> > +	state.period =3D lmu_bank->pwm_period;
> > +	state.duty_cycle =3D brightness * state.period / max_brightness;
> > +
> > +	if (state.duty_cycle)
> > +		state.enabled =3D true;
> > +	else
> > +		state.enabled =3D false;
> > +
> > +	ret =3D pwm_apply_state(lmu_bank->lmu->pwm, &state);
> > +	if (ret)
> > +		dev_err(lmu_bank->dev, "Failed to configure PWM: %d", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_lmu_bl_set_brightness(struct ti_lmu_bank *lmu_bank,
> > +				    int brightness)
> > +{
> > +	const struct ti_lmu_bl_cfg *cfg =3D lmu_bank->cfg;
> > +	bool enable =3D brightness > 0;
> > +	int ret;
> > +
> > +	ret =3D ti_lmu_bl_enable(lmu_bank, enable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (lmu_bank->mode =3D=3D BL_PWM_BASED) {
> > +		ti_lmu_bl_pwm_ctrl(lmu_bank, brightness);
> > +
> > +		switch (cfg->pwm_action) {
> > +		case UPDATE_PWM_ONLY:
> > +			/* No register update is required */
> > +			return 0;
> > +		case UPDATE_MAX_BRT:
> > +			/*
> > +			 * PWM can start from any non-zero code and dim down
> > +			 * to zero. So, brightness register should be updated
> > +			 * even in PWM mode.
> > +			 */
>=20
> This comment could do with a little expansion (I assume the bank's
> brightness register means something different when in PWM mode but the
> flow of the code is tricky to read).

I will consult the manual and see how exactly the PWM stuff
is supposed to work. The platform I need this driver for
(Motorola Droid 4) does not have/use the PWM feature.

> > +			if (brightness > 0)
>=20
> Isn't this "enable"?

Yes, good catch!

> > +				brightness =3D MAX_BRIGHTNESS_11BIT;
> > +			else
> > +				brightness =3D 0;
> > +			break;
> > +		default:
>=20
> case UPDATE_PWM_AND_BRT_REGISTER:

ok.

>=20
> > +			break;
> > +		}
> > +	}
> > +
> > +	lmu_bank->current_brightness =3D brightness;
> > +
> > +	return ti_lmu_bl_update_brightness_register(lmu_bank, brightness);
> > +}
> > [...]

Thanks for the review.

-- Sebastian

--lnaz3qtfrucvtiyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrLkWkACgkQ2O7X88g7
+prTqhAAjmteY3GPfUYt58ENfMaf+cxErUMrESoB1kizb6VCzsPBtVVD8XTzvLO5
cOiHhWw0YaMZQlZIUMas+qDvN+uTlCeZR51a0LcYx3XAijh9GpX7EfHHtXya5BHC
ByhwOCeHTa5iQbnv+a2c6xX+EdVl2vHYNjoPo0hyUo/SvMGzDI2BaCPAwaiLPT+R
orgWctyEKJKkqnJ4Q9O4A53dy4TbcI7rkNKt/n8/ooaGcLbYzJr2530TskJc++7+
vDXmUpqlhH5NCOQC4bREnbW/x2D+Dej1KWwhlR57gLcgdBlGuKWymyeJLM/+acih
DXSecjBpsUPwVHzSQrcWwTYqT8y6AqjLg4JMaq1GlOcbpULL+fNDWxiyiY7uRqAH
7LHKgUzg8w6A7Znn4CRCtyzwuF4URt1kGmvAo2p5ZcC0DQNwjsLUeIZHhPk4cw/G
flJYX9UMZaUj6KRgEU4k/9JLGrSsZ5Xajey1UwTtPdQnWDlmMqArFeKXljyR7WO6
CKdfNFYFcza2AbS76kM+NsONP1v3UrvyFda+YbNiIM9ZyXT8pCGAbhUp2UAJ8tGB
9oSolrhSc09SD+fiD+BVs+OZHanSF+EO2Fo73kPlDWvwaOXg6mO7aenC7KJKBP+T
rI62IJCohAf7N9MP2USG5c0NCSjqwLk7GD7Lzo4u28/SgU7zYkc=
=6EFx
-----END PGP SIGNATURE-----

--lnaz3qtfrucvtiyk--
