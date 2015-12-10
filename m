From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] clk: ti: Add support for dm814x ADPLL
Date: Thu, 10 Dec 2015 10:04:00 -0800
Message-ID: <20151210180400.GG23396@atomide.com>
References: <1449106504-7645-1-git-send-email-tony@atomide.com>
 <1449106504-7645-2-git-send-email-tony@atomide.com>
 <20151203160712.GM23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151203160712.GM23396@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [151203 08:08]:
> * Tony Lindgren <tony@atomide.com> [151202 17:36]:
> > On dm814x we have 13 ADPLLs with 3 to 4 outputs on each. The
> > ADPLLs have several dividers and muxes controlled by a shared
> > control register for each PLL.
> > 
> > Note that for the clocks to work as device drivers for booting on
> > dm814x, this patch depends on "ARM: OMAP2+: Change core_initcall
> > levels to postcore_initcall".
> > 
> > Also note that this patch does not implement clk_set_rate,
> > that will be posted later on when available.
> 
> Mike & Stephen, after review, can we have this patch alone in an
> immutable branch against v4.4-rc1 that I can merge in too?

Matthijs wanted to rename adpllj naming to adpll_lj and remove remaining
fapll references, so I'll do that today and repost this series.

Tero, do you have any comments on this one? After repost, do you want
to take this into your clock branch and send a pull request to
Mike & Stephen along with other omap clock changes?

> Also, the dts changes I need to queue separately FYI to avoid merge
> conflicts.

I'd still like to have just this clock driver patch alone in an
immutable branch that I can merge in too. Otherwise we'll get oopses
during booting when devices are being added.

Regards,

Tony
