From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v7 08/11] ARM: OMAP2+: gpmc: generic timing calculation
Date: Wed, 26 Sep 2012 22:24:22 -0500
Message-ID: <5063C6E6.50109@ti.com>
References: <cover.1348058726.git.afzal@ti.com> <6b20c05230f22380802936f83377e94823488fa8.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51706 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab2I0DY3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 23:24:29 -0400
In-Reply-To: <6b20c05230f22380802936f83377e94823488fa8.1348058726.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 09/19/2012 08:23 AM, Afzal Mohammed wrote:
> Presently there are three peripherals that gets it timing
> by runtime calculation. Those peripherals can work with
> frequency scaling that affects gpmc clock. But timing
> calculation for them are in different ways.
> 
> Here a generic runtime calculation method is proposed. Input
> to this function were selected so that they represent timing
> variables that are present in peripheral datasheets. Motive
> behind this was to achieve DT bindings for the inputs as is.
> Even though a few of the tusb6010 timings could not be made
> directly related to timings normally found on peripherals,
> expressions used were translated to those that could be
> justified.
> 
> There are possibilities of improving the calculations, like
> calculating timing for read & write operations in a more
> similar way. Expressions derived here were tested for async
> onenand on omap3evm (as vanilla Kernel does not have omap3evm
> onenand support, local patch was used). Other peripherals,
> tusb6010, smc91x calculations were validated by simulating
> on omap3evm.
> 
> Regarding "we_on" for onenand async, it was found that even
> for muxed address/data, it need not be greater than
> "adv_wr_off", but rather could be derived from write setup
> time for peripheral from start of access time, hence would
> more be in line with peripheral timings. With this method
> it was working fine. If it is required in some cases to
> have "we_on" same as "wr_data_mux_bus" (i.e. greater than
> "adv_wr_off"), another variable could be added to indicate
> it. But such a requirement is not expected though.
> 
> It has been observed that "adv_rd_off" & "adv_wr_off" are
> currently calculated by adding an offset over "oe_on" and
> "we_on" respectively in the case of smc91x. But peripheral
> datasheet does not specify so and so "adv_rd(wr)_off" has
> been derived (to be specific, made ignorant of "oe_on" and
> "we_on") observing datasheet rather than adding an offset.
> Hence this generic routine is expected to work for smc91x
> (91C96 RX51 board). This was verified on smsc911x (9220 on
> OMAP3EVM) - a similar ethernet controller.
> 
> Timings are calculated in ps to prevent rounding errors and
> converted to ns at final stage so that these values can be
> directly fed to gpmc_cs_set_timings(). gpmc_cs_set_timings()
> would be modified to take ps once all custom timing routines
> are replaced by the generic routine, at the same time
> generic timing routine would be modified to provide timings
> in ps. struct gpmc_timings field types are upgraded from
> u16 => u32 so that it can hold ps values.
> 
> Whole of this exercise is being done to achieve driver and
> DT conversion. If timings could not be calculated in a
> peripheral agnostic way, either gpmc driver would have to
> be peripheral gnostic or a wrapper arrangement over gpmc
> driver would be required.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v7:	1. Use picoseconds throughout generic timing routine to prevent
> 	 rounding error.
> 	2. Documentation on gpmc timings
> 
>  Documentation/bus-devices/ti-gpmc.txt  |  77 ++++++++
>  arch/arm/mach-omap2/gpmc.c             | 319 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/gpmc.h | 101 ++++++++---
>  3 files changed, 477 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/bus-devices/ti-gpmc.txt
> 
> diff --git a/Documentation/bus-devices/ti-gpmc.txt b/Documentation/bus-devices/ti-gpmc.txt
> new file mode 100644
> index 0000000..2c88a88
> --- /dev/null
> +++ b/Documentation/bus-devices/ti-gpmc.txt
> @@ -0,0 +1,77 @@
> +GPMC (General Purpose Memory Controller):
> +=========================================
> +
> +GPMC is an unified memory controller dedicated to interfacing external
> +memory devices like
> + * Asynchronous SRAM like memories and application specific integrated
> +   circuit devices.
> + * Asynchronous, synchronous, and page mode burst NOR flash devices
> +   NAND flash
> + * Pseudo-SRAM devices
> +
> +GPMC is found on Texas Instruments SoC's (OMAP based)
> +
> +
> +GPMC generic timing calculation:
> +================================
> +
> +GPMC has certain timings that has to be programmed for proper
> +functioning of the peripheral, while peripheral has another set of
> +timings. To have peripheral work with gpmc, peripheral timings has to
> +be translated to the form gpmc can understand. The way it has to be
> +translated depends on the connected peripheral. Also there is a
> +dependency for certain gpmc timings on gpmc clock frequency. Hence a
> +generic timing routine was developed to achieve above requirements.
> +
> +Generic routine provides a generic method to calculate gpmc timings
> +from gpmc peripheral timings. struct gpmc_device_timings fields has to
> +be updated with timings from the datasheet of the peripheral that is
> +connected to gpmc. A few of the peripheral timings can be fed either
> +in time or in cycles, provision to handle this scenario has been
> +provided (refer struct gpmc_device_timings definition). It may so
> +happen that timing as specified by peripheral datasheet is not present
> +in timing structure, in this scenario, try to correlate peripheral
> +timing to the one available. If that doesn't work, try to add a new
> +field as required by peripheral, educate generic timing routine to
> +handle it, make sure that it does not break any of the existing.
> +Then there may be cases where peripheral datasheet doesn't mention
> +certain fields of struct gpmc_device_timings, zero those entries.
> +
> +Generic timing routine has been verified to work properly on
> +multiple onenand's and tusb6010 peripherals.
> +
> +A word of caution: generic timing routine has been developed based
> +on understanding of gpmc timings, peripheral timings, available
> +custom timing routines, a kind of reverse engineering without
> +most of the datasheets & hardware (to be exact none of those supported
> +in mainline having custom timing routine) and by simulation.
> +
> +Dependency of peripheral timings on gpmc timings:
> +
> +cs_on: t_ceasu

