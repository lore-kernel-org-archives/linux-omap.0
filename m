From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Tue, 29 Jun 2010 15:20:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006291355520.24097@xanadu.home>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
 <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com>
 <20100623133636.GC7058@shareable.org> <20100629141836.GM2822@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:55558 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0F2TUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 15:20:53 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L4S009J5J29JNE0@VL-MR-MR002.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 29 Jun 2010 15:20:34 -0400 (EDT)
In-reply-to: <20100629141836.GM2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 29 Jun 2010, Tony Lindgren wrote:

> OK. Sorry for the delay again. Here's an updated version that sets
> __kuser_get_tls instruction dynamically. Does this do what you were
> thinking, or did I miss something?

See my comments below.

> Also, can we detect somehow the hardware that uses CONFIG_TLS_REG_EMUL?
> Might be possible to remove that Kconfig option too later on..

Well... I don't think we _should_ try to detect it as it is not widely 
available if at all.

And there is actually a "bug" with __kuser_get_tls because if ever 
CONFIG_TLS_REG_EMUL is selected then a call to __kuser_get_tls is 
currently doing nothing while it should actually use the mrc 
instruction.

> diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
> index f7bd52b..c1062c3 100644
> --- a/arch/arm/include/asm/hwcap.h
> +++ b/arch/arm/include/asm/hwcap.h
> @@ -19,6 +19,7 @@
>  #define HWCAP_NEON	4096
>  #define HWCAP_VFPv3	8192
>  #define HWCAP_VFPv3D16	16384
> +#define HWCAP_TLS	32768
>  
>  #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
>  /*
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 7ee48e7..949df9b 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -739,11 +739,13 @@ ENTRY(__switch_to)
>  #ifdef CONFIG_MMU
>  	ldr	r6, [r2, #TI_CPU_DOMAIN]
>  #endif
> -#if defined(CONFIG_HAS_TLS_REG)
> -	mcr	p15, 0, r3, c13, c0, 3		@ set TLS register
> -#elif !defined(CONFIG_TLS_REG_EMUL)
> -	mov	r4, #0xffff0fff
> -	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
> +#if !defined(CONFIG_TLS_REG_EMUL)
> +	ldr	r4, =elf_hwcap
> +	ldr	r4, [r4, #0]
> +	mov	r5, #0xffff0fff
> +	tst	r4, #HWCAP_TLS			@ hardware TLS available?
> +	mcrne	p15, 0, r3, c13, c0, 3		@ yes, set TLS register
> +	streq	r3, [r5, #-15]			@ set TLS value at 0xffff0ff0
>  #endif

Could this be a tristate instead?  There are actually 3 cases:

1) We know the TLS reg is _always_ available i.e. ARMv6K, ARMV7 and 
   above.  In that case the test on elf_hwcap is redundant and wasteful.

2) We know the TLS reg is _never_ available i.e. pre-ARMv6.  The test on 
   elf_hwcap is again redundant and wasteful.

3) We're unsure as the actual CPU is known only at run time.

Case #1 will become the common case in the future.  Case #2 is still 
widely relevant for deployed systems in the field, and some popular 
ARMv5TE based SOCs are still produced right now.  So instead of 
replacing #1 and #2 with #3, I think you should add #3 to the other 
cases instead.

>  #ifdef CONFIG_MMU
>  	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
> @@ -1009,16 +1011,13 @@ kuser_cmpxchg_fixup:
>   */
>  
>  __kuser_get_tls:				@ 0xffff0fe0
> -
> -#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
> -	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
> -#else
> -	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
> -#endif
> +	nop				@ read TLS, set in kuser_get_tls_init
>  	usr_ret	lr
> -
> -	.rep	5
> -	.word	0			@ pad up to __kuser_helper_version
> +	mrc	p15, 0, r0, c13, c0, 3	@ 0xffff0fe8 hardware TLS code
> +	ldr	r0, [pc, #(16 - 8)]	@ 0xffff0fec software TLS code
> +	.word	0			@ 0xffff0ff0 software TLS value
> +	nop				@ pad up to __kuser_helper_version
> +	nop
>  	.endr

This looks obscur.  The idea of patching the appropriate instruction at 
runtime here is a good one.  However I'd simply keep the ldr version in 
place otherwise the pc displacement doesn't match anymore when 
disassembling.  And simply overwrite it with the mrc version when 
necessary.

BTW you left a stray .endr here.

>  /*
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 122d999..a675260 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -269,6 +269,27 @@ static void __init cacheid_init(void)
>  extern struct proc_info_list *lookup_processor_type(unsigned int);
>  extern struct machine_desc *lookup_machine_type(unsigned int);
>  
> +#ifdef CONFIG_CPU_V6
> +static void __init feat_v6_fixup(void)
> +{
> +	int id = read_cpuid_id();
> +
> +	if (id & 0x000f0000 != 0x00070000)
> +		return;
> +
> +	/*
> +	 * HWCAP_TLS is available only on 1136 r1p0 and later,
> +	 * see also kuser_get_tls_init.
> +	 */
> +	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
> +		elf_hwcap &= ~HWCAP_TLS;

You should probably test for the vendor ID as well (ARM in this case).

> +}
> +#else
> +static inline void feat_v6_fixup(void)
> +{
> +}
> +#endif

