From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Mon, 20 Dec 2010 11:28:08 +0100
Message-ID: <AANLkTi=rT+tAzm7Dd3KUvoQM0Nn+X110+pfYcUqmGKY=@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35890 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0LTK2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:28:09 -0500
Received: by qwa26 with SMTP id 26so2628266qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:28:08 -0800 (PST)
In-Reply-To: <1292712817-24999-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
> This disables L2 cache before invalidating it and reenables it afterw=
ards.
> This is be done according to ARM documentation. Currently this is ide=
ntified
> as being needed on OMAP3630 as the disable/enable is done from "publi=
c side"
> while, on OMAP3430, this is done in the "secure side".
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> [nm@ti.com: ported to 2.6.37-rc2, added hooks to enable the logic onl=
y on 3630]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Acked-by: Jean Pihet <j-pihet@ti.com>

> ---
> v4: rebased only. no functional change
> v3: http://marc.info/?l=3Dlinux-omap&m=3D129139583519221&w=3D2
> collate all silicon specific errata under a single cpu detection code
> =A0 =A0 =A0 =A0making it elegant and more maintainable.
> v2: https://patchwork.kernel.org/patch/365232/
> =A0 =A0 =A0 =A0rebased out to this series independent of HS bugfixes
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013171125204&w=3D2
>
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 =A05 ++++-
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 30 +++++++++++++++++++++++++=
+++++
> =A03 files changed, 36 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 8d9aa3e..5e0bee9 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -90,8 +90,10 @@ extern unsigned int omap34xx_cpu_suspend_sz;
> =A0#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
> =A0extern u16 pm34xx_errata;
> =A0#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A0(pm34xx_errata & =
(id))
> +extern void enable_omap3630_toggle_l2_on_restore(void);
> =A0#else
> =A0#define IS_PM34XX_ERRATUM(id) =A0 =A0 =A0 =A0 =A00
> +static inline void enable_omap3630_toggle_l2_on_restore(void) { }
> =A0#endif =A0 =A0 =A0 =A0 /* defined(CONFIG_PM) && defined(CONFIG_ARC=
H_OMAP3) */
>
> =A0#endif
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index b32a2ed..4ba7a06 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1007,8 +1007,11 @@ void omap_push_sram_idle(void)
>
> =A0static void __init pm_errata_configure(void)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap3630())
> + =A0 =A0 =A0 if (cpu_is_omap3630()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm34xx_errata |=3D PM_RTA_ERRATUM_i608=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the l2 cache toggling in slee=
p logic */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_omap3630_toggle_l2_on_restore();
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static int __init omap3_pm_init(void)
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index cc3507b..d2eda01 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -111,6 +111,19 @@ ENTRY(get_omap3630_restore_pointer_sz)
> =A0 =A0 =A0 =A0 .word =A0 . - get_omap3630_restore_pointer
>
> =A0 =A0 =A0 =A0.text
> +/*
> + * L2 cache needs to be toggled for stable OFF mode functionality on=
 3630.
> + * This function sets up a fflag that will allow for this toggling t=
o take
> + * place on 3630. Hopefully some version in the future maynot need t=
his
> + */
> +ENTRY(enable_omap3630_toggle_l2_on_restore)
> + =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 @ save registers on stac=
k
> + =A0 =A0 =A0 /* Setup so that we will disable and enable l2 */
> + =A0 =A0 =A0 mov =A0 =A0 r1, #0x1
> + =A0 =A0 =A0 str =A0 =A0 r1, l2dis_3630
> + =A0 =A0 =A0 =A0ldmfd =A0 sp!, {pc} =A0 =A0 @ restore regs and retur=
n
> +
> + =A0 =A0 =A0 .text
> =A0/* Function call to get the restore pointer for for ES3 to resume =
from OFF */
> =A0ENTRY(get_es3_restore_pointer)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {lr} =A0 =A0 =A0 @ save registers on st=
ack
> @@ -283,6 +296,14 @@ restore:
> =A0 =A0 =A0 =A0 moveq =A0 r9, #0x3 =A0 =A0 =A0 =A0@ MPU OFF =3D> L1 a=
nd L2 lost
> =A0 =A0 =A0 =A0movne =A0 r9, #0x1 =A0 =A0 =A0 =A0@ Only L1 and L2 los=
t =3D> avoid L2 invalidation
> =A0 =A0 =A0 =A0bne =A0 =A0 logic_l1_restore
> +
> + =A0 =A0 =A0 ldr =A0 =A0 r0, l2dis_3630
> + =A0 =A0 =A0 cmp =A0 =A0 r0, #0x1 =A0 =A0 =A0 =A0@ should we disable=
 L2 on 3630?
> + =A0 =A0 =A0 bne =A0 =A0 skipl2dis
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r0, c1, c0, 1
> + =A0 =A0 =A0 bic =A0 =A0 r0, r0, #2 =A0 =A0 =A0@ disable L2 cache
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 1
> +skipl2dis:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r0, control_stat
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, [r0]
> =A0 =A0 =A0 =A0and =A0 =A0 r1, #0x700
> @@ -343,6 +364,13 @@ smi: =A0 =A0.word 0xE1600070 =A0 =A0 =A0 =A0 =A0=
 @ Call SMI monitor (smieq)
> =A0 =A0 =A0 =A0mov =A0 =A0 r12, #0x2
> =A0 =A0 =A0 =A0.word 0xE1600070 =A0 =A0 =A0 =A0@ Call SMI monitor (sm=
ieq)
> =A0logic_l1_restore:
> + =A0 =A0 =A0 ldr =A0 =A0 r1, l2dis_3630
> + =A0 =A0 =A0 cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0@ Do we need to re-=
enable L2 on 3630?
> + =A0 =A0 =A0 bne =A0 =A0 skipl2reen
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r1, c1, c0, 1
> + =A0 =A0 =A0 orr =A0 =A0 r1, r1, #2 =A0 =A0 =A0@ re-enable L2 cache
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c1, c0, 1
> +skipl2reen:
> =A0 =A0 =A0 =A0mov =A0 =A0 r1, #0
> =A0 =A0 =A0 =A0/* Invalidate all instruction caches to PoU
> =A0 =A0 =A0 =A0 * and flush branch target cache */
> @@ -678,6 +706,8 @@ control_mem_rta:
> =A0 =A0 =A0 =A0.word =A0 CONTROL_MEM_RTA_CTRL
> =A0kernel_flush:
> =A0 =A0 =A0 =A0.word v7_flush_dcache_all
> +l2dis_3630:
> + =A0 =A0 =A0 .word 0
> =A0 =A0 =A0 =A0/* these 2 words need to be at the end !!! */
> =A0kick_counter:
> =A0 =A0 =A0 =A0.word =A0 0
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
