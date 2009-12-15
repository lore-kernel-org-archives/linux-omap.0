From: =?ISO-8859-1?Q?Fr=E9d=E9ric_BEGOU?= <fbegou@sios.fr>
Subject: [RFC] twl4030 PWM backlight driver
Date: Tue, 15 Dec 2009 15:23:18 +0100
Message-ID: <4B279BD6.1010004@sios.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2e.orange.fr ([80.12.242.111]:1607 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266AbZLOOXG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 09:23:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I am developing our own board file for my company's omap3530 basedboard.
The board has an LCD panel and the backlight is PWM driven via the 
twl4030's PWMB port.
We are already using DSS2 on our board and things are going neatly.

To clean up things, and planning to make the backlight level available 
for the userland, I have already developped some piece of code, based 
heavily on the drivers/video/backlight/omap1_bl.
I've called this one twl4030_bl, very incomplete since it uses only PWMB 
of the twl4030.

Is it okay to have it done this way, or should I have based my work on 
drivers/video/backlight/pwm_bl ?

Another question is whether the resulting driver will be usable on DSS2, 
and how ? Every board which is now using DSS2 uses its own "set_level" 
and "get_level" functions in the board file, and I'm wondering if this 
shouldn't be done in a cleaner way, in an external driver like the one 
I've done ?

Thanks for your comments,

Fred


/*
  * Backlight driver for twl4030 companion ship for OMAP2 based boards.
  *
  * Copyright (c) 2009 Frederic Begou <fbegou@sios.fr>
  * based on OMAP1 backlight driver from
  * Andrzej Zaborowski <balrog@zabor.org>
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This package is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this package; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
  * 02110-1301 USA
  */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/fb.h>
#include <linux/backlight.h>
#include <linux/i2c/twl4030.h>

#include <mach/hardware.h>
#include <plat/board.h>
#include <plat/mux.h>

#define TWL4030_MAX_INTENSITY	100

struct twl4030_backlight {
	int powermode;
	int current_intensity;

	struct device *dev;
	struct omap_backlight_config *pdata;
};

static void inline twl4030bl_send_intensity(int intensity)
{
	u8 c;
	c = (125 * (100 - intensity)) / 100 + 2;
	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, intensity,
					TWL_PWMB_PWMBOFF);
}

static void twl4030_blank(struct twl4030_backlight *bl, int mode)
{
	if (bl->pdata->set_power)
		bl->pdata->set_power(bl->dev, mode);

	switch (mode) {
	case FB_BLANK_NORMAL:
	case FB_BLANK_VSYNC_SUSPEND:
	case FB_BLANK_HSYNC_SUSPEND:
	case FB_BLANK_POWERDOWN:
		twl4030bl_send_intensity(0);
		break;

	case FB_BLANK_UNBLANK:
		twl4030bl_send_intensity(bl->current_intensity);
		break;
	}
}

#ifdef CONFIG_PM
static int twl4030bl_suspend(struct platform_device *pdev, pm_message_t 
state)
{
	struct backlight_device *dev = platform_get_drvdata(pdev);
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);

	twl4030bl_blank(bl, FB_BLANK_POWERDOWN);
	return 0;
}

static int twl4030bl_resume(struct platform_device *pdev)
{
	struct backlight_device *dev = platform_get_drvdata(pdev);
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);

	twl4030bl_blank(bl, bl->powermode);
	return 0;
}
#else
#define twl4030bl_suspend	NULL
#define twl4030bl_resume	NULL
#endif

static int twl4030bl_set_power(struct backlight_device *dev, int state)
{
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);

	twl4030bl_blank(bl, state);
	bl->powermode = state;

	return 0;
}

static int twl4030bl_update_status(struct backlight_device *dev)
{
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);

	if (bl->current_intensity != dev->props.brightness) {
		if (bl->powermode == FB_BLANK_UNBLANK)
			twl4030bl_send_intensity(dev->props.brightness);
		bl->current_intensity = dev->props.brightness;
	}

	if (dev->props.fb_blank != bl->powermode)
		twl4030bl_set_power(dev, dev->props.fb_blank);

	return 0;
}

static int twl4030bl_get_intensity(struct backlight_device *dev)
{
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
	return bl->current_intensity;
}

static struct backlight_ops twl4030bl_ops = {
	.get_brightness = twl4030bl_get_intensity,
	.update_status  = twl4030bl_update_status,
};

static int twl4030bl_probe(struct platform_device *pdev)
{
	struct backlight_device *dev;
	struct omap_backlight *bl;
	struct omap_backlight_config *pdata = pdev->dev.platform_data;

	if (!pdata)
		return -ENXIO;

	twl4030bl_ops.check_fb = pdata->check_fb;

	bl = kzalloc(sizeof(struct omap_backlight), GFP_KERNEL);
	if (unlikely(!bl))
		return -ENOMEM;

	dev = backlight_device_register("twl4030-bl", &pdev->dev,
					bl, &twl4030bl_ops);
	if (IS_ERR(dev)) {
		kfree(bl);
		return PTR_ERR(dev);
	}

	bl->powermode = FB_BLANK_POWERDOWN;
	bl->current_intensity = 0;

	bl->pdata = pdata;
	bl->dev = &pdev->dev;

	platform_set_drvdata(pdev, dev);

	dev->props.fb_blank = FB_BLANK_UNBLANK;
	dev->props.max_brightness = TWL4030BL_MAX_INTENSITY;
	dev->props.brightness = pdata->default_intensity;
	twl4030bl_update_status(dev);

	printk(KERN_INFO "TWL4030 PWM LCD backlight initialised\n");

	return 0;
}

static int twl4030bl_remove(struct platform_device *pdev)
{
	struct backlight_device *dev = platform_get_drvdata(pdev);
	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);

	backlight_device_unregister(dev);
	kfree(bl);

	return 0;
}

static struct platform_driver twl4030bl_driver = {
	.probe		= twl4030bl_probe,
	.remove		= twl4030bl_remove,
	.suspend	= twl4030bl_suspend,
	.resume		= twl4030bl_resume,
	.driver		= {
		.name	= "twl4030-bl",
	},
};

static int __init twl4030bl_init(void)
{
	return platform_driver_register(&twl4030bl_driver);
}

static void __exit twl4030bl_exit(void)
{
	platform_driver_unregister(&twl4030bl_driver);
}

module_init(twl4030bl_init);
module_exit(twl4030bl_exit);

MODULE_AUTHOR("Frederic Begou <fbegou@sios.fr>");
MODULE_DESCRIPTION("TWL4030 PWM LCD Backlight driver");
MODULE_LICENSE("GPL");


