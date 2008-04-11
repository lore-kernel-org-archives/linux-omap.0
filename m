From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: USB: Fix potential resource overlap due to
	incorrect end address
Date: Fri, 11 Apr 2008 12:32:16 -0700
Message-ID: <20080411193215.GK7717@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08805C30691@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56517 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbYDKTcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:32:17 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805C30691@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [080408 05:08]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> The end address for the USB memory resources were incorrectly defined as
> (<start> + <size>) instead of (<start> + <size - 1>) resulting in a
> potential overlap with the start address of other resources.

Pushing today.

Tony


> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Acked-by: Nishant Kamat <nskamat@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp-usb.c |    2 +-
>  arch/arm/mach-omap2/board-3430sdp-usb.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp-usb.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp-usb.c	2008-04-08 17:28:40.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp-usb.c	2008-04-08 17:29:54.868278300 +0530
> @@ -23,7 +23,7 @@
>  static struct resource musb_resources[] = {
>  	[0] = {
>  		.start	= OMAP243X_HS_BASE,
> -		.end	= OMAP243X_HS_BASE + SZ_8K,
> +		.end	= OMAP243X_HS_BASE + SZ_8K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {	/* general IRQ */
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-usb.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp-usb.c	2008-04-08 17:28:40.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-usb.c	2008-04-08 17:30:21.938407487 +0530
> @@ -29,7 +29,7 @@
>  static struct resource musb_resources[] = {
>  	[0] = {
>  		.start	= OMAP34XX_HSUSB_OTG_BASE,
> -		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K,
> +		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {	/* general IRQ */
> @@ -100,7 +100,7 @@ static struct platform_device musb_devic
>  static struct resource ehci_resources[] = {
>  	[0] = {
>  		.start   = OMAP34XX_HSUSB_HOST_BASE + 0x800,
> -		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K,
> +		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K - 1,
>  		.flags   = IORESOURCE_MEM,
>  	},
>  	[1] = {         /* general IRQ */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
