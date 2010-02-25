From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 1/3] ARM: OMAP3630: PRCM: Add UART4 control bits
Date: Thu, 25 Feb 2010 14:03:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002251403010.2701@utopia.booyaka.com>
References: <1267108876-18028-1-git-send-email-saaguirre@ti.com> <1267108876-18028-2-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54957 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933668Ab0BYVD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 16:03:29 -0500
In-Reply-To: <1267108876-18028-2-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 25 Feb 2010, Sergio Aguirre wrote:

> This bits are exclusive of omap 36xx family of chips.

Verified against the Rev C TRM.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/prcm-common.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 90f603d..c4e7bcb 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -390,6 +390,8 @@
>  #define OMAP3430_EN_MPU_SHIFT				1
>  
>  /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
> +#define OMAP3630_EN_UART4				(1 << 18)
> +#define OMAP3630_EN_UART4_SHIFT				18
>  #define OMAP3430_EN_GPIO6				(1 << 17)
>  #define OMAP3430_EN_GPIO6_SHIFT				17
>  #define OMAP3430_EN_GPIO5				(1 << 16)
> @@ -430,6 +432,8 @@
>  #define OMAP3430_EN_MCBSP2_SHIFT			0
>  
>  /* CM_IDLEST_PER, PM_WKST_PER shared bits */
> +#define OMAP3630_ST_UART4_SHIFT				18
> +#define OMAP3630_ST_UART4_MASK				(1 << 18)
>  #define OMAP3430_ST_GPIO6_SHIFT				17
>  #define OMAP3430_ST_GPIO6_MASK				(1 << 17)
>  #define OMAP3430_ST_GPIO5_SHIFT				16
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
