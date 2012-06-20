From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] OMAP: beagle: Set USB Host Port 1 to
 OMAP_USBHS_PORT_MODE_UNUSED
Date: Wed, 20 Jun 2012 07:31:51 -0700
Message-ID: <20120620143149.GR12766@atomide.com>
References: <1340115769-16902-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34614 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2FTObx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 10:31:53 -0400
Content-Disposition: inline
In-Reply-To: <1340115769-16902-1-git-send-email-brian.austin@cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com

* Brian Austin <brian.austin@cirrus.com> [120619 07:29]:
> The beagleboard USB Host Port that is used is Port 2. The platform driver sets MODE_PHY for port 1 causing pin muxing to override the pins on the expansion
> connector P17 when using board_mux[]. Since USBHS Port 1 is not connected remove the case for muxing the USB Port1 pins by default.
> 
> Patch is based off of 3.5-rc2 from ASoC for-next branch
> 
> Tested with BeagleBoard xM revC and checked the userguides for Beagle xM and revC to be sure USB Port2 is what is used.

Thanks applying into fixes.

Tony

> 
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 79c6909..75eb88a 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -435,7 +435,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
>  
>  static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
>  
> -	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
>  	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
>  	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
>  
> -- 
> 1.7.10.4
> 
> 
