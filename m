From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] Re-arranging OMAP2 and OMAP3 boards
Date: Wed, 16 Apr 2008 13:51:40 -0700
Message-ID: <20080416205140.GG17055@atomide.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8A6A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:58074 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYDPUvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 16:51:42 -0400
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8A6A@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org

* Syed Mohammed, Khasim <khasim@ti.com> [080416 05:04]:
> Re-arranging OMAP2 and OMAP3 boards

Pushing today.

Tony

> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: my_branch/arch/arm/mach-omap2/Kconfig
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-16 14:39:51.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-16 14:40:02.000000000 +0530
> @@ -98,10 +98,11 @@
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
