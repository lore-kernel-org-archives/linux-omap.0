From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
Date: Wed, 20 May 2009 05:18:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F50968B0@dbde02.ent.ti.com>
References: <1242422451-21551-1-git-send-email-mlc@ti.com>
 <1242422451-21551-2-git-send-email-mlc@ti.com>
 <20090518212216.GR19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50963E1@dbde02.ent.ti.com>
 <20090518213902.GS19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5096447@dbde02.ent.ti.com>
 <20090519162940.GX19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56408 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbZESXsj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:48:39 -0400
In-Reply-To: <20090519162940.GX19742@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Christensen, Mikkel" <mlc@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Tuesday, May 19, 2009 11:30 AM
>To: Pandita, Vikram
>Cc: Christensen, Mikkel; linux-omap@vger.kernel.org
>Subject: Re: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
>
>* Pandita, Vikram <vikram.pandita@ti.com> [090518 20:55]:
>> Tony
>>
>> >* Pandita, Vikram <vikram.pandita@ti.com> [090518 14:31]:
>> >> Tony
>> >>
>> >> >>
>> >> >> +
>> >> >> +	zoom2_init_smsc911x();
>> >> >> +	zoom2_init_quaduart();
>> >> >> +	return platform_add_devices(zoom2_devices, ARRAY_SIZE(zoom2_devices));
>> >> >> +}
>> >> >> +arch_initcall(omap_zoom2_debugboard_init);
>> >> >
>> >> >Please just move all the related functions to board-zoom2.c. I don't see any
>> >> >reason to have a separate file for the debugboard features. The runtime detection
>> >> >should do the trick.
>> >>
>> >> Two reasons for keeping a separate debug board.
>> >> a) debug board is detachable in h/w and hence we thought its better to keep the s/w also that
>way
>> >> The quart chip on debug bard is a quard-uart and can support 4 different console outputs.
>> >> All those we thought of adding in future.
>> >
>> >Well those you can easily optimize out by not compiling in those devices.
>> >
>> >>
>> >> b) we took reference from board-rx51-peripherals.c wherein some parts of the board file can be
>> >moved out to a new file
>> >>
>> >> If you still think we need to merge, then let us know.
>> >> We are open to suggestions/changes.
>> >
>> >Well the reason for separate board-*-peripheral-whatever.c files is that
>> >they're intended to be shared with other board-*.c files. Currently n8x0
>> >and rx51 share devices. In general, we should try to do generic platform
>> >init files, like gpmc-onenand.c and gpmc-smc91x.c.
>> >
>> >Then I see need for gpmc-sdp-flash.c that's shared between 2430 and 3430 sdp
>> >at least.
>> >
>> >So yeah, for zoom2, I'd rather see just board-zoom2.c for now. But if you
>> >create some other board that uses the same debug board functions, then
>> >there could be a separate zoom-debugboard.c.
>>
>>
>> Yes. There is next generation of zoom boards that will re-use the Debug board.
>> That way the debug board file will get re-used.
>
>OK, how about rename it to something that makes sense as a name for
>multiple zoom like boards and resubmit.

I am planning on renaming debug board zoom2 file to board-zoom-debugboard.c
That way it can be used by different Zoom family of boards.

>
>Also the arch_initcall() issue below still needs fixing.

I have cleaned the issue by making the debug_board_init call as late_initcall().

There is a dependency on serial.c file and hence the need for arch_init/late_init calls.

platform_device_register() should happen for serial.c file (8250) for the omap uarts first and this should be followed by platform_device_register() for the quard uart on debug board.

So there is a dependency on order of registration of platform device for the same 8250 driver.

If you ack, then I can post the patches with the changes.

