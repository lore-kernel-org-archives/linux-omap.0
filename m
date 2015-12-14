From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH v2] clk: ti: Add support for dm814x ADPLL
Date: Mon, 14 Dec 2015 10:15:26 +0100
Message-ID: <20151214091526.GA16315@squirrel.local>
References: <1449800792-5551-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449800792-5551-1-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2015 at 06:26:32PM -0800, Tony Lindgren wrote:
> +- compatible : shall be one of "ti,dm814-adpll-s-clock" or
> +  "ti,dm814-adpll-j-clock" depending on the type of the ADPLL

There's still a j -> lj you missed.

Also, since the device series almost always referred to as dm814x, any 
reason the x is omitted here?  Based on a quick google, dm814 mostly seems 
to be a moose hunting area in alaska ;-)

> +- clocks : link phandles of parent clocks (clk-ref and clk-bypass)

The documentation and your later example calls these clkinp and clkinpulow. 
In theory adpll-s has a third input (clkinphif).

Calling the input clock "clk-ref" is potentially misleading since the 
documentation uses the name "refclk" for clkinp/(N+1). Also, while I'll 
admit "clkinpulow" is an awful name, "clk-bypass" is also misleading since 
it is merely an optional alternative bypass clock, the default being 
clkinp/(N2+1).

Are you aware of any dm814x-sibling that actually uses clkinpulow, or are 
you just including it for completeness or consistency with DPLL instances 
in other devices like the omap4 or am335x?


> +		clock-output-names = "481c5040.adpll.dcoclkldo",
> ...
> +		clock-output-names = "481c5080.adpll.clkdcoldo",

I know this inconsistency comes straight out of the TRM, but may I vote for 
picking one of them and sticking to it? :-)


> +#define ADPLL_CLKINPHIFSEL_ADPLL_S	19	/* REVISIT: which bit? */

Impossible to say unless a dm814x sibling shows up that actually uses it; 
pll_mpu lacks the HIF clocks entirely.  Note that it's quite possible bit 19 
is indeed officially assigned to it, CLKINPHIFSEL and CLKOUTLDOEN do not 
conflict since they apply to different PLL types.


> +static void ti_adpll_set_bypass(struct ti_adpll_data *d)
> +static void ti_adpll_clear_bypass(struct ti_adpll_data *d)

These functions relate to a specific "Idle Bypass" mode of the PLL,
which gates the refclk and sort of freezes the PLL state.  Various other
control/status bits become unresponsive in this mode as a result.

I would suggest reflecting this in the name, or at least a comment,
since "bypass" refers to a much more general state.  Clearing the IDLE
bit is necessary to take the PLL out of bypass, but other conditions
need to be satisfied as well.  Hence, "clear_bypass" does not not
literally do what its name would seem to suggest.

> +static int ti_adpll_wait_lock(struct ti_adpll_data *d)
> ...
> +	while (ti_adpll_clock_is_bypass(d)) {

Locked and bypass are not actually mutually exclusive:  if you only care
about the DCO clock and not CLKOUT you can clear M2PWDNZ before enabling
the PLL, resulting in status (FREQLOCK | PHASELOCK | BYPASS) after lock.

I don't know if there's any reason to take this obscure configuration
into consideration, but I just wanted to make you aware of it.


> +static int ti_adpll_is_prepared(struct clk_hw *hw)
> ...
> +	return (v & ADPLL_STATUS_PREPARED_MASK) == ADPLL_STATUS_PREPARED_MASK;

Yet here you do actually test whether the PLL is locked... why the use a
different condition here than in ti_adpll_wait_lock?


> +static unsigned long ti_adpll_recalc_rate(struct clk_hw *hw,
> ...
> +	if (ti_adpll_clock_is_bypass(d))
> +		return clk_get_rate(d->clocks[TI_ADPLL_N2].clk);

Bypass refers to clkout. This function calculates the DCO clock, which
is never subject to bypass: if the PLL is off, dcoclk is low.

<rant>
Although I understand the reasoning behind using abstractions like
readl_relaxed() for I/O access to allow portability to platforms where
I/O is not simply memory-mapped, this concern does not exist for
platform-specific devices like this.  There's really no reason in my
humble opinion this code could not simply do

	/* read predivider and multiplier, shifted left 18 bits to
	 * accomodate the fractional multiplier */
	spin_lock_irqsave(&d->lock, flags);
	divider = (pll->n + 1) << 18;
	rate = (pll->m << 18) + pll->frac_m;
	spin_unlock_irqrestore(&d->lock, flags);

	do_div(rate, divider);

instead of spending a whole paragraph of code on reading each individual
field, which I think just hurts readability.
</rant>

Note btw that PLLSS is entirely memory-like and is perfectly okay with
16-bit reads/writes.  Grouping the  u16 n, m2, m, n2;  into two 32-bit
registers in the documentation is just TI being silly.


> +	frac_m += 1;

que?


> +	/* Internal mux, sources from divider N2 or clkinpulow */
> +	err = ti_adpll_init_mux(d, TI_ADPLL_ULOW, "ulow",

Shouldn't this just be called "bypass", since it is the bypass clock
after all.  I would associate the name "ulow" only with clkinpulow.


Matthijs
