From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Generic TRITON power scripts for OMAP3 based boards.
Date: Thu, 7 Jan 2010 09:31:28 -0600
Message-ID: <4B45FE50.6040904@ti.com>
References: <1262860355-28099-1-git-send-email-x0080970@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35714 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab0AGPbe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 10:31:34 -0500
In-Reply-To: <1262860355-28099-1-git-send-email-x0080970@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <x0080970@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

Manuel, Lesly Arackal had written, on 01/07/2010 04:32 AM, the following:
> Changes to move the voltsetup_time & sleep/wakeup/warm_rest sequence moved to new file.
thanks for the same.

> 
> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: nm@ti.com
normally the format is:
Cc: Nishanth Menon <nm@ti.com>
> Cc: dderrick@ti.com
> Cc: sameo@linux.intel.com
> ---
>  arch/arm/mach-omap2/Makefile                 |   12 ++-
>  arch/arm/mach-omap2/board-3430sdp.c          |   99 +++++---------------
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   98 +++++---------------

would be good if you introduce the specific board changes as a seperate 
patch in the series.

>  arch/arm/mach-omap2/twl4030-script.c         |  126 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl4030-script.h         |   12 +++
>  5 files changed, 194 insertions(+), 153 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/twl4030-script.c
>  create mode 100644 arch/arm/mach-omap2/twl4030-script.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index a08aa62..f681325 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -92,7 +92,8 @@ obj-$(CONFIG_MACH_OMAP3EVM)           += board-omap3evm.o \
>  obj-$(CONFIG_MACH_OMAP3_PANDORA)       += board-omap3pandora.o \
>                                            mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)                += board-3430sdp.o \
> -                                          mmc-twl4030.o
> +                                          mmc-twl4030.o \
> +                                          twl4030-script.o
>  obj-$(CONFIG_MACH_NOKIA_N8X0)          += board-n8x0.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)          += board-rx51.o \
>                                            board-rx51-sdram.o \
> @@ -101,14 +102,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)             += board-rx51.o \
>  obj-$(CONFIG_MACH_OMAP_ZOOM2)          += board-zoom2.o \
>                                            board-zoom-peripherals.o \
>                                            mmc-twl4030.o \
> -                                          board-zoom-debugboard.o
> +                                          board-zoom-debugboard.o \
> +                                          twl4030-script.o
>  obj-$(CONFIG_MACH_OMAP_ZOOM3)          += board-zoom3.o \
>                                            board-zoom-peripherals.o \
>                                            mmc-twl4030.o \
> -                                          board-zoom-debugboard.o
> +                                          board-zoom-debugboard.o \
> +                                          twl4030-script.o
>  obj-$(CONFIG_MACH_OMAP_3630SDP)                += board-3630sdp.o \
>                                            board-zoom-peripherals.o \
> -                                          mmc-twl4030.o
> +                                          mmc-twl4030.o \
> +                                          twl4030-script.o

how about doing:
obj-$(CONFIG_TWL4030_DEFAULT_POWER_SCRIPT) += twl4030-script.o

and introduce TWL4030_DEFAULT_POWER_SCRIPT as Kconfig option?

