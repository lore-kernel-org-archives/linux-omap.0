From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Date: Mon, 9 Apr 2018 18:11:07 +0200
Message-ID: <20180409161107.6owmanmi6cheicyo@earth.universe>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
 <1c69be8b-1ba0-a596-6c54-022b1baf3812@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3ytjpvmiq6z7ra7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c69be8b-1ba0-a596-6c54-022b1baf3812@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--w3ytjpvmiq6z7ra7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 04, 2018 at 01:30:37PM -0500, Dan Murphy wrote:
> Sebastian
>=20
> -Milo Kim email is not valid

Thanks for your review! Milo was CC'd, since git took over the
SoB. I will make sure to avoid it next time.

> On 03/30/2018 12:24 PM, Sebastian Reichel wrote:
> > This adds backlight support for the following TI LMU
> > chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> >=20
> > Signed-off-by: Milo Kim <milo.kim@ti.com>
> > [add LED subsystem support for keyboard backlight and rework DT
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
>=20
> select REGMAP?

Right.

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
>=20
> I don't see this used.

I guess I can remove this :)

> > +#define NUM_DUAL_CHANNEL			2
> > +#define LMU_BACKLIGHT_DUAL_CHANNEL_USED		(BIT(0) | BIT(1))
> > +#define LMU_BACKLIGHT_11BIT_LSB_MASK		(BIT(0) | BIT(1) | BIT(2))
> > +#define LMU_BACKLIGHT_11BIT_MSB_SHIFT		3
> > +
>=20
> Struct kerneldoc?

Ok.

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
>=20
> Is there anyway that update_status and set_led_blocking can be
> called at the same time causing a race condition in this api?

