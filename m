From: Jon Hunter <jon-hunter@TI.COM>
Subject: Re: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
Date: Wed, 22 Aug 2012 21:58:44 -0500
Message-ID: <50359C64.40603@ti.com>
References: <cover.1345524670.git.afzal@ti.com> <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55517 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756653Ab2HWC6g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 22:58:36 -0400
In-Reply-To: <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@TI.COM>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 08/21/2012 05:45 AM, Afzal Mohammed wrote:
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
> Whole of this exercise is being done to achieve driver and
> DT conversion. If timings could not be calculated in a
> peripheral agnostic way, either gpmc driver would have to
> be peripheral gnostic or a wrapper arrangement over gpmc
> driver would be required.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |  302 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |   61 +++++++
>  2 files changed, 363 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index d005b3a..d8e5b08 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -233,6 +233,18 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
>  	return ticks * gpmc_get_fclk_period() / 1000;
>  }
>  
> +unsigned int gpmc_ticks_to_ps(unsigned int ticks)
> +{
> +	return ticks * gpmc_get_fclk_period();
> +}
> +
> +unsigned int gpmc_round_ps_to_ticks(unsigned int time_ps)
> +{
> +	unsigned long ticks = gpmc_ps_to_ticks(time_ps);
> +
> +	return ticks * gpmc_get_fclk_period();
> +}
> +
>  static inline void gpmc_cs_modify_reg(int cs, int reg, u32 mask, bool value)
>  {
>  	u32 l;
> @@ -884,6 +896,296 @@ static void __init gpmc_mem_init(void)
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

What is the above comment referring too?

> +static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
> +				struct gpmc_device_timings *dev_t)
> +{
> +	bool mux = dev_t->mux;
> +	u32 temp;
> +
> +	/* adv_rd_off */
> +	temp = dev_t->t_avdp_r;
> +	/* mux check required ? */
> +	if (mux) {
> +		/* t_avdp not to be required for sync, only added for tusb this
> +		 * indirectly necessitates requirement of t_avdp_r & t_avdp_w
> +		 * instead of having a single t_avdp
> +		 */
> +		temp = max_t(u32, temp,	gpmc_t->clk_activation * 1000 +
> +							dev_t->t_avdh);
> +		temp = max_t(u32,
> +			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
> +	}
> +	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp) / 1000;
> +
> +	/* oe_on */
> +	temp = dev_t->t_oeasu; /* remove this ? */
> +	if (mux) {
> +		temp = max_t(u32, temp,
> +			gpmc_t->clk_activation * 1000 + dev_t->t_ach);
> +		temp = max_t(u32, temp, (gpmc_t->adv_rd_off +
> +				gpmc_ticks_to_ns(dev_t->cyc_aavdh_oe)) * 1000);
> +	}
> +	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
> +
> +	/* access */
> +	/* any scope for improvement ?, by combining oe_on & clk_activation,
> +	 * need to check whether access = clk_activation + round to sync clk ?
> +	 */
> +	temp = max_t(u32, dev_t->t_iaa,	dev_t->cyc_iaa * gpmc_t->sync_clk);
> +	temp += gpmc_t->clk_activation * 1000;
> +	if (dev_t->cyc_oe)
> +		temp = max_t(u32, temp, (gpmc_t->oe_on +
> +				gpmc_ticks_to_ns(dev_t->cyc_oe)) * 1000);
> +	gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
> +
> +	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ns(1);
> +	gpmc_t->cs_rd_off = gpmc_t->oe_off;
> +
> +	/* rd_cycle */
> +	temp = max_t(u32, dev_t->t_cez_r, dev_t->t_oez);
> +	temp = gpmc_round_ps_to_sync_clk(temp, gpmc_t->sync_clk) +
> +							gpmc_t->access * 1000;
> +	/* barter t_ce_rdyz with t_cez_r ? */
> +	if (dev_t->t_ce_rdyz)
> +		temp = max_t(u32, temp,
> +				gpmc_t->cs_rd_off * 1000 + dev_t->t_ce_rdyz);
> +	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
> +
> +	return 0;
> +}

