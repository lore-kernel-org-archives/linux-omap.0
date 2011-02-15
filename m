From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Tue, 15 Feb 2011 03:10:28 -0600
Message-ID: <AANLkTinSOUPZuDikusgnT99Qmqv8p+DNQu2Hu42N=yJb@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
	<13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
	<AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
	<33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
	<4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:45763 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab1BOJKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 04:10:32 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1F9AfpC021629
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:10:41 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1F9Aetn021605
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:10:40 -0500 (EST)
Received: by vxc38 with SMTP id 38so4152054vxc.15
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:10:28 -0800 (PST)
In-Reply-To: <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, Catalin Marinas <catalin.marinas@arm.com>

On Tue, Feb 15, 2011 at 1:14 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Monday, February 14, 2011 10:39 AM
>> To: Andrei Warkentin
>> Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Catalin Marinas
>> Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
>> operation can cause data corruption
>>
>
> [....]
>
>> > ...
>> I understood that from first comment. But I am not in favor
>> of polluting common ARM files with SOC specific #ifdeffery.
>> We have gone over this when first errata support
>> was added for PL310
>>
>> I have a better way to handle this scenario.
>> Expect an updated patch for this.
>>
>
> Below is the updated version which should remove any
> OMAP dependency on these errata's. Attached same.
>
> ----
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 14 Jan 2011 14:16:04 +0530
> Subject: [v2 PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operat=
ion
> can cause data corruption
>
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean & Invalidat=
e
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 ++++=
++++++++-
> =A0arch/arm/include/asm/outercache.h =A0| =A0 =A01 +
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0arch/arm/mach-omap2/omap4-common.c | =A0 =A07 +++++++
> =A0arch/arm/mm/cache-l2x0.c =A0 =A0 =A0 =A0 =A0 | =A0 28 ++++++++++++=
+++-------------
> =A05 files changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..ebadd95 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
>
> =A0config PL310_ERRATA_588369
> =A0 =A0 =A0 =A0bool "Clean & Invalidate maintenance operations do not=
 invalidate
> clean lines"
> - =A0 =A0 =A0 depends on CACHE_L2X0 && ARCH_OMAP4
> + =A0 =A0 =A0 depends on CACHE_L2X0 && CACHE_PL310
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0 The PL310 L2 cache controller implements three ty=
pes of Clean &
> =A0 =A0 =A0 =A0 =A0 Invalidate maintenance operations: by Physical Ad=
dress
> @@ -1177,6 +1177,17 @@ config ARM_ERRATA_743622
> =A0 =A0 =A0 =A0 =A0visible impact on the overall performance or power=
 consumption
> of the
> =A0 =A0 =A0 =A0 =A0processor.
>
> +config PL310_ERRATA_727915
> + =A0 =A0 =A0 bool "Background Clean & Invalidate by Way operation ca=
n cause
> data corruption"
> + =A0 =A0 =A0 depends on CACHE_L2X0 && CACHE_PL310
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 PL310 implements the Clean & Invalidate by Way L2 c=
ache
> maintenance
> + =A0 =A0 =A0 =A0 operation (offset 0x7FC). This operation runs in ba=
ckground so
> that
> + =A0 =A0 =A0 =A0 PL310 can handle normal accesses while it is in pro=
gress. Under
> very
> + =A0 =A0 =A0 =A0 rare circumstances, due to this erratum, write data=
 can be lost
> when
> + =A0 =A0 =A0 =A0 PL310 treats a cacheable write transaction during a=
 Clean &
> + =A0 =A0 =A0 =A0 Invalidate by Way operation Note that this errata u=
ses Texas
> + =A0 =A0 =A0 =A0 Instrument's secure monitor api to implement the wo=
rk around.
> =A0endmenu
>
> =A0source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/include/asm/outercache.h
> b/arch/arm/include/asm/outercache.h
> index fc19009..348d513 100644
> --- a/arch/arm/include/asm/outercache.h
> +++ b/arch/arm/include/asm/outercache.h
> @@ -31,6 +31,7 @@ struct outer_cache_fns {
> =A0#ifdef CONFIG_OUTER_CACHE_SYNC
> =A0 =A0 =A0 =A0void (*sync)(void);
> =A0#endif
> + =A0 =A0 =A0 void (*set_debug)(unsigned long);
> =A0};
>
> =A0#ifdef CONFIG_OUTER_CACHE
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index f285dd7..fd11ab4 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,7 +45,10 @@ config ARCH_OMAP4
> =A0 =A0 =A0 =A0select CPU_V7
> =A0 =A0 =A0 =A0select ARM_GIC
> =A0 =A0 =A0 =A0select LOCAL_TIMERS
> + =A0 =A0 =A0 select CACHE_L2X0
> + =A0 =A0 =A0 select CACHE_PL310
> =A0 =A0 =A0 =A0select PL310_ERRATA_588369
> + =A0 =A0 =A0 select PL310_ERRATA_727915
> =A0 =A0 =A0 =A0select ARM_ERRATA_720789
> =A0 =A0 =A0 =A0select ARCH_HAS_OPP
> =A0 =A0 =A0 =A0select PM_OPP if PM
> diff --git a/arch/arm/mach-omap2/omap4-common.c
> b/arch/arm/mach-omap2/omap4-common.c
> index 1926864..9ef8c29 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
> =A0 =A0 =A0 =A0omap_smc1(0x102, 0x0);
> =A0}
>
> +static void omap4_l2x0_set_debug(unsigned long val)
> +{
> + =A0 =A0 =A0 /* Program PL310 L2 Cache controller debug register */
> + =A0 =A0 =A0 omap_smc1(0x100, val);
> +}
> +
> =A0static int __init omap_l2_cache_init(void)
> =A0{
> =A0 =A0 =A0 =A0u32 aux_ctrl =3D 0;
> @@ -99,6 +105,7 @@ static int __init omap_l2_cache_init(void)
> =A0 =A0 =A0 =A0 * specific one
> =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0outer_cache.disable =3D omap4_l2x0_disable;
> + =A0 =A0 =A0 outer_cache.set_debug =3D omap4_l2x0_set_debug;
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..a8caee4 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -67,18 +67,22 @@ static inline void l2x0_inv_line(unsigned long ad=
dr)
> =A0 =A0 =A0 =A0writel_relaxed(addr, base + L2X0_INV_LINE_PA);
> =A0}
>
> -#ifdef CONFIG_PL310_ERRATA_588369
> +#if defined(CONFIG_PL310_ERRATA_588369) ||
> defined(CONFIG_PL310_ERRATA_727915)
> =A0static void debug_writel(unsigned long val)
> =A0{
> - =A0 =A0 =A0 extern void omap_smc1(u32 fn, u32 arg);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Texas Instrument secure monitor api to modify the
> - =A0 =A0 =A0 =A0* PL310 Debug Control Register.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 omap_smc1(0x100, val);
> + =A0 =A0 =A0 if (outer_cache.set_debug)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outer_cache.set_debug(val);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(val, l2x0_base + L2X0_DEBUG_CTRL=
);
> +}
> +#else
> +/* Optimised out for non-errata case */
> +static inline void debug_writel(unsigned long val)
> +{
> =A0}
> +#endif
>
> +#ifdef CONFIG_PL310_ERRATA_588369
> =A0static inline void l2x0_flush_line(unsigned long addr)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *base =3D l2x0_base;
> @@ -91,11 +95,6 @@ static inline void l2x0_flush_line(unsigned long a=
ddr)
> =A0}
> =A0#else
>
> -/* Optimised out for non-errata case */
> -static inline void debug_writel(unsigned long val)
> -{
> -}
> -
> =A0static inline void l2x0_flush_line(unsigned long addr)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *base =3D l2x0_base;
> @@ -119,9 +118,11 @@ static void l2x0_flush_all(void)
>
> =A0 =A0 =A0 =A0/* clean all ways */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&l2x0_lock, flags);
> + =A0 =A0 =A0 debug_writel(0x03);
> =A0 =A0 =A0 =A0writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_I=
NV_WAY);
> =A0 =A0 =A0 =A0cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_wa=
y_mask);
> =A0 =A0 =A0 =A0cache_sync();
> + =A0 =A0 =A0 debug_writel(0x00);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&l2x0_lock, flags);
> =A0}
>
> @@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base, __u32
> aux_val, __u32 aux_mask)
> =A0 =A0 =A0 =A0outer_cache.flush_all =3D l2x0_flush_all;
> =A0 =A0 =A0 =A0outer_cache.inv_all =3D l2x0_inv_all;
> =A0 =A0 =A0 =A0outer_cache.disable =3D l2x0_disable;
> + =A0 =A0 =A0 outer_cache.set_debug =3D NULL;
>
> =A0 =A0 =A0 =A0printk(KERN_INFO "%s cache controller enabled\n", type=
);
> =A0 =A0 =A0 =A0printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_=
CTRL 0x%08x,
> Cache size: %d B\n",
> --
> 1.6.0.4
>

