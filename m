From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: Get rid of "ti,elm-id not found"
 warning
Date: Mon, 10 Nov 2014 09:00:57 -0800
Message-ID: <20141110170056.GJ31454@atomide.com>
References: <1415363219-25644-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46144 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbaKJRBm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 12:01:42 -0500
Content-Disposition: inline
In-Reply-To: <1415363219-25644-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ezequiel@vanguardiasur.com.ar, linux-omap@vger.kernel.org, pekon@pek-sem.com

* Roger Quadros <rogerq@ti.com> [141107 04:28]:
> OMAP3 and lower SoCs don't have the ELM module so this warning
> is annoying. Get rid of it.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 104bc2c..2334235 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1394,8 +1394,6 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  	if (gpmc_nand_data->elm_of_node == NULL)
>  		gpmc_nand_data->elm_of_node =
>  					of_parse_phandle(child, "elm_id", 0);
> -	if (gpmc_nand_data->elm_of_node == NULL)
> -		pr_warn("%s: ti,elm-id property not found\n", __func__);
>  
>  	/* select ecc-scheme for NAND */
>  	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {

I'll apply this into omap-for-v3.19/fixes-not-urgent as that's where
the various error and warning message fixes are.

Thanks,

Tony
