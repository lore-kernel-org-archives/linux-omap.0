From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Thu, 17 Feb 2011 12:05:59 -0800
Message-ID: <AANLkTincWLyqdtAoS4gxvhGZGRdzRAiQ41Pn8QSG-id=@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
	<20110215110453.GB11199@n2100.arm.linux.org.uk>
	<AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com>
	<1297939312.7096.32.camel@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:51651 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922Ab1BQUHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 15:07:44 -0500
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p1HK7hAe017406
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 12:07:43 -0800
Received: from vxa37 (vxa37.prod.google.com [10.241.33.37])
	by wpaz24.hot.corp.google.com with ESMTP id p1HK7UNB006661
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 12:07:42 -0800
Received: by vxa37 with SMTP id 37so1393302vxa.6
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 12:07:42 -0800 (PST)
In-Reply-To: <1297939312.7096.32.camel@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 17, 2011 at 2:41 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Colin,
>
> On Tue, 2011-02-15 at 16:26 -0800, Colin Cross wrote:
>> On Tue, Feb 15, 2011 at 3:04 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Feb 11, 2011 at 06:50:57PM -0800, Colin Cross wrote:
>> >> > +ENDPROC(cpu_resume_turn_mmu_on)
>> >> > +cpu_resume_after_mmu:
>> >> > + =A0 =A0 =A0 str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore=
 old mapping
>> >> > +#ifdef MULTI_CACHE
>> >> > + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
>> >> > + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
>> >> > +#else
>> >> > + =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
>> >> > +#endif
>> >
>> > I think we can eliminate this cache flush by delaying the cache en=
able
>> > as below. =A0Could you see whether Tegra 2 survives this please?
>> > Thanks.
>> >
>> > diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
>> > index bed1876..193be5f 100644
>> > --- a/arch/arm/kernel/sleep.S
>> > +++ b/arch/arm/kernel/sleep.S
>> > @@ -4,6 +4,7 @@
>> > =A0#include <asm/assembler.h>
>> > =A0#include <asm/glue-cache.h>
>> > =A0#include <asm/glue-proc.h>
>> > +#include <asm/system.h>
>> > =A0 =A0 =A0 =A0.text
>> >
>> > =A0/*
>> > @@ -81,25 +82,22 @@ ENTRY(cpu_resume_mmu)
>> > =A0 =A0 =A0 =A0str =A0 =A0 r3, [r2, r4, lsl #2] =A0 =A0@ setup 1:1=
 mapping for mmu code
>> > =A0 =A0 =A0 =A0sub =A0 =A0 r2, r2, r1
>> > =A0 =A0 =A0 =A0ldr =A0 =A0 r3, =3Dcpu_resume_after_mmu
>> > + =A0 =A0 =A0 bic =A0 =A0 r1, r0, #CR_C =A0 =A0 =A0 =A0 =A0 @ ensu=
re D-cache is disabled
>> > =A0 =A0 =A0 =A0b =A0 =A0 =A0 cpu_resume_turn_mmu_on
>> > =A0ENDPROC(cpu_resume_mmu)
>> > =A0 =A0 =A0 =A0.ltorg
>> > =A0 =A0 =A0 =A0.align =A05
>> > =A0cpu_resume_turn_mmu_on:
>> > - =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 0 =A0 @ turn on MMU,=
 caches, etc
>> > - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r0, c0, c0, 0 =A0 @ read id reg
>> > - =A0 =A0 =A0 mov =A0 =A0 r0, r0
>> > - =A0 =A0 =A0 mov =A0 =A0 r0, r0
>> > + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c1, c0, 0 =A0 @ turn on MMU,=
 I-cache, etc
>> > + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r1, c0, c0, 0 =A0 @ read id reg
>> > + =A0 =A0 =A0 mov =A0 =A0 r1, r1
>> > + =A0 =A0 =A0 mov =A0 =A0 r1, r1
>> > =A0 =A0 =A0 =A0mov =A0 =A0 pc, r3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0@ jump to virtual address
>> > =A0ENDPROC(cpu_resume_turn_mmu_on)
>> > =A0cpu_resume_after_mmu:
>> > =A0 =A0 =A0 =A0str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore o=
ld mapping
>> > -#ifdef MULTI_CACHE
>> > - =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
>> > - =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
>> > -#else
>> > - =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
>> > -#endif
>> > + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 0 =A0 @ turn on D-ca=
che
>> > + =A0 =A0 =A0 mov =A0 =A0 pc, lr
>> >
>> > =A0/*
>> > =A0* Note: Yes, part of the following code is located into the .da=
ta section.
>> >
>> >
>>
>> Tested-by: Colin Cross <ccross@android.com>
>>
>> Works for Tegra 2 cpuidle and suspend.
>>
>
> When calling suspend from cpuidle, do you flush the stack (ie CPU
> context) from L2 using outer_cache functions ? This has to be done wh=
en
> one CPU is shut down with L2 enabled for the MMU off resume path to w=
ork
> properly.
Tegra2 has the power rails of the two cpus tied together, so the cpu
that suspends first only needs to go through cpu_resume if the other
cpu has also suspended and flushed the entire L2 cache.  On platforms
that can power gate the cpus individually you will need to flush the
stack and stack pointer in cpu_suspend.  I have a patch that does the
flushes in cpu_suspend, but it failed on the way back up because the
page table modifications got lost behind the L2, and I haven't retried
it since Russell fixed that.

> I think that on resume you invalidate L1 in the reset vector before
> jumping to cpu_resume, correct ?
I manually invalidate the L1 Dcache, but not the Icache.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
