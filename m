From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] clk: ti: Add support for dm814x ADPLL
Date: Fri, 11 Dec 2015 08:03:54 -0800
Message-ID: <20151211160353.GL23396@atomide.com>
References: <1449800792-5551-1-git-send-email-tony@atomide.com>
 <566A7F52.4020801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566A7F52.4020801@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151210 23:45]:
> On 12/11/2015 04:26 AM, Tony Lindgren wrote:
> 
> Looks mostly good to me, added some minor comments inline below. Sorry again
> for latencies in my replies.

No problme, thanks for looking.

> >+static bool ti_adpll_clock_is_bypass(struct ti_adpll_data *d)
> >+{
> >+	unsigned long flags;
> >+	u32 v;
> >+
> >+	spin_lock_irqsave(&d->lock, flags);
> >+	v = readl_relaxed(d->status);
> >+	spin_unlock_irqrestore(&d->lock, flags);
> 
> What do you need the lock for in here?

Yeah seems pointless, will remove.

> >+static int ti_adpll_clkout_set_parent(struct clk_hw *hw, u8 index)
> >+{
> >+	struct ti_adpll_clkout_data *co = to_clkout(hw);
> >+	struct ti_adpll_data *d = co->adpll;
> >+
> >+	return ti_adpll_clock_is_bypass(d) == index;

Hmm yeah that seems broken. I need to check what all really goes
to bypass mode with ulowclken signal.

> What is the point of this? It doesn't seem to set anything.

> >+	/* Internal mux, sources sources from DCO and clkinphf */
> 
> Double "sources" in comment?
> 
> >+	/* Output clkout clkout, sources M2 or ulow */
> 
> Double "clkout" in comment?

Oops will fix.

> >+	d->pwrctrl = d->base + register_offset + ADPLL_PWRCTRL_OFFSET;
> >+	d->clkctrl = d->base + register_offset + ADPLL_CLKCTRL_OFFSET;
> >+	d->tenable = d->base + register_offset + ADPLL_TENABLE_OFFSET;
> >+	d->tenablediv = d->base + register_offset + ADPLL_TENABLEDIV_OFFSET;
> >+	d->m2ndiv = d->base + register_offset + ADPLL_M2NDIV_OFFSET;
> >+	d->mn2div = d->base + register_offset + ADPLL_MN2DIV_OFFSET;
> >+	d->fracdiv = d->base + register_offset + ADPLL_FRACDIV_OFFSET;
> >+	d->bwctrl = d->base + register_offset + ADPLL_BWCTRL_OFFSET;
> >+	d->status = d->base + register_offset + ADPLL_STATUS_OFFSET;
> >+	d->m3div = d->base + register_offset + ADPLL_M3DIV_OFFSET;
> >+	d->rampctrl = d->base + register_offset + ADPLL_RAMPCTRL_OFFSET;
> 
> Do you need the individual pointers to each of these registers within the
> struct? Seems the offsets are pretty static so could just use d->base +
> offset + MAGIC calculation where used.
> 
> Most of these registers are not used for anything either at the moment it
> seems.

Well I guess I was initially thinking that we can set up separate instances
for the children and don't need locking for the registers.. But all of them
really share the clkctl register so that did not work out.

Yeah I can change these to use offsets no problem.

Regards,

Tony
