From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: Add support for the IGEP v2 board (rev
 B)
Date: Thu, 12 Nov 2009 14:36:32 -0800
Message-ID: <20091112223632.GH24837@atomide.com>
References: <70c9a9110910140132l863c6f9y208ad7dcfc6fd88e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50478 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbZKLWg3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 17:36:29 -0500
Content-Disposition: inline
In-Reply-To: <70c9a9110910140132l863c6f9y208ad7dcfc6fd88e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org

* Enric Balletb=F2 i Serra <eballetbo@gmail.com> [091014 01:48]:
> This patch adds minimal IGEP v2 support.
>=20
> The IGEP v2 board is a low-cost, fan-less and industrial temperature
> range single board computer that unleashes laptop-like performance an=
d
> expandability without the bulk, expense, or noise of typical desktop
> machines. Its architecture shares much in common with other OMAP3 boa=
rds.

Can you please refresh against the for-next branch in linux-omap and
repost?

Thanks,

Tony
=20
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>  arch/arm/mach-omap2/Kconfig          |    4 +
>  arch/arm/mach-omap2/Makefile         |    2 +
>  arch/arm/mach-omap2/board-igep0020.c |  252 ++++++++++++++++++++++++=
++++++++++
>  3 files changed, 258 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-igep0020.c
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 75b1c7e..9936510 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -85,6 +85,10 @@ config MACH_OMAP_ZOOM2
>  	bool "OMAP3 Zoom2 board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>=20
> +config MACH_IGEP0020
> +	bool "IGEP0020"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +
>  config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
>  	depends on ARCH_OMAP4
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 6b7702f..df0bdc4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -74,6 +74,8 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51.o \
>  obj-$(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom2.o \
>  					   mmc-twl4030.o \
>  					   board-zoom-debugboard.o
> +obj-$(CONFIG_MACH_IGEP0020)		+=3D board-igep0020.o \
> +					   mmc-twl4030.o \
>=20
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+=3D board-4430sdp.o
>=20
> diff --git a/arch/arm/mach-omap2/board-igep0020.c
> b/arch/arm/mach-omap2/board-igep0020.c
> new file mode 100644
> index 0000000..15175e0
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -0,0 +1,252 @@
> +/*
> + * Copyright (C) 2009 Integration Software and Electronic Engineerin=
g.
> + *
> + * Modified from mach-omap2/board-generic.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c/twl4030.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/common.h>
> +#include <mach/gpmc.h>
> +#include <mach/onenand.h>
> +#include <mach/usb.h>
> +
> +#include "mmc-twl4030.h"
> +
> +#define IGEP2_SMSC911X_CS       5
> +#define IGEP2_SMSC911X_GPIO     176
> +#define IGEP2_GPIO_LED_0_RED 	26
> +#define IGEP2_GPIO_LED_0_GREEN 	27
> +#define IGEP2_GPIO_LED_1_RED   	28
> +
> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> +
> +#include <linux/smsc911x.h>
> +
> +static struct resource igep2_smsc911x_resources[] =3D {
> +	{
> +		.name	=3D "smsc911x-memory",
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +	{
> +		.flags	=3D IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> +	},
> +};
> +
> +static struct smsc911x_platform_config igep2_smsc911x_config =3D {
> +	.irq_polarity	=3D SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +	.irq_type	=3D SMSC911X_IRQ_TYPE_OPEN_DRAIN,
> +	.flags		=3D SMSC911X_USE_32BIT ,
> +	.phy_interface	=3D PHY_INTERFACE_MODE_MII,
> +};
> +
> +static struct platform_device igep2_smsc911x_device =3D {
> +	.name		=3D "smsc911x",
> +	.id		=3D -1,
> +	.num_resources	=3D ARRAY_SIZE(igep2_smsc911x_resources),
> +	.resource	=3D igep2_smsc911x_resources,
> +	.dev		=3D {
> +		.platform_data =3D &igep2_smsc911x_config,
> +	},
> +};
> +
> +static inline void __init igep2_init_smsc911x(void)
> +{
> +	unsigned long cs_mem_base;
> +
> +	if (gpmc_cs_request(IGEP2_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
> +		pr_warning("igep2_init_smsc911x: "
> +			   "Failed request for GPMC mem\n");
> +		gpmc_cs_free(IGEP2_SMSC911X_CS);
> +		return;
> +	}
> +
> +	igep2_smsc911x_resources[0].start =3D cs_mem_base + 0x0;
> +	igep2_smsc911x_resources[0].end   =3D cs_mem_base + 0xff;
> +
> +	if ((gpio_request(IGEP2_SMSC911X_GPIO, "SMSC911X IRQ") =3D=3D 0) &&
> +	    (gpio_direction_input(IGEP2_SMSC911X_GPIO) =3D=3D 0)) {
> +		gpio_export(IGEP2_SMSC911X_GPIO, 0);
> +	} else {
> +		pr_warning("igep2_init_smsc911x: "
> +			   "Could not obtain gpio for IRQ\n");
> +		return;
> +	}
> +
> +	igep2_smsc911x_resources[1].start =3D OMAP_GPIO_IRQ(IGEP2_SMSC911X_=
GPIO);
> +	igep2_smsc911x_resources[1].end	  =3D 0;
> +
> +	platform_device_register(&igep2_smsc911x_device);
> +}
> +
> +#else
> +
> +static inline void __init igep2_init_smsc911x(void) { }
> +
> +#endif
> +
> +static struct omap_board_config_kernel igep2_config[] __initdata =3D=
 {
> +};
> +
> +static struct regulator_consumer_supply igep2_vmmc1_supply =3D {
> +	.supply		=3D "vmmc",
> +};
> +
> +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> +static struct regulator_init_data igep2_vmmc1 =3D {
> +	.constraints =3D {
> +		.min_uV			=3D 1850000,
> +		.max_uV			=3D 3150000,
> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		=3D REGULATOR_CHANGE_VOLTAGE
> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  =3D 1,
> +	.consumer_supplies      =3D &igep2_vmmc1_supply,
> +};
> +
> +static struct twl4030_hsmmc_info mmc[] __initdata =3D {
> +	{
> +		.mmc		=3D 1,
> +		.wires		=3D 4,
> +		.gpio_wp	=3D -EINVAL,
> +	},
> +	{
> +		.mmc		=3D 2,
> +		.wires		=3D 4,
> +		.gpio_cd	=3D -EINVAL,
> +		.gpio_wp	=3D -EINVAL,
> +	},
> +	{}      /* Terminator */
> +};
> +
> +static int igep2_twl_gpio_setup(struct device *dev,
> +		unsigned gpio, unsigned ngpio)
> +{
> +	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> +	mmc[0].gpio_cd =3D gpio + 0;
> +	twl4030_mmc_init(mmc);
> +
> +	/* link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	*/
> +	igep2_vmmc1_supply.dev =3D mmc[0].dev;
> +
> +	return 0;
> +};
> +
> +static struct twl4030_usb_data igep2_usb_data =3D {
> +	.usb_mode	=3D T2_USB_MODE_ULPI,
> +};
> +
> +static void __init igep2_init_irq(void)
> +{
> +	omap_board_config =3D igep2_config;
> +	omap_board_config_size =3D ARRAY_SIZE(igep2_config);
> +	omap2_init_common_hw(NULL, NULL);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +static struct twl4030_gpio_platform_data igep2_gpio_data =3D {
> +	.gpio_base	=3D OMAP_MAX_GPIO_LINES,
> +	.irq_base	=3D TWL4030_GPIO_IRQ_BASE,
> +	.irq_end	=3D TWL4030_GPIO_IRQ_END,
> +	.setup		=3D igep2_twl_gpio_setup,
> +};
> +
> +static struct twl4030_platform_data igep2_twldata =3D {
> +	.irq_base	=3D TWL4030_IRQ_BASE,
> +	.irq_end	=3D TWL4030_IRQ_END,
> +
> +	/* platform_data for children goes here */
> +	.usb		=3D &igep2_usb_data,
> +	.gpio		=3D &igep2_gpio_data,
> +	.vmmc1          =3D &igep2_vmmc1,
> +
> +};
> +
> +static struct i2c_board_info __initdata igep2_i2c_boardinfo[] =3D {
> +	{
> +		I2C_BOARD_INFO("twl4030", 0x48),
> +		.flags		=3D I2C_CLIENT_WAKE,
> +		.irq		=3D INT_34XX_SYS_NIRQ,
> +		.platform_data	=3D &igep2_twldata,
> +	},
> +};
> +
> +static int __init igep2_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
> +			ARRAY_SIZE(igep2_i2c_boardinfo));
> +	/* Bus 3 is attached to the DVI port where devices like the pico DL=
P
> +	 * projector don't work reliably with 400kHz */
> +	omap_register_i2c_bus(3, 100, NULL, 0);
> +	return 0;
> +}
> +
> +static void __init igep2_init(void)
> +{
> +	igep2_i2c_init();
> +	omap_serial_init();
> +	usb_musb_init();
> +
> +	igep2_init_smsc911x();
> +
> +	/* GPIO userspace leds */
> +	if ((gpio_request(IGEP2_GPIO_LED_0_RED, "GPIO_LED_0_RED") =3D=3D 0)=
 &&
> +	    (gpio_direction_output(IGEP2_GPIO_LED_0_RED, 1) =3D=3D 0)) {
> +		gpio_export(IGEP2_GPIO_LED_0_RED, 0);
> +		gpio_set_value(IGEP2_GPIO_LED_0_RED, 0);
> +	} else
> +		pr_warning("igep2_init: "
> +			   "Could not obtain gpio for GPIO_LED_0_RED\n");
> +
> +	if ((gpio_request(IGEP2_GPIO_LED_0_GREEN, "GPIO_LED_0_GREEN") =3D=3D=
 0) &&
> +	    (gpio_direction_output(IGEP2_GPIO_LED_0_GREEN, 1) =3D=3D 0)) {
> +		gpio_export(IGEP2_GPIO_LED_0_GREEN, 0);
> +		gpio_set_value(IGEP2_GPIO_LED_0_GREEN, 0);
> +	} else
> +		pr_warning("igep2_init: "
> +			   "Could not obtain gpio for GPIO_LED_0_GREEN\n");
> +
> +	if ((gpio_request(IGEP2_GPIO_LED_1_RED, "GPIO_LED_1_RED") =3D=3D 0)=
 &&
> +	    (gpio_direction_output(IGEP2_GPIO_LED_1_RED, 1) =3D=3D 0)) {
> +		gpio_export(IGEP2_GPIO_LED_1_RED, 0);
> +		gpio_set_value(IGEP2_GPIO_LED_1_RED, 0);
> +	} else
> +		pr_warning("igep2_init: "
> +			   "Could not obtain gpio for GPIO_LED_1_RED\n");
> +}
> +
> +static void __init igep2_map_io(void)
> +{
> +	omap2_set_globals_343x();
> +	omap2_map_common_io();
> +}
> +
> +MACHINE_START(IGEP0020, "IGEP v2 board")
> +	.phys_io	=3D 0x48000000,
> +	.io_pg_offst	=3D ((0xfa000000) >> 18) & 0xfffc,
> +	.boot_params	=3D 0x80000100,
> +	.map_io		=3D igep2_map_io,
> +	.init_irq	=3D igep2_init_irq,
> +	.init_machine	=3D igep2_init,
> +	.timer		=3D &omap_timer,
> +MACHINE_END
> --=20
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
