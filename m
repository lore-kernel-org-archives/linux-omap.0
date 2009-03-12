From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP:clock: missing list_del for
 clk_notifier_unregister
Date: Thu, 12 Mar 2009 01:30:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903120128570.26959@utopia.booyaka.com>
References: <1236790153-9324-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZCLHau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 03:30:50 -0400
In-Reply-To: <1236790153-9324-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ramesh Gupta <grgupta@ti.com>, Palande Ameya <ameya.palande@nokia.com>

Hi,

On Wed, 11 Mar 2009, Nishanth Menon wrote:

> clk_notifier_unregister should clean the list before
> freeing clock notifier, else clk_notifier_list is
> filled with dangling pointers
> 
> Issue seen while repetative loading/unloading of bridgedriver
> 
> Ref: http://marc.info/?t=123678326300002&r=1&w=2
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/clock.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index c8d9e96..523d1b0 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -725,8 +725,11 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
>  		 * XXX ugh, layering violation.  there should be some
>  		 * support in the notifier code for this.
>  		 */
> -		if (!cn->notifier_head.head)
> +		if (!cn->notifier_head.head) {
> +			/* Free up my clock node too */
> +			list_del(&cn->node);
>  			kfree(cn);
> +		}
>  
>  	} else {
>  		r = -ENOENT;
> -- 
> 1.5.4.3
> 

Thanks, this looks good.

Just to clarify, this is currently against the PM branch.  There's a new 
version of the clock notifier patch coming out soon against l-o; will roll 
this fix in.


- Paul
