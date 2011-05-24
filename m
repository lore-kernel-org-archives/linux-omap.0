From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/3] Initial B&N Nook Color (encore) support.
Date: Tue, 24 May 2011 10:07:15 +0300
Message-ID: <4DDB5923.4030706@compulab.co.il>
References: <1306098276-21112-1-git-send-email-green@linuxhacker.ru> <1306098276-21112-2-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:48579
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752579Ab1EXHHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 03:07:20 -0400
In-Reply-To: <1306098276-21112-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Oleg,


Some comments below, mostly nitpicking, sorry...


On 05/23/11 00:04, green@linuxhacker.ru wrote:

> From: Oleg Drokin <green@linuxhacker.ru>
>
> Bare-bones board file, comes with serial console, gpio keys,
> MMC/SDCard and USB (peripheral) support.
>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
>  arch/arm/mach-omap2/Kconfig                  |    5 +
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/board-omap3encore.c      |  350 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  4 files changed, 358 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap3encore.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b997a35..5370561 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -173,6 +173,11 @@ config MACH_OMAP3_TORPEDO
>  	 for full description please see the products webpage at
>  	 http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
>  
> +config MACH_ENCORE
> +        bool "Barnes & Noble Encore (Nook Color)"
> +        depends on ARCH_OMAP3
> +        select OMAP_PACKAGE_CBP
> +
>  config MACH_OVERO
>  	bool "Gumstix Overo board"
>  	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index a0c2cae..619e5ca 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -189,6 +189,8 @@ obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o \
>  					   hsmmc.o
> +obj-$(CONFIG_MACH_ENCORE)		+= board-omap3encore.o \
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
> new file mode 100644
> index 0000000..e4a0a98
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3encore.c
> @@ -0,0 +1,350 @@
> +/*
> + * Support for Barns&Noble Nook Color
> + *
> + * Loosely based on mach-omap2/board-zoom.c
> + * Copyright (C) 2008-2010 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * May 2011 Oleg Drokin <green@linuxhacker.ru> - Port to 2.6.39

You'd better avoid versions in comments,
this information can be mined from git log if needed.
I don't really mind if you want to keep it, so do as you like.

> + *
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <plat/common.h>
> +#include <plat/usb.h>
> +#include <plat/mux.h>
> +#include <plat/mmc.h>
> +
> +#include "mux.h"
> +#include "hsmmc.h"
> +#include "sdram-hynix-h8mbx00u0mer-0em.h"
> +
> +/* Encore-specific device-info and i2c addresses. */
> +/* Battery, bus 1 */
> +#define MAX17042_I2C_SLAVE_ADDRESS	0x36
> +#define MAX17042_GPIO_FOR_IRQ		100
> +
> +/*addition of MAXIM8903/TI GPIO mapping WRT schematics */
> +#define MAX8903_UOK_GPIO_FOR_IRQ	115
> +#define MAX8903_DOK_GPIO_FOR_IRQ	114
> +#define MAX8903_GPIO_CHG_EN		110
> +#define MAX8903_GPIO_CHG_STATUS		111
> +#define MAX8903_GPIO_CHG_FLT		101
> +#define MAX8903_GPIO_CHG_IUSB		102
> +#define MAX8903_GPIO_CHG_USUS		104
> +#define MAX8903_GPIO_CHG_ILM		61
> +
> +/* TI WLAN */
> +#define ENCORE_WIFI_PMENA_GPIO		22
> +#define ENCORE_WIFI_IRQ_GPIO		15
> +#define ENCORE_WIFI_EN_POW		16
> +
> +/* Accelerometer i2c bus 1*/
> +#define KXTF9_I2C_SLAVE_ADDRESS		0x0F
> +#define KXTF9_GPIO_FOR_PWR		34
> +#define KXTF9_GPIO_FOR_IRQ		113
> +
> +/* Touch screen i2c bus 2*/
> +#define CYTTSP_I2C_SLAVEADDRESS		34
> +#define ENCORE_CYTTSP_GPIO		99
> +#define ENCORE_CYTTSP_RESET_GPIO	46
> +
> +/* Audio codec, i2c bus 2 */
> +#define AUDIO_CODEC_POWER_ENABLE_GPIO	103
> +#define AUDIO_CODEC_RESET_GPIO		37
> +#define AUDIO_CODEC_IRQ_GPIO		59
> +#define AIC3100_I2CSLAVEADDRESS		0x18
> +
> +
> +/* Different HW revisions */
> +#define BOARD_ENCORE_REV_EVT1A		0x1
> +#define BOARD_ENCORE_REV_EVT1B		0x2
> +#define BOARD_ENCORE_REV_EVT2		0x3
> +#define BOARD_ENCORE_REV_DVT		0x4
> +#define BOARD_ENCORE_REV_PVT		0x5
> +#define BOARD_ENCORE_REV_UNKNOWN	0x6
> +
> +static inline int is_encore_board_evt2(void)
> +{
> +	return system_rev >= BOARD_ENCORE_REV_EVT2;
> +}
> +
> +static inline int is_encore_board_evt1b(void)
> +{
> +	return system_rev == BOARD_ENCORE_REV_EVT1B;
> +}
> +
> +static int encore_twl4030_keymap[] = {
> +	KEY(1, 0, KEY_VOLUMEUP),
> +	KEY(2, 0, KEY_VOLUMEDOWN),
> +};
> +
> +static struct matrix_keymap_data encore_twl4030_keymap_data = {
> +	.keymap			= encore_twl4030_keymap,
> +	.keymap_size		= ARRAY_SIZE(encore_twl4030_keymap),
> +};
> +
> +static struct twl4030_keypad_data encore_kp_twl4030_data = {
> +	.rows			= 8,
> +	.cols			= 8,
> +	.keymap_data		= &encore_twl4030_keymap_data,
> +	.rep			= 1,
> +};
> +
> +/* HOME key code for HW > EVT2A */
> +static struct gpio_keys_button encore_gpio_buttons[] = {
> +	{
> +		.code			= KEY_POWER,
> +		.gpio			= 14,
> +		.desc			= "POWER",
> +		.active_low		= 0,
> +		.wakeup			= 1,
> +	},
> +	{
> +		.code			= KEY_HOME,
> +		.gpio			= 48,
> +		.desc			= "HOME",
> +		.active_low		= 1,
> +		.wakeup			= 1,
> +	},
> +};
> +
> +static struct gpio_keys_platform_data encore_gpio_key_info = {
> +	.buttons	= encore_gpio_buttons,
> +	.nbuttons	= ARRAY_SIZE(encore_gpio_buttons),
> +};
> +
> +static struct platform_device encore_keys_gpio = {
> +	.name	= "gpio-keys",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &encore_gpio_key_info,
> +	},
> +};
> +
> +static struct platform_device *encore_devices[] __initdata = {
> +	&encore_keys_gpio,
> +};
> +
> +static void __init omap_encore_init_early(void)
> +{
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
> +				  h8mbx00u0mer0em_sdrc_params);
> +}
> +
> +static struct twl4030_usb_data encore_usb_data = {
> +	.usb_mode	= T2_USB_MODE_ULPI,
> +};
> +
> +static struct regulator_consumer_supply encore_vmmc1_supply = {
> +	.supply		= "vmmc",
> +	.dev_name       = "omap_hsmmc.0"
> +};

