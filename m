From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] AM35xx: Add AM35xx specific control module registers
Date: Mon, 14 Dec 2009 15:26:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141525060.12561@utopia.booyaka.com>
References: <1257269870-10356-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36884 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbZLNW0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 17:26:52 -0500
In-Reply-To: <1257269870-10356-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Ranjith,

again, I regret the delay -

On Tue, 3 Nov 2009, Ranjith Lohithakshan wrote:

> AM3517/05 has a few additional control module registers defined mainly
> to control the new IP's. This patch adds support for those new registers.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

It looks like the IP_CLK_CTRL register is called IPSS_CLK_CTRL, according 
to the TRM.  Should this be renamed in the patch?  If so, I'll be happy to 
do it before queuing it up, or if you like you can send an updated patch.


- Paul

> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index fdb6300..9ba907a 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -147,6 +147,15 @@
>  #define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
>  #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
>  
> +/* OMAP3517/AM3517 only CONTROL_GENERAL register offsets */
> +#define OMAP3517_CONTROL_MSUSPENDMUX_6  (OMAP2_CONTROL_GENERAL + 0x0038)
> +#define OMAP3517_CONTROL_DEVCONF2       (OMAP2_CONTROL_GENERAL + 0x0310)
> +#define OMAP3517_CONTROL_DEVCONF3       (OMAP2_CONTROL_GENERAL + 0x0314)
> +#define OMAP3517_CONTROL_CBA_PRIORITY   (OMAP2_CONTROL_GENERAL + 0x0320)
> +#define OMAP3517_CONTROL_LVL_INTR_CLEAR (OMAP2_CONTROL_GENERAL + 0x0324)
> +#define OMAP3517_CONTROL_IP_SW_RESET    (OMAP2_CONTROL_GENERAL + 0x0328)
> +#define OMAP3517_CONTROL_IP_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
> +
>  /* 34xx D2D idle-related pins, handled by PM core */
>  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
>  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
> @@ -238,6 +247,14 @@
>  #define		FEAT_NEON		0
>  #define		FEAT_NEON_NONE		1
>  
> +/* OMAP3517_CONTROL_IP_CLK_CTRL bits */
> +#define OMAP3517_USBOTG_VBUSP_CLK_SHIFT    0
> +#define OMAP3517_CPGMAC_VBUSP_CLK_SHIFT    1
> +#define OMAP3517_VPFE_VBUSP_CLK_SHIFT      2
> +#define OMAP3517_HECC_VBUSP_CLK_SHIFT      3
> +#define OMAP3517_USBOTG_FCLK_SHIFT         8
> +#define OMAP3517_CPGMAC_FCLK_SHIFT         9
> +#define OMAP3517_VPFE_FCLK_SHIFT           10
>  
>  #ifndef __ASSEMBLY__
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
