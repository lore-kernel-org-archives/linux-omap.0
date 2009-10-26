From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Mon, 26 Oct 2009 06:10:04 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AC22851@dlee02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50209 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbZJZLKB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 07:10:01 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9QBA52M002482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:10:06 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9QBA5hq019527
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:10:05 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QBA56I008205
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:10:05 -0500 (CDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pais, Allen
> Sent: Monday, October 26, 2009 2:43 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 1/2] Added board-3630.c file.
> 
> From 553ee2299d0ea6493e8587e7cc832361646f81a7 Mon Sep 17 00:00:00 2001
> From: Allen Pais <allen.pais@ti.com>
> Date: Mon, 26 Oct 2009 12:50:17 +0530
> Subject: [PATCH 1/2] Added board-3630.c file.
> 
> The following sequence of patch set is to adds minimal OMAP3630 board
> support to OMAP GIT.
> This patch is tested on TI's OMAP3630 SDP.
> 
> OMAP 3630 is an ARM Cortex A8 based Multimedia Application processor. For
> more
> information please visit:
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=61
> 23&navigation
> Id=12836&contentId=52606
> 
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> ---
>  arch/arm/mach-omap2/board-3630sdp.c |  188
> +++++++++++++++++++++++++++++++++++
>  1 files changed, 188 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-3630sdp.c
> 
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> omap2/board-3630sdp.c
> new file mode 100644
> index 0000000..d3ddbd1
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -0,0 +1,188 @@
> +/*
> + *  linux/arch/arm/mach-omap2/board-3630sdp.c
> + *  Copyright (C) 2007 Texas Instruments
2007???? I don't recollect 3630 in 2007.

> + *  Modified from mach-omap2/board-generic.c
> + *  Initial code: Allen Pais
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c/twl4030.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <plat/common.h>
> +#include <plat/usb.h>
> +
> +#include "mmc-twl4030.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
> +/* 3630SDP has Qwerty keyboard*/
> +static int board_keymap[] = {
> +	KEY(0, 0, KEY_E),
> +	KEY(1, 0, KEY_R),
> +	KEY(2, 0, KEY_T),
> +	KEY(3, 0, KEY_HOME),
> +	KEY(6, 0, KEY_I),
> +	KEY(7, 0, KEY_LEFTSHIFT),
> +	KEY(0, 1, KEY_D),
> +	KEY(1, 1, KEY_F),
> +	KEY(2, 1, KEY_G),
> +	KEY(3, 1, KEY_SEND),
> +	KEY(6, 1, KEY_K),
> +	KEY(7, 1, KEY_ENTER),
> +	KEY(0, 2, KEY_X),
> +	KEY(1, 2, KEY_C),
> +	KEY(2, 2, KEY_V),
> +	KEY(3, 2, KEY_END),
> +	KEY(6, 2, KEY_DOT),
> +	KEY(7, 2, KEY_CAPSLOCK),
> +	KEY(0, 3, KEY_Z),
> +	KEY(1, 3, KEY_KPPLUS),
> +	KEY(2, 3, KEY_B),
> +	KEY(3, 3, KEY_F1),
> +	KEY(6, 3, KEY_O),
> +	KEY(7, 3, KEY_SPACE),
> +	KEY(0, 4, KEY_W),
> +	KEY(1, 4, KEY_Y),
> +	KEY(2, 4, KEY_U),
> +	KEY(3, 4, KEY_F2),
> +	KEY(4, 4, KEY_VOLUMEUP),
> +	KEY(6, 4, KEY_L),
> +	KEY(7, 4, KEY_LEFT),
> +	KEY(0, 5, KEY_S),
> +	KEY(1, 5, KEY_H),
> +	KEY(2, 5, KEY_J),
> +	KEY(3, 5, KEY_F3),
> +	KEY(5, 5, KEY_VOLUMEDOWN),
> +	KEY(6, 5, KEY_M),
> +	KEY(4, 5, KEY_ENTER),
> +	KEY(7, 5, KEY_RIGHT),
> +	KEY(0, 6, KEY_Q),
> +	KEY(1, 6, KEY_A),
> +	KEY(2, 6, KEY_N),
> +	KEY(3, 6, KEY_BACKSPACE),
> +	KEY(6, 6, KEY_P),
> +	KEY(7, 6, KEY_UP),
> +	KEY(6, 7, KEY_SELECT),
> +	KEY(7, 7, KEY_DOWN),
> +	KEY(0, 7, KEY_PROG1),	/*MACRO 1 <User defined> */
> +	KEY(1, 7, KEY_PROG2),	/*MACRO 2 <User defined> */
> +	KEY(2, 7, KEY_PROG3),	/*MACRO 3 <User defined> */
> +	KEY(3, 7, KEY_PROG4),	/*MACRO 4 <User defined> */
> +	0
> +};

