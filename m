From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode
Date: Sat, 06 Oct 2012 16:47:13 +0200
Message-ID: <d33d89a21809e413076781ba0d44502c@localhost>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com> <1347036934-8519-3-git-send-email-marc.zyngier@arm.com> <20121005200822.GQ3874@atomide.com> <6d3553bfe8a2d1ac88cab852100616a7@localhost> <alpine.LFD.2.02.1210060955230.16518@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:35030 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260Ab2JFOrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 10:47:17 -0400
In-Reply-To: <alpine.LFD.2.02.1210060955230.16518@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Sat, 6 Oct 2012 10:06:00 -0400 (EDT), Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Sat, 6 Oct 2012, Marc Zyngier wrote:
> 
>> Hi Tony,
>> 
>> On Fri, 5 Oct 2012 13:08:22 -0700, Tony Lindgren <tony@atomide.com>
>> wrote:
>> > Hi,
>> > 
>> > * Marc Zyngier <marc.zyngier@arm.com> [120907 10:04]:
>> >> From: Dave Martin <dave.martin@linaro.org>
>> >> 
>> >> This patch does two things:
>> >> 
>> >>   * Ensure that asynchronous aborts are masked at kernel entry.
>> >>     The bootloader should be masking these anyway, but this reduces
>> >>     the damage window just in case it doesn't.
>> >> 
>> >>   * Enter svc mode via exception return to ensure that CPU state is
>> >>     properly serialised.  This does not matter when switching from
>> >>     an ordinary privileged mode ("PL1" modes in ARMv7-AR rev C
>> >>     parlance), but it potentially does matter when switching from a
>> >>     another privileged mode such as hyp mode.
>> >> 
>> >> This should allow the kernel to boot safely either from svc mode or
>> >> hyp mode, even if no support for use of the ARM Virtualization
>> >> Extensions is built into the kernel.
>> >> 
>> >> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> > 
>> > Just bisected this down in linux-next for breaking booting of
>> > my omap2420 ARMv6 based n8x0..
>> > 
>> >> --- a/arch/arm/kernel/head.S
>> >> +++ b/arch/arm/kernel/head.S
>> >> @@ -83,8 +83,12 @@ ENTRY(stext)
>> >>   THUMB(	.thumb			)	@ switch to Thumb now.
>> >>   THUMB(1:			)
>> >>  
>> >> -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
>> >> -						@ and irqs disabled
>> >> +#ifdef CONFIG_ARM_VIRT_EXT
>> >> +	bl	__hyp_stub_install
>> >> +#endif
>> >> +	@ ensure svc mode and all interrupts masked
>> >> +	safe_svcmode_maskall r9
>> >> +
>> >>  	mrc	p15, 0, r9, c0, c0		@ get processor id
>> >>  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
>> >>  	movs	r10, r5				@ invalid processor (r5=0)?
>> > 
>> > ..and looks like undoing this part fixes it. Any ideas?
>> > 
>> > I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
>> > ARMv6 but that does not help.
>> 
>> If you compiled for v6 only, we can safely exclude __hyp_stub_install,
>> and
>> I assume that you get past the decompressor.
>> 
>> If so, that indicates some side effect of the safe_svcmode_maskall
macro,
>> and I suspect the "movs pc, lr" bit.
> 
> That would be surprizing if the "movs pc, lr" was to blame.  This should

> work on all architectures.
> 
> However the A bit might be to blame.
> 
>> Can you try the attached patch? It basically falls back to the previous
>> behaviour if not entered in HYP mode.
> 
> This is likely to work of course.  However I think we should try to 
> pinpoint the exact problem i.e. whether it is the A bit or the "movs pc,

> lr" which makes a difference (it is unlikely to be both).

Agreed. We need to get to the bottom of this. Also, finding out which
revisions of the 1136 are present on both of Tony's platforms could help
understanding why this works on OMAP 2430 and not 2420.

> So I was about to suggest to test this patch as well:
> 
> diff --git a/arch/arm/include/asm/assembler.h
> b/arch/arm/include/asm/assembler.h
> index 683a1e6b60..118e22ee46 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -254,8 +254,7 @@
>  	mov	lr , \reg
>  	and	lr , lr , #MODE_MASK
>  	cmp	lr , #HYP_MODE
> -	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
> -	bic	\reg , \reg , #MODE_MASK
> +	mov	\reg , #PSR_I_BIT | PSR_F_BIT
>  	orr	\reg , \reg , #SVC_MODE
>  THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	msr	spsr_cxsf, \reg

Yup, that should give us all the information we need.

Thanks Nico.

        M.
-- 
Fast, cheap, reliable. Pick two.
