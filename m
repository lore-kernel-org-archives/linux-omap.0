From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430 SDP
 board file
Date: Wed, 30 Dec 2009 14:32:57 +0300
Message-ID: <4B3B3A69.2030301@ru.mvista.com>
References: <1262169902-31258-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:59393 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751782AbZL3LdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 06:33:20 -0500
In-Reply-To: <1262169902-31258-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@suse.de>

Hello.

Maulik Mankad wrote:

> ARM : OMAP4 : Add USB support to 4430 SDP board file
>
> This patch adds support for Mentor USB to 4430 SDP board file.
>
> It also defines the base address for HS USB OTG controller in OMAP4.
>
> Also updates platform specfic structure with base address and IRQ details.
>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>
> Index: felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
> ===================================================================
> --- felipe_musb.orig/arch/arm/mach-omap2/board-4430sdp.c
> +++ felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
>   
[...]
> @@ -73,11 +75,22 @@ static void __init omap_4430sdp_init_irq
>  	omap_gpio_init();
>  }
>  
> +static struct musb_omap_data omap4430sdp_data = {
> +.interface_type	= MUSB_INTERFACE_UTMI,
> +.mode 		= MUSB_PERIPHERAL,
> +.power		= 100,
>   

    You have lost the indentation here.

> Index: felipe_musb/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- felipe_musb.orig/arch/arm/mach-omap2/usb-musb.c
> +++ felipe_musb/arch/arm/mach-omap2/usb-musb.c
> @@ -81,8 +81,13 @@ void __init usb_musb_init(void *arch_dat
>  
>  	if (cpu_is_omap243x())
>  		musb_resources[0].start = OMAP243X_HS_BASE;
> -	else
> +	else if (cpu_is_omap34xx())
>  		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> +	else if (cpu_is_omap44xx()) {
> +		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
> +		musb_resources[1].start =  INT_44XX_HS_USB_MC;
> +		musb_resources[2].start =  INT_44XX_HS_USB_DMA;
>   

   Why extra speces here?

WBR, Sergei


