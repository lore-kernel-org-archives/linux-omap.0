From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Mon, 06 Sep 2010 12:46:34 +0100
Message-ID: <1283773594.11660.10.camel@e102109-lin.cambridge.arm.com>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk>
	 <20100820120622.GL25742@atomide.com><20100830225527.GC11597@atomide.com>
	 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
	 <20100902161659.GJ11597@atomide.com><20100902162039.GM11597@atomide.com>
	 <20100902162537.GU26319@n2100.arm.linux.org.uk>
	 <20100902163453.GR11597@atomide.com><20100902234746.GF11597@atomide.com>
	 <20100903090734.GJ26319@n2100.arm.linux.org.uk>
	 <20100903091029.GK26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46607 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753646Ab0IFLqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 07:46:55 -0400
In-Reply-To: <20100903091029.GK26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

Russell,

I can see you posted another version while writing this e-mail. But I
think most comments still apply. 

On Fri, 2010-09-03 at 10:10 +0100, Russell King - ARM Linux wrote:
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 6e8f05c..55974d2 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -154,16 +154,32 @@
>         .long   9999b,9001f;                    \
>         .popsection
> 
> +#ifdef CONFIG_SMP
> +#define SMP(instr...)                                          \
> +9998:  instr
> +#define UP(instr...)                                           \
> +       .pushsection ".smpalt.init", "a"                        ;\
> +       .word   9998b                                           ;\
> +       instr                                                   ;\
> +       .popsection
> +#else
> +#define SMP(instr...)
> +#define UP(instr...) instr
> +#endif

Would this work with Thumb-2 kernel builds? Maybe you can add a W(instr)
in the SMP/UP macros to make sure that the instruction is always 32-bit
wide.

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index bb8e93a..bb2ef60 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -965,11 +965,8 @@ kuser_cmpxchg_fixup:
>         beq     1b
>         rsbs    r0, r3, #0
>         /* beware -- each __kuser slot must be 8 instructions max */
> -#ifdef CONFIG_SMP
> -       b       __kuser_memory_barrier
> -#else
> -       usr_ret lr
> -#endif
> +       SMP(b   __kuser_memory_barrier)
> +       UP(usr_ret      lr)

Ah, the automatic W() I mentioned above wouldn't work for macros.

> @@ -333,4 +336,35 @@ __create_page_tables:
>  ENDPROC(__create_page_tables)
>         .ltorg
> 
> +#ifdef CONFIG_SMP_ON_UP
> +__fixup_smp:
> +       and     r0, r9, #0xff000000
> +       teq     r0, #0x41000000         @ ARM CPU?
> +       bne     smp_on_up               @ no, assume UP

That's a bit restricting but I'm not sure we have a better way. If we
have the new CPUID format (MIDR[19:16] = 0xf), we can check MMFR0[31:28]
for 1 which means "implemented with hardware coherency support".

> +       and     r0, r9, #0x00070000
> +       teq     r0, #0x00070000         @ ARMv6/v7?
> +       bne     smp_on_up               @ no, assume UP
> +       mrc     p15, 0, r0, c0, c0, 5   @ read MIDR

Typo in comment - MPIDR.

I think this applies to the smp_midr.h file. Should we call it
smp_mpidr.h or just mpidr.h?

> +       movs    r0, r0, lsr #30
> +       teqne   r0, #3                  @ check top two bits 00 or 11
> +       movne   pc, lr
> +
> +smp_on_up:
> +       adr     r0, 1f
> +       ldmia   r0, {r3, r6, r7}
> +       sub     r3, r0, r3
> +       add     r6, r6, r3
> +       add     r7, r7, r3
> +2:     cmp     r6, r7
> +       ldmia   r6!, {r0, r4}
> +       movhs   pc, lr
> +       str     r4, [r0, r3]
> +       b       2b
> +ENDPROC(__fixup_smp)
> +
> +1:     .word   .
> +       .word   __smpalt_begin
> +       .word   __smpalt_end

I think a '.align 2' would be useful as Thumb-2 code may break the
alignment of 1f.

-- 
Catalin

