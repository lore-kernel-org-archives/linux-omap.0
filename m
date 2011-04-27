From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 2/2] Add basic devices support for Nook Color
Date: Wed, 27 Apr 2011 11:49:33 +0300
Message-ID: <4DB7D89D.7090707@compulab.co.il>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru> <1303869133-27976-3-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:54081
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755129Ab1D0ImP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 04:42:15 -0400
In-Reply-To: <1303869133-27976-3-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org

On 04/27/11 04:52, green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> MMC/SD interface, i2c, usb.

You should have added these at the first patch instead of Android devices.

> ---
>  arch/arm/configs/encore-nookcolor-defconfig | 2015 +++++++++++++++++++++++++++

The defconfig should be a separate patch. You should rather add encore board
options to omap2plus_defconfig.

>  arch/arm/mach-omap2/Makefile                |    3 +-
>  arch/arm/mach-omap2/board-omap3encore.c     |  325 +++++-
>  drivers/mfd/twl-core.c                      |    6 +

The TWL updates should be in a separate patch

>  4 files changed, 2343 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/configs/encore-nookcolor-defconfig

[ snip ]

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 207f372..b894777 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -189,7 +189,8 @@ obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o \
>  					   hsmmc.o
> -obj-$(CONFIG_MACH_ENCORE)               += board-omap3encore.o
> +obj-$(CONFIG_MACH_ENCORE)		+= board-omap3encore.o \
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
> index 9a00d6b..055549b 100644
> --- a/arch/arm/mach-omap2/board-omap3encore.c
> +++ b/arch/arm/mach-omap2/board-omap3encore.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  
>  #include <linux/spi/spi.h>
> +#include <linux/i2c/twl.h>
>  #include <linux/interrupt.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
> @@ -33,6 +34,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <linux/mmc/host.h>
>  
>  #include <plat/mcspi.h>
>  #include <mach/gpio.h>
> @@ -48,21 +50,80 @@
>  #include <plat/sram.h>
>  
>  #include <plat/display.h>
> +#include <plat/mmc.h>
>  #include <plat/omap-serial.h>
>  
>  #include <plat/system.h>
>  
>  #include "mux.h"
> +#include "hsmmc.h"
>  #include "prcm-common.h"
>  
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
>  
>  #include <media/v4l2-int-device.h>
>  
> +#ifndef CONFIG_TWL4030_CORE
> +#error "no power companion board defined!"
> +#endif
> +

Board should boot even when CONFIG_TWL4030_CORE is not defined, so drop it.

>  #ifdef CONFIG_ANDROID_RAM_CONSOLE
>  #include <linux/bootmem.h>
>  #endif
>  
> +static int encore_twl4030_keymap[] = {
> +	KEY(0, 0, KEY_HOME),
> +	KEY(0, 1, KEY_VOLUMEUP),
> +	KEY(0, 2, KEY_VOLUMEDOWN),
> +	0
> +};
> +
> +static struct matrix_keymap_data encore_twl4030_keymap_data = {
> +	.keymap			= encore_twl4030_keymap,
> +	.keymap_size	= ARRAY_SIZE(encore_twl4030_keymap),
> +};
> +
> +static struct twl4030_keypad_data encore_kp_twl4030_data = {
> +	.rows			= 8,
> +	.cols			= 8,
> +	.keymap_data		= &encore_twl4030_keymap_data,
> +	.rep			= 1,
> +};
> +
> +// HOME key code for HW > EVT2A

no C++ comments

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
> +//	.rep		= 1,		/* auto-repeat */

ditto

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
> +#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)

why is t2_out needed here?

