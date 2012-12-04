From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: kill NEED_MACH_GPIO_H
Date: Mon, 3 Dec 2012 17:41:15 -0800
Message-ID: <20121204014114.GA4636@atomide.com>
References: <1354578625-25760-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38038 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719Ab2LDBlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 20:41:21 -0500
Content-Disposition: inline
In-Reply-To: <1354578625-25760-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [121203 15:52]:
> This does not appear to be used by the OMAP.

Thanks, I already have a smilar patch already queued in
linux next as 873e6980 (ARM: OMAP: Remove NEED_MACH_GPIO_H).

Regards,

Tony
 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/Kconfig                        | 1 -
>  arch/arm/mach-omap1/include/mach/gpio.h | 3 ---
>  arch/arm/mach-omap2/include/mach/gpio.h | 3 ---
>  3 files changed, 7 deletions(-)
>  delete mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
>  delete mode 100644 arch/arm/mach-omap2/include/mach/gpio.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f456cf4..12deaec 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -938,7 +938,6 @@ config ARCH_OMAP
>  	select CLKSRC_MMIO
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_CLK
> -	select NEED_MACH_GPIO_H
>  	help
>  	  Support for TI's OMAP platform (OMAP1/2/3/4).
>  
> diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
> deleted file mode 100644
> index ebf86c0..0000000
> --- a/arch/arm/mach-omap1/include/mach/gpio.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * arch/arm/mach-omap1/include/mach/gpio.h
> - */
> diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
> deleted file mode 100644
> index 5621cc5..0000000
> --- a/arch/arm/mach-omap2/include/mach/gpio.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * arch/arm/mach-omap2/include/mach/gpio.h
> - */
> -- 
> 1.7.11.7
> 
