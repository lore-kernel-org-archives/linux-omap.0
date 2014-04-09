From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod_data: Correct clock domains for USB
 modules
Date: Wed, 9 Apr 2014 10:19:19 -0500
Message-ID: <534564F7.2010803@ti.com>
References: <1397056615-4503-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933420AbaDIPTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 11:19:21 -0400
In-Reply-To: <1397056615-4503-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On 04/09/2014 10:16 AM, Roger Quadros wrote:
> OMAP3 doesn't contain "l3_init_clkdm" clock domain. Use the
> proper clock domains for USB Host and USB TLL modules.
> 
> Gets rid of the following warnings during boot
>  omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
>  omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
> 
> Reported-by: Nishant Menon <nm@ti.com>

I guess I have a "h" at the end of my first name :P


> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 9c7e23a..3aa49ed 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1968,7 +1968,7 @@ static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
>  static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
>  	.name		= "usb_host_hs",
>  	.class		= &omap3xxx_usb_host_hs_hwmod_class,
> -	.clkdm_name	= "l3_init_clkdm",
> +	.clkdm_name	= "usbhost_clkdm",
>  	.mpu_irqs	= omap3xxx_usb_host_hs_irqs,
>  	.main_clk	= "usbhost_48m_fck",
>  	.prcm = {
> @@ -2053,7 +2053,7 @@ static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] = {
>  static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
>  	.name		= "usb_tll_hs",
>  	.class		= &omap3xxx_usb_tll_hs_hwmod_class,
> -	.clkdm_name	= "l3_init_clkdm",
> +	.clkdm_name	= "core_l4_clkdm",
>  	.mpu_irqs	= omap3xxx_usb_tll_hs_irqs,
>  	.main_clk	= "usbtll_fck",
>  	.prcm = {
> 


-- 
Regards,
Nishanth Menon
