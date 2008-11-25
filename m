From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc6-omap 2/2] remove gpio_expander_omap
Date: Tue, 25 Nov 2008 15:38:04 -0800
Message-ID: <20081125233804.GE11997@atomide.com>
References: <200811241029.34245.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54718 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYKYXiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 18:38:04 -0500
Content-Disposition: inline
In-Reply-To: <200811241029.34245.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081124 10:29]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Now that H3 is converted to use GPIO calls, get rid of the
> legacy gpio_expander_omap code ... it has no more users.
> 
> One more needless divergence from mainline gone!

Woohoo! Pushing today.

Tony


> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/mach-omap1/Kconfig                    |    1 
>  arch/arm/plat-omap/include/mach/gpioexpander.h |   35 -----------
>  drivers/i2c/chips/Kconfig                      |    7 --
>  drivers/i2c/chips/Makefile                     |    1 
>  drivers/i2c/chips/gpio_expander_omap.c         |   71 -----------------------
>  5 files changed, 115 deletions(-)
> 
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -38,7 +38,6 @@ config MACH_OMAP_H2
>  config MACH_OMAP_H3
>  	bool "TI H3 Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> -#	select GPIOEXPANDER_OMAP
>      	help
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
> --- a/arch/arm/plat-omap/include/mach/gpioexpander.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - * arch/arm/plat-omap/include/mach/gpioexpander.h
> - *
> - *
> - * Copyright (C) 2004 Texas Instruments, Inc.
> - *
> - * This package is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> - * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> - * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> - */
> -
> -#ifndef __ASM_ARCH_OMAP_GPIOEXPANDER_H
> -#define __ASM_ARCH_OMAP_GPIOEXPANDER_H
> -
> -/* Function Prototypes for GPIO Expander functions */
> -
> -#ifdef CONFIG_GPIOEXPANDER_OMAP
> -int read_gpio_expa(u8 *, int);
> -int write_gpio_expa(u8 , int);
> -#else
> -static inline int read_gpio_expa(u8 *val, int addr)
> -{
> -	return 0;
> -}
> -static inline int write_gpio_expa(u8 val, int addr)
> -{
> -	return 0;
> -}
> -#endif
> -
> -#endif /* __ASM_ARCH_OMAP_GPIOEXPANDER_H */
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -134,13 +134,6 @@ config SENSORS_TLV320AIC23
>  	  If you say yes here you get support for the I2C control
>  	  interface for Texas Instruments TLV320AIC23 audio codec.
>  
> -config GPIOEXPANDER_OMAP
> -	bool "GPIO Expander PCF8574PWR for OMAP"
> -	depends on I2C && MACH_OMAP_H3
> -	help
> -	  If you say yes here you get support for I/O expander calls
> -	  to configure IrDA, Camera and audio devices.
> -
>  config TWL4030_MADC
>  	tristate "TWL4030 MADC Driver"
>  	depends on TWL4030_CORE
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -20,7 +20,6 @@ obj-$(CONFIG_PCF8575)		+= pcf8575.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_TPS65010)		+= tps65010.o
>  obj-$(CONFIG_SENSORS_TLV320AIC23) += tlv320aic23.o
> -obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
>  obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
> --- a/drivers/i2c/chips/gpio_expander_omap.c
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -/*
> - * drivers/i2c/chips/gpio_expander_omap.c
> - *
> - * Copyright (C) 2004 Texas Instruments Inc
> - * Author:
> - *
> - * gpio expander is used to configure IrDA, camera and audio devices on omap 1710 processor.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - */
> -
> -#include <linux/types.h>
> -#include <linux/i2c.h>
> -#include <linux/errno.h>
> -
> -int read_gpio_expa(u8 * val, int addr);
> -int write_gpio_expa(u8 val, int addr);
> -
> -int write_gpio_expa(u8 val, int addr)
> -{
> -	struct i2c_adapter *adap;
> -	int err;
> -	struct i2c_msg msg[1];
> -	unsigned char data[1];
> -
> -	adap = i2c_get_adapter(1);
> -	if (!adap)
> -		return -ENODEV;
> -	msg->addr = addr;	/* I2C address of GPIO EXPA */
> -	msg->flags = 0;
> -	msg->len = 1;
> -	msg->buf = data;
> -	data[0] = val;
> -	err = i2c_transfer(adap, msg, 1);
> -	if (err >= 0)
> -		return 0;
> -	return err;
> -}
> -
> -/* Read from I/O EXPANDER on the H3 board.
> - * The IO expanders need an independent I2C client driver.
> - */
> -
> -int read_gpio_expa(u8 * val, int addr)
> -{
> -	struct i2c_adapter *adap;
> -	int err;
> -	struct i2c_msg msg[1];
> -	unsigned char data[1];
> -
> -	adap = i2c_get_adapter(1);
> -	if (!adap)
> -		return -ENODEV;
> -	msg->addr = addr;	/* I2C address of GPIO EXPA */
> -	msg->flags = I2C_M_RD;
> -	msg->len = 2;
> -	msg->buf = data;
> -	err = i2c_transfer(adap, msg, 1);
> -	*val = data[0];
> -
> -	if (err >= 0)
> -		return 0;
> -	return err;
> -}
> -
> -EXPORT_SYMBOL(read_gpio_expa);
> -EXPORT_SYMBOL(write_gpio_expa);
> -
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
