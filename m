From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] OMAP: McBSP: Remove unused audio macros in mcbsp.h
Date: Fri, 4 Feb 2011 19:27:14 +0530
Message-ID: <20110204135714.GD2070@m-desktop>
References: <1296810909-24737-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45697 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308Ab1BDN6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 08:58:13 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so958234yxd.34
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 05:58:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296810909-24737-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

On Fri, Feb 04, 2011 at 02:45:09PM +0530, Kishon Vijay Abraham I wrote:
> Some macros defined in mcbsp.h related to audio, which are never being used
> is removed.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Charulatha V <charu@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index b87d83c..6ecf105 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -106,13 +106,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
>  #define OMAP_MCBSP_REG_XCCR	0x00
>  #define OMAP_MCBSP_REG_RCCR	0x00
>  
> -#define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
> -#define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
> -
> -#define AUDIO_MCBSP		OMAP_MCBSP1
> -#define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
> -#define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX

Thanks. I have patch in my git repo to cleanup all unwanted dma macros.
I will remove mcbsp dma related declarations in my patch.

Acked-by: G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath

> -
>  #else
>  
>  #define OMAP_MCBSP_REG_DRR2	0x00
> @@ -168,13 +161,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
>  #define OMAP_ST_REG_SFIRCR	0x28
>  #define OMAP_ST_REG_SSELCR	0x2C
>  
> -#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
> -#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
> -
> -#define AUDIO_MCBSP		OMAP_MCBSP2
> -#define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
> -#define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
> -
>  #endif
>  
>  /************************** McBSP SPCR1 bit definitions ***********************/
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