>  obj-$(CONFIG_MACH_CM_T35)              += board-cm-t35.o \
>                                            mmc-twl4030.o
>  obj-$(CONFIG_MACH_IGEP0020)            += board-igep0020.o \
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 7ded90f..c89073f 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -46,6 +46,7 @@
>  #include "mux.h"
>  #include "sdram-qimonda-hyb18m512160af-6.h"
>  #include "mmc-twl4030.h"
> +#include "twl4030-script.h"
>  #include "pm.h"
>  #include "omap3-opp.h"
> 
> @@ -446,79 +447,6 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
>         .irq_line       = 1,
>  };
> 
> -
> -static struct twl4030_ins __initdata sleep_on_seq[] = {
> -       /* Broadcast message to put res to sleep */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_SLEEP), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_SLEEP), 2},
> -};
> -
> -static struct twl4030_script sleep_on_script __initdata = {
> -       .script = sleep_on_seq,
> -       .size   = ARRAY_SIZE(sleep_on_seq),
> -       .flags  = TWL4030_SLEEP_SCRIPT,
> -};
> -
> -static struct twl4030_ins wakeup_p12_seq[] __initdata = {
> -       /* Broadcast message to put res to active */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_ACTIVE), 2},
> -};
> -
> -static struct twl4030_script wakeup_p12_script __initdata = {
> -       .script = wakeup_p12_seq,
> -       .size   = ARRAY_SIZE(wakeup_p12_seq),
> -       .flags  = TWL4030_WAKEUP12_SCRIPT,
> -};
> -
> -static struct twl4030_ins wakeup_p3_seq[] __initdata = {
> -       /* Broadcast message to put res to active */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_ACTIVE), 2},
> -};
> -
> -static struct twl4030_script wakeup_p3_script __initdata = {
> -       .script = wakeup_p3_seq,
> -       .size   = ARRAY_SIZE(wakeup_p3_seq),
> -       .flags  = TWL4030_WAKEUP3_SCRIPT,
> -};
> -
> -static struct twl4030_ins wrst_seq[] __initdata = {
> -/*
> - * Reset twl4030.
> - * Reset Main_Ref.
> - * Reset All type2_group2.
> - * Reset VUSB_3v1.
> - * Reset All type2_group1.
> - * Reset RC.
> - * Reenable twl4030.
> - */
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1c, RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x13, RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> -};
> -static struct twl4030_script wrst_script __initdata = {
> -       .script = wrst_seq,
> -       .size   = ARRAY_SIZE(wrst_seq),
> -       .flags  = TWL4030_WRST_SCRIPT,
> -};
> -
> -static struct twl4030_script *twl4030_scripts[] __initdata = {
> -       &sleep_on_script,
> -       &wakeup_p12_script,
> -       &wakeup_p3_script,
> -       &wrst_script,
> -};
> -
>  static struct twl4030_resconfig twl4030_rconfig[] = {
>         { .resource = RES_VPLL1, .devgroup = DEV_GRP_P1, .type = 3,
>                 .type2 = 1, .remap_sleep = RES_STATE_OFF },
> @@ -548,11 +476,29 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
>  };
> 
>  static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
> -       .scripts        = twl4030_scripts,
> -       .num            = ARRAY_SIZE(twl4030_scripts),
>         .resource_config = twl4030_rconfig,
>  };
> 
> +#ifdef CONFIG_TWL4030_POWER
> +static void use_generic_twl4030_script(void)
> +{
> +       omap3_setuptime_table.voltsetup_time1_ret =
> +                               twl4030_voltsetup_time.voltsetup_time1_ret;
> +       omap3_setuptime_table.voltsetup_time2_ret =
> +                               twl4030_voltsetup_time.voltsetup_time2_ret;
> +       omap3_setuptime_table.voltsetup_time1_off =
> +                               twl4030_voltsetup_time.voltsetup_time1_off;
> +       omap3_setuptime_table.voltsetup_time2_off =
> +                               twl4030_voltsetup_time.voltsetup_time1_off;
> +
> +       omap3_setuptime_table.voltoffset = twl4030_voltsetup_time.voltoffset;
> +       omap3_setuptime_table.voltsetup2 = twl4030_voltsetup_time.voltsetup2;
> +
> +       sdp3430_t2scripts_data.scripts = twl4030_generic_script.scripts;
> +       sdp3430_t2scripts_data.num = twl4030_generic_script.num;
> +}
> +#endif
> +
>  /*
>   * Apply all the fixed voltages since most versions of U-Boot
>   * don't bother with that initialization.
> @@ -806,6 +752,9 @@ static struct omap_board_mux board_mux[] __initdata = {
> 
>  static void __init omap_3430sdp_init(void)
>  {
> +#ifdef CONFIG_TWL4030_POWER
> +       use_generic_twl4030_script();
> +#endif
>         omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>         omap3430_i2c_init();
>         platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index de68cd3..ae09e29 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -26,6 +26,7 @@
> 
>  #include "mux.h"
>  #include "mmc-twl4030.h"
> +#include "twl4030-script.h"
>  #include "pm.h"
> 
>  /* FIXME: These are not the optimal setup values */
> @@ -118,78 +119,6 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
>         .rep            = 1,
>  };
> 
> -static struct twl4030_ins __initdata sleep_on_seq[] = {
> -       /* Broadcast message to put res to sleep */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_SLEEP), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_SLEEP), 2},
> -};
> -
> -static struct twl4030_script sleep_on_script __initdata = {
> -       .script = sleep_on_seq,
> -       .size   = ARRAY_SIZE(sleep_on_seq),
> -       .flags  = TWL4030_SLEEP_SCRIPT,
> -};
> -
> -static struct twl4030_ins wakeup_p12_seq[] __initdata = {
> -       /* Broadcast message to put res to active */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_ACTIVE), 2},
> -};
> -
> -static struct twl4030_script wakeup_p12_script __initdata = {
> -       .script = wakeup_p12_seq,
> -       .size   = ARRAY_SIZE(wakeup_p12_seq),
> -       .flags  = TWL4030_WAKEUP12_SCRIPT,
> -};
> -
> -static struct twl4030_ins wakeup_p3_seq[] __initdata = {
> -       /* Broadcast message to put res to active */
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_ACTIVE), 2},
> -};
> -
> -static struct twl4030_script wakeup_p3_script __initdata = {
> -       .script = wakeup_p3_seq,
> -       .size   = ARRAY_SIZE(wakeup_p3_seq),
> -       .flags  = TWL4030_WAKEUP3_SCRIPT,
> -};
> -
> -static struct twl4030_ins wrst_seq[] __initdata = {
> -/*
> - * Reset twl4030.
> - * Reset Main_Ref.
> - * Reset All type2_group2.
> - * Reset VUSB_3v1.
> - * Reset All type2_group1.
> - * Reset RC.
> - * Reenable twl4030.
> - */
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1c, RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x13, RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
> -                                                       RES_STATE_WRST), 2},
> -       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> -};
> -static struct twl4030_script wrst_script __initdata = {
> -       .script = wrst_seq,
> -       .size   = ARRAY_SIZE(wrst_seq),
> -       .flags  = TWL4030_WRST_SCRIPT,
> -};
> -
> -static struct twl4030_script *twl4030_scripts[] __initdata = {
> -       &sleep_on_script,
> -       &wakeup_p12_script,
> -       &wakeup_p3_script,
> -       &wrst_script,
> -};
> -
>  static struct twl4030_resconfig twl4030_rconfig[] = {
>         { .resource = RES_VPLL1, .devgroup = DEV_GRP_P1, .type = 3,
>                 .type2 = 1, .remap_sleep = RES_STATE_OFF },
> @@ -219,11 +148,29 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
>  };
> 
>  static struct twl4030_power_data zoom_t2scripts_data __initdata = {
> -       .scripts        = twl4030_scripts,
> -       .num            = ARRAY_SIZE(twl4030_scripts),
>         .resource_config = twl4030_rconfig,
>  };
> 
> +#ifdef CONFIG_TWL4030_POWER
> +static void use_generic_twl4030_script(void)
> +{
> +       omap3_setuptime_table.voltsetup_time1_ret =
> +                               twl4030_voltsetup_time.voltsetup_time1_ret;
> +       omap3_setuptime_table.voltsetup_time2_ret =
> +                               twl4030_voltsetup_time.voltsetup_time2_ret;
> +       omap3_setuptime_table.voltsetup_time1_off =
> +                               twl4030_voltsetup_time.voltsetup_time1_off;
> +       omap3_setuptime_table.voltsetup_time2_off =
> +                               twl4030_voltsetup_time.voltsetup_time1_off;
> +
> +       omap3_setuptime_table.voltoffset = twl4030_voltsetup_time.voltoffset;
> +       omap3_setuptime_table.voltsetup2 = twl4030_voltsetup_time.voltsetup2;
> +
> +       zoom_t2scripts_data.scripts = twl4030_generic_script.scripts;
> +       zoom_t2scripts_data.num = twl4030_generic_script.num;
> +}
> +#endif
> +
>  static struct regulator_consumer_supply zoom_vmmc1_supply = {
>         .supply         = "vmmc",
>  };
> @@ -404,6 +351,9 @@ static void enable_board_wakeup_source(void)
> 
>  void __init zoom_peripherals_init(void)
>  {
> +#ifdef CONFIG_TWL4030_POWER
> +       use_generic_twl4030_script();
> +#endif
>         omap_i2c_init();
>         omap_serial_init();
>         usb_musb_init();
> diff --git a/arch/arm/mach-omap2/twl4030-script.c b/arch/arm/mach-omap2/twl4030-script.c
> new file mode 100644
> index 0000000..365d0ea
> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl4030-script.c
> @@ -0,0 +1,126 @@
> +/*
> + * linux/arch/arm/mach-omap2/twl4030-script.c
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifdef CONFIG_TWL4030_POWER
> +
> +#include "twl4030-script.h"
> +
> +/* FIXME: These are not the optimal setup values */
> +struct prm_setup_vc twl4030_voltsetup_time = {
> +       /* VOLT SETUPTIME for RET & OFF */
> +       .voltsetup_time1_ret = 0x005B,
> +       .voltsetup_time2_ret = 0x0055,
> +       .voltsetup_time1_off = 0x00B3,
> +       .voltsetup_time2_off = 0x00A0,
> +       .voltoffset = 0x118,
> +       .voltsetup2 = 0x32,

Magic numbers?? do these stand good for all oscillator variations on 
different boards?
also:
How do we handle the delta b/w 3630 and 3430?

> +};
> +
> +/*
> + * Sequence to controll the TRITON Power resources,
                   ^^^^^^^^ spell check
> + * when the system goes into sleep.
> + * Executed upon P1_P2/P3 transition for sleep.
> + */
> +static struct twl4030_ins __initdata sleep_on_seq[] = {
> +       /* Broadcast message to put res to sleep */
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +                                                       RES_STATE_SLEEP), 2},
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +                                                       RES_STATE_SLEEP), 2},
> +};
> +
> +static struct twl4030_script sleep_on_script __initdata = {
> +       .script = sleep_on_seq,
> +       .size   = ARRAY_SIZE(sleep_on_seq),
> +       .flags  = TWL4030_SLEEP_SCRIPT,
> +};
> +
> +/*
> + * Sequence to controll the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P1_P2 transition for wakeup.
> + */
> +static struct twl4030_ins wakeup_p12_seq[] __initdata = {
> +       /* Broadcast message to put res to active */
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +                                                       RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wakeup_p12_script __initdata = {
> +       .script = wakeup_p12_seq,
> +       .size   = ARRAY_SIZE(wakeup_p12_seq),
> +       .flags  = TWL4030_WAKEUP12_SCRIPT,
> +};
> +
> +/*
> + * Sequence to controll the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P3 transition for wakeup.
> + */
> +static struct twl4030_ins wakeup_p3_seq[] __initdata = {
> +       /* Broadcast message to put res to active */
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +                                                       RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wakeup_p3_script __initdata = {
> +       .script = wakeup_p3_seq,
> +       .size   = ARRAY_SIZE(wakeup_p3_seq),
> +       .flags  = TWL4030_WAKEUP3_SCRIPT,
> +};
> +
> +/*
> + * Sequence to reset the TRITON Power resources,
> + * when the system gets warm reset.
> + * Executed upon warm reset signal.
> + */
> +static struct twl4030_ins wrst_seq[] __initdata = {
> +/*
> + * Reset twl4030.
> + * Reset Main_Ref.
> + * Reset All type2_group2.
> + * Reset VUSB_3v1.
> + * Reset All type2_group1.
> + * Reset RC.
> + * Reenable twl4030.
> + */
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1c, RES_STATE_WRST), 2},
                                       ^^^^ Magic numbers!!

> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +                                                       RES_STATE_WRST), 2},
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x13, RES_STATE_WRST), 2},
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +                                                       RES_STATE_WRST), 2},
> +       {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
> +                                                       RES_STATE_WRST), 2},
> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
                                       ^^^^ More Magic numbers!!
