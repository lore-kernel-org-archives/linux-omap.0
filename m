From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: Show bootloader GPMC timings to allow
 configuring the .dts file
Date: Thu, 30 Oct 2014 16:26:51 +0200
Message-ID: <54524AAB.6010306@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46164 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbaJ3O1S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2014 10:27:18 -0400
In-Reply-To: <1414628948-30702-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Sorry if you get this twice. I wasn't sure if my last reply went through.

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> As we still have some devices with GPMC timings missing from the
> .dts files, let's make it a bit easier to use the bootloader
> values and print them out.
> 
> Note that we now need to move the parsing of the device tree provided
> configuration a bit earlier so we can use that for checking if anything
> was configured.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/gpmc.c | 141 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 2c5f348..0999923 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -291,6 +291,123 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
>  			   p->cycle2cyclediffcsen);
>  }
>  
> +static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
> +			       bool raw, bool noval, int shift,
> +			       const char *name)
> +{
> +	u32 l;
> +	int nr_bits, max_value, mask;
> +
> +	l = gpmc_cs_read_reg(cs, reg);
> +	nr_bits = end_bit - st_bit + 1;
> +	max_value = (1 << nr_bits) - 1;
> +	mask = max_value << st_bit;
> +	l = (l & mask) >> st_bit;
> +	if (shift)
> +		l <<= shift;
> +	if (noval && (l == 0))
> +		return 0;
> +	if (!raw) {
> +		unsigned int time_ns_min, time_ns, time_ns_max;
> +
> +		time_ns_min = gpmc_ticks_to_ns(l ? l - 1 : 0);
> +		time_ns = gpmc_ticks_to_ns(l);
> +		time_ns_max = gpmc_ticks_to_ns(l + 1 > max_value ?
> +					       max_value : l + 1);
> +		pr_info("gpmc,%s = <%u> (%u - %u ns, %i ticks)\n",
> +			name, time_ns, time_ns_min, time_ns_max, l);
> +	} else {
> +		pr_info("gpmc,%s = <%u>\n", name, l);
> +	}
> +
> +	return l;
> +}
> +
> +#define GPMC_PRINT_CONFIG(cs, config) \
> +	pr_info("cs%i %s: 0x%08x\n", cs, #config, \
> +		gpmc_cs_read_reg(cs, config))
> +#define GPMC_GET_RAW(reg, st, end, field) \
> +	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 0, 0, field)
> +#define GPMC_GET_RAW_BOOL(reg, st, end, field) \
> +	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 1, 0, field)
> +#define GPMC_GET_RAW_SHIFT(reg, st, end, shift, field) \
> +	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 1, (shift), field)
> +#define GPMC_GET_TICKS(reg, st, end, field) \
> +	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, 0, 0, field)
> +
> +static void gpmc_show_regs(int cs, const char *desc)
> +{
> +	pr_info("gpmc cs%i %s:\n", cs, desc);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG1);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG2);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG3);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG4);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG5);
> +	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG6);
> +}
> +
> +/*
> + * Note that gpmc,wait-pin handing wrongly assumes bit 8 is available,
> + * see commit c9fb809.
> + */
> +static void gpmc_cs_show_timings(int cs, const char *desc)
> +{
> +	gpmc_show_regs(cs, desc);
> +
> +	pr_info("gpmc cs%i access configuration:\n", cs);
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
> +	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
> +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 12, 13, "device-width");
> +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 22, 22, "wait-on-read");
> +	GPMC_GET_RAW_SHIFT(GPMC_CS_CONFIG1, 23, 24, 3, "burst-length");

how does this work with shift = 3?
Possible values of burst length are
0 -> 4
1 -> 8
2 -> 16

> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 27, 27, "sync-write");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 28, 28, "burst-write");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 29, 29, "gpmc,sync-read");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 30, 30, "burst-read");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 31, 31, "burst-wrap");
> +
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG2,  7,  7, "cs-extra-delay");
> +
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG3,  7,  7, "adv-extra-delay");
> +
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG4, 23, 23, "we-extra-delay");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG4,  7,  7, "oe-extra-delay");
> +
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG6,  7,  7, "cycle2cycle-samecsen");
> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG6,  6,  6, "cycle2cycle-diffcsen");
> +
> +	pr_info("gpmc cs%i timings configuration:\n", cs);
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG2,  0,  3, "cs-on-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG2,  8, 12, "cs-rd-off-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG2, 16, 20, "cs-wr-off-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG3,  0,  3, "adv-on-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG3,  8, 12, "adv-rd-off-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG3, 16, 20, "adv-wr-off-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG4,  0,  3, "oe-on-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG4,  8, 12, "oe-off-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG4, 16, 19, "we-on-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG4, 24, 28, "we-off-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG5,  0,  4, "rd-cycle-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG5,  8, 12, "wr-cycle-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG5, 16, 20, "access-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG5, 24, 27, "page-burst-access-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 0, 3, "bus-turnaround-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 8, 11, "cycle2cycle-delay-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG1, 18, 19, "wait-monitoring-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG1, 25, 26, "clk-activation-ns");
> +
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 16, 19, "wr-data-mux-bus-ns");
> +	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 24, 28, "wr-access-ns");
> +}
> +

Shouldn't all the above functions except gpmc_show_regs() be defined within #ifdef DEBUG?


>  #ifdef DEBUG
>  static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  			       int time, const char *name)
> @@ -361,6 +478,9 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  	int div;
>  	u32 l;
>  
> +#ifdef DEBUG
> +	gpmc_cs_show_timings(cs, "before gpmc_cs_set_timings");
> +#endif
>  	div = gpmc_calc_divider(t->sync_clk);
>  	if (div < 0)
>  		return div;
> @@ -410,7 +530,9 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  	}
>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
> -
> +#ifdef DEBUG
> +	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
> +#endif
>  	return 0;
>  }
>  
> @@ -1571,6 +1693,20 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	}
>  	gpmc_cs_set_name(cs, child->name);
>  
> +	gpmc_read_settings_dt(child, &gpmc_s);
> +	gpmc_read_timings_dt(child, &gpmc_t);
> +
> +	/*
> +	 * For some GPMC devices we still need to rely on the bootloader
> +	 * timings because the devices can be connected via FPGA.
> +	 * REVISIT: Add timing support from slls644g.pdf.
> +	 */
> +	if (!gpmc_t.cs_rd_off) {
> +		gpmc_cs_show_timings(cs,
> +				     "please add GPMC bootloader timings to .dts");
> +		goto no_timings;
> +	}
> +
>  	/*
>  	 * For some GPMC devices we still need to rely on the bootloader
>  	 * timings because the devices can be connected via FPGA. So far
> @@ -1602,8 +1738,6 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		goto err;
>  	}
>  
> -	gpmc_read_settings_dt(child, &gpmc_s);
> -
>  	ret = of_property_read_u32(child, "bank-width", &gpmc_s.device_width);
>  	if (ret < 0)
>  		goto err;
> @@ -1612,7 +1746,6 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	if (ret < 0)
>  		goto err;
>  
> -	gpmc_read_timings_dt(child, &gpmc_t);
>  	gpmc_cs_set_timings(cs, &gpmc_t);
>  
>  no_timings:
> 

cheers,
-roger
