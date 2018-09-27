From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Date: Thu, 27 Sep 2018 07:04:53 -0500
Message-ID: <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com> <20180926223612.GA32286@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926223612.GA32286@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

Thanks for the review

On 09/26/2018 05:36 PM, Pavel Machek wrote:
> Hi!
> 
>> Introduce the LED LM3633 driver.  This LED
>> driver has 9 total LED outputs with runtime
>> internal ramp configurations.
>>
>> Data sheet:
>> http://www.ti.com/lit/ds/symlink/lm3633.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> I did some editing... and this code looks very similar to 3697 code.
> 

Ok I will review each one.  Keep in mind these drivers are by no means complete
I anticipate this driver to look different then the 3697 code.

But I do expect a certain level of duplication of code as we see across all drivers.

>> diff --git a/drivers/leds/leds-lm3633.c b/drivers/leds/leds-lm3633.c
>> new file mode 100644
>> index 000000000000..3d29b0ed67d3
>> --- /dev/null
>> +++ b/drivers/leds/leds-lm3633.c
>> @@ -0,0 +1,430 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// TI LM3633 LED chip family driver
>> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <uapi/linux/uleds.h>
>> +
>> +#include "ti-lmu-led-common.h"
> 
> You might want to move includes to ti-lmu-led-common.h, so these are
> not repeated?
> 

Sounds good

>> +/**
>> + * struct lm3633 -
>> + * @enable_gpio - Hardware enable gpio
>> + * @regulator - LED supply regulator pointer
>> + * @client - Pointer to the I2C client
>> + * @regmap - Devices register map
>> + * @dev - Pointer to the devices device struct
>> + * @lock - Lock for reading/writing the device
>> + * @leds - Array of LED strings
>> + */
>> +struct lm3633 {
>> +	struct gpio_desc *enable_gpio;
>> +	struct regulator *regulator;
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct device *dev;
>> +	struct mutex lock;
>> +	struct lm3633_led leds[];
>> +};
> 
> Exactly same structure is used for 3697. Worth sharing?

But it is not the same structure for the 3632.  I anticipate this to change
as I debug the code and add pwm support.

> 
>> +static const struct regmap_config lm3633_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = LM3633_CTRL_ENABLE,
>> +	.reg_defaults = lm3633_reg_defs,
>> +	.num_reg_defaults = ARRAY_SIZE(lm3633_reg_defs),
>> +	.cache_type = REGCACHE_FLAT,
>> +};
> 
> Same regmap config. Maybe difficult to share.

Agreed.

> 
>> +static int lm3633_brightness_set(struct led_classdev *led_cdev,
>> +				enum led_brightness brt_val)
>> +{
>> +	struct lm3633_led *led = container_of(led_cdev, struct lm3633_led,
>> +					      led_dev);
>> +	int ctrl_en_val;
>> +	int ret;
>> +
>> +	mutex_lock(&led->priv->lock);
>> +
>> +	if (led->control_bank == LM3633_CONTROL_A) {
>> +		led->lmu_data.msb_brightness_reg = LM3633_CTRL_A_BRT_MSB;
>> +		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_A_BRT_LSB;
>> +		ctrl_en_val = LM3633_CTRL_A_EN;
>> +	} else {
>> +		led->lmu_data.msb_brightness_reg = LM3633_CTRL_B_BRT_MSB;
>> +		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_B_BRT_LSB;
>> +		ctrl_en_val = LM3633_CTRL_B_EN;
>> +	}
>> +
>> +	if (brt_val == LED_OFF)
>> +		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
>> +					 ctrl_en_val, ~ctrl_en_val);
>> +	else
>> +		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
>> +					 ctrl_en_val, ctrl_en_val);
>> +
>> +	ret = ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
>> +	if (ret)
>> +		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
>> +
>> +	mutex_unlock(&led->priv->lock);
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function with different constants.

This will change to support all the control banks.

