From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx headers
Date: Thu, 20 May 2010 10:12:33 -0700
Message-ID: <87bpcafqf2.fsf@deeprootsystems.com>
References: <1274307029-22032-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34510 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab0ETRMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 13:12:41 -0400
Received: by pvg3 with SMTP id 3so10339pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 10:12:40 -0700 (PDT)
In-Reply-To: <1274307029-22032-1-git-send-email-h-kanigeri2@ti.com> (Hari Kanigeri's message of "Wed\, 19 May 2010 17\:10\:29 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux Omap <linux-omap@vger.kernel.org>

Hari Kanigeri <h-kanigeri2@ti.com> writes:

> The prm-regbits-xxxx.h header files are not dependent on prm.h
> header file.
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +

This file is not in mailine, or linux-omap master.  Please
state any dependencies in this part of the changelog.

Kevin

>  arch/arm/mach-omap2/prm-regbits-24xx.h     |    1 -
>  arch/arm/mach-omap2/prm-regbits-34xx.h     |    1 -
>  arch/arm/mach-omap2/prm-regbits-44xx.h     |    1 -
>  4 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 667633c..88cc9ca 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -26,6 +26,7 @@
>  #include "omap_hwmod_common_data.h"
>  
>  #include "cm.h"
> +#include "prm.h"
>  #include "prm-regbits-44xx.h"
>  
>  /* Base offset for all OMAP4 interrupts external to MPUSS */
> diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
> index 4002051..fd763b5 100644
> --- a/arch/arm/mach-omap2/prm-regbits-24xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
> @@ -14,7 +14,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include "prm.h"
>  
>  /* Bits shared between registers */
>  
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index 8f21bae..ef7fd5e 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -14,7 +14,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include "prm.h"
>  
>  /* Shared register bits */
>  
> diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
> index 597be4a..ef7af7e 100644
> --- a/arch/arm/mach-omap2/prm-regbits-44xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
> @@ -22,7 +22,6 @@
>  #ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
>  #define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
>  
> -#include "prm.h"
>  
>  
>  /*
> -- 
> 1.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
