From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Mon, 17 Jan 2011 17:03:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101171702510.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:59907 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab1AQWDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:03:14 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LF6003Y5T8RLH70@vl-mo-mrz23.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 17 Jan 2011 17:02:52 -0500 (EST)
In-reply-to: <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> Rather than turning off CPU domain switching when the build architecture
> includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> turn it on when it's required to support a CPU architecture.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/mm/Kconfig |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 22a3f4a..29215f5 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -435,25 +435,30 @@ config CPU_32v3
>  	bool
>  	select TLS_REG_EMUL if SMP || !MMU
>  	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
> +	select CPU_USE_DOMAINS if MMU
>  
>  config CPU_32v4
>  	bool
>  	select TLS_REG_EMUL if SMP || !MMU
>  	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
> +	select CPU_USE_DOMAINS if MMU
>  
>  config CPU_32v4T
>  	bool
>  	select TLS_REG_EMUL if SMP || !MMU
>  	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
> +	select CPU_USE_DOMAINS if MMU
>  
>  config CPU_32v5
>  	bool
>  	select TLS_REG_EMUL if SMP || !MMU
>  	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
> +	select CPU_USE_DOMAINS if MMU
>  
>  config CPU_32v6
>  	bool
>  	select TLS_REG_EMUL if !CPU_32v6K && !MMU
> +	select CPU_USE_DOMAINS if CPU_V6 && MMU
>  
>  config CPU_32v6K
>  	bool "Support ARM V6K processor extensions" if !SMP
> @@ -620,8 +625,6 @@ config CPU_CP15_MPU
>  
>  config CPU_USE_DOMAINS
>  	bool
> -	depends on MMU
> -	default y if !CPU_32v6K
>  	help
>  	  This option enables or disables the use of domain switching
>  	  via the set_fs() function.
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
