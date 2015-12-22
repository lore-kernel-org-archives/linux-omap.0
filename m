From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] clk: ti: Add support for dm814x ADPLL
Date: Tue, 22 Dec 2015 14:18:48 -0800
Message-ID: <20151222221847.GH2793@atomide.com>
References: <1450798030-23680-1-git-send-email-tony@atomide.com>
 <5679B2D6.4050102@ti.com>
 <20151222203224.GG2793@atomide.com>
 <20151222205604.GA14912@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151222205604.GA14912@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [151222 12:56]:
> On 12/22, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [151222 12:28]:
> > > On 12/22/2015 05:27 PM, Tony Lindgren wrote:
> > > >On dm814x we have 13 ADPLLs with 3 to 4 outputs on each. The
> > > >ADPLLs have several dividers and muxes controlled by a shared
> > > >control register for each PLL.
> > > >
> > > >Note that for the clocks to work as device drivers for booting on
> > > >dm814x, this patch depends on "ARM: OMAP2+: Change core_initcall
> > > >levels to postcore_initcall".
> > > >
> > > >Also note that this patch does not implement clk_set_rate for the
> > > >PLL, that will be posted later on when available.
> > > >
> > > >Cc: Michael Turquette <mturquette@baylibre.com>
> > > >Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > >Cc: Tero Kristo <t-kristo@ti.com>
> > > >Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > >---
> > > >
> > > >If no more comments, Tero can you please apply into an immutable
> > > >branch against v4.4-rc1 that I can merge in too?
> > > >
> > > >Changes since v3:
> > > >
> > > >- We want to create the clkdev entry for all clocks, not just outputs
> > > >- ti_adpll_wait_lock loops did not do the right thing
> > > >- We want to use CLK_GET_RATE_NOCACHE in ti_adpll_init_dco
> > > 
> > > I have just one comment below still, once that is addressed:
> > > 
> > > Conditionally-acked-by: Tero Kristo <t-kristo@ti.com>
> > > 
> > > Stephen / Michael, can you pick this up for next merge? I don't have
> > > anything else coming for the window this time, and I am probably going to be
> > > on vacation just nicely to not be able to push anything anyway.
> > 
> > Also, I managed to remove the dependency to the dts changes. So there's
> > no longer any need to set up an immutable branch for this patch.
> 
> Can you split the binding description into a separate patch and send it
> to the dt mailing list? Feel free to add my Ack to it.

OK will do thanks.

> Stephen and I are trying to not take that stuff anymore.

Sure, no problem.

Regards,

Tony
