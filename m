From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1
	and 2
Date: Thu, 24 Apr 2008 14:46:44 -0700
Message-ID: <20080424214644.GQ16834@atomide.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com> <1209052465-13210-2-git-send-email-edubezval@gmail.com> <1209052465-13210-3-git-send-email-edubezval@gmail.com> <1209052465-13210-4-git-send-email-edubezval@gmail.com> <1209052465-13210-5-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50292 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbYDXVqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:46:44 -0400
Content-Disposition: inline
In-Reply-To: <1209052465-13210-5-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080424 09:03]:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch adds DMA and IRQ definition for McBSP 1 and 2
> devices for omap34xx based systems.

I'll push this patch only for now.

Tony

> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  include/asm-arm/arch-omap/dma.h  |    4 ++++
>  include/asm-arm/arch-omap/irqs.h |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
> index be0431e..270e158 100644
> --- a/include/asm-arm/arch-omap/dma.h
> +++ b/include/asm-arm/arch-omap/dma.h
> @@ -273,6 +273,10 @@
>  #define OMAP24XX_DMA_MS			63	/* S_DMA_62 */
>  #define OMAP242X_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
>  #define OMAP243X_DMA_EXT_DMAREQ6	64	/* S_DMA_63 */
> +#define OMAP34XX_DMA_MCBSP1_TX		31	/* S_DMA_30 */
> +#define OMAP34XX_DMA_MCBSP1_RX		32	/* S_DMA_31 */
> +#define OMAP34XX_DMA_MCBSP2_TX		33	/* S_DMA_32 */
> +#define OMAP34XX_DMA_MCBSP2_RX		34	/* S_DMA_33 */
>  #define OMAP34XX_DMA_EXT_DMAREQ3	64	/* S_DMA_63 */
>  #define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
>  #define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
> diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
> index 15446fd..4e185a8 100644
> --- a/include/asm-arm/arch-omap/irqs.h
> +++ b/include/asm-arm/arch-omap/irqs.h
> @@ -316,7 +316,11 @@
>  #define INT_34XX_USIM_IRQ	35
>  #define INT_34XX_WDT3_IRQ	36
>  #define INT_34XX_SPI4_IRQ	48
> +#define INT_34XX_MCBSP1_IRQ_TX	59
> +#define INT_34XX_MCBSP1_IRQ_RX	60
>  #define INT_34XX_I2C3_IRQ	61
> +#define INT_34XX_MCBSP2_IRQ_TX	62
> +#define INT_34XX_MCBSP2_IRQ_RX	63
>  #define INT_34XX_PBIAS_IRQ	75
>  #define INT_34XX_OHCI_IRQ	76
>  #define INT_34XX_EHCI_IRQ	77
> -- 
> 1.5.5.1.67.gbdb8.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