Thanks for adding these details. Could be good to clarify that the
left-hand side parameters are the gpmc register fields and the
right-hand side are the timing parameters these are calculated using.

Also, given that this is in documentation for completeness it could be
good to somewhere state what "t_ceasu" means. For the gpmc register
field description may be we could give a reference to an OMAP document.

> +adv_on: t_avdasu, t_ceavd
> +sync_clk: clk
> +page_burst_access: t_bacc
> +clk_activation: t_ces, t_avds
> +
> +adv_rd_off: t_avdp_r, t_avdh(s*)
> +oe_on: t_oeasu, t_aavdh(a**), t_ach(s), cyc_aavdh_oe(s)

Would it be better to have ...

oe_on (sync):	t_oeasu, t_ach(*), cyc_aavdh_oe
oe_on (async):	t_oeasu, t_aavdh(*)

* - optional

I assume that the hold times from the clock (t_ach and t_aavdh) are used
for fine tuning if the peripheral requires this, but a user adding a new
device would not be required to specify these, where as t_oeasu is
mandatory.

Or maybe should the timings be grouped as ...

General
Read Async
Read Async Address/Data Multiplexed
Read Sync
Read Sync Address/Data Multiplexed
Write Async
Write Async Address/Data Multiplexed
Write Sync
Write Sync Address/Data Multiplexed

There may be some duplication but it will be clear where things like ADV
timing applies.

