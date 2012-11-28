From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 13/22] mfd: omap-usb-host: override number of ports
 from platform data
Date: Wed, 28 Nov 2012 08:33:08 -0800
Message-ID: <20121128163307.GA5312@atomide.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
 <1354114150-11941-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17494 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173Ab2K1QdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 11:33:11 -0500
Content-Disposition: inline
In-Reply-To: <1354114150-11941-14-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [121128 06:52]:
> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
> but they have different number of ports i.e. 2 and 3 respectively.
> So we can't rely on REVISION register for number of ports on OMAP5
> and depend on platform data (or device tree) instead.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/usb-host.c        |    1 +
>  arch/arm/plat-omap/include/plat/usb.h |    2 +
>  drivers/mfd/omap-usb-host.c           |   34 ++++++++++++++++++++------------
>  3 files changed, 24 insertions(+), 13 deletions(-)

Note that plat/usb.h is now include/linux/platform_data/usb-omap.h
in linux next so you need to coordinate with that.

For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index 3c43449..eb85528 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -504,6 +504,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>  	ohci_data.es2_compatibility = pdata->es2_compatibility;
>  	usbhs_data.ehci_data = &ehci_data;
>  	usbhs_data.ohci_data = &ohci_data;
> +	usbhs_data.nports = pdata->nports;
>  
>  	if (cpu_is_omap34xx()) {
>  		setup_ehci_io_mux(pdata->port_mode);
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 87ee140..6b618a1 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -27,6 +27,7 @@ enum usbhs_omap_port_mode {
>  };
>  
>  struct usbhs_omap_board_data {
> +	int				nports;
>  	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
>  
>  	/* have to be valid if phy_reset is true and portx is in phy mode */
> @@ -59,6 +60,7 @@ struct ohci_hcd_omap_platform_data {
>  };
>  
>  struct usbhs_omap_platform_data {
> +	int					nports;
>  	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
>  
>  	struct ehci_hcd_omap_platform_data	*ehci_data;
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 87b574b..fda235a 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -495,19 +495,27 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  	 */
>  	pm_runtime_put_sync(dev);
>  
> -	switch (omap->usbhs_rev) {
> -	case OMAP_USBHS_REV1:
> -		omap->nports = 3;
> -		break;
> -	case OMAP_USBHS_REV2:
> -		omap->nports = 2;
> -		break;
> -	default:
> -		omap->nports = OMAP3_HS_USB_PORTS;
> -		dev_dbg(dev,
> -		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
> -		   omap->usbhs_rev, omap->nports);
> -		break;
> +	/*
> +	 * If platform data contains nports then use that
> +	 * else make out number of ports from USBHS revision
> +	 */
> +	if (pdata->nports) {
> +			omap->nports = pdata->nports;
> +	} else {
> +		switch (omap->usbhs_rev) {
> +		case OMAP_USBHS_REV1:
> +			omap->nports = 3;
> +			break;
> +		case OMAP_USBHS_REV2:
> +			omap->nports = 2;
> +			break;
> +		default:
> +			omap->nports = OMAP3_HS_USB_PORTS;
> +			dev_dbg(dev,
> +			"USB HOST Rev:0x%d not recognized, assuming %d ports\n",
> +				omap->usbhs_rev, omap->nports);
> +			break;
> +		}
>  	}
>  
>  	for (i = 0; i < omap->nports; i++)
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
