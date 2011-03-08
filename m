From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v8 3/7] omap3: pm: TWL4030 power scripts for OMAP3 boards
Date: Tue, 8 Mar 2011 21:33:32 +0530
Message-ID: <AANLkTikW_cgeh+YXLMfxex-AHY+PSCkj92tLwOdWh0zb@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com> <1299072653-13414-4-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:51377 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754782Ab1CHQDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 11:03:54 -0500
Received: by wyb34 with SMTP id 34so193602wyb.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 08:03:52 -0800 (PST)
In-Reply-To: <1299072653-13414-4-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 2, 2011 at 19:00, Lesly A M <leslyam@ti.com> wrote:
[...]
> diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4=
030.c
> new file mode 100644
> index 0000000..ff344b3
> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl4030.c
> @@ -0,0 +1,145 @@
> +/*
> + * OMAP power script for PMIC TWL4030
> + *
> + * Author: Lesly A M <leslyam@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Lesly A M <leslyam@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifdef CONFIG_TWL4030_POWER

Why?

> +
> +#include "twl4030.h"
> +
> +/*
> + * Sequence to control the TRITON Power resources,
> + * when the system goes into sleep.
> + * Executed upon P1_P2/P3 transition for sleep.
> + */
try this:
=2E/scripts/kernel-doc --text arch/arm/mach-omap2/twl4030.c
Warning(arch/arm/mach-omap2/twl4030.c): no structured comments found

err... mebbe we need kernel doc styled comments here?

> +static struct twl4030_ins __initdata sleep_on_seq[] =3D {
does this sequence get triggered for RET or OFF from OMAP perspective?

> + =A0 =A0 =A0 /* Broadcast message to put res to sleep */
> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
At this point - we expect .type=3D0 and .type2=3D1 to go to sleep rt?
NRESPWRON is the only one that matched this criteria.

> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
At this point - we expect .type=3D0 and .type2=3D1 to go to sleep rt?
HFCLKOUT, VINTANA2 matches this criteria

Which rails are impacted by this? I tried mapping to a spread sheet
and may be lost :(
mebbe documenting it with reasoning why they are chosen will help
reviewers and future
code users understand this better.

> +};
> +
> +static struct twl4030_script sleep_on_script __initdata =3D {
> + =A0 =A0 =A0 .script =3D sleep_on_seq,
> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(sleep_on_seq),
> + =A0 =A0 =A0 .flags =A0=3D TWL4030_SLEEP_SCRIPT,
> +};
> +
> +/*
> + * Sequence to control the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P1_P2 transition for wakeup.
> + */
> +static struct twl4030_ins wakeup_p12_seq[] __initdata =3D {
> + =A0 =A0 =A0 /* Broadcast message to put res to active */
> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 2},
=2Etype=3D0 and .type2=3D1 are woken up rt?
NRESPWRON wokeup but we put HFCLKOUT and VINTANA2 to sleep - no wakeup
for those?

> +};
> +
> +static struct twl4030_script wakeup_p12_script __initdata =3D {
> + =A0 =A0 =A0 .script =3D wakeup_p12_seq,
> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(wakeup_p12_seq),
> + =A0 =A0 =A0 .flags =A0=3D TWL4030_WAKEUP12_SCRIPT,
> +};
> +
> +/*
> + * Sequence to control the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P3 transition for wakeup.

I need a bit of dumbing it down here - what is P3 transition? is it
waking from OFF/RET? is it follow on from P12 then P3?

> + */
> +static struct twl4030_ins wakeup_p3_seq[] __initdata =3D {
> + =A0 =A0 =A0 /* Broadcast message to put res to active */
> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 2},
ok - so we wakeup HFCLKOUT and VINTANA2 here - makes me wonder why we
chose VINTANA2 and not VINTANA1.

> +};
> +
> +static struct twl4030_script wakeup_p3_script __initdata =3D {
> + =A0 =A0 =A0 .script =3D wakeup_p3_seq,
> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(wakeup_p3_seq),
> + =A0 =A0 =A0 .flags =A0=3D TWL4030_WAKEUP3_SCRIPT,
> +};
> +
> +/*
> + * Sequence to reset the TRITON Power resources,
> + * when the system gets warm reset.
> + * Executed upon warm reset signal.
this one makes sense to me thanks.
> + */
> +static struct twl4030_ins wrst_seq[] __initdata =3D {
> +/*
> + * Reset twl4030.
Why should I reset twl4030 on warm reset? cant I just let the scripts
sit there while I detect (using some mechanism) that i have already
programmed the scripts, hence dont need to reprogram them again?

> + * Reset Main_Ref.
> + * Reset All type2_group2.
> + * Reset VUSB_3v1.
> + * Reset All type2_group1.
> + * Reset RC.
what is RC?
> + * Reenable twl4030.
re-enable?

but, I dont understand: why are these rails chosen? are *all*
platforms having the same rails? would there be variances?

> + */
> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), =
2},
> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_Main_Ref, RES_STATE_WRS=
T), 2},
s/RES_Main_Ref/RES_MAIN_REF ?

> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_WRST), 2},
> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_VUSB_3V1, RES_STATE_WRS=
T), 2},
> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, =
RES_TYPE2_R1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_WRST), 2},
> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, =
RES_TYPE2_R0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_WRST), 2},
> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE=
), 2},

I dont understand this sequence unfortunately. need documentation to
help me here.

> +};
> +
> +static struct twl4030_script wrst_script __initdata =3D {
> + =A0 =A0 =A0 .script =3D wrst_seq,
> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(wrst_seq),
> + =A0 =A0 =A0 .flags =A0=3D TWL4030_WRST_SCRIPT,
> +};
> +
> +/* TRITON script for sleep, wakeup & warm_reset */
> +static struct twl4030_script *twl4030_scripts[] __initdata =3D {
> + =A0 =A0 =A0 &wakeup_p12_script,
> + =A0 =A0 =A0 &wakeup_p3_script,
> + =A0 =A0 =A0 &sleep_on_script,
> + =A0 =A0 =A0 &wrst_script,
> +};
> +
> +static struct twl4030_resconfig twl4030_rconfig[] =3D {
overall, I recommend being explicit for the rails  -I believe VPLLs
are an example of that. rationale: imagine doing a OTA update: you'd
have the old scripts programmed in by the previous kernel, then the
new kernel starts up since we do a OMAP restart and not really a TWL
restart, we'd end up with a mixture of scripts in the system.  - this
is definitely a scenario to avoid - things like broadcast events like
those above going through to rails in the wrong groups can have
havoc..

> + =A0 =A0 =A0 { .resource =3D RES_VPLL1, .devgroup =3D DEV_GRP_P1, .t=
ype =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STAT=
E_OFF },
> + =A0 =A0 =A0 { .resource =3D RES_VINTANA1, .devgroup =3D DEV_GRP_ALL=
, .type =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_VINTANA2, .devgroup =3D DEV_GRP_ALL=
, .type =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_VINTDIG, .devgroup =3D DEV_GRP_ALL,=
 .type =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_VIO, .devgroup =3D DEV_GRP_ALL, .ty=
pe =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_VDD1, .devgroup =3D DEV_GRP_P1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 4, .type2 =3D 1, .remap_sleep=
 =3D RES_STATE_OFF },
> + =A0 =A0 =A0 { .resource =3D RES_VDD2, .devgroup =3D DEV_GRP_P1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 3, .type2 =3D 1, .remap_sleep=
 =3D RES_STATE_OFF },
> + =A0 =A0 =A0 { .resource =3D RES_REGEN, .devgroup =3D DEV_GRP_ALL, .=
type =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_NRES_PWRON, .devgroup =3D DEV_GRP_A=
LL, .type =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_CLKEN, .devgroup =3D DEV_GRP_ALL, .=
type =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_SYSEN, .devgroup =3D DEV_GRP_ALL, .=
type =3D 6,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STAT=
E_SLEEP },
> + =A0 =A0 =A0 { .resource =3D RES_HFCLKOUT, .devgroup =3D DEV_GRP_P3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 0, .type2 =3D 2, .remap_sleep=
 =3D RES_STATE_SLEEP },
> + =A0 =A0 =A0 { 0, 0},

Dumb q:  vpll2, vaux1-3, vmmc1-2,vsim,vdac,vsub1.5,1.8,3.1, regen,
32KHzclk, triton_ref and main_ref are other resources not covered in
the sequence? I think you either need to cover them OR document why
not and probably stuff like vaux, vmmc1-2 are responsibility of
drivers needs to be clearly stated.

> +};
> +
> +struct twl4030_power_data __initdata twl4030_generic_script =3D {
> + =A0 =A0 =A0 .scripts =A0 =A0 =A0 =A0=3D twl4030_scripts,
> + =A0 =A0 =A0 .num =A0 =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(twl4030_scri=
pts),
> + =A0 =A0 =A0 .resource_config =3D twl4030_rconfig,
> +};
> +#endif
> diff --git a/arch/arm/mach-omap2/twl4030.h b/arch/arm/mach-omap2/twl4=
030.h
> new file mode 100644
> index 0000000..ee66e7d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl4030.h
> @@ -0,0 +1,20 @@
> +/*
> + * OMAP TWL4030 power scripts header file
> + *
> + * Author: Lesly A M <x0080970@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
> +#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
> +
> +#include <linux/i2c/twl.h>
mebbe Kevin can comment if including header in header file is a good id=
ea..

> +
> +extern struct twl4030_power_data twl4030_generic_script;
what if TWL4030 was disabled?

> +#endif
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 61b9609..f4bd475 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -436,9 +436,23 @@ static inline int twl6030_mmc_card_detect(struct=
 device *dev, int slot)
>
> =A0/* Power bus message definitions */
>
> -/* The TWL4030/5030 splits its power-management resources (the vario=
us
> - * regulators, clock and reset lines) into 3 processor groups - P1, =
P2 and
> - * P3. These groups can then be configured to transition between sle=
ep, wait-on
> +/*
> + * The TWL4030/5030 splits its power-management resources (the vario=
us
> + * regulators, clock and reset lines) into 3 processor groups - P1, =
P2 and P3.
> + *
> + * Resources attached to device group P1 is managed depending on the=
 state of
> + * NSLEEP1 pin of TRITON, which is connected to sys_off signal from =
OMAP
> + *
> + * Resources attached to device group P2 is managed depending on the=
 state of
> + * NSLEEP2 pin of TRITON, which is can be connected to a modem or
> + * some other processor
how do these map to OMAP - remember - most of us are familiar with
OMAP and not TWL4030 :(

> + *
> + * Resources attached to device group P3 is managed depending on the=
 state of
> + * CLKREQ pin of TRITON, which is connected to clk request signal fr=
om OMAP
> + *
> + * If required these resources can be attached to combination of P1/=
P2/P3.
> + *
> + * These groups can then be configured to transition between sleep, =
wait-on
> =A0* and active states by sending messages to the power bus. =A0See S=
ection 5.4.2
> =A0* Power Resources of TWL4030 TRM
> =A0*/
> @@ -448,7 +462,17 @@ static inline int twl6030_mmc_card_detect(struct=
 device *dev, int slot)
