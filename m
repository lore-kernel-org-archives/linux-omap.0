From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC PATCH 1/1] OMAP2430: Adding missing #defines for TWL4030
Date: Sun, 6 Apr 2008 17:10:13 +0300
Message-ID: <20080406141012.GA12021@kedavra.cpe.vivax.com.br>
References: <1207481707-3326-1-git-send-email-francisco.alecrim@indt.org.br>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58495 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYDFOIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 10:08:19 -0400
Content-Disposition: inline
In-Reply-To: <1207481707-3326-1-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

On Sun, Apr 06, 2008 at 02:35:07PM +0300, Francisco Alecrim wrote:
> Adding missing #defines for TWL4030
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>

Hmmm... even the osk has twl4030... nice.
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  include/asm-arm/arch-omap/board-2430osk.h |   13 ++++++++++---
>  include/asm-arm/arch-omap/board-2430sdp.h |   12 ++++++++++--
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/board-2430osk.h b/include/asm-arm/arch-omap/board-2430osk.h
> index e5b63ae..fcb1a2a 100644
> --- a/include/asm-arm/arch-omap/board-2430osk.h
> +++ b/include/asm-arm/arch-omap/board-2430osk.h
> @@ -39,9 +39,16 @@
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
> -
> +#else
> +#define NR_IRQS				(IH_TWL4030_PWRBASE_END)
> +#endif /* CONFIG_I2C_TWL4030_GPIO */
>  #endif /* __ASM_ARCH_OMAP_2430OSK_H */
> diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
> index 186e9cc..1a5414e 100644
> --- a/include/asm-arm/arch-omap/board-2430sdp.h
> +++ b/include/asm-arm/arch-omap/board-2430sdp.h
> @@ -40,10 +40,18 @@
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
>  
>  /* Function prototypes */
>  extern void sdp2430_flash_init(void);
> -- 
> 1.5.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
