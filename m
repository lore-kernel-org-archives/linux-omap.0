From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP2430: Add missing defines for TWL4030
Date: Wed, 9 Apr 2008 21:18:43 +0000
Message-ID: <20080409211842.GP31071@atomide.com>
References: <47FB90CD.90104@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59637 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbYDIVSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:18:44 -0400
Content-Disposition: inline
In-Reply-To: <47FB90CD.90104@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [080408 15:37]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This patch adds missing defines for TWL4030.

I've pushed this. We should fix the defines, as it now looks like this
will again break efforts of building multiple omaps into the same
kernel. Basically the same things need to be defined in just one
common place.

Tony


> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  include/asm-arm/arch-omap/board-2430osk.h |   15 +++++++++++++--
>  include/asm-arm/arch-omap/board-2430sdp.h |   15 +++++++++++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/board-2430osk.h b/include/asm-arm/arch-omap/board-2430osk.h
> index e5b63ae..14c996e 100644
> --- a/include/asm-arm/arch-omap/board-2430osk.h
> +++ b/include/asm-arm/arch-omap/board-2430osk.h
> @@ -33,15 +33,26 @@
>  #define OMAP24XX_ETHR_START		0x08000300
>  #define OMAP24XX_ETHR_GPIO_IRQ		149
>  
> +#ifdef CONFIG_TWL4030_CORE
> +
>  #define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
>  
>  /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
>  #define IH_TWL4030_BASE			IH_BOARD_BASE
>  #define IH_TWL4030_END			(IH_TWL4030_BASE+8)
>  
> +#define IH_TWL4030_PWRBASE		(IH_TWL4030_END)
> +#define IH_TWL4030_PWRBASE_END		(IH_TWL4030_PWRBASE+8)
> +
> +#ifdef CONFIG_TWL4030_GPIO
> +
>  /* TWL4030 GPIO Interrupts */
> -#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
> -#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
> +#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_PWRBASE_END)
> +#define IH_TWL4030_GPIO_END		(IH_TWL4030_GPIO_BASE+18)
>  #define NR_IRQS				(IH_TWL4030_GPIO_END)
> +#else
> +#define NR_IRQS				(IH_TWL4030_PWRBASE_END)
> +#endif /* CONFIG_I2C_TWL4030_GPIO */
> +#endif /* End of support for TWL4030 */
>  
>  #endif /* __ASM_ARCH_OMAP_2430OSK_H */
> diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
> index 186e9cc..217f197 100644
> --- a/include/asm-arm/arch-omap/board-2430sdp.h
> +++ b/include/asm-arm/arch-omap/board-2430sdp.h
> @@ -34,16 +34,27 @@
>  #define OMAP24XX_ETHR_GPIO_IRQ		149
>  #define SDP2430_CS0_BASE		0x04000000
>  
> +#ifdef CONFIG_TWL4030_CORE
> +
>  #define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
>  
>  /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
>  #define IH_TWL4030_BASE			IH_BOARD_BASE
>  #define IH_TWL4030_END			(IH_TWL4030_BASE+8)
>  
> +#define IH_TWL4030_PWRBASE		(IH_TWL4030_END)
> +#define IH_TWL4030_PWRBASE_END		(IH_TWL4030_PWRBASE+8)
> +
> +#ifdef CONFIG_TWL4030_GPIO
> +
>  /* TWL4030 GPIO Interrupts */
> -#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
> -#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
> +#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_PWRBASE_END)
> +#define IH_TWL4030_GPIO_END		(IH_TWL4030_GPIO_BASE+18)
>  #define NR_IRQS				(IH_TWL4030_GPIO_END)
> +#else
> +#define NR_IRQS				(IH_TWL4030_PWRBASE_END)
> +#endif /* CONFIG_I2C_TWL4030_GPIO */
> +#endif /* End of support for TWL4030 */
>  
>  /* Function prototypes */
>  extern void sdp2430_flash_init(void);
> -- 1.5.3.GIT
> 
