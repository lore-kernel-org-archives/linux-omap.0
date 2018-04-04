From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Date: Wed, 4 Apr 2018 13:30:37 -0500
Message-ID: <1c69be8b-1ba0-a596-6c54-022b1baf3812@ti.com>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Sebastian

-Milo Kim email is not valid

On 03/30/2018 12:24 PM, Sebastian Reichel wrote:
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> 
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
>  binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/video/backlight/Kconfig                 |   7 +
>  drivers/video/backlight/Makefile                |   3 +
>  drivers/video/backlight/ti-lmu-backlight-core.c | 666 ++++++++++++++++++++++++
>  drivers/video/backlight/ti-lmu-backlight-data.c | 304 +++++++++++
>  drivers/video/backlight/ti-lmu-backlight-data.h |  95 ++++
>  5 files changed, 1075 insertions(+)
>  create mode 100644 drivers/video/backlight/ti-lmu-backlight-core.c
>  create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.c
>  create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.h
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 5d2d0d7e8100..27e6c5a0add8 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -427,6 +427,13 @@ config BACKLIGHT_SKY81452
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called sky81452-backlight
>  
> +config BACKLIGHT_TI_LMU
> +	tristate "Backlight driver for TI LMU"
> +	depends on BACKLIGHT_CLASS_DEVICE && MFD_TI_LMU

select REGMAP?

> +	help
> +	  Say Y to enable the backlight driver for TI LMU devices.
> +	  This supports LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> +
>  config BACKLIGHT_TPS65217
>  	tristate "TPS65217 Backlight"
>  	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 19da71d518bf..a1132d3dfd4c 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -53,6 +53,9 @@ obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
>  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
> +ti-lmu-backlight-objs			:= ti-lmu-backlight-core.o \
> +					   ti-lmu-backlight-data.o
> +obj-$(CONFIG_BACKLIGHT_TI_LMU)		+= ti-lmu-backlight.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
> diff --git a/drivers/video/backlight/ti-lmu-backlight-core.c b/drivers/video/backlight/ti-lmu-backlight-core.c
> new file mode 100644
> index 000000000000..a6099581edd7
> --- /dev/null
> +++ b/drivers/video/backlight/ti-lmu-backlight-core.c
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2015 Texas Instruments
> + * Copyright 2018 Sebastian Reichel
> + *
> + * TI LMU Backlight driver, based on previous work from
> + * Milo Kim <milo.kim@ti.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/ti-lmu.h>
> +#include <linux/mfd/ti-lmu-register.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "ti-lmu-backlight-data.h"
> +
> +enum ti_lmu_bl_ctrl_mode {
> +	BL_REGISTER_BASED,
> +	BL_PWM_BASED,
> +};
> +
> +enum ti_lmu_bl_type {
> +	TI_LMU_BL,  /* backlight userspace interface */
> +	TI_LMU_LED, /* led userspace interface */
> +};
> +
> +enum ti_lmu_bl_ramp_mode {
> +	BL_RAMP_UP,
> +	BL_RAMP_DOWN,
> +};
> +
> +#define DEFAULT_PWM_NAME			"lmu-backlight"

I don't see this used.

> +#define NUM_DUAL_CHANNEL			2
> +#define LMU_BACKLIGHT_DUAL_CHANNEL_USED		(BIT(0) | BIT(1))
> +#define LMU_BACKLIGHT_11BIT_LSB_MASK		(BIT(0) | BIT(1) | BIT(2))
> +#define LMU_BACKLIGHT_11BIT_MSB_SHIFT		3
> +

Struct kerneldoc?

