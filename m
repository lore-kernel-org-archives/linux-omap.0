From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 1/6] ARM: move cache/processor/fault glue to separate
 include files
Date: Fri, 11 Feb 2011 18:52:14 -0800
Message-ID: <AANLkTimZOGkgjudvxeaOMJz=p2peZAt6Zf-sFjrz66YL@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgc-0002yU-Gr@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:62441 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379Ab1BLCwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 21:52:19 -0500
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p1C2qGR5032625
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:17 -0800
Received: from vws16 (vws16.prod.google.com [10.241.21.144])
	by kpbe19.cbf.corp.google.com with ESMTP id p1C2qEbg006741
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:15 -0800
Received: by vws16 with SMTP id 16so2137131vws.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:14 -0800 (PST)
In-Reply-To: <E1Pnvgc-0002yU-Gr@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 8:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This allows the cache/processor/fault glue to be more easily used
> from assembler code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/include/asm/cacheflush.h =A0| =A0133 +----------------
> =A0arch/arm/include/asm/cpu-multi32.h | =A0 69 --------
> =A0arch/arm/include/asm/cpu-single.h =A0| =A0 44 ------
> =A0arch/arm/include/asm/glue-cache.h =A0| =A0146 ++++++++++++++++++
> =A0arch/arm/include/asm/glue-df.h =A0 =A0 | =A0110 +++++++++++++
> =A0arch/arm/include/asm/glue-pf.h =A0 =A0 | =A0 57 +++++++
> =A0arch/arm/include/asm/glue-proc.h =A0 | =A0261 ++++++++++++++++++++=
+++++++++++
> =A0arch/arm/include/asm/glue.h =A0 =A0 =A0 =A0| =A0138 --------------=
---
> =A0arch/arm/include/asm/proc-fns.h =A0 =A0| =A0299 ++++++++----------=
------------------
> =A0arch/arm/kernel/asm-offsets.c =A0 =A0 =A0| =A0 =A02 +
> =A0arch/arm/kernel/entry-armv.S =A0 =A0 =A0 | =A0 =A03 +-
> =A011 files changed, 644 insertions(+), 618 deletions(-)
> =A0delete mode 100644 arch/arm/include/asm/cpu-multi32.h
> =A0delete mode 100644 arch/arm/include/asm/cpu-single.h
> =A0create mode 100644 arch/arm/include/asm/glue-cache.h
> =A0create mode 100644 arch/arm/include/asm/glue-df.h
> =A0create mode 100644 arch/arm/include/asm/glue-pf.h
> =A0create mode 100644 arch/arm/include/asm/glue-proc.h
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm=
/cacheflush.h
> index 3acd8fa..18a5664 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -12,7 +12,7 @@
>
> =A0#include <linux/mm.h>
>
> -#include <asm/glue.h>
> +#include <asm/glue-cache.h>
> =A0#include <asm/shmparam.h>
> =A0#include <asm/cachetype.h>
> =A0#include <asm/outercache.h>
> @@ -20,123 +20,6 @@
> =A0#define CACHE_COLOUR(vaddr) =A0 =A0((vaddr & (SHMLBA - 1)) >> PAGE=
_SHIFT)
>
> =A0/*
> - * =A0 =A0 Cache Model
> - * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - */
> -#undef _CACHE
> -#undef MULTI_CACHE
> -
> -#if defined(CONFIG_CPU_CACHE_V3)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE v3
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_CACHE_V4)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE v4
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_ARM920T) || defined(CONFIG_CPU_ARM922T) || \
> - =A0 =A0defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020) |=
| \
> - =A0 =A0defined(CONFIG_CPU_ARM1026)
> -# define MULTI_CACHE 1
> -#endif
> -
> -#if defined(CONFIG_CPU_FA526)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE fa
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_ARM926T)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE arm926
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_ARM940T)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE arm940
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_ARM946E)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE arm946
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_CACHE_V4WB)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE v4wb
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_XSCALE)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE xscale
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_XSC3)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE xsc3
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_MOHAWK)
> -# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -# else
> -# =A0define _CACHE mohawk
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_FEROCEON)
> -# define MULTI_CACHE 1
> -#endif
> -
> -#if defined(CONFIG_CPU_V6)
> -//# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -//# else
> -//# =A0define _CACHE v6
> -//# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_V7)
> -//# ifdef _CACHE
> -# =A0define MULTI_CACHE 1
> -//# else
> -//# =A0define _CACHE v7
> -//# endif
> -#endif
> -
> -#if !defined(_CACHE) && !defined(MULTI_CACHE)
> -#error Unknown cache maintainence model
> -#endif
> -
> -/*
> =A0* This flag is used to indicate that the page pointed to by a pte =
is clean
> =A0* and does not require cleaning before returning it to the user.
> =A0*/
> @@ -249,19 +132,11 @@ extern struct cpu_cache_fns cpu_cache;
> =A0* visible to the CPU.
> =A0*/
> =A0#define dmac_map_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_cache=
=2Edma_map_area
> -#define dmac_unmap_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_cache.dma=
_unmap_area
> +#define dmac_unmap_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0cpu_cache.dma_unmap_area
> =A0#define dmac_flush_range =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_cache.dma=
_flush_range
>
> =A0#else
>
> -#define __cpuc_flush_icache_all =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glu=
e(_CACHE,_flush_icache_all)
> -#define __cpuc_flush_kern_all =A0 =A0 =A0 =A0 =A0__glue(_CACHE,_flus=
h_kern_cache_all)
> -#define __cpuc_flush_user_all =A0 =A0 =A0 =A0 =A0__glue(_CACHE,_flus=
h_user_cache_all)
> -#define __cpuc_flush_user_range =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glu=
e(_CACHE,_flush_user_cache_range)
> -#define __cpuc_coherent_kern_range =A0 =A0 __glue(_CACHE,_coherent_k=
ern_range)
> -#define __cpuc_coherent_user_range =A0 =A0 __glue(_CACHE,_coherent_u=
ser_range)
> -#define __cpuc_flush_dcache_area =A0 =A0 =A0 __glue(_CACHE,_flush_ke=
rn_dcache_area)
> -
> =A0extern void __cpuc_flush_icache_all(void);
> =A0extern void __cpuc_flush_kern_all(void);
> =A0extern void __cpuc_flush_user_all(void);
> @@ -276,10 +151,6 @@ extern void __cpuc_flush_dcache_area(void *, siz=
e_t);
> =A0* is visible to DMA, or data written by DMA to system memory is
> =A0* visible to the CPU.
> =A0*/
> -#define dmac_map_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(_CAC=
HE,_dma_map_area)
> -#define dmac_unmap_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(_CACHE=
,_dma_unmap_area)
> -#define dmac_flush_range =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(_CACHE,_=
dma_flush_range)
> -
> =A0extern void dmac_map_area(const void *, size_t, int);
> =A0extern void dmac_unmap_area(const void *, size_t, int);
> =A0extern void dmac_flush_range(const void *, const void *);
> diff --git a/arch/arm/include/asm/cpu-multi32.h b/arch/arm/include/as=
m/cpu-multi32.h
> deleted file mode 100644
> index e2b5b0b..0000000
> --- a/arch/arm/include/asm/cpu-multi32.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/*
> - * =A0arch/arm/include/asm/cpu-multi32.h
> - *
> - * =A0Copyright (C) 2000 Russell King
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <asm/page.h>
> -
> -struct mm_struct;
> -
> -/*
> - * Don't change this structure - ASM code
> - * relies on it.
> - */
> -extern struct processor {
> - =A0 =A0 =A0 /* MISC
> - =A0 =A0 =A0 =A0* get data abort address/flags
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*_data_abort)(unsigned long pc);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Retrieve prefetch fault address
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 unsigned long (*_prefetch_abort)(unsigned long lr);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Set up any processor specifics
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*_proc_init)(void);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Disable any processor specifics
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*_proc_fin)(void);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Special stuff for a reset
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*reset)(unsigned long addr) __attribute__((noretu=
rn));
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Idle the processor
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 int (*_do_idle)(void);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Processor architecture specific
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* clean a virtual address range from the
> - =A0 =A0 =A0 =A0* D-cache without flushing the cache.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*dcache_clean_area)(void *addr, int size);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Set the page table
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*switch_mm)(unsigned long pgd_phys, struct mm_str=
uct *mm);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Set a possibly extended PTE. =A0Non-extended PTEs =
should
> - =A0 =A0 =A0 =A0* ignore 'ext'.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned in=
t ext);
> -} processor;
> -
> -#define cpu_proc_init() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0processor._proc_init()
> -#define cpu_proc_fin() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 processor._pr=
oc_fin()
> -#define cpu_reset(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0processor.reset(addr)
> -#define cpu_do_idle() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0processor._=
do_idle()
> -#define cpu_dcache_clean_area(addr,sz) processor.dcache_clean_area(a=
ddr,sz)
> -#define cpu_set_pte_ext(ptep,pte,ext) =A0processor.set_pte_ext(ptep,=
pte,ext)
> -#define cpu_do_switch_mm(pgd,mm) =A0 =A0 =A0 processor.switch_mm(pgd=
,mm)
> diff --git a/arch/arm/include/asm/cpu-single.h b/arch/arm/include/asm=
/cpu-single.h
> deleted file mode 100644
> index f073a6d..0000000
> --- a/arch/arm/include/asm/cpu-single.h
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -/*
> - * =A0arch/arm/include/asm/cpu-single.h
> - *
> - * =A0Copyright (C) 2000 Russell King
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -/*
> - * Single CPU
> - */
> -#ifdef __STDC__
> -#define __catify_fn(name,x) =A0 =A0name##x
> -#else
> -#define __catify_fn(name,x) =A0 =A0name/**/x
> -#endif
> -#define __cpu_fn(name,x) =A0 =A0 =A0 __catify_fn(name,x)
> -
> -/*
> - * If we are supporting multiple CPUs, then we must use a table of
> - * function pointers for this lot. =A0Otherwise, we can optimise the
> - * table away.
> - */
> -#define cpu_proc_init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__cpu_fn(CP=
U_NAME,_proc_init)
> -#define cpu_proc_fin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __cpu_fn(CP=
U_NAME,_proc_fin)
> -#define cpu_reset =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__cpu_f=
n(CPU_NAME,_reset)
> -#define cpu_do_idle =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__cpu_fn(=
CPU_NAME,_do_idle)
> -#define cpu_dcache_clean_area =A0 =A0 =A0 =A0 =A0__cpu_fn(CPU_NAME,_=
dcache_clean_area)
> -#define cpu_do_switch_mm =A0 =A0 =A0 =A0 =A0 =A0 =A0 __cpu_fn(CPU_NA=
ME,_switch_mm)
> -#define cpu_set_pte_ext =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__cpu_fn(CPU_NAME,_set_pte_ext)
> -
> -#include <asm/page.h>
> -
> -struct mm_struct;
> -
> -/* declare all the functions as extern */
> -extern void cpu_proc_init(void);
> -extern void cpu_proc_fin(void);
> -extern int cpu_do_idle(void);
> -extern void cpu_dcache_clean_area(void *, int);
> -extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struc=
t *mm);
> -extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext=
);
> -extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm=
/glue-cache.h
> new file mode 100644
> index 0000000..0591d35
> --- /dev/null
> +++ b/arch/arm/include/asm/glue-cache.h
> @@ -0,0 +1,146 @@
> +/*
> + * =A0arch/arm/include/asm/glue-cache.h
> + *
> + * =A0Copyright (C) 1999-2002 Russell King
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ASM_GLUE_CACHE_H
> +#define ASM_GLUE_CACHE_H
> +
> +#include <asm/glue.h>
> +
> +/*
> + * =A0 =A0 Cache Model
> + * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + */
> +#undef _CACHE
> +#undef MULTI_CACHE
> +
> +#if defined(CONFIG_CPU_CACHE_V3)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE v3
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_CACHE_V4)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE v4
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_ARM920T) || defined(CONFIG_CPU_ARM922T) || \
> + =A0 =A0defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020) |=
| \
> + =A0 =A0defined(CONFIG_CPU_ARM1026)
> +# define MULTI_CACHE 1
> +#endif
> +
> +#if defined(CONFIG_CPU_FA526)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE fa
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_ARM926T)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE arm926
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_ARM940T)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE arm940
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_ARM946E)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE arm946
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_CACHE_V4WB)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE v4wb
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_XSCALE)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE xscale
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_XSC3)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE xsc3
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_MOHAWK)
> +# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +# else
> +# =A0define _CACHE mohawk
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_FEROCEON)
> +# define MULTI_CACHE 1
> +#endif
> +
> +#if defined(CONFIG_CPU_V6)
> +//# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +//# else
> +//# =A0define _CACHE v6
> +//# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_V7)
> +//# ifdef _CACHE
> +# =A0define MULTI_CACHE 1
> +//# else
> +//# =A0define _CACHE v7
> +//# endif
> +#endif
> +
> +#if !defined(_CACHE) && !defined(MULTI_CACHE)
> +#error Unknown cache maintainence model
> +#endif
> +
> +#ifndef MULTI_CACHE
> +#define __cpuc_flush_icache_all =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glu=
e(_CACHE,_flush_icache_all)
> +#define __cpuc_flush_kern_all =A0 =A0 =A0 =A0 =A0__glue(_CACHE,_flus=
h_kern_cache_all)
> +#define __cpuc_flush_user_all =A0 =A0 =A0 =A0 =A0__glue(_CACHE,_flus=
h_user_cache_all)
> +#define __cpuc_flush_user_range =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glu=
e(_CACHE,_flush_user_cache_range)
> +#define __cpuc_coherent_kern_range =A0 =A0 __glue(_CACHE,_coherent_k=
ern_range)
> +#define __cpuc_coherent_user_range =A0 =A0 __glue(_CACHE,_coherent_u=
ser_range)
> +#define __cpuc_flush_dcache_area =A0 =A0 =A0 __glue(_CACHE,_flush_ke=
rn_dcache_area)
> +
> +#define dmac_map_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(_CAC=
HE,_dma_map_area)
> +#define dmac_unmap_area =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__glue(_CACHE,_dma_unmap_area)
> +#define dmac_flush_range =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(_CACHE,_=
dma_flush_range)
> +#endif
> +
> +#endif
> diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/gl=
ue-df.h
> new file mode 100644
> index 0000000..354d571
> --- /dev/null
> +++ b/arch/arm/include/asm/glue-df.h
> @@ -0,0 +1,110 @@
> +/*
> + * =A0arch/arm/include/asm/glue-df.h
> + *
> + * =A0Copyright (C) 1997-1999 Russell King
> + * =A0Copyright (C) 2000-2002 Deep Blue Solutions Ltd.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ASM_GLUE_DF_H
> +#define ASM_GLUE_DF_H
> +
> +#include <asm/glue.h>
> +
> +/*
> + * =A0 =A0 Data Abort Model
> + * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * =A0 =A0 We have the following to choose from:
> + * =A0 =A0 =A0 arm6 =A0 =A0 =A0 =A0 =A0- ARM6 style
> + * =A0 =A0 =A0 arm7 =A0 =A0 =A0 =A0 =A0- ARM7 style
> + * =A0 =A0 =A0 v4_early =A0 =A0 =A0- ARMv4 without Thumb early abort=
 handler
> + * =A0 =A0 =A0 v4t_late =A0 =A0 =A0- ARMv4 with Thumb late abort han=
dler
> + * =A0 =A0 =A0 v4t_early =A0 =A0 - ARMv4 with Thumb early abort hand=
ler
> + * =A0 =A0 =A0 v5tej_early =A0 - ARMv5 with Thumb and Java early abo=
rt handler
> + * =A0 =A0 =A0 xscale =A0 =A0 =A0 =A0- ARMv5 with Thumb with Xscale =
extensions
> + * =A0 =A0 =A0 v6_early =A0 =A0 =A0- ARMv6 generic early abort handl=
er
> + * =A0 =A0 =A0 v7_early =A0 =A0 =A0- ARMv7 generic early abort handl=
er
> + */
> +#undef CPU_DABORT_HANDLER
> +#undef MULTI_DABORT
> +
> +#if defined(CONFIG_CPU_ARM610)
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER cpu_arm6_data_abort
> +# endif
> +#endif
> +
> +#if defined(CONFIG_CPU_ARM710)
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER cpu_arm7_data_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_LV4T
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v4t_late_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV4
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v4_early_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV4T
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v4t_early_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV5TJ
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v5tj_early_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV5T
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v5t_early_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV6
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v6_early_abort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ABRT_EV7
> +# ifdef CPU_DABORT_HANDLER
> +# =A0define MULTI_DABORT 1
> +# else
> +# =A0define CPU_DABORT_HANDLER v7_early_abort
> +# endif
> +#endif
> +
> +#ifndef CPU_DABORT_HANDLER
> +#error Unknown data abort handler type
> +#endif
> +
> +#endif
> diff --git a/arch/arm/include/asm/glue-pf.h b/arch/arm/include/asm/gl=
ue-pf.h
> new file mode 100644
> index 0000000..d385f37
> --- /dev/null
> +++ b/arch/arm/include/asm/glue-pf.h
> @@ -0,0 +1,57 @@
> +/*
> + * =A0arch/arm/include/asm/glue-pf.h
> + *
> + * =A0Copyright (C) 1997-1999 Russell King
> + * =A0Copyright (C) 2000-2002 Deep Blue Solutions Ltd.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ASM_GLUE_PF_H
> +#define ASM_GLUE_PF_H
> +
> +#include <asm/glue.h>
> +
> +/*
> + * =A0 =A0 Prefetch Abort Model
> + * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * =A0 =A0 We have the following to choose from:
> + * =A0 =A0 =A0 legacy =A0 =A0 =A0 =A0- no IFSR, no IFAR
> + * =A0 =A0 =A0 v6 =A0 =A0 =A0 =A0 =A0 =A0- ARMv6: IFSR, no IFAR
> + * =A0 =A0 =A0 v7 =A0 =A0 =A0 =A0 =A0 =A0- ARMv7: IFSR and IFAR
> + */
> +
> +#undef CPU_PABORT_HANDLER
> +#undef MULTI_PABORT
> +
> +#ifdef CONFIG_CPU_PABRT_LEGACY
> +# ifdef CPU_PABORT_HANDLER
> +# =A0define MULTI_PABORT 1
> +# else
> +# =A0define CPU_PABORT_HANDLER legacy_pabort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_PABRT_V6
> +# ifdef CPU_PABORT_HANDLER
> +# =A0define MULTI_PABORT 1
> +# else
> +# =A0define CPU_PABORT_HANDLER v6_pabort
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_PABRT_V7
> +# ifdef CPU_PABORT_HANDLER
> +# =A0define MULTI_PABORT 1
> +# else
> +# =A0define CPU_PABORT_HANDLER v7_pabort
> +# endif
> +#endif
> +
> +#ifndef CPU_PABORT_HANDLER
> +#error Unknown prefetch abort handler type
> +#endif
> +
> +#endif
> diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/=
glue-proc.h
> new file mode 100644
> index 0000000..e3bf443
> --- /dev/null
> +++ b/arch/arm/include/asm/glue-proc.h
> @@ -0,0 +1,261 @@
> +/*
> + * =A0arch/arm/include/asm/glue-proc.h
> + *
> + * =A0Copyright (C) 1997-1999 Russell King
> + * =A0Copyright (C) 2000 Deep Blue Solutions Ltd
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ASM_GLUE_PROC_H
> +#define ASM_GLUE_PROC_H
> +
> +#include <asm/glue.h>
> +
> +/*
> + * Work out if we need multiple CPU support
> + */
> +#undef MULTI_CPU
> +#undef CPU_NAME
> +
> +/*
> + * CPU_NAME - the prefix for CPU related functions
> + */
> +
> +#ifdef CONFIG_CPU_ARM610
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm6
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM7TDMI
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm7tdmi
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM710
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm7
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM720T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm720
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM740T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm740
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM9TDMI
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm9tdmi
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM920T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm920
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM922T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm922
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_FA526
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_fa526
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM925T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm925
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM926T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm926
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM940T
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm940
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM946E
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm946
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_SA110
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_sa110
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_SA1100
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_sa1100
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM1020
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm1020
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM1020E
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm1020e
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM1022
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm1022
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_ARM1026
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_arm1026
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_XSCALE
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_xscale
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_XSC3
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_xsc3
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_MOHAWK
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_mohawk
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_FEROCEON
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_feroceon
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_V6
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_v6
> +# endif
> +#endif
> +
> +#ifdef CONFIG_CPU_V7
> +# ifdef CPU_NAME
> +# =A0undef =A0MULTI_CPU
> +# =A0define MULTI_CPU
> +# else
> +# =A0define CPU_NAME cpu_v7
> +# endif
> +#endif
> +
> +#ifndef MULTI_CPU
> +#define cpu_proc_init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(CPU_=
NAME,_proc_init)
> +#define cpu_proc_fin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(CPU_=
NAME,_proc_fin)
> +#define cpu_reset =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(=
CPU_NAME,_reset)
> +#define cpu_do_idle =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(CP=
U_NAME,_do_idle)
> +#define cpu_dcache_clean_area =A0 =A0 =A0 =A0 =A0__glue(CPU_NAME,_dc=
ache_clean_area)
> +#define cpu_do_switch_mm =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(CPU_NAME=
,_switch_mm)
> +#define cpu_set_pte_ext =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__glue(CPU_NAME,_set_pte_ext)
> +#endif
> +
> +#endif
> diff --git a/arch/arm/include/asm/glue.h b/arch/arm/include/asm/glue.=
h
> index 234a3fc..0ec35d1 100644
> --- a/arch/arm/include/asm/glue.h
> +++ b/arch/arm/include/asm/glue.h
> @@ -15,7 +15,6 @@
> =A0*/
> =A0#ifdef __KERNEL__
>
> -
> =A0#ifdef __STDC__
> =A0#define ____glue(name,fn) =A0 =A0 =A0name##fn
> =A0#else
> @@ -23,141 +22,4 @@
> =A0#endif
> =A0#define __glue(name,fn) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0____glue(na=
me,fn)
>
> -
> -
> -/*
> - * =A0 =A0 Data Abort Model
> - * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - *
> - * =A0 =A0 We have the following to choose from:
> - * =A0 =A0 =A0 arm6 =A0 =A0 =A0 =A0 =A0- ARM6 style
> - * =A0 =A0 =A0 arm7 =A0 =A0 =A0 =A0 =A0- ARM7 style
> - * =A0 =A0 =A0 v4_early =A0 =A0 =A0- ARMv4 without Thumb early abort=
 handler
> - * =A0 =A0 =A0 v4t_late =A0 =A0 =A0- ARMv4 with Thumb late abort han=
dler
> - * =A0 =A0 =A0 v4t_early =A0 =A0 - ARMv4 with Thumb early abort hand=
ler
> - * =A0 =A0 =A0 v5tej_early =A0 - ARMv5 with Thumb and Java early abo=
rt handler
> - * =A0 =A0 =A0 xscale =A0 =A0 =A0 =A0- ARMv5 with Thumb with Xscale =
extensions
> - * =A0 =A0 =A0 v6_early =A0 =A0 =A0- ARMv6 generic early abort handl=
er
> - * =A0 =A0 =A0 v7_early =A0 =A0 =A0- ARMv7 generic early abort handl=
er
> - */
> -#undef CPU_DABORT_HANDLER
> -#undef MULTI_DABORT
> -
> -#if defined(CONFIG_CPU_ARM610)
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER cpu_arm6_data_abort
> -# endif
> -#endif
> -
> -#if defined(CONFIG_CPU_ARM710)
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER cpu_arm7_data_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_LV4T
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v4t_late_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV4
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v4_early_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV4T
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v4t_early_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV5TJ
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v5tj_early_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV5T
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v5t_early_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV6
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v6_early_abort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ABRT_EV7
> -# ifdef CPU_DABORT_HANDLER
> -# =A0define MULTI_DABORT 1
> -# else
> -# =A0define CPU_DABORT_HANDLER v7_early_abort
> -# endif
> -#endif
> -
> -#ifndef CPU_DABORT_HANDLER
> -#error Unknown data abort handler type
> -#endif
> -
> -/*
> - * =A0 =A0 Prefetch Abort Model
> - * =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - *
> - * =A0 =A0 We have the following to choose from:
> - * =A0 =A0 =A0 legacy =A0 =A0 =A0 =A0- no IFSR, no IFAR
> - * =A0 =A0 =A0 v6 =A0 =A0 =A0 =A0 =A0 =A0- ARMv6: IFSR, no IFAR
> - * =A0 =A0 =A0 v7 =A0 =A0 =A0 =A0 =A0 =A0- ARMv7: IFSR and IFAR
> - */
> -
> -#undef CPU_PABORT_HANDLER
> -#undef MULTI_PABORT
> -
> -#ifdef CONFIG_CPU_PABRT_LEGACY
> -# ifdef CPU_PABORT_HANDLER
> -# =A0define MULTI_PABORT 1
> -# else
> -# =A0define CPU_PABORT_HANDLER legacy_pabort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_PABRT_V6
> -# ifdef CPU_PABORT_HANDLER
> -# =A0define MULTI_PABORT 1
> -# else
> -# =A0define CPU_PABORT_HANDLER v6_pabort
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_PABRT_V7
> -# ifdef CPU_PABORT_HANDLER
> -# =A0define MULTI_PABORT 1
> -# else
> -# =A0define CPU_PABORT_HANDLER v7_pabort
> -# endif
> -#endif
> -
> -#ifndef CPU_PABORT_HANDLER
> -#error Unknown prefetch abort handler type
> -#endif
> -
> =A0#endif
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/p=
roc-fns.h
> index 8fdae9b..6980215 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -13,248 +13,77 @@
>
> =A0#ifdef __KERNEL__
>
> +#include <asm/glue-proc.h>
> +#include <asm/page.h>
>
> -/*
> - * Work out if we need multiple CPU support
> - */
> -#undef MULTI_CPU
> -#undef CPU_NAME
> +#ifndef __ASSEMBLY__
> +
> +struct mm_struct;
>
> =A0/*
> - * CPU_NAME - the prefix for CPU related functions
> + * Don't change this structure - ASM code relies on it.
> =A0*/
> -
> -#ifdef CONFIG_CPU_ARM610
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm6
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM7TDMI
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm7tdmi
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM710
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm7
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM720T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm720
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM740T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm740
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM9TDMI
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm9tdmi
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM920T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm920
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM922T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm922
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_FA526
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_fa526
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM925T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm925
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM926T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm926
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM940T
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm940
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM946E
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm946
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_SA110
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_sa110
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_SA1100
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_sa1100
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM1020
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm1020
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM1020E
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm1020e
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM1022
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm1022
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_ARM1026
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_arm1026
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_XSCALE
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_xscale
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_XSC3
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_xsc3
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_MOHAWK
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_mohawk
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_FEROCEON
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_feroceon
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_V6
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_v6
> -# endif
> -#endif
> -
> -#ifdef CONFIG_CPU_V7
> -# ifdef CPU_NAME
> -# =A0undef =A0MULTI_CPU
> -# =A0define MULTI_CPU
> -# else
> -# =A0define CPU_NAME cpu_v7
> -# endif
> -#endif
> -
> -#ifndef __ASSEMBLY__
> +extern struct processor {
> + =A0 =A0 =A0 /* MISC
> + =A0 =A0 =A0 =A0* get data abort address/flags
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*_data_abort)(unsigned long pc);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Retrieve prefetch fault address
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned long (*_prefetch_abort)(unsigned long lr);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set up any processor specifics
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*_proc_init)(void);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Disable any processor specifics
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*_proc_fin)(void);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Special stuff for a reset
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*reset)(unsigned long addr) __attribute__((noretu=
rn));
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Idle the processor
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int (*_do_idle)(void);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Processor architecture specific
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* clean a virtual address range from the
> + =A0 =A0 =A0 =A0* D-cache without flushing the cache.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*dcache_clean_area)(void *addr, int size);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set the page table
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*switch_mm)(unsigned long pgd_phys, struct mm_str=
uct *mm);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set a possibly extended PTE. =A0Non-extended PTEs =
should
> + =A0 =A0 =A0 =A0* ignore 'ext'.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned in=
t ext);
> +} processor;
>
> =A0#ifndef MULTI_CPU
> -#include <asm/cpu-single.h>
> +extern void cpu_proc_init(void);
> +extern void cpu_proc_fin(void);
> +extern int cpu_do_idle(void);
> +extern void cpu_dcache_clean_area(void *, int);
> +extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struc=
t *mm);
> +extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext=
);
> +extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> =A0#else
> -#include <asm/cpu-multi32.h>
> +#define cpu_proc_init() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0processor._proc_init()
> +#define cpu_proc_fin() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 processor._pr=
oc_fin()
> +#define cpu_reset(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0processor.reset(addr)
> +#define cpu_do_idle() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0processor._=
do_idle()
> +#define cpu_dcache_clean_area(addr,sz) processor.dcache_clean_area(a=
ddr,sz)
> +#define cpu_set_pte_ext(ptep,pte,ext) =A0processor.set_pte_ext(ptep,=
pte,ext)
> +#define cpu_do_switch_mm(pgd,mm) =A0 =A0 =A0 processor.switch_mm(pgd=
,mm)
> =A0#endif
>
> =A0#include <asm/memory.h>
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offs=
ets.c
> index 82da661..5302a91 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -13,6 +13,8 @@
> =A0#include <linux/sched.h>
> =A0#include <linux/mm.h>
> =A0#include <linux/dma-mapping.h>
> +#include <asm/glue-df.h>
> +#include <asm/glue-pf.h>
> =A0#include <asm/mach/arch.h>
> =A0#include <asm/thread_info.h>
> =A0#include <asm/memory.h>
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-arm=
v.S
> index 2b46fea..e8d8856 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -16,7 +16,8 @@
> =A0*/
>
> =A0#include <asm/memory.h>
> -#include <asm/glue.h>
> +#include <asm/glue-df.h>
> +#include <asm/glue-pf.h>
> =A0#include <asm/vfpmacros.h>
> =A0#include <mach/entry-macro.S>
> =A0#include <asm/thread_notify.h>
> --
> 1.6.2.5

Acked-by: Colin Cross <ccross@android.com>

Tested on Tegra 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
