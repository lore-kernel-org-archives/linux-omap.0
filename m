From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
Date: Fri, 19 Feb 2010 17:37:40 -0600
Message-ID: <A24693684029E5489D1D202277BE89445369164A@dlee02.ent.ti.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
 <20100219233019.10559.71005.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36058 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab0BSXhv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:37:51 -0500
In-Reply-To: <20100219233019.10559.71005.stgit@baageli.muru.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, February 19, 2010 5:30 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Felipe Balbi; linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> Subject: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
> 
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> omap3430 TRM says the OTG address space is 4k, not 8k.
> 
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
> index a80441d..ba71f76 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -152,7 +152,7 @@ void __init usb_musb_init(void)
>  		musb_resources[0].start = OMAP243X_HS_BASE;
>  	else
>  		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> -	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
> +	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;

I'm just curious...

Is this valid also if cpu_is_243x() ?

Regards,
Sergio
> 
>  	/*
>  	 * REVISIT: This line can be removed once all the platforms using
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