Why not REGULATOR_SUPPLY?

> +
> +static struct regulator_consumer_supply encore_vdda_dac_supply =
> +	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
> +
> +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> +static struct regulator_init_data encore_vmmc1 = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 3150000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &encore_vmmc1_supply,
> +};
> +
> +static struct regulator_init_data encore_vdac = {
> +	.constraints = {
> +		.min_uV                 = 1800000,
> +		.max_uV                 = 1800000,
> +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &encore_vdda_dac_supply,
> +};
> +
> +/*
> + * The order is reverted in this table so that internal eMMC is presented
> + * as first mmc card for compatibility with existing installations and
> + * for common sense reasons
> + */
> +static struct omap2_hsmmc_info mmc[] __initdata = {
> +	{
> +		.name		= "internal",
> +		.mmc		= 2,
> +		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +		.nonremovable	= true,
> +		.power_saving	= true,
> +		.ocr_mask	= MMC_VDD_165_195, /* 1.85V */
> +	},
> +	{
> +		.name		= "external",
> +		.mmc		= 1,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +		.power_saving	= true,
> +	},
> +	{
> +		.name		= "internal",
> +		.mmc		= 3,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +		.nonremovable	= true,
> +		.power_saving	= true,
> +	},
> +	{}      /* Terminator */
> +};
> +
> +static int encore_hsmmc_card_detect(struct device *dev, int slot)
> +{
> +	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +
> +	/* Encore board EVT2 and later has pin high when card is present */
> +	return gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> +}
> +
> +static int encore_twl4030_hsmmc_late_init(struct device *dev)
> +{
> +	int ret = 0;
> +	struct platform_device *pdev = container_of(dev,
> +						struct platform_device, dev);
> +	struct omap_mmc_platform_data *pdata = dev->platform_data;
> +
> +	if (is_encore_board_evt2()) {
> +		/* Setting MMC1 (external) Card detect */
> +		if (pdev->id == 0)
> +			pdata->slots[0].card_detect = encore_hsmmc_card_detect;
> +	}
> +
> +	return ret;
> +}
> +
> +static __init void encore_hsmmc_set_late_init(struct device *dev)
> +{
> +	struct omap_mmc_platform_data *pdata;
> +
> +	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
> +	if (!dev)
> +		return;
> +
> +	pdata = dev->platform_data;
> +	pdata->init = encore_twl4030_hsmmc_late_init;
> +}
> +
> +static int __ref encore_twl_gpio_setup(struct device *dev,
> +		unsigned gpio, unsigned ngpio)
> +{
> +	struct omap2_hsmmc_info *c;
> +	/*
> +	 * gpio + 0 is "mmc0_cd" (input/IRQ),
> +	 * gpio + 1 is "mmc1_cd" (input/IRQ)
> +	 */
> +	mmc[1].gpio_cd = gpio + 0;
> +	mmc[0].gpio_cd = gpio + 1;
> +	omap2_hsmmc_init(mmc);
> +	for (c = mmc; c->mmc; c++)
> +		encore_hsmmc_set_late_init(c->dev);
> +
> +	return 0;
> +}
> +
> +static struct twl4030_gpio_platform_data encore_gpio_data = {
> +	.gpio_base	= OMAP_MAX_GPIO_LINES,
> +	.irq_base	= TWL4030_GPIO_IRQ_BASE,
> +	.irq_end	= TWL4030_GPIO_IRQ_END,
> +	.setup		= encore_twl_gpio_setup,
> +};
> +
> +static struct twl4030_madc_platform_data encore_madc_data = {
> +	.irq_line	= 1,
> +};
> +
> +static struct twl4030_platform_data __refdata encore_twldata = {
> +	.irq_base	= TWL4030_IRQ_BASE,
> +	.irq_end	= TWL4030_IRQ_END,
> +
> +	.madc		= &encore_madc_data,
> +	.usb		= &encore_usb_data,
> +	.gpio		= &encore_gpio_data,
> +	.keypad		= &encore_kp_twl4030_data,
> +	.vmmc1		= &encore_vmmc1,
> +	.vdac		= &encore_vdac,
> +};
> +
> +static struct i2c_board_info __initdata encore_i2c_bus1_info[] = {
> +	{
> +		I2C_BOARD_INFO("tps65921", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.irq = INT_34XX_SYS_NIRQ,
> +		.platform_data = &encore_twldata,
> +	},
> +};
> +
> +static struct i2c_board_info __initdata encore_i2c_bus2_info[] = {
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define board_mux       NULL

I don't insist, but you don't need the #else for board_mux.
mux.h already provides you a stub in case !CONFIG_OMAP_MUX.

> +#endif
> +
> +static struct omap_board_config_kernel encore_config[] __initdata = {
> +};
> +
> +static void __init omap_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 100, encore_i2c_bus1_info,
> +			ARRAY_SIZE(encore_i2c_bus1_info));
> +	omap_register_i2c_bus(2, 400, encore_i2c_bus2_info,
> +			ARRAY_SIZE(encore_i2c_bus2_info));
> +}
> +
> +static void __init omap_encore_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
> +	omap_i2c_init();
> +	omap_serial_init();
> +	usb_musb_init(NULL);
> +
> +	omap_board_config = encore_config;
> +	omap_board_config_size = ARRAY_SIZE(encore_config);
> +
> +	platform_add_devices(encore_devices, ARRAY_SIZE(encore_devices));
> +}
> +
> +MACHINE_START(ENCORE, "encore")
> +	.boot_params	= 0x80000100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap_encore_init_early,
> +	.init_irq	= omap_init_irq,
> +	.init_machine	= omap_encore_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index 30b891c..21c4ca9 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -151,6 +151,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		DEBUG_LL_OMAP3(3, cm_t3517);
>  		DEBUG_LL_OMAP3(3, craneboard);
>  		DEBUG_LL_OMAP3(3, devkit8000);
> +		DEBUG_LL_OMAP3(3, encore);
>  		DEBUG_LL_OMAP3(3, igep0020);
>  		DEBUG_LL_OMAP3(3, igep0030);
>  		DEBUG_LL_OMAP3(3, nokia_rm680);

-- 
Regards,
Igor.