>
>Regards,
>
>Tony
>
>>
>> >
>> >Regards,
>> >
>> >Tony
>> >
>> >
>> >> >
>> >> >Also, the arch_initcall() above is wrong, it runs for all the boards and
>> >> >platforms compiled in even if they are not zoom2 boards.
>> >> >
>> >> >Other than, looks OK to me, so we might be able to get this into mainline
>> >> >this merge window.
>> >> >
>> >> >Regards,
>> >> >
>> >> >Tony
>> >>
>> >>
>> >>
>> >> >
>> >> >
>> >> >> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
>> >> >> new file mode 100644
>> >> >> index 0000000..5a656b3
>> >> >> --- /dev/null
>> >> >> +++ b/arch/arm/mach-omap2/board-zoom2.c
>> >> >> @@ -0,0 +1,107 @@
>> >> >> +/*
>> >> >> + * Copyright (C) 2009 Texas Instruments Inc.
>> >> >> + * Mikkel Christensen <mlc@ti.com>
>> >> >> + *
>> >> >> + * Modified from mach-omap2/board-ldp.c
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and/or modify
>> >> >> + * it under the terms of the GNU General Public License version 2 as
>> >> >> + * published by the Free Software Foundation.
>> >> >> + */
>> >> >> +
>> >> >> +#include <linux/kernel.h>
>> >> >> +#include <linux/init.h>
>> >> >> +#include <linux/platform_device.h>
>> >> >> +#include <linux/i2c/twl4030.h>
>> >> >> +
>> >> >> +#include <asm/mach-types.h>
>> >> >> +#include <asm/mach/arch.h>
>> >> >> +
>> >> >> +#include <mach/gpio.h>
>> >> >> +#include <mach/common.h>
>> >> >> +#include <mach/usb.h>
>> >> >> +
>> >> >> +#include "mmc-twl4030.h"
>> >> >> +
>> >> >> +static void __init omap_zoom2_init_irq(void)
>> >> >> +{
>> >> >> +	omap2_init_common_hw(NULL);
>> >> >> +	omap_init_irq();
>> >> >> +	omap_gpio_init();
>> >> >> +}
>> >> >> +
>> >> >> +static struct omap_uart_config zoom2_uart_config __initdata = {
>> >> >> +	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
>> >> >> +};
>> >> >> +
>> >> >> +static struct omap_board_config_kernel zoom2_config[] __initdata = {
>> >> >> +	{ OMAP_TAG_UART,	&zoom2_uart_config },
>> >> >> +};
>> >> >> +
>> >> >> +static struct twl4030_gpio_platform_data zoom2_gpio_data = {
>> >> >> +	.gpio_base	= OMAP_MAX_GPIO_LINES,
>> >> >> +	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>> >> >> +	.irq_end	= TWL4030_GPIO_IRQ_END,
>> >> >> +};
>> >> >> +
>> >> >> +static struct twl4030_platform_data zoom2_twldata = {
>> >> >> +	.irq_base	= TWL4030_IRQ_BASE,
>> >> >> +	.irq_end	= TWL4030_IRQ_END,
>> >> >> +
>> >> >> +	/* platform_data for children goes here */
>> >> >> +	.gpio		= &zoom2_gpio_data,
>> >> >> +};
>> >> >> +
>> >> >> +static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
>> >> >> +	{
>> >> >> +		I2C_BOARD_INFO("twl4030", 0x48),
>> >> >> +		.flags = I2C_CLIENT_WAKE,
>> >> >> +		.irq = INT_34XX_SYS_NIRQ,
>> >> >> +		.platform_data = &zoom2_twldata,
>> >> >> +	},
>> >> >> +};
>> >> >> +
>> >> >> +static int __init omap_i2c_init(void)
>> >> >> +{
>> >> >> +	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
>> >> >> +			ARRAY_SIZE(zoom2_i2c_boardinfo));
>> >> >> +	omap_register_i2c_bus(2, 400, NULL, 0);
>> >> >> +	omap_register_i2c_bus(3, 400, NULL, 0);
>> >> >> +	return 0;
>> >> >> +}
>> >> >> +
>> >> >> +static struct twl4030_hsmmc_info mmc[] __initdata = {
>> >> >> +	{
>> >> >> +		.mmc		= 1,
>> >> >> +		.wires		= 4,
>> >> >> +		.gpio_cd	= -EINVAL,
>> >> >> +		.gpio_wp	= -EINVAL,
>> >> >> +	},
>> >> >> +	{}	/* Terminator */
>> >> >> +};
>> >> >> +
>> >> >> +static void __init omap_zoom2_init(void)
>> >> >> +{
>> >> >> +	omap_i2c_init();
>> >> >> +	omap_board_config = zoom2_config;
>> >> >> +	omap_board_config_size = ARRAY_SIZE(zoom2_config);
>> >> >> +	omap_serial_init();
>> >> >> +	twl4030_mmc_init(mmc);
>> >> >> +	usb_musb_init();
>> >> >> +}
>> >> >> +
>> >> >> +static void __init omap_zoom2_map_io(void)
>> >> >> +{
>> >> >> +	omap2_set_globals_343x();
>> >> >> +	omap2_map_common_io();
>> >> >> +}
>> >> >> +
>> >> >> +MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
>> >> >> +	.phys_io	= 0x48000000,
>> >> >> +	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
>> >> >> +	.boot_params	= 0x80000100,
>> >> >> +	.map_io		= omap_zoom2_map_io,
>> >> >> +	.init_irq	= omap_zoom2_init_irq,
>> >> >> +	.init_machine	= omap_zoom2_init,
>> >> >> +	.timer		= &omap_timer,
>> >> >> +MACHINE_END
>> >> >> --
>> >> >> 1.5.4.3
>> >> >>
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>>

