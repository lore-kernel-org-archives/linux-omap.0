From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: Fix FAPLL udelay in clk_enable with clk_prepare
Date: Wed, 23 Sep 2015 08:38:12 -0700
Message-ID: <20150923153812.GF23801@atomide.com>
References: <1442956985-32642-1-git-send-email-tony@atomide.com>
 <560242EB.5070001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560242EB.5070001@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150922 23:17]:
> Tony,
> 
> On 09/23/2015 12:23 AM, Tony Lindgren wrote:
> > As recently pointed out (again) by Thomas and Russell, we must not
> > wait in in clk_enable. The wait for PLL to lock needs to happen
> > in clk_prepare instead.
> > 
> > It seems this is a common copy paste error with the PLL drivers,
> > and similar fixes should be applied to other PLL drivers after
> > testing.
> 
> One thing to note:
> because of how the hwmod code works, at boot time we prepare all clocks for
> the devices and in runtime the hwmod only uses clk_enable/disable, it will
> never unprepare the clock(s). This will means that these clocks will be
> enabled all the time and will never turned off.

Good point, we need to check that for hwmod pm_runtime related
functions. Basically the PLLs we can't disable until in
pm_runtime_disable.

I think the approach we need to take to be that clk_enable/disable
is really optional clk_gate_enable/disable. And in many cases PLLs
don't have a gate, so it's correct for pm_runtime enable/disable
to not do anything for the PLLs.

And the reason we don't want to change pm_runtime hooks to use
clk_prepare_enable/disable is that then drivers can't use
pm_runtime_irq_safe like some do currently.

Regards,

Tony
