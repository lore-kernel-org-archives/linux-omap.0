From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Thu, 17 Feb 2011 10:41:52 +0000
Message-ID: <1297939312.7096.32.camel@e102568-lin.cambridge.arm.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	 <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	 <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
	 <20110215110453.GB11199@n2100.arm.linux.org.uk>
	 <AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:33052 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751993Ab1BQKmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 05:42:06 -0500
In-Reply-To: <AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org

Colin,

On Tue, 2011-02-15 at 16:26 -0800, Colin Cross wrote:
> On Tue, Feb 15, 2011 at 3:04 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Feb 11, 2011 at 06:50:57PM -0800, Colin Cross wrote:
> >> > +ENDPROC(cpu_resume_turn_mmu_on)
> >> > +cpu_resume_after_mmu:
> >> > +       str     r5, [r2, r4, lsl #2]    @ restore old mapping
> >> > +#ifdef MULTI_CACHE
> >> > +       ldr     r10, =cpu_cache
> >> > +       ldr     pc, [r10, #CACHE_FLUSH_KERN_ALL]
> >> > +#else
> >> > +       b       __cpuc_flush_kern_all
> >> > +#endif
> >
> > I think we can eliminate this cache flush by delaying the cache enable
> > as below.  Could you see whether Tegra 2 survives this please?
> > Thanks.
> >
> > diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> > index bed1876..193be5f 100644
> > --- a/arch/arm/kernel/sleep.S
> > +++ b/arch/arm/kernel/sleep.S
> > @@ -4,6 +4,7 @@
> >  #include <asm/assembler.h>
> >  #include <asm/glue-cache.h>
> >  #include <asm/glue-proc.h>
> > +#include <asm/system.h>
> >        .text
> >
> >  /*
> > @@ -81,25 +82,22 @@ ENTRY(cpu_resume_mmu)
> >        str     r3, [r2, r4, lsl #2]    @ setup 1:1 mapping for mmu code
> >        sub     r2, r2, r1
> >        ldr     r3, =cpu_resume_after_mmu
> > +       bic     r1, r0, #CR_C           @ ensure D-cache is disabled
> >        b       cpu_resume_turn_mmu_on
> >  ENDPROC(cpu_resume_mmu)
> >        .ltorg
> >        .align  5
> >  cpu_resume_turn_mmu_on:
> > -       mcr     p15, 0, r0, c1, c0, 0   @ turn on MMU, caches, etc
> > -       mrc     p15, 0, r0, c0, c0, 0   @ read id reg
> > -       mov     r0, r0
> > -       mov     r0, r0
> > +       mcr     p15, 0, r1, c1, c0, 0   @ turn on MMU, I-cache, etc
> > +       mrc     p15, 0, r1, c0, c0, 0   @ read id reg
> > +       mov     r1, r1
> > +       mov     r1, r1
> >        mov     pc, r3                  @ jump to virtual address
> >  ENDPROC(cpu_resume_turn_mmu_on)
> >  cpu_resume_after_mmu:
> >        str     r5, [r2, r4, lsl #2]    @ restore old mapping
> > -#ifdef MULTI_CACHE
> > -       ldr     r10, =cpu_cache
> > -       ldr     pc, [r10, #CACHE_FLUSH_KERN_ALL]
> > -#else
> > -       b       __cpuc_flush_kern_all
> > -#endif
> > +       mcr     p15, 0, r0, c1, c0, 0   @ turn on D-cache
> > +       mov     pc, lr
> >
> >  /*
> >  * Note: Yes, part of the following code is located into the .data section.
> >
> >
> 
> Tested-by: Colin Cross <ccross@android.com>
> 
> Works for Tegra 2 cpuidle and suspend.
> 

When calling suspend from cpuidle, do you flush the stack (ie CPU
context) from L2 using outer_cache functions ? This has to be done when
one CPU is shut down with L2 enabled for the MMU off resume path to work
properly.
I think that on resume you invalidate L1 in the reset vector before
jumping to cpu_resume, correct ?

Many thanks,
Lorenzo


