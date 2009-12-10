From: Daniel Toussaint <daniel@dmhome.net>
Subject: Re: [PATCH] Initial support for OMAP3 Thunder board
Date: Thu, 10 Dec 2009 23:30:20 +0100
Message-ID: <6cb69d4a0912101430l2555db33y8c56f7f75a1f9dd@mail.gmail.com>
References: <4B21593C.9060409@dmhome.net> <20091210204821.GV24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36878 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761971AbZLJWaS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 17:30:18 -0500
Received: by bwz27 with SMTP id 27so245709bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 14:30:22 -0800 (PST)
In-Reply-To: <20091210204821.GV24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
> Cool. Can you please split the the patches into following
> separate patches:
>
> 1. Add minimal board support
> 2. Add defconfig
> 3. Add ASoC support
> 4. Add DSS2 support

Ok, so can the DSS2 related stuff be ifdef-ed in the board file ,or
does it have to be completely seperated ?
Thanks

> Then please run all the patches through scripts/checkpatch.pl --stric=
t
> and fix the errors and warnings.
>
> And please make sure things keep compiling through the
> all the patches, otherwise git bisect will break.
>
> Cheers,
>
> Tony
>
>
>> /Signed-off-by Daniel Toussaint <daniel@dmhome.net>
>>
>>
>> ///
>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconf=
ig
>> index 16c0c13..e5493a5 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -151,6 +151,11 @@ config MACH_OMAP_4430SDP
>> =A0 =A0 =A0 bool "OMAP 4430 SDP board"
>> =A0 =A0 =A0 depends on ARCH_OMAP4
>>
>> +config MACH_OMAP3_THUNDER
>> + =A0 =A0 bool "Thunder OMAP3530 board"
>> + =A0 =A0 depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> + =A0 =A0 =A0select OMAP_PACKAGE_CUS
>> +
>> =A0config OMAP3_EMU
>> =A0 =A0 =A0 bool "OMAP3 debugging peripherals"
>> =A0 =A0 =A0 depends on ARCH_OMAP3
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 0c5d886..bd76499 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -105,6 +105,9 @@ obj-$(CONFIG_MACH_OMAP_4430SDP) =A0 =A0 =A0 =A0 =
=A0 +=3D board-4430sdp.o
>>
>> =A0obj-$(CONFIG_MACH_OMAP3517EVM) =A0 =A0 +=3D board-am3517evm.o
>>
>> +obj-$(CONFIG_MACH_OMAP3_THUNDER) =A0 =A0 =A0 =A0 +=3D board-omap3th=
under.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc-twl4030.o
>> +
>> =A0# Platform specific device init code
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+=3D usb-musb.o
>> =A0obj-$(CONFIG_MACH_OMAP2_TUSB6010) =A0 =A0+=3D usb-tusb6010.o
>> diff --git a/arch/arm/mach-omap2/board-omap3thunder.c b/arch/arm/mac=
h-omap2/board-omap3thunder.c
>> new file mode 100644
>> index 0000000..d6ea9de
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-omap3thunder.c
>> @@ -0,0 +1,647 @@
>> +/*
>> + * linux/arch/arm/mach-omap2/board-omap3touchbook.c
>> + *
>> + * Copyright (C) 2009 Technexion
>> + *
>> + * Modified from mach-omap2/board-omap3beagleboard.c
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/leds.h>
>> +#include <linux/gpio.h>
>> +#include <linux/input.h>
>> +#include <linux/gpio_keys.h>
>> +
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mtd/nand.h>
>> +
>> +#include <linux/regulator/machine.h>
>> +#include <linux/i2c/twl4030.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/map.h>
>> +#include <asm/mach/flash.h>
>> +
>> +#include <plat/board.h>
>> +#include <plat/usb.h>
>> +#include <linux/usb/otg.h>
>> +#include <plat/common.h>
>> +#include <plat/gpmc.h>
>> +#include <plat/nand.h>
>> +#include <plat/mux.h>
>> +#include <plat/display.h>
>> +
>> +#include "mmc-twl4030.h"
>> +#include "mux.h"
>> +
>> +
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/ads7846.h>
>> +#include <plat/mcspi.h>
>> +
>> +#include <plat/mmc.h>
>> +
>> +
>> +#define OMAP3_THUNDER_TS_GPIO =A0 =A0 =A0 =A0136
>> +
>> +#define GPMC_CS0_BASE =A00x60
>> +#define GPMC_CS_SIZE =A0 0x30
>> +
>> +#define NAND_BLOCK_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0SZ_128K
>> +
>> +#define THUNDER_DVI_PANEL_EN_GPIO 199 /* GPIO 7 on TWL4030 */
>> +#define THUNDER_LCD_PANEL_ENVDD 138
>> +#define THUNDER_LCD_PON 139
>> +
>> +#define TWL_INTBR_GPBR1 0x0c
>> +#define TWL_INTBR_PMBR1 0x0d
>> +#define TWL_PWM0_ON =A0 =A00x00
>> +#define TWL_PWM0_OFF =A0 0x01
>> +
>> +static int lcd_enabled;
>> +static int dvi_enabled;
>> +
>> +static void __init thunder_display_init(void)
>> +{
>> + =A0 =A0 gpio_request(THUNDER_LCD_PANEL_ENVDD, "lcd_panel_envdd");
>> + =A0 =A0 gpio_request(THUNDER_LCD_PON, "lcd_panel_pon");
>> + =A0 =A0 gpio_direction_output(THUNDER_LCD_PON, 1);
>> + =A0 =A0 gpio_direction_output(THUNDER_LCD_PANEL_ENVDD, 0);
>> + =A0 =A0 return;
>> +}
>> +
>> +static int thunder_enable_lcd(struct omap_dss_device *dssdev)
>> +{
>> +
>> + =A0 =A0 if (dvi_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "cannot enable LCD, DVI is=
 enabled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 gpio_set_value(THUNDER_LCD_PANEL_ENVDD, 0);
>> + =A0 =A0 gpio_set_value(THUNDER_LCD_PON, 1);
>> +
>> + =A0 =A0 /* This turns on the backlight, move this to backlight cod=
e later */
>> + =A0 =A0 twl4030_i2c_write_u8(TWL4030_MODULE_PWM0, 0x81, TWL_PWM0_O=
N);
>> + =A0 =A0 =A0 =A0twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, 0x04, TW=
L_INTBR_PMBR1);
>> + =A0 =A0 =A0 =A0twl4030_i2c_write_u8(TWL4030_MODULE_PWM0, 6 + 40 , =
TWL_PWM0_OFF);
>> + =A0 =A0 =A0 =A0twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, 0x05, TW=
L_INTBR_GPBR1);
>> + =A0 =A0 twl4030_i2c_write_u8(TWL4030_MODULE_PWM0, 6 + 50 , TWL_PWM=
0_OFF);
>> + =A0 =A0 /* End of turning on Backlight */
>> +
>> + =A0 =A0 lcd_enabled =3D 1;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void thunder_disable_lcd(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 gpio_set_value(THUNDER_LCD_PANEL_ENVDD, 1);
>> + =A0 =A0 gpio_set_value(THUNDER_LCD_PON, 0);
>> + =A0 =A0 lcd_enabled =3D 0;
>> +}
>> +
>> +
>> +static int thunder_set_backlight ( struct omap_dss_device *dssdev, =
int level)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int thunder_get_backlight ( struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 return 10;
>> +}
>> +
>> +
>> +static struct omap_dss_device thunder_lcd_device =3D {
>> + =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP_DISPLAY=
_TYPE_DPI,
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "lcd",
>> + =A0 =A0 .driver_name =A0 =A0 =A0 =A0 =A0 =A0=3D "panel-lg-lb043wq2=
",
>> + =A0 =A0 .phy.dpi.data_lines =A0 =A0 =3D 24,
>> + =A0 =A0 .platform_enable =A0 =A0 =A0 =A0=3D thunder_enable_lcd,
>> + =A0 =A0 .platform_disable =A0 =A0 =A0 =3D thunder_disable_lcd,
>> +
>> + =A0 =A0 .get_backlight =A0 =A0 =A0 =A0 =A0=3D thunder_get_backligh=
t,
>> + =A0 =A0 .set_backlight =A0 =A0 =A0 =A0 =A0=3D thunder_set_backligh=
t,
>> + =A0 =A0 .max_backlight_level =A0 =A0=3D 100,
>> +};
>> +
>> +static int thunder_enable_dvi(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 if (lcd_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "cannot enable DVI, LCD is=
 enabled\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 gpio_set_value(THUNDER_DVI_PANEL_EN_GPIO, 1);
>> + =A0 =A0 dvi_enabled =3D 1;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void thunder_disable_dvi(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 gpio_set_value(THUNDER_DVI_PANEL_EN_GPIO, 0);
>> + =A0 =A0 dvi_enabled =3D 0;
>> +}
>> +
>> +static struct omap_dss_device thunder_dvi_device =3D {
>> + =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP_DISPLAY=
_TYPE_DPI,
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "dvi",
>> + =A0 =A0 .driver_name =A0 =A0 =A0 =A0 =A0 =A0=3D "generic_panel",
>> + =A0 =A0 .phy.dpi.data_lines =A0 =A0 =3D 24,
>> + =A0 =A0 .platform_enable =A0 =A0 =A0 =A0=3D thunder_enable_dvi,
>> + =A0 =A0 .platform_disable =A0 =A0 =A0 =3D thunder_disable_dvi,
>> +};
>> +
>> +static struct omap_dss_device *thunder_dss_devices[] =3D {
>> + =A0 =A0 &thunder_lcd_device,
>> + =A0 =A0 &thunder_dvi_device,
>> +};
>> +
>> +static struct omap_dss_board_info thunder_dss_data =3D {
>> + =A0 =A0 .num_devices =A0 =A0=3D ARRAY_SIZE(thunder_dss_devices),
>> + =A0 =A0 .devices =A0 =A0 =A0 =A0=3D thunder_dss_devices,
>> + =A0 =A0 .default_device =3D &thunder_lcd_device,
>> +};
>> +
>> +static struct platform_device thunder_dss_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omapdss",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &thunder_dss_data,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct regulator_consumer_supply thunder_vdds_dsi_supply =3D=
 {
>> + =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vdds_dsi",
>> + =A0 =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0=3D &thunder_dss_device=
=2Edev,
>> +};
>> +
>> +static struct mtd_partition omap3thunder_nand_partitions[] =3D {
>> + =A0 =A0 /* All the partition sizes are listed in terms of NAND blo=
ck size */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * NAND_BLO=
CK_SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x80000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 15 * NAND_BL=
OCK_SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot Env"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x260000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1 * NAND_BLO=
CK_SIZE,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x280000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 32 * NAND_BL=
OCK_SIZE,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File System=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x680000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_SIZ_=
=46ULL,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_nand_platform_data omap3thunder_nand_data =3D {
>> + =A0 =A0 .options =A0 =A0 =A0 =A0=3D NAND_BUSWIDTH_16,
>> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D omap3thunder_nand_partitions=
,
>> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(omap3thunder_nand_par=
titions),
>> + =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disable=
 DMA in OMAP NAND driver */
>> + =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
>> + =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
>> +};
>> +
>> +static struct resource omap3thunder_nand_resource =3D {
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
>> +};
>> +
>> +static struct platform_device omap3thunder_nand_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &omap3thunder_nand_d=
ata,
>> + =A0 =A0 },
>> + =A0 =A0 .num_resources =A0=3D 1,
>> + =A0 =A0 .resource =A0 =A0 =A0 =3D &omap3thunder_nand_resource,
>> +};
>> +
>> +#include "sdram-micron-mt46h32m32lf-6.h"
>> +
>> +static struct omap_uart_config omap3_thunder_uart_config __initdata=
 =3D {
>> + =A0 =A0 .enabled_uarts =A0=3D ((1 << 0) | (1 << 1) | (1 << 2)),
>> +};
>> +
>> +static struct twl4030_usb_data thunder_usb_data =3D {
>> + =A0 =A0 .usb_mode =A0 =A0 =A0 =3D T2_USB_MODE_ULPI,
>> +};
>> +
>> +static struct twl4030_hsmmc_info mmc[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D 29,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
>> +
>> + =A0 =A0 },
>> + =A0 =A0 {} =A0 =A0 =A0/* Terminator */
>> +};
>> +
>> +static struct regulator_consumer_supply thunder_vmmc1_supply =3D {
>> + =A0 =A0 .supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc",
>> +};
>> +
>> +static struct regulator_consumer_supply thunder_vmmc2_supply =3D {
>> + =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc",
>> +};
>> +
>> +
>> +static struct regulator_consumer_supply thunder_vsim_supply =3D {
>> + =A0 =A0 .supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc_aux",
>> +};
>> +
>> +static struct gpio_led gpio_leds[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "thunderboard::usr0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .default_trigger =A0 =A0 =A0 =A0=3D "heart=
beat",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D -EINVAL, =A0 =A0 =A0/* gets replaced */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .active_low =A0 =A0 =A0 =A0 =A0 =A0 =3D tr=
ue,
>> + =A0 =A0 },
>> +};
>> +
>> +static int thunder_twl_gpio_setup(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned gpio, unsigned ngpio)
>> +{
>> + =A0 =A0 omap_mux_init_gpio(29,OMAP_PIN_INPUT);
>> + =A0 =A0 mmc[0].gpio_cd =3D gpio + 0;
>> + =A0 =A0 twl4030_mmc_init(mmc);
>> +
>> + =A0 =A0 /* link regulators to MMC adapters */
>> + =A0 =A0 thunder_vmmc1_supply.dev =3D mmc[0].dev;
>> + =A0 =A0 thunder_vmmc2_supply.dev =3D mmc[1].dev;
>> + =A0 =A0 thunder_vsim_supply.dev =3D mmc[0].dev;
>> +
>> + =A0 =A0 /* the LED marked LED 2 (LEDA) */
>> + =A0 =A0 gpio_leds[0].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
>> +
>> + =A0 =A0 /* gpio + 7 =3D=3D DVI Enable */
>> + =A0 =A0 =A0 =A0gpio_request(gpio + 7, "EN_DVI");
>> + =A0 =A0 =A0 =A0gpio_direction_output(gpio + 7, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct twl4030_gpio_platform_data thunder_gpio_data =3D {
>> + =A0 =A0 .gpio_base =A0 =A0 =A0=3D OMAP_MAX_GPIO_LINES,
>> + =A0 =A0 .irq_base =A0 =A0 =A0 =3D TWL4030_GPIO_IRQ_BASE,
>> + =A0 =A0 .irq_end =A0 =A0 =A0 =A0=3D TWL4030_GPIO_IRQ_END,
>> + =A0 =A0 .use_leds =A0 =A0 =A0 =3D false,
>> + =A0 =A0 .pullups =A0 =A0 =A0 =A0=3D BIT(1),
>> + =A0 =A0 .pulldowns =A0 =A0 =A0=3D BIT(2) | BIT(6) | BIT(7) | BIT(8=
) | BIT(13)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | BIT(15) =
| BIT(16) | BIT(17),
>> + =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D thunder_twl_gpio_setup,
>> +};
>> +
>> +
>> +/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=3D=
 max 220 mA) */
>> +static struct regulator_init_data thunder_vmmc1 =3D {
>> + =A0 =A0 .constraints =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1850000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 3150000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REGULA=
TOR_CHANGE_VOLTAGE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_CHANGE_STATUS,
>> + =A0 =A0 },
>> + =A0 =A0 .num_consumer_supplies =A0=3D 1,
>> + =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &thunder_vmmc1_supply,
>> +};
>> +
>> +
>> +static struct regulator_init_data thunder_vmmc2 =3D {
>> + =A0 =A0 =A0 =A0.constraints =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =3D 1850000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 3150000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D true,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D R=
EGULATOR_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =A0 =A0 =3D=
 REGULATOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| REGULATOR_CHANGE_STATUS,
>> + =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 =A0.num_consumer_supplies =A0=3D 1,
>> + =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0=3D &thunder_vmmc2_su=
pply,
>> +};
>> +
>> +/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card =3D=3D max 50 mA)=
 */
