From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 1/5] ARM: omap4: Provide do_wfi() for Thumb-2
Date: Wed, 9 Feb 2011 11:19:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102091118390.14920@xanadu.home>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org> <1297263683-10621-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54873 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1BIQTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 11:19:45 -0500
Received: by vws16 with SMTP id 16so198536vws.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:19:44 -0800 (PST)
In-Reply-To: <1297263683-10621-2-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

On Wed, 9 Feb 2011, Dave Martin wrote:

> For CONFIG_THUMB2_KERNEL, the existing definition of do_wfi() will
> insert invalid code into the instruction stream.
> 
> Any assembler which can assemble Thumb-2 is guaranteed to accept
> the "wfi" mnemonic, so for the Thumb-2 case, just use the mnemonic.
> 
> The ARM case is left as-is.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 5b0270b..de441c0 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -17,8 +17,12 @@
>   * wfi used in low power code. Directly opcode is used instead
>   * of instruction to avoid mulit-omap build break

Might be a good idea to fix the typo above while at it.


> +#ifdef CONFIG_THUMB2_KERNEL
> +#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
> +#else
>  #define do_wfi()			\
>  		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
> +#endif
>  
>  #ifdef CONFIG_CACHE_L2X0
>  extern void __iomem *l2cache_base;
> -- 
> 1.7.1
> 
