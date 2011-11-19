From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error when omap_l3_noc built
 as module
Date: Fri, 18 Nov 2011 16:37:37 -0800
Message-ID: <20111119003737.GB31337@atomide.com>
References: <1320839199-4006-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12622 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752712Ab1KSAhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:37:39 -0500
Content-Disposition: inline
In-Reply-To: <1320839199-4006-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [111109 03:12]:
> Fix below compilation failure on mainline kernel 3.2-rc1
> when omap_l3_noc.c is built as module.
> 
> arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';' before 'MODULE_DEVICE_TABLE'
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying into fixes.

Tony

> ---
>  arch/arm/mach-omap2/omap_l3_noc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
> index 6a66aa5..d15225f 100644
> --- a/arch/arm/mach-omap2/omap_l3_noc.c
> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
> @@ -237,7 +237,7 @@ static int __devexit omap4_l3_remove(struct platform_device *pdev)
>  static const struct of_device_id l3_noc_match[] = {
>  	{.compatible = "ti,omap4-l3-noc", },
>  	{},
> -}
> +};
>  MODULE_DEVICE_TABLE(of, l3_noc_match);
>  #else
>  #define l3_noc_match NULL
> -- 
> 1.7.4.1
> 
