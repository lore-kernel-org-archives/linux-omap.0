From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Select right CPU_Vn automatically
Date: Wed, 5 Nov 2008 19:23:11 -0800
Message-ID: <20081106032311.GO21736@atomide.com>
References: <1225464325-32208-1-git-send-email-lauri.leukkunen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59635 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYKFDXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 22:23:13 -0500
Content-Disposition: inline
In-Reply-To: <1225464325-32208-1-git-send-email-lauri.leukkunen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Lauri Leukkunen <lauri.leukkunen@nokia.com> [081031 07:45]:
> Prevents idiots like me from creating an uncompilable .config

Pushing.

Tony

> Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index c730fa6..e57430b 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -10,11 +10,13 @@ config ARCH_OMAP2420
>  	depends on ARCH_OMAP24XX
>  	select OMAP_DM_TIMER
>  	select ARCH_OMAP_OTG
> +	select CPU_V6
>  
>  config ARCH_OMAP2430
>  	bool "OMAP2430 support"
>  	depends on ARCH_OMAP24XX
>  	select ARCH_OMAP_OTG
> +	select CPU_V6
>  
>  config ARCH_OMAP34XX
>  	bool "OMAP34xx Based System"
> @@ -24,6 +26,7 @@ config ARCH_OMAP3430
>  	bool "OMAP3430 support"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select ARCH_OMAP_OTG
> +	select CPU_V7
>  
>  comment "OMAP Board Type"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
