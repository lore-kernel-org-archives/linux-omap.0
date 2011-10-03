From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/30] ARM: omap: enable building omap2 without
 omap2420/2430
Date: Mon, 3 Oct 2011 10:53:08 -0700
Message-ID: <20111003175308.GR6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27398 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756159Ab1JCRxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 13:53:11 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-6-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111002 07:13]:
> Kconfig allows selecting CONFIG_OMAP2 but no specific SOC, the options
> being omap2420 and omap2430, but that leads to a build error when
> omap3 or omap4 are also enabled and the MULTI_OMAP2 symbol is
> undefined.
> 
> This adds another clause to plat/multi.h, mainly to allow all
> possible randconfig combinations to build cleanly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/include/plat/multi.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
> index 999ffba..fb7f196 100644
> --- a/arch/arm/plat-omap/include/plat/multi.h
> +++ b/arch/arm/plat-omap/include/plat/multi.h
> @@ -82,6 +82,11 @@
>  #  define OMAP_NAME omap2430
>  # endif
>  #endif
> +#ifdef CONFIG_ARCH_OMAP2
> +# ifndef OMAP_NAME
> +#  define OMAP_NAME omap2
> +# endif
> +#endif
>  #ifdef CONFIG_ARCH_OMAP3
>  # ifdef OMAP_NAME
>  #  undef  MULTI_OMAP2
> -- 
> 1.7.5.4
> 