> +access: t_iaa, t_oe(a), t_ce(a), t_aa(a), cyc_iaa(s), cyc_oe(s)
> +rd_cycle: t_rd_cycle(a), t_cez_r, t_oez, t_ce_rdyz(s)
> +
> +adv_wr_off: t_avdp_w, t_avdh(s)
> +we_on, wr_data_mux_bus: t_weasu, t_aavdh, cyc_aavhd_we, t_rdyo(s)
> +we_off: t_wpl, cyc_wpl(s)
> +cs_wr_off: t_wph
> +wr_cycle: t_cez_w, t_wr_cycle(a), t_ce_rdyz(s)
> +
> +*s - sync only
> +**a - async only
> +
> +Note: Many of gpmc timings are dependent on other gpmc timings (a few
> +gpmc timings purely dependent on other gpmc timings, a reason that
> +some of the gpmc timings are missing above), and it will result in
> +indirect dependency of peripheral timings to gpmc timings other than
> +mentioned above, refer timing routine for more details. To know what
> +these peripheral timings correspond to, please see explanations in
> +struct gpmc_device_timings definition.
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 35e4e7d..da93b6d 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -238,6 +238,18 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
>  	return ticks * gpmc_get_fclk_period() / 1000;
>  }
>  
> +static unsigned int gpmc_ticks_to_ps(unsigned int ticks)
> +{
> +	return ticks * gpmc_get_fclk_period();
> +}
> +
> +static unsigned int gpmc_round_ps_to_ticks(unsigned int time_ps)
> +{
> +	unsigned long ticks = gpmc_ps_to_ticks(time_ps);
> +
> +	return ticks * gpmc_get_fclk_period();
> +}
> +
>  static inline void gpmc_cs_modify_reg(int cs, int reg, u32 mask, bool value)
>  {
>  	u32 l;
> @@ -892,6 +904,313 @@ static void __init gpmc_mem_init(void)
>  	}
>  }
>  
> +static u32 gpmc_round_ps_to_sync_clk(u32 time_ps, u32 sync_clk)
> +{
> +	u32 temp;
> +	int div;
> +
> +	div = gpmc_calc_divider(sync_clk);
> +	temp = gpmc_ps_to_ticks(time_ps);
> +	temp = (temp + div - 1) / div;
> +	return gpmc_ticks_to_ps(temp * div);
> +}
> +
> +/* can the cycles be avoided ? */

Nit should this be marked with a TODO?

> +static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
> +				struct gpmc_device_timings *dev_t)
> +{
> +	bool mux = dev_t->mux;
> +	u32 temp;
> +
> +	/* adv_rd_off */
> +	temp = dev_t->t_avdp_r;
> +	/* mux check required ? */

Nit should this be marked with a TODO?

> +	if (mux) {
> +		/* t_avdp not to be required for sync, only added for tusb this
> +		 * indirectly necessitates requirement of t_avdp_r & t_avdp_w
> +		 * instead of having a single t_avdp
> +		 */
> +		temp = max_t(u32, temp,	gpmc_t->clk_activation + dev_t->t_avdh);
> +		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
> +	}
> +	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp);

Any reason why we can't return ns in the above function? Or make this
function gpmc_round_ps_to_ns()? Then we could avoid having
gpmc_convert_ps_to_ns() below.

