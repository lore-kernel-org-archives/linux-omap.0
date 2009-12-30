From: Paul Walmsley <paul@pwsan.com>
Subject: Re: clk2xxx.c doesn't compile if CPUFREQ is enabled
Date: Wed, 30 Dec 2009 02:09:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912300208260.24862@utopia.booyaka.com>
References: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45468 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbZL3JJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 04:09:59 -0500
In-Reply-To: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Felipe,

On Sat, 26 Dec 2009, Felipe Balbi wrote:

> if we enable CPUFREQ we can't build omap2 for two reasons,
> one of them is fixed by the patch below but the other one
> it seems like it'll need more invasive changes to the code
> so I'll leave it for you to decide how to do it.
> 
> It's basically failing because the __musb_be_array() check
> in ARRAY_SIZE() is failing and printing the following message:
> 
> arch/arm/mach-omap2/clock2xxx.c:453: error: negative width in bit-field '<anonymous>'
> 
> NYET-Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Care to send a version with a Signed-off-by?  I will base the remaining 
fixes on top of this.  Thanks for reporting this and sending the initial 
patch.


- Paul

> ---
>  arch/arm/mach-omap2/clock2xxx.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
> index d0e3fb7..4e2bdfe 100644
> --- a/arch/arm/mach-omap2/clock2xxx.c
> +++ b/arch/arm/mach-omap2/clock2xxx.c
> @@ -455,12 +455,15 @@ static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
>  void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
>  {
>  	struct prcm_config *prcm;
> +	long rate;
>  	int i = 0;
>  
> +	rate = clk_get_rate(sclk);
> +
>  	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
>  		if (!(prcm->flags & cpu_mask))
>  			continue;
> -		if (prcm->xtal_speed != sys_ck.rate)
> +		if (prcm->xtal_speed != rate)
>  			continue;
>  
>  		/* don't put bypass rates in table */
> -- 
> 1.6.6.rc0
> 

