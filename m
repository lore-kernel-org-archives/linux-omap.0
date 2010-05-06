From: "Jason" <lzg@ema-tech.com>
Subject: RE: [PATCH] Add support for OMAP3Stalker boards
Date: Thu, 6 May 2010 10:13:41 +0800
Message-ID: <00ce01caecc1$c2431560$46c94020$@com>
References: <000501cabadc$711651a0$5342f4e0$@com> <20100504225952.GQ29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:43164 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0EFCNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 22:13:50 -0400
Received: by qyk27 with SMTP id 27so11426558qyk.23
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 19:13:49 -0700 (PDT)
In-Reply-To: <20100504225952.GQ29604@atomide.com>
Content-Language: zh-cn
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Thanks for replaying, I did have a long wait.

A question about board version. Is it good to do a hardware check to fi=
nd
out hardware version?
 Like function static void __init omap3_evm_get_revision(void) in
board-omap3evm.c


Best regards,
Jason

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: 2010=C4=EA5=D4=C25=C8=D5 7:00
> To: Jason
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Add support for OMAP3Stalker boards
>=20
> Hi,
>=20
> Sorry for the delay in replying. Few comments, see below.
>=20
> * Jason <lzg@ema-tech.com> [100303 06:16]:
> > This patche add omap3 board support for the EMA-Tech StalkerBoards.=
 Base
> on
> > TI's EVM.
>=20
> <snip>
>=20
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -82,6 +82,26 @@ config MACH_OMAP3517EVM
> >  	depends on ARCH_OMAP3
> >  	select OMAP_PACKAGE_CBB
> >
> > +config MACH_SBC3530
> > +	bool "OMAP3 SBC STALKER board"
> > +	depends on ARCH_OMAP3
> > +
> > +choice
> > +	prompt STALKER_BOARD_TYPE
> > +	depends on MACH_SBC3530
> > +	default STALKER_EVM
> > +
> > +config STALKER_BOARD_TYPE_EVM
> > +	bool "Stalker EVM board"
> > +	help
> > +	  Select this option if you have a Stalker EVM board
> > +
> > +config STALKER_BOARD_TYPE_LK_S
> > +	bool "Stalker LK-S board"
> > +	help
> > +	  Select this option if you have a Stalker LK-S board
> > +endchoice
> > +
> >  config MACH_OMAP3_PANDORA
> >  	bool "OMAP3 Pandora"
> >  	depends on ARCH_OMAP3
>=20
> Things like this are best done by looking at the ATAG_REVISION passed=
 by
> the bootloader. Then you can dynamically initialize the platform data
> based on the revision.
>=20
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> > @@ -0,0 +1,922 @@
> > +/*
> > + * linux/arch/arm/mach-omap2/board-omap3evm.c
> > + *
> > + * Copyright (C) 2008 Guangzhou EMA-Tech
> > + *
> > + * Modified from mach-omap2/board-omap3evm.c
> > + *
> > + * Initial code: Syed Mohammed Khasim
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/clk.h>
> > +#include <linux/gpio.h>
> > +#include <linux/input.h>
> > +#include <linux/input/matrix_keypad.h>
> > +#include <linux/leds.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/ads7846.h>
> > +#include <linux/i2c/twl.h>
> > +#include <linux/usb/otg.h>
> > +#if defined(CONFIG_STALKER_BOARD_TYPE_EVM)
> > +#include <linux/dm9000.h>
> > +#elif defined(CONFIG_STALKER_BOARD_TYPE_LK_S)
>=20
> We should not ifdef includes, it should be OK to include them
automatically.
>=20
> > +#include <linux/smsc911x.h>
> > +#include <linux/gpio_keys.h>
> > +#include <linux/i2c/at24.h>
> > +#endif
> > +
> > +#include <linux/regulator/machine.h>
> > +
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/mtd/nand.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> > +#include <asm/mach/flash.h>
> > +
> > +#include <plat/board.h>
> > +#include <plat/mux.h>
> > +#include <plat/gpmc.h>
> > +#include <plat/nand.h>
> > +#include <plat/usb.h>
> > +#include <plat/common.h>
> > +#include <plat/control.h>
> > +#include <plat/mcspi.h>
> > +#include <plat/clock.h>
> > +#include <plat/omap-pm.h>
> > +#include <plat/display.h>
> > +#include <plat/timer-gp.h>
> > +
> > +#include "mux.h"
> > +#include "sdram-micron-mt46h32m32lf-6.h"
> > +#include "hsmmc.h"
> > +#include "pm.h"
>=20
> That's a lot of include files, are they all needed?
>=20
> > +static struct mtd_partition omap3stalker_nand_partitions[] =3D {
> > +	/* All the partition sizes are listed in terms of NAND block size=
 */
