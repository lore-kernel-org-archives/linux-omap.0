From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] Add and build TPS6235x based PR785 board support
Date: Fri, 27 Feb 2009 08:54:11 -0800
Message-ID: <20090227165411.GA11594@atomide.com>
References: <1233723384-13212-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56893 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbZB0QyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 11:54:18 -0500
Content-Disposition: inline
In-Reply-To: <1233723384-13212-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: broonie@sirena.org.uk, linux-omap@vger.kernel.org

Hi

Few comments below.

* Manikandan Pillai <mani.pillai@ti.com> [090203 20:56]:
> Change in this patch include
> comments fix from David Brownell and Mark
> 
> Removed all the child registration functions for I2C controller
> 
> TPS6235x chip based PR785 power modules are from Texas Instruments
> for OMAP3 EVM boards. This patch supports the PR785 card
> and provides the driver support for the TPS devices.
> 
> For compilation, the LCD and MMC drivers are modified and will not
> work. Further patches will be provided for support of LCD and MMC
> with PR785 boards.
> 
> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig          |   11 ++++
>  arch/arm/mach-omap2/board-omap3evm.c |   84 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mmc-twl4030.c    |    4 +-
>  drivers/video/omap/lcd_omap3evm.c    |    6 ++
>  4 files changed, 104 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0a86a88..91890be 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -121,6 +121,17 @@ config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  
> +menu 	"PR785 Power board selection for OMAP3 EVM"
> +config OMAP3EVM_PR785
> +	bool "Power board for OMAP3 EVM"
> +	depends on I2C=y && ARCH_OMAP34XX
> +	help
> +	Say yes here if you are using the TPS6235x based PR785 Power Module
> +	for the EVM boards. This core driver provides register access and IRQ
> +	handling facilities, and registers devices for the various functions
> +	so that function-specific drivers can bind to them.
> +endmenu
> +
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index e4e60e2..4d8e836 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -36,11 +36,16 @@
>  #include <mach/usb-ehci.h>
>  #include <mach/common.h>
>  #include <mach/mcspi.h>
> +#include <mach/mux.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "twl4030-generic-scripts.h"
>  #include "mmc-twl4030.h"
> +#include <linux/regulator/machine.h>
>  
> +#if defined(CONFIG_OMAP3EVM_PR785) && defined(CONFIG_TWL4030_CORE)
> +#error config err : only one of OMAP3EVM_PR785 or TWL4030_CORE can be defined
> +#endif
>  
>  static struct resource omap3evm_smc911x_resources[] = {
>  	[0] =	{
> @@ -89,6 +94,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
>  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
> +#if defined(CONFIG_TWL4030_CORE)
>  static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
> @@ -150,11 +156,66 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
>  		.platform_data = &omap3evm_twldata,
>  	},
>  };
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +/* CORE voltage regulator */
> +struct regulator_consumer_supply tps62352_core_consumers = {
> +	.supply = "vdd2",
> +};
> +
> +/* MPU voltage regulator */
> +struct regulator_consumer_supply tps62352_mpu_consumers = {
> +	.supply = "vdd1",
> +};
> +
> +struct regulator_init_data vdd2_tps_regulator_data = {
> +		.constraints = {
> +			.min_uV = 750000,
> +			.max_uV = 1537000,
> +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +				REGULATOR_CHANGE_STATUS),
> +		},
> +		.num_consumer_supplies  = 1,
> +		.consumer_supplies      = &tps62352_core_consumers,
> +};
> +
> +struct regulator_init_data vdd1_tps_regulator_data = {
> +		.constraints = {
> +			.min_uV = 750000,
> +			.max_uV = 1537000,
> +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +				REGULATOR_CHANGE_STATUS),
> +		},
> +		.num_consumer_supplies  = 1,
> +		.consumer_supplies      = &tps62352_mpu_consumers,
> +};
> +
> +static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
> +	{
> +		I2C_BOARD_INFO("tps62352", 0x4A),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &vdd2_tps_regulator_data,
> +	},
> +	{
> +		I2C_BOARD_INFO("tps62353", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &vdd1_tps_regulator_data,
> +	},
> +};
> +#endif
>  
>  static int __init omap3_evm_i2c_init(void)
>  {
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
> +		ARRAY_SIZE(tps_6235x_i2c_board_info));
> +
> +#endif
> +#if defined(CONFIG_TWL4030_CORE)
>  	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
>  			ARRAY_SIZE(omap3evm_i2c_boardinfo));
> +#endif
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	omap_register_i2c_bus(3, 400, NULL, 0);
>  	return 0;
> @@ -233,6 +294,7 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
>  	&omap3evm_smc911x_device,
>  };

