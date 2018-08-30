From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [rfc] leds: add TI LMU backlight driver
Date: Thu, 30 Aug 2018 14:41:29 -0500
Message-ID: <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
References: <20180829212032.GB15786@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180829212032.GB15786@amd>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 08/29/2018 04:20 PM, Pavel Machek wrote:
> 
> Here's preview of driver for TI LMU. It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
> 
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> 
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> Does it looks mostly reasonable? I guess it will need some
> s/BACKLIGHT/LEDS/ , and I'll need to remove my debugging hacks.
> 
> I'd prefer this to be LED driver, first; I'll need to figure out what
> to do with backlight. I guess something like existing "backlight"
> trigger should do the trick.
> 

I looked at this driver from Milo before submitting a specific LM3697 driver.

I do not like this driver.
I don't like that it smashes numerous devices into some structure with varying register maps.

Not only that but it appears that you just pulled this driver from a repo and posted it without clean up.

If the devices share register maps and can be added to families I would prefer to do it that way.

So if the LM3695 and LM3697 share the same features and register map they should be one driver
The LM363x series may be able to be a different driver.

I would prefer separated drivers rather then trying to consolidate them.  Otherwise we may have other devices
trying to be shoe horned into this framework.

Dan

> Best regards,
> 								Pavel
> 
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 44097a3..7b0929e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -756,6 +756,13 @@ config LEDS_NIC78BX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-nic78bx.
>  
> +config BACKLIGHT_TI_LMU
> +       tristate "Backlight driver for TI LMU"
> +       depends on BACKLIGHT_CLASS_DEVICE && MFD_TI_LMU
> +       help
> +         Say Y to enable the backlight driver for TI LMU devices.
> +         This supports LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> +
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
>  
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 420b5d2..8edb9bf 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -78,6 +78,9 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>  obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
>  obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
> +ti-lmu-backlight-objs                   := ti-lmu-backlight-core.o \
> +                                           ti-lmu-backlight-data.o
> +obj-$(CONFIG_BACKLIGHT_TI_LMU)          += ti-lmu-backlight.o
>  
>  # LED SPI Drivers
>  obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
> diff --git a/drivers/leds/ti-lmu-backlight-core.c b/drivers/leds/ti-lmu-backlight-core.c
> new file mode 100644
> index 0000000..c9af061
> --- /dev/null
> +++ b/drivers/leds/ti-lmu-backlight-core.c
> @@ -0,0 +1,556 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2015 Texas Instruments
> + * Copyright 2018 Sebastian Reichel
> + *
> + * TI LMU Backlight driver, based on previous work from
> + * Milo Kim <milo.kim@ti.com>
> + */
> +
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
> +enum ti_lmu_bl_ramp_mode {
> +	BL_RAMP_UP,
> +	BL_RAMP_DOWN,
> +};
> +
> +#define NUM_DUAL_CHANNEL			2
> +#define LMU_BACKLIGHT_DUAL_CHANNEL_USED		(BIT(0) | BIT(1))
> +#define LMU_BACKLIGHT_11BIT_LSB_MASK		(BIT(0) | BIT(1) | BIT(2))
> +#define LMU_BACKLIGHT_11BIT_MSB_SHIFT		3
> +
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
> +static int ti_lmu_bl_set_brightness(struct ti_lmu_bank *lmu_bank,
> +				    int brightness)
> +{
> +	bool enable = brightness > 0;
> +	int ret;
> +
> +	ret = ti_lmu_bl_enable(lmu_bank, enable);
> +	if (ret)
> +		return ret;
> +
> +	lmu_bank->current_brightness = brightness;
> +
> +	return ti_lmu_bl_update_brightness_register(lmu_bank, brightness);
> +}
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
> +	val = 0;
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
> +static int ti_lmu_bl_register_led(struct ti_lmu_bank *lmu_bank)
> +{
> +	int err;
> +
> +	printk("lmu: register_led\n");
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
> +	printk("lmu: register_led\n");
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
> +	return ti_lmu_bl_register_led(lmu_bank);
> +}
> +
> +static int setup_of_node(struct platform_device *pdev)
> +{
> +	struct device_node *parent_node = pdev->dev.parent->of_node;
> +	char *name;
> +
> +	if (!parent_node)
> +		return 0;
> +
> +	name = kasprintf(GFP_KERNEL, "bank%d", pdev->id);
> +//		name = kasprintf(GFP_KERNEL, "lcd_backlight", pdev->id);
> +	if (!name) {
> +		printk("No memory?!\n");
> +		return -ENOMEM;
> +	}
> +
> +	printk("Searching for device in parent: %pOFn", parent_node);
> +
> +	pdev->dev.of_node = of_get_child_by_name(parent_node, name);
> +	kfree(name);
> +
> +	if (!pdev->dev.of_node) {
> +		printk("No such child: %s\n", name);		
> +		return -ENODEV;
> +	}
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
> +	printk("lmu: set_brightness %d\n", lmu_bank->default_brightness);		
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
> +	printk("lmu: bl probe\n");
> +	err = setup_of_node(pdev);
> +	if (err)
> +		return err;
> +
> +	printk("lmu: bank\n");	
> +	lmu_bank = devm_kzalloc(&pdev->dev, sizeof(*lmu_bank), GFP_KERNEL);
> +	if (!lmu_bank)
> +		return -ENOMEM;
> +	lmu_bank->dev = &pdev->dev;
> +	dev_set_drvdata(&pdev->dev, lmu_bank);
> +
> +	err = device_property_read_string(&pdev->dev, "label",
> +					  &lmu_bank->label);
> +	if (err)
> +		return err;
> +
> +	if (!strcmp(lmu_bank->label, "keyboard")) {
> +		lmu_bank->label = "kbd_backlight";
> +	} else
> +		lmu_bank->default_brightness = 255;
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
> +	printk("lmu: brightness\n");		
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
> diff --git a/drivers/leds/ti-lmu-backlight-data.c b/drivers/leds/ti-lmu-backlight-data.c
> new file mode 100644
> index 0000000..583136c
> --- /dev/null
> +++ b/drivers/leds/ti-lmu-backlight-data.c
> @@ -0,0 +1,304 @@
> +/*
> + * TI LMU (Lighting Management Unit) Backlight Device Data
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
> diff --git a/drivers/leds/ti-lmu-backlight-data.h b/drivers/leds/ti-lmu-backlight-data.h
> new file mode 100644
> index 0000000..c64e8e6
> --- /dev/null
> +++ b/drivers/leds/ti-lmu-backlight-data.h
> @@ -0,0 +1,95 @@
> +/*
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
> 


-- 
------------------
Dan Murphy
