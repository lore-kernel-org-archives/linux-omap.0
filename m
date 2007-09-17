From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Use the correct flags type where local_irq_save
Date: Mon, 17 Sep 2007 11:20:26 -0700
Message-ID: <20070917182026.GD21226@atomide.com>
References: <20070917074103.GA3488@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070917074103.GA3488@party>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kmpark@infradead.org> [070917 00:42]:
> [PATCH] Use the correct flags where the local_irq_save
> 
> We should use the 'unsigned long flags'.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index acdcbe1..8e30202 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -575,10 +575,11 @@ static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
>  
>  static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
>  {
> -	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
> +	u32 cur_rate, low, mult, div, valid_rate, done_rate;
>  	u32 bypass = 0;
>  	struct prcm_config tmpset;
>  	const struct dpll_data *dd;
> +	unsigned long flags;
>  	int ret = -EINVAL;
>  
>  	local_irq_save(flags);
> @@ -947,9 +948,10 @@ static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
>  /* Sets basic clocks based on the specified rate */
>  static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
>  {
> -	u32 flags, cur_rate, done_rate, bypass = 0, tmp;
> +	u32 cur_rate, done_rate, bypass = 0, tmp;
>  	struct prcm_config *prcm;
>  	unsigned long found_speed = 0;
> +	unsigned long flags;
>  
>  	if (clk != &virt_prcm_set)
>  		return -EINVAL;
> diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
> index 089b559..008a0e4 100644
> --- a/arch/arm/mach-omap2/memory.c
> +++ b/arch/arm/mach-omap2/memory.c
> @@ -75,7 +75,8 @@ u32 omap2_dll_force_needed(void)
>  u32 omap2_reprogram_sdrc(u32 level, u32 force)
>  {
>  	u32 dll_ctrl, m_type;
> -	u32 prev = curr_perf_level, flags;
> +	u32 prev = curr_perf_level;
> +	unsigned long flags;
>  
>  	if ((curr_perf_level == level) && !force)
>  		return prev;

Pushing today, I refreshed it for Paul's patch for clock24xx.c

Hey great, no more wrapping in the patch!

Tony
