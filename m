From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Fix SDRC register addresses
Date: Fri, 7 Aug 2009 05:48:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908070548000.7977@utopia.booyaka.com>
References: <1249477918-7200-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293AbZHGLss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 07:48:48 -0400
In-Reply-To: <1249477918-7200-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

On Wed, 5 Aug 2009, Roger Quadros wrote:

> SDRC addresses are offset from OMAP3430_SDRC_RT_BASE and not
> OMAP3430_SMS_RT_BASE.
> This fixes OFF mode on EMU/HS devices.
> 
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>

> ---
>  arch/arm/mach-omap2/sleep34xx.S |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 807b23e..53b6da9 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -49,13 +49,13 @@
>  #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
>  						+ SCRATCHPAD_MEM_OFFS)
>  #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> -#define SDRC_SYSCONFIG_P	(OMAP3430_SMS_RT_BASE + SDRC_SYSCONFIG)
> -#define SDRC_MR_0_P		(OMAP3430_SMS_RT_BASE + SDRC_MR_0)
> -#define SDRC_EMR2_0_P		(OMAP3430_SMS_RT_BASE + SDRC_EMR2_0)
> -#define SDRC_MANUAL_0_P		(OMAP3430_SMS_RT_BASE + SDRC_MANUAL_0)
> -#define SDRC_MR_1_P		(OMAP3430_SMS_RT_BASE + SDRC_MR_1)
> -#define SDRC_EMR2_1_P		(OMAP3430_SMS_RT_BASE + SDRC_EMR2_1)
> -#define SDRC_MANUAL_1_P		(OMAP3430_SMS_RT_BASE + SDRC_MANUAL_1)
> +#define SDRC_SYSCONFIG_P	(OMAP3430_SDRC_RT_BASE + SDRC_SYSCONFIG)
> +#define SDRC_MR_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_MR_0)
> +#define SDRC_EMR2_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_EMR2_0)
> +#define SDRC_MANUAL_0_P		(OMAP3430_SDRC_RT_BASE + SDRC_MANUAL_0)
> +#define SDRC_MR_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_MR_1)
> +#define SDRC_EMR2_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_EMR2_1)
> +#define SDRC_MANUAL_1_P		(OMAP3430_SDRC_RT_BASE + SDRC_MANUAL_1)
>  #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
> -- 
> 1.6.0.4
> 


- Paul
