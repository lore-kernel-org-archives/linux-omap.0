From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
Date: Fri, 10 Jun 2011 21:38:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D426804@dbde02.ent.ti.com>
References: <1307718873-27652-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495Ab1FJQIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 12:08:47 -0400
In-Reply-To: <1307718873-27652-1-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Friday, June 10, 2011 8:45 PM
> To: linux-omap
> Cc: Tony; linux-arm; Balbi, Felipe; Menon, Nishanth
> Subject: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
> 
> Attempting to disable USB generates the following warning at 
> the moment:
> warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI 
> which has unmet direct dependencies (USB_SUPPORT)
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on 3.0-rc2
>  arch/arm/mach-omap2/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index ef7e12f..d5cf1a8 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -33,7 +33,7 @@ config ARCH_OMAP3
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V7
> -	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
>  	select ARCH_HAS_OPP
>  	select PM_OPP if PM
> @@ -50,7 +50,7 @@ config ARCH_OMAP4
>  	select ARM_ERRATA_720789
>  	select ARCH_HAS_OPP
>  	select PM_OPP if PM
> -	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  
>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2


Here is earlier discussion on the same subject:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42064.html

Exactly same patch was proposed.

~sanjeev

> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 