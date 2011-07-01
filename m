From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/8] OMAP2+: clockdomain: Add an api to read idle
 mode
Date: Fri, 1 Jul 2011 06:22:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010622050.27025@utopia.booyaka.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com> <1309191103-8817-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33879 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab1GAMWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 08:22:39 -0400
In-Reply-To: <1309191103-8817-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, toddpoynor@google.com

Hi

On Mon, 27 Jun 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.

This looks good but I'd also suggest crediting Todd in the changelog for 
his review comments...

> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clockdomain.c |   21 +++++++++++++++++++++
>  arch/arm/mach-omap2/clockdomain.h |    3 +++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 6cb6c03..3f2a8e7 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -795,6 +795,27 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
>  	arch_clkdm->clkdm_deny_idle(clkdm);
>  }
>  
> +/**
> + * clkdm_allows_idle - Check if the clkdm hwsup/autoidle is enabled
> + * @clkdm: struct clockdomain *
> + *
> + * Returns true if the clockdomain is in hardware-supervised
> + * idle mode, or 0 otherwise.
> + *
> + */
> +int clkdm_allows_idle(struct clockdomain *clkdm)
> +{
> +	if (!clkdm)
> +		return -EINVAL;
> +
> +	if (!arch_clkdm || !arch_clkdm->clkdm_allows_idle)
> +		return -EINVAL;
> +
> +	pr_debug("clockdomain: reading idle state for %s\n", clkdm->name);
> +
> +	return arch_clkdm->clkdm_allows_idle(clkdm);
> +}
> +
>  
>  /* Clockdomain-to-clock framework interface code */
>  
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> index 5823584..2d3d970 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -138,6 +138,7 @@ struct clockdomain {
>   * @clkdm_wakeup: Force a clockdomain to wakeup
>   * @clkdm_allow_idle: Enable hw supervised idle transitions for clock domain
>   * @clkdm_deny_idle: Disable hw supervised idle transitions for clock domain
> + * @clkdm_allows_idle: Check if hw supervised idle transitions are enabled
>   * @clkdm_clk_enable: Put the clkdm in right state for a clock enable
>   * @clkdm_clk_disable: Put the clkdm in right state for a clock disable
>   */
> @@ -154,6 +155,7 @@ struct clkdm_ops {
>  	int	(*clkdm_wakeup)(struct clockdomain *clkdm);
>  	void	(*clkdm_allow_idle)(struct clockdomain *clkdm);
>  	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
> +	int	(*clkdm_allows_idle)(struct clockdomain *clkdm);
>  	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
>  	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
>  };
> @@ -177,6 +179,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
>  
>  void clkdm_allow_idle(struct clockdomain *clkdm);
>  void clkdm_deny_idle(struct clockdomain *clkdm);
> +int clkdm_allows_idle(struct clockdomain *clkdm);
>  
>  int clkdm_wakeup(struct clockdomain *clkdm);
>  int clkdm_sleep(struct clockdomain *clkdm);
> -- 
> 1.7.0.4
> 


- Paul