> =A0#define DEV_GRP_P1 =A0 =A0 =A0 =A0 =A0 =A0 0x1 =A0 =A0 /* P1: all =
OMAP devices */
> =A0#define DEV_GRP_P2 =A0 =A0 =A0 =A0 =A0 =A0 0x2 =A0 =A0 /* P2: all =
Modem devices */
> =A0#define DEV_GRP_P3 =A0 =A0 =A0 =A0 =A0 =A0 0x4 =A0 =A0 /* P3: all =
peripheral devices */
> +#define DEV_GRP_ALL =A0 =A0 =A0 =A0 =A0 =A00x7 =A0 =A0 /* P1/P2/P3: =
all devices */
>
> +/*
> + * The 27 power resources in TRITON is again divided into
> + * analog resources:
> + * =A0 =A0 Power Providers - LDO regulators, dc-to-dc regulators
> + * =A0 =A0 Power Reference - analog reference
> + *
> + * and digital resources:
> + * =A0 =A0 Reset & Clock - reset and clock signals.
> + */
> =A0/* Resource groups */
> =A0#define RES_GRP_RES =A0 =A0 =A0 =A0 =A0 =A00x0 =A0 =A0 /* Reserved=
 */
> =A0#define RES_GRP_PP =A0 =A0 =A0 =A0 =A0 =A0 0x1 =A0 =A0 /* Power pr=
oviders */
> @@ -460,7 +484,10 @@ static inline int twl6030_mmc_card_detect(struct=
 device *dev, int slot)
> =A0#define RES_GRP_ALL =A0 =A0 =A0 =A0 =A0 =A00x7 =A0 =A0 /* All reso=
urce groups */
>
> =A0#define RES_TYPE2_R0 =A0 =A0 =A0 =A0 =A0 0x0
> +#define RES_TYPE2_R1 =A0 =A0 =A0 =A0 =A0 0x1
> +#define RES_TYPE2_R2 =A0 =A0 =A0 =A0 =A0 0x2
>
> +#define RES_TYPE_R0 =A0 =A0 =A0 =A0 =A0 =A00x0
> =A0#define RES_TYPE_ALL =A0 =A0 =A0 =A0 =A0 0x7
>
> =A0/* Resource states */
> --
> 1.7.1
>
>


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