> > +	{
> > +	 .name =3D "X-Loader",
> > +	 .offset =3D 0,
> > +	 .size =3D 4 * (SZ_128K),
> > +	 .mask_flags =3D MTD_WRITEABLE,
> > +	 },
> > +	{
> > +	 .name =3D "U-Boot",
> > +	 .offset =3D MTDPART_OFS_APPEND,
> > +	 .size =3D 15 * (SZ_128K),
> > +	 .mask_flags =3D MTD_WRITEABLE,
> > +	 },
> > +	{
> > +	 .name =3D "U-Boot Env",
> > +	 .offset =3D MTDPART_OFS_APPEND,
> > +	 .size =3D 1 * (SZ_128K)},
> > +	{
> > +	 .name =3D "Kernel",
> > +	 .offset =3D MTDPART_OFS_APPEND,
> > +	 .size =3D 32 * (SZ_128K)},
> > +	{
> > +	 .name =3D "File System",
> > +	 .size =3D MTDPART_SIZ_FULL,
> > +	 .offset =3D MTDPART_OFS_APPEND,
> > +	 },
> > +};
>=20
> Please use tabs instead of spaces.
>=20
> > +void __init omap3stalker_flash_init(void)
> > +{
> > +	u8 cs =3D 0;
> > +	u8 nandcs =3D GPMC_CS_NUM + 1;
> > +	u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
>=20
> Please leave out the NAND stuff for now, we need to first fix the
> NAND driver before adding more of the OMAP34XX_GPMC_VIRT..
>=20
> > +static struct resource omap3stalker_smsc911x_resources[] =3D {
> > +	[0] =3D {
> > +	       .start =3D OMAP3STALKER_ETHR_START,
> > +	       .end =3D
> > +	       (OMAP3STALKER_ETHR_START + OMAP3STALKER_ETHR_SIZE -
> 1),
> > +	       .flags =3D IORESOURCE_MEM,
> > +	       },
> > +	[1] =3D {
> > +	       .start =3D OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
> > +	       .end =3D OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
> > +	       .flags =3D (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
> > +	       },
> > +};
>=20
> Please use tabs here too instead of spaces.
>=20
> > +static struct omap2_hsmmc_info mmc[] =3D {
> > +	{
> > +	 .mmc =3D 1,
> > +	 .wires =3D 4,
> > +	 .gpio_cd =3D -EINVAL,
> > +	 .gpio_wp =3D 23,
> > +	 },
> > +	{}			/* Terminator */
> > +};
> > +
> > +#if defined(CONFIG_STALKER_BOARD_TYPE_LK_S)
> > +static struct gpio_keys_button gpio_buttons[] =3D {
> > +	{
> > +	 .code =3D BTN_EXTRA,
> > +	 .gpio =3D 18,
> > +	 .desc =3D "user",
> > +	 .wakeup =3D 1,
> > +	 },
> > +};
>=20
> Here too.
>=20
> > +	.irq_base =3D TWL4030_IRQ_BASE,
> > +	.irq_end =3D TWL4030_IRQ_END,
> > +
> > +	/* platform_data for children goes here */
> > +	.keypad =3D &omap3stalker_kp_data,
> > +	.madc =3D &omap3stalker_madc_data,
> > +	.usb =3D &omap3stalker_usb_data,
> > +	.gpio =3D &omap3stalker_gpio_data,
> > +	.codec =3D &omap3stalker_codec_data,
> > +	.vdac =3D &omap3_stalker_vdac,
> > +	.vpll2 =3D &omap3_stalker_vpll2,
> > +};
>=20
> Please align with tabs:
>=20
> 	.keypad		=3D &omap3stalker_kp_data,
> 	.madc		=3D &omap3stalker_madc_data,
>=20
> > +static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo=
[] =3D
{
> > +	{
> > +	 I2C_BOARD_INFO("twl4030", 0x48),
> > +	 .flags =3D I2C_CLIENT_WAKE,
> > +	 .irq =3D INT_34XX_SYS_NIRQ,
> > +	 .platform_data =3D &omap3stalker_twldata,
> > +	 },
> > +};
>=20
> Tabify
>=20
> > +#ifdef CONFIG_STALKER_BOARD_TYPE_LK_S
> > +static struct at24_platform_data fram_info =3D {
> > +	.byte_len =3D (64 * 1024) / 8,
> > +	.page_size =3D 8192,
> > +	.flags =3D AT24_FLAG_ADDR16 | AT24_FLAG_IRUGO,
> > +};
> > +
> > +static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo=
3[] =3D
{
> > +	{
> > +	 I2C_BOARD_INFO("24c64", 0x50),
> > +	 .flags =3D I2C_CLIENT_WAKE,
> > +	 .platform_data =3D &fram_info,
> > +	 },
> > +};
> > +#endif
>=20
> Tabify
>=20
> Anyways, mostly minor stuff except for the preference for dynamic
detection
> of the board.
>=20
> Regards,
>=20
> Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