>> +static struct regulator_init_data thunder_vsim =3D {
>> + =A0 =A0 .constraints =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1800000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 3000000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REGULA=
TOR_CHANGE_VOLTAGE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_CHANGE_STATUS,
>> + =A0 =A0 },
>> + =A0 =A0 .num_consumer_supplies =A0=3D 1,
>> + =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &thunder_vsim_supply,
>> +};
>> +
>> +static struct regulator_consumer_supply thunder_vdda_dac_supply =3D=
 {
>> + =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vdda_dac",
>> + =A0 =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0=3D &thunder_dss_device=
=2Edev,
>> +};
>> +
>> +
>> +/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
>> +static struct regulator_init_data thunder_vdac =3D {
>> + =A0 =A0.constraints =3D {
>> + =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =3D 1800000,
>> + =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =3D 1800000,
>> + =A0 =A0 =A0 =A0.apply_uV =A0 =A0 =A0 =3D true,
>> + =A0 =A0 =A0 =A0.valid_modes_mask =A0 =3D REGULATOR_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =3D REGULATOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_CHANGE_STATUS,
>> + =A0 =A0},
>> + =A0 =A0.num_consumer_supplies =A0=3D 1,
>> + =A0 =A0.consumer_supplies =A0=3D &thunder_vdda_dac_supply,
>> +};
>> +
>> +/* VPLL2 for digital video outputs */
>> +static struct regulator_init_data thunder_vpll2 =3D {
>> + =A0 =A0.constraints =3D {
>> + =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "VDVI",
>> + =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =3D 1800000,
>> + =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =3D 1800000,
>> + =A0 =A0 .valid_modes_mask =A0 =3D REGULATOR_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =3D REGULATOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_CHANGE_STATUS,
>> + =A0 =A0},
>> + =A0 =A0.num_consumer_supplies =A0=3D 1,
>> + =A0 =A0.consumer_supplies =A0=3D &thunder_vdds_dsi_supply,
>> +};
>> +
>> +
>> +
>> +static struct twl4030_platform_data thunder_twldata =3D {
>> + =A0 =A0 .irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
>> + =A0 =A0 .irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
>> +
>> + =A0 =A0 /* platform_data for children goes here */
>> + =A0 =A0 .usb =A0 =A0 =A0 =A0 =A0 =A0=3D &thunder_usb_data,
>> + =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =3D &thunder_gpio_data,
>> + =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &thunder_vmmc1,
>> + =A0 =A0 .vmmc2 =A0 =A0 =A0 =A0 =A0=3D &thunder_vmmc2,
>> + =A0 =A0 .vsim =A0 =A0 =A0 =A0 =A0 =3D &thunder_vsim,
>> + =A0 =A0 .vdac =A0 =A0 =A0 =A0 =A0 =3D &thunder_vdac,
>> + =A0 =A0 .vpll2 =A0 =A0 =A0 =A0 =A0=3D &thunder_vpll2,
>> +};
>> +
>> +static struct i2c_board_info __initdata thunder_i2c_boardinfo[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 I2C_BOARD_INFO("twl4030", 0x48),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D I2C_CLIENT_WAKE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .irq =3D INT_34XX_SYS_NIRQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &thunder_twldata,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap3_thunder_i2c_init(void)
>> +{
>> + =A0 =A0 omap_register_i2c_bus(1, 2600, thunder_i2c_boardinfo, ARRA=
Y_SIZE(thunder_i2c_boardinfo));
>> + =A0 =A0 omap_register_i2c_bus(2, 100,NULL, 0);
>> + =A0 =A0 omap_register_i2c_bus(3, 100, NULL, 0);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void __init omap3_thunder_init_irq(void)
>> +{
>> + =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, mt46h32m32=
lf6_sdrc_params);
>> + =A0 =A0 omap_init_irq();
>> + =A0 =A0 omap_gpio_init();
>> +}
>> +
>> +static struct gpio_led_platform_data gpio_led_info =3D {
>> + =A0 =A0 .leds =A0 =A0 =A0 =A0 =A0 =3D gpio_leds,
>> + =A0 =A0 .num_leds =A0 =A0 =A0 =3D ARRAY_SIZE(gpio_leds),
>> +};
>> +
>> +static struct platform_device leds_gpio =3D {
>> + =A0 =A0 .name =A0 =3D "leds-gpio",
>> + =A0 =A0 .id =A0 =A0 =3D -1,
>> + =A0 =A0 .dev =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &gpio_led_info,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct gpio_keys_button gpio_buttons[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .code =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D BTN_EXTRA,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 7,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "user",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wakeup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct gpio_keys_platform_data gpio_key_info =3D {
>> + =A0 =A0 .buttons =A0 =A0 =A0 =A0=3D gpio_buttons,
>> + =A0 =A0 .nbuttons =A0 =A0 =A0 =3D ARRAY_SIZE(gpio_buttons),
>> +};
>> +
>> +static struct platform_device keys_gpio =3D {
>> + =A0 =A0 .name =A0 =3D "gpio-keys",
>> + =A0 =A0 .id =A0 =A0 =3D -1,
>> + =A0 =A0 .dev =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &gpio_key_info,
>> + =A0 =A0 },
>> +};
>> +
>> +static void ads7846_dev_init(void)
>> +{
>> + =A0 =A0 if (gpio_request(OMAP3_THUNDER_TS_GPIO, "ADS7846 pendown")=
 < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't get ads7846 pen dow=
n GPIO\n");
>> +
>> + =A0 =A0 gpio_direction_input(OMAP3_THUNDER_TS_GPIO);
>> +
>> + =A0 =A0 omap_set_gpio_debounce(OMAP3_THUNDER_TS_GPIO, 1);
>> + =A0 =A0 omap_set_gpio_debounce_time(OMAP3_THUNDER_TS_GPIO, 0xa);
>> +}
>> +
>> +static int ads7846_get_pendown_state(void)
>> +{
>> + =A0 =A0 return !gpio_get_value(OMAP3_THUNDER_TS_GPIO);
>> +}
>> +
>> +struct ads7846_platform_data ads7846_config =3D {
>> + =A0 =A0 .x_max =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0fff,
>> + =A0 =A0 .y_max =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0fff,
>> + =A0 =A0 .x_plate_ohms =A0 =A0 =A0 =A0 =A0 =3D 180,
>> + =A0 =A0 .pressure_max =A0 =A0 =A0 =A0 =A0 =3D 255,
>> + =A0 =A0 .debounce_max =A0 =A0 =A0 =A0 =A0 =3D 10,
>> + =A0 =A0 .debounce_tol =A0 =A0 =A0 =A0 =A0 =3D 3,
>> + =A0 =A0 .debounce_rep =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 .get_pendown_state =A0 =A0 =A0=3D ads7846_get_pendown_stat=
e,
>> + =A0 =A0 .keep_vref_on =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 .settle_delay_usecs =A0 =A0 =3D 150,
>> +};
>> +
>> +
>> +static struct omap2_mcspi_device_config ads7846_mcspi_config =3D {
>> + =A0 =A0 .turbo_mode =A0 =A0 =3D 0,
>> + =A0 =A0 .single_channel =3D 1, =A0/* 0: slave, 1: master */
>> +};
>> +
>> +
>> +struct spi_board_info omap3thunder_spi_board_touch[] =3D {
>> + =A0 =A0 =A0{
>> + =A0 =A0 =A0 =A0 =A0 =A0 .modalias =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =
"ads7846",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .bus_num =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .chip_select =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .max_speed_hz =A0 =A0 =A0 =A0 =A0 =3D 1500=
000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =A0 =A0 =A0 =A0=3D &ads78=
46_mcspi_config,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D OMAP_GPIO_IRQ(OMAP3_THUNDER_TS_GPIO),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0 =A0 =A0 =A0 =A0=3D &ads=
7846_config,
>> + =A0 =A0 },
>> +};
>> +
>> +
>> +/* G-sensor on SPI bus 4 */
>> +static struct spi_board_info omap3thunder_spi_board_info[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .modalias =3D "spidev",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .max_speed_hz =A0 =3D 1500000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mode =3D SPI_MODE_0,
>> + =A0 =A0 =A0 =A0},
>> +};
>> +
>> +static struct omap_board_config_kernel omap3_thunder_config[] __ini=
tdata =3D {
>> +};
>> +
>> +static struct platform_device *omap3_thunder_devices[] __initdata =3D=
 {
>> + =A0 =A0 &thunder_dss_device,
>> + =A0 =A0 &leds_gpio,
>> + =A0 =A0 &keys_gpio,
>> +};
>> +
>> +static void __init omap3thunder_flash_init(void)
>> +{
>> + =A0 =A0 u8 cs =3D 0;
>> + =A0 =A0 u8 nandcs =3D GPMC_CS_NUM + 1;
>> +
>> + =A0 =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
>> +
>> + =A0 =A0 /* find out the chip-select on which NAND exists */
>> + =A0 =A0 while (cs < GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpmc_cs_read_reg(cs, GPMC_CS_CONFI=
G1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((ret & 0xC00) =3D=3D 0x800) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Found NA=
ND on CS%d\n", cs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nandcs > GPMC_CS_NUM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nandcs =3D=
 cs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (nandcs > GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "NAND: Unable to find con=
figuration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"in GPM=
C\n ");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (nandcs < GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3thunder_nand_data.cs =3D nandcs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3thunder_nand_data.gpmc_cs_baseaddr =3D=
 (void *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (gpmc_base_add + GPMC_CS0_=
BASE + nandcs * GPMC_CS_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3thunder_nand_data.gpmc_baseaddr =3D (=
void *) (gpmc_base_add);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Registering NAND on CS%d=
\n", nandcs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device_register(&omap3thunder=
_nand_device) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to=
 register NAND device\n");
>> + =A0 =A0 }
>> +}
>> +
>> +
>> +static struct ehci_hcd_omap_platform_data ehci_pdata __initconst =3D=
 {
>> + =A0 =A0 =A0 =A0.port_mode[0] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>> + =A0 =A0 =A0 =A0.port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
>> + =A0 =A0 =A0 =A0.port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>> +
>> + =A0 =A0 =A0 =A0.phy_reset =A0=3D false,
>> + =A0 =A0 =A0 =A0.reset_gpio_port[0] =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0.reset_gpio_port[1] =A0=3D 162,
>> + =A0 =A0 =A0 =A0.reset_gpio_port[2] =A0=3D -EINVAL
>> +};
>> +
>> +static void __init omap3_thunder_init(void)
>> +{
>> + =A0 =A0 omap3_thunder_i2c_init();
>> +
>> + =A0 =A0 /* Turn on Wireless LAN */
>> + =A0 =A0 =A0 =A0gpio_request( 157 , "WIFI ENABLE");
>> + =A0 =A0 =A0 =A0gpio_direction_output( 157, 0);
>> +
>> + =A0 =A0 platform_add_devices(omap3_thunder_devices,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap3_thunder_d=
evices));
>> + =A0 =A0 omap_board_config =3D omap3_thunder_config;
>> + =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(omap3_thunder_config=
);
>> + =A0 =A0 omap_serial_init();
>> +
>> + =A0 =A0 usb_musb_init();
>> + =A0 =A0 usb_ehci_init(&ehci_pdata);
>> + =A0 =A0 omap3thunder_flash_init();
>> +
>> + =A0 =A0 ads7846_dev_init();
>> + =A0 =A0 spi_register_board_info(omap3thunder_spi_board_touch, ARRA=
Y_SIZE(omap3thunder_spi_board_touch));
>> + =A0 =A0 spi_register_board_info(omap3thunder_spi_board_info, ARRAY=
_SIZE(omap3thunder_spi_board_info));
>> +
>> + =A0 =A0 thunder_display_init();
>> +}
>> +
>> +static void __init omap3_thunder_map_io(void)
>> +{
>> + =A0 =A0 omap2_set_globals_343x();
>> + =A0 =A0 omap2_map_common_io();
>> +}
>> +
>> +MACHINE_START(OMAP3_THUNDER, "OMAP3 Thunder Board")
>> + =A0 =A0 /* Maintainer: Daniel Toussaint daniel.toussaint@technexio=
n.com */
>> + =A0 =A0 .phys_io =A0 =A0 =A0 =A0=3D 0x48000000,
>> + =A0 =A0 .io_pg_offst =A0 =A0=3D ((0xd8000000) >> 18) & 0xfffc,
>> + =A0 =A0 .boot_params =A0 =A0=3D 0x80000100,
>> + =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D omap3_thunder_map_io,
>> + =A0 =A0 .init_irq =A0 =A0 =A0 =3D omap3_thunder_init_irq,
>> + =A0 =A0 .init_machine =A0 =3D omap3_thunder_init,
>> + =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
>> +MACHINE_END
>> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/om=
ap2/displays/Kconfig
>> index 79d2861..a831fff 100644
>> --- a/drivers/video/omap2/displays/Kconfig
>> +++ b/drivers/video/omap2/displays/Kconfig
>> @@ -25,4 +25,11 @@ config PANEL_TAAL
>> =A0 =A0 =A0 =A0 =A0help
>> =A0 =A0 =A0 =A0 =A0 =A0Taal DSI command mode panel from TPO.
>>
>> +config PANEL_LG_LB043WQ2
>> + =A0 =A0 =A0 =A0tristate "LG LB043WQ2 Panel"
>> + =A0 =A0 =A0 =A0depends on OMAP2_DSS
>> + =A0 =A0 =A0 =A0help
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LG LB043WQ2 Panel on Thunder board
>> +
>> +
>> =A0endmenu
>> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/o=
map2/displays/Makefile
>> index d44e765..ae0c956 100644
>> --- a/drivers/video/omap2/displays/Makefile
>> +++ b/drivers/video/omap2/displays/Makefile
>> @@ -3,3 +3,5 @@ obj-$(CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C) +=3D panel-=
samsung-lte430wq-f0c.o
>> =A0obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw0=
1.o
>>
>> =A0obj-$(CONFIG_PANEL_TAAL) +=3D panel-taal.o
>> +obj-$(CONFIG_PANEL_LG_LB043WQ2) +=3D panel-lg-lb043wq2.o
>> +
>> diff --git a/drivers/video/omap2/displays/panel-lg-lb043wq2.c b/driv=
ers/video/omap2/displays/panel-lg-lb043wq2.c
>> new file mode 100644
>> index 0000000..57a74f6
>> --- /dev/null
>> +++ b/drivers/video/omap2/displays/panel-lg-lb043wq2.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * LCD panel driver for LG LB043WQ2 panel
>> + *
>> + * Daniel Toussaint <daniel.toussaint@technexion.com>
>> + *
>> + * Modified from Sharp LS037V7DW01
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +
>> +
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +
>> +#include <plat/display.h>
>> +
>> +static struct omap_video_timings lg_lb043wq2_timings =3D {
>> + =A0 =A0 .x_res =3D 480,
>> + =A0 =A0 .y_res =3D 272,
>> +
>> + =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=3D 41,
>> + =A0 =A0 =A0 =A0.hfp =A0 =A0 =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 =A0.hbp =A0 =A0 =A0 =A0 =A0 =A0=3D 45-41,
>> +
>> + =A0 =A0 =A0 =A0.vsw =A0 =A0 =A0 =A0 =A0 =A0=3D 10,
>> + =A0 =A0 =A0 =A0.vfp =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 =A0 =A0 =A0.vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 12-10,
>> +
>> +
>> + =A0 =A0 .pixel_clock =A0 =A0=3D 8000,
>> +
>> +};
>> +
>> +static int lg_lb043wq2_panel_probe(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_I=
VS |
>> + =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IHS;
>> + =A0 =A0 dssdev->panel.timings =3D lg_lb043wq2_timings;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void lg_lb043wq2_panel_remove(struct omap_dss_device *dssdev=
)
>> +{
>> +}
>> +
>> +static int lg_lb043wq2_panel_enable(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 int r =3D 0;
>> +
>> + =A0 =A0 /* wait couple of vsyncs until enabling the LCD */
>> + =A0 =A0 msleep(50);
>> +
>> + =A0 =A0 if (dssdev->platform_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D dssdev->platform_enable(dssdev);
>> +
>> + =A0 =A0 return r;
>> +}
>> +
>> +static void lg_lb043wq2_panel_disable(struct omap_dss_device *dssde=
v)
>> +{
>> + =A0 =A0 if (dssdev->platform_disable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dssdev->platform_disable(dssdev);
>> +
>> + =A0 =A0 /* wait at least 5 vsyncs after disabling the LCD */
>> +
>> + =A0 =A0 msleep(100);
>> +}
>> +
>> +static int lg_lb043wq2_panel_suspend(struct omap_dss_device *dssdev=
)
>> +{
>> + =A0 =A0 lg_lb043wq2_panel_disable(dssdev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int lg_lb043wq2_panel_resume(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 return lg_lb043wq2_panel_enable(dssdev);
>> +}
>> +
>> +static struct omap_dss_driver lg_lb043wq2_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D lg_lb043wq2_panel_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D lg_lb043wq2_panel_remove,
>> +
>> + =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D lg_lb043wq2_panel_enable,
>> + =A0 =A0 .disable =A0 =A0 =A0 =A0=3D lg_lb043wq2_panel_disable,
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D lg_lb043wq2_panel_suspend,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D lg_lb043wq2_panel_resume,
>> +
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "panel-lg-lb043wq2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init lg_lb043wq2_panel_drv_init(void)
>> +{
>> + =A0 =A0 return omap_dss_register_driver(&lg_lb043wq2_driver);
>> +}
>> +
>> +static void __exit lg_lb043wq2_panel_drv_exit(void)
>> +{
>> + =A0 =A0 omap_dss_unregister_driver(&lg_lb043wq2_driver);
>> +}
>> +
>> +module_init(lg_lb043wq2_panel_drv_init);
>> +module_exit(lg_lb043wq2_panel_drv_exit);
>> +MODULE_LICENSE("GPL");
>> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
>> index 61952aa..2f6c6ae 100644
>> --- a/sound/soc/omap/Kconfig
>> +++ b/sound/soc/omap/Kconfig
>> @@ -116,3 +116,13 @@ config SND_OMAP_SOC_IGEP0020
>> =A0 =A0 =A0 select SND_SOC_TWL4030
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Say Y if you want to add support for Soc audio on IG=
EP v2 board.
>> +
>> +config SND_OMAP_SOC_OMAP3_THUNDER
>> + =A0 =A0 =A0 =A0tristate "SoC Audio support for OMAP3 Thunder"
>> + =A0 =A0 =A0 =A0depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMA=
P3_THUNDER
>> + =A0 =A0 =A0 =A0select SND_OMAP_SOC_MCBSP
>> + =A0 =A0 =A0 =A0select SND_SOC_TWL4030
>> + =A0 =A0 =A0 =A0help
>> + =A0 =A0 =A0 =A0 =A0Say Y if you want to add support for SoC audio =
on the Thunder Board.
>> +
>> +
>> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
>> index d49458a..08c0918 100644
>> --- a/sound/soc/omap/Makefile
>> +++ b/sound/soc/omap/Makefile
>> @@ -18,6 +18,7 @@ snd-soc-omap3pandora-objs :=3D omap3pandora.o
>> =A0snd-soc-omap3beagle-objs :=3D omap3beagle.o
>> =A0snd-soc-zoom2-objs :=3D zoom2.o
>> =A0snd-soc-igep0020-objs :=3D igep0020.o
>> +snd-soc-omap3thunder-objs :=3D omap3thunder.o
>>
>> =A0obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-n810.o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) +=3D snd-soc-ams-delta.o
>> @@ -31,3 +32,5 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) +=3D snd-=
soc-omap3pandora.o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) +=3D snd-soc-omap3beagle.=
o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) +=3D snd-soc-zoom2.o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) +=3D snd-soc-igep0020.o
>> +obj-$(CONFIG_SND_OMAP_SOC_OMAP3_THUNDER) +=3D snd-soc-omap3thunder.=
o
>> +
>> diff --git a/sound/soc/omap/omap3thunder.c b/sound/soc/omap/omap3thu=
nder.c
>> new file mode 100644
>> index 0000000..cd91dff
>> --- /dev/null
>> +++ b/sound/soc/omap/omap3thunder.c
>> @@ -0,0 +1,160 @@
>> +/*
>> + * omap3 audio support for Technexion Thunder boards.
>> + * Modified from omap3beagle.c
>> + * Daniel Toussaint <daniel.toussaint@technexion.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +
>> +#include <linux/clk.h>
>> +#include <linux/platform_device.h>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dapm.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <plat/hardware.h>
>> +#include <plat/gpio.h>
>> +#include <plat/mcbsp.h>
>> +
>> +#include "omap-mcbsp.h"
>> +#include "omap-pcm.h"
>> +#include "../codecs/twl4030.h"
>> +
>> +static int omap3thunder_hw_params(struct snd_pcm_substream *substre=
am,
>> + =A0 =A0 struct snd_pcm_hw_params *params)
>> +{
>> + =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_dat=
a;
>> + =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
>> + =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
>> + =A0 =A0 unsigned int fmt;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 switch (params_channels(params)) {
>> + =A0 =A0 case 2: /* Stereo I2S mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D =A0 SND_SOC_DAIFMT_I2S |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_CBM_CFM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 4: /* Four channel TDM mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D =A0 SND_SOC_DAIFMT_DSP_A |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_IB_NF |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_CBM_CFM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Set codec DAI configuration */
>> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, fmt);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set codec DAI confi=
guration\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Set cpu DAI configuration */
>> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set cpu DAI configu=
ration\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Set the codec system clock for DAC and ADC */
>> + =A0 =A0 ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SND_SOC_CLOCK_IN);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't set codec system cl=
ock\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct snd_soc_ops omap3thunder_ops =3D {
>> + =A0 =A0 .hw_params =3D omap3thunder_hw_params,
>> +};
>> +
>> +/* Digital audio interface glue - connects codec <--> CPU */
>> +static struct snd_soc_dai_link omap3thunder_dai =3D {
>> + =A0 =A0 .name =3D "TWL4030",
>> + =A0 =A0 .stream_name =3D "TWL4030",
>> + =A0 =A0 .cpu_dai =3D &omap_mcbsp_dai[0],
>> + =A0 =A0 .codec_dai =3D &twl4030_dai[TWL4030_DAI_HIFI],
>> + =A0 =A0 .ops =3D &omap3thunder_ops,
>> +};
>> +
>> +/* Audio machine driver */
>> +static struct snd_soc_card snd_soc_omap3thunder =3D {
>> + =A0 =A0 .name =3D "omap3thunder",
>> + =A0 =A0 .platform =3D &omap_soc_platform,
>> + =A0 =A0 .dai_link =3D &omap3thunder_dai,
>> + =A0 =A0 .num_links =3D 1,
>> +};
>> +
>> +/* Audio subsystem */
>> +static struct snd_soc_device omap3thunder_snd_devdata =3D {
>> + =A0 =A0 .card =3D &snd_soc_omap3thunder,
>> + =A0 =A0 .codec_dev =3D &soc_codec_dev_twl4030,
>> +};
>> +
>> +static struct platform_device *omap3thunder_snd_device;
>> +
>> +static int __init omap3thunder_soc_init(void)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (!machine_is_omap3_thunder()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("Not OMAP3 thunder!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> + =A0 =A0 pr_info("OMAP3 thunder SoC init\n");
>> +
>> + =A0 =A0 omap3thunder_snd_device =3D platform_device_alloc("soc-aud=
io", -1);
>> + =A0 =A0 if (!omap3thunder_snd_device) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Platform device allocatio=
n failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 platform_set_drvdata(omap3thunder_snd_device, &omap3thunde=
r_snd_devdata);
>> + =A0 =A0 omap3thunder_snd_devdata.dev =3D &omap3thunder_snd_device-=
>dev;
>> + =A0 =A0 *(unsigned int *)omap3thunder_dai.cpu_dai->private_data =3D=
 1; /* McBSP2 */
>> +
>> + =A0 =A0 ret =3D platform_device_add(omap3thunder_snd_device);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> +
>> + =A0 =A0 return 0;
>> +
>> +err1:
>> + =A0 =A0 printk(KERN_ERR "Unable to add platform device\n");
>> + =A0 =A0 platform_device_put(omap3thunder_snd_device);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void __exit omap3thunder_soc_exit(void)
>> +{
>> + =A0 =A0 platform_device_unregister(omap3thunder_snd_device);
>> +}
>> +
>> +module_init(omap3thunder_soc_init);
>> +module_exit(omap3thunder_soc_exit);
>> +
>> +MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
>> +MODULE_DESCRIPTION("ALSA SoC OMAP3 thunder");
>> +MODULE_LICENSE("GPL");
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
