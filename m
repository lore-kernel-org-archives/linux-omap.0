From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
 asm/spinlock.h
Date: Mon, 17 Jan 2011 15:13:04 -0800
Message-ID: <20110117231304.GD4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24867 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1AQXNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:13:17 -0500
Content-Disposition: inline
In-Reply-To: <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:21]:
> SMP requires at least the ARMv6K extensions to be present, so if we're
> running on SMP, the WFE and SEV instructions must be available.
> 
> However, when we run on UP, the v6K extensions may not be available,
> and so we don't want WFE/SEV to be in the instruction stream.  Use the
> SMP alternatives infrastructure to replace these instructions with NOPs
> if we build for SMP but run on UP.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Boots on omap242x (ARMv6 without K) and omap3/4:

Tested-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/include/asm/spinlock.h |   37 +++++++++++++++++++++++++------------
>  1 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index 17eb355..da1af52 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -5,17 +5,36 @@
>  #error SMP not supported on pre-ARMv6 CPUs
>  #endif
>  
> +/*
> + * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
> + * extensions, so when running on UP, we have to patch these instructions away.
> + */
> +#define ALT_SMP(smp, up)					\
> +	"9998:	" smp "\n"					\
> +	"	.pushsection \".alt.smp.init\", \"a\"\n"	\
> +	"	.long	9998b\n"				\
> +	"	" up "\n"					\
> +	"	.popsection\n"
> +
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define SEV		ALT_SMP("sev.w", "nop.w")
> +#define WFE(cond)	ALT_SMP("wfe" cond ".w", "nop.w")
> +#else
> +#define SEV		ALT_SMP("sev", "nop")
> +#define WFE(cond)	ALT_SMP("wfe" cond, "nop")
> +#endif
> +
>  static inline void dsb_sev(void)
>  {
>  #if __LINUX_ARM_ARCH__ >= 7
>  	__asm__ __volatile__ (
>  		"dsb\n"
> -		"sev"
> +		SEV
>  	);
> -#elif defined(CONFIG_CPU_32v6K)
> +#else
>  	__asm__ __volatile__ (
>  		"mcr p15, 0, %0, c7, c10, 4\n"
> -		"sev"
> +		SEV
>  		: : "r" (0)
>  	);
>  #endif
> @@ -46,9 +65,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  	__asm__ __volatile__(
>  "1:	ldrex	%0, [%1]\n"
>  "	teq	%0, #0\n"
> -#ifdef CONFIG_CPU_32v6K
> -"	wfene\n"
> -#endif
> +	WFE("ne")
>  "	strexeq	%0, %2, [%1]\n"
>  "	teqeq	%0, #0\n"
>  "	bne	1b"
> @@ -107,9 +124,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
>  	__asm__ __volatile__(
>  "1:	ldrex	%0, [%1]\n"
>  "	teq	%0, #0\n"
> -#ifdef CONFIG_CPU_32v6K
> -"	wfene\n"
> -#endif
> +	WFE("ne")
>  "	strexeq	%0, %2, [%1]\n"
>  "	teq	%0, #0\n"
>  "	bne	1b"
> @@ -176,9 +191,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
>  "1:	ldrex	%0, [%2]\n"
>  "	adds	%0, %0, #1\n"
>  "	strexpl	%1, %0, [%2]\n"
> -#ifdef CONFIG_CPU_32v6K
> -"	wfemi\n"
> -#endif
> +	WFE("mi")
>  "	rsbpls	%0, %1, #0\n"
>  "	bmi	1b"
>  	: "=&r" (tmp), "=&r" (tmp2)
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
