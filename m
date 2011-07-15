From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
 using clockdomain force wakeup
Date: Fri, 15 Jul 2011 02:03:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39619 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964873Ab1GOID1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 04:03:27 -0400
In-Reply-To: <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, p-titiano@ti.com, b-cousson@ti.com

cc'ing Patrick

Hi Rajendra, Santosh,

some comments here:

On Wed, 13 Jul 2011, Santosh Shilimkar wrote:

> While using clockdomain force wakeup method, not waiting for powerdomain
> to be effectively ON may end up locking the clockdomain FSM until a
> next wakeup event occurs.
> 
> One such issue was seen on OMAP4430, where L4_PER was periodically
> getting stuck in in-transition state when transitioning from from OSWR to ON.
> 
> This issue was reported and investigated by Patrick Titiano <p-titiano@ti.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Patrick Titiano <p-titiano@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clockdomain.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index b98a972..583cc3d 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -718,6 +718,8 @@ int clkdm_sleep(struct clockdomain *clkdm)
>   */
>  int clkdm_wakeup(struct clockdomain *clkdm)
>  {
> +	int ret;
> +
>  	if (!clkdm)
>  		return -EINVAL;
>  
> @@ -732,7 +734,10 @@ int clkdm_wakeup(struct clockdomain *clkdm)
>  
>  	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
>  
> -	return arch_clkdm->clkdm_wakeup(clkdm);
> +	ret = arch_clkdm->clkdm_wakeup(clkdm);
> +	ret |= pwrdm_wait_transition(clkdm->pwrdm.ptr);

Seems like this should just call pwrdm_state_switch() or 
pwrdm_clkdm_state_switch()?  (This second function looks superfluous, we 
should probably get rid of it.)

Shouldn't this be added to all of 
clkdm_{wakeup,sleep,allow_idle,deny_idle}() if it isn't there already?

> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 1.7.4.1
> 


- Paul
