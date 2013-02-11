From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
Date: Mon, 11 Feb 2013 15:33:23 -0800
Message-ID: <87fw12xw70.fsf@linaro.org>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:55663 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760181Ab3BKXd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 18:33:27 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so2958674dal.1
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 15:33:27 -0800 (PST)
In-Reply-To: <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com> (Vaibhav
	Bedia's message of "Mon, 31 Dec 2012 18:37:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Vaibhav Bedia <vaibhav.bedia@ti.com> writes:

> TPTC0 needs to be idled and put to standby under SW control.

Please elaborate about why (e.g. HW support not available, HW support
broken/buggy, etc.) since these blocks are not well documented in the
docs that I have (spruh73f.)

Thanks,

Kevin

> Add the appropriate flags in the TPTC0 hwmod entry.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> v1->v2:
> 	No change
>
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 5e50e68..5c34d4b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
>  	.mpu_irqs	= am33xx_tptc0_irqs,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