Each bank is either exclusively exposed via LED or via backlight
subsystem.

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
> > +			if (brightness > 0)
> > +				brightness =3D MAX_BRIGHTNESS_11BIT;
> > +			else
> > +				brightness =3D 0;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	lmu_bank->current_brightness =3D brightness;
> > +
> > +	return ti_lmu_bl_update_brightness_register(lmu_bank, brightness);
> > +}
> > +
> > +static int ti_lmu_bl_update_status(struct backlight_device *bl_dev)
> > +{
> > +	struct ti_lmu_bank *lmu_bank =3D bl_get_data(bl_dev);
> > +	int brightness =3D bl_dev->props.brightness;
> > +
> > +	if (bl_dev->props.state & BL_CORE_SUSPENDED)
> > +		brightness =3D 0;
> > +
> > +	return ti_lmu_bl_set_brightness(lmu_bank, brightness);
> > +}
> > +
> > +static const struct backlight_ops lmu_backlight_ops =3D {
> > +	.options =3D BL_CORE_SUSPENDRESUME,
> > +	.update_status =3D ti_lmu_bl_update_status,
> > +};
> > +
> > +static int ti_lmu_bl_set_led_blocking(struct led_classdev *ledc,
> > +					     enum led_brightness value)
> > +{
> > +	struct ti_lmu_bank *lmu_bank =3D dev_get_drvdata(ledc->dev->parent);
> > +	int brightness =3D value;
> > +
> > +	return ti_lmu_bl_set_brightness(lmu_bank, brightness);
> > +}
> > +
> > +static int ti_lmu_bl_check_channel(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	const struct ti_lmu_bl_cfg *cfg =3D lmu_bank->cfg;
> > +	const struct ti_lmu_bl_reg *reginfo =3D cfg->reginfo;
> > +
> > +	if (!reginfo->brightness_msb)
> > +		return -EINVAL;
> > +
> > +	if (cfg->max_brightness > MAX_BRIGHTNESS_8BIT) {
> > +		if (!reginfo->brightness_lsb)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_create_channel(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	const struct lmu_bl_reg_data *regdata =3D lmu_bank->cfg->reginfo->cha=
nnel;
> > +	int num_channels =3D lmu_bank->cfg->num_channels;
> > +	unsigned long led_sources =3D lmu_bank->leds;
> > +	int i, ret;
> > +	u8 shift;
> > +
> > +	/*
> > +	 * How to create backlight output channels:
> > +	 *   Check 'led_sources' bit and update registers.
> > +	 *
> > +	 *   1) Dual channel configuration
> > +	 *     The 1st register data is used for single channel.
> > +	 *     The 2nd register data is used for dual channel.
> > +	 *
> > +	 *   2) Multiple channel configuration
> > +	 *     Each register data is mapped to bank ID.
> > +	 *     Bit shift operation is defined in channel registers.
> > +	 *
> > +	 * Channel register data consists of address, mask, value.
> > +	 */
> > +
> > +	if (num_channels =3D=3D NUM_DUAL_CHANNEL) {
> > +		if (led_sources =3D=3D LMU_BACKLIGHT_DUAL_CHANNEL_USED)
> > +			regdata++;
> > +
> > +		return regmap_update_bits(regmap, regdata->reg, regdata->mask,
> > +					  regdata->val);
> > +	}
> > +
> > +	for (i =3D 0; regdata && i < num_channels; i++) {
> > +		/*
> > +		 * Note that the result of regdata->val is shift bit.
> > +		 * The bank_id should be shifted for the channel configuration.
> > +		 */
> > +		if (test_bit(i, &led_sources)) {
> > +			shift =3D regdata->val;
> > +			ret =3D regmap_update_bits(regmap, regdata->reg,
> > +						 regdata->mask,
> > +						 lmu_bank->bank_id << shift);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		regdata++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_update_ctrl_mode(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	const struct lmu_bl_reg_data *regdata =3D
> > +		lmu_bank->cfg->reginfo->mode + lmu_bank->bank_id;
> > +	u8 val =3D regdata->val;
> > +
> > +	if (!regdata)
> > +		return 0;
> > +
> > +	/*
> > +	 * Update PWM configuration register.
> > +	 * If the mode is register based, then clear the bit.
> > +	 */
> > +	if (lmu_bank->mode !=3D BL_PWM_BASED)
> > +		val =3D 0;
> > +
> > +	return regmap_update_bits(regmap, regdata->reg, regdata->mask, val);
> > +}
> > +
> > +static int ti_lmu_bl_convert_ramp_to_index(struct ti_lmu_bank *lmu_ban=
k,
> > +						  enum ti_lmu_bl_ramp_mode mode)
> > +{
> > +	const int *ramp_table =3D lmu_bank->cfg->ramp_table;
> > +	const int size =3D lmu_bank->cfg->size_ramp;
> > +	unsigned int msec;
> > +	int i;
> > +
> > +	if (!ramp_table)
> > +		return -EINVAL;
> > +
> > +	switch (mode) {
> > +	case BL_RAMP_UP:
> > +		msec =3D lmu_bank->ramp_up_msec;
> > +		break;
> > +	case BL_RAMP_DOWN:
> > +		msec =3D lmu_bank->ramp_down_msec;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (msec <=3D ramp_table[0])
> > +		return 0;
> > +
> > +	if (msec > ramp_table[size - 1])
> > +		return size - 1;
> > +
> > +	for (i =3D 1; i < size; i++) {
> > +		if (msec =3D=3D ramp_table[i])
> > +			return i;
> > +
> > +		/* Find an approximate index by looking up the table */
> > +		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
> > +			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
> > +				return i - 1;
> > +			else
> > +				return i;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +
>=20
> Extra new line

oops.

>=20
> > +static int ti_lmu_bl_set_ramp(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	const struct ti_lmu_bl_reg *reginfo =3D lmu_bank->cfg->reginfo;
> > +	int offset =3D reginfo->ramp_reg_offset;
> > +	int i, ret, index;
> > +	struct lmu_bl_reg_data regdata;
> > +
> > +	for (i =3D BL_RAMP_UP; i <=3D BL_RAMP_DOWN; i++) {
> > +		index =3D ti_lmu_bl_convert_ramp_to_index(lmu_bank, i);
> > +		if (index > 0) {
> > +			if (!reginfo->ramp)
> > +				break;
> > +
> > +			regdata =3D reginfo->ramp[i];
> > +			if (lmu_bank->bank_id !=3D 0)
> > +				regdata.val +=3D offset;
> > +
> > +			/* regdata.val is shift bit */
> > +			ret =3D regmap_update_bits(regmap, regdata.reg,
> > +						 regdata.mask,
> > +						 index << regdata.val);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_configure(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	int ret;
> > +
> > +	ret =3D ti_lmu_bl_check_channel(lmu_bank);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ti_lmu_bl_create_channel(lmu_bank);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ti_lmu_bl_update_ctrl_mode(lmu_bank);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ti_lmu_bl_set_ramp(lmu_bank);
> > +}
> > +
> > +static int ti_lmu_bl_register_backlight(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	struct backlight_device *bl_dev;
> > +	struct backlight_properties props;
> > +
> > +	if (lmu_bank->type !=3D TI_LMU_BL)
> > +		return -EINVAL;
> > +
> > +	memset(&props, 0, sizeof(struct backlight_properties));
> > +	props.type =3D BACKLIGHT_PLATFORM;
> > +	props.brightness =3D lmu_bank->default_brightness;
> > +	props.max_brightness =3D lmu_bank->cfg->max_brightness;
> > +
> > +	bl_dev =3D devm_backlight_device_register(lmu_bank->dev, lmu_bank->la=
bel,
> > +						lmu_bank->dev, lmu_bank,
> > +						&lmu_backlight_ops, &props);
> > +	if (IS_ERR(bl_dev))
> > +		return PTR_ERR(bl_dev);
> > +
> > +	lmu_bank->backlight =3D bl_dev;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_register_led(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	int err;
> > +
> > +	if (lmu_bank->type !=3D TI_LMU_LED)
> > +		return -EINVAL;
> > +
> > +	lmu_bank->led =3D devm_kzalloc(lmu_bank->dev, sizeof(*lmu_bank->led),
> > +				     GFP_KERNEL);
> > +	if (!lmu_bank->led)
> > +		return -ENOMEM;
> > +
> > +	lmu_bank->led->name =3D lmu_bank->label;
> > +	lmu_bank->led->max_brightness =3D lmu_bank->cfg->max_brightness;
> > +	lmu_bank->led->brightness_set_blocking =3D
> > +		ti_lmu_bl_set_led_blocking;
> > +
> > +	err =3D devm_led_classdev_register(lmu_bank->dev, lmu_bank->led);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	switch (lmu_bank->type) {
> > +	case TI_LMU_BL:
> > +		return ti_lmu_bl_register_backlight(lmu_bank);
> > +	case TI_LMU_LED:
> > +		return ti_lmu_bl_register_led(lmu_bank);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int setup_of_node(struct platform_device *pdev)
>=20
> This seems a bit generic.  Maybe keep with the naming convention
>=20
> ti_lmu_setup_of_node

right.

> > +{
> > +	struct device_node *parent_node =3D pdev->dev.parent->of_node;
> > +	char *name;
> > +
> > +	if (!parent_node)
> > +		return 0;
> > +
> > +	name =3D kasprintf(GFP_KERNEL, "bank%d", pdev->id);
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > +	pdev->dev.of_node =3D of_get_child_by_name(parent_node, name);
> > +	kfree(name);
> > +
> > +	if (!pdev->dev.of_node)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_parse_led_sources(struct device *dev)
> > +{
> > +	unsigned long mask =3D 0;
> > +	int ret;
> > +	int size, i;
> > +	u32 *leds;
> > +
> > +	size =3D device_property_read_u32_array(dev, "ti,led-sources", NULL, =
0);
> > +	if (size <=3D 0) {
> > +		dev_err(dev, "Missing or malformed property led-sources: %d\n",
> > +			size);
> > +		return size < 0 ? size : -EINVAL;
>=20
> Why the additional check? Why not just return -EINVAL?

I think it makes sense to pass the actual error code, but I can
simplify it when you insist.

> > +	}
> > +
> > +	leds =3D kmalloc_array(size, sizeof(u32), GFP_KERNEL);
> > +	if (!leds)
> > +		return -ENOMEM;
> > +
> > +	ret =3D device_property_read_u32_array(dev, "ti,led-sources", leds, s=
ize);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to read led-sources property: %d\n", ret);
> > +		goto out;
> > +	}
> > +
> > +	for (i =3D 0; i < size; i++)
> > +		set_bit(leds[i], &mask);
> > +
> > +	ret =3D mask;
> > +
> > +out:
> > +	kfree(leds);
> > +	return ret;
> > +}
> > +
> > +static int ti_lmu_bl_init(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	struct regmap *regmap =3D lmu_bank->lmu->regmap;
> > +	const struct lmu_bl_reg_data *regdata =3D
> > +		lmu_bank->cfg->reginfo->init;
> > +	int num_init =3D lmu_bank->cfg->reginfo->num_init;
> > +	int i, ret;
> > +
> > +	if (lmu_bank->lmu->backlight_initialized)
> > +		return 0;
>=20
> Add a new line here

ok

> > +	lmu_bank->lmu->backlight_initialized =3D true;
> > +
> > +	for (i =3D 0; regdata && i < num_init; i++) {
> > +		ret =3D regmap_update_bits(regmap, regdata->reg, regdata->mask,
> > +					 regdata->val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		regdata++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_reload(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	int err;
> > +
> > +	ti_lmu_bl_init(lmu_bank);
> > +
> > +	err =3D ti_lmu_bl_configure(lmu_bank);
> > +	if (err)
> > +		return err;
> > +
> > +	return ti_lmu_bl_set_brightness(lmu_bank, lmu_bank->current_brightnes=
s);
> > +}
> > +
> > +static int ti_lmu_bl_monitor_notifier(struct notifier_block *nb,
> > +					     unsigned long action, void *unused)
> > +{
> > +	struct ti_lmu_bank *lmu_bank =3D container_of(nb, struct ti_lmu_bank,=
 nb);
> > +
> > +	if (action =3D=3D LMU_EVENT_MONITOR_DONE) {
> > +		if (ti_lmu_bl_reload(lmu_bank))
> > +			return NOTIFY_STOP;
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static int ti_lmu_bl_probe(struct platform_device *pdev)
> > +{
> > +	struct ti_lmu_bank *lmu_bank;
> > +	int err;
> > +
> > +	err =3D setup_of_node(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	lmu_bank =3D devm_kzalloc(&pdev->dev, sizeof(*lmu_bank), GFP_KERNEL);
> > +	if (!lmu_bank)
> > +		return -ENOMEM;
>=20
> Add a new line here

ok

> > +	lmu_bank->dev =3D &pdev->dev;
> > +	dev_set_drvdata(&pdev->dev, lmu_bank);
> > +
> > +	err =3D device_property_read_string(&pdev->dev, "label",
> > +					  &lmu_bank->label);
> > +	if (err)
> > +		return err;
> > +
> > +	lmu_bank->type =3D TI_LMU_BL;
> > +	if (!strcmp(lmu_bank->label, "keyboard")) {
> > +		lmu_bank->type =3D TI_LMU_LED;
> > +		lmu_bank->label =3D "kbd_backlight";
>=20
> What is the reason for changing the label?  Why can't the label in
> the DT be kbd_backlight?

It can, I tried to avoid Linuxism in DT.

> > +	}
> > +
> > +	lmu_bank->leds =3D ti_lmu_parse_led_sources(&pdev->dev);
> > +	if (lmu_bank->leds < 0)
> > +		return lmu_bank->leds;
> > +	else if (lmu_bank->leds =3D=3D 0)
> > +		return -EINVAL;
> > +
> > +	device_property_read_u32(&pdev->dev, "default-brightness-level",
> > +				 &lmu_bank->default_brightness);
> > +	device_property_read_u32(&pdev->dev, "ti,ramp-up-ms",
> > +				 &lmu_bank->ramp_up_msec);
> > +	device_property_read_u32(&pdev->dev, "ti,ramp-down-ms",
> > +				 &lmu_bank->ramp_down_msec);
> > +	device_property_read_u32(&pdev->dev, "pwm-period",
> > +				 &lmu_bank->pwm_period);
> > +
> > +	if (lmu_bank->pwm_period > 0)
> > +		lmu_bank->mode =3D BL_PWM_BASED;
> > +	else
> > +		lmu_bank->mode =3D BL_REGISTER_BASED;
> > +
> > +	lmu_bank->lmu =3D dev_get_drvdata(pdev->dev.parent);
> > +	lmu_bank->cfg =3D &lmu_bl_cfg[lmu_bank->lmu->id];
> > +	lmu_bank->bank_id =3D pdev->id;
> > +
> > +	ti_lmu_bl_init(lmu_bank);
> > +
> > +	err =3D ti_lmu_bl_configure(lmu_bank);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D ti_lmu_bl_add_device(lmu_bank);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D ti_lmu_bl_set_brightness(lmu_bank,
> > +					      lmu_bank->default_brightness);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * Notifier callback is required because backlight device needs
> > +	 * reconfiguration after fault detection procedure is done by
> > +	 * ti-lmu-fault-monitor driver.
> > +	 */
> > +	if (lmu_bank->cfg->fault_monitor_used) {
> > +		lmu_bank->nb.notifier_call =3D ti_lmu_bl_monitor_notifier;
> > +		err =3D blocking_notifier_chain_register(&lmu_bank->lmu->notifier,
> > +						       &lmu_bank->nb);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_lmu_bl_remove(struct platform_device *pdev)
> > +{
> > +	struct ti_lmu_bank *lmu_bank =3D platform_get_drvdata(pdev);
> > +
> > +	if (lmu_bank->cfg->fault_monitor_used)
> > +		blocking_notifier_chain_unregister(&lmu_bank->lmu->notifier,
> > +						   &lmu_bank->nb);
> > +
> > +	ti_lmu_bl_set_brightness(lmu_bank, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver ti_lmu_bl_driver =3D {
> > +	.probe  =3D ti_lmu_bl_probe,
> > +	.remove  =3D ti_lmu_bl_remove,
> > +	.driver =3D {
> > +		.name =3D "ti-lmu-led-backlight",
> > +	},
> > +};
> > +module_platform_driver(ti_lmu_bl_driver)
> > +
> > +MODULE_DESCRIPTION("TI LMU Backlight LED Driver");
> > +MODULE_AUTHOR("Sebastian Reichel");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:ti-lmu-led-backlight");
> > diff --git a/drivers/video/backlight/ti-lmu-backlight-data.c b/drivers/=
video/backlight/ti-lmu-backlight-data.c
> > new file mode 100644
> > index 000000000000..583136cb934d
> > --- /dev/null
> > +++ b/drivers/video/backlight/ti-lmu-backlight-data.c
> > @@ -0,0 +1,304 @@
> > +/*
>=20
> Inconsistent licensing here the core has
> // SPDX-License-Identifier: GPL-2.0
>=20
> > + * TI LMU (Lighting Management Unit) Backlight Device Data
> > + *
> > + * Copyright 2015 Texas Instruments
>=20
> Copyright?

The original driver is from Milo Kim / TI. I changed almost all of
the core driver, so I took the liberty to update the copyright and
license header. The data part has been taken over almost unmodified,
so I kept the original header. I suppose TI is fine with using the
abbreviated header?

> > + * Author: Milo Kim <milo.kim@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include "ti-lmu-backlight-data.h"
> > +
> > +/* LM3532 */
> > +static const struct lmu_bl_reg_data lm3532_init_data[] =3D {
> > +	{ LM3532_REG_ZONE_CFG_A, LM3532_ZONE_MASK, LM3532_ZONE_0 },
> > +	{ LM3532_REG_ZONE_CFG_B, LM3532_ZONE_MASK, LM3532_ZONE_1 },
> > +	{ LM3532_REG_ZONE_CFG_C, LM3532_ZONE_MASK, LM3532_ZONE_2 },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3532_channel_data[] =3D {
> > +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED1_CFG_MASK,
> > +	  LM3532_ILED1_CFG_SHIFT },
> > +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED2_CFG_MASK,
> > +	  LM3532_ILED2_CFG_SHIFT },
> > +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED3_CFG_MASK,
> > +	  LM3532_ILED3_CFG_SHIFT },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3532_mode_data[] =3D {
> > +	{ LM3532_REG_PWM_A_CFG, LM3532_PWM_A_MASK, LM3532_PWM_ZONE_0 },
> > +	{ LM3532_REG_PWM_B_CFG, LM3532_PWM_B_MASK, LM3532_PWM_ZONE_1 },
> > +	{ LM3532_REG_PWM_C_CFG, LM3532_PWM_C_MASK, LM3532_PWM_ZONE_2 },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3532_ramp_data[] =3D {
> > +	{ LM3532_REG_RAMPUP, LM3532_RAMPUP_MASK, LM3532_RAMPUP_SHIFT },
> > +	{ LM3532_REG_RAMPDN, LM3532_RAMPDN_MASK, LM3532_RAMPDN_SHIFT },
> > +};
> > +
> > +static u8 lm3532_enable_reg =3D LM3532_REG_ENABLE;
> > +
> > +static u8 lm3532_brightness_regs[] =3D {
> > +	LM3532_REG_BRT_A,
> > +	LM3532_REG_BRT_B,
> > +	LM3532_REG_BRT_C,
> > +};
> > +
> > +static const struct ti_lmu_bl_reg lm3532_reg_info =3D {
> > +	.init		=3D lm3532_init_data,
> > +	.num_init	=3D ARRAY_SIZE(lm3532_init_data),
> > +	.channel	=3D lm3532_channel_data,
> > +	.mode		=3D lm3532_mode_data,
> > +	.ramp		=3D lm3532_ramp_data,
> > +	.enable		=3D &lm3532_enable_reg,
> > +	.brightness_msb	=3D lm3532_brightness_regs,
> > +};
> > +
> > +/* LM3631 */
> > +static const struct lmu_bl_reg_data lm3631_init_data[] =3D {
> > +	{ LM3631_REG_BRT_MODE, LM3631_MODE_MASK, LM3631_DEFAULT_MODE },
> > +	{ LM3631_REG_BL_CFG, LM3631_MAP_MASK, LM3631_EXPONENTIAL_MAP },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3631_channel_data[] =3D {
> > +	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_SINGLE_CHANNEL=
 },
> > +	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_DUAL_CHANNEL },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3631_ramp_data[] =3D {
> > +	{ LM3631_REG_SLOPE, LM3631_SLOPE_MASK, LM3631_SLOPE_SHIFT },
> > +};
> > +
> > +static u8 lm3631_enable_reg =3D LM3631_REG_DEVCTRL;
> > +static u8 lm3631_brightness_msb_reg =3D LM3631_REG_BRT_MSB;
> > +static u8 lm3631_brightness_lsb_reg =3D LM3631_REG_BRT_LSB;
> > +
> > +static const struct ti_lmu_bl_reg lm3631_reg_info =3D {
> > +	.init		=3D lm3631_init_data,
> > +	.num_init	=3D ARRAY_SIZE(lm3631_init_data),
> > +	.channel	=3D lm3631_channel_data,
> > +	.ramp		=3D lm3631_ramp_data,
> > +	.enable		=3D &lm3631_enable_reg,
> > +	.brightness_msb	=3D &lm3631_brightness_msb_reg,
> > +	.brightness_lsb	=3D &lm3631_brightness_lsb_reg,
> > +};
> > +
> > +/* LM3632 */
> > +static const struct lmu_bl_reg_data lm3632_init_data[] =3D {
> > +	{ LM3632_REG_CONFIG1, LM3632_OVP_MASK, LM3632_OVP_25V },
> > +	{ LM3632_REG_CONFIG2, LM3632_SWFREQ_MASK, LM3632_SWFREQ_1MHZ },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3632_channel_data[] =3D {
> > +	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_SINGLE_CHANNEL=
 },
> > +	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_DUAL_CHANNEL },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3632_mode_data[] =3D {
> > +	{ LM3632_REG_IO_CTRL, LM3632_PWM_MASK, LM3632_PWM_MODE },
> > +};
> > +
> > +static u8 lm3632_enable_reg =3D LM3632_REG_ENABLE;
> > +static u8 lm3632_brightness_msb_reg =3D LM3632_REG_BRT_MSB;
> > +static u8 lm3632_brightness_lsb_reg =3D LM3632_REG_BRT_LSB;
> > +
> > +static const struct ti_lmu_bl_reg lm3632_reg_info =3D {
> > +	.init		=3D lm3632_init_data,
> > +	.num_init	=3D ARRAY_SIZE(lm3632_init_data),
> > +	.channel	=3D lm3632_channel_data,
> > +	.mode		=3D lm3632_mode_data,
> > +	.enable		=3D &lm3632_enable_reg,
> > +	.brightness_msb	=3D &lm3632_brightness_msb_reg,
> > +	.brightness_lsb	=3D &lm3632_brightness_lsb_reg,
> > +};
> > +
> > +/* LM3633 */
> > +static const struct lmu_bl_reg_data lm3633_init_data[] =3D {
> > +	{ LM3633_REG_BOOST_CFG, LM3633_OVP_MASK, LM3633_OVP_40V },
> > +	{ LM3633_REG_BL_RAMP_CONF, LM3633_BL_RAMP_MASK, LM3633_BL_RAMP_EACH },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3633_channel_data[] =3D {
> > +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED1_CFG_MASK,
> > +	  LM3633_HVLED1_CFG_SHIFT },
> > +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED2_CFG_MASK,
> > +	  LM3633_HVLED2_CFG_SHIFT },
> > +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED3_CFG_MASK,
> > +	  LM3633_HVLED3_CFG_SHIFT },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3633_mode_data[] =3D {
> > +	{ LM3633_REG_PWM_CFG, LM3633_PWM_A_MASK, LM3633_PWM_A_MASK },
> > +	{ LM3633_REG_PWM_CFG, LM3633_PWM_B_MASK, LM3633_PWM_B_MASK },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3633_ramp_data[] =3D {
> > +	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPUP_MASK, LM3633_BL_RAMPUP_SHIFT =
},
> > +	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPDN_MASK, LM3633_BL_RAMPDN_SHIFT =
},
> > +};
> > +
> > +static u8 lm3633_enable_reg =3D LM3633_REG_ENABLE;
> > +
> > +static u8 lm3633_brightness_msb_regs[] =3D {
> > +	LM3633_REG_BRT_HVLED_A_MSB,
> > +	LM3633_REG_BRT_HVLED_B_MSB,
> > +};
> > +
> > +static u8 lm3633_brightness_lsb_regs[] =3D {
> > +	LM3633_REG_BRT_HVLED_A_LSB,
> > +	LM3633_REG_BRT_HVLED_B_LSB,
> > +};
> > +
> > +static const struct ti_lmu_bl_reg lm3633_reg_info =3D {
> > +	.init		 =3D lm3633_init_data,
> > +	.num_init	 =3D ARRAY_SIZE(lm3633_init_data),
> > +	.channel	 =3D lm3633_channel_data,
> > +	.mode		 =3D lm3633_mode_data,
> > +	.ramp		 =3D lm3633_ramp_data,
> > +	.ramp_reg_offset =3D 1, /* For LM3633_REG_BL1_RAMPUP/DN */
> > +	.enable		 =3D &lm3633_enable_reg,
> > +	.brightness_msb	 =3D lm3633_brightness_msb_regs,
> > +	.brightness_lsb	 =3D lm3633_brightness_lsb_regs,
> > +};
> > +
> > +/* LM3695 */
> > +static const struct lmu_bl_reg_data lm3695_init_data[] =3D {
> > +	{ LM3695_REG_GP, LM3695_BRT_RW_MASK, LM3695_BRT_RW_MASK },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3695_channel_data[] =3D {
> > +	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_SINGLE_CHANNEL },
> > +	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_DUAL_CHANNEL },
> > +};
> > +
> > +static u8 lm3695_enable_reg =3D LM3695_REG_GP;
> > +static u8 lm3695_brightness_msb_reg =3D LM3695_REG_BRT_MSB;
> > +static u8 lm3695_brightness_lsb_reg =3D LM3695_REG_BRT_LSB;
> > +
> > +static const struct ti_lmu_bl_reg lm3695_reg_info =3D {
> > +	.init		=3D lm3695_init_data,
> > +	.num_init	=3D ARRAY_SIZE(lm3695_init_data),
> > +	.channel	=3D lm3695_channel_data,
> > +	.enable		=3D &lm3695_enable_reg,
> > +	.enable_usec	=3D 600,
> > +	.brightness_msb	=3D &lm3695_brightness_msb_reg,
> > +	.brightness_lsb	=3D &lm3695_brightness_lsb_reg,
> > +};
> > +
> > +/* LM3697 */
> > +static const struct lmu_bl_reg_data lm3697_init_data[] =3D {
> > +	{ LM3697_REG_RAMP_CONF, LM3697_RAMP_MASK, LM3697_RAMP_EACH },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3697_channel_data[] =3D {
> > +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED1_CFG_MASK,
> > +	  LM3697_HVLED1_CFG_SHIFT },
> > +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED2_CFG_MASK,
> > +	  LM3697_HVLED2_CFG_SHIFT },
> > +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED3_CFG_MASK,
> > +	  LM3697_HVLED3_CFG_SHIFT },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3697_mode_data[] =3D {
> > +	{ LM3697_REG_PWM_CFG, LM3697_PWM_A_MASK, LM3697_PWM_A_MASK },
> > +	{ LM3697_REG_PWM_CFG, LM3697_PWM_B_MASK, LM3697_PWM_B_MASK },
> > +};
> > +
> > +static const struct lmu_bl_reg_data lm3697_ramp_data[] =3D {
> > +	{ LM3697_REG_BL0_RAMP, LM3697_RAMPUP_MASK, LM3697_RAMPUP_SHIFT },
> > +	{ LM3697_REG_BL0_RAMP, LM3697_RAMPDN_MASK, LM3697_RAMPDN_SHIFT },
> > +};
> > +
> > +static u8 lm3697_enable_reg =3D LM3697_REG_ENABLE;
> > +
> > +static u8 lm3697_brightness_msb_regs[] =3D {
> > +	LM3697_REG_BRT_A_MSB,
> > +	LM3697_REG_BRT_B_MSB,
> > +};
> > +
> > +static u8 lm3697_brightness_lsb_regs[] =3D {
> > +	LM3697_REG_BRT_A_LSB,
> > +	LM3697_REG_BRT_B_LSB,
> > +};
> > +
> > +static const struct ti_lmu_bl_reg lm3697_reg_info =3D {
> > +	.init		 =3D lm3697_init_data,
> > +	.num_init	 =3D ARRAY_SIZE(lm3697_init_data),
> > +	.channel	 =3D lm3697_channel_data,
> > +	.mode		 =3D lm3697_mode_data,
> > +	.ramp		 =3D lm3697_ramp_data,
> > +	.ramp_reg_offset =3D 1, /* For LM3697_REG_BL1_RAMPUP/DN */
> > +	.enable		 =3D &lm3697_enable_reg,
> > +	.brightness_msb	 =3D lm3697_brightness_msb_regs,
> > +	.brightness_lsb	 =3D lm3697_brightness_lsb_regs,
> > +};
> > +
> > +static int lm3532_ramp_table[] =3D { 0, 1, 2, 4, 8, 16, 32, 65 };
> > +
> > +static int lm3631_ramp_table[] =3D {
> > +	   0,   1,   2,    5,   10,   20,   50,  100,
> > +	 250, 500, 750, 1000, 1500, 2000, 3000, 4000,
> > +};
> > +
> > +static int common_ramp_table[] =3D {
> > +	   2, 250, 500, 1000, 2000, 4000, 8000, 16000,
> > +};
> > +
> > +#define LM3532_MAX_CHANNELS		3
> > +#define LM3631_MAX_CHANNELS		2
> > +#define LM3632_MAX_CHANNELS		2
> > +#define LM3633_MAX_CHANNELS		3
> > +#define LM3695_MAX_CHANNELS		2
> > +#define LM3697_MAX_CHANNELS		3
> > +
> > +const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID] =3D {
> > +	{
> > +		.reginfo		=3D &lm3532_reg_info,
> > +		.num_channels		=3D LM3532_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_8BIT,
> > +		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
> > +		.ramp_table		=3D lm3532_ramp_table,
> > +		.size_ramp		=3D ARRAY_SIZE(lm3532_ramp_table),
> > +	},
> > +	{
> > +		.reginfo		=3D &lm3631_reg_info,
> > +		.num_channels		=3D LM3631_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
> > +		.pwm_action		=3D UPDATE_PWM_ONLY,
> > +		.ramp_table		=3D lm3631_ramp_table,
> > +		.size_ramp		=3D ARRAY_SIZE(lm3631_ramp_table),
> > +	},
> > +	{
> > +		.reginfo		=3D &lm3632_reg_info,
> > +		.num_channels		=3D LM3632_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
> > +		.pwm_action		=3D UPDATE_PWM_ONLY,
> > +	},
> > +	{
> > +		.reginfo		=3D &lm3633_reg_info,
> > +		.num_channels		=3D LM3633_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
> > +		.pwm_action		=3D UPDATE_MAX_BRT,
> > +		.ramp_table		=3D common_ramp_table,
> > +		.size_ramp		=3D ARRAY_SIZE(common_ramp_table),
> > +		.fault_monitor_used	=3D true,
> > +	},
> > +	{
> > +		.reginfo		=3D &lm3695_reg_info,
> > +		.num_channels		=3D LM3695_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
> > +		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
> > +	},
> > +	{
> > +		.reginfo		=3D &lm3697_reg_info,
> > +		.num_channels		=3D LM3697_MAX_CHANNELS,
> > +		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
> > +		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
> > +		.ramp_table		=3D common_ramp_table,
> > +		.size_ramp		=3D ARRAY_SIZE(common_ramp_table),
> > +		.fault_monitor_used	=3D true,
> > +	},
> > +};
> > diff --git a/drivers/video/backlight/ti-lmu-backlight-data.h b/drivers/=
video/backlight/ti-lmu-backlight-data.h
> > new file mode 100644
> > index 000000000000..c64e8e6513e1
> > --- /dev/null
> > +++ b/drivers/video/backlight/ti-lmu-backlight-data.h
> > @@ -0,0 +1,95 @@
> > +/*
>=20
> Inconsistent licensing here the core has
> // SPDX-License-Identifier: GPL-2.0

See above.

> > + * TI LMU (Lighting Management Unit) Backlight Device Data Definitions
> > + *
> > + * Copyright 2015 Texas Instruments
> > + *
> > + * Author: Milo Kim <milo.kim@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __TI_LMU_BACKLIGHT_H__
> > +#define __TI_LMU_BACKLIGHT_H__
> > +
> > +#include <linux/mfd/ti-lmu.h>
> > +#include <linux/mfd/ti-lmu-register.h>
> > +
> > +#define MAX_BRIGHTNESS_8BIT		255
> > +#define MAX_BRIGHTNESS_11BIT		2047
> > +
> > +enum ti_lmu_bl_pwm_action {
> > +	/* Update PWM duty, no brightness register update is required */
> > +	UPDATE_PWM_ONLY,
> > +	/* Update not only duty but also brightness register */
> > +	UPDATE_PWM_AND_BRT_REGISTER,
> > +	/* Update max value in brightness registers */
> > +	UPDATE_MAX_BRT,
> > +};
> > +
> > +struct lmu_bl_reg_data {
> > +	u8 reg;
> > +	u8 mask;
> > +	u8 val;
> > +};
> > +
> > +/**
> > + * struct ti_lmu_bl_reg
> > + *
> > + * @init:		Device initialization registers
> > + * @num_init:		Numbers of initialization registers
> > + * @channel:		Backlight channel configuration registers
> > + * @mode:		Brightness control mode registers
> > + * @ramp:		Ramp registers for lighting effect
> > + * @ramp_reg_offset:	Ramp register offset.
> > + *			Only used for multiple ramp registers.
> > + * @enable:		Enable control register address
> > + * @enable_usec:	Delay time for updating enable register.
> > + *			Unit is microsecond.
> > + * @brightness_msb:	Brightness MSB(Upper 8 bits) registers.
> > + *			Concatenated with LSB in 11 bit dimming mode.
> > + *			In 8 bit dimming, only MSB is used.
> > + * @brightness_lsb:	Brightness LSB(Lower 3 bits) registers.
> > + *			Only valid in 11 bit dimming mode.
> > + */
> > +struct ti_lmu_bl_reg {
> > +	const struct lmu_bl_reg_data *init;
> > +	int num_init;
> > +	const struct lmu_bl_reg_data *channel;
> > +	const struct lmu_bl_reg_data *mode;
> > +	const struct lmu_bl_reg_data *ramp;
> > +	int ramp_reg_offset;
> > +	u8 *enable;
> > +	unsigned long enable_usec;
> > +	u8 *brightness_msb;
> > +	u8 *brightness_lsb;
> > +};
> > +
> > +/**
> > + * struct ti_lmu_bl_cfg
> > + *
> > + * @reginfo:		Device register configuration
> > + * @num_channels:	Number of backlight channels
> > + * @max_brightness:	Max brightness value of backlight device
> > + * @pwm_action:		How to control brightness registers in PWM mode
> > + * @ramp_table:		[Optional] Ramp time table for lighting effect.
> > + *			It's used for searching approximate register index.
> > + * @size_ramp:		[Optional] Size of ramp table
> > + * @fault_monitor_used:	[Optional] Set true if the device needs to han=
dle
> > + *			LMU fault monitor event.
> > + *
> > + * This structure is used for device specific data configuration.
> > + */
> > +struct ti_lmu_bl_cfg {
> > +	const struct ti_lmu_bl_reg *reginfo;
> > +	int num_channels;
> > +	int max_brightness;
> > +	enum ti_lmu_bl_pwm_action pwm_action;
> > +	int *ramp_table;
> > +	int size_ramp;
> > +	bool fault_monitor_used;
> > +};
> > +
> > +extern const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID];
> > +#endif
> >=20

-- Sebastian

--w3ytjpvmiq6z7ra7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrLkJYACgkQ2O7X88g7
+pq6/g/9HV8Oa7b8AGxFOm3xdLrJKBaG2gA5DW4WQKGAPyYvuLh9L0U7F+7i9yxG
xtKy3AzTCWDG/i/noVNBXozE9G83SEfOIf0Oc4i4LV0wLV1uqpODYN8pb8oDsB1N
72x39cal1IHW6gcHVn80rdVunOX42Kwsu0JIZ0kZqPvojtWv0msUiWiTzt4gPbWP
FCrcx92KiaZXp7DIbM3jo0XNqlav0OL+ZP7RnhZaFxLbxluY4gB+4w5i+yDJQJfl
I3ccHdc3syNz1ZR6uodS+MgGQKLeK/PA3b5206mDriPOIVCtXkTRxeZAh4Mo5zZa
jT2b8uGb/KTsiYrpzdpYAveH4tLBJnNIWnI5aqkGqUviHgg7b/MfXqWVrx0L6vSg
rYh5TawLlOyuRumGZmxI9cK06/wci4HHmPMdpDaj6zBQW0Q17HCcZRM+KiyIH+uh
7xUB+kTN04myxagn3RoIj+S9k0tuAWu0NLXgosJrMbfN+l1HBi9NonbjcgqUjz6l
Flvry50VWk1ZjXt8pyH29vMidE90BKOX4U/Bpb5Yy78dTqPBPB1ptAE2xdtdUXfd
XMHdFcD7O+ma0vFSvKsi5BnQZoboVDoB7DVUO/qOqhExWBmpPTx55Pwu1EpD0zeO
PiclKGZDB5YYjdaNqGX6Oyt9IjUnBkdPLdeQOlyQ00ggXyg8F8A=
=BjUk
-----END PGP SIGNATURE-----

--w3ytjpvmiq6z7ra7--
