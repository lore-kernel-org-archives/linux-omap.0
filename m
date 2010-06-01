From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 1/4] [OMAP1] Add MMC board code common to HTC devices
Date: Tue, 1 Jun 2010 08:33:03 -0700
Message-ID: <AANLkTilYNPttOPe24ZUw2kB6nDs9KRR1FfPx9nPfRvZL@mail.gmail.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
	<1275110887-2918-2-git-send-email-darkstar6262@gmail.com>
	<20100601101947.GB4085@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:55918 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab0FAPlW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 11:41:22 -0400
Received: by pzk15 with SMTP id 15so1528417pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 08:41:22 -0700 (PDT)
In-Reply-To: <20100601101947.GB4085@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

On Tue, Jun 1, 2010 at 3:19 AM, Ladislav Michl <Ladislav.Michl@seznam.c=
z> wrote:
> On Fri, May 28, 2010 at 10:28:04PM -0700, Cory Maccarrone wrote:
>> This change adds the htc-mmc.c and htc-mmc.h files that
>> contain common setup code for many OMAP850-based HTC
>> smartphones. =C2=A0This code is a port of the code used by
>> the linwizard project to support devices such as the
>> HTC Wizard, HTC Herald, HTC Opal, etc.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap1/htc-mmc.c | =C2=A0104 ++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0arch/arm/mach-omap1/htc-mmc.h | =C2=A0 26 ++++++++++
>> =C2=A02 files changed, 130 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 arch/arm/mach-omap1/htc-mmc.c
>> =C2=A0create mode 100644 arch/arm/mach-omap1/htc-mmc.h
>>
>> diff --git a/arch/arm/mach-omap1/htc-mmc.c b/arch/arm/mach-omap1/htc=
-mmc.c
>> new file mode 100644
>> index 0000000..4fa8bb4
>> --- /dev/null
>> +++ b/arch/arm/mach-omap1/htc-mmc.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * linux/arch/arm/mach-omap1/htc-mmc.c
>> + *
>> + * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
>> + * Author: Felipe Balbi <felipe.lima@indt.org.br>
>> + *
>> + * This code is based on linux/arch/arm/mach-omap2/board-n800-mmc.c=
, which is:
>> + * Copyright (C) 2006 Nokia Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <plat/mmc.h>
>> +#include <asm/mach-types.h>
>> +
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
>> +
>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>> +
>> +#define OMAP_MMC_REG_SYSC (0xfffb7800 + 0x32)
>> +#define OMAP_MMC_REG_SYSS (0xfffb7800 + 0x34)
>
> Where are these used?
>
>> +static int slot_cover_open;
>> +static struct device *mmc_device;
>> +
>> +static int htc_mmc_set_power(struct device *dev, int slot, int powe=
r_on,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int vdd)
>> +{
>> +#ifdef CONFIG_MMC_DEBUG
>> + =C2=A0 =C2=A0 dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slo=
t + 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 power_on ? "on" : "off",=
 vdd);
>> +#endif
>> + =C2=A0 =C2=A0 if (slot !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "No such sl=
ot %d\n", slot + 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> No-op?
>
>> +static int htc_mmc_set_bus_mode(struct device *dev, int slot, int b=
us_mode)
>> +{
>> +#ifdef CONFIG_MMC_DEBUG
>> + =C2=A0 =C2=A0 dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_mode =3D=3D MMC_BUSM=
ODE_OPENDRAIN ? "open-drain" : "push-pull");
>> +#endif
>> + =C2=A0 =C2=A0 if (slot !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "No such sl=
ot %d\n", slot + 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* Treated on upper level */
>> +
>> + =C2=A0 =C2=A0 return bus_mode;
>> +}
>> +
>> +static int htc_mmc_get_cover_state(struct device *dev, int slot)
>> +{
>> + =C2=A0 =C2=A0 BUG_ON(slot !=3D 0);
>> + =C2=A0 =C2=A0 return slot_cover_open;
>> +}
>
> Just a complicated way to return zero...
>
>> +static int htc_mmc_late_init(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 mmc_device =3D dev;
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> What is this good for?
>
>> +static void htc_mmc_cleanup(struct device *dev)
>> +{
>> +}
>> +
>> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
>> + =C2=A0 =C2=A0 .nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> + =C2=A0 =C2=A0 .switch_slot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
>> + =C2=A0 =C2=A0 .init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D htc_mmc_late_init,
>> + =C2=A0 =C2=A0 .cleanup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D htc_mmc_cleanup,
>> + =C2=A0 =C2=A0 .slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_power =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D htc_mmc_set_power,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_bus_mode =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D htc_mmc_set_bus_mode,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_ro =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NULL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_cover_state =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D htc_mmc_get_cover_state,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_=
VDD_32_33 | MMC_VDD_33_34,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nomux =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wires =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .switch_pin =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,
>> + =C2=A0 =C2=A0 },
>> +};
>
> To me above seems completely no-op, so it could be simplified this wa=
y:
> static struct omap_mmc_platform_data htc_mmc1_data =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.switch_slot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ocr_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_=
30_31 |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MMC_VDD_32_33 | MMC_VDD_33_34,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.nomux =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.wires =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.switch_pin =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> };
>
> Now, once this file contains only one structure definition, is it wor=
th
> to let it exist at all? What about adding it to board-htcherald.c ins=
tead?
>
>> +
>> +static struct omap_mmc_platform_data *htc_mmc_data[1];
>> +
>> +void __init htc_mmc_init(void)
>> +{
>> + =C2=A0 =C2=A0 /* register it */
>> + =C2=A0 =C2=A0 htc_mmc_data[0] =3D &htc_mmc1_data;
>> + =C2=A0 =C2=A0 omap1_init_mmc(htc_mmc_data, 1);
>> +}
>> +#endif
>> +
>> diff --git a/arch/arm/mach-omap1/htc-mmc.h b/arch/arm/mach-omap1/htc=
-mmc.h
>> new file mode 100644
>> index 0000000..480de14
>> --- /dev/null
>> +++ b/arch/arm/mach-omap1/htc-mmc.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * linux/arch/arm/mach-omap1/htc-mmc.h
>> + *
>> + * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
>> + * Author: Felipe Balbi <felipe.lima@indt.org.br>
>> + *
>> + * This code is based on linux/arch/arm/mach-omap2/board-n800-mmc.c=
, which is:
>> + * Copyright (C) 2006 Nokia Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef __HTC_MMC_H
>> +#define __HTC_MMC_H
>> +
>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>> +extern void htc_mmc_init(void);
>> +#else
>> +static inline void htc_mmc_init(void)
>> +{
>> +}
>> +#endif
>> +
>> +#endif /* __HTC_MMC_H */
>> +
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>

Thanks for the feedback.  I had originally intended this code to be
used by other devices that have yet to be submitted, but looking at
your comments, you're right -- most of that is a no-op.  It can very
easily be moved directly into the board file.

This patch can be disregarded, and I'll submit a revised version of
patch 4 for the herald.

Thanks.
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
