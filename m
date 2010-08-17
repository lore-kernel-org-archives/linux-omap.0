From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] ARM: Allow optional UP processor functions for SMP
	kernels
Date: Tue, 17 Aug 2010 12:08:57 +0100
Message-ID: <20100817110857.GB20325@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100817105325.19061.93324.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43963 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab0HQLJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 07:09:09 -0400
Content-Disposition: inline
In-Reply-To: <20100817105325.19061.93324.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Tue, Aug 17, 2010 at 01:53:25PM +0300, Tony Lindgren wrote:
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index e621530..1c2f587 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -18,4 +18,13 @@ static inline int cache_ops_need_broadcast(void)
>  	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
>  }
>  
> +#ifdef CONFIG_SMP_ON_UP
> +extern int smp_on_up(void);
> +#else
> +static inline int smp_on_up(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index d5231ae..5f3606c 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -289,6 +289,50 @@ static void __init feat_v6_fixup(void)
>  		elf_hwcap &= ~HWCAP_TLS;
>  }
>  
> +#ifdef CONFIG_SMP_ON_UP
> +
> +static int _smp_on_up;
> +
> +int smp_on_up(void)
> +{
> +	return _smp_on_up;
> +}

This kind of function to access one bit of data is really silly and
expensive.  If you want to do something like this to hide the data
itself, then instead do this in the header file:

static inline int smp_on_up(void)
{
#ifdef CONFIG_SMP_ON_UP
	extern int _smp_on_up;
	return _smp_on_up;
#else
	return 0;
#endif
}

rather than making the compiler unable to optimize this call by spilling
at least 5 registers each time.

> +	if (list->proc_up)
> +		processor = *list->proc_up;
> +
> +	if (list->tlb_up)
> +		cpu_tlb = *list->tlb_up;
> +
> +	if (list->cache_up)
> +		cpu_cache = *list->cache_up;

I don't think this is a good approach at all - most of the assembly
is identical and I'm sure there's a much better approach to fixing
these things up.
