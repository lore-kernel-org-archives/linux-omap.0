From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Tue, 13 Oct 2009 10:18:14 -0700
Message-ID: <20091013171814.GT12700@atomide.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62936 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760343AbZJMRS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 13:18:59 -0400
Content-Disposition: inline
In-Reply-To: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org

* Vikram Pandita <vikram.pandita@ti.com> [091012 14:31]:
> make default cpu_is_omap3630() return zero
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index da9e8f8..940946e 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define cpu_is_omap2423()		0
>  #define cpu_is_omap2430()		0
>  #define cpu_is_omap3430()		0
> +#define cpu_is_omap3630()		0
>  
>  /*
>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> @@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  						(omap3_has_sgx()) &	\
>  						(!omap3_has_iva()))
>  # define cpu_is_omap3530		(cpu_is_omap3430())
> +# undef cpu_is_omap3630()
>  # define cpu_is_omap3630()		is_omap363x()
>  #endif

This undef should be just undef cpu_is_omap3630 instead of
cpu_is_omap3630().

Tony