> +
>  /* Use address that is most likely unused and untouched by u-boot */
>  #define ENCORE_RAM_CONSOLE_START 0x8e000000
>  #define ENCORE_RAM_CONSOLE_SIZE (0x20000)
> @@ -84,20 +145,262 @@ static struct platform_device encore_ram_console_device = {
>  
>  static struct platform_device *encore_devices[] __initdata = {
>  	&encore_ram_console_device,
> +	&encore_keys_gpio,
>  };
>  
>  static void __init omap_encore_init_early(void)
>  {
> -printk("in early ini\n");
>  	omap2_init_common_infrastructure();
>  	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
>  				  h8mbx00u0mer0em_sdrc_params);
>  #ifdef CONFIG_ANDROID_RAM_CONSOLE
>  	reserve_bootmem(ENCORE_RAM_CONSOLE_START, ENCORE_RAM_CONSOLE_SIZE, 0);
>  #endif /* CONFIG_ANDROID_RAM_CONSOLE */
> -printk("done early ini\n");
>  }
>  
> +static struct twl4030_usb_data encore_usb_data = {
> +      .usb_mode	= T2_USB_MODE_ULPI,
> +};
> +
> +static struct regulator_consumer_supply encore_vmmc1_supply = {
> +	.supply		= "vmmc",
> +};
> +
> +static struct regulator_consumer_supply encore_vsim_supply = {
> +	.supply		= "vmmc_aux",
> +};
> +
> +static struct regulator_consumer_supply encore_vmmc2_supply = {
> +	.supply		= "vmmc",
> +};
> +
> +static struct regulator_consumer_supply encore_vdda_dac_supply = {
> +	.supply		= "vdda_dac",
> +};
> +
> +static struct regulator_consumer_supply encore_vdds_dsi_supply = {
> +	.supply		= "vdds_dsi",
> +};
> +
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
> +/* VMMC2 for MMC2 card */
> +static struct regulator_init_data encore_vmmc2 = {
> +	.constraints = {
> +		.min_uV			= 1850000,
> +		.max_uV			= 1850000,
> +		.apply_uV		= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &encore_vmmc2_supply,
> +};
> +
> +/* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
> +static struct regulator_init_data encore_vsim = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 3000000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &encore_vsim_supply,
> +};
> +
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
> +static struct regulator_init_data encore_vdsi = {
> +	.constraints = {
> +		.min_uV                 = 1800000,
> +		.max_uV                 = 1800000,
> +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &encore_vdds_dsi_supply,
> +};
> +
> +/* The order is reverted in this table so that internal eMMC is presented
> + * as first mmc card for compatibility with existing android installations */
> +static struct omap2_hsmmc_info mmc[] __initdata = {
> +	{
> +		.name		= "internal",
> +		.mmc		= 2,
> +		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +		.nonremovable	= true,
> +		.power_saving	= true,
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
> +	/* Encore board EVT2 and later has pin high when card is present) */
> +	return gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> +}
> +
> +static int encore_twl4030_hsmmc_late_init(struct device *dev)
> +{
> +        int ret = 0;
> +        struct platform_device *pdev = container_of(dev,
> +                                struct platform_device, dev);
> +        struct omap_mmc_platform_data *pdata = dev->platform_data;
> +
> +	if(is_encore_board_evt2()) {
> +		/* Setting MMC1 (external) Card detect */
> +		if (pdev->id == 0) {
> +			pdata->slots[0].card_detect = encore_hsmmc_card_detect;
> +		}
> +	}
> +        return ret;
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
>
> +static int __ref encore_twl_gpio_setup(struct device *dev,
> +		unsigned gpio, unsigned ngpio)
> +{
> +	struct omap2_hsmmc_info *c;
> +	/* gpio + 0 is "mmc0_cd" (input/IRQ),
> +	 * gpio + 1 is "mmc1_cd" (input/IRQ)
> +	 */

please fix the comment style

> +printk("******IN boxer_twl_gpio_setup********\n");

please remove the printk

> +	mmc[1].gpio_cd = gpio + 0;
> +	mmc[0].gpio_cd = gpio + 1;
> +	omap2_hsmmc_init(mmc);
> +	for (c = mmc; c->mmc; c++)
> +                encore_hsmmc_set_late_init(c->dev);
> +
> +	/* link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	*/

please fix the comment style

> +	encore_vmmc1_supply.dev = mmc[1].dev;
> +	encore_vsim_supply.dev = mmc[1].dev;
> +	encore_vmmc2_supply.dev = mmc[0].dev;
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
> +	/* platform_data for children goes here */
> +	.madc		= &encore_madc_data,
> +	.usb		= &encore_usb_data,
> +	.gpio		= &encore_gpio_data,
> +	.keypad		= &encore_kp_twl4030_data,
> +	.vmmc1		= &encore_vmmc1,
> +	.vmmc2		= &encore_vmmc2,
> +	.vsim		= &encore_vsim,
> +	.vdac		= &encore_vdac,
> +	.vpll2		= &encore_vdsi,
> +};
> +
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
> +
> +static struct omap_musb_board_data musb_board_data = {
> +	.interface_type		= MUSB_INTERFACE_ULPI,
> +#ifdef CONFIG_USB_MUSB_OTG
> +	.mode			= MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +	.mode			= MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> +	.mode			= MUSB_PERIPHERAL,
> +#endif

This kind of ifdefery is handled inside the musb driver. I'd set the mode to
MUSB_OTG unless you want to explicitly limit it to HOST or PERIPHERAL

> +	.power			= 100,
> +};
> +
> +
>  #if defined(CONFIG_USB_ANDROID) || defined(CONFIG_USB_ANDROID_MODULE)
>  static struct usb_mass_storage_platform_data mass_storage_pdata = {
>  	.vendor = "B&N     ",
> @@ -125,20 +428,32 @@ static struct omap_board_mux board_mux[] __initdata = {
>  static struct omap_board_config_kernel encore_config[] __initdata = {
>  };
>  
> +static int __init omap_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 100, encore_i2c_bus1_info,
> +			ARRAY_SIZE(encore_i2c_bus1_info));
> +	omap_register_i2c_bus(2, 400, encore_i2c_bus2_info,
> +			ARRAY_SIZE(encore_i2c_bus2_info));
> +	return 0;
> +}
> +
>  static void __init omap_encore_init(void)
>  {
> -printk("in encore init\n");
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	omap_i2c_init();
>  	omap_serial_init();
> +	usb_musb_init(&musb_board_data);
>  
>  	omap_board_config = encore_config;
>  	omap_board_config_size = ARRAY_SIZE(encore_config);
>  
>  	platform_add_devices(encore_devices, ARRAY_SIZE(encore_devices));
>  
> -        BUG_ON(!cpu_is_omap3630());
> +#if defined(CONFIG_USB_ANDROID) || defined(CONFIG_USB_ANDROID_MODULE)
> +	platform_device_register(&usb_mass_storage_device);
> +#endif

Please remove Android devices

> -printk("done encore init\n");
> +        BUG_ON(!cpu_is_omap3630());
>  }
>  
>  MACHINE_START(ENCORE, "encore")
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 960b5be..7df5185 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -223,6 +223,7 @@
>  #define TPS_SUBSET		BIT(1)	/* tps659[23]0 have fewer LDOs */
>  #define TWL5031			BIT(2)  /* twl5031 has different registers */
>  #define TWL6030_CLASS		BIT(3)	/* TWL6030 class */
> +#define TPS_65921		BIT(4)	/* w/o vmmc2 */
>  
>  /*----------------------------------------------------------------------*/
>  
> @@ -813,7 +814,11 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
>  		child = add_regulator(TWL4030_REG_VSIM, pdata->vsim);
>  		if (IS_ERR(child))
>  			return PTR_ERR(child);
> +	}
>  
> +	/* maybe add some more LDOs that are omitted on cost-reduced parts */
> +	if (twl_has_regulator() && !(features & TPS_SUBSET|TPS_65921)
> +	  && twl_class_is_4030()) {
>  		child = add_regulator(TWL4030_REG_VAUX1, pdata->vaux1);
>  		if (IS_ERR(child))
>  			return PTR_ERR(child);
> @@ -1107,6 +1112,7 @@ static const struct i2c_device_id twl_ids[] = {
>  	{ "tps65950", 0 },		/* catalog version of twl5030 */
>  	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
>  	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
> +	{ "tps65921", TPS_65921 },	/* No aux devices: vibrator & led */
>  	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
>  	{ /* end of list */ },
>  };


-- 
Sincerely yours,
Mike.
