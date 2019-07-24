From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Backlight in motorola Droid 4
Date: Wed, 24 Jul 2019 10:10:12 -0500
Message-ID: <fdcab21e-dd5e-1f7e-6927-16597a94c1a2@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd> <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724124530.GA30211@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 7/24/19 7:45 AM, Pavel Machek wrote:
> Hi!
>
>>> So now the backlight LED can be controlled. Good. (And thanks!)
>>>
>>> But I seem to remember that backlight had range from "is it really on?"
>>> to "very bright"; now it seems to have range from "bright" to "very
>>> bright".
>>>
>>> Any ideas what goes on there?
>> In the LM3552 driver we are changing the Full scale brightness registers for
>> the
>>
>> specific control bank.
>>
>> #define LM3532_REG_CTRL_A_BRT    0x17
>> #define LM3532_REG_CTRL_B_BRT    0x19
>> #define LM3532_REG_CTRL_C_BRT    0x1b
>>
>> In the ti-lmu code the ALS zones were being modified not the control bank
>> brightness.
>>
>> #define LM3532_REG_BRT_A            0x70    /* zone 0 */
>> #define LM3532_REG_BRT_B            0x76    /* zone 1 */
>> #define LM3532_REG_BRT_C            0x7C    /* zone 2 */
>>
>> Not sure how the ALS is attached in the system if it reports to the host and
>> the host manages
>>
>> the back light or if the the ALS is connected directly to the LM3532.
>>
>> Maybe the ALS zone targets need to be updated to allow a fuller range.  The
>> LM3532 may be stuck
>>
>> in a certain zone.
>>
>> Probably should set up the ALS properties in the device tree.
> I came with this so far.

OK I guess you will remove the commentary in the driver once you submit

the patch


> 									Pavel
>
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> index 62af1b8..752952e 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -422,6 +422,7 @@
>   			led-sources = <2>;
>   			ti,led-mode = <0>;
>   			label = ":backlight";
> +			default-state = "on";
>   			linux,default-trigger = "backlight";
>   		};
>   
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index e5e1b3a..2baeacd 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -288,7 +288,7 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
>   				   count, ppos);
>   }
>   
> -#undef REGMAP_ALLOW_WRITE_DEBUGFS
> +#define REGMAP_ALLOW_WRITE_DEBUGFS
>   #ifdef REGMAP_ALLOW_WRITE_DEBUGFS
>   /*
>    * This can be dangerous especially when we have clients such as
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index bdc98dd..db6e382 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -172,6 +172,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>   				led.default_state = LEDS_GPIO_DEFSTATE_ON;
>   			else
>   				led.default_state = LEDS_GPIO_DEFSTATE_OFF;
> +			/* FIXME: else ... warn about bad device tree */
>   		}
>   
>   		if (fwnode_property_present(child, "retain-state-suspended"))
> diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
> index 180895b..365a22a5 100644
> --- a/drivers/leds/leds-lm3532.c
> +++ b/drivers/leds/leds-lm3532.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // TI LM3532 LED driver
>   // Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// http://www.ti.com/lit/ds/symlink/lm3532.pdf

I don't put symlinks in drivers as they are subject to change.

This link is in the patch history anyway


>   
>   #include <linux/i2c.h>
>   #include <linux/leds.h>
> @@ -23,7 +24,7 @@
>   #define LM3532_REG_PWM_B_CFG	0x14
>   #define LM3532_REG_PWM_C_CFG	0x15
>   #define LM3532_REG_ZONE_CFG_A	0x16
> -#define LM3532_REG_CTRL_A_BRT	0x17
> +#define LM3532_REG_CTRL_A_BRT	0x17 /* Called "Control A Full-Scale Current " in documentation */
>   #define LM3532_REG_ZONE_CFG_B	0x18
>   #define LM3532_REG_CTRL_B_BRT	0x19
>   #define LM3532_REG_ZONE_CFG_C	0x1a
> @@ -38,6 +39,7 @@
>   #define LM3532_REG_ZN_2_LO	0x65
>   #define LM3532_REG_ZN_3_HI	0x66
>   #define LM3532_REG_ZN_3_LO	0x67
> +#define LM3532_REG_ZN_TARGET	0x70
>   #define LM3532_REG_MAX		0x7e
>   
>   /* Contorl Enable */
> @@ -302,7 +304,7 @@ static int lm3532_led_disable(struct lm3532_led *led_data)
>   	int ret;
>   
>   	ret = regmap_update_bits(led_data->priv->regmap, LM3532_REG_ENABLE,
> -					 ctrl_en_val, ~ctrl_en_val);
> +					 ctrl_en_val, 0);
>   	if (ret) {
>   		dev_err(led_data->priv->dev, "Failed to set ctrl:%d\n", ret);
>   		return ret;
> @@ -321,6 +323,7 @@ static int lm3532_brightness_set(struct led_classdev *led_cdev,
>   
>   	mutex_lock(&led->priv->lock);
>   
> +	/* Actually, I don't think this is acceptable */
>   	if (led->mode == LM3532_BL_MODE_ALS) {
>   		if (brt_val > LED_OFF)
>   			ret = lm3532_led_enable(led);
> @@ -339,11 +342,23 @@ static int lm3532_brightness_set(struct led_classdev *led_cdev,
>   	if (ret)
>   		goto unlock;
>   
> +	/* This driver is sick. It manipulates maximum current register (5-bit),
> +	   but fails to control 8-bit brightness register... which is exponential
> +	   so it allows >8 bit of control */
> +

>   	brightness_reg = LM3532_REG_CTRL_A_BRT + led->control_bank * 2;
The appropriate target register can be programmed in the control bank 
config register bits[4:2]

Default is 0x1xx which is 0x74.

The target register should be set in the config as well and then stored 
as a register offset.

Or just set the CTRL_A_BRT to 0x74 and take the default config

> -	brt_val = brt_val / LM3532_BRT_VAL_ADJUST;
> +	brt_val = 255 / LM3532_BRT_VAL_ADJUST;
>   

Don't need this if we have 8 bit control.  This was only needed for the 
max current control.


>   	ret = regmap_write(led->priv->regmap, brightness_reg, brt_val);
>   
> +	brightness_reg = 0x70 + led->control_bank * 5;
> +
> +	ret = regmap_write(led->priv->regmap, brightness_reg, brt_val);
> +	ret = regmap_write(led->priv->regmap, brightness_reg+1, brt_val);
> +	ret = regmap_write(led->priv->regmap, brightness_reg+2, brt_val);
> +	ret = regmap_write(led->priv->regmap, brightness_reg+3, brt_val);
> +	ret = regmap_write(led->priv->regmap, brightness_reg+4, brt_val);
> +

You don't need to write all the target registers.

Dan

<snip>
