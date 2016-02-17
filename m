From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] clk: ti: Add support for dm814x ADPLL
Date: Wed, 17 Feb 2016 13:20:46 -0800
Message-ID: <20160217212045.GE21202@atomide.com>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-3-git-send-email-tony@atomide.com>
 <20160217011930.2278.38316@quark.deferred.io>
 <20160217173949.GB21202@atomide.com>
 <20160217205257.2278.11639@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160217205257.2278.11639@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [160217 12:53]:
> Quoting Tony Lindgren (2016-02-17 09:39:49)
> > * Michael Turquette <mturquette@baylibre.com> [160216 17:32]:
> > > 
> > > We have a shiny new series that provides a standard way to do this:
> > > 
> > > http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>
> > 
> > OK nice, so tagging the MPU and DDR clocks with CLK_IS_CRITICAL or
> > "clock-critical" should allow removing this code. I think in this
> > case I still need to set CLK_IS_CRITICAL as the clock is output 1
> > of the dts defined clock and does not have a separate dts node.
> 
> In fact I hate clock-critical as a DT property and it's only there to
> support legacy DT bindings that store all clk data in DT and have zero
> clk data in C. So please use the CLK_IS_CRITICAL or CLK_ENABLE_HAND_OFF
> flags in C.
> 
> Do you think you will ever have a driver that wants to gate these
> clocks? Probably not for MPU/DDR, but the HAND_OFF flag is a better fit
> if you do. It's the same as CRITICAL but transfers the prepare/enable
> reference counting to the consumer driver after that driver calls
> clk_get() and clk_prepare_enable() on the HAND_OFF clk.

OK I'll use CLK_ENABLE_HAND_OFF then. Who knows maybe somebody
somewhere has code running on one of the coprocessors in SRAM that
actually allows gating these :)

> > I can update when those patches hit Linux next, or I can do a
> > follow-up patch later on if we want to avoid the dependency
> > here. Which do you prefer?
> 
> Well, testing is always welcome :-)
>
> If you rebase onto those patches then I'll add your patches to that
> series for testing and merge it that way.

OK will do and repost after some testing.

Regards,

Tony
