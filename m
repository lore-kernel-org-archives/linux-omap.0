From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 07/10 V3] omap3: clk: use pm accessor functions for
 cpufreq table
Date: Tue, 8 Dec 2009 09:54:40 +0200
Message-ID: <20091208075440.GC23829@esdhcp037198.research.nokia.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
 <1259122159-1583-3-git-send-email-nm@ti.com>
 <1259122159-1583-4-git-send-email-nm@ti.com>
 <1259122159-1583-5-git-send-email-nm@ti.com>
 <1259122159-1583-6-git-send-email-nm@ti.com>
 <1259122159-1583-7-git-send-email-nm@ti.com>
 <1259122159-1583-8-git-send-email-nm@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48891 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbZLHHyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 02:54:53 -0500
Content-Disposition: inline
In-Reply-To: <1259122159-1583-8-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Little comment bellow,

On Wed, Nov 25, 2009 at 05:09:16AM +0100, ext Nishanth Menon wrote:
> omap2_clk_init_cpufreq_table currently directly accesses the opp
> table, making it unscalable to various OMAPs. Instead use the
> accessor functions to populate the cpufreq table
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   32 +++++++++++++++++++-------------
>  1 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 5150939..d07f1c1 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -1042,30 +1042,36 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
>  #if defined(CONFIG_ARCH_OMAP3)
>  
>  #ifdef CONFIG_CPU_FREQ
> -static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPP+1];
> +
> +static struct cpufreq_frequency_table *freq_table;
>  
>  void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
>  {
> -	struct omap_opp *prcm;
>  	int i = 0;
> +	u8 opp_num;
> +	struct omap_opp *opp = NULL;
> +	unsigned long freq = ULONG_MAX;
>  
> -	if (!mpu_opps)
> +	if (!mpu_opps || opp_get_opp_count(&opp_num, mpu_opps)) {
> +		pr_warning("%s: failed to initialize frequency"
> +				"table\n", __func__);
>  		return;
> -
> -	prcm = mpu_opps + MAX_VDD1_OPP;
> -	for (; prcm->rate; prcm--) {
> -		freq_table[i].index = i;
> -		freq_table[i].frequency = prcm->rate / 1000;
> -		i++;
>  	}
>  
> -	if (i == 0) {
> -		printk(KERN_WARNING "%s: failed to initialize frequency \
> -								table\n",
> -								__func__);
> +	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
> +			(opp_num + 1), GFP_KERNEL);
> +	if (!freq_table) {
> +		pr_warning("%s: failed to allocate frequency"
> +				"table\n", __func__);
>  		return;
>  	}
>  
> +	while (!opp_get_lower_opp(&opp, &freq, mpu_opps)) {
> +		freq_table[i].index = i;
> +		freq_table[i].frequency =  freq / 1000;
                                         ^^

Use one space around (on each side of) most binary and ternary operators,
such as any of these:

	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :

> +		i++;
> +	}
> +
>  	freq_table[i].index = i;
>  	freq_table[i].frequency = CPUFREQ_TABLE_END;
>  
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