I think the #ifdef is unnecessary here.  This is __init code anyway, so 
this could as well be always compiled in.

> +
>  static void __init setup_processor(void)
>  {
>  	struct proc_info_list *list;
> @@ -311,6 +332,8 @@ static void __init setup_processor(void)
>  	elf_hwcap &= ~HWCAP_THUMB;
>  #endif
>  
> +	feat_v6_fixup();
> +
>  	cacheid_init();
>  	cpu_proc_init();
>  }
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 1621e53..85dd001 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -518,16 +518,19 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
>  
>  	case NR(set_tls):
>  		thread->tp_value = regs->ARM_r0;
> -#if defined(CONFIG_HAS_TLS_REG)
> -		asm ("mcr p15, 0, %0, c13, c0, 3" : : "r" (regs->ARM_r0) );
> -#elif !defined(CONFIG_TLS_REG_EMUL)
> -		/*
> -		 * User space must never try to access this directly.
> -		 * Expect your app to break eventually if you do so.
> -		 * The user helper at 0xffff0fe0 must be used instead.
> -		 * (see entry-armv.S for details)
> -		 */
> -		*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
> +#if !defined(CONFIG_TLS_REG_EMUL)
> +		if (elf_hwcap & HWCAP_TLS) {
> +			asm ("mcr p15, 0, %0, c13, c0, 3"
> +				: : "r" (regs->ARM_r0));
> +		} else {
> +			/*
> +			 * User space must never try to access this directly.
> +			 * Expect your app to break eventually if you do so.
> +			 * The user helper at 0xffff0fe0 must be used instead.
> +			 * (see entry-armv.S for details)
> +			 */
> +			*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
> +		}
>  #endif

The same comment as for __kuser_get_tls would apply here.  However, 
instead of duplicating the code block, you could define a macro, such as 
has_tls_reg(), that would be either 0, 1, or ((elf_hwcap & HWCAP_TLS).

>  		return 0;
>  
> @@ -743,6 +746,21 @@ void __init trap_init(void)
>  	return;
>  }
>  
> +#if defined(CONFIG_TLS_REG_EMUL)
> +static void __init kuser_get_tls_init(unsigned long vectors)
> +{
> +	memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> +}
> +#else
> +static void __init kuser_get_tls_init(unsigned long vectors)
> +{
> +	if (elf_hwcap & HWCAP_TLS)
> +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> +	else
> +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfec, 4);
> +}
> +#endif

Please move the #ifdef within the function body.  Also it would be nice 
to add comments about what those magic offsets are.


Nicolas
