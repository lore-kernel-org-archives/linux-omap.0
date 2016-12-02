From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Fri, 02 Dec 2016 15:52:21 -0800
Message-ID: <148072274164.32158.6012452044533845688@resonance>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-12-git-send-email-t-kristo@ti.com>
 <20161028005047.GQ26139@codeaurora.org>
 <cd32a554-ba0a-33cd-c15c-121524ce679b@ti.com>
 <20161028125112.xfyrx7l7m64z6cu6@atomide.com>
 <20161028233617.GP16026@codeaurora.org>
 <20161028235448.57squdf6cu2wxxvm@atomide.com>
 <148071802182.32158.11479184984645880313@resonance>
 <20161202231240.GH4705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161202231240.GH4705@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-12-02 15:12:40)
> * Michael Turquette <mturquette@baylibre.com> [161202 14:34]:
> > Quoting Tony Lindgren (2016-10-28 16:54:48)
> > > * Stephen Boyd <sboyd@codeaurora.org> [161028 16:37]:
> > > > On 10/28, Tony Lindgren wrote:
> > > > > * Tero Kristo <t-kristo@ti.com> [161028 00:43]:
> > > > > > On 28/10/16 03:50, Stephen Boyd wrote:
> > > > > > > I suppose a PRCM is
> > > > > > > like an MFD that has clocks and resets under it? On other
> > > > > > > platforms we've combined that all into one node and just had
> > > > > > > #clock-cells and #reset-cells in that node. Is there any reason
> > > > > > > we can't do that here?
> > > > > > 
> > > > > > For OMAPs, there are typically multiple instances of the PRCM around; OMAP4
> > > > > > for example has:
> > > > > > 
> > > > > > cm1 @ 0x4a004000 (clocks + clockdomains)
> > > > > > cm2 @ 0x4a008000 (clocks + clockdomains)
> > > > > > prm @ 0x4a306000 (few clocks + resets + power state handling)
> > > > > > scrm @ 0x4a30a000 (few external clocks + plenty of misc stuff)
> > > > > > 
> > > > > > These instances are also under different power/voltage domains which means
> > > > > > their PM behavior is different.
> > > > > > 
> > > > > > The idea behind having a clockdomain as a provider was mostly to have the
> > > > > > topology visible : prcm-instance -> clockdomain -> clocks
> > > > > 
> > > > > Yeah that's needed to get the interconnect hierarchy right for
> > > > > genpd :)
> > > > > 
> > > > > > ... but basically I think it would be possible to drop the clockdomain
> > > > > > representation and just mark the prcm-instance as a clock provider. Tony,
> > > > > > any thoughts on that?
> > > > > 
> > > > > No let's not drop the clockdomains as those will be needed when we
> > > > > move things into proper hierarchy within the interconnect instances.
> > > > > This will then help with getting things right with genpd.
> > > > > 
> > > > > In the long run we just want to specify clockdomain and the offset of
> > > > > the clock instance within the clockdomain in the dts files.
> > > > > 
> > > > 
> > > > Sorry, I have very little idea how OMAP hardware works. Do you
> > > > mean that you will have different nodes for each clockdomain so
> > > > that genpd can map 1:1 to the node in dts? But in hardware
> > > > there's a prcm that allows us to control many clock domains
> > > > through register read/writes? How is the interconnect involved?
> > > 
> > > There are multiple clockdomains, at least one for each interconnect
> > > instance. Once a clockdomain is idle, the related interconnect can
> > > idle too. So yeah genpd pretty much maps 1:1 with the clockdomains.
> > > 
> > > There's more info in for example omap4 TRM section "3.4.1 Device
> > > Power-Management Layout" that shows the voltage/power/clock domains.
> > > The interconnect instances are mostly named there too looking at
> > > the L4/L3 naming.
> > 
> > I'm confused on two points:
> > 
> > 1) why are the clkdm's acting as clock providers? I've always hated the
> > name "clock domain" since those bits are for managing module state, not
> > clock state. The PRM, CM1 and CM2 provide the clocks, not the
> > clockdomains.
> 
> The clock domains have multiple clock inputs that are routed to multiple
> child clocks. So it is a clock :)
> 
> See for example omap4430 TRM "3.6.4 CD_WKUP Clock Domain" on page
> 393 in my revision here.
> 
> On that page "Figure 3-48" shows CD_WKUP with the four input clocks.
> And then "Table 3-84. CD_WKUP Control and Status Parameters" shows
> the CD_WKUP clock domain specific registers. These registers show
> the status, I think they are all read-only registers. Then CD_WKUP
> has multiple child clocks with configurable registers.
> 
> From hardware register point of view, each clock domain has:
> 
> - Read-only clockdomain status registers in the beginning of
>   the address space
> 
> - Multiple similar clock instances register instances each
>   mapping to a specific interconnect target module
> 
> These are documented in "3.11.16.1 WKUP_CM Register Summary".

Oh, this is because you are treating the MODULEMODE bits like gate
clocks. I never really figured out if this was the best way to model
those bits since they do more than control a line toggling at a rate.
For instance this bit will affect the master/slave IDLE protocol between
the module and the PRCM.

> 
> From hardware point of view, we ideally want to map interconnect
> target modules to the clock instance offset from the clock domain
> for that interconnect segment. For example gptimer1 clocks would
> be just:
> 
> clocks = <&cd_wkup 0x40>;
> 
> > 2) why aren't the clock domains modeled as genpds with their associated
> > devices attached to them? Note that it is possible to "nest" genpd
> > objects. This would also allow for the "Clockdomain Dependency"
> > relationships to be properly modeled (see section 3.1.1.1.7 Clock Domain
> > Dependency in the OMAP4 TRM).
> 
> Clock domains only route clocks to child clocks. Power domains
> are different registers. The power domains map roughly to
> interconnect instances, there we have registers to disable the
> whole interconnect when idle.

I'm not talking about power islands at all, but the genpd object in
Linux. For instance, if we treat each clock domain like a clock
provider, how could the functional dependency between clkdm_A and
clkdm_B be asserted?

There is certainly no API for that in the clock framework, but for genpd
your runtime_pm_get() callback for clkdm_A could call runtime_pm_get
against clkdm_B, which would satisfy the requirement. See section
3.1.1.1.7 Clock Domain Dependency in the OMAP4 TRM, version AB.

Regards,
Mike

> 
> Regards,
> 
> Tony