NAK. Could we follow the same issue with zoom2 -> break the keypad into a
Separate one and use it instead? Same for all reused zoom2 components..

> +
> +static struct matrix_keymap_data board_map_data = {
> +	.keymap			= board_keymap,
> +	.keymap_size		= ARRAY_SIZE(board_keymap),
> +};
> +
> +static struct twl4030_keypad_data sdp3630_kp_twl4030_data = {
> +	.keymap_data	= &board_map_data,
> +	.rows		= 8,
> +	.cols		= 8,
> +	.rep		= 1,
> +};
> +
> +static struct omap_board_config_kernel sdp3630_config[] __initdata = {
> +};
> +
> +
> +static int sdp3630_batt_table[] = {
> +/* 0 C*/
> +30800, 29500, 28300, 27100,
> +26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
> +17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
> +11600, 11200, 10800, 10400, 10000, 9630,  9280,  8950,  8620,  8310,
> +8020,  7730,  7460,  7200,  6950,  6710,  6470,  6250,  6040,  5830,
> +5640,  5450,  5260,  5090,  4920,  4760,  4600,  4450,  4310,  4170,
> +4040,  3910,  3790,  3670,  3550
> +};
> +
> +static struct twl4030_bci_platform_data sdp3630_bci_data = {
> +	.battery_tmp_tbl	= sdp3630_batt_table,
> +	.tblsize		= ARRAY_SIZE(sdp3630_batt_table),
> +};
> +
> +static struct twl4030_usb_data sdp3630_usb_data = {
> +	.usb_mode	= T2_USB_MODE_ULPI,
> +};
> +
> +static void __init omap_sdp3630_init_irq(void)
> +{
> +	omap_board_config = sdp3630_config;
> +	omap_board_config_size = ARRAY_SIZE(sdp3630_config);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +				 mt46h32m32lf6_sdrc_params);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +static struct twl4030_madc_platform_data sdp3630_madc_data = {
> +	.irq_line	= 1,
> +};
> +
> +static struct twl4030_platform_data sdp3630_twldata = {
> +	.irq_base	= TWL4030_IRQ_BASE,
> +	.irq_end	= TWL4030_IRQ_END,
> +
> +	/* platform_data for children goes here */
> +	.bci		= &sdp3630_bci_data,
> +	.madc		= &sdp3630_madc_data,
> +	.usb		= &sdp3630_usb_data,
> +	.keypad		= &sdp3630_kp_twl4030_data,
> +
> +};
> +
> +static struct i2c_board_info __initdata sdp3630_i2c_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("twl4030", 0x48),
> +		.flags		= I2C_CLIENT_WAKE,
> +		.irq		= INT_34XX_SYS_NIRQ,
> +		.platform_data	= &sdp3630_twldata,
> +	},
> +};
> +
> +static int __init omap_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 2600, sdp3630_i2c_boardinfo,
> +			ARRAY_SIZE(sdp3630_i2c_boardinfo));
> +	omap_register_i2c_bus(2, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	return 0;
> +}
> +
> +static void __init omap_sdp3630_init(void)
> +{
> +	omap_i2c_init();
> +	omap_serial_init();
> +	usb_musb_init();
> +}
> +
> +static void __init omap_sdp3630_map_io(void)
> +{
> +	omap2_set_globals_343x();
> +	omap2_map_common_io();
> +}
> +
> +MACHINE_START(OMAP_3630SDP, "OMAP SDP3630 board")
> +	.phys_io	= 0x48000000,
> +	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
> +	.boot_params	= 0x80000100,
> +	.map_io		= omap_sdp3630_map_io,
> +	.init_irq	= omap_sdp3630_init_irq,
> +	.init_machine	= omap_sdp3630_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> +
> --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Regards,
Nishanth Menon

