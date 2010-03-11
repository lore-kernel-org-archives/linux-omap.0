From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Replace vdvi with vdds_dsi regulator supply in
 OMAP3EVM board file
Date: Thu, 11 Mar 2010 14:18:21 -0800
Message-ID: <20100311221821.GM2900@atomide.com>
References: <hvaibhav@ti.com>
 <1268299842-8070-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62956 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab0CKWRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:17:02 -0500
Content-Disposition: inline
In-Reply-To: <1268299842-8070-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Tomi.Valkeinen@nokia.com

* hvaibhav@ti.com <hvaibhav@ti.com> [100311 01:28]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface, it
> is required to define DSI regulator supply, and since we don't need VDVI
> supply so remove it.

This one does not seem to apply, maybe this should be merged into
one of your pending patches?

Tony
 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 017bb2f..ea1014b 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -515,8 +515,8 @@ static struct regulator_init_data omap3_evm_vdac = {
> 
>  /* VPLL2 for digital video outputs */
>  static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &omap3_evm_lcd_device.dev,
> +	.supply		= "vdds_dsi",
> +	.dev		= &omap3_evm_dss_device.dev,
>  };
> 
>  static struct regulator_init_data omap3_evm_vpll2 = {
> --
> 1.6.2.4
> 
