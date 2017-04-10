From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Mon, 10 Apr 2017 09:18:16 -0700
Message-ID: <20170410161816.GD5339@atomide.com>
References: <94d20a17-5072-ffab-3529-4bbb14327a10@ti.com>
 <20170323010057.GI10760@atomide.com>
 <20170323170210.GL10760@atomide.com>
 <8648f054-cf04-41df-20f3-82e0d63feefa@ti.com>
 <20170330165448.GF10760@atomide.com>
 <55b439ed-8b81-2e6b-64f1-34f9f3cc5369@ti.com>
 <20170403153604.GI10760@atomide.com>
 <b135c5d6-f06d-030d-333b-5223ef1aca9a@ti.com>
 <20170407164731.GJ13234@atomide.com>
 <6dd4c892-f0b5-f72e-c5e9-357cb8506f05@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6dd4c892-f0b5-f72e-c5e9-357cb8506f05@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170410 00:34]:
> On 07/04/17 19:47, Tony Lindgren wrote:
> > OK hdmi works now on panda for both omapfb and omapdrm. Any ideas why
> > that change is now needed though?
> 
> Yes, it is pretty clear actually. Previously, the hwmod main clock was
> controlling the hdmi clock, but this is now rerouted to the clkctrl module
> clock, which is shared between all DSS submodules. This leaves the hdmi
> clock disabled, causing the failure.
> 
> The fix just puts the hdmi clock into the optional clocks list, and forces
> all the optional clocks on when pm_runtime is enabled for the module.

OK so no need to fix it in the current kernels then.

Thanks,

Tony
