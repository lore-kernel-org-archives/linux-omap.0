From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: EHCI: Allow EHCI to work as a module again
Date: Mon, 6 Jul 2009 10:13:16 +0300
Message-ID: <20090706071316.GI8461@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305C10FA4@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64085 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbZGFHOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 03:14:04 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305C10FA4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>

On Mon, Jul 06, 2009 at 09:05:09AM +0200, ext Gadiyar, Anand wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> OMAP3: EHCI: Allow EHCI to work as a module again
> 
> commit fc3c45ca seems to have broken EHCI as a module. Fix this.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

hmm... that was a bad mistake :-s

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index 0fe26f2..56fc7f4 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -27,7 +27,7 @@
>  #include <mach/irqs.h>
>  #include <mach/usb.h>
>  
> -#if defined(CONFIG_USB_EHCI_HCD) || #define(CONFIG_USB_EHCI_HCD_MODULE)
> +#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
>  
>  static struct resource ehci_resources[] = {
>  	{
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
