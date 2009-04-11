From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [RFC] Save HSMMC registers if core is powered off
Date: Sat, 11 Apr 2009 02:04:15 -0700
Message-ID: <f9d2a5e10904110204x30662644se51ac24c7f94fbcf@mail.gmail.com>
References: <1239435130-30784-1-git-send-email-Russ.Dill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:32926 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbZDKJEQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Apr 2009 05:04:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1370845rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Apr 2009 02:04:15 -0700 (PDT)
In-Reply-To: <1239435130-30784-1-git-send-email-Russ.Dill@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com, linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@gmail.com>

On Sat, Apr 11, 2009 at 12:32 AM, Russ Dill <russ.dill@gmail.com> wrote=
:
> I've noticed that if the core power domain gets powered off during
> suspend, the MMC registers get reset. Which, among other things cause=
s
> the MMC host controller code to turn on VMMC1 even if no MMC card is
> present.
>
> I'm not sure if this is the right place to put this code. It also
> doesn't work. If any of the __raw_readl commands execute, the board w=
ill
> hang on a suspend attempt (assuming the core domain will be powered
> off.) Strangely, the __raw_writel commands don't cause problems (othe=
r
> than writing 0s to all the MMC registers.)

That would be because omap_mmc_suspend disables the interface clock.
The suspend method is a more logical place to save these registers,
but I'm not sure how to tell from the suspend method if the domain is
going to be turned off or not.

> My platform is an OMAP3430 on a rev B7 Beagleboard. The patch is agai=
nst
> omap/pm.
> ---
> =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-omap2/hsmmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 73 +++++++++++++++++++++++++++++++
> =C2=A0arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A05 ++
> =C2=A0arch/arm/plat-omap/include/mach/hsmmc.h | =C2=A0 15 ++++++
> =C2=A04 files changed, 94 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/mach-omap2/hsmmc.c
> =C2=A0create mode 100644 arch/arm/plat-omap/include/mach/hsmmc.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index c58bab4..4dd8ec0 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -24,6 +24,7 @@ obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D=
 pm.o
> =C2=A0obj-$(CONFIG_ARCH_OMAP2) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +=3D pm24xx.o
> =C2=A0obj-$(CONFIG_ARCH_OMAP24XX) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D sleep24xx.o
> =C2=A0obj-$(CONFIG_ARCH_OMAP3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +=3D pm34xx.o sleep34xx.o cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +=3D hsmmc.o
> =C2=A0obj-$(CONFIG_PM_DEBUG) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +=3D pm-debug.o
> =C2=A0endif
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> new file mode 100644
> index 0000000..9ac6f91
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -0,0 +1,73 @@
> +/*
> + * HSMMC context save/restore functions
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <asm/io.h>
> +
> +#include <mach/mmc.h>
> +
> +#define HSMMC_SYSCONFIG =C2=A0 =C2=A0 =C2=A0 =C2=A00x0010
> +#define HSMMC_CON =C2=A0 =C2=A0 =C2=A00x002c
> +#define HSMMC_HCTL =C2=A0 =C2=A0 0x0128
> +#define HSMMC_SYSCTL =C2=A0 0x012c
> +#define HSMMC_IE =C2=A0 =C2=A0 =C2=A0 0x0134
> +#define HSMMC_ISE =C2=A0 =C2=A0 =C2=A00x0138
> +
> +static const void __iomem *instances[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 OMAP2_IO_ADDRESS(OMAP2_MMC1_BASE),
> + =C2=A0 =C2=A0 =C2=A0 OMAP2_IO_ADDRESS(OMAP2_MMC2_BASE),
> + =C2=A0 =C2=A0 =C2=A0 OMAP2_IO_ADDRESS(OMAP3_MMC3_BASE),
> +};
> +
> +struct omap3_hsmmc_regs {
> + =C2=A0 =C2=A0 =C2=A0 u32 sysconfig;
> + =C2=A0 =C2=A0 =C2=A0 u32 con;
> + =C2=A0 =C2=A0 =C2=A0 u32 hctl;
> + =C2=A0 =C2=A0 =C2=A0 u32 sysctl;
> + =C2=A0 =C2=A0 =C2=A0 u32 ie;
> + =C2=A0 =C2=A0 =C2=A0 u32 ise;
> +};
> +
> +static struct omap3_hsmmc_regs hsmmc_context[ARRAY_SIZE(instances)];
> +
> +static void hsmmc_write_reg(int id, int idx, u32 val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(val, instances[id] + idx);
> +}
> +
> +static u32 hsmmc_read_reg(int id, int idx)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;//__raw_readl(instances[id] + idx);
> +}
> +
> +void omap3_hsmmc_save_context(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(instances); i++) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].s=
ysconfig =3D hsmmc_read_reg(i, HSMMC_SYSCONFIG);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].c=
on =3D hsmmc_read_reg(i, HSMMC_CON);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].h=
ctl =3D hsmmc_read_reg(i, HSMMC_HCTL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].s=
ysctl =3D hsmmc_read_reg(i, HSMMC_SYSCTL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].i=
e =3D hsmmc_read_reg(i, HSMMC_IE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_context[i].i=
se =3D hsmmc_read_reg(i, HSMMC_ISE);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +void omap3_hsmmc_restore_context(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(instances); i++) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_SYSCONFIG, hsmmc_context[i].sysconfig);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_CON, hsmmc_context[i].con);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_HCTL, hsmmc_context[i].hctl);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_SYSCTL, hsmmc_context[i].sysctl);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_IE, hsmmc_context[i].ie);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsmmc_write_reg(i,=
 HSMMC_ISE, hsmmc_context[i].ise);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 7474cfa..b2393c5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -41,6 +41,7 @@
> =C2=A0#include <mach/sdrc.h>
> =C2=A0#include <mach/dma.h>
> =C2=A0#include <mach/gpmc.h>
> +#include <mach/hsmmc.h>
> =C2=A0#include <mach/dma.h>
> =C2=A0#include <asm/tlbflush.h>
>
> @@ -148,6 +149,8 @@ static void omap3_core_save_context(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_intc_save_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save the GPMC context */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_gpmc_save_context();
> + =C2=A0 =C2=A0 =C2=A0 /* Save the HSMMC context */
> + =C2=A0 =C2=A0 =C2=A0 omap3_hsmmc_save_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save the system control module context,=
 padconf already save above*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_control_save_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_dma_global_context_save();
> @@ -159,6 +162,8 @@ static void omap3_core_restore_context(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_control_restore_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restore the GPMC context */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_gpmc_restore_context();
> + =C2=A0 =C2=A0 =C2=A0 /* Restore the HSMMC context */
> + =C2=A0 =C2=A0 =C2=A0 omap3_hsmmc_restore_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restore the interrupt controller contex=
t */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_intc_restore_context();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_dma_global_context_restore();
> diff --git a/arch/arm/plat-omap/include/mach/hsmmc.h b/arch/arm/plat-=
omap/include/mach/hsmmc.h
> new file mode 100644
> index 0000000..ae3caee
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/hsmmc.h
> @@ -0,0 +1,15 @@
> +/*
> + * HSMMC save/restore logic for OMAP3
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __OMAP3_HSMMC_H
> +#define __OMAP3_HSMMC_H
> +
> +extern void omap3_hsmmc_save_context(void);
> +extern void omap3_hsmmc_restore_context(void);
> +
> +#endif
> --
> 1.6.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
