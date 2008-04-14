From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM support
Date: Mon, 14 Apr 2008 21:04:48 +0300
Message-ID: <20080414180447.GA4463@kedavra.cpe.vivax.com.br>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57037 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764657AbYDNSDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:03:03 -0400
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Apr 14, 2008 at 05:36:50PM +0530, Syed Mohammed, Khasim wrote:
> 
> Updated Kconfig and Makefile for OMAP3 EVM support
> 
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |   10 +++++++---
>  arch/arm/mach-omap2/Makefile |    1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> Index: my_branch/arch/arm/mach-omap2/Kconfig
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-14 16:07:11.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-14 16:07:41.000000000 +0530
> @@ -98,10 +98,14 @@
>  	bool "OMAP 2430 SDP board"
>  	depends on ARCH_OMAP2 && ARCH_OMAP2430
>  
> +config MACH_OMAP_2430OSK
> +	bool "OMAP 2430 OSK board"
> +	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> +
>  config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  
> -config MACH_OMAP_2430OSK
> -	bool "OMAP 2430 OSK board"
> -	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> +config MACH_OMAP3EVM
> +	bool "OMAP 3530 EVM board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX

Do you really need to move 2430OSK here?
It looks like unnecessary change.

please revert.

> 
> Index: my_branch/arch/arm/mach-omap2/Makefile
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-14 16:07:11.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-14 16:07:41.000000000 +0530
> @@ -34,6 +34,7 @@
>  					   board-sdp-hsmmc.o \
>  					   board-3430sdp-usb.o \
>  					   board-3430sdp-flash.o
> +obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3-evm.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
>  					   board-apollon-mmc.o	\
>  					   board-apollon-keys.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
