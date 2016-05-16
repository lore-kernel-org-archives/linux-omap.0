From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: Add support for basic clk_set_rate for dm814x
 and j5-eco ADPLL
Date: Mon, 16 May 2016 08:36:00 -0700
Message-ID: <20160516153600.GK5995@atomide.com>
References: <1463157653-9404-1-git-send-email-tony@atomide.com>
 <20160515040028.GA20983@squirrel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160515040028.GA20983@squirrel.local>
Sender: linux-clk-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Nicolas Chauvet <kwizart@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [160514 21:02]:
> On Fri, May 13, 2016 at 09:40:53AM -0700, Tony Lindgren wrote:
> > +#define TI_ADPLL_DIV_N_MAX		GENMASK(7, 0)
> > +#define TI_ADPLL_MULT_M_MAX		(GENMASK(11, 0) + 1)
> 
> These are PLL-type dependent, also the +1 is wrong since M isn't
> off-by-one like N and N2 are.  (consistency? who needs that anyway?)
> 
> Here's what my own header says:
> 
> 			//		PLLS	PLLLJ
> /*10*/	u16 prediv;	// aka N	0..127	0..255	(off by one)
> /*12*/	u16 postdiv;	// aka M2	1..31	1..127  (but see note below)
> /*14*/	u16 mult;	// aka M	2..2047	2..4095
> /*16*/	u16 bypassdiv;	// aka N2	0..15	0..15	(off by one)
> 
> the "note below" referred to being:
> 
> // Using the fractional multiplier increases jitter (presumably more for PLLS
> // than for PLLLJ) and imposes constraints on the multiplier:
> //	PLLLJ:  mult < 4094
> //	PLLS:	mult < 2046 && mult >= 20
> // Other docs say mult > 100 is required for PLLS for max 2.5% period jitter.

OK thanks for that info.

> > +	/* Ratio for integer multiplier M and pre-divider N */
> > +	rational_best_approximation(rate, dcorate, TI_ADPLL_MULT_M_MAX,
> > +				    TI_ADPLL_DIV_N_MAX, &m, &n);
> 
> I'm seeing all sorts of problems here...
> 
> "dcorate" is a rather misleading name since I would expect that to
> refer to the rate of the dco, obviously, while in fact it's the input
> clock adjusted to account for an implicit factor of 2 (or 8 if you
> enable M4XEN, the utility of which I do not see).
> 
> It makes no sense to use rational_best_approximation on the integer
> part and then calculate the fractional part separately.  Not only is the
> calculation wrong, it's needlessly complicated.  You could just have
> passed TI_ADPLL_MULT_M_MAX << 18 to rational_best_approximation and then
> split m into integer and fractional part.

Hmm I guess I was trying to only change the integer part separately
if possible but the code is not even doing that.. I guess there's no
advantage to that and we have the the post divider to play with. I'll
update the patch for what you're suggesting.

> The biggest problem however is that the best rational approximation does
> not guarantee the refclk and dcoclk are within valid range.  This is
> unlikely to be a problem for PLLS, but PLLLJ has quite narrow ranges:
> 0.5-2.5 MHz for refclk and 0.5-2.0 GHz for dcoclk.

Yeah that's a concern :) Some of this can be corrected by manually
changing the multiplier and divider values, maybe not all cases
though.

Seems strange if we already don't have a decent piece of code to use
here.. Anybody got code stashed away for the PLLS and PLLLJ set_rate
handling?

> I don't really have much time right now to spend on this, I suggest
> checking previous threads on the 814x PLLs since I'm pretty sure the
> complications/constraints for setting them have been discussed.

OK sure, thanks a lot for your comments though!

> > + *                                            Maybe we can
> > + * make the SD_DIV_TARGET_MHZ configurable also?
> 
> What use would it have?  All docs I've ever seen say sddiv must be set
> to ceil(dcoclk / 250_MHz) and none of the docs contain any background
> information whatsoever on how this thing works, so there's no informed
> way to choose an alternate value.
> 
> > +	if ((sd >= TI814X_ADPLLJ_MIN_SD_DIV) &&
> > +	    (sd <= TI814X_ADPLLJ_MAX_SD_DIV)) {
> 
> always true due to the limited range permitted for dcoclk.

OK in that case I'll update the comments to reflect that :)

Regards,

Tony
