From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 29/30] ARM: omap: select USB_ARCH_HAS_EHCI only when
 USB is enabled
Date: Mon, 3 Oct 2011 11:27:46 -0700
Message-ID: <20111003182746.GE6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-30-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33384 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab1JCS1s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:27:48 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-30-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111002 07:13]:
> This avoids a warning from Kconfig about missing dependencies.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 3921a95..fdd45dd 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -32,7 +32,7 @@ config ARCH_OMAP3
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V7
> -	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
>  	select ARCH_HAS_OPP
>  	select PM_OPP if PM
> @@ -50,7 +50,7 @@ config ARCH_OMAP4
>  	select CACHE_L2X0
>  	select ARCH_HAS_OPP
>  	select PM_OPP if PM
> -	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  
>  config ARCH_OMAP2_AUTO
>  	bool
> -- 
> 1.7.5.4
> 
