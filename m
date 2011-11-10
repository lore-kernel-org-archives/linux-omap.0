From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Thu, 10 Nov 2011 15:08:15 +0200
Message-ID: <4EBBCCBF.9010705@compulab.co.il>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:51565
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934318Ab1KJNI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 08:08:28 -0500
In-Reply-To: <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Ilya,

On 11/09/11 02:12, Ilya Yanok wrote:
> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/boot/dts/mcx.dts                    |   29 ++
>  arch/arm/mach-omap2/Kconfig                  |    5 +
>  arch/arm/mach-omap2/Makefile                 |    3 +
>  arch/arm/mach-omap2/board-mcx.c              |  618 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  5 files changed, 656 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mcx.dts
>  create mode 100644 arch/arm/mach-omap2/board-mcx.c
> 
> diff --git a/arch/arm/boot/dts/mcx.dts b/arch/arm/boot/dts/mcx.dts
> new file mode 100644
> index 0000000..c87df59
> --- /dev/null
> +++ b/arch/arm/boot/dts/mcx.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "am35xx.dtsi"
> +
> +/ {
> +	model = "HTKW mcx";
> +	compatible = "htkw,mcx";
> +
> +	/*
> +	 * Since the initial device tree board file does not create any
> +	 * devices (MMC, network...), the only way to boot is to provide a
> +	 * ramdisk.
> +	 */
> +	chosen {
> +		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index c3d530b..3be9cc0 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -230,6 +230,11 @@ config MACH_OMAP_3430SDP
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> +config MACH_MCX
> +	bool "htkw mcx board"

I have no problem with that, but is this really how you want
the config option to be displayed?

> +	depends on ARCH_OMAP3
> +	select OMAP_PACKAGE_CBB
> +
>  config MACH_NOKIA_N800
>         bool
>  
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 69ab1c0..913aa43 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -232,6 +232,9 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
>  
>  obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
>  obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
> +obj-$(CONFIG_MACH_MCX)			+= board-mcx.o \
> +					   omap_phy_internal.o \

This one is always compiled in, so you don't need to specify it
(see a couple of lines below in the file)

> +					   hsmmc.o

This one is compiled in when CONFIG_MMC_OMAP_HS symbol
enabled, so you don't need to specify this one either.

>  
>  # Platform specific device init code
>  
> diff --git a/arch/arm/mach-omap2/board-mcx.c b/arch/arm/mach-omap2/board-mcx.c
> new file mode 100644
> index 0000000..311e1fb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-mcx.c
> @@ -0,0 +1,618 @@
> +/*
> + * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
> + *
> + * Modified from mach-omap2/board-omap3beagle.c
> + *
> + * Initial code: Syed Mohammed Khasim
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/leds.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/opp.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mmc/host.h>
> +
> +#include <linux/regulator/machine.h>
> +#include <linux/davinci_emac.h>
> +#include <linux/i2c/edt_ts.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/am35xx.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
> +
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/omap_hwmod.h>
> +#include <video/omapdss.h>
> +#include <video/omap-panel-generic-dpi.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>
> +#include <plat/usb.h>
> +#include <plat/omap_device.h>
> +
> +#include "mux.h"
> +#include "control.h"
> +#include "hsmmc.h"
> +#include "common-board-devices.h"

I bet, you don't use and don't need all the includes above...
Can it be reduced to the really needed ones?

> +
> +#define MCX_MDIO_FREQUENCY	(1000000)
> +
> +static struct mdio_platform_data mcx_mdio_pdata = {
> +	.bus_freq	= MCX_MDIO_FREQUENCY,
> +};
> +
> +static struct resource am3517_mdio_resources[] = {
> +	{
> +		.start  = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET,
> +		.end    = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET +
> +			  SZ_4K - 1,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device am3517_mdio_device = {
> +	.name		= "davinci_mdio",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(am3517_mdio_resources),
> +	.resource	= am3517_mdio_resources,
> +	.dev.platform_data = &mcx_mdio_pdata,
> +};
> +
> +static struct emac_platform_data mcx_emac_pdata = {
> +	.rmii_en	= 1,
> +};
> +
> +static struct resource am3517_emac_resources[] = {
> +	{
> +		.start  = AM35XX_IPSS_EMAC_BASE,
> +		.end    = AM35XX_IPSS_EMAC_BASE + 0x2FFFF,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start  = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
> +		.end    = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start  = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
> +		.end    = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start  = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
> +		.end    = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start  = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
> +		.end    = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device am3517_emac_device = {
> +	.name		= "davinci_emac",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(am3517_emac_resources),
> +	.resource	= am3517_emac_resources,
> +};
> +
> +static void am3517_enable_ethernet_int(void)
> +{
> +	u32 regval;
> +
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> +	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
> +		AM35XX_CPGMAC_C0_TX_PULSE_CLR |
> +		AM35XX_CPGMAC_C0_MISC_PULSE_CLR |
> +		AM35XX_CPGMAC_C0_RX_THRESH_CLR);
> +	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> +}
> +
> +static void am3517_disable_ethernet_int(void)
> +{
> +	u32 regval;
> +
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> +	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
> +		AM35XX_CPGMAC_C0_TX_PULSE_CLR);
> +	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> +}
> +
> +static void mcx_ethernet_init(struct emac_platform_data *pdata)
> +{
> +	unsigned int regval;
> +
> +	pdata->ctrl_reg_offset		= AM35XX_EMAC_CNTRL_OFFSET;
> +	pdata->ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET;
> +	pdata->ctrl_ram_offset		= AM35XX_EMAC_CNTRL_RAM_OFFSET;
> +	pdata->ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE;
> +	pdata->version			= EMAC_VERSION_2;
> +	pdata->hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR;
> +	pdata->interrupt_enable		= am3517_enable_ethernet_int;
> +	pdata->interrupt_disable	= am3517_disable_ethernet_int;
> +	am3517_emac_device.dev.platform_data	= pdata;
> +	platform_device_register(&am3517_emac_device);
> +	platform_device_register(&am3517_mdio_device);
> +	clk_add_alias(NULL, dev_name(&am3517_emac_device.dev),
> +		      "emac_clk", &am3517_emac_device.dev);
> +	clk_add_alias(NULL, dev_name(&am3517_mdio_device.dev),
> +		      "phy_clk", &am3517_emac_device.dev);
> +
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> +	regval = regval & (~(AM35XX_CPGMACSS_SW_RST));
> +	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
> +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> +
> +	return ;

?? just copy/paste?

> +}

Almost all of the data above is AM35xx specific,
not board specific.
It makes sense to put it into an AM35xx specific file.
Say am35xx-emac.c?
That way we will have much less copy/paste across boards.

> +
> +static struct mtd_partition mcx_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name		= "X-Loader",
> +		.offset		= 0,
> +		.size		= 4 * NAND_BLOCK_SIZE,
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
> +		.size		= 15 * NAND_BLOCK_SIZE,
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot Env",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
> +		.size		= 1 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "Kernel",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
> +		.size		= 32 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "File System",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
> +		.size		= MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +#define LCD_PWR_ENn		131
> +#define HDMI_TRCVR_PDn		133
> +#define LCD_BKLIGHT_EN		55
> +#define LCD_LVL_SFHT_BUF_ENn	43
> +
> +static int lcd_enabled;
> +static int dvi_enabled;
> +
> +static int mcx_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	if (dvi_enabled) {
> +		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio_set_value(LCD_BKLIGHT_EN, 1);
> +	lcd_enabled = 1;
> +
> +	return 0;
> +}
> +
> +static void mcx_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(LCD_BKLIGHT_EN, 0);
> +	lcd_enabled = 0;
> +}
> +
> +static struct panel_generic_dpi_data lcd_panel = {
> +	.name			= "focaltech_etm070003dh6",
> +	.platform_enable	= mcx_panel_enable_lcd,
> +	.platform_disable	= mcx_panel_disable_lcd,
> +};
> +
> +static struct omap_dss_device mcx_lcd_device = {
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.name			= "lcd",
> +	.driver_name		= "generic_dpi_panel",
> +	.data			= &lcd_panel,
> +	.phy.dpi.data_lines	= 24,
> +};
> +
> +/*
> + * TV Output
> + */
> +
> +static int mcx_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +	return 0;
> +}
> +
> +static void mcx_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
> +}
> +
> +static struct omap_dss_device mcx_tv_device = {
> +	.type			= OMAP_DISPLAY_TYPE_VENC,
> +	.name			= "tv",
> +	.driver_name		= "venc",
> +	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
> +	.platform_enable	= mcx_panel_enable_tv,
> +	.platform_disable	= mcx_panel_disable_tv,
> +};
> +
> +/*
> + * DVI/HDMI Output
> + */
> +
> +static int mcx_panel_enable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (lcd_enabled) {
> +		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
> +		return -EINVAL;
> +	}
> +	dvi_enabled = 1;
> +	gpio_set_value(HDMI_TRCVR_PDn, 1);
> +	return 0;
> +}
> +
> +static void mcx_panel_disable_dvi(struct omap_dss_device *dssdev)
> +{
> +	dvi_enabled = 0;
> +	gpio_set_value(HDMI_TRCVR_PDn, 0);
> +}
> +
> +static struct panel_generic_dpi_data dvi_panel = {
> +	.platform_enable	= mcx_panel_enable_dvi,
> +	.platform_disable	= mcx_panel_disable_dvi,
> +};
> +static struct omap_dss_device mcx_dvi_device = {
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.name			= "dvi",
> +	.driver_name		= "dvi",
> +	.data			= &dvi_panel,
> +	.phy.dpi.data_lines	= 24,
> +};
> +
> +static struct omap_dss_device *mcx_dss_devices[] = {
> +	&mcx_lcd_device,
> +	&mcx_tv_device,
> +	&mcx_dvi_device,
> +};
> +
> +static struct omap_dss_board_info mcx_dss_data = {
> +	.num_devices	= ARRAY_SIZE(mcx_dss_devices),
> +	.devices	= mcx_dss_devices,
> +	.default_device	= &mcx_lcd_device,
> +};
> +
> +static void __init mcx_display_init(void)
> +{
> +	int r;
> +
> +	/* disable LCD backlight */
> +	r = gpio_request(LCD_BKLIGHT_EN, "LCD_BKLIGHT_EN");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_BKLIGHT_EN gpio\n");
> +		goto err_1;
> +	}
> +	omap_mux_init_gpio(LCD_BKLIGHT_EN, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(LCD_BKLIGHT_EN, 0);

I see what are you up to here...
Do you mean: try to request the GPIO and only if it is free,
then set the mux?
I think it is redundant...
You don't really have that concurrency - no any other code
should request these GPIOs and if there is, then it is a bug
and should be treated as such.
I think there is no need in this kind of complexity - just
use gpio_{request|free}_array().

> +
> +	/* Enable VIO-> 3.3v level shifter */
> +	r = gpio_request(LCD_LVL_SFHT_BUF_ENn, "LCD_LVL_SFHT_BUF_ENn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_LVL_SFHT_BUF_ENn gpio\n");
> +		goto err_2;
> +	}
> +	omap_mux_init_gpio(LCD_LVL_SFHT_BUF_ENn, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(LCD_LVL_SFHT_BUF_ENn, 0);
> +
> +	/* Enable LCD panel VCC */
> +
> +	r = gpio_request(LCD_PWR_ENn, "LCD_PWR_ENn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_PWR_ENn\n");
> +		goto err_3;
> +	}
> +	omap_mux_init_gpio(LCD_PWR_ENn, OMAP_PIN_OUTPUT);
> +
> +	gpio_direction_output(LCD_PWR_ENn, 0);
> +
> +	/* Disable HDMI transceiver */
> +	r = gpio_request(HDMI_TRCVR_PDn, "HDMI_TRCVR_PDn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get HDMI_TRCVR_PDn\n");
> +		goto err_4;
> +	}
> +	omap_mux_init_gpio(HDMI_TRCVR_PDn, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(HDMI_TRCVR_PDn, 0);
> +
> +	omap_display_init(&mcx_dss_data);
> +
> +	return;
> +
> +err_4:
> +	gpio_free(HDMI_TRCVR_PDn);
> +err_3:
> +	gpio_free(LCD_LVL_SFHT_BUF_ENn);
> +err_2:
> +	gpio_free(LCD_LVL_SFHT_BUF_ENn);
> +err_1:
> +	gpio_free(LCD_BKLIGHT_EN);
> +}

