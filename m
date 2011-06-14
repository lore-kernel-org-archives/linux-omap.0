From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
Date: Tue, 14 Jun 2011 04:50:56 -0700
Message-ID: <20110614115056.GT3352@atomide.com>
References: <1307491366-28793-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61739 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755915Ab1FNLu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:50:58 -0400
Content-Disposition: inline
In-Reply-To: <1307491366-28793-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110607 16:58]:
> OMAP1 needs this also since GPIO driver (common for all OMAPs) is
> being converted to use generic IRQ chip.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Maybe queue this together with your GPIO patches?

Acked-by: Tony Lindgren <tony@atomide.com>


> ---
>  arch/arm/plat-omap/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 49a4c75..9a4a6bf 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -13,6 +13,7 @@ config ARCH_OMAP1
>  	bool "TI OMAP1"
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_MMIO
> +	select GENERIC_IRQ_CHIP
>  	help
>  	  "Systems based on omap7xx, omap15xx or omap16xx"
>  
> -- 
> 1.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
