From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Thu, 12 Apr 2012 11:06:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54454 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab2DLRGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 13:06:55 -0400
In-Reply-To: <1334238098-29859-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 12 Apr 2012, Rajendra Nayak wrote:

> On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
> its associated with a clk.

Sounds like this should be conditional based on the platform, then, 
rather than weakening the warning for all platforms ?

> Hence look for a clkdm in both clk and hwmod and warn only when
> its missing in both. Also fix the pr_warning() to print the correct
> hwmod name.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 2c27fdb..83d56df 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -566,9 +566,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  		return -EINVAL;
>  	}
>  
> -	if (!oh->_clk->clkdm)
> +	if (!oh->_clk->clkdm && !oh->clkdm_name)
>  		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
> -			   oh->main_clk, oh->_clk->name);
> +			   oh->name, oh->_clk->name);
>  
>  	return ret;
>  }
> -- 
> 1.7.1
> 


- Paul