Why not use gpio_{request|free}_array()?
It will make the above code really simple.

> +
> +/* TPS65023 specific initialization */
> +/* VDCDC1 -> VDD_CORE */
> +static struct regulator_consumer_supply am3517_vdcdc1_supplies[] = {
> +	{
> +		.supply = "vdd_core",
> +	},
> +};
> +
> +/* VDCDC2 -> VDDSHV */
> +static struct regulator_consumer_supply am3517_vdcdc2_supplies[] = {
> +	{
> +		.supply = "vddshv",
> +	},
> +};
> +
> +/*
> + * VDCDC2 |-> VDDS
> + *	  |-> VDDS_SRAM_CORE_BG
> + *	  |-> VDDS_SRAM_MPU
> + */
> +static struct regulator_consumer_supply am3517_vdcdc3_supplies[] = {
> +	{
> +		.supply = "vdds",
> +	},
> +	{
> +		.supply = "vdds_sram_core_bg",
> +	},
> +	{
> +		.supply = "vdds_sram_mpu",
> +	},
> +};
> +
> +/*
> + * LDO1 |-> VDDA1P8V_USBPHY
> + *	|-> VDDA_DAC
> + */
> +static struct regulator_consumer_supply am3517_ldo1_supplies[] = {
> +	{
> +		.supply = "vdda1p8v_usbphy",
> +	},
> +	{
> +		.supply = "vdda_dac",
> +	},
> +};
> +
> +/* LDO2 -> VDDA3P3V_USBPHY */
> +static struct regulator_consumer_supply am3517_ldo2_supplies[] = {
> +	{
> +		.supply = "vdda3p3v_usbphy",
> +	},
> +};
> +
> +static struct regulator_init_data mcx_regulator_data[] = {
> +	/* DCDC1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1200000,
> +			.max_uV = 1200000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc1_supplies),
> +		.consumer_supplies = am3517_vdcdc1_supplies,
> +	},
> +	/* DCDC2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc2_supplies),
> +		.consumer_supplies = am3517_vdcdc2_supplies,
> +	},
> +	/* DCDC3 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc3_supplies),
> +		.consumer_supplies = am3517_vdcdc3_supplies,
> +	},
> +	/* LDO1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo1_supplies),
> +		.consumer_supplies = am3517_ldo1_supplies,
> +	},
> +	/* LDO2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo2_supplies),
> +		.consumer_supplies = am3517_ldo2_supplies,
> +	},
> +};
> +
> +static struct i2c_board_info __initdata mcx_i2c1_devices[] = {
> +	{
> +		I2C_BOARD_INFO("ds1337", 0x68),
> +	},
> +	{
> +		I2C_BOARD_INFO("tps65023", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &mcx_regulator_data[0],
> +	},
> +};
> +
> +#define TOUCH_INT_GPIO	170
> +
> +static struct edt_platform_data edt_ts_data = {
> +	.irq_gpio = TOUCH_INT_GPIO,
> +};
> +
> +static int __init mcx_ts_init(void)

What is the point in int as return type, if you don't check it?

> +{
> +	struct i2c_board_info mcx_edt_ts[] = {
> +		{
> +			I2C_BOARD_INFO("edt_ts", 0x38),
> +			.platform_data = &edt_ts_data,
> +		},
> +	};
> +
> +	if (gpio_request(TOUCH_INT_GPIO, "TOUCH_INT")) {
> +		printk(KERN_ERR "failed to get TOUCH_INT gpio\n");
> +		return 1;
> +	}
> +
> +	gpio_direction_input(TOUCH_INT_GPIO);

gpio_request_one()?

> +
> +	i2c_register_board_info(3, mcx_edt_ts, 1);
> +
> +	return 0;
> +}
> +
> +static int __init mcx_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 400, mcx_i2c1_devices,
> +			ARRAY_SIZE(mcx_i2c1_devices));
> +	omap_register_i2c_bus(2, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	mcx_ts_init();
> +	return 0;
> +}
> +
> +#define USB_HOST_PWR_EN		132
> +#define USB_PHY1_RESET		154
> +#define USB_PHY2_RESET		152
> +
> +static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> +
> +	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
> +
> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = USB_PHY1_RESET,
> +	.reset_gpio_port[1]  = USB_PHY2_RESET,
> +	.reset_gpio_port[2]  = -EINVAL
> +};
> +
> +#define SD_CARD_WP		65
> +
> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +		.mmc		= 1,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd        = -EINVAL,
> +		.gpio_wp        = SD_CARD_WP,
> +		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
> +					MMC_VDD_165_195,
> +	},
> +	{}      /* Terminator */
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
> +	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
> +			OMAP_PULL_ENA | OMAP_PULL_UP),
> +	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
> +			OMAP_PULL_ENA | OMAP_PULL_UP),
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#endif
> +
> +static void __init mcx_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	mcx_i2c_init();
> +	omap_serial_init();
> +
> +	mcx_display_init();
> +
> +	/* Configure EHCI ports */
> +	gpio_request(USB_HOST_PWR_EN, "USB_HOST_PWR_EN");
> +	omap_mux_init_gpio(USB_HOST_PWR_EN, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(USB_HOST_PWR_EN, 1);

gpio_request_one()?

> +
> +	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(USB_PHY2_RESET, OMAP_PIN_OUTPUT);
> +	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, mcx_nand_partitions,
> +			     ARRAY_SIZE(mcx_nand_partitions));
> +	/*Ethernet*/
> +	mcx_ethernet_init(&mcx_emac_pdata);
> +
> +	/* MMC init */
> +	omap_mux_init_gpio(SD_CARD_WP, OMAP_PIN_INPUT);
> +	omap2_hsmmc_init(mmc);
> +}
> +
> +static const char *mcx_dt_match[] __initdata = {
> +	"htkw,mcx",
> +	NULL
> +};
> +
> +MACHINE_START(MCX, "htkw mcx")
> +	/* Maintainer: Ilya Yanok */
> +	.atag_offset	= 0x100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= am35xx_init_early,
> +	.init_irq	= omap3_init_irq,
> +	.init_machine	= mcx_init,
> +	.timer		= &omap3_timer,
> +	.dt_compat	= mcx_dt_match,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index 2d45ea3..5a1bb62 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -168,6 +168,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		DEBUG_LL_OMAP3(3, omap_ldp);
>  		DEBUG_LL_OMAP3(3, overo);
>  		DEBUG_LL_OMAP3(3, touchbook);
> +		DEBUG_LL_OMAP3(3, mcx);

Alphabetical order please.

>  
>  		/* omap4 based boards using UART3 */
>  		DEBUG_LL_OMAP4(3, omap_4430sdp);

-- 
Regards,
Igor.