> +
> +	/* oe_on */
> +	temp = dev_t->t_oeasu; /* remove this ? */
> +	if (mux) {
> +		temp = max_t(u32, temp,	gpmc_t->clk_activation + dev_t->t_ach);
> +		temp = max_t(u32, temp, gpmc_t->adv_rd_off +
> +				gpmc_ticks_to_ps(dev_t->cyc_aavdh_oe));
> +	}
> +	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
> +
> +	/* access */
> +	/* any scope for improvement ?, by combining oe_on & clk_activation,
> +	 * need to check whether access = clk_activation + round to sync clk ?
> +	 */
> +	temp = max_t(u32, dev_t->t_iaa,	dev_t->cyc_iaa * gpmc_t->sync_clk);
> +	temp += gpmc_t->clk_activation;
> +	if (dev_t->cyc_oe)
> +		temp = max_t(u32, temp, gpmc_t->oe_on +
> +				gpmc_ticks_to_ps(dev_t->cyc_oe));
> +	gpmc_t->access = gpmc_round_ps_to_ticks(temp);
> +
> +	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ps(1);
> +	gpmc_t->cs_rd_off = gpmc_t->oe_off;
> +
> +	/* rd_cycle */
> +	temp = max_t(u32, dev_t->t_cez_r, dev_t->t_oez);
> +	temp = gpmc_round_ps_to_sync_clk(temp, gpmc_t->sync_clk) +
> +							gpmc_t->access;
> +	/* barter t_ce_rdyz with t_cez_r ? */
> +	if (dev_t->t_ce_rdyz)
> +		temp = max_t(u32, temp,	gpmc_t->cs_rd_off + dev_t->t_ce_rdyz);
> +	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp);
> +
> +	return 0;
> +}
> +
> +static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
> +				struct gpmc_device_timings *dev_t)
> +{
> +	bool mux = dev_t->mux;
> +	u32 temp;
> +
> +	/* adv_wr_off */
> +	temp = dev_t->t_avdp_w;
> +	if (mux) {
> +		temp = max_t(u32, temp,
> +			gpmc_t->clk_activation + dev_t->t_avdh);
> +		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
> +	}
> +	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp);
> +
> +	/* wr_data_mux_bus */
> +	temp = max_t(u32, dev_t->t_weasu,
> +			gpmc_t->clk_activation + dev_t->t_rdyo);
> +	/* shouldn't mux be kept as a whole for wr_data_mux_bus ?,
> +	 * and in that case remember to handle we_on properly
> +	 */
> +	if (mux) {
> +		temp = max_t(u32, temp,
> +			gpmc_t->adv_wr_off + dev_t->t_aavdh);
> +		temp = max_t(u32, temp, gpmc_t->adv_wr_off +
> +				gpmc_ticks_to_ps(dev_t->cyc_aavdh_we));
> +	}
> +	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp);
> +
> +	/* we_on */
> +	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
> +		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu);
> +	else
> +		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
> +
> +	/* wr_access */
> +	/* gpmc_capability check reqd ? , even if not, will not harm */
> +	gpmc_t->wr_access = gpmc_t->access;
> +
> +	/* we_off */
> +	temp = gpmc_t->we_on + dev_t->t_wpl;
> +	temp = max_t(u32, temp,
> +			gpmc_t->wr_access + gpmc_ticks_to_ps(1));
> +	temp = max_t(u32, temp,
> +		gpmc_t->we_on + gpmc_ticks_to_ps(dev_t->cyc_wpl));
> +	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp);
> +
> +	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off +
> +							dev_t->t_wph);
> +
> +	/* wr_cycle */
> +	temp = gpmc_round_ps_to_sync_clk(dev_t->t_cez_w, gpmc_t->sync_clk);
> +	temp += gpmc_t->wr_access;
> +	/* barter t_ce_rdyz with t_cez_w ? */
> +	if (dev_t->t_ce_rdyz)
> +		temp = max_t(u32, temp,
> +				 gpmc_t->cs_wr_off + dev_t->t_ce_rdyz);
> +	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp);
> +
> +	return 0;
> +}
> +
> +static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
> +				struct gpmc_device_timings *dev_t)
> +{
> +	bool mux = dev_t->mux;
> +	u32 temp;
> +
> +	/* adv_rd_off */
> +	temp = dev_t->t_avdp_r;
> +	if (mux)
> +		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
> +	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp);
> +
> +	/* oe_on */
> +	temp = dev_t->t_oeasu;
> +	if (mux)
> +		temp = max_t(u32, temp,
> +			gpmc_t->adv_rd_off + dev_t->t_aavdh);
> +	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
> +
> +	/* access */
> +	temp = max_t(u32, dev_t->t_iaa, /* remove t_iaa in async ? */
> +				gpmc_t->oe_on + dev_t->t_oe);
> +	temp = max_t(u32, temp,
> +				gpmc_t->cs_on + dev_t->t_ce);
> +	temp = max_t(u32, temp,
> +				gpmc_t->adv_on + dev_t->t_aa);
> +	gpmc_t->access = gpmc_round_ps_to_ticks(temp);
> +
> +	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ps(1);
> +	gpmc_t->cs_rd_off = gpmc_t->oe_off;
> +
> +	/* rd_cycle */
> +	temp = max_t(u32, dev_t->t_rd_cycle,
> +			gpmc_t->cs_rd_off + dev_t->t_cez_r);
> +	temp = max_t(u32, temp, gpmc_t->oe_off + dev_t->t_oez);
> +	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp);
> +
> +	return 0;
> +}
> +
> +static int gpmc_calc_async_write_timings(struct gpmc_timings *gpmc_t,
> +				struct gpmc_device_timings *dev_t)
> +{
> +	bool mux = dev_t->mux;
> +	u32 temp;
> +
> +	/* adv_wr_off */
> +	temp = dev_t->t_avdp_w;
> +	if (mux)
> +		temp = max_t(u32, gpmc_t->adv_on + gpmc_ticks_to_ps(1), temp);
> +	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp);
> +
> +	/* wr_data_mux_bus */
> +	temp = dev_t->t_weasu;
> +	if (mux) {
> +		temp = max_t(u32, temp,	gpmc_t->adv_wr_off + dev_t->t_aavdh);
> +		temp = max_t(u32, temp, gpmc_t->adv_wr_off +
> +				gpmc_ticks_to_ps(dev_t->cyc_aavdh_we));
> +	}
> +	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp);
> +
> +	/* we_on */
> +	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
> +		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu);
> +	else
> +		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
> +
> +	/* we_off */
> +	temp = gpmc_t->we_on + dev_t->t_wpl;
> +	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp);
> +
> +	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off +
> +							dev_t->t_wph);
> +
> +	/* wr_cycle */
> +	temp = max_t(u32, dev_t->t_wr_cycle,
> +				gpmc_t->cs_wr_off + dev_t->t_cez_w);
> +	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp);
> +
> +	return 0;
> +}
> +
> +static int gpmc_calc_sync_common_timings(struct gpmc_timings *gpmc_t,
> +			struct gpmc_device_timings *dev_t)
> +{
> +	u32 temp;
> +
> +	gpmc_t->sync_clk = gpmc_calc_divider(dev_t->clk) *
> +						gpmc_get_fclk_period();
> +
> +	gpmc_t->page_burst_access = gpmc_round_ps_to_sync_clk(
> +					dev_t->t_bacc,
> +					gpmc_t->sync_clk);
> +
> +	temp = max_t(u32, dev_t->t_ces, dev_t->t_avds);
> +	gpmc_t->clk_activation = gpmc_round_ps_to_ticks(temp);
> +
> +	if (gpmc_calc_divider(gpmc_t->sync_clk) != 1)
> +		return 0;
> +
> +	if (dev_t->ce_xdelay)
> +		gpmc_t->bool_timings.cs_extra_delay = true;
> +	if (dev_t->avd_xdelay)
> +		gpmc_t->bool_timings.adv_extra_delay = true;
> +	if (dev_t->oe_xdelay)
> +		gpmc_t->bool_timings.oe_extra_delay = true;
> +	if (dev_t->we_xdelay)
> +		gpmc_t->bool_timings.we_extra_delay = true;
> +
> +	return 0;
> +}
> +
> +static int gpmc_calc_common_timings(struct gpmc_timings *gpmc_t,
> +			struct gpmc_device_timings *dev_t)
> +{
> +	u32 temp;
> +
> +	/* cs_on */
> +	gpmc_t->cs_on = gpmc_round_ps_to_ticks(dev_t->t_ceasu);
> +
> +	/* adv_on */
> +	temp = dev_t->t_avdasu;
> +	if (dev_t->t_ce_avd)
> +		temp = max_t(u32, temp,
> +				gpmc_t->cs_on + dev_t->t_ce_avd);
> +	gpmc_t->adv_on = gpmc_round_ps_to_ticks(temp);
> +
> +	if (dev_t->sync_write || dev_t->sync_read)
> +		gpmc_calc_sync_common_timings(gpmc_t, dev_t);
> +
> +	return 0;
> +}
> +
> +static void gpmc_convert_ps_to_ns(struct gpmc_timings *t)
> +{
> +	t->cs_on /= 1000;
> +	t->cs_rd_off /= 1000;
> +	t->cs_wr_off /= 1000;
> +	t->adv_on /= 1000;
> +	t->adv_rd_off /= 1000;
> +	t->adv_wr_off /= 1000;
> +	t->we_on /= 1000;
> +	t->we_off /= 1000;
> +	t->oe_on /= 1000;
> +	t->oe_off /= 1000;
> +	t->page_burst_access /= 1000;
> +	t->access /= 1000;
> +	t->rd_cycle /= 1000;
> +	t->wr_cycle /= 1000;
> +	t->bus_turnaround /= 1000;
> +	t->cycle2cycle_delay /= 1000;
> +	t->wait_monitoring /= 1000;
> +	t->clk_activation /= 1000;
> +	t->wr_access /= 1000;
> +	t->wr_data_mux_bus /= 1000;
> +}
> +
> +int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
> +			struct gpmc_device_timings *dev_t)
> +{
> +	memset(gpmc_t, 0, sizeof(*gpmc_t));
> +
> +	gpmc_calc_common_timings(gpmc_t, dev_t);
> +
> +	if (dev_t->sync_read)
> +		gpmc_calc_sync_read_timings(gpmc_t, dev_t);
> +	else
> +		gpmc_calc_async_read_timings(gpmc_t, dev_t);
> +
> +	if (dev_t->sync_write)
> +		gpmc_calc_sync_write_timings(gpmc_t, dev_t);
> +	else
> +		gpmc_calc_async_write_timings(gpmc_t, dev_t);
> +
> +	gpmc_convert_ps_to_ns(gpmc_t);

I am wondering if we could avoid this above function and then ...

> +
> +	return 0;
> +}
> +
>  static int __init gpmc_init(void)
>  {
>  	u32 l;
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> index 1cafbfd..9b46bbb 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -116,42 +116,103 @@ struct gpmc_timings {
>  	u32 sync_clk;
>  
>  	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
> -	u16 cs_on;		/* Assertion time */
> -	u16 cs_rd_off;		/* Read deassertion time */
> -	u16 cs_wr_off;		/* Write deassertion time */
> +	u32 cs_on;		/* Assertion time */
> +	u32 cs_rd_off;		/* Read deassertion time */
> +	u32 cs_wr_off;		/* Write deassertion time */
>  
>  	/* ADV signal timings corresponding to GPMC_CONFIG3 */
> -	u16 adv_on;		/* Assertion time */
> -	u16 adv_rd_off;		/* Read deassertion time */
> -	u16 adv_wr_off;		/* Write deassertion time */
> +	u32 adv_on;		/* Assertion time */
> +	u32 adv_rd_off;		/* Read deassertion time */
> +	u32 adv_wr_off;		/* Write deassertion time */
>  
>  	/* WE signals timings corresponding to GPMC_CONFIG4 */
> -	u16 we_on;		/* WE assertion time */
> -	u16 we_off;		/* WE deassertion time */
> +	u32 we_on;		/* WE assertion time */
> +	u32 we_off;		/* WE deassertion time */
>  
>  	/* OE signals timings corresponding to GPMC_CONFIG4 */
> -	u16 oe_on;		/* OE assertion time */
> -	u16 oe_off;		/* OE deassertion time */
> +	u32 oe_on;		/* OE assertion time */
> +	u32 oe_off;		/* OE deassertion time */
>  
>  	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
> -	u16 page_burst_access;	/* Multiple access word delay */
> -	u16 access;		/* Start-cycle to first data valid delay */
> -	u16 rd_cycle;		/* Total read cycle time */
> -	u16 wr_cycle;		/* Total write cycle time */
> +	u32 page_burst_access;	/* Multiple access word delay */
> +	u32 access;		/* Start-cycle to first data valid delay */
> +	u32 rd_cycle;		/* Total read cycle time */
> +	u32 wr_cycle;		/* Total write cycle time */
>  
> -	u16 bus_turnaround;
> -	u16 cycle2cycle_delay;
> +	u32 bus_turnaround;
> +	u32 cycle2cycle_delay;
>  
> -	u16 wait_monitoring;
> -	u16 clk_activation;
> +	u32 wait_monitoring;.abctuw
> +	u32 clk_activation;
>  
>  	/* The following are only on OMAP3430 */
> -	u16 wr_access;		/* WRACCESSTIME */
> -	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
> +	u32 wr_access;		/* WRACCESSTIME */
> +	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */

 ... we could keep the above u16.
>  
>  	struct gpmc_bool_timings bool_timings;
>  };
>  
> +/* Device timings in picoseconds */
> +struct gpmc_device_timings {
> +	u32 t_ceasu;	/* address setup to CS valid */
> +	u32 t_avdasu;	/* address setup to ADV valid */
> +	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
> +	 * of tusb using these timings even for sync whilst
> +	 * ideally for adv_rd/(wr)_off it should have considered
> +	 * t_avdh instead. This indirectly necessitates r/w
> +	 * variations of t_avdp as it is possible to have one
> +	 * sync & other async
> +	 */
> +	u32 t_avdp_r;	/* ADV low time (what about t_cer ?) */
> +	u32 t_avdp_w;
> +	u32 t_aavdh;	/* address hold time */
> +	u32 t_oeasu;	/* address setup to OE valid */
> +	u32 t_aa;	/* access time from ADV assertion */
> +	u32 t_iaa;	/* initial access time */
> +	u32 t_oe;	/* access time from OE assertion */
> +	u32 t_ce;	/* access time from CS asertion */
> +	u32 t_rd_cycle;	/* read cycle time */
> +	u32 t_cez_r;	/* read CS deassertion to high Z */
> +	u32 t_cez_w;	/* write CS deassertion to high Z */
> +	u32 t_oez;	/* OE deassertion to high Z */
> +	u32 t_weasu;	/* address setup to WE valid */
> +	u32 t_wpl;	/* write assertion time */
> +	u32 t_wph;	/* write deassertion time */
> +	u32 t_wr_cycle;	/* write cycle time */
> +
> +	u32 clk;
> +	u32 t_bacc;	/* burst access valid clock to output delay */
> +	u32 t_ces;	/* CS setup time to clk */
> +	u32 t_avds;	/* ADV setup time to clk */
> +	u32 t_avdh;	/* ADV hold time from clk */
> +	u32 t_ach;	/* address hold time from clk */
> +	u32 t_rdyo;	/* clk to ready valid */
> +
> +	u32 t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
> +	u32 t_ce_avd;	/* CS on to ADV on delay */
> +
> +	/* XXX: check the possibility of combining
> +	 * cyc_aavhd_oe & cyc_aavdh_we
> +	 */
> +	u8 cyc_aavdh_oe;
> +	u8 cyc_aavdh_we;
> +	u8 cyc_oe;
> +	u8 cyc_wpl;
> +	u32 cyc_iaa;

May be I should look at an example, but it would be good to document
what these cyc_xxx parameters are/represent.

Cheers
Jon
