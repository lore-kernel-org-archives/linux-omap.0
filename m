From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] ARM: remove NR_IRQS dependency for ARM-specific
 HARDIRQ_BITS definition
Date: Tue, 25 Oct 2011 13:45:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110251343580.31312@xanadu.home>
References: <1319541948-10035-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:48225 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab1JYLp2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2011 07:45:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LTM00HMWDY2LJ50@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 25 Oct 2011 07:44:26 -0400 (EDT)
In-reply-to: <1319541948-10035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 25 Oct 2011, Kevin Hilman wrote:

> As a first step towards removing NR_IRQS, remove the ARM customization
> of HARDIRQ_BITS based on NR_IRQS.
> 
> The generic code in <linux/hardirq.h> already has a default value of
> 10 for HARDIRQ_BITS which is the max used on ARM, so let's just remove
> the NR_IRQS based customization and use the generic default.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/include/asm/hardirq.h |   17 -----------------
>  1 files changed, 0 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index 89ad180..96cb097 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -30,23 +30,6 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
>  
>  #define arch_irq_stat_cpu	smp_irq_stat_cpu
>  
> -#if NR_IRQS > 512
> -#define HARDIRQ_BITS	10
> -#elif NR_IRQS > 256
> -#define HARDIRQ_BITS	9
> -#else
> -#define HARDIRQ_BITS	8
> -#endif
> -
> -/*
> - * The hardirq mask has to be large enough to have space
> - * for potentially all IRQ sources in the system nesting
> - * on a single CPU:
> - */
> -#if (1 << HARDIRQ_BITS) < NR_IRQS
> -# error HARDIRQ_BITS is too low!
> -#endif
> -
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
>  
>  #endif /* __ASM_HARDIRQ_H */
> -- 
> 1.7.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