> 
>> +static int lm3633_set_control_bank(struct lm3633 *priv)
>> +{
>> +	u8 control_bank_config = 0;
>> +	struct lm3633_led *led;
>> +	int ret, i;
>> +
>> +	led = &priv->leds[0];
>> +	if (led->control_bank == LM3633_CONTROL_A)
>> +		led = &priv->leds[1];
>> +
>> +	for (i = 0; i < LM3633_MAX_HVLED_STRINGS; i++)
>> +		if (led->hvled_strings[i] == LM3633_HVLED_ASSIGNMENT)
>> +			control_bank_config |= 1 << i;
>> +
>> +	ret = regmap_write(priv->regmap, LM3633_HVLED_OUTPUT_CONFIG,
>> +			   control_bank_config);
>> +	if (ret)
>> +		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
>> +
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function.

This will change to support all the control banks.

> 
>> +static int lm3633_init(struct lm3633 *priv)
>> +{
>> +	struct lm3633_led *led;
>> +	int i, ret;
>> +
>> +	if (priv->enable_gpio) {
>> +		gpiod_direction_output(priv->enable_gpio, 1);
>> +	} else {
>> +		ret = regmap_write(priv->regmap, LM3633_RESET, LM3633_SW_RESET);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "Cannot reset the device\n");
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, LM3633_CTRL_ENABLE, 0x0);
>> +	if (ret) {
>> +		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = lm3633_set_control_bank(priv);
>> +	if (ret)
>> +		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
>> +
>> +	for (i = 0; i < LM3633_MAX_CONTROL_BANKS; i++) {
>> +		led = &priv->leds[i];
>> +		ti_lmu_common_set_ramp(&led->lmu_data);
>> +		if (ret)
>> +			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
>> +	}
>> +out:
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function.


This will change to support all the control banks.

> 
>> +static int lm3633_probe_dt(struct lm3633 *priv)
>> +{
>> +	struct fwnode_handle *child = NULL;
>> +	struct lm3633_led *led;
>> +	const char *name;
>> +	int control_bank;
>> +	size_t i = 0;
>> +	int ret;
>> +
>> +	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
>> +						   "enable", GPIOD_OUT_LOW);
>> +	if (IS_ERR(priv->enable_gpio)) {
>> +		ret = PTR_ERR(priv->enable_gpio);
>> +		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
>> +	if (IS_ERR(priv->regulator))
>> +		priv->regulator = NULL;
>> +
>> +	device_for_each_child_node(priv->dev, child) {
>> +		ret = fwnode_property_read_u32(child, "reg", &control_bank);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "reg property missing\n");
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		if (control_bank > LM3633_CONTROL_B) {
>> +			dev_err(&priv->client->dev, "reg property is invalid\n");
>> +			ret = -EINVAL;
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		led = &priv->leds[i];
>> +
>> +		led->control_bank = control_bank;
>> +		led->lmu_data.bank_id = control_bank;
>> +		led->lmu_data.enable_reg = LM3633_CTRL_ENABLE;
>> +		led->lmu_data.regmap = priv->regmap;
>> +		if (control_bank == LM3633_CONTROL_A)
>> +			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_A_RAMP;
>> +		else
>> +			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_B_RAMP;
>> +
>> +		if (control_bank <= LM3633_CONTROL_B)
>> +			ret = fwnode_property_read_u32_array(child, "led-sources",
>> +						    led->hvled_strings,
>> +						    LM3633_MAX_HVLED_STRINGS);
>> +		else
>> +			ret = fwnode_property_read_u32_array(child, "led-sources",
>> +						    led->lvled_strings,
>> +						    LM3633_MAX_LVLED_STRINGS);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "led-sources property missing\n");
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		ret = ti_lmu_common_get_ramp_params(&priv->client->dev, child, &led->lmu_data);
>> +		if (ret)
>> +			dev_warn(&priv->client->dev, "runtime-ramp properties missing\n");
>> +
>> +		fwnode_property_read_string(child, "linux,default-trigger",
>> +					    &led->led_dev.default_trigger);
>> +
>> +		ret = fwnode_property_read_string(child, "label", &name);
>> +		if (ret)
>> +			snprintf(led->label, sizeof(led->label),
>> +				"%s::", priv->client->name);
>> +		else
>> +			snprintf(led->label, sizeof(led->label),
>> +				 "%s:%s", priv->client->name, name);
>> +
>> +		led->priv = priv;
>> +		led->led_dev.name = led->label;
>> +		led->led_dev.brightness_set_blocking = lm3633_brightness_set;
>> +
>> +		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "led register err: %d\n",
>> +				ret);
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		i++;
>> +	}
>> +
>> +child_out:
>> +	return ret;
>> +}
> 
> Very similar, but not quite same.

I know this function will definitely change to support the LVLED control bank setting.
The main difference here is that the HVLED has a simple control bank configuration and the
LVLED is highly configurable with multiple permutations.

As well as maybe the PWM support

> 
>> +static int lm3633_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct lm3633 *led;
>> +	int count;
>> +	int ret;
>> +
>> +	count = device_get_child_node_count(&client->dev);
>> +	if (!count) {
>> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
>> +		return -ENODEV;
>> +	}
>> +
>> +	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
>> +			   GFP_KERNEL);
>> +	if (!led)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&led->lock);
>> +	i2c_set_clientdata(client, led);
>> +
>> +	led->client = client;
>> +	led->dev = &client->dev;
>> +	led->regmap = devm_regmap_init_i2c(client, &lm3633_regmap_config);
>> +	if (IS_ERR(led->regmap)) {
>> +		ret = PTR_ERR(led->regmap);
>> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = lm3633_probe_dt(led);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return lm3633_init(led);
>> +}
> 
> Duplicate.

I do expect the probes to be the same as in most cases.

> 
>> +static int lm3633_remove(struct i2c_client *client)
>> +{
>> +	struct lm3633 *led = i2c_get_clientdata(client);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(led->regmap, LM3633_CTRL_ENABLE,
>> +				 LM3633_CTRL_A_B_EN, 0);
>> +	if (ret) {
>> +		dev_err(&led->client->dev, "Failed to disable the device\n");
>> +		return ret;
>> +	}
>> +
>> +	if (led->enable_gpio)
>> +		gpiod_direction_output(led->enable_gpio, 0);
>> +
>> +	if (led->regulator) {
>> +		ret = regulator_disable(led->regulator);
>> +		if (ret)
>> +			dev_err(&led->client->dev,
>> +				"Failed to disable regulator\n");
>> +	}
>> +
>> +	mutex_destroy(&led->lock);
>> +
>> +	return 0;
>> +}
> 
> Duplicate.
> 
> Can we get some more sharing? One way would be to have struct with
> all the constants (instead of #defines) use that...?

I will look at the adding common constants to but they should be common across
more then just 2 devices.  As you can see the LM3632 code is quite different
when you add in the flash/torch support.

I am trying to keep the common as light weight as possible and not add code that
cannot be used across multiple devices.

Dan

> 
> Thanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
