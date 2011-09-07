From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/8] OMAP3+: ABB: Adaptive Body-Bias structures & data
Date: Wed, 7 Sep 2011 21:57:55 +0200
Message-ID: <CAORVsuXpqMwKx8tBXYFtvy=yrF+AkUWrG6TKd5+zz195pdD9dg@mail.gmail.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
	<1309393560-8874-5-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f43.google.com ([209.85.212.43]:50780 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab1IGT54 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 15:57:56 -0400
Received: by vws10 with SMTP id 10so35216vws.2
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 12:57:55 -0700 (PDT)
In-Reply-To: <1309393560-8874-5-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

Hi Mike,

On Thu, Jun 30, 2011 at 2:25 AM, Mike Turquette <mturquette@ti.com> wro=
te:
> Due to voltage domain trimming and silicon characterstics some silico=
n
> may experience instability when operating at a high voltage. =A0To
> compensate for this an Adaptive Body-Bias ldo exists. =A0First featur=
ed in
> OMAP3630, the purpose of this ldo is to provide a voltage boost to PM=
OS
> backgates when a voltage domain is operating at a high OPP. =A0In thi=
s
> mode the ldo is said to be in Forward Body-Bias. =A0At OPPs within a
> nominal voltage range the ABB ldo is bypassed.
>
> This patch introduces the data structures needed to represent the ABB
> ldo's in the voltage layer, and populates the appropriate data for 36=
30
> and OMAP4. =A0Not all voltage domains have an ABB ldo, and OMAP34xx d=
oes
> not have it at all; in such cases the voltage data will be marked wit=
h
> OMAP_ABB_NO_LDO.
The OMAP_ABB_ macros are defined but not used in this patch set. Is
this intentional?
Should the opp_sel field get tested against OMAP_ABB_NO_LDO and if
true should the ABB operations be no-ops?

>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 | =A0 =A05 +-
> =A0arch/arm/mach-omap2/abb.h =A0 =A0 =A0 =A0 =A0| =A0 85 ++++++++++++=
++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/abb36xx_data.c | =A0 38 ++++++++++++++++
> =A0arch/arm/mach-omap2/abb44xx_data.c | =A0 44 ++++++++++++++++++
> =A04 files changed, 170 insertions(+), 2 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/abb.h
> =A0create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
> =A0create mode 100644 arch/arm/mach-omap2/abb44xx_data.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 2cbef35..7dbb4d5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -79,14 +79,15 @@ endif
> =A0# PRCM
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D prcm.o c=
m2xxx_3xxx.o prm2xxx_3xxx.o
> =A0obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D prcm.o c=
m2xxx_3xxx.o prm2xxx_3xxx.o \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0vc3xxx_data.o vp3xxx_data.o
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0vc3xxx_data.o vp3xxx_data.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0abb36xx_data.o
> =A0# XXX The presence of cm2xxx_3xxx.o on the line below is temporary=
 and
> =A0# will be removed once the OMAP4 part of the codebase is converted=
 to
> =A0# use OMAP4-specific PRCM functions.
> =A0obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D prcm.o c=
m2xxx_3xxx.o cminst44xx.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 cm44xx.o prcm_mpu44xx.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 prminst44xx.o vc44xx_data.o \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0vp44xx_data.o
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0vp44xx_data.o abb44xx_data.o
>
> =A0# OMAP voltage domains
> =A0ifeq ($(CONFIG_PM),y)
> diff --git a/arch/arm/mach-omap2/abb.h b/arch/arm/mach-omap2/abb.h
> new file mode 100644
> index 0000000..74f2044
> --- /dev/null
> +++ b/arch/arm/mach-omap2/abb.h
> @@ -0,0 +1,85 @@
> +/*
> + * OMAP Adaptive Body-Bias structure and macro definitions
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Mike Turquette <mturquette@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_ABB_H
> +#define __ARCH_ARM_MACH_OMAP2_ABB_H
> +
> +#include <linux/kernel.h>
> +
> +#include "voltage.h"
> +
> +/* NOMINAL_OPP bypasses the ABB ldo, FAST_OPP sets it to Forward Bod=
y-Bias */
> +#define OMAP_ABB_NOMINAL_OPP =A0 0
> +#define OMAP_ABB_FAST_OPP =A0 =A0 =A01
> +#define OMAP_ABB_NO_LDO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~0

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
