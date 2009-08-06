From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/9] ehci: correct EHCI init parameters on OMAP3EVM
Date: Thu, 6 Aug 2009 15:43:24 +0300
Message-ID: <20090806124323.GO2358@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58966 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZHFMna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:43:30 -0400
Content-Disposition: inline
In-Reply-To: <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 15:12]:
> Multimedia Daughter card on OMAP3EVM uses port2 as EHCI port.
> Other ports (port1 and port3)are not used.
> 
> GPIO135 has been used as EHCI phy reset pin so the mux config
> is also setup.
> 
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

Is this safe to do if you don't have the daughter card? If so, maybe
add a comment for it.

I guess the nicest thing would be to wait until the daughter card
is probed based on some I2C chip id and only then mux the pins.

Tony