Let's leave out the ifdefs. There's nothing stopping us from
compiling kernels that work with both twl4030 and tps6235. And to
optimize out the code you could just have something like this:

#if defined(CONFIG_TWL4030_CORE) || defined(CONFIG_TWL4030_CORE_MODULE)

set_all_the_twl_stuff
...

#else
static inline int board_twl4030_init(void)
{
	return 0;
}
#endif

#if defined(CONFIG_TPS6235) || defined(CONFIG_TPS6235_MODULE)

set_all_the_tps_stuff
...

#else
static inline int board_tps6235_init(void)
{
	return 0;
}
#endif

Then in the omap3_evm_i2c_init() you would just try to register
both i2c chips, and use the one that's connected. The probe will will
fail for the one that's not connected.

> +#if defined(CONFIG_TPS)
>  static struct twl4030_hsmmc_info mmc[] __initdata = {
>  	{
>  		.mmc		= 1,
> @@ -242,6 +304,23 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
>  	},
>  	{}	/* Terminator */
>  };
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +static void omap_init_pr785(void)
> +{
> +	struct platform_device *pdev;
> +	/* Initialize the mux settings for PR785 power module board */
> +	if (cpu_is_omap343x()) {
> +		omap_cfg_reg(AF26_34XX_GPIO0);
> +		omap_cfg_reg(AF22_34XX_GPIO9);
> +		omap_cfg_reg(AF6_34XX_GPIO140_UP);
> +		omap_cfg_reg(AE6_34XX_GPIO141);
> +		omap_cfg_reg(AF5_34XX_GPIO142);
> +		omap_cfg_reg(AE5_34XX_GPIO143);
> +	}
> +}
> +#endif

The above you'd want to set after you've successfully probed for the tps
chip.
  
>  static void __init omap3_evm_init(void)
>  {
> @@ -255,7 +334,12 @@ static void __init omap3_evm_init(void)
>  				ARRAY_SIZE(omap3evm_spi_board_info));
>  
>  	omap_serial_init();
> +#if defined(CONFIG_TWL4030_CORE)
>  	twl4030_mmc_init(mmc);
> +#endif
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +	omap_init_pr785();
> +#endif
>  	usb_musb_init();
>  	usb_ehci_init();
>  	omap3evm_flash_init();
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 437f520..d907889 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -168,7 +168,7 @@ static int twl_mmc_resume(struct device *dev, int slot)
>   */
>  static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
>  {
> -	int ret;
> +	int ret = 0;
>  	u8 vmmc, dev_grp_val;
>  
>  	switch (1 << vdd) {
> @@ -223,6 +223,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
>  	else
>  		dev_grp_val = LDO_CLR;		/* Power down */
>  
> +#if defined(CONFIG_TWL4030_CORE)
>  	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>  					dev_grp_val, c->twl_vmmc_dev_grp);
>  	if (ret)
> @@ -231,6 +232,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
>  	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>  					vmmc, c->twl_mmc_dedicated);
>  
> +#endif
>  	return ret;
>  }
>  
> diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
> index 1c3d814..4f373b2 100644
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ b/drivers/video/omap/lcd_omap3evm.c
> @@ -66,9 +66,11 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
>  	gpio_direction_output(LCD_PANEL_LR, 1);
>  	gpio_direction_output(LCD_PANEL_UD, 1);
>  
> +#if defined(CONFIG_TWL4030_CORE)
>  	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> +#endif
>  	bklight_level = 100;
>  
>  	return 0;
> @@ -97,6 +99,7 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
>  static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
>  						unsigned int level)
>  {
> +#if defined(CONFIG_TWL4030_CORE)
>  	u8 c;
>  	if ((level >= 0) && (level <= 100)) {
>  		c = (125 * (100 - level)) / 100 + 2;
> @@ -104,6 +107,9 @@ static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
>  		bklight_level = level;
>  	}
>  	return 0;
> +#endif
> +	/* Fix this once patch fix is sent out for TPS-boards */
> +	return -1;
>  }
>  
>  static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)

You should separate out the driver related parts from this patch.

Regards,

Tony
