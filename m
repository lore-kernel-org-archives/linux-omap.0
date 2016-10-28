From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Fri, 28 Oct 2016 16:54:48 -0700
Message-ID: <20161028235448.57squdf6cu2wxxvm@atomide.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-12-git-send-email-t-kristo@ti.com>
 <20161028005047.GQ26139@codeaurora.org>
 <cd32a554-ba0a-33cd-c15c-121524ce679b@ti.com>
 <20161028125112.xfyrx7l7m64z6cu6@atomide.com>
 <20161028233617.GP16026@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161028233617.GP16026@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Stephen Boyd <sboyd@codeaurora.org> [161028 16:37]:
> On 10/28, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [161028 00:43]:
> > > On 28/10/16 03:50, Stephen Boyd wrote:
> > > > I suppose a PRCM is
> > > > like an MFD that has clocks and resets under it? On other
> > > > platforms we've combined that all into one node and just had
> > > > #clock-cells and #reset-cells in that node. Is there any reason
> > > > we can't do that here?
> > > 
> > > For OMAPs, there are typically multiple instances of the PRCM around; OMAP4
> > > for example has:
> > > 
> > > cm1 @ 0x4a004000 (clocks + clockdomains)
> > > cm2 @ 0x4a008000 (clocks + clockdomains)
> > > prm @ 0x4a306000 (few clocks + resets + power state handling)
> > > scrm @ 0x4a30a000 (few external clocks + plenty of misc stuff)
> > > 
> > > These instances are also under different power/voltage domains which means
> > > their PM behavior is different.
> > > 
> > > The idea behind having a clockdomain as a provider was mostly to have the
> > > topology visible : prcm-instance -> clockdomain -> clocks
> > 
> > Yeah that's needed to get the interconnect hierarchy right for
> > genpd :)
> > 
> > > ... but basically I think it would be possible to drop the clockdomain
> > > representation and just mark the prcm-instance as a clock provider. Tony,
> > > any thoughts on that?
> > 
> > No let's not drop the clockdomains as those will be needed when we
> > move things into proper hierarchy within the interconnect instances.
> > This will then help with getting things right with genpd.
> > 
> > In the long run we just want to specify clockdomain and the offset of
> > the clock instance within the clockdomain in the dts files.
> > 
> 
> Sorry, I have very little idea how OMAP hardware works. Do you
> mean that you will have different nodes for each clockdomain so
> that genpd can map 1:1 to the node in dts? But in hardware
> there's a prcm that allows us to control many clock domains
> through register read/writes? How is the interconnect involved?

There are multiple clockdomains, at least one for each interconnect
instance. Once a clockdomain is idle, the related interconnect can
idle too. So yeah genpd pretty much maps 1:1 with the clockdomains.

There's more info in for example omap4 TRM section "3.4.1 Device
Power-Management Layout" that shows the voltage/power/clock domains.
The interconnect instances are mostly named there too looking at
the L4/L3 naming.

Regards,

Tony
