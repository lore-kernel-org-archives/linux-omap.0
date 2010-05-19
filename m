From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/3] arm: omap: musb: do not issue SOFTRESET on omap3630
Date: Wed, 19 May 2010 22:56:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE575@dbde02.ent.ti.com>
References: <1274262018-32631-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab0ESR0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 13:26:18 -0400
In-Reply-To: <1274262018-32631-3-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

felipe.balbi@nokia.com wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Errata ID i445 says we SOFTRESET doesn't work properly
> on omap3630, so let's avoid issuing that here.
> 

Not really - all it says is that a ULPI reset is not propagated
to the PHY when you softreset the controller.

The controller softreset itself is quite functional.

Also, this is applicable to 3430 as well and is not 3630 specific.

So I'd NAK this patch.


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index de3e768..97dae0d 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -54,6 +54,10 @@ void __init usb_musb_pm_init(void)
>  	if (!cpu_is_omap34xx())
>  		return;
>  
> +	/* Errata ID i445 fix : Do not use SOFTRESET with OMAP3630 */
> +	if (cpu_is_omap3630())
> +		return;
> +
>  	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
>  	if (WARN_ON(!otg_base))
>  		return;
