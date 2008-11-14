From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc4-omap-git] beagle: warning fix
Date: Fri, 14 Nov 2008 13:46:51 -0800
Message-ID: <20081114214651.GP3106@atomide.com>
References: <200811131838.06494.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50715 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYKNVqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 16:46:53 -0500
Content-Disposition: inline
In-Reply-To: <200811131838.06494.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081113 18:38]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Fix a section warning for Beagle.

Pushing today.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -116,7 +116,7 @@ static struct twl4030_usb_data beagle_us
>  	.usb_mode	= T2_USB_MODE_ULPI,
>  };
>  
> -static struct twl4030_hsmmc_info mmc[] __initdata = {
> +static struct twl4030_hsmmc_info mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.wires		= 8,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
