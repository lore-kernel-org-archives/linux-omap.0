From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 10 Oct 2008 15:44:07 +0300
Message-ID: <20081010124407.GC7503@gandalf.research.nokia.com>
References: <1223642237-9345-1-git-send-email-premi@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20302 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbYJJMoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 08:44:18 -0400
Content-Disposition: inline
In-Reply-To: <1223642237-9345-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Fri, Oct 10, 2008 at 06:07:17PM +0530, ext Sanjeev Premi wrote:
> Fix these compiler warnings:
> smartreflex.c:126: warning: initialization makes integer from pointer without a cast
> smartreflex.c:134: warning: initialization makes integer from pointer without a cast
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index e54c0fb..8460633 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -123,7 +123,7 @@ static struct omap_sr sr1 = {
>  	.is_sr_reset		= 1,
>  	.is_autocomp_active	= 0,
>  	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> +	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),

please don't. Most likely srbase_addr should move to void __iomem *

Paul, any comments ??

>  };
>  
>  static struct omap_sr sr2 = {
> @@ -131,7 +131,7 @@ static struct omap_sr sr2 = {
>  	.is_sr_reset		= 1,
>  	.is_autocomp_active	= 0,
>  	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
> +	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
>  };
>  
>  static struct sr_custom_clk sr1_custom_clk = {
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
