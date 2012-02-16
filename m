From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH] OMAP3: Add Corscience Tricorder board
Date: Thu, 16 Feb 2012 19:37:33 +0100
Message-ID: <4F3D4CED.9030606@gmail.com>
References: <1328111949-1859-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40895 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754212Ab2BPSgN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 13:36:13 -0500
Received: by lagu2 with SMTP id u2so2761933lag.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 10:36:12 -0800 (PST)
In-Reply-To: <1328111949-1859-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

Hello Tony,

do you have any comments on this?

Thomas

On 02/01/2012 04:59 PM, Thomas Weber wrote:
> Tricorder is a board which is very similar to the Devkit8000.
> It is designed as a base platform for further medical devices.
>
> www.corscience.de/en/medical-engineering/products/multiparameter/mp10-board.html
>
> Signed-off-by: Thomas Weber<weber@corscience.de>
> ---
>   arch/arm/mach-omap2/Kconfig                  |    6 +
>   arch/arm/mach-omap2/Makefile                 |    1 +
>   arch/arm/mach-omap2/board-tricorder.c        |  379 ++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>   sound/soc/omap/Kconfig                       |    2 +-
>   sound/soc/omap/omap3beagle.c                 |    6 +-
>   6 files changed, 392 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/board-tricorder.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 41e6612..980c11c 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -159,6 +159,12 @@ config MACH_DEVKIT8000
>   	default y
>   	select OMAP_PACKAGE_CUS
>
> +config MACH_TRICORDER
> +	bool "Tricorder board"
> +	depends on ARCH_OMAP3
> +	default y
> +	select OMAP_PACKAGE_CUS
> +
>   config MACH_OMAP_LDP
>   	bool "OMAP3 LDP board"
>   	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index fc9b238..83e8156 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -204,6 +204,7 @@ obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
>   obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
>   obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
>   obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
> +obj-$(CONFIG_MACH_TRICORDER)		+= board-tricorder.o
>   obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>   obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
>   					   sdram-nokia.o
> diff --git a/arch/arm/mach-omap2/board-tricorder.c b/arch/arm/mach-omap2/board-tricorder.c
> new file mode 100644
> index 0000000..bafe6a7
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-tricorder.c
> @@ -0,0 +1,379 @@
> +/*
> + * board-tricorder.c - Corscience Tricorder board
> + *
> + * Copyright (C) 2012
> + * Corscience GmbH&  Co. KG,<www.corscience.de>
> + * Thomas Weber<weber@corscience.de>
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
> +#include<linux/kernel.h>
> +#include<linux/init.h>
> +#include<linux/platform_device.h>
> +#include<linux/delay.h>
> +#include<linux/err.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +#include<linux/leds.h>
> +#include<linux/gpio.h>
> +#include<linux/input.h>
> +#include<linux/gpio_keys.h>
> +
> +#include<linux/mtd/mtd.h>
> +#include<linux/mtd/partitions.h>
> +#include<linux/mtd/nand.h>
> +#include<linux/mmc/host.h>
> +
> +#include<linux/regulator/machine.h>
> +#include<linux/i2c/twl.h>
> +
> +#include<mach/hardware.h>
> +#include<mach/id.h>
> +#include<asm/mach-types.h>
> +#include<asm/mach/arch.h>
> +#include<asm/mach/map.h>
> +#include<asm/mach/flash.h>
> +
> +#include<plat/board.h>
> +#include<plat/gpmc.h>
> +#include<plat/nand.h>
> +#include<plat/usb.h>
> +
> +#include<linux/input/matrix_keypad.h>
> +#include<linux/interrupt.h>
> +
> +#include<linux/i2c/at24.h>
> +
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
> +#include "common.h"
> +#include "mux.h"
> +#include "hsmmc.h"
> +#include "common-board-devices.h"
> +
> +#define NAND_BLOCK_SIZE		SZ_128K
> +
> +static struct mtd_partition tricorder_nand_partitions[] = {
> +	/* All the partitionsizes are listed in terms of NAND block size */
> +	{
> +		.name		= "U-Boot SPL",
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
> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +		.mmc		= 1,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd	= 126,
> +	},
> +	{}	/* Terminator */
> +};
> +
> +static struct regulator_consumer_supply tricorder_vmmc1_supply =
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
> +
> +/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
> +static struct regulator_init_data tricorder_vmmc1 = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 3150000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	=&tricorder_vmmc1_supply,
> +};
> +
> +static struct twl4030_platform_data tricorder_twldata = {
> +	/* platform_data for children goes here */
> +	.vmmc1		=&tricorder_vmmc1,
> +};
> +
> +static struct at24_platform_data tricorder_eepromdata = {
> +	.byte_len       = 4096, /* 32K */
> +	.page_size      = 32,
> +	.flags          = AT24_FLAG_ADDR16 | AT24_FLAG_IRUGO
> +};
> +
> +static struct i2c_board_info __initdata tricorder_i2c2_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("24c32", 0x50),
> +		.platform_data =&tricorder_eepromdata,
> +	},
> +	{
> +		I2C_BOARD_INFO("24c32", 0x51),
> +		.platform_data =&tricorder_eepromdata,
> +	},
> +};
> +
> +static int __init tricorder_i2c_init(void)
> +{
> +	omap3_pmic_get_config(&tricorder_twldata,
> +			TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_AUDIO,
> +			TWL_COMMON_REGULATOR_VDAC);
> +	omap3_pmic_init("tps65930",&tricorder_twldata);
> +	omap_register_i2c_bus(2, 400, tricorder_i2c2_boardinfo,
> +				ARRAY_SIZE(tricorder_i2c2_boardinfo));
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	return 0;
> +}
> +
> +static struct gpio_led gpio_leds[] = {
> +	{
> +		.name			= "orange",
> +		.default_trigger	= "heartbeat",
> +		.gpio			= 42,
> +		.active_low		= false,
> +	},
> +	{
> +		.name			= "green",
> +		.default_trigger	= "heartbeat",
> +		.gpio			= 43,
> +		.active_low		= false,
> +	},
> +};
> +
> +static struct gpio_led_platform_data gpio_led_info = {
> +	.leds		= gpio_leds,
> +	.num_leds	= ARRAY_SIZE(gpio_leds),
> +};
> +
> +static struct platform_device leds_gpio = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	=&gpio_led_info,
> +	},
> +};
> +
> +static struct platform_device *tricorder_devices[] __initdata = {
> +	&leds_gpio,
> +};
> +
> +static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> +
> +	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
> +	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
> +
> +	.phy_reset  = 1,
> +	.reset_gpio_port[0]  = -EINVAL,
> +	.reset_gpio_port[1]  = -EINVAL,
> +	.reset_gpio_port[2]  = -EINVAL,
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	/* mUSB */
> +	OMAP3_MUX(HSUSB0_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_STP, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(HSUSB0_DIR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_NXT, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* USB 1 */
> +	OMAP3_MUX(ETK_CTL, OMAP_MUX_MODE3 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(ETK_CLK, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D8, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D9, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(CAM_HS, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	/* McSPI 3 */
> +	OMAP3_MUX(ETK_D0, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D1, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(ETK_D2, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D3, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(ETK_D7, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D4, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(ETK_D5, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE3 | OMAP_PIN_INPUT),
> +	/* MMC 1 */
> +	OMAP3_MUX(SDMMC1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* GPIO */
> +	OMAP3_MUX(SDMMC1_DAT4, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT6, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SDMMC1_DAT7, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	/* McBSP 2 */
> +	OMAP3_MUX(MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	/* I2C 1 */
> +	OMAP3_MUX(I2C1_SCL, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(I2C1_SDA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* I2C 2 */
> +	OMAP3_MUX(I2C2_SCL, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(I2C2_SDA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* I2C 3 */
> +	OMAP3_MUX(I2C3_SCL, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(I2C3_SDA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* I2C 4 */
> +	OMAP3_MUX(I2C4_SCL, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(I2C4_SDA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(UART3_RTS_SD, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	/* UART 2 */
> +	OMAP3_MUX(MCBSP3_DX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP3_DR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	/* UART 1 */
> +	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* DSS */
> +	OMAP3_MUX(DSS_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_HSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_VSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_ACBIAS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA9, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA10, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA11, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA12, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA13, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA14, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA15, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	/* GPIO */
> +	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA20, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	/* McSPI 1 */
> +	OMAP3_MUX(MCSPI1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCSPI1_SIMO, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCSPI1_SOMI, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCSPI1_CS0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	/* HDQ */
> +	OMAP3_MUX(HDQ_SIO, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* McSPI 4 */
> +	OMAP3_MUX(MCBSP1_CLKR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	/* MMC 2 */
> +	OMAP3_MUX(SDMMC2_DAT4, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(SDMMC2_DAT5, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(SDMMC2_DAT6, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(SDMMC2_DAT7, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
> +	/* I2C3 */
> +	OMAP3_MUX(I2C3_SCL, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(I2C3_SDA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	/* GPIO */
> +	OMAP3_MUX(MCBSP1_FSR, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_NCS4, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_NCS6, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_NCS7, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_WAIT3, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_CLK, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	/* TPS IRQ */
> +	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_WAKEUP_EN | \
> +			OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(GPMC_A1, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_A2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_A3, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_A4, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_A5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_A6, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_A7, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(GPMC_A9, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(GPMC_A10, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#endif
> +
> +static void __init tricorder_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
> +	omap_serial_init();
> +	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> +			mt46h32m32lf6_sdrc_params);
> +
> +	tricorder_i2c_init();
> +	platform_add_devices(tricorder_devices,
> +			ARRAY_SIZE(tricorder_devices));
> +
> +	omap2_hsmmc_init(mmc);
> +
> +	usb_musb_init(NULL);
> +
> +	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, tricorder_nand_partitions,
> +				ARRAY_SIZE(tricorder_nand_partitions));
> +
> +	/* Ensure SDRC pins are mux'd for self-refresh */
> +	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> +}
> +
> +MACHINE_START(TRICORDER, "OMAP3 Tricorder")
> +	.atag_offset	= 0x100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap35xx_init_early,
> +	.init_irq	= omap3_init_irq,
> +	.handle_irq	= omap3_intc_handle_irq,
> +	.init_machine	= tricorder_init,
> +	.timer		=&omap3_secure_timer,
> +	.restart	= omap_prcm_restart,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index 6ee9049..1aa29a8 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -167,6 +167,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>   		DEBUG_LL_OMAP3(3, omap_ldp);
>   		DEBUG_LL_OMAP3(3, overo);
>   		DEBUG_LL_OMAP3(3, touchbook);
> +		DEBUG_LL_OMAP3(3, tricorder);
>
>   		/* omap4 based boards using UART3 */
>   		DEBUG_LL_OMAP4(3, omap_4430sdp);
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index fb1bf25..16377ab 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -127,7 +127,7 @@ config SND_OMAP_SOC_OMAP3_PANDORA
>   config SND_OMAP_SOC_OMAP3_BEAGLE
>   	tristate "SoC Audio support for OMAP3 Beagle and Devkit8000"
>   	depends on TWL4030_CORE&&  SND_OMAP_SOC
> -	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000)
> +	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000 || MACH_TRICORDER)
>   	select SND_OMAP_SOC_MCBSP
>   	select SND_SOC_TWL4030
>   	help
> diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
> index 3357dcc..963a9a4 100644
> --- a/sound/soc/omap/omap3beagle.c
> +++ b/sound/soc/omap/omap3beagle.c
> @@ -112,9 +112,11 @@ static int __init omap3beagle_soc_init(void)
>   {
>   	int ret;
>
> -	if (!(machine_is_omap3_beagle() || machine_is_devkit8000()))
> +	if (!(machine_is_omap3_beagle()
> +		|| machine_is_devkit8000()
> +		|| machine_is_tricorder()))
>   		return -ENODEV;
> -	pr_info("OMAP3 Beagle/Devkit8000 SoC init\n");
> +	pr_info("OMAP3 Beagle/Devkit8000/Tricorder SoC init\n");
>
>   	omap3beagle_snd_device = platform_device_alloc("soc-audio", -1);
>   	if (!omap3beagle_snd_device) {

