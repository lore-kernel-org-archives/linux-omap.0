From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/9] omap: clocks: Add checks to see if enable/disable
 ops are supported
Date: Mon, 7 Feb 2011 18:48:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab1BHBs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 20:48:27 -0500
In-Reply-To: <1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Check if enable/disable operations are supported for a given
> clock node before attempting to call them.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 2a2f152..5c08c18 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
>  
>  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>  
> -	clk->ops->disable(clk);
> +	if (clk->ops && clk->ops->enable)
> +		clk->ops->disable(clk);

Shouldn't that read:

    if (clk->ops && clk->ops->disable)

?


- Paul
