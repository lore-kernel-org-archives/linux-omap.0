From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Mon, 05 Dec 2016 10:46:43 +0200
Message-ID: <2239782.MNuANFihMe@avalon>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com> <20161205082210.GA2901@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161205082210.GA2901@localhost.localdomain>
Sender: linux-clk-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,

On Monday 05 Dec 2016 09:22:10 Ladislav Michl wrote:
> Hi Laurent,
> 
> I'm happy someone is stepping into this again :-) Just a few comments bellow
> (and this thread for more:
> http://www.spinics.net/lists/linux-omap/msg126591.html)
>
> On Fri, Dec 02, 2016 at 11:14:38PM +0200, Laurent Pinchart wrote:
> > From: Richard Watts <rrw@kynesim.co.uk>
> > 
> > The OMAP36xx DPLL5, driving EHCI USB, can be subject to a long-term
> > frequency drift. The frequency drift magnitude depends on the VCO update
> > rate, which is inversely proportional to the PLL divider. The kernel
> > DPLL configuration code results in a high value for the divider, leading
> > to a long term drift high enough to cause USB transmission errors. In
> > the worst case the USB PHY's ULPI interface can stop responding,
> > breaking USB operation completely. This manifests itself on the
> > Beagleboard xM by the LAN9514 reporting 'Cannot enable port 2. Maybe the
> > cable is bad?' in the kernel log.
> > 
> > Errata sprz319 advisory 2.1 documents PLL values that minimize the
> > drift. Use them automatically when DPLL5 is used for USB operation,
> > which we detect based on the requested clock rate. The clock framework
> > will still compute the PLL parameters and resulting rate as usual, but
> > the PLL M and N values will then be overridden. This can result in the
> > effective clock rate being slightly different than the rate cached by
> > the clock framework, but won't cause any adverse effect to USB
> > operation.
> > 
> > Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
> > [Upported from v3.2 to v4.9]
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v2:
> > 
> > - Added spaces around +
> > ---
> > 
> >  drivers/clk/ti/clk-3xxx.c | 20 +++++++-------
> >  drivers/clk/ti/clock.h    |  9 +++++++
> >  drivers/clk/ti/dpll.c     | 19 +++++++++++++-
> >  drivers/clk/ti/dpll3xxx.c | 67 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 104 insertions(+), 11 deletions(-)

[snip]

> > diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> > index 88f2ce81ba55..4cdd28a25584 100644
> > --- a/drivers/clk/ti/dpll3xxx.c
> > +++ b/drivers/clk/ti/dpll3xxx.c
> > @@ -838,3 +838,70 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw
> > *hw, unsigned long rate,
> >  	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
> >  						      index);
> >  }
> > +
> > +/* Apply DM3730 errata sprz319 advisory 2.1. */
> > +static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
> > +				     unsigned long parent_rate)
> > +{
> > +	struct omap3_dpll5_settings {
> > +		unsigned int rate, m, n;
> > +	};
> > +
> > +	static const struct omap3_dpll5_settings precomputed[] = {
> > +		/*
> > +		 * From DM3730 errata advisory 2.1, table 35 and 36.
> > +		 * The N value is increased by 1 compared to the tables as the
> > +		 * errata lists register values while last_rounded_field is
> > the
> > +		 * real divider value.
> > +		 */
> > +		{ 12000000,  80,  0 + 1 },
> > +		{ 13000000, 443,  5 + 1 },
> > +		{ 19200000,  50,  0 + 1 },
> > +		{ 26000000, 443, 11 + 1 },
> > +		{ 38400000,  25,  0 + 1 }
> > +	};
> 
> Table 36 list two options with 26MHz clocks: m=443, n=11 and m=480, n=12
> with a statement: "The choice between these two options with a 26 MHz input
> should be based on characterization on the end system."
> 
> Shall we care about that?

I'd like to, but at the moment I don't see how. Proposals are welcome :-) I 
don't think addressing that issue should be a blocker to get this patch merged 
though.

> > +	const struct omap3_dpll5_settings *d;
> > +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> > +	struct dpll_data *dd;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(precomputed); ++i) {
> > +		if (parent_rate == precomputed[i].rate)
> > +			break;
> > +	}
> > +
> > +	if (i == ARRAY_SIZE(precomputed))
> > +		return false;
> > +
> > +	d = &precomputed[i];
> > +
> > +	/* Update the M, N and rounded rate values and program the DPLL. */
> > +	dd = clk->dpll_data;
> > +	dd->last_rounded_m = d->m;
> > +	dd->last_rounded_n = d->n;
> > +	dd->last_rounded_rate = div_u64((u64)parent_rate * d->m, d->n);
> > +	omap3_noncore_dpll_program(clk, 0);
> > +
> > +	return true;
> > +}
> 
> What about small optimization? Gives a few tens of bytes smaller code...
> 
> diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> index 88f2ce8..cd22bcc 100644
> --- a/drivers/clk/ti/dpll3xxx.c
> +++ b/drivers/clk/ti/dpll3xxx.c
> @@ -838,3 +838,67 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw,
> unsigned long rate, return omap3_noncore_dpll_set_rate_and_parent(hw, rate,
> parent_rate, index);
>  }
> +
> +/* Apply DM3730 errata sprz319 advisory 2.1. */
> +static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
> +				     unsigned long parent_rate)
> +{
> +	struct omap3_dpll5_settings {
> +		unsigned int rate, m, n;
> +	};
> +
> +	static const struct omap3_dpll5_settings precomputed[] = {
> +		/*
> +		 * From DM3730 errata advisory 2.1, table 35 and 36.
> +		 * The N value is increased by 1 compared to the tables as the
> +		 * errata lists register values while last_rounded_field is 
the
> +		 * real divider value.
> +		 */
> +		{ 12000000,  80,  0 + 1 },
> +		{ 13000000, 443,  5 + 1 },
> +		{ 19200000,  50,  0 + 1 },
> +		{ 26000000, 443, 11 + 1 },
> +		{ 38400000,  25,  0 + 1 }
> +	};
> +
> +	struct clk_hw_omap *clk;
> +	struct dpll_data *dd;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(precomputed); i++)
> +		if (parent_rate == precomputed[i].rate) {
> +			clk = to_clk_hw_omap(hw);
> +			/* Update the M, N and rounded rate values */
> +			dd = clk->dpll_data;
> +			dd->last_rounded_m = precomputed[i].m;
> +			dd->last_rounded_n = precomputed[i].n;
> +			dd->last_rounded_rate =
> +				div_u64((u64)parent_rate * dd->last_rounded_m,
> +					dd->last_rounded_n);
> +			omap3_noncore_dpll_program(clk, 0);
> +
> +			return true;
> +		}
> +
> +	return false;
> +}

I had tried that, but I find the code less readable :-S

(I wish C had a for (...) { ... } else { ... } construct like Python does.)

> > +/**
> > + * omap3_dpll5_set_rate - set rate for omap3 dpll5
> > + * @hw: clock to change
> > + * @rate: target rate for clock
> > + * @parent_rate: rate of the parent clock
> > + *
> > + * Set rate for the DPLL5 clock. Apply the sprz319 advisory 2.1 on
> > OMAP36xx if
> > + * the DPLL is used for USB host (detected through the requested rate).
> > + */
> > +int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			 unsigned long parent_rate)
> > +{
> > +	if (rate == OMAP3_DPLL5_FREQ_FOR_USBHOST * 8) {
> > +		if (omap3_dpll5_apply_errata(hw, parent_rate))
> > +			return 0;
> > +	}
> > +
> > +	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
> > +}

-- 
Regards,

Laurent Pinchart

