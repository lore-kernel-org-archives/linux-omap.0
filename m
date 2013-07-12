From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device
 tree based booting"
Date: Fri, 12 Jul 2013 00:20:51 -0700
Message-ID: <20130712072051.GA7656@atomide.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <1373539986-27272-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11963 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757128Ab3GLHU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 03:20:57 -0400
Content-Disposition: inline
In-Reply-To: <1373539986-27272-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

* Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
> This reverts commit 82702ea11ddfe0e43382e1fa5b66d807d8114916.
> 
> The above commit stubbed out omap_serial_early_init() in case of
> DT build thinking it was doing the serial port initializations.

Well not really. It was done to cut dependency between device
tree initialized drivers and pdata initialized drivers.
 
> omap_serial_early_init() however does not do the serial port
> inits (its instead done by omap_serial_init_port()) instead
> it sets the HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags
> for the console uart which causes hwmod to avoid doing a reset
> followed by the idling of the console uart.
> 
> This is still needed even in the DT case.

This fix is going the wrong way.

The console is working fine with DT based booting for me,
except for the earlyprintk fix needed.

And there should not be any need to parse cmdline for console
as omap-serial.c sets it up and already knows about it.

Care to state what exactly this attempts to fix and for which
omaps? If this is only needed for am33xx, then why?

Regards,

Tony
 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Mark Jackson <mpfj-list@newflow.co.uk>
> Reported-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 3a674de..58d5b56 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -175,9 +175,6 @@ static char *cmdline_find_option(char *str)
>  
>  static int __init omap_serial_early_init(void)
>  {
> -	if (of_have_populated_dt())
> -		return -ENODEV;
> -
>  	do {
>  		char oh_name[MAX_UART_HWMOD_NAME_LEN];
>  		struct omap_hwmod *oh;
> -- 
> 1.7.9.5
> 