[...]

> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> index 1cafbfd..e59a932 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -152,6 +152,67 @@ struct gpmc_timings {
>  	struct gpmc_bool_timings bool_timings;
>  };
>  
> +/* Device timings in picoseconds */

Why pico seconds and not nanoseconds? I understand you may need to
temporarily convert to pico-secs for rounding, but when providing timing
it seems nano-secs is more suitable.

> +struct gpmc_device_timings {
> +	u32     t_ceasu;	/* address setup to CS valid */
> +	u32     t_avdasu;	/* address setup to ADV valid */
> +	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
> +	 * of tusb using these timings even for sync whilst
> +	 * ideally for adv_rd/(wr)_off it should have considered
> +	 * t_avdh instead. This indirectly necessitates r/w
> +	 * variations of t_avdp as it is possible to have one
> +	 * sync & other async
> +	 */
> +	u32	t_avdp_r;	/* ADV low time (what about t_cer ?) */
> +	u32	t_avdp_w;
> +	u32	t_aavdh;	/* address hold time */
> +	u32     t_oeasu;	/* address setup to OE valid */
> +	u32     t_aa;		/* access time from ADV assertion */
> +	u32     t_iaa;		/* initial access time */
> +	u32     t_oe;		/* access time from OE assertion */
> +	u32     t_ce;		/* access time from CS asertion */
> +	u32     t_rd_cycle;	/* read cycle time */
> +	u32     t_cez_r;	/* read CS deassertion to high Z */
> +	u32     t_cez_w;	/* write CS deassertion to high Z */
> +	u32     t_oez;		/* OE deassertion to high Z */
> +	u32     t_weasu;	/* address setup to WE valid */
> +	u32     t_wpl;		/* write assertion time */
> +	u32     t_wph;		/* write deassertion time */
> +	u32     t_wr_cycle;	/* write cycle time */
> +
> +	u32	clk;
> +	u32	t_bacc;		/* burst access valid clock to output delay */
> +	u32	t_ces;		/* CS setup time to clk */
> +	u32	t_avds;		/* ADV setup time to clk */
> +	u32	t_avdh;		/* ADV hold time from clk */
> +	u32     t_ach;		/* address hold time from clk */
> +	u32	t_rdyo;		/* clk to ready valid */
> +
> +	u32	t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
> +	u32	t_ce_avd;	/* CS on to ADV on delay */
> +
> +	/* XXX: check the possibility of combining
> +	 * cyc_aavhd_oe & cyc_aavdh_we
> +	 */
> +	u8	cyc_aavdh_oe;
> +	u8	cyc_aavdh_we;
> +	u8	cyc_oe;
> +	u8	cyc_wpl;
> +	u32     cyc_iaa;
> +
> +	bool	mux;		/* address & data muxed */
> +	bool	sync_write;	/* synchronous write */
> +	bool	sync_read;	/* synchronous read */
> +
> +	bool	ce_xdelay;
> +	bool	avd_xdelay;
> +	bool	oe_xdelay;
> +	bool	we_xdelay;
> +};

I am a little concerned about the above timings structure. For example,
if I am adding support for a new devices it is not clear ...

1. Which are required
2. Which are applicable for async, sync, address-data multiplexed etc.
3. Exactly how these relate to the fields in the gpmc registers.

I understand that this is based upon how timings for onenand and tusb
are being calculated today, but I am not sure that this is the way to go
for all devices. Personally, I would like to see us get away from how
those devices are calculating timings for any new device.

In general, I am concerned that we are abstracting the timings further
from the actual register fields. For example, the timings parameter
"t_ceasu" is described "address setup to CS valid" which is not
incorrect but this value is really just programming the CSONTIME field
and so why not call this cs_on?

So although this may consolidate how the timings are calculated today, I
am concerned it will be confusing to add timings for a new device. At
least if I am calculating timings, I am taking the timing information
for the device and translating that to the how I need to program the
gpmc register fields.

Cheers
Jon