Why set by default to NULL, why not have a normal l2x0_set_debug which
just does a write to L2X0_DEBUG_CTRL, and then just invoke the
function pointer when you wish to manipulate the DCR? That way you
don't need the runtime check, and it's just clearer, I think.

Also, why not do something like -
=2E...
do_stuff();
#ifdef CONFIG_NEED_ERRATA_1234
do_errata_stuff();
#endif
do_more_stuff();
=2E..

instead of  -

=2E..
#ifdef CONFIG_NEED_ERRATA_1234
do_some_stuf() {
bar();
}
#else
{
do_some_stuff() {
}
// nothing
}

do_stuff();
do_some_stuff();
do_more_stuff();

It's not exactly clear otherwise what's happening and why there are
these extra calls that sometimes are compiled in, and sometimes
aren't. The way I am suggesting, you would just look at a function
block and you can easily tell what is different in the errata case,
and you don't need to jump back and forth to figure that out. I think
it makes for cleaner code.

And it would be nice if the errata had some revision data attached to
them, as in my suggestion patch I sent earlier. It's a nuisance to
look at Kconfig wondering which errata you might be interested in,
especially if your platform spans several generations and revs of
different parts. Then you need to dig up an errata sheet and scan it
yourself. The alternative is to be able to select a known rev for
PL310, for example, which would just pick the errata that apply to
that rev, or at least mention the affected revs in the documentation
for the option.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
