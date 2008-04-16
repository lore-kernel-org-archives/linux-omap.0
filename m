From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] Updated Kconfig and Makefile to add OMAP3 EVM Board
Date: Wed, 16 Apr 2008 14:06:53 -0700
Message-ID: <20080416210652.GI17055@atomide.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8A6C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55337 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYDPVGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 17:06:54 -0400
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8A6C@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org

* Syed Mohammed, Khasim <khasim@ti.com> [080416 05:05]:
> 
> Updated Kconfig and Makefile to add OMAP3 EVM Board

Can you please repost the patches one more time grouped
in following patches:

1. Add support for omap3 evm (Patches 2, 3, 5)
2. Add default config for omap3 evm (Patch 4)
3. Add support for omap3 beagle (Patches 6, 7, 8)
4. Add default config for omap3 beagle (Patch 9)

Thanks,

Tony

> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |    3 +++
>  arch/arm/mach-omap2/Makefile |    1 +
>  2 files changed, 4 insertions(+)
> 
> Index: my_branch/arch/arm/mach-omap2/Makefile
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-16 14:39:51.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-16 14:41:28.000000000 +0530
> @@ -34,6 +34,7 @@
>  					   board-sdp-hsmmc.o \
>  					   board-3430sdp-usb.o \
>  					   board-3430sdp-flash.o
> +obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
>  					   board-apollon-mmc.o	\
>  					   board-apollon-keys.o
> 
> Index: my_branch/arch/arm/mach-omap2/Kconfig
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-16 14:40:02.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-16 14:41:28.000000000 +0530
> @@ -106,3 +106,6 @@
>  	bool "OMAP 3430 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  
> +config MACH_OMAP3EVM
> +	bool "OMAP 3530 EVM board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
