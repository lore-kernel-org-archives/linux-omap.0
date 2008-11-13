From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2-omap] H4 stops using gpio_expander_omap
Date: Thu, 13 Nov 2008 13:10:42 -0800
Message-ID: <20081113211041.GD3106@atomide.com>
References: <200810291443.52865.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63613 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbYKMVKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:10:45 -0500
Content-Disposition: inline
In-Reply-To: <200810291443.52865.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081029 14:48]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> This patch starts updating the H4 board support to use gpiolib.  It
> switches from the gpio_expander_omap.c code to the mainline pcf8474
> driver for its three I2C GPIO expanders.
> 
> It also adds two minor features:  LCD stays powered off when it's not
> used; and the backlight control is exposed through the LED framework
> (using the new "backlight" trigger).
> 
> Plus it fixes a bug that would have affected anyone trying to use the
> camera sensor:  it wouldn't power up, since 0x80 != 0x08.  (Though
> there's no mainline V4L2 driver for that sensor yet...)

Pushing today.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Once H3 has a similar patch, one drivers/i2c/chips driver can go...
> 
>  arch/arm/mach-omap2/Kconfig                |    1 
>  arch/arm/mach-omap2/board-h4.c             |  189 +++++++++++++++++----------
>  arch/arm/plat-omap/include/mach/board-h4.h |   42 ++++++
>  drivers/i2c/chips/Kconfig                  |    2 
>  drivers/net/irda/Kconfig                   |    2 
>  5 files changed, 165 insertions(+), 71 deletions(-)
> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -59,7 +59,6 @@ config MACH_OMAP_H4
>  	bool "OMAP 2420 H4 board"
>  	depends on ARCH_OMAP2 && ARCH_OMAP2420
>  	select OMAP_DEBUG_DEVICES
> -	select GPIOEXPANDER_OMAP
>  
>  config MACH_OMAP_H4_TUSB
>  	bool "TUSB 6010 EVM board"
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -22,8 +22,13 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/leds.h>
> +
>  #include <linux/i2c/at24.h>
>  #include <linux/i2c/menelaus.h>
> +#include <linux/i2c/pcf857x.h>
> +
>  #include <linux/spi/spi.h>
>  #include <linux/spi/tsc210x.h>
>  
> @@ -36,8 +41,6 @@
>  #include <asm/mach/flash.h>
>  
>  #include <mach/control.h>
> -#include <mach/gpio.h>
> -#include <mach/gpioexpander.h>
>  #include <mach/mux.h>
>  #include <mach/usb.h>
>  #include <mach/irda.h>
> @@ -142,32 +145,16 @@ static struct platform_device h4_flash_d
>  	.resource	= &h4_flash_resource,
>  };
>  
> -/* Select between the IrDA and aGPS module
> - */
>  #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
> +
> +/* Select between the IrDA and aGPS module */
>  static int h4_select_irda(struct device *dev, int state)
>  {
> -	unsigned char expa;
> -	int err = 0;
> -
> -	if ((err = read_gpio_expa(&expa, 0x21))) {
> -		printk(KERN_ERR "Error reading from I/O expander\n");
> -		return err;
> -	}
> +	/* U192.P0 = high for IRDA; else AGPS */
> +	gpio_set_value_cansleep(H4_GPIO_IRDA_AGPSn, state & IR_SEL);
>  
> -	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
> -	if (state & IR_SEL) {	/* IrDa */
> -		if ((err = write_gpio_expa(expa | 0x01, 0x21))) {
> -			printk(KERN_ERR "Error writing to I/O expander\n");
> -			return err;
> -		}
> -	} else {
> -		if ((err = write_gpio_expa(expa & ~0x01, 0x21))) {
> -			printk(KERN_ERR "Error writing to I/O expander\n");
> -			return err;
> -		}
> -	}
> -	return err;
> +	/* NOTE:  UART3 can also hook up to a DB9 or to GSM ... */
> +	return 0;
>  }
>  
>  static void set_trans_mode(struct work_struct *work)
> @@ -175,22 +162,9 @@ static void set_trans_mode(struct work_s
>  	struct omap_irda_config *irda_config =
>  		container_of(work, struct omap_irda_config, gpio_expa.work);
>  	int mode = irda_config->mode;
> -	unsigned char expa;
> -	int err = 0;
> -
> -	if ((err = read_gpio_expa(&expa, 0x20)) != 0) {
> -		printk(KERN_ERR "Error reading from I/O expander\n");
> -	}
> -
> -	expa &= ~0x01;
> -
> -	if (!(mode & IR_SIRMODE)) { /* MIR/FIR */
> -		expa |= 0x01;
> -	}
>  
> -	if ((err = write_gpio_expa(expa, 0x20)) != 0) {
> -		printk(KERN_ERR "Error writing to I/O expander\n");
> -	}
> +	/* U191.P0 = low for SIR; else MIR/FIR */
> +	gpio_set_value_cansleep(H4_GPIO_IRDA_FIRSEL, !(mode & IR_SIRMODE));
>  }
>  
>  static int h4_transceiver_mode(struct device *dev, int mode)
> @@ -568,37 +542,13 @@ const static struct ov9640_reg ov9640_co
>  
>  static int ov9640_sensor_power_set(int power)
>  {
> -	unsigned char expa;
> -	int err;
> -
> -	/* read current state of GPIO EXPA outputs */
> -	if ((err = read_gpio_expa(&expa, 0x20))) {
> -		printk(KERN_ERR "Error reading GPIO EXPA 0x20\n");
> -		return err;
> -	}
> -
> -	expa = power ? expa | 0x80 : expa & ~0x08;
> -
> -	/* Set GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up sensor */
> -	if ((err = write_gpio_expa(expa, 0x20))) {
> -		printk(KERN_ERR "Error writing to GPIO EXPA 0x20\n");
> -		return err;
> -	}
> +	/* power up the sensor? */
> +	gpio_set_value_cansleep(H4_GPIO_CAM_MODULE_EN, power);
>  
> -	if (power) {
> -		/* read current state of GPIO EXPA outputs */
> -		if ((err = read_gpio_expa(&expa, 0x22))) {
> -			printk(KERN_ERR "Error reading GPIO EXPA\n");
> -			return err;
> -		}
> -		/* Clear GPIO EXPA P7 (CAM_RST) */
> -		if ((err = write_gpio_expa(expa & ~0x80, 0x22))) {
> -			printk(KERN_ERR "Error writing to GPIO EXPA\n");
> -			return err;
> -		}
> -	}
> +	/* take it out of reset if it's not powered */
> +	gpio_direction_output(H4_GPIO_CAM_RST, !power);
>  
> -	return err;
> +	return 0;
>  }
>  
>  static struct v4l2_ifparm ifparm = {
> @@ -626,14 +576,117 @@ static struct ov9640_platform_data h4_ov
>  	.default_regs	= ov9640_common,
>  	.ifparm		= ov9640_ifparm,
>  };
> +
>  #endif
>  
> +/* leave LCD powered off unless it will be used */
> +#if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
> +#define LCD_ENABLED		true
> +#else
> +#define LCD_ENABLED		false
> +#endif
> +
> +static struct gpio_led backlight_leds[] = {
> +	{
> +		.name			= "lcd_h4",
> +		.default_trigger	= "backlight",
> +		.gpio			= H4_GPIO_LCD_ENBKL,
> +	},
> +	{ },
> +};
> +
> +static struct gpio_led_platform_data backlight_led_data = {
> +	.num_leds		= 1,
> +	.leds			= backlight_leds,
> +};
> +
> +static struct platform_device h4_backlight_device = {
> +	.name			= "leds-gpio",
> +	.id			= 0,
> +	.dev.platform_data	= &backlight_led_data,
> +};
> +
> +static int
> +u191_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *context)
> +{
> +	/* P0 = IRDA control, FIR/MIR vs SIR */
> +	gpio_request(H4_GPIO_IRDA_FIRSEL, "irda_firsel");
> +	gpio_direction_output(H4_GPIO_IRDA_FIRSEL, false);
> +
> +	/* P3 = camera sensor module PWDN */
> +	gpio_request(H4_GPIO_CAM_MODULE_EN, "camera_en");
> +	gpio_direction_output(H4_GPIO_CAM_MODULE_EN, false);
> +
> +	/* P7 = LCD_ENVDD ... controls power to LCD (including backlight)
> +	 * P5 = LCD_ENBKL ... switches backlight
> +	 */
> +	gpio_request(H4_GPIO_LCD_ENVDD, "lcd_power");
> +	gpio_direction_output(H4_GPIO_LCD_ENVDD, LCD_ENABLED);
> +	if (LCD_ENABLED) {
> +		h4_backlight_device.dev.parent = &client->dev;
> +		platform_device_register(&h4_backlight_device);
> +	}
> +
> +	/* P6 = AUDIO_ENVDD ... switch power to microphone */
> +	gpio_request(H4_GPIO_AUDIO_ENVDD, "audio_power");
> +	gpio_direction_output(H4_GPIO_AUDIO_ENVDD, true);
> +
> +	return 0;
> +}
> +
> +
> +static struct pcf857x_platform_data u191_platform_data = {
> +	.gpio_base	= H4_U191_GPIO_BASE,
> +	.setup		= u191_setup,
> +};
> +
> +static int
> +u192_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *context)
> +{
> +	gpio_request(H4_GPIO_IRDA_AGPSn, "irda/agps");
> +	gpio_direction_output(H4_GPIO_IRDA_AGPSn, false);
> +
> +	return 0;
> +}
> +
> +static struct pcf857x_platform_data u192_platform_data = {
> +	.gpio_base	= H4_U192_GPIO_BASE,
> +	.setup		= u192_setup,
> +};
> +
> +static int
> +u193_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *context)
> +{
> +	/* reset sensor */
> +	gpio_request(H4_GPIO_CAM_RST, "camera_rst");
> +	gpio_direction_output(H4_GPIO_CAM_RST, true);
> +
> +	return 0;
> +}
> +
> +static struct pcf857x_platform_data u193_platform_data = {
> +	.gpio_base	= H4_U193_GPIO_BASE,
> +	.setup		= u193_setup,
> +};
> +
>  static struct at24_platform_data m24c01 = {
>  	.byte_len	= SZ_1K / 8,
>  	.page_size	= 16,
>  };
>  
>  static struct i2c_board_info __initdata h4_i2c_board_info[] = {
> +	{	/* U191 gpios */
> +		I2C_BOARD_INFO("pcf8574", 0x20),
> +		.platform_data	= &u191_platform_data,
> +	},
> +	{	/* U192 gpios */
> +		I2C_BOARD_INFO("pcf8574", 0x21),
> +		.platform_data	= &u192_platform_data,
> +	},
> +	{	/* U193 gpios */
> +		I2C_BOARD_INFO("pcf8574", 0x22),
> +		.platform_data	= &u193_platform_data,
> +	},
>  	{
>  		I2C_BOARD_INFO("rv5c387a", 0x32),
>  		/* no IRQ wired to OMAP; nINTB goes to AGPS */
> --- a/arch/arm/plat-omap/include/mach/board-h4.h
> +++ b/arch/arm/plat-omap/include/mach/board-h4.h
> @@ -34,5 +34,47 @@ extern void h4_mmc_init(void);
>  
>  /* Placeholder for H4 specific defines */
>  #define OMAP24XX_ETHR_GPIO_IRQ		92
> +
> +/* FPGA on debug board has 32 GPIOs:  16 dedicated to leds,
> + * 8 outputs on a header, and 6 inputs from a DIP switch.
> + */
> +#define H4_DEBUG_GPIO_BASE		OMAP_MAX_GPIO_LINES
> +#	define H4_DEBUG_GPIO_SW3_1	(H4_DEBUG_GPIO_BASE + 24)
> +#	define H4_DEBUG_GPIO_SW3_2	(H4_DEBUG_GPIO_BASE + 25)
> +#	define H4_DEBUG_GPIO_SW3_3	(H4_DEBUG_GPIO_BASE + 26)
> +#	define H4_DEBUG_GPIO_SW3_4	(H4_DEBUG_GPIO_BASE + 27)
> +#	define H4_DEBUG_GPIO_SW3_5	(H4_DEBUG_GPIO_BASE + 28)
> +#	define H4_DEBUG_GPIO_SW3_8	(H4_DEBUG_GPIO_BASE + 29)
> +
> +/* H4 baseboard has 3 PCF8574 (8 bit) I2C GPIO expanders */
> +#define H4_U191_GPIO_BASE		(H4_DEBUG_GPIO_BASE + 32)
> +#	define H4_GPIO_IRDA_FIRSEL	(H4_U191_GPIO_BASE + 0)
> +#	define H4_GPIO_MODEM_MOD_EN	(H4_U191_GPIO_BASE + 1)
> +#	define H4_GPIO_WLAN_MOD_EN	(H4_U191_GPIO_BASE + 2)
> +#	define H4_GPIO_CAM_MODULE_EN	(H4_U191_GPIO_BASE + 3)
> +#	define H4_GPIO_HANDSET_EN	(H4_U191_GPIO_BASE + 4)
> +#	define H4_GPIO_LCD_ENBKL	(H4_U191_GPIO_BASE + 5)
> +#	define H4_GPIO_AUDIO_ENVDD	(H4_U191_GPIO_BASE + 6)
> +#	define H4_GPIO_LCD_ENVDD	(H4_U191_GPIO_BASE + 7)
> +
> +#define H4_U192_GPIO_BASE		(H4_U191_GPIO_BASE + 8)
> +#	define H4_GPIO_IRDA_AGPSn	(H4_U192_GPIO_BASE + 0)
> +#	define H4_GPIO_AGPS_PWREN	(H4_U192_GPIO_BASE + 1)
> +#	define H4_GPIO_AGPS_RSTn	(H4_U192_GPIO_BASE + 2)
> +#	define H4_GPIO_AGPS_SLEEP	(H4_U192_GPIO_BASE + 3)
> +#	define H4_GPIO_AGPS_PA_XMT	(H4_U192_GPIO_BASE + 4)
> +#	define H4_GPIO_MODEM_SPR2	(H4_U192_GPIO_BASE + 5)
> +#	define H4_GPIO_MODEM_SPR1	(H4_U192_GPIO_BASE + 6)
> +#	define H4_GPIO_BT_ACLK_ENn	(H4_U192_GPIO_BASE + 7)
> +
> +#define H4_U193_GPIO_BASE		(H4_U192_GPIO_BASE + 8)
> +#	define H4_GPIO_SPR0		(H4_U193_GPIO_BASE + 0)
> +#	define H4_GPIO_SPR1		(H4_U193_GPIO_BASE + 1)
> +#	define H4_GPIO_WLAN_SHUTDOWN	(H4_U193_GPIO_BASE + 2)
> +#	define H4_GPIO_WLAN_RESET	(H4_U193_GPIO_BASE + 3)
> +#	define H4_GPIO_WLAN_CLK_ENn	(H4_U193_GPIO_BASE + 4)
> +	/* 5, 6 not connected */
> +#	define H4_GPIO_CAM_RST		(H4_U193_GPIO_BASE + 7)
> +
>  #endif /*  __ASM_ARCH_OMAP_H4_H */
>  
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -148,7 +148,7 @@ config SENSORS_TLV320AIC23
>  
>  config GPIOEXPANDER_OMAP
>  	bool "GPIO Expander PCF8574PWR for OMAP"
> -	depends on I2C && (ARCH_OMAP16XX || ARCH_OMAP24XX)
> +	depends on I2C && MACH_OMAP_H3
>  	help
>  	  If you say yes here you get support for I/O expander calls
>  	  to configure IrDA, Camera and audio devices.
> --- a/drivers/net/irda/Kconfig
> +++ b/drivers/net/irda/Kconfig
> @@ -345,7 +345,7 @@ config MCS_FIR
>  config OMAP_IR
>  	tristate "OMAP IrDA(SIR/MIR/FIR)"
>  	depends on IRDA && ARCH_OMAP
> -	select GPIOEXPANDER_OMAP if (MACH_OMAP_H3 || MACH_OMAP_H4)
> +	select GPIOEXPANDER_OMAP if MACH_OMAP_H3
>          help
>  	  Say Y here if you want to build support for the Texas Instruments
>  	  OMAP IrDA device driver, which supports SIR/MIR/FIR. This driver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
