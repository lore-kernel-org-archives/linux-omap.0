From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
 to set the RTC
Date: Tue, 31 May 2011 03:29:03 -0700
Message-ID: <20110531102903.GU11352@atomide.com>
References: <4D9AEB76.2060509@ahsoftware.de>
 <1302010808-3065-1-git-send-email-holler@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20332 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753084Ab1EaK3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 06:29:06 -0400
Content-Disposition: inline
In-Reply-To: <1302010808-3065-1-git-send-email-holler@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Alexander Holler <holler@ahsoftware.de> [110405 06:38]:
> Without msecure beeing high it isn't possible to set (or start)
> the RTC.
> 
> Tested with a BeagleBoard C4.

Adding this into fixes.

Tony
 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 46d814a..ebe3a7e 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -628,6 +628,9 @@ static void __init omap3_beagle_init(void)
>  	usb_ehci_init(&ehci_pdata);
>  	omap3beagle_flash_init();
>  
> +	/* Ensure msecure is mux'd to be able to set the RTC. */
> +	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
> +
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> -- 
> 1.7.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
