From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 07/15] ARM: OMAP2+: hwmod: Update the hwmod data for TPTCs
 in AM33XX
Date: Mon, 5 Nov 2012 12:49:49 +0530
Message-ID: <50976895.9040409@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-8-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2KEHT7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 02:19:59 -0500
In-Reply-To: <1351859566-24818-8-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com



On 11/2/2012 6:02 PM, Vaibhav Bedia wrote:
> Update the TPTC hwmod entry to reflect the fact that
> the idle and standby transitions are s/w controlled.
> 

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index ec3fbb2..7772c29 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1827,6 +1827,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
>  	.mpu_irqs	= am33xx_tptc0_irqs,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> 
