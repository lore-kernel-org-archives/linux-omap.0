From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Fri, 11 Feb 2011 15:45:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102111543010.14920@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
 <20110208164747.GD6188@n2100.arm.linux.org.uk>
 <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
 <20110210130430.GB3652@n2100.arm.linux.org.uk>
 <1297343555.9306.9.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23980 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758146Ab1BKUp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 15:45:58 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGH006C20BQPD40@vl-mh-mrz21.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 11 Feb 2011 15:45:26 -0500 (EST)
In-reply-to: <1297343555.9306.9.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Catalin Marinas wrote:

> On Thu, 2011-02-10 at 13:04 +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 09, 2011 at 10:01:33AM +0000, Catalin Marinas wrote:
> > > Could we make the domains usage a run-time feature based on the
> > > architecture version? For ARMv7, we need to have the vectors page
> > > read-only anyway if the SWP emulation is enabled (and I posted a
> > > simple patch in a reply to your email).
> > >
> > > The issue I see is that ARM11MPCore is reported as v7 though we still
> > > use domains on this processor (we could always remove the domains if
> > > TLS register is available or use some more precise architecture
> > > version identification).
> > 
> > We could also do the below, which I think is more logical - SWP emulation
> > requires that CPU domains aren't enabled, so let's make that explicit
> > in the Kconfig.
> 
> This may work but it is to restrictive IMHO. SWP emulation only requires
> that RO user pages are also RO for the kernel. And there is a simple fix
> for this:
> 

The patch below is making the code more straight forward regardless of 
any swp emulation issues.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index ee57640..6e0b349 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -758,17 +758,21 @@ static void __init kuser_get_tls_init(unsigned long vectors)
>  
>  void __init early_trap_init(void)
>  {
> -#if defined(CONFIG_CPU_USE_DOMAINS)
> -	unsigned long vectors = CONFIG_VECTORS_BASE;
> -#else
> -	unsigned long vectors = (unsigned long)vectors_page;
> -#endif
> +	unsigned long vectors;
>  	extern char __stubs_start[], __stubs_end[];
>  	extern char __vectors_start[], __vectors_end[];
>  	extern char __kuser_helper_start[], __kuser_helper_end[];
>  	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
>  
>  	/*
> +	 * On ARMv7, user RO pages are mapped as kernel RO.
> +	 */
> +	if (cpu_architecture() >= 7)
> +		vectors = (unsigned long)vectors_page;
> +	else
> +		vectors = CONFIG_VECTORS_BASE;
> +
> +	/*
>  	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
>  	 * into the vector page, mapped at 0xffff0000, and ensure these
>  	 * are visible to the instruction stream.
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..5f51592 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -146,11 +146,6 @@ ENTRY(cpu_v7_set_pte_ext)
>  
>  	tst	r1, #L_PTE_USER
>  	orrne	r3, r3, #PTE_EXT_AP1
> -#ifdef CONFIG_CPU_USE_DOMAINS
> -	@ allow kernel read/write access to read-only user pages
> -	tstne	r3, #PTE_EXT_APX
> -	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> -#endif
>  
>  	tst	r1, #L_PTE_XN
>  	orrne	r3, r3, #PTE_EXT_XN
> 
> 
> -- 
> Catalin
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