> +struct ti_lmu_bank {
> +	struct device *dev;
> +	int bank_id;
> +	const struct ti_lmu_bl_cfg *cfg;
> +	struct ti_lmu *lmu;
> +	const char *label;
> +	int leds;
> +	int current_brightness;
> +	u32 default_brightness;
> +	u32 ramp_up_msec;
> +	u32 ramp_down_msec;
> +	u32 pwm_period;
> +	enum ti_lmu_bl_ctrl_mode mode;
> +	enum ti_lmu_bl_type type;
> +
> +	struct notifier_block nb;
> +
> +	struct backlight_device *backlight;
> +	struct led_classdev *led;
> +};
> +
> +static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	unsigned long enable_time = lmu_bank->cfg->reginfo->enable_usec;
> +	u8 *reg = lmu_bank->cfg->reginfo->enable;
> +	u8 mask = BIT(lmu_bank->bank_id);
> +	u8 val = (enable == true) ? mask : 0;
> +	int ret;
> +
> +	if (!reg)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(regmap, *reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	if (enable_time > 0)
> +		usleep_range(enable_time, enable_time + 100);
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_update_brightness_register(struct ti_lmu_bank *lmu_bank,
> +						       int brightness)
> +{
> +	const struct ti_lmu_bl_cfg *cfg = lmu_bank->cfg;
> +	const struct ti_lmu_bl_reg *reginfo = cfg->reginfo;
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	u8 reg, val;
> +	int ret;
> +
> +	/*
> +	 * Brightness register update
> +	 *
> +	 * 11 bit dimming: update LSB bits and write MSB byte.
> +	 *		   MSB brightness should be shifted.
> +	 *  8 bit dimming: write MSB byte.
> +	 */
> +	if (cfg->max_brightness == MAX_BRIGHTNESS_11BIT) {
> +		reg = reginfo->brightness_lsb[lmu_bank->bank_id];
> +		ret = regmap_update_bits(regmap, reg,
> +					 LMU_BACKLIGHT_11BIT_LSB_MASK,
> +					 brightness);
> +		if (ret)
> +			return ret;
> +
> +		val = brightness >> LMU_BACKLIGHT_11BIT_MSB_SHIFT;
> +	} else {
> +		val = brightness;
> +	}
> +
> +	reg = reginfo->brightness_msb[lmu_bank->bank_id];
> +	return regmap_write(regmap, reg, val);
> +}
> +
> +static int ti_lmu_bl_pwm_ctrl(struct ti_lmu_bank *lmu_bank, int brightness)
> +{
> +	int max_brightness = lmu_bank->cfg->max_brightness;
> +	struct pwm_state state = { };
> +	int ret;
> +
> +	if (!lmu_bank->lmu->pwm) {
> +		dev_err(lmu_bank->dev, "Missing PWM device!\n");
> +		return -ENODEV;
> +	}
> +
> +	pwm_init_state(lmu_bank->lmu->pwm, &state);
> +	state.period = lmu_bank->pwm_period;
> +	state.duty_cycle = brightness * state.period / max_brightness;
> +
> +	if (state.duty_cycle)
> +		state.enabled = true;
> +	else
> +		state.enabled = false;
> +
> +	ret = pwm_apply_state(lmu_bank->lmu->pwm, &state);
> +	if (ret)
> +		dev_err(lmu_bank->dev, "Failed to configure PWM: %d", ret);
> +
> +	return ret;
> +}
> +
> +static int ti_lmu_bl_set_brightness(struct ti_lmu_bank *lmu_bank,
> +				    int brightness)
> +{
> +	const struct ti_lmu_bl_cfg *cfg = lmu_bank->cfg;
> +	bool enable = brightness > 0;
> +	int ret;
> +

Is there anyway that update_status and set_led_blocking can be called at the same time causing
a race condition in this api?

> +	ret = ti_lmu_bl_enable(lmu_bank, enable);
> +	if (ret)
> +		return ret;
> +
> +	if (lmu_bank->mode == BL_PWM_BASED) {
> +		ti_lmu_bl_pwm_ctrl(lmu_bank, brightness);
> +
> +		switch (cfg->pwm_action) {
> +		case UPDATE_PWM_ONLY:
> +			/* No register update is required */
> +			return 0;
> +		case UPDATE_MAX_BRT:
> +			/*
> +			 * PWM can start from any non-zero code and dim down
> +			 * to zero. So, brightness register should be updated
> +			 * even in PWM mode.
> +			 */
> +			if (brightness > 0)
> +				brightness = MAX_BRIGHTNESS_11BIT;
> +			else
> +				brightness = 0;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	lmu_bank->current_brightness = brightness;
> +
> +	return ti_lmu_bl_update_brightness_register(lmu_bank, brightness);
> +}
> +
> +static int ti_lmu_bl_update_status(struct backlight_device *bl_dev)
> +{
> +	struct ti_lmu_bank *lmu_bank = bl_get_data(bl_dev);
> +	int brightness = bl_dev->props.brightness;
> +
> +	if (bl_dev->props.state & BL_CORE_SUSPENDED)
> +		brightness = 0;
> +
> +	return ti_lmu_bl_set_brightness(lmu_bank, brightness);
> +}
> +
> +static const struct backlight_ops lmu_backlight_ops = {
> +	.options = BL_CORE_SUSPENDRESUME,
> +	.update_status = ti_lmu_bl_update_status,
> +};
> +
> +static int ti_lmu_bl_set_led_blocking(struct led_classdev *ledc,
> +					     enum led_brightness value)
> +{
> +	struct ti_lmu_bank *lmu_bank = dev_get_drvdata(ledc->dev->parent);
> +	int brightness = value;
> +
> +	return ti_lmu_bl_set_brightness(lmu_bank, brightness);
> +}
> +
> +static int ti_lmu_bl_check_channel(struct ti_lmu_bank *lmu_bank)
> +{
> +	const struct ti_lmu_bl_cfg *cfg = lmu_bank->cfg;
> +	const struct ti_lmu_bl_reg *reginfo = cfg->reginfo;
> +
> +	if (!reginfo->brightness_msb)
> +		return -EINVAL;
> +
> +	if (cfg->max_brightness > MAX_BRIGHTNESS_8BIT) {
> +		if (!reginfo->brightness_lsb)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_create_channel(struct ti_lmu_bank *lmu_bank)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	const struct lmu_bl_reg_data *regdata = lmu_bank->cfg->reginfo->channel;
> +	int num_channels = lmu_bank->cfg->num_channels;
> +	unsigned long led_sources = lmu_bank->leds;
> +	int i, ret;
> +	u8 shift;
> +
> +	/*
> +	 * How to create backlight output channels:
> +	 *   Check 'led_sources' bit and update registers.
> +	 *
> +	 *   1) Dual channel configuration
> +	 *     The 1st register data is used for single channel.
> +	 *     The 2nd register data is used for dual channel.
> +	 *
> +	 *   2) Multiple channel configuration
> +	 *     Each register data is mapped to bank ID.
> +	 *     Bit shift operation is defined in channel registers.
> +	 *
> +	 * Channel register data consists of address, mask, value.
> +	 */
> +
> +	if (num_channels == NUM_DUAL_CHANNEL) {
> +		if (led_sources == LMU_BACKLIGHT_DUAL_CHANNEL_USED)
> +			regdata++;
> +
> +		return regmap_update_bits(regmap, regdata->reg, regdata->mask,
> +					  regdata->val);
> +	}
> +
> +	for (i = 0; regdata && i < num_channels; i++) {
> +		/*
> +		 * Note that the result of regdata->val is shift bit.
> +		 * The bank_id should be shifted for the channel configuration.
> +		 */
> +		if (test_bit(i, &led_sources)) {
> +			shift = regdata->val;
> +			ret = regmap_update_bits(regmap, regdata->reg,
> +						 regdata->mask,
> +						 lmu_bank->bank_id << shift);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		regdata++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_update_ctrl_mode(struct ti_lmu_bank *lmu_bank)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	const struct lmu_bl_reg_data *regdata =
> +		lmu_bank->cfg->reginfo->mode + lmu_bank->bank_id;
> +	u8 val = regdata->val;
> +
> +	if (!regdata)
> +		return 0;
> +
> +	/*
> +	 * Update PWM configuration register.
> +	 * If the mode is register based, then clear the bit.
> +	 */
> +	if (lmu_bank->mode != BL_PWM_BASED)
> +		val = 0;
> +
> +	return regmap_update_bits(regmap, regdata->reg, regdata->mask, val);
> +}
> +
> +static int ti_lmu_bl_convert_ramp_to_index(struct ti_lmu_bank *lmu_bank,
> +						  enum ti_lmu_bl_ramp_mode mode)
> +{
> +	const int *ramp_table = lmu_bank->cfg->ramp_table;
> +	const int size = lmu_bank->cfg->size_ramp;
> +	unsigned int msec;
> +	int i;
> +
> +	if (!ramp_table)
> +		return -EINVAL;
> +
> +	switch (mode) {
> +	case BL_RAMP_UP:
> +		msec = lmu_bank->ramp_up_msec;
> +		break;
> +	case BL_RAMP_DOWN:
> +		msec = lmu_bank->ramp_down_msec;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (msec <= ramp_table[0])
> +		return 0;
> +
> +	if (msec > ramp_table[size - 1])
> +		return size - 1;
> +
> +	for (i = 1; i < size; i++) {
> +		if (msec == ramp_table[i])
> +			return i;
> +
> +		/* Find an approximate index by looking up the table */
> +		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
> +			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
> +				return i - 1;
> +			else
> +				return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +

Extra new line

> +static int ti_lmu_bl_set_ramp(struct ti_lmu_bank *lmu_bank)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	const struct ti_lmu_bl_reg *reginfo = lmu_bank->cfg->reginfo;
> +	int offset = reginfo->ramp_reg_offset;
> +	int i, ret, index;
> +	struct lmu_bl_reg_data regdata;
> +
> +	for (i = BL_RAMP_UP; i <= BL_RAMP_DOWN; i++) {
> +		index = ti_lmu_bl_convert_ramp_to_index(lmu_bank, i);
> +		if (index > 0) {
> +			if (!reginfo->ramp)
> +				break;
> +
> +			regdata = reginfo->ramp[i];
> +			if (lmu_bank->bank_id != 0)
> +				regdata.val += offset;
> +
> +			/* regdata.val is shift bit */
> +			ret = regmap_update_bits(regmap, regdata.reg,
> +						 regdata.mask,
> +						 index << regdata.val);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_configure(struct ti_lmu_bank *lmu_bank)
> +{
> +	int ret;
> +
> +	ret = ti_lmu_bl_check_channel(lmu_bank);
> +	if (ret)
> +		return ret;
> +
> +	ret = ti_lmu_bl_create_channel(lmu_bank);
> +	if (ret)
> +		return ret;
> +
> +	ret = ti_lmu_bl_update_ctrl_mode(lmu_bank);
> +	if (ret)
> +		return ret;
> +
> +	return ti_lmu_bl_set_ramp(lmu_bank);
> +}
> +
> +static int ti_lmu_bl_register_backlight(struct ti_lmu_bank *lmu_bank)
> +{
> +	struct backlight_device *bl_dev;
> +	struct backlight_properties props;
> +
> +	if (lmu_bank->type != TI_LMU_BL)
> +		return -EINVAL;
> +
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type = BACKLIGHT_PLATFORM;
> +	props.brightness = lmu_bank->default_brightness;
> +	props.max_brightness = lmu_bank->cfg->max_brightness;
> +
> +	bl_dev = devm_backlight_device_register(lmu_bank->dev, lmu_bank->label,
> +						lmu_bank->dev, lmu_bank,
> +						&lmu_backlight_ops, &props);
> +	if (IS_ERR(bl_dev))
> +		return PTR_ERR(bl_dev);
> +
> +	lmu_bank->backlight = bl_dev;
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_register_led(struct ti_lmu_bank *lmu_bank)
> +{
> +	int err;
> +
> +	if (lmu_bank->type != TI_LMU_LED)
> +		return -EINVAL;
> +
> +	lmu_bank->led = devm_kzalloc(lmu_bank->dev, sizeof(*lmu_bank->led),
> +				     GFP_KERNEL);
> +	if (!lmu_bank->led)
> +		return -ENOMEM;
> +
> +	lmu_bank->led->name = lmu_bank->label;
> +	lmu_bank->led->max_brightness = lmu_bank->cfg->max_brightness;
> +	lmu_bank->led->brightness_set_blocking =
> +		ti_lmu_bl_set_led_blocking;
> +
> +	err = devm_led_classdev_register(lmu_bank->dev, lmu_bank->led);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
> +{
> +	switch (lmu_bank->type) {
> +	case TI_LMU_BL:
> +		return ti_lmu_bl_register_backlight(lmu_bank);
> +	case TI_LMU_LED:
> +		return ti_lmu_bl_register_led(lmu_bank);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int setup_of_node(struct platform_device *pdev)

This seems a bit generic.  Maybe keep with the naming convention

ti_lmu_setup_of_node

> +{
> +	struct device_node *parent_node = pdev->dev.parent->of_node;
> +	char *name;
> +
> +	if (!parent_node)
> +		return 0;
> +
> +	name = kasprintf(GFP_KERNEL, "bank%d", pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	pdev->dev.of_node = of_get_child_by_name(parent_node, name);
> +	kfree(name);
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_parse_led_sources(struct device *dev)
> +{
> +	unsigned long mask = 0;
> +	int ret;
> +	int size, i;
> +	u32 *leds;
> +
> +	size = device_property_read_u32_array(dev, "ti,led-sources", NULL, 0);
> +	if (size <= 0) {
> +		dev_err(dev, "Missing or malformed property led-sources: %d\n",
> +			size);
> +		return size < 0 ? size : -EINVAL;

Why the additional check? Why not just return -EINVAL?

> +	}
> +
> +	leds = kmalloc_array(size, sizeof(u32), GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "ti,led-sources", leds, size);
> +	if (ret) {
> +		dev_err(dev, "Failed to read led-sources property: %d\n", ret);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < size; i++)
> +		set_bit(leds[i], &mask);
> +
> +	ret = mask;
> +
> +out:
> +	kfree(leds);
> +	return ret;
> +}
> +
> +static int ti_lmu_bl_init(struct ti_lmu_bank *lmu_bank)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	const struct lmu_bl_reg_data *regdata =
> +		lmu_bank->cfg->reginfo->init;
> +	int num_init = lmu_bank->cfg->reginfo->num_init;
> +	int i, ret;
> +
> +	if (lmu_bank->lmu->backlight_initialized)
> +		return 0;

Add a new line here

> +	lmu_bank->lmu->backlight_initialized = true;
> +
> +	for (i = 0; regdata && i < num_init; i++) {
> +		ret = regmap_update_bits(regmap, regdata->reg, regdata->mask,
> +					 regdata->val);
> +		if (ret)
> +			return ret;
> +
> +		regdata++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_reload(struct ti_lmu_bank *lmu_bank)
> +{
> +	int err;
> +
> +	ti_lmu_bl_init(lmu_bank);
> +
> +	err = ti_lmu_bl_configure(lmu_bank);
> +	if (err)
> +		return err;
> +
> +	return ti_lmu_bl_set_brightness(lmu_bank, lmu_bank->current_brightness);
> +}
> +
> +static int ti_lmu_bl_monitor_notifier(struct notifier_block *nb,
> +					     unsigned long action, void *unused)
> +{
> +	struct ti_lmu_bank *lmu_bank = container_of(nb, struct ti_lmu_bank, nb);
> +
> +	if (action == LMU_EVENT_MONITOR_DONE) {
> +		if (ti_lmu_bl_reload(lmu_bank))
> +			return NOTIFY_STOP;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int ti_lmu_bl_probe(struct platform_device *pdev)
> +{
> +	struct ti_lmu_bank *lmu_bank;
> +	int err;
> +
> +	err = setup_of_node(pdev);
> +	if (err)
> +		return err;
> +
> +	lmu_bank = devm_kzalloc(&pdev->dev, sizeof(*lmu_bank), GFP_KERNEL);
> +	if (!lmu_bank)
> +		return -ENOMEM;

Add a new line here

> +	lmu_bank->dev = &pdev->dev;
> +	dev_set_drvdata(&pdev->dev, lmu_bank);
> +
> +	err = device_property_read_string(&pdev->dev, "label",
> +					  &lmu_bank->label);
> +	if (err)
> +		return err;
> +
> +	lmu_bank->type = TI_LMU_BL;
> +	if (!strcmp(lmu_bank->label, "keyboard")) {
> +		lmu_bank->type = TI_LMU_LED;
> +		lmu_bank->label = "kbd_backlight";

What is the reason for changing the label?  Why can't the label in the DT be kbd_backlight?

> +	}
> +
> +	lmu_bank->leds = ti_lmu_parse_led_sources(&pdev->dev);
> +	if (lmu_bank->leds < 0)
> +		return lmu_bank->leds;
> +	else if (lmu_bank->leds == 0)
> +		return -EINVAL;
> +
> +	device_property_read_u32(&pdev->dev, "default-brightness-level",
> +				 &lmu_bank->default_brightness);
> +	device_property_read_u32(&pdev->dev, "ti,ramp-up-ms",
> +				 &lmu_bank->ramp_up_msec);
> +	device_property_read_u32(&pdev->dev, "ti,ramp-down-ms",
> +				 &lmu_bank->ramp_down_msec);
> +	device_property_read_u32(&pdev->dev, "pwm-period",
> +				 &lmu_bank->pwm_period);
> +
> +	if (lmu_bank->pwm_period > 0)
> +		lmu_bank->mode = BL_PWM_BASED;
> +	else
> +		lmu_bank->mode = BL_REGISTER_BASED;
> +
> +	lmu_bank->lmu = dev_get_drvdata(pdev->dev.parent);
> +	lmu_bank->cfg = &lmu_bl_cfg[lmu_bank->lmu->id];
> +	lmu_bank->bank_id = pdev->id;
> +
> +	ti_lmu_bl_init(lmu_bank);
> +
> +	err = ti_lmu_bl_configure(lmu_bank);
> +	if (err)
> +		return err;
> +
> +	err = ti_lmu_bl_add_device(lmu_bank);
> +	if (err)
> +		return err;
> +
> +	err = ti_lmu_bl_set_brightness(lmu_bank,
> +					      lmu_bank->default_brightness);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Notifier callback is required because backlight device needs
> +	 * reconfiguration after fault detection procedure is done by
> +	 * ti-lmu-fault-monitor driver.
> +	 */
> +	if (lmu_bank->cfg->fault_monitor_used) {
> +		lmu_bank->nb.notifier_call = ti_lmu_bl_monitor_notifier;
> +		err = blocking_notifier_chain_register(&lmu_bank->lmu->notifier,
> +						       &lmu_bank->nb);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_lmu_bl_remove(struct platform_device *pdev)
> +{
> +	struct ti_lmu_bank *lmu_bank = platform_get_drvdata(pdev);
> +
> +	if (lmu_bank->cfg->fault_monitor_used)
> +		blocking_notifier_chain_unregister(&lmu_bank->lmu->notifier,
> +						   &lmu_bank->nb);
> +
> +	ti_lmu_bl_set_brightness(lmu_bank, 0);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ti_lmu_bl_driver = {
> +	.probe  = ti_lmu_bl_probe,
> +	.remove  = ti_lmu_bl_remove,
> +	.driver = {
> +		.name = "ti-lmu-led-backlight",
> +	},
> +};
> +module_platform_driver(ti_lmu_bl_driver)
> +
> +MODULE_DESCRIPTION("TI LMU Backlight LED Driver");
> +MODULE_AUTHOR("Sebastian Reichel");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:ti-lmu-led-backlight");
> diff --git a/drivers/video/backlight/ti-lmu-backlight-data.c b/drivers/video/backlight/ti-lmu-backlight-data.c
> new file mode 100644
> index 000000000000..583136cb934d
> --- /dev/null
> +++ b/drivers/video/backlight/ti-lmu-backlight-data.c
> @@ -0,0 +1,304 @@
> +/*

Inconsistent licensing here the core has
// SPDX-License-Identifier: GPL-2.0

> + * TI LMU (Lighting Management Unit) Backlight Device Data
> + *
> + * Copyright 2015 Texas Instruments

Copyright?

> + *
> + * Author: Milo Kim <milo.kim@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "ti-lmu-backlight-data.h"
> +
> +/* LM3532 */
> +static const struct lmu_bl_reg_data lm3532_init_data[] = {
> +	{ LM3532_REG_ZONE_CFG_A, LM3532_ZONE_MASK, LM3532_ZONE_0 },
> +	{ LM3532_REG_ZONE_CFG_B, LM3532_ZONE_MASK, LM3532_ZONE_1 },
> +	{ LM3532_REG_ZONE_CFG_C, LM3532_ZONE_MASK, LM3532_ZONE_2 },
> +};
> +
> +static const struct lmu_bl_reg_data lm3532_channel_data[] = {
> +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED1_CFG_MASK,
> +	  LM3532_ILED1_CFG_SHIFT },
> +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED2_CFG_MASK,
> +	  LM3532_ILED2_CFG_SHIFT },
> +	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED3_CFG_MASK,
> +	  LM3532_ILED3_CFG_SHIFT },
> +};
> +
> +static const struct lmu_bl_reg_data lm3532_mode_data[] = {
> +	{ LM3532_REG_PWM_A_CFG, LM3532_PWM_A_MASK, LM3532_PWM_ZONE_0 },
> +	{ LM3532_REG_PWM_B_CFG, LM3532_PWM_B_MASK, LM3532_PWM_ZONE_1 },
> +	{ LM3532_REG_PWM_C_CFG, LM3532_PWM_C_MASK, LM3532_PWM_ZONE_2 },
> +};
> +
> +static const struct lmu_bl_reg_data lm3532_ramp_data[] = {
> +	{ LM3532_REG_RAMPUP, LM3532_RAMPUP_MASK, LM3532_RAMPUP_SHIFT },
> +	{ LM3532_REG_RAMPDN, LM3532_RAMPDN_MASK, LM3532_RAMPDN_SHIFT },
> +};
> +
> +static u8 lm3532_enable_reg = LM3532_REG_ENABLE;
> +
> +static u8 lm3532_brightness_regs[] = {
> +	LM3532_REG_BRT_A,
> +	LM3532_REG_BRT_B,
> +	LM3532_REG_BRT_C,
> +};
> +
> +static const struct ti_lmu_bl_reg lm3532_reg_info = {
> +	.init		= lm3532_init_data,
> +	.num_init	= ARRAY_SIZE(lm3532_init_data),
> +	.channel	= lm3532_channel_data,
> +	.mode		= lm3532_mode_data,
> +	.ramp		= lm3532_ramp_data,
> +	.enable		= &lm3532_enable_reg,
> +	.brightness_msb	= lm3532_brightness_regs,
> +};
> +
> +/* LM3631 */
> +static const struct lmu_bl_reg_data lm3631_init_data[] = {
> +	{ LM3631_REG_BRT_MODE, LM3631_MODE_MASK, LM3631_DEFAULT_MODE },
> +	{ LM3631_REG_BL_CFG, LM3631_MAP_MASK, LM3631_EXPONENTIAL_MAP },
> +};
> +
> +static const struct lmu_bl_reg_data lm3631_channel_data[] = {
> +	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_SINGLE_CHANNEL },
> +	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_DUAL_CHANNEL },
> +};
> +
> +static const struct lmu_bl_reg_data lm3631_ramp_data[] = {
> +	{ LM3631_REG_SLOPE, LM3631_SLOPE_MASK, LM3631_SLOPE_SHIFT },
> +};
> +
> +static u8 lm3631_enable_reg = LM3631_REG_DEVCTRL;
> +static u8 lm3631_brightness_msb_reg = LM3631_REG_BRT_MSB;
> +static u8 lm3631_brightness_lsb_reg = LM3631_REG_BRT_LSB;
> +
> +static const struct ti_lmu_bl_reg lm3631_reg_info = {
> +	.init		= lm3631_init_data,
> +	.num_init	= ARRAY_SIZE(lm3631_init_data),
> +	.channel	= lm3631_channel_data,
> +	.ramp		= lm3631_ramp_data,
> +	.enable		= &lm3631_enable_reg,
> +	.brightness_msb	= &lm3631_brightness_msb_reg,
> +	.brightness_lsb	= &lm3631_brightness_lsb_reg,
> +};
> +
> +/* LM3632 */
> +static const struct lmu_bl_reg_data lm3632_init_data[] = {
> +	{ LM3632_REG_CONFIG1, LM3632_OVP_MASK, LM3632_OVP_25V },
> +	{ LM3632_REG_CONFIG2, LM3632_SWFREQ_MASK, LM3632_SWFREQ_1MHZ },
> +};
> +
> +static const struct lmu_bl_reg_data lm3632_channel_data[] = {
> +	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_SINGLE_CHANNEL },
> +	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_DUAL_CHANNEL },
> +};
> +
> +static const struct lmu_bl_reg_data lm3632_mode_data[] = {
> +	{ LM3632_REG_IO_CTRL, LM3632_PWM_MASK, LM3632_PWM_MODE },
> +};
> +
> +static u8 lm3632_enable_reg = LM3632_REG_ENABLE;
> +static u8 lm3632_brightness_msb_reg = LM3632_REG_BRT_MSB;
> +static u8 lm3632_brightness_lsb_reg = LM3632_REG_BRT_LSB;
> +
> +static const struct ti_lmu_bl_reg lm3632_reg_info = {
> +	.init		= lm3632_init_data,
> +	.num_init	= ARRAY_SIZE(lm3632_init_data),
> +	.channel	= lm3632_channel_data,
> +	.mode		= lm3632_mode_data,
> +	.enable		= &lm3632_enable_reg,
> +	.brightness_msb	= &lm3632_brightness_msb_reg,
> +	.brightness_lsb	= &lm3632_brightness_lsb_reg,
> +};
> +
> +/* LM3633 */
> +static const struct lmu_bl_reg_data lm3633_init_data[] = {
> +	{ LM3633_REG_BOOST_CFG, LM3633_OVP_MASK, LM3633_OVP_40V },
> +	{ LM3633_REG_BL_RAMP_CONF, LM3633_BL_RAMP_MASK, LM3633_BL_RAMP_EACH },
> +};
> +
> +static const struct lmu_bl_reg_data lm3633_channel_data[] = {
> +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED1_CFG_MASK,
> +	  LM3633_HVLED1_CFG_SHIFT },
> +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED2_CFG_MASK,
> +	  LM3633_HVLED2_CFG_SHIFT },
> +	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED3_CFG_MASK,
> +	  LM3633_HVLED3_CFG_SHIFT },
> +};
> +
> +static const struct lmu_bl_reg_data lm3633_mode_data[] = {
> +	{ LM3633_REG_PWM_CFG, LM3633_PWM_A_MASK, LM3633_PWM_A_MASK },
> +	{ LM3633_REG_PWM_CFG, LM3633_PWM_B_MASK, LM3633_PWM_B_MASK },
> +};
> +
> +static const struct lmu_bl_reg_data lm3633_ramp_data[] = {
> +	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPUP_MASK, LM3633_BL_RAMPUP_SHIFT },
> +	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPDN_MASK, LM3633_BL_RAMPDN_SHIFT },
> +};
> +
> +static u8 lm3633_enable_reg = LM3633_REG_ENABLE;
> +
> +static u8 lm3633_brightness_msb_regs[] = {
> +	LM3633_REG_BRT_HVLED_A_MSB,
> +	LM3633_REG_BRT_HVLED_B_MSB,
> +};
> +
> +static u8 lm3633_brightness_lsb_regs[] = {
> +	LM3633_REG_BRT_HVLED_A_LSB,
> +	LM3633_REG_BRT_HVLED_B_LSB,
> +};
> +
> +static const struct ti_lmu_bl_reg lm3633_reg_info = {
> +	.init		 = lm3633_init_data,
> +	.num_init	 = ARRAY_SIZE(lm3633_init_data),
> +	.channel	 = lm3633_channel_data,
> +	.mode		 = lm3633_mode_data,
> +	.ramp		 = lm3633_ramp_data,
> +	.ramp_reg_offset = 1, /* For LM3633_REG_BL1_RAMPUP/DN */
> +	.enable		 = &lm3633_enable_reg,
> +	.brightness_msb	 = lm3633_brightness_msb_regs,
> +	.brightness_lsb	 = lm3633_brightness_lsb_regs,
> +};
> +
> +/* LM3695 */
> +static const struct lmu_bl_reg_data lm3695_init_data[] = {
> +	{ LM3695_REG_GP, LM3695_BRT_RW_MASK, LM3695_BRT_RW_MASK },
> +};
> +
> +static const struct lmu_bl_reg_data lm3695_channel_data[] = {
> +	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_SINGLE_CHANNEL },
> +	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_DUAL_CHANNEL },
> +};
> +
> +static u8 lm3695_enable_reg = LM3695_REG_GP;
> +static u8 lm3695_brightness_msb_reg = LM3695_REG_BRT_MSB;
> +static u8 lm3695_brightness_lsb_reg = LM3695_REG_BRT_LSB;
> +
> +static const struct ti_lmu_bl_reg lm3695_reg_info = {
> +	.init		= lm3695_init_data,
> +	.num_init	= ARRAY_SIZE(lm3695_init_data),
> +	.channel	= lm3695_channel_data,
> +	.enable		= &lm3695_enable_reg,
> +	.enable_usec	= 600,
> +	.brightness_msb	= &lm3695_brightness_msb_reg,
> +	.brightness_lsb	= &lm3695_brightness_lsb_reg,
> +};
> +
> +/* LM3697 */
> +static const struct lmu_bl_reg_data lm3697_init_data[] = {
> +	{ LM3697_REG_RAMP_CONF, LM3697_RAMP_MASK, LM3697_RAMP_EACH },
> +};
> +
> +static const struct lmu_bl_reg_data lm3697_channel_data[] = {
> +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED1_CFG_MASK,
> +	  LM3697_HVLED1_CFG_SHIFT },
> +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED2_CFG_MASK,
> +	  LM3697_HVLED2_CFG_SHIFT },
> +	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED3_CFG_MASK,
> +	  LM3697_HVLED3_CFG_SHIFT },
> +};
> +
> +static const struct lmu_bl_reg_data lm3697_mode_data[] = {
> +	{ LM3697_REG_PWM_CFG, LM3697_PWM_A_MASK, LM3697_PWM_A_MASK },
> +	{ LM3697_REG_PWM_CFG, LM3697_PWM_B_MASK, LM3697_PWM_B_MASK },
> +};
> +
> +static const struct lmu_bl_reg_data lm3697_ramp_data[] = {
> +	{ LM3697_REG_BL0_RAMP, LM3697_RAMPUP_MASK, LM3697_RAMPUP_SHIFT },
> +	{ LM3697_REG_BL0_RAMP, LM3697_RAMPDN_MASK, LM3697_RAMPDN_SHIFT },
> +};
> +
> +static u8 lm3697_enable_reg = LM3697_REG_ENABLE;
> +
> +static u8 lm3697_brightness_msb_regs[] = {
> +	LM3697_REG_BRT_A_MSB,
> +	LM3697_REG_BRT_B_MSB,
> +};
> +
> +static u8 lm3697_brightness_lsb_regs[] = {
> +	LM3697_REG_BRT_A_LSB,
> +	LM3697_REG_BRT_B_LSB,
> +};
> +
> +static const struct ti_lmu_bl_reg lm3697_reg_info = {
> +	.init		 = lm3697_init_data,
> +	.num_init	 = ARRAY_SIZE(lm3697_init_data),
> +	.channel	 = lm3697_channel_data,
> +	.mode		 = lm3697_mode_data,
> +	.ramp		 = lm3697_ramp_data,
> +	.ramp_reg_offset = 1, /* For LM3697_REG_BL1_RAMPUP/DN */
> +	.enable		 = &lm3697_enable_reg,
> +	.brightness_msb	 = lm3697_brightness_msb_regs,
> +	.brightness_lsb	 = lm3697_brightness_lsb_regs,
> +};
> +
> +static int lm3532_ramp_table[] = { 0, 1, 2, 4, 8, 16, 32, 65 };
> +
> +static int lm3631_ramp_table[] = {
> +	   0,   1,   2,    5,   10,   20,   50,  100,
> +	 250, 500, 750, 1000, 1500, 2000, 3000, 4000,
> +};
> +
> +static int common_ramp_table[] = {
> +	   2, 250, 500, 1000, 2000, 4000, 8000, 16000,
> +};
> +
> +#define LM3532_MAX_CHANNELS		3
> +#define LM3631_MAX_CHANNELS		2
> +#define LM3632_MAX_CHANNELS		2
> +#define LM3633_MAX_CHANNELS		3
> +#define LM3695_MAX_CHANNELS		2
> +#define LM3697_MAX_CHANNELS		3
> +
> +const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID] = {
> +	{
> +		.reginfo		= &lm3532_reg_info,
> +		.num_channels		= LM3532_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_8BIT,
> +		.pwm_action		= UPDATE_PWM_AND_BRT_REGISTER,
> +		.ramp_table		= lm3532_ramp_table,
> +		.size_ramp		= ARRAY_SIZE(lm3532_ramp_table),
> +	},
> +	{
> +		.reginfo		= &lm3631_reg_info,
> +		.num_channels		= LM3631_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_11BIT,
> +		.pwm_action		= UPDATE_PWM_ONLY,
> +		.ramp_table		= lm3631_ramp_table,
> +		.size_ramp		= ARRAY_SIZE(lm3631_ramp_table),
> +	},
> +	{
> +		.reginfo		= &lm3632_reg_info,
> +		.num_channels		= LM3632_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_11BIT,
> +		.pwm_action		= UPDATE_PWM_ONLY,
> +	},
> +	{
> +		.reginfo		= &lm3633_reg_info,
> +		.num_channels		= LM3633_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_11BIT,
> +		.pwm_action		= UPDATE_MAX_BRT,
> +		.ramp_table		= common_ramp_table,
> +		.size_ramp		= ARRAY_SIZE(common_ramp_table),
> +		.fault_monitor_used	= true,
> +	},
> +	{
> +		.reginfo		= &lm3695_reg_info,
> +		.num_channels		= LM3695_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_11BIT,
> +		.pwm_action		= UPDATE_PWM_AND_BRT_REGISTER,
> +	},
> +	{
> +		.reginfo		= &lm3697_reg_info,
> +		.num_channels		= LM3697_MAX_CHANNELS,
> +		.max_brightness		= MAX_BRIGHTNESS_11BIT,
> +		.pwm_action		= UPDATE_PWM_AND_BRT_REGISTER,
> +		.ramp_table		= common_ramp_table,
> +		.size_ramp		= ARRAY_SIZE(common_ramp_table),
> +		.fault_monitor_used	= true,
> +	},
> +};
> diff --git a/drivers/video/backlight/ti-lmu-backlight-data.h b/drivers/video/backlight/ti-lmu-backlight-data.h
> new file mode 100644
> index 000000000000..c64e8e6513e1
> --- /dev/null
> +++ b/drivers/video/backlight/ti-lmu-backlight-data.h
> @@ -0,0 +1,95 @@
> +/*

Inconsistent licensing here the core has
// SPDX-License-Identifier: GPL-2.0

> + * TI LMU (Lighting Management Unit) Backlight Device Data Definitions
> + *
> + * Copyright 2015 Texas Instruments
> + *
> + * Author: Milo Kim <milo.kim@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __TI_LMU_BACKLIGHT_H__
> +#define __TI_LMU_BACKLIGHT_H__
> +
> +#include <linux/mfd/ti-lmu.h>
> +#include <linux/mfd/ti-lmu-register.h>
> +
> +#define MAX_BRIGHTNESS_8BIT		255
> +#define MAX_BRIGHTNESS_11BIT		2047
> +
> +enum ti_lmu_bl_pwm_action {
> +	/* Update PWM duty, no brightness register update is required */
> +	UPDATE_PWM_ONLY,
> +	/* Update not only duty but also brightness register */
> +	UPDATE_PWM_AND_BRT_REGISTER,
> +	/* Update max value in brightness registers */
> +	UPDATE_MAX_BRT,
> +};
> +
> +struct lmu_bl_reg_data {
> +	u8 reg;
> +	u8 mask;
> +	u8 val;
> +};
> +
> +/**
> + * struct ti_lmu_bl_reg
> + *
> + * @init:		Device initialization registers
> + * @num_init:		Numbers of initialization registers
> + * @channel:		Backlight channel configuration registers
> + * @mode:		Brightness control mode registers
> + * @ramp:		Ramp registers for lighting effect
> + * @ramp_reg_offset:	Ramp register offset.
> + *			Only used for multiple ramp registers.
> + * @enable:		Enable control register address
> + * @enable_usec:	Delay time for updating enable register.
> + *			Unit is microsecond.
> + * @brightness_msb:	Brightness MSB(Upper 8 bits) registers.
> + *			Concatenated with LSB in 11 bit dimming mode.
> + *			In 8 bit dimming, only MSB is used.
> + * @brightness_lsb:	Brightness LSB(Lower 3 bits) registers.
> + *			Only valid in 11 bit dimming mode.
> + */
> +struct ti_lmu_bl_reg {
> +	const struct lmu_bl_reg_data *init;
> +	int num_init;
> +	const struct lmu_bl_reg_data *channel;
> +	const struct lmu_bl_reg_data *mode;
> +	const struct lmu_bl_reg_data *ramp;
> +	int ramp_reg_offset;
> +	u8 *enable;
> +	unsigned long enable_usec;
> +	u8 *brightness_msb;
> +	u8 *brightness_lsb;
> +};
> +
> +/**
> + * struct ti_lmu_bl_cfg
> + *
> + * @reginfo:		Device register configuration
> + * @num_channels:	Number of backlight channels
> + * @max_brightness:	Max brightness value of backlight device
> + * @pwm_action:		How to control brightness registers in PWM mode
> + * @ramp_table:		[Optional] Ramp time table for lighting effect.
> + *			It's used for searching approximate register index.
> + * @size_ramp:		[Optional] Size of ramp table
> + * @fault_monitor_used:	[Optional] Set true if the device needs to handle
> + *			LMU fault monitor event.
> + *
> + * This structure is used for device specific data configuration.
> + */
> +struct ti_lmu_bl_cfg {
> +	const struct ti_lmu_bl_reg *reginfo;
> +	int num_channels;
> +	int max_brightness;
> +	enum ti_lmu_bl_pwm_action pwm_action;
> +	int *ramp_table;
> +	int size_ramp;
> +	bool fault_monitor_used;
> +};
> +
> +extern const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID];
> +#endif
> 


-- 
------------------
Dan Murphy
