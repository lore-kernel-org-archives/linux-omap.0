From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] MMC: OMAP: Remove unnecessary extern sdp_mmc_init
Date: Sat, 26 Apr 2008 02:33:08 +0300
Message-ID: <20080425233307.GB28058@kedavra.cpe.vivax.com.br>
References: <1209150302-6292-1-git-send-email-francisco.alecrim@indt.org.br>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47975 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYDYXbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 19:31:42 -0400
Content-Disposition: inline
In-Reply-To: <1209150302-6292-1-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

On Fri, Apr 25, 2008 at 10:05:02PM +0300, Francisco Alecrim wrote:
> From: Francisco Alecrim <francisco.alecrim@indt.org.br>
> 
> Remove unnecessary extern sdp_mmc_init() at board header. New extern
> hsmmc_init() defined include/asm-arm/arch-omap/hsmmc.h.
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> Acked-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Good catch... let this one out when generalizing mmc init routine.

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  include/asm-arm/arch-omap/board-2430sdp.h     |    1 -
>  include/asm-arm/arch-omap/board-3430sdp.h     |    1 -
>  include/asm-arm/arch-omap/board-omap3beagle.h |    2 --
>  3 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
> index ad682c5..b308e88 100644
> --- a/include/asm-arm/arch-omap/board-2430sdp.h
> +++ b/include/asm-arm/arch-omap/board-2430sdp.h
> @@ -39,6 +39,5 @@
>  /* Function prototypes */
>  extern void sdp2430_flash_init(void);
>  extern void sdp2430_usb_init(void);
> -extern void sdp_mmc_init(void);
>  
>  #endif /* __ASM_ARCH_OMAP_2430SDP_H */
> diff --git a/include/asm-arm/arch-omap/board-3430sdp.h b/include/asm-arm/arch-omap/board-3430sdp.h
> index 34e878a..77f8647 100644
> --- a/include/asm-arm/arch-omap/board-3430sdp.h
> +++ b/include/asm-arm/arch-omap/board-3430sdp.h
> @@ -30,7 +30,6 @@
>  #define __ASM_ARCH_OMAP_3430SDP_H
>  
>  extern void sdp3430_usb_init(void);
> -extern void sdp_mmc_init(void);
>  
>  #define DEBUG_BASE			0x08000000  /* debug board */
>  
> diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/asm-arm/arch-omap/board-omap3beagle.h
> index 782e2e5..14db589 100644
> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
> @@ -29,8 +29,6 @@
>  #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
>  #define __ASM_ARCH_OMAP3_BEAGLE_H
>  
> -extern void sdp_mmc_init(void);
> -
>  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
>  
>  #endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
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