> +};
> +
> +static struct twl4030_script wrst_script __initdata = {
> +       .script = wrst_seq,
> +       .size   = ARRAY_SIZE(wrst_seq),
> +       .flags  = TWL4030_WRST_SCRIPT,
> +};
> +
> +/* TRITON script for sleep, wakeup & warm_reset */
> +static struct twl4030_script *twl4030_scripts[] __initdata = {
> +       &sleep_on_script,
> +       &wakeup_p12_script,
> +       &wakeup_p3_script,
> +       &wrst_script,
> +};
> +
> +struct twl4030_power_data twl4030_generic_script __initdata = {
> +       .scripts        = twl4030_scripts,
> +       .num            = ARRAY_SIZE(twl4030_scripts),
> +};
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/twl4030-script.h b/arch/arm/mach-omap2/twl4030-script.h
> new file mode 100644
> index 0000000..43dae35
> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl4030-script.h
> @@ -0,0 +1,12 @@
> +#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
> +#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
> +
> +#include <linux/i2c/twl.h>
> +#include "pm.h"
> +
> +#ifdef CONFIG_TWL4030_POWER
> +extern struct prm_setup_vc twl4030_voltsetup_time;
> +extern struct twl4030_power_data twl4030_generic_script;

api's might be better compared to exporting structs..


> +#endif
> +
> +#endif
> --
> 1.6.0.4
> 
> 

in general if you could describe what you are doing with the scripts, it 
will help the readers.

-- 
Regards,
Nishanth Menon
