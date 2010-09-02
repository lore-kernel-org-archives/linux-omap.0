From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early
	init testing
Date: Thu, 2 Sep 2010 18:08:30 +0100
Message-ID: <20100902170830.GW26319@n2100.arm.linux.org.uk>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk> <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com> <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59464 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab0IBRIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 13:08:38 -0400
Content-Disposition: inline
In-Reply-To: <20100902161846.GK11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> >From 7044c13594c3023da6095f8d432eda260bc3207f Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 30 Aug 2010 14:00:54 -0700
> Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
> 
> Add inline function smp_on_up() for early init checks, and
> change build_mem_type_table to use it.

Isn't something missing from this - such as a C-mode definition of
SMP() and UP() ?

> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 8db3512..5ef4114 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
>  #define UP(instr...)	_str(instr)
>  #endif
>  
> +static inline int smp_on_up(void)
> +{
> +#ifdef CONFIG_SMP_ON_UP
> +	int smp_on_up;
> +
> +	asm(							\
> +		SMP(mov	%0, #0)					\
> +		UP(mov	%0, #1)					\
> +		: "=r" (smp_on_up));
> +
> +	return smp_on_up;
> +#else
> +	return 0;
> +#endif

I think this is the wrong approach - rather than a function which tells us
just if we are a SMP kernel running on UP, why not something which returns
whether we're running on SMP and use that to eliminate some of these ifdefs?
