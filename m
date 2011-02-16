From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Tue, 15 Feb 2011 16:26:00 -0800
Message-ID: <AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com>
	<20110215110453.GB11199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110215110453.GB11199@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 15, 2011 at 3:04 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 11, 2011 at 06:50:57PM -0800, Colin Cross wrote:
>> > +ENDPROC(cpu_resume_turn_mmu_on)
>> > +cpu_resume_after_mmu:
>> > + =A0 =A0 =A0 str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore old ma=
pping
>> > +#ifdef MULTI_CACHE
>> > + =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
>> > + =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
>> > +#else
>> > + =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
>> > +#endif
>
> I think we can eliminate this cache flush by delaying the cache enable
> as below. =A0Could you see whether Tegra 2 survives this please?
> Thanks.
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index bed1876..193be5f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -4,6 +4,7 @@
> =A0#include <asm/assembler.h>
> =A0#include <asm/glue-cache.h>
> =A0#include <asm/glue-proc.h>
> +#include <asm/system.h>
> =A0 =A0 =A0 =A0.text
>
> =A0/*
> @@ -81,25 +82,22 @@ ENTRY(cpu_resume_mmu)
> =A0 =A0 =A0 =A0str =A0 =A0 r3, [r2, r4, lsl #2] =A0 =A0@ setup 1:1 mappin=
g for mmu code
> =A0 =A0 =A0 =A0sub =A0 =A0 r2, r2, r1
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, =3Dcpu_resume_after_mmu
> + =A0 =A0 =A0 bic =A0 =A0 r1, r0, #CR_C =A0 =A0 =A0 =A0 =A0 @ ensure D-ca=
che is disabled
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 cpu_resume_turn_mmu_on
> =A0ENDPROC(cpu_resume_mmu)
> =A0 =A0 =A0 =A0.ltorg
> =A0 =A0 =A0 =A0.align =A05
> =A0cpu_resume_turn_mmu_on:
> - =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 0 =A0 @ turn on MMU, caches=
, etc
> - =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r0, c0, c0, 0 =A0 @ read id reg
> - =A0 =A0 =A0 mov =A0 =A0 r0, r0
> - =A0 =A0 =A0 mov =A0 =A0 r0, r0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c1, c0, 0 =A0 @ turn on MMU, I-cach=
e, etc
> + =A0 =A0 =A0 mrc =A0 =A0 p15, 0, r1, c0, c0, 0 =A0 @ read id reg
> + =A0 =A0 =A0 mov =A0 =A0 r1, r1
> + =A0 =A0 =A0 mov =A0 =A0 r1, r1
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, r3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ ju=
mp to virtual address
> =A0ENDPROC(cpu_resume_turn_mmu_on)
> =A0cpu_resume_after_mmu:
> =A0 =A0 =A0 =A0str =A0 =A0 r5, [r2, r4, lsl #2] =A0 =A0@ restore old mapp=
ing
> -#ifdef MULTI_CACHE
> - =A0 =A0 =A0 ldr =A0 =A0 r10, =3Dcpu_cache
> - =A0 =A0 =A0 ldr =A0 =A0 pc, [r10, #CACHE_FLUSH_KERN_ALL]
> -#else
> - =A0 =A0 =A0 b =A0 =A0 =A0 __cpuc_flush_kern_all
> -#endif
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c1, c0, 0 =A0 @ turn on D-cache
> + =A0 =A0 =A0 mov =A0 =A0 pc, lr
>
> =A0/*
> =A0* Note: Yes, part of the following code is located into the .data sect=
ion.
>
>

Tested-by: Colin Cross <ccross@android.com>

Works for Tegra 2 cpuidle and suspend.
