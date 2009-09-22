From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/9] ehci: correct EHCI init parameters on OMAP3EVM
Date: Mon, 21 Sep 2009 17:59:56 -0700
Message-ID: <20090922005956.GH27699@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52740 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZIVA7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 20:59:55 -0400
Content-Disposition: inline
In-Reply-To: <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 05:12]:
> Multimedia Daughter card on OMAP3EVM uses port2 as EHCI port.
> Other ports (port1 and port3)are not used.
> 
> GPIO135 has been used as EHCI phy reset pin so the mux config
> is also setup.

Adding this to ehci branch.

Tony
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 595beac..b497979 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -308,7 +308,9 @@ static void __init omap3_evm_init(void)
>  
>  	omap_serial_init();
>  	usb_musb_init();
> -	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
> +	/* Setup EHCI phy reset padconfig */
> +	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
> +	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, -EINVAL, 135);
>  	ads7846_dev_init();
>  }
>  
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
