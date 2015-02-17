From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
Date: Tue, 17 Feb 2015 11:27:14 +0200
Message-ID: <54E30972.4020107@ti.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Robert,

On 16/02/15 17:49, Robert ABEL wrote:
> WAITMONITORINGTIME is expressed in GPMC_CLK cycles (even for asynchronous accesses).
> However the driver currently converts them to GPMC_FCLK cycles, thus waitmonitoringtime in dt
> had to be predivided by divider as a workaround. This patch fixes the issue by reading the

Can you please point out which DT had used this pre-divided workaround? We will have to
fix those then.

> current GPMCFCLKDIVIDER and adjusting the divisor for WAITMONITORINGTIME accordingly.
> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
> ---
>  arch/arm/mach-omap2/gpmc.c | 78 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c

Can you please rebase your patches on top of v3.19?
gpmc.c has been moved to drivers/memory/omap-gpmc.c

> index bae4a20..4fa5ff1 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -113,6 +113,9 @@
>   */
>  #define	GPMC_NR_IRQ		2
>  
> +#define GPMC_FCLK       0
> +#define GPMC_CLK        1
> +

enum gpmc_clksel {
	GPMC_CLKSEL_FCLK,
	GPMC_CLKSEL_CLK,
};

So all the below occurrences of "unsigned int clk_sel" become "enum gpmc_clksel".

>  struct gpmc_client_irq	{
>  	unsigned		irq;
>  	u32			bitmask;
> @@ -208,16 +211,55 @@ static unsigned long gpmc_get_fclk_period(void)
>  	return rate;
>  }
>  
> -static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
> +/**
> + * gpmc_get_clk_period - get period of selected clk in ps
> + * @cs     : affected chip select
> + * @clk_sel: either one of GPMC_CLK or GPMC_FCLK
> + *
> + * GPMC_CS_CONFIG1 GPMCFCLKDIVIDER for cs has to be setup
> + * prior to calling this function with GPMC_CLK.
> + * 
> + */
> +static unsigned long gpmc_get_clk_period(int cs, unsigned int clk_sel)
> +{
> +
> +	unsigned long tick_ps = gpmc_get_fclk_period();
> +	u32 l;
> +	int div;
> +
> +	switch (clk_sel) {
> +	case GPMC_CLK:
> +		/* get current clk divider */
> +		l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +		div = (l & 0x03) + 1;
> +		/* get GPMC_CLK period */
> +		tick_ps *= div;
> +		break;
> +	case GPMC_FCLK:
> +		/* FALL-THROUGH */
> +	default:
> +		break;
> +	}
> +
> +	return tick_ps;
> +
> +}
> +
> +static unsigned int gpmc_ns_to_clk_ticks(unsigned int time_ns, int cs, unsigned int clk_sel)
>  {
>  	unsigned long tick_ps;
>  
>  	/* Calculate in picosecs to yield more exact results */
> -	tick_ps = gpmc_get_fclk_period();
> +	tick_ps = gpmc_get_clk_period(cs, clk_sel);
>  
>  	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
>  }
>  
> +static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
> +{
> +	return gpmc_ns_to_clk_ticks(time_ns, 0, GPMC_FCLK);

This function should have been unchanged since we're dealing with GPMC_FCLK
and it was using gpmc_get_fclk_period().

> +}
> +
>  static unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
>  {
>  	unsigned long tick_ps;
> @@ -280,10 +322,10 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
>  
>  #ifdef DEBUG
>  static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> -			       int time, const char *name)
> +			       int time, unsigned int clk_sel, const char *name)
>  #else
>  static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> -			       int time)
> +			       int time, unsigned int clk_sel)
>  #endif
>  {
>  	u32 l;
> @@ -292,7 +334,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  	if (time == 0)
>  		ticks = 0;
>  	else
> -		ticks = gpmc_ns_to_ticks(time);
> +		ticks = gpmc_ns_to_clk_ticks(time, cs, clk_sel);
>  	nr_bits = end_bit - st_bit + 1;
>  	if (ticks >= 1 << nr_bits) {
>  #ifdef DEBUG
> @@ -307,7 +349,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  #ifdef DEBUG
>  	printk(KERN_INFO
>  		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
> -	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
> +	       cs, name, ticks, gpmc_get_clk_period(cs, clk_sel) * ticks / 1000,
>  			(l >> st_bit) & mask, time);
>  #endif
>  	l &= ~(mask << st_bit);
> @@ -320,12 +362,19 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  #ifdef DEBUG
>  #define GPMC_SET_ONE(reg, st, end, field) \
>  	if (set_gpmc_timing_reg(cs, (reg), (st), (end),		\
> -			t->field, #field) < 0)			\
> +			t->field, GPMC_FCLK, #field) < 0)			\
>  		return -1
> +#define GPMC_SET_ONE_C(reg, st, end, field, clk_sel) \

Let's call this GPMC_SET_ONE_CLKSEL()

> +	if (set_gpmc_timing_reg(cs, (reg), (st), (end),     \
> +            t->field, clk_sel, #field) < 0)             \
> +        return -1
>  #else
>  #define GPMC_SET_ONE(reg, st, end, field) \
> -	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field) < 0) \
> +	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field, GPMC_FCLK) < 0) \
>  		return -1
> +#define GPMC_SET_ONE_C(reg, st, end, field, clk_sel) \
> +	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field, clk_sel) < 0)   \
> +        return -1
>  #endif
>  
>  int gpmc_calc_divider(unsigned int sync_clk)
> @@ -374,22 +423,23 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
>  	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
>  
> -	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
> -	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> -
>  	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
>  	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
>  
>  	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +	l &= ~0x03;
> +	l |= (div - 1);
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> +
> +	GPMC_SET_ONE_C(GPMC_CS_CONFIG1, 18, 19, wait_monitoring, GPMC_CLK);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> +
>  #ifdef DEBUG
>  	printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
>  	       cs, (div * gpmc_get_fclk_period()) / 1000, div);
>  #endif
> -	l &= ~0x03;
> -	l |= (div - 1);
> -	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
>  
> 

You will also need to correct gpmc_cs_show_timings() to show the
correct timing for "wait-monitoring-ns" based on GPMC_CLK.

cheers,
-roger
