From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Tue, 11 Apr 2017 09:24:55 -0700
Message-ID: <20170411162455.GK5339@atomide.com>
References: <20170323170210.GL10760@atomide.com>
 <8648f054-cf04-41df-20f3-82e0d63feefa@ti.com>
 <20170330165448.GF10760@atomide.com>
 <55b439ed-8b81-2e6b-64f1-34f9f3cc5369@ti.com>
 <20170403153604.GI10760@atomide.com>
 <b135c5d6-f06d-030d-333b-5223ef1aca9a@ti.com>
 <20170407164731.GJ13234@atomide.com>
 <6dd4c892-f0b5-f72e-c5e9-357cb8506f05@ti.com>
 <20170410161816.GD5339@atomide.com>
 <74c65472-cc1c-1ab9-7d27-65a164a6f025@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74c65472-cc1c-1ab9-7d27-65a164a6f025@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170410 11:36]:
> On 10/04/17 19:18, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [170410 00:34]:
> > > On 07/04/17 19:47, Tony Lindgren wrote:
> > > > OK hdmi works now on panda for both omapfb and omapdrm. Any ideas why
> > > > that change is now needed though?
> > > 
> > > Yes, it is pretty clear actually. Previously, the hwmod main clock was
> > > controlling the hdmi clock, but this is now rerouted to the clkctrl module
> > > clock, which is shared between all DSS submodules. This leaves the hdmi
> > > clock disabled, causing the failure.
> > > 
> > > The fix just puts the hdmi clock into the optional clocks list, and forces
> > > all the optional clocks on when pm_runtime is enabled for the module.
> > 
> > OK so no need to fix it in the current kernels then.
> 
> Yeah, just need to figure out a clean order of applying these patches. The
> hwmod data change for DSS modules can most likely be applied before the dts
> change for clkctrl is going in, as it is just causing double clk_enable /
> disable for the main clocks in that case.

Yeah no idea about the hwmod change needed for DSS.. Maybe patch it in
only in the no "ti,hwmods" path?

For the rest, how about the following for getting things patched with
a minimal patching needed to revert in case of regressions:

1. Let's add the clkctrl driver and it's dts clocks. Let's tag the
   new clkctrl clocks with status = "disabled" and not add the
   consumers into any existing devices

2. Let's modify the dts files to add the hwmod related items for the
   wrapper IP module but let's keep things probing the old way using
   compatible = "simple-bus" for now

3. Let's add the wrapper IP driver and make sure it does nothing
   except probe the children just like "simple-bus" currently does if
   the child module has the "ti,hwmods" property set

4. Then we can finally start flipping things over one module at a
   time just by removing "ti,hwmods" for the child device and
   status = "disabled" for the related module clock

Regards,

Tony
