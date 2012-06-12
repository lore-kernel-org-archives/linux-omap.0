From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 07/14] ARM: OMAP2+: gpmc: time setting (register#)
 helper
Date: Tue, 12 Jun 2012 13:55:23 -0500
Message-ID: <4FD7909B.4040304@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <aafc6bc498e303be0bc86ce1ae395148fdca5c3d.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58002 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2FLSzb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 14:55:31 -0400
In-Reply-To: <aafc6bc498e303be0bc86ce1ae395148fdca5c3d.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:27 AM, Afzal Mohammed wrote:
> Helper for setting GPMC timing by taking input as register values.

When are the timings calculated? Why not just use the existing
gpmc_cs_set_timings()?

I guess I am not convinced that we need to have multiple formats to pass
timings such as clock, period, etc.

I think that it is sufficient to pass the timings as time (period) as is
currently done and have the driver convert to clocks based upon the gpmc
fclk rate.

Jon

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 4e19010..e60076e3 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -960,6 +960,49 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
>  	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
>  }
>  
> +static inline void gpmc_set_one_timing(int cs, int reg, int start,
> +							int end, u32 val)
> +{
> +	u32 l;
> +	unsigned mask;
> +
> +	mask = (1 << (end - start + 1)) - 1;
> +	l = gpmc_cs_read_reg(cs, reg);
> +	l &= ~(mask << start);
> +	l |= val << start;
> +	gpmc_cs_write_reg(cs, reg, l);
> +}
> +
> +static void gpmc_cs_set_register_timings(int cs, const struct gpmc_timings *t)
> +{
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 0, 1, t->sync_clk);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 18, 19, t->wait_monitoring);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 25, 26, t->clk_activation);
> +
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 0, 3, t->cs_on);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 8, 12, t->cs_rd_off);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 16, 20, t->cs_wr_off);
> +
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 0, 3, t->adv_on);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 8, 12, t->adv_rd_off);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 16, 20, t->adv_wr_off);
> +
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 0, 3, t->oe_on);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 8, 12, t->oe_off);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 16, 19, t->we_on);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 24, 28, t->we_off);
> +
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG5, 24, 27, t->page_burst_access);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 0, 3, t->bus_turnaround);
> +	gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 8, 11,	t->cycle2cycle_delay);
> +
> +	if (gpmc_revision >= 4) {
> +		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 16, 19,
> +						t->wr_data_mux_bus);
> +		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 24, 28, t->wr_access);
> +	}
> +}
> +
>  static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
>  {
>  	return bitmask;
