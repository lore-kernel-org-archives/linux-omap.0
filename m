From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Fri, 11 Feb 2011 18:50:57 -0800
Message-ID: <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:61867 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810Ab1BLCvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 21:51:02 -0500
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p1C2oxfL031594
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:50:59 -0800
Received: from vxb41 (vxb41.prod.google.com [10.241.33.105])
	by wpaz24.hot.corp.google.com with ESMTP id p1C2omjX024303
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:50:58 -0800
Received: by vxb41 with SMTP id 41so1685212vxb.39
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:50:57 -0800 (PST)
In-Reply-To: <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 8:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This adds core support for saving and restoring CPU coprocessor
> registers for suspend/resume support. =A0This contains support for su=
spend
> with ARM920, ARM926, SA11x0, PXA25x, PXA27x, PXA3xx, V6 and V7 CPUs.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/include/asm/glue-proc.h | =A0 =A03 +
> =A0arch/arm/include/asm/proc-fns.h =A0| =A0 =A07 ++
> =A0arch/arm/kernel/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/kernel/asm-offsets.c =A0 =A0| =A0 =A09 +++
> =A0arch/arm/kernel/sleep.S =A0 =A0 =A0 =A0 =A0| =A0110 ++++++++++++++=
++++++++++++++++++++++
> =A0arch/arm/mm/proc-arm1020.S =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mm/proc-arm1020e.S =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm1022.S =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mm/proc-arm1026.S =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mm/proc-arm6_7.S =A0 =A0 =A0 =A0| =A0 =A06 ++
> =A0arch/arm/mm/proc-arm720.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm740.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm7tdmi.S =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm920.S =A0 =A0 =A0 =A0| =A0 37 ++++++++++++
> =A0arch/arm/mm/proc-arm922.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm925.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm926.S =A0 =A0 =A0 =A0| =A0 37 ++++++++++++
> =A0arch/arm/mm/proc-arm940.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm946.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-arm9tdmi.S =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-fa526.S =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mm/proc-feroceon.S =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-mohawk.S =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/arm/mm/proc-sa110.S =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mm/proc-sa1100.S =A0 =A0 =A0 =A0| =A0 39 +++++++++++++
> =A0arch/arm/mm/proc-v6.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 50 ++++++++++++=
++++
> =A0arch/arm/mm/proc-v7.S =A0 =A0 =A0 =A0 =A0 =A0| =A0116 ++++++++++++=
++++++++++++++++----------
> =A0arch/arm/mm/proc-xsc3.S =A0 =A0 =A0 =A0 =A0| =A0 48 ++++++++++++++=
+-
> =A0arch/arm/mm/proc-xscale.S =A0 =A0 =A0 =A0| =A0 45 ++++++++++++++-
> =A029 files changed, 523 insertions(+), 33 deletions(-)
> =A0create mode 100644 arch/arm/kernel/sleep.S
>
> diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/=
glue-proc.h
> index e3bf443..6469521 100644
> --- a/arch/arm/include/asm/glue-proc.h
> +++ b/arch/arm/include/asm/glue-proc.h
> @@ -256,6 +256,9 @@
> =A0#define cpu_dcache_clean_area =A0 =A0 =A0 =A0 =A0__glue(CPU_NAME,_=
dcache_clean_area)
> =A0#define cpu_do_switch_mm =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(CPU_NA=
ME,_switch_mm)
> =A0#define cpu_set_pte_ext =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0__glue(CPU_NAME,_set_pte_ext)
> +#define cpu_suspend_size =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(CPU_NAME=
,_suspend_size)
> +#define cpu_do_suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __glue(CPU_NA=
ME,_do_suspend)
> +#define cpu_do_resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__glue(CPU_=
NAME,_do_resume)
> =A0#endif
>
> =A0#endif
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/p=
roc-fns.h
> index 6980215..8ec535e 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -66,6 +66,11 @@ extern struct processor {
> =A0 =A0 =A0 =A0 * ignore 'ext'.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned i=
nt ext);
> +
> + =A0 =A0 =A0 /* Suspend/resume */
> + =A0 =A0 =A0 unsigned int suspend_size;
> + =A0 =A0 =A0 void (*do_suspend)(void *);
> + =A0 =A0 =A0 void (*do_resume)(void *);
> =A0} processor;
>
> =A0#ifndef MULTI_CPU
> @@ -86,6 +91,8 @@ extern void cpu_reset(unsigned long addr) __attribu=
te__((noreturn));
> =A0#define cpu_do_switch_mm(pgd,mm) =A0 =A0 =A0 processor.switch_mm(p=
gd,mm)
> =A0#endif
>
> +extern void cpu_resume(void);
> +
> =A0#include <asm/memory.h>
>
> =A0#ifdef CONFIG_MMU
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 185ee82..74554f1 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_MODULES) =A0 =A0 =A0 =A0 +=3D armksyms=
=2Eo module.o
> =A0obj-$(CONFIG_ARTHUR) =A0 =A0 =A0 =A0 =A0 +=3D arthur.o
> =A0obj-$(CONFIG_ISA_DMA) =A0 =A0 =A0 =A0 =A0+=3D dma-isa.o
> =A0obj-$(CONFIG_PCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D bios32.o isa.o
> +obj-$(CONFIG_PM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep.o
> =A0obj-$(CONFIG_HAVE_SCHED_CLOCK) +=3D sched_clock.o
> =A0obj-$(CONFIG_SMP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D smp.o smp_tlb.o
> =A0obj-$(CONFIG_HAVE_ARM_SCU) =A0 =A0 +=3D smp_scu.o
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offs=
ets.c
> index 5302a91..927522c 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -13,6 +13,7 @@
> =A0#include <linux/sched.h>
> =A0#include <linux/mm.h>
> =A0#include <linux/dma-mapping.h>
> +#include <asm/cacheflush.h>
> =A0#include <asm/glue-df.h>
> =A0#include <asm/glue-pf.h>
> =A0#include <asm/mach/arch.h>
> @@ -116,6 +117,14 @@ int main(void)
> =A0#ifdef MULTI_PABORT
> =A0 DEFINE(PROCESSOR_PABT_FUNC, =A0offsetof(struct processor, _prefet=
ch_abort));
> =A0#endif
> +#ifdef MULTI_CPU
> + =A0DEFINE(CPU_SLEEP_SIZE, =A0 =A0 =A0 offsetof(struct processor, su=
spend_size));
> + =A0DEFINE(CPU_DO_SUSPEND, =A0 =A0 =A0 offsetof(struct processor, do=
_suspend));
> + =A0DEFINE(CPU_DO_RESUME, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offsetof(st=
ruct processor, do_resume));
> +#endif
> +#ifdef MULTI_CACHE
> + =A0DEFINE(CACHE_FLUSH_KERN_ALL, offsetof(struct cpu_cache_fns, flus=
h_kern_all));
> +#endif
> =A0 BLANK();
> =A0 DEFINE(DMA_BIDIRECTIONAL, =A0 =A0DMA_BIDIRECTIONAL);
> =A0 DEFINE(DMA_TO_DEVICE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TO_DEVIC=
E);
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> new file mode 100644
> index 0000000..9f106fa
> --- /dev/null
> +++ b/arch/arm/kernel/sleep.S
> @@ -0,0 +1,110 @@
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +#include <asm/glue-cache.h>
> +#include <asm/glue-proc.h>
> + =A0 =A0 =A0 .text
> +
> +/*
> + * Save CPU state for a suspend
> + * =A0r1 =3D v:p offset
> + * =A0r3 =3D virtual return function
> + * Note: sp is decremented to allocate space for CPU state on stack
> + * r0-r3,r9,r10,lr corrupted
> + */
> +ENTRY(cpu_suspend)
> + =A0 =A0 =A0 mov =A0 =A0 r9, lr
> +#ifdef MULTI_CPU
> + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dprocessor
> + =A0 =A0 =A0 mov =A0 =A0 r2, sp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 current virtual SP
> + =A0 =A0 =A0 ldr =A0 =A0 r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sl=
eep state
> + =A0 =A0 =A0 ldr =A0 =A0 ip, [r10, #CPU_DO_RESUME] @ virtual resume =
function
> + =A0 =A0 =A0 sub =A0 =A0 sp, sp, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ all=
ocate CPU state on stack
> + =A0 =A0 =A0 mov =A0 =A0 r0, sp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 save pointer
> + =A0 =A0 =A0 add =A0 =A0 ip, ip, r1 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ con=
vert resume fn to phys
> + =A0 =A0 =A0 stmfd =A0 sp!, {r1, r2, r3, ip} =A0 @ save v:p, virt SP=
, retfn, phys resume fn
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3Dsleep_save_sp
> + =A0 =A0 =A0 add =A0 =A0 r2, sp, r1 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ con=
vert SP to phys
> + =A0 =A0 =A0 str =A0 =A0 r2, [r3] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ s=
ave phys SP
> + =A0 =A0 =A0 mov =A0 =A0 lr, pc
> + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
> +#else
> + =A0 =A0 =A0 mov =A0 =A0 r2, sp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 current virtual SP
> + =A0 =A0 =A0 ldr =A0 =A0 r0, =3Dcpu_suspend_size
> + =A0 =A0 =A0 sub =A0 =A0 sp, sp, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ all=
ocate CPU state on stack
> + =A0 =A0 =A0 mov =A0 =A0 r0, sp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 save pointer
> + =A0 =A0 =A0 stmfd =A0 sp!, {r1, r2, r3} =A0 =A0 =A0 @ save v:p, vir=
t SP, return fn
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3Dsleep_save_sp
> + =A0 =A0 =A0 add =A0 =A0 r2, sp, r1 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ con=
vert SP to phys
> + =A0 =A0 =A0 str =A0 =A0 r2, [r3] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ s=
ave phys SP
> + =A0 =A0 =A0 bl =A0 =A0 =A0cpu_do_suspend
> +#endif
> +
> + =A0 =A0 =A0 @ flush data cache
> +#ifdef MULTI_CACHE
> + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
> + =A0 =A0 =A0 mov =A0 =A0 lr, r9
> + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
> +#else
> + =A0 =A0 =A0 mov =A0 =A0 lr, r9
> + =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
> +#endif
> +ENDPROC(cpu_suspend)
> + =A0 =A0 =A0 .ltorg
> +
> +/*
> + * r0 =3D control register value
> + * r1 =3D v:p offset (preserved by cpu_do_resume)
> + * r2 =3D phys page table base
> + * r3 =3D L1 section flags
> + */
> +ENTRY(cpu_resume_mmu)
> + =A0 =A0 =A0 adr =A0 =A0 r4, cpu_resume_turn_mmu_on
> + =A0 =A0 =A0 mov =A0 =A0 r4, r4, lsr #20
> + =A0 =A0 =A0 orr =A0 =A0 r3, r3, r4, lsl #20
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ save old mapp=
ing
> + =A0 =A0 =A0 str =A0 =A0 r3, [r2, r4, lsl #2] =A0 =A0@ setup 1:1 map=
ping for mmu code
> + =A0 =A0 =A0 sub =A0 =A0 r2, r2, r1
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3Dcpu_resume_after_mmu
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_turn_mmu_on
> +ENDPROC(cpu_resume_mmu)
> + =A0 =A0 =A0 .ltorg
> + =A0 =A0 =A0 .align =A05
> +cpu_resume_turn_mmu_on:
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 0 =A0 @ turn on MMU, ca=
ches, etc
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r0, c0, c0, 0 =A0 @ read id reg
> + =A0 =A0 =A0 mov =A0 =A0 r0, r0
> + =A0 =A0 =A0 mov =A0 =A0 r0, r0
> + =A0 =A0 =A0 mov =A0 =A0 pc, r3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 jump to virtual address
> +ENDPROC(cpu_resume_turn_mmu_on)
> +cpu_resume_after_mmu:
> + =A0 =A0 =A0 str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore old m=
apping
> +#ifdef MULTI_CACHE
> + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
> + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
> +#else
> + =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
> +#endif
> +
> +/*
> + * Note: Yes, part of the following code is located into the .data s=
ection.
> + * =A0 =A0 =A0 This is to allow sleep_save_sp to be accessed with a =
relative load
> + * =A0 =A0 =A0 while we can't rely on any MMU translation. =A0We cou=
ld have put
> + * =A0 =A0 =A0 sleep_save_sp in the .text section as well, but some =
setups might
> + * =A0 =A0 =A0 insist on it to be truly read-only.
> + */
> + =A0 =A0 =A0 .data
> + =A0 =A0 =A0 .align
> +ENTRY(cpu_resume)
> + =A0 =A0 =A0 ldr =A0 =A0 r0, sleep_save_sp =A0 =A0 =A0 @ stack phys =
addr
> + =A0 =A0 =A0 msr =A0 =A0 cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @=
 set SVC, irqs off
> +#ifdef MULTI_CPU
> + =A0 =A0 =A0 ldmia =A0 r0!, {r1, sp, lr, pc} =A0 @ load v:p, stack, =
return fn, resume fn
> +#else
> + =A0 =A0 =A0 ldmia =A0 r0!, {r1, sp, lr} =A0 =A0 =A0 @ load v:p, sta=
ck, return fn
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_do_resume
> +#endif
> +ENDPROC(cpu_resume)
> +
> +sleep_save_sp:
> + =A0 =A0 =A0 .word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
> index bcf748d..226e3d8 100644
> --- a/arch/arm/mm/proc-arm1020.S
> +++ b/arch/arm/mm/proc-arm1020.S
> @@ -493,6 +493,9 @@ arm1020_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm1020_processor_functions, . - arm1020_pro=
cessor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.=
S
> index ab7ec26..86d9c2c 100644
> --- a/arch/arm/mm/proc-arm1020e.S
> +++ b/arch/arm/mm/proc-arm1020e.S
> @@ -474,6 +474,9 @@ arm1020e_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020e_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020e_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1020e_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm1020e_processor_functions, . - arm1020e_p=
rocessor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
> index 831c5e5..83d3dd3 100644
> --- a/arch/arm/mm/proc-arm1022.S
> +++ b/arch/arm/mm/proc-arm1022.S
> @@ -457,6 +457,9 @@ arm1022_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1022_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1022_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1022_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm1022_processor_functions, . - arm1022_pro=
cessor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
> index e3f7e9a..686043e 100644
> --- a/arch/arm/mm/proc-arm1026.S
> +++ b/arch/arm/mm/proc-arm1026.S
> @@ -452,6 +452,9 @@ arm1026_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1026_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1026_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm1026_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm1026_processor_functions, . - arm1026_pro=
cessor_functions
>
> =A0 =A0 =A0 =A0.section .rodata
> diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
> index 6a7be18..5f79dc4 100644
> --- a/arch/arm/mm/proc-arm6_7.S
> +++ b/arch/arm/mm/proc-arm6_7.S
> @@ -284,6 +284,9 @@ ENTRY(arm6_processor_functions)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm6_dcache_clean_area
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm6_switch_mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm6_set_pte_ext
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 arm6_processor_functions, . =
- arm6_processor_functions
>
> =A0/*
> @@ -301,6 +304,9 @@ ENTRY(arm7_processor_functions)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm7_dcache_clean_area
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm7_switch_mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm7_set_pte_ext
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 arm7_processor_functions, . =
- arm7_processor_functions
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
> index c285395..665266d 100644
> --- a/arch/arm/mm/proc-arm720.S
> +++ b/arch/arm/mm/proc-arm720.S
> @@ -185,6 +185,9 @@ ENTRY(arm720_processor_functions)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm720_dcache_clean_area
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm720_switch_mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm720_set_pte_ext
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 arm720_processor_functions, =
=2E - arm720_processor_functions
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
> index 38b27dc..6f9d12e 100644
> --- a/arch/arm/mm/proc-arm740.S
> +++ b/arch/arm/mm/proc-arm740.S
> @@ -130,6 +130,9 @@ ENTRY(arm740_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_arm740_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm740_switch_mm
> =A0 =A0 =A0 =A0.word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ cpu_*_set_pte
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm740_processor_functions, . - arm740_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.=
S
> index 0c9786d..e4c165c 100644
> --- a/arch/arm/mm/proc-arm7tdmi.S
> +++ b/arch/arm/mm/proc-arm7tdmi.S
> @@ -70,6 +70,9 @@ ENTRY(arm7tdmi_processor_functions)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm7tdmi_dcache_clean_ar=
ea
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm7tdmi_switch_mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ cpu_*_set_pte
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 arm7tdmi_processor_functions=
, . - arm7tdmi_processor_functions
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
> index 6109f27..b2705de 100644
> --- a/arch/arm/mm/proc-arm920.S
> +++ b/arch/arm/mm/proc-arm920.S
> @@ -387,6 +387,40 @@ ENTRY(cpu_arm920_set_pte_ext)
> =A0#endif
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> +/* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S =
*/
> +.globl arm920_suspend_size
> +.equ =A0 arm920_suspend_size, 4 * 3
> +#ifdef CONFIG_PM
> +ENTRY(arm920_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r7, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 0 =A0 @ TTB address
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c1, c0, 0 =A0 @ Control registe=
r
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r7}
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4 - r7, pc}
> +ENDPROC(arm920_do_suspend)
> +
> +ENTRY(arm920_do_resume)
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c8, c7, 0 =A0 @ invalidate I+D =
TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c7, 0 =A0 @ invalidate I+D =
caches
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r7}
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c2, c0, 0 =A0 @ TTB address
> + =A0 =A0 =A0 mov =A0 =A0 r0, r7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 control register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r6, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3DPMD_TYPE_SECT | PMD_SECT_BUFFERABLE =
| \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PMD_SECT_CACHEABLE | PMD_BIT=
4 | PMD_SECT_AP_WRITE
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(arm920_do_resume)
> +#else
> +#define arm920_do_suspend =A0 =A0 =A00
> +#define arm920_do_resume =A0 =A0 =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0 =A0 =A0 =A0.type =A0 __arm920_setup, #function
> @@ -432,6 +466,9 @@ arm920_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm920_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm920_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm920_set_pte_ext
> + =A0 =A0 =A0 .word =A0 arm920_suspend_size
> + =A0 =A0 =A0 .word =A0 arm920_do_suspend
> + =A0 =A0 =A0 .word =A0 arm920_do_resume
> =A0 =A0 =A0 =A0.size =A0 arm920_processor_functions, . - arm920_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
> index bb2f0f4..36154b1 100644
> --- a/arch/arm/mm/proc-arm922.S
> +++ b/arch/arm/mm/proc-arm922.S
> @@ -436,6 +436,9 @@ arm922_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm922_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm922_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm922_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm922_processor_functions, . - arm922_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
> index c13e01a..89c5e00 100644
> --- a/arch/arm/mm/proc-arm925.S
> +++ b/arch/arm/mm/proc-arm925.S
> @@ -503,6 +503,9 @@ arm925_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm925_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm925_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm925_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm925_processor_functions, . - arm925_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
> index 42eb431..3beb784 100644
> --- a/arch/arm/mm/proc-arm926.S
> +++ b/arch/arm/mm/proc-arm926.S
> @@ -401,6 +401,40 @@ ENTRY(cpu_arm926_set_pte_ext)
> =A0#endif
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> +/* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S =
*/
> +.globl arm926_suspend_size
> +.equ =A0 arm926_suspend_size, 4 * 3
> +#ifdef CONFIG_PM
> +ENTRY(arm926_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r7, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c2, c0, 0 =A0 @ TTB address
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c1, c0, 0 =A0 @ Control registe=
r
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r7}
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4 - r7, pc}
> +ENDPROC(arm926_do_suspend)
> +
> +ENTRY(arm926_do_resume)
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c8, c7, 0 =A0 @ invalidate I+D =
TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c7, 0 =A0 @ invalidate I+D =
caches
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r7}
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c2, c0, 0 =A0 @ TTB address
> + =A0 =A0 =A0 mov =A0 =A0 r0, r7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 control register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r6, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3DPMD_TYPE_SECT | PMD_SECT_BUFFERABLE =
| \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PMD_SECT_CACHEABLE | PMD_BIT=
4 | PMD_SECT_AP_WRITE
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(arm926_do_resume)
> +#else
> +#define arm926_do_suspend =A0 =A0 =A00
> +#define arm926_do_resume =A0 =A0 =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0 =A0 =A0 =A0.type =A0 __arm926_setup, #function
> @@ -456,6 +490,9 @@ arm926_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_arm926_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm926_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_arm926_set_pte_ext
> + =A0 =A0 =A0 .word =A0 arm926_suspend_size
> + =A0 =A0 =A0 .word =A0 arm926_do_suspend
> + =A0 =A0 =A0 .word =A0 arm926_do_resume
> =A0 =A0 =A0 =A0.size =A0 arm926_processor_functions, . - arm926_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
> index 7b11cdb..26aea3f 100644
> --- a/arch/arm/mm/proc-arm940.S
> +++ b/arch/arm/mm/proc-arm940.S
> @@ -363,6 +363,9 @@ ENTRY(arm940_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_arm940_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm940_switch_mm
> =A0 =A0 =A0 =A0.word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ cpu_*_set_pt=
e
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm940_processor_functions, . - arm940_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
> index 1a5bbf0..8063345 100644
> --- a/arch/arm/mm/proc-arm946.S
> +++ b/arch/arm/mm/proc-arm946.S
> @@ -419,6 +419,9 @@ ENTRY(arm946_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_arm946_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_arm946_switch_mm
> =A0 =A0 =A0 =A0.word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ cpu_*_set_pt=
e
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 arm946_processor_functions, . - arm946_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.=
S
> index db67e31..7b7ebd4 100644
> --- a/arch/arm/mm/proc-arm9tdmi.S
> +++ b/arch/arm/mm/proc-arm9tdmi.S
> @@ -70,6 +70,9 @@ ENTRY(arm9tdmi_processor_functions)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm9tdmi_dcache_clean_ar=
ea
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 cpu_arm9tdmi_switch_mm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 @ cpu_*_set_pte
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.size =A0 arm9tdmi_processor_functions=
, . - arm9tdmi_processor_functions
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
> index 7c9ad62..fc2a4ae 100644
> --- a/arch/arm/mm/proc-fa526.S
> +++ b/arch/arm/mm/proc-fa526.S
> @@ -195,6 +195,9 @@ fa526_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_fa526_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_fa526_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_fa526_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 fa526_processor_functions, . - fa526_process=
or_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.=
S
> index b4597ed..d3883ee 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -554,6 +554,9 @@ feroceon_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_feroceon_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_feroceon_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_feroceon_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 feroceon_processor_functions, . - feroceon_p=
rocessor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
> index 4458ee6..9d4f2ae 100644
> --- a/arch/arm/mm/proc-mohawk.S
> +++ b/arch/arm/mm/proc-mohawk.S
> @@ -388,6 +388,9 @@ mohawk_processor_functions:
> =A0 =A0 =A0 =A0.word =A0 cpu_mohawk_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_mohawk_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_mohawk_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 mohawk_processor_functions, . - mohawk_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
> index 5aa8d59..46f09ed 100644
> --- a/arch/arm/mm/proc-sa110.S
> +++ b/arch/arm/mm/proc-sa110.S
> @@ -203,6 +203,9 @@ ENTRY(sa110_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_sa110_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_sa110_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_sa110_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 sa110_processor_functions, . - sa110_process=
or_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
> index 2ac4e6f..74483d1 100644
> --- a/arch/arm/mm/proc-sa1100.S
> +++ b/arch/arm/mm/proc-sa1100.S
> @@ -169,6 +169,42 @@ ENTRY(cpu_sa1100_set_pte_ext)
> =A0#endif
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> +.globl cpu_sa1100_suspend_size
> +.equ =A0 cpu_sa1100_suspend_size, 4*4
> +#ifdef CONFIG_PM
> +ENTRY(cpu_sa1100_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r7, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c3, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c2, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 translation table base addr
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 0 =A0 =A0 =A0 =A0 =A0@=
 PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c1, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 control reg
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r7} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ store cp regs
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4 - r7, pc}
> +ENDPROC(cpu_sa1100_do_suspend)
> +
> +ENTRY(cpu_sa1100_do_resume)
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r7} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ load cp regs
> + =A0 =A0 =A0 mov =A0 =A0 r1, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c8, c7, 0 =A0 =A0 =A0 =A0 =A0 @=
 flush I+D TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c7, 0 =A0 =A0 =A0 =A0 =A0 @=
 flush I&D cache
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c9, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 invalidate RB
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c9, c0, 5 =A0 =A0 =A0 =A0 =A0 @=
 allow user space to use RB
> +
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c3, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c2, c0, 0 =A0 =A0 =A0 =A0 =A0 @=
 translation table base addr
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c13, c0, 0 =A0 =A0 =A0 =A0 =A0@=
 PID
> + =A0 =A0 =A0 mov =A0 =A0 r0, r7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0@ control register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r5, lsr #14 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ get TTB0 base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3DPMD_TYPE_SECT | PMD_SECT_BUFFERABLE =
| \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PMD_SECT_CACHEABLE | PMD_SEC=
T_AP_WRITE
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(cpu_sa1100_do_resume)
> +#else
> +#define cpu_sa1100_do_suspend =A00
> +#define cpu_sa1100_do_resume =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0 =A0 =A0 =A0.type =A0 __sa1100_setup, #function
> @@ -218,6 +254,9 @@ ENTRY(sa1100_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_sa1100_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_sa1100_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_sa1100_set_pte_ext
> + =A0 =A0 =A0 .word =A0 cpu_sa1100_suspend_size
> + =A0 =A0 =A0 .word =A0 cpu_sa1100_do_suspend
> + =A0 =A0 =A0 .word =A0 cpu_sa1100_do_resume
> =A0 =A0 =A0 =A0.size =A0 sa1100_processor_functions, . - sa1100_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index 59a7e1f..832b6bd 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -121,6 +121,53 @@ ENTRY(cpu_v6_set_pte_ext)
> =A0#endif
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> +/* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S =
*/
> +.globl cpu_v6_suspend_size
> +.equ =A0 cpu_v6_suspend_size, 4 * 8
> +#ifdef CONFIG_PM
> +ENTRY(cpu_v6_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r11, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ FCSE/PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 1 =A0@ Context ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c2, c0, 0 =A0 @ Translation tab=
le base 0
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r8, c2, c0, 1 =A0 @ Translation tab=
le base 1
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r9, c1, c0, 1 =A0 @ auxillary contr=
ol register
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r10, c1, c0, 2 =A0@ co-processor ac=
cess control
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r11, c1, c0, 0 =A0@ control registe=
r
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r11}
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4- r11, pc}
> +ENDPROC(cpu_v6_do_suspend)
> +
> +ENTRY(cpu_v6_do_resume)
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c14, 0 =A0@ clean+invalidat=
e D cache
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c5, 0 =A0 @ invalidate I ca=
che
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c15, 0 =A0@ clean+invalidat=
e cache
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c10, 4 =A0@ drain write buf=
fer
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r11}
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ FCSE/PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c13, c0, 1 =A0@ Context ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r7, c2, c0, 0 =A0 @ Translation tab=
le base 0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r8, c2, c0, 1 =A0 @ Translation tab=
le base 1
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r9, c1, c0, 1 =A0 @ auxillary contr=
ol register
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r10, c1, c0, 2 =A0@ co-processor ac=
cess control
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c2, c0, 2 =A0 @ TTB control reg=
ister
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c5, 4 =A0 @ ISB
> + =A0 =A0 =A0 mov =A0 =A0 r0, r11 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ c=
ontrol register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r7, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, cpu_resume_l1_flags
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(cpu_v6_do_resume)
> +cpu_resume_l1_flags:
> + =A0 =A0 =A0 ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_F=
LAGS_SMP)
> + =A0 =A0 =A0 ALT_UP(.long =A0PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD=
_FLAGS_UP)
> +#else
> +#define cpu_v6_do_suspend 0
> +#define cpu_v6_do_resume 0
> +#endif
>
>
> =A0 =A0 =A0 =A0.type =A0 cpu_v6_name, #object
> @@ -206,6 +253,9 @@ ENTRY(v6_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_v6_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_v6_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_v6_set_pte_ext
> + =A0 =A0 =A0 .word =A0 cpu_v6_suspend_size
> + =A0 =A0 =A0 .word =A0 cpu_v6_do_suspend
> + =A0 =A0 =A0 .word =A0 cpu_v6_do_resume
> =A0 =A0 =A0 =A0.size =A0 v6_processor_functions, . - v6_processor_fun=
ctions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..a5187dd 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -171,6 +171,87 @@ cpu_v7_name:
> =A0 =A0 =A0 =A0.ascii =A0"ARMv7 Processor"
> =A0 =A0 =A0 =A0.align
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Memory region attributes with SCTLR.TRE=3D1
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* =A0 n =3D TEX[0],C,B
> + =A0 =A0 =A0 =A0* =A0 TR =3D PRRR[2n+1:2n] =A0 =A0 =A0 =A0 - memory =
type
> + =A0 =A0 =A0 =A0* =A0 IR =3D NMRR[2n+1:2n] =A0 =A0 =A0 =A0 - inner c=
acheable property
> + =A0 =A0 =A0 =A0* =A0 OR =3D NMRR[2n+17:2n+16] =A0 =A0 - outer cache=
able property
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n =A0 =A0=
 =A0 TR =A0 =A0 =A0IR =A0 =A0 =A0OR
> + =A0 =A0 =A0 =A0* =A0 UNCACHED =A0 =A0 =A0 =A0 =A0 000 =A0 =A0 00
> + =A0 =A0 =A0 =A0* =A0 BUFFERABLE =A0 =A0 =A0 =A0 001 =A0 =A0 10 =A0 =
=A0 =A000 =A0 =A0 =A000
> + =A0 =A0 =A0 =A0* =A0 WRITETHROUGH =A0 =A0 =A0 010 =A0 =A0 10 =A0 =A0=
 =A010 =A0 =A0 =A010
> + =A0 =A0 =A0 =A0* =A0 WRITEBACK =A0 =A0 =A0 =A0 =A0011 =A0 =A0 10 =A0=
 =A0 =A011 =A0 =A0 =A011
> + =A0 =A0 =A0 =A0* =A0 reserved =A0 =A0 =A0 =A0 =A0 110
> + =A0 =A0 =A0 =A0* =A0 WRITEALLOC =A0 =A0 =A0 =A0 111 =A0 =A0 10 =A0 =
=A0 =A001 =A0 =A0 =A001
> + =A0 =A0 =A0 =A0* =A0 DEV_SHARED =A0 =A0 =A0 =A0 100 =A0 =A0 01
> + =A0 =A0 =A0 =A0* =A0 DEV_NONSHARED =A0 =A0 =A0100 =A0 =A0 01
> + =A0 =A0 =A0 =A0* =A0 DEV_WC =A0 =A0 =A0 =A0 =A0 =A0 001 =A0 =A0 10
> + =A0 =A0 =A0 =A0* =A0 DEV_CACHED =A0 =A0 =A0 =A0 011 =A0 =A0 10
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Other attributes:
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* =A0 DS0 =3D PRRR[16] =3D 0 =A0 =A0 =A0 =A0 - devic=
e shareable property
> + =A0 =A0 =A0 =A0* =A0 DS1 =3D PRRR[17] =3D 1 =A0 =A0 =A0 =A0 - devic=
e shareable property
> + =A0 =A0 =A0 =A0* =A0 NS0 =3D PRRR[18] =3D 0 =A0 =A0 =A0 =A0 - norma=
l shareable property
> + =A0 =A0 =A0 =A0* =A0 NS1 =3D PRRR[19] =3D 1 =A0 =A0 =A0 =A0 - norma=
l shareable property
> + =A0 =A0 =A0 =A0* =A0 NOS =3D PRRR[24+n] =3D 1 =A0 =A0 =A0 - not out=
er shareable
> + =A0 =A0 =A0 =A0*/
> +.equ =A0 PRRR, =A0 0xff0a81a8
> +.equ =A0 NMRR, =A0 0x40e040e0
> +
> +/* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.=
S */
> +.globl cpu_v7_suspend_size
> +.equ =A0 cpu_v7_suspend_size, 4 * 8
> +#ifdef CONFIG_PM
> +ENTRY(cpu_v7_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r11, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ FCSE/PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c13, c0, 1 =A0@ Context ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c2, c0, 0 =A0 @ TTB 0
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r8, c2, c0, 1 =A0 @ TTB 1
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r9, c1, c0, 0 =A0 @ Control registe=
r
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r10, c1, c0, 1 =A0@ Auxiliary contr=
ol register
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r11, c1, c0, 2 =A0@ Co-processor ac=
cess control
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r11}
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4 - r11, pc}
> +ENDPROC(cpu_v7_do_suspend)
> +
> +ENTRY(cpu_v7_do_resume)
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c8, c7, 0 =A0 @ invalidate TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c5, 0 =A0 @ invalidate I ca=
che
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r11}
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c13, c0, 0 =A0@ FCSE/PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c13, c0, 1 =A0@ Context ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c3, c0, 0 =A0 @ Domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r7, c2, c0, 0 =A0 @ TTB 0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r8, c2, c0, 1 =A0 @ TTB 1
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c2, c0, 2 =A0 @ TTB control reg=
ister
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r10, c1, c0, 1 =A0@ Auxillary contr=
ol register
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r11, c1, c0, 2 =A0@ Co-processor ac=
cess control
> + =A0 =A0 =A0 ldr =A0 =A0 r4, =3DPRRR =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ P=
RRR
> + =A0 =A0 =A0 ldr =A0 =A0 r5, =3DNMRR =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ N=
MRR
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r4, c10, c2, 0 =A0@ write PRRR
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c10, c2, 1 =A0@ write NMRR
> + =A0 =A0 =A0 isb
> + =A0 =A0 =A0 mov =A0 =A0 r0, r9 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 control register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r7, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, cpu_resume_l1_flags
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(cpu_v7_do_resume)
> +cpu_resume_l1_flags:
> + =A0 =A0 =A0 ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_F=
LAGS_SMP)
> + =A0 =A0 =A0 ALT_UP(.long =A0PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD=
_FLAGS_UP)
> +#else
> +#define cpu_v7_do_suspend =A0 =A0 =A00
> +#define cpu_v7_do_resume =A0 =A0 =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0/*
> @@ -276,36 +357,8 @@ __v7_setup:
> =A0 =A0 =A0 =A0ALT_SMP(orr =A0 =A0 r4, r4, #TTB_FLAGS_SMP)
> =A0 =A0 =A0 =A0ALT_UP(orr =A0 =A0 =A0r4, r4, #TTB_FLAGS_UP)
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r4, c2, c0, 1 =A0 =A0 =A0 =A0 =A0 =
@ load TTB1
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Memory region attributes with SCTLR.TRE=3D1
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* =A0 n =3D TEX[0],C,B
> - =A0 =A0 =A0 =A0* =A0 TR =3D PRRR[2n+1:2n] =A0 =A0 =A0 =A0 - memory =
type
> - =A0 =A0 =A0 =A0* =A0 IR =3D NMRR[2n+1:2n] =A0 =A0 =A0 =A0 - inner c=
acheable property
> - =A0 =A0 =A0 =A0* =A0 OR =3D NMRR[2n+17:2n+16] =A0 =A0 - outer cache=
able property
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n =A0 =A0=
 =A0 TR =A0 =A0 =A0IR =A0 =A0 =A0OR
> - =A0 =A0 =A0 =A0* =A0 UNCACHED =A0 =A0 =A0 =A0 =A0 000 =A0 =A0 00
> - =A0 =A0 =A0 =A0* =A0 BUFFERABLE =A0 =A0 =A0 =A0 001 =A0 =A0 10 =A0 =
=A0 =A000 =A0 =A0 =A000
> - =A0 =A0 =A0 =A0* =A0 WRITETHROUGH =A0 =A0 =A0 010 =A0 =A0 10 =A0 =A0=
 =A010 =A0 =A0 =A010
> - =A0 =A0 =A0 =A0* =A0 WRITEBACK =A0 =A0 =A0 =A0 =A0011 =A0 =A0 10 =A0=
 =A0 =A011 =A0 =A0 =A011
> - =A0 =A0 =A0 =A0* =A0 reserved =A0 =A0 =A0 =A0 =A0 110
> - =A0 =A0 =A0 =A0* =A0 WRITEALLOC =A0 =A0 =A0 =A0 111 =A0 =A0 10 =A0 =
=A0 =A001 =A0 =A0 =A001
> - =A0 =A0 =A0 =A0* =A0 DEV_SHARED =A0 =A0 =A0 =A0 100 =A0 =A0 01
> - =A0 =A0 =A0 =A0* =A0 DEV_NONSHARED =A0 =A0 =A0100 =A0 =A0 01
> - =A0 =A0 =A0 =A0* =A0 DEV_WC =A0 =A0 =A0 =A0 =A0 =A0 001 =A0 =A0 10
> - =A0 =A0 =A0 =A0* =A0 DEV_CACHED =A0 =A0 =A0 =A0 011 =A0 =A0 10
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* Other attributes:
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* =A0 DS0 =3D PRRR[16] =3D 0 =A0 =A0 =A0 =A0 - devic=
e shareable property
> - =A0 =A0 =A0 =A0* =A0 DS1 =3D PRRR[17] =3D 1 =A0 =A0 =A0 =A0 - devic=
e shareable property
> - =A0 =A0 =A0 =A0* =A0 NS0 =3D PRRR[18] =3D 0 =A0 =A0 =A0 =A0 - norma=
l shareable property
> - =A0 =A0 =A0 =A0* =A0 NS1 =3D PRRR[19] =3D 1 =A0 =A0 =A0 =A0 - norma=
l shareable property
> - =A0 =A0 =A0 =A0* =A0 NOS =3D PRRR[24+n] =3D 1 =A0 =A0 =A0 - not out=
er shareable
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 ldr =A0 =A0 r5, =3D0xff0a81a8 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ PRRR
> - =A0 =A0 =A0 ldr =A0 =A0 r6, =3D0x40e040e0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ NMRR
> + =A0 =A0 =A0 ldr =A0 =A0 r5, =3DPRRR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 @ PRRR
> + =A0 =A0 =A0 ldr =A0 =A0 r6, =3DNMRR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 @ NMRR
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r5, c10, c2, 0 =A0 =A0 =A0 =A0 =A0=
@ write PRRR
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r6, c10, c2, 1 =A0 =A0 =A0 =A0 =A0=
@ write NMRR
> =A0#endif
> @@ -351,6 +404,9 @@ ENTRY(v7_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_v7_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_v7_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_v7_set_pte_ext
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> + =A0 =A0 =A0 .word =A0 0
> =A0 =A0 =A0 =A0.size =A0 v7_processor_functions, . - v7_processor_fun=
ctions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
> index ec26355..63d8b20 100644
> --- a/arch/arm/mm/proc-xsc3.S
> +++ b/arch/arm/mm/proc-xsc3.S
> @@ -413,9 +413,52 @@ ENTRY(cpu_xsc3_set_pte_ext)
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> =A0 =A0 =A0 =A0.ltorg
> -
> =A0 =A0 =A0 =A0.align
>
> +.globl cpu_xsc3_suspend_size
> +.equ =A0 cpu_xsc3_suspend_size, 4 * 8
> +#ifdef CONFIG_PM
> +ENTRY(cpu_xsc3_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r10, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p14, 0, r4, c6, c0, 0 =A0 @ clock configura=
tion, for turbo mode
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c15, c1, 0 =A0@ CP access reg
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c3, c0, 0 =A0 @ domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r8, c2, c0, 0 =A0 @ translation tab=
le base addr
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r9, c1, c0, 1 =A0 @ auxiliary contr=
ol reg
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r10, c1, c0, 0 =A0@ control reg
> + =A0 =A0 =A0 bic =A0 =A0 r4, r4, #2 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ cle=
ar frequency change bit
> + =A0 =A0 =A0 stmia =A0 r0, {r1, r4 - r10} =A0 =A0 =A0@ store v:p off=
set + cp regs
> + =A0 =A0 =A0 ldmia =A0 sp!, {r4 - r10, pc}
> +ENDPROC(cpu_xsc3_do_suspend)
> +
> +ENTRY(cpu_xsc3_do_resume)
> + =A0 =A0 =A0 ldmia =A0 r0, {r1, r4 - r10} =A0 =A0 =A0@ load v:p offs=
et + cp regs
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c7, 0 =A0 @ invalidate I & =
D caches, BTB
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c10, 4 =A0@ drain write (&f=
ill) buffer
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c5, 4 =A0 @ flush prefetch =
buffer
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c8, c7, 0 =A0 @ invalidate I & =
D TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p14, 0, r4, c6, c0, 0 =A0 @ clock configura=
tion, turbo mode.
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c15, c1, 0 =A0@ CP access reg
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r7, c3, c0, 0 =A0 @ domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r8, c2, c0, 0 =A0 @ translation tab=
le base addr
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r9, c1, c0, 1 =A0 @ auxiliary contr=
ol reg
> +
> + =A0 =A0 =A0 @ temporarily map resume_turn_on_mmu into the page tabl=
e,
> + =A0 =A0 =A0 @ otherwise prefetch abort occurs after MMU is turned o=
n
> + =A0 =A0 =A0 mov =A0 =A0 r0, r10 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ c=
ontrol register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r8, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3D0x542e =A0 =A0 =A0 =A0 =A0 =A0 @ sec=
tion flags
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(cpu_xsc3_do_resume)
> +#else
> +#define cpu_xsc3_do_suspend =A0 =A00
> +#define cpu_xsc3_do_resume =A0 =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0 =A0 =A0 =A0.type =A0 __xsc3_setup, #function
> @@ -476,6 +519,9 @@ ENTRY(xsc3_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_xsc3_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_xsc3_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_xsc3_set_pte_ext
> + =A0 =A0 =A0 .word =A0 cpu_xsc3_suspend_size
> + =A0 =A0 =A0 .word =A0 cpu_xsc3_do_suspend
> + =A0 =A0 =A0 .word =A0 cpu_xsc3_do_resume
> =A0 =A0 =A0 =A0.size =A0 xsc3_processor_functions, . - xsc3_processor=
_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
> index 5a37c5e..086038c 100644
> --- a/arch/arm/mm/proc-xscale.S
> +++ b/arch/arm/mm/proc-xscale.S
> @@ -513,11 +513,49 @@ ENTRY(cpu_xscale_set_pte_ext)
> =A0 =A0 =A0 =A0xscale_set_pte_ext_epilogue
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> -
> =A0 =A0 =A0 =A0.ltorg
> -
> =A0 =A0 =A0 =A0.align
>
> +.globl cpu_xscale_suspend_size
> +.equ =A0 cpu_xscale_suspend_size, 4 * 7
> +#ifdef CONFIG_PM
> +ENTRY(cpu_xscale_do_suspend)
> + =A0 =A0 =A0 stmfd =A0 sp!, {r4 - r10, lr}
> + =A0 =A0 =A0 mrc =A0 =A0 p14, 0, r4, c6, c0, 0 =A0 @ clock configura=
tion, for turbo mode
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r5, c15, c1, 0 =A0@ CP access reg
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r6, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r7, c3, c0, 0 =A0 @ domain ID
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r8, c2, c0, 0 =A0 @ translation tab=
le base addr
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r9, c1, c1, 0 =A0 @ auxiliary contr=
ol reg
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r10, c1, c0, 0 =A0@ control reg
> + =A0 =A0 =A0 bic =A0 =A0 r4, r4, #2 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ cle=
ar frequency change bit
> + =A0 =A0 =A0 stmia =A0 r0, {r4 - r10} =A0 =A0 =A0 =A0 =A0@ store cp =
regs
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r4 - r10, pc}
> +ENDPROC(cpu_xscale_do_suspend)
> +
> +ENTRY(cpu_xscale_do_resume)
> + =A0 =A0 =A0 ldmia =A0 r0, {r4 - r10} =A0 =A0 =A0 =A0 =A0@ load cp r=
egs
> + =A0 =A0 =A0 mov =A0 =A0 ip, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c8, c7, 0 =A0 @ invalidate I & =
D TLBs
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, ip, c7, c7, 0 =A0 @ invalidate I & =
D caches, BTB
> + =A0 =A0 =A0 mcr =A0 =A0 p14, 0, r4, c6, c0, 0 =A0 @ clock configura=
tion, turbo mode.
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r5, c15, c1, 0 =A0@ CP access reg
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r6, c13, c0, 0 =A0@ PID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r7, c3, c0, 0 =A0 @ domain ID
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r8, c2, c0, 0 =A0 @ translation tab=
le base addr
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r9, c1, c1, 0 =A0 @ auxiliary contr=
ol reg
> + =A0 =A0 =A0 mov =A0 =A0 r0, r10 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ c=
ontrol register
> + =A0 =A0 =A0 mov =A0 =A0 r2, r8, lsr #14 =A0 =A0 =A0 =A0 @ get TTB0 =
base
> + =A0 =A0 =A0 mov =A0 =A0 r2, r2, lsl #14
> + =A0 =A0 =A0 ldr =A0 =A0 r3, =3DPMD_TYPE_SECT | PMD_SECT_BUFFERABLE =
| \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PMD_SECT_CACHEABLE | PMD_SEC=
T_AP_WRITE
> + =A0 =A0 =A0 b =A0 =A0 =A0 cpu_resume_mmu
> +ENDPROC(cpu_xscale_do_resume)
> +#else
> +#define cpu_xscale_do_suspend =A00
> +#define cpu_xscale_do_resume =A0 0
> +#endif
> +
> =A0 =A0 =A0 =A0__CPUINIT
>
> =A0 =A0 =A0 =A0.type =A0 __xscale_setup, #function
> @@ -565,6 +603,9 @@ ENTRY(xscale_processor_functions)
> =A0 =A0 =A0 =A0.word =A0 cpu_xscale_dcache_clean_area
> =A0 =A0 =A0 =A0.word =A0 cpu_xscale_switch_mm
> =A0 =A0 =A0 =A0.word =A0 cpu_xscale_set_pte_ext
> + =A0 =A0 =A0 .word =A0 cpu_xscale_suspend_size
> + =A0 =A0 =A0 .word =A0 cpu_xscale_do_suspend
> + =A0 =A0 =A0 .word =A0 cpu_xscale_do_resume
> =A0 =A0 =A0 =A0.size =A0 xscale_processor_functions, . - xscale_proce=
ssor_functions
>
> =A0 =A0 =A0 =A0.section ".rodata"
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Acked-by: Colin Cross <ccross@android.com>

Tested with idle and suspend on Tegra 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
