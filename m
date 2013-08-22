From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv5 02/31] CLK: TI: Add DPLL clock support
Date: Thu, 22 Aug 2013 01:04:07 -0700
Message-ID: <20130822080407.8231.53331@quantum>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-3-git-send-email-t-kristo@ti.com>
 <20130813105042.GJ27165@e106331-lin.cambridge.arm.com>
 <52121EF5.9040706@ti.com>
 <20130819141803.GO3719@e106331-lin.cambridge.arm.com>
 <52123531.4060608@ti.com>
 <20130819162450.GS3719@e106331-lin.cambridge.arm.com>
 <5212509F.9030608@ti.com> <20130819220006.4443.23042@quantum>
 <5214E7ED.80909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5214E7ED.80909@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "nm@ti.com" <nm@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2013-08-21 09:16:45)
> On 08/20/2013 01:00 AM, Mike Turquette wrote:
> > Quoting Tero Kristo (2013-08-19 10:06:39)
> >> On 08/19/2013 07:24 PM, Mark Rutland wrote:
> >>> On Mon, Aug 19, 2013 at 04:09:37PM +0100, Tero Kristo wrote:
> >>>> On 08/19/2013 05:18 PM, Mark Rutland wrote:
> >>>>> On Mon, Aug 19, 2013 at 02:34:45PM +0100, Tero Kristo wrote:
> >>>>>> On 08/13/2013 01:50 PM, Mark Rutland wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On Fri, Aug 02, 2013 at 05:25:21PM +0100, Tero Kristo wrote:
> >>>>>>>> The OMAP clock driver now supports DPLL clock type. This patch also
> >>>>>>>> adds support for DT DPLL nodes.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>>>>>>> ---
> >>>>>>>>      .../devicetree/bindings/clock/ti/dpll.txt          |   70 +++
> >>>>>>>>      arch/arm/mach-omap2/clock.h                        |  144 +-----
> >>>>>>>>      arch/arm/mach-omap2/clock3xxx.h                    |    2 -
> >>>>>>>>      drivers/clk/Makefile                               |    1 +
> >>>>>>>>      drivers/clk/ti/Makefile                            |    3 +
> >>>>>>>>      drivers/clk/ti/dpll.c                              |  488 ++++++++++++++++++++
> >>>>>>>>      include/linux/clk/ti.h                             |  164 +++++++
> >>>>>>>>      7 files changed, 727 insertions(+), 145 deletions(-)
> >>>>>>>>      create mode 100644 Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>>>>>>      create mode 100644 drivers/clk/ti/Makefile
> >>>>>>>>      create mode 100644 drivers/clk/ti/dpll.c
> >>>>>>>>      create mode 100644 include/linux/clk/ti.h
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>>>>>> new file mode 100644
> >>>>>>>> index 0000000..dcd6e63
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>>>>>> @@ -0,0 +1,70 @@
> >>>>>>>> +Binding for Texas Instruments DPLL clock.
> >>>>>>>> +
> >>>>>>>> +This binding uses the common clock binding[1].  It assumes a
> >>>>>>>> +register-mapped DPLL with usually two selectable input clocks
> >>>>>>>> +(reference clock and bypass clock), with digital phase locked
> >>>>>>>> +loop logic for multiplying the input clock to a desired output
> >>>>>>>> +clock. This clock also typically supports different operation
> >>>>>>>> +modes (locked, low power stop etc.) This binding has several
> >>>>>>>> +sub-types, which effectively result in slightly different setup
> >>>>>>>> +for the actual DPLL clock.
> >>>>>>>> +
> >>>>>>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>>>>>>> +
> >>>>>>>> +Required properties:
> >>>>>>>> +- compatible : shall be one of:
> >>>>>>>> +               "ti,omap4-dpll-x2-clock",
> >>>>>>>> +               "ti,omap3-dpll-clock",
> >>>>>>>> +               "ti,omap3-dpll-core-clock",
> >>>>>>>> +               "ti,omap3-dpll-per-clock",
> >>>>>>>> +               "ti,omap3-dpll-per-j-type-clock",
> >>>>>>>> +               "ti,omap4-dpll-clock",
> >>>>>>>> +               "ti,omap4-dpll-core-clock",
> >>>>>>>> +               "ti,omap4-dpll-m4xen-clock",
> >>>>>>>> +               "ti,omap4-dpll-j-type-clock",
> >>>>>>>> +               "ti,omap4-dpll-no-gate-clock",
> >>>>>>>> +               "ti,omap4-dpll-no-gate-j-type-clock",
> >>>>>>>> +
> >>>>>>>> +- #clock-cells : from common clock binding; shall be set to 0.
> >>>>>>>> +- clocks : link phandles of parent clocks (clk-ref and clk-bypass)
> >>>>>>>
> >>>>>>> It might be a good idea to use clock-names to clarify which clocks are
> >>>>>>> present (I notice your examples contain only one clock input).
> >>>>>>
> >>>>>> All DPLLs have both bypass and reference clocks, but these can be the
> >>>>>> same. Is it better to just list both always (and hence drop
> >>>>>> clock-names), or provide clock-names always?
> >>>>>
> >>>>> If they're separate inputs, it's worth listing both (even if they're fed
> >>>>> by the same provider). If it's possible one input might not be wired up,
> >>>>> use clock-names.
> >>>>
> >>>> Ref and bypass clocks are used currently by all DPLLs (also the APLL) so
> >>>> I guess I just enforce both to be specified.
> >>>
> >>> Ok. It's always possible to add clock-names later if a platform doesn't
> >>> wire an input. We lose the possibility of future compatibility, but
> >>> backwards compatibility is easy enough to maintain.
> >>>
> >>>>>>>> +- ti,clkdm-name : clockdomain name for the DPLL
> >>>>>>>
> >>>>>>> Could you elaborate on what this is for? What constitutes a valid name?
> >>>>>>>
> >>>>>>> I'm not sure a string is the best way to define the linkage of several
> >>>>>>> elements to a domain...
> >>>>>>
> >>>>>> Well, I am not sure if we can do this any better at this point, we don't
> >>>>>> have DT nodes for clockdomain at the moment (I am not sure if we will
> >>>>>> have those either as there are only a handful of those per SoC) but I'll
> >>>>>> add some more documentation for this.
> >>>>>
> >>>>> I'll have to see the documentation, but I'd be very wary of putting that
> >>>>> in as-is. Does having the clock domain string link this up to domains in
> >>>>> platform data?
> >>>>>
> >>>>> I'm not sure how well we'll be able to maintain support for that in
> >>>>> future if it requires other platform code to use now, and we're not sure
> >>>>> how the domains themselves will be represented in dt.
> >>>>
> >>>> Hmm so, should I add a stub representation for the clockdomains to the
> >>>> DT then for now or how should this be handled? The stubs could then be
> >>>> mapped to the actual clock domains based on their node names.
> >
> > I'm not sure that this binding should know about the clock domain at
> > all. Maybe the clock domain binding should list the clocks that are
> > within the domain?
> 
> Ok, I experimented with this stuff a bit to have a proper reply, and it 
> looks like I can get this done with a clockdomain mapping, which has its 
> own binding. Something like this:
> 
>          clockdomains {
>                  usbhost_clkdm: usbhost_clkdm {
>                          compatible = "ti,clockdomain";
>                          clocks = <&usbhost_48m_fck>, <&usbhost_ick>;
>                  };
>         };

Cool, this is much closer to what I had in mind. I guess the clock
domain DT binding can be marked as "Unstable - ABI compatibility may be
broken in the future" since the binding isn't really fleshed out yet.

> 
> Mike, what is your approach on this? Are you okay having the 
> implementation for this under drivers/clk? I recall you mentioned 
> earlier that you don't want clockdomain stuff under drivers/clk, hence I 
> am asking.

I do not want them to live there permanently. There has been some talk
about drivers/syscon/ or whatever for a while now, but this clkdm stuff
is also not a good candidate for that since none of the clkdm bits here
are really fleshed out with an eye towards a reusable core framework.
Maybe someday though...

I guess I could take it into drivers/clk/ti/ on a temporary basis, with
a commitment to move it out when the right driver infrastructure for
clock domains comes along.

Regards,
Mike

> 
> Here is the initial implementation for the binding:
> 
> void __init of_omap_clockdomain_setup(struct device_node *node)
> {
>          struct clk *clk;
>          struct clk_hw *clk_hw;
>          const char *clkdm_name = node->name;
>          int i;
>          int num_clks;
> 
>          num_clks = of_count_phandle_with_args(node, "clocks", 
> "#clock-cells");
> 
>          for (i = 0; i < num_clks; i++) {
>                  clk = of_clk_get(node, i);
>                  if (__clk_get_flags(clk) & CLK_IS_BASIC) {
>                          pr_warn("%s: can't setup clkdm for basic clk %s\n",
>                                  __func__, __clk_get_name(clk));
>                          continue;
>                  }
>                  clk_hw = __clk_get_hw(clk);
>                  to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
>                  omap2_init_clk_clkdm(clk_hw);
>          }
> }
> CLK_OF_DECLARE(omap_clockdomain, "ti,clockdomain", 
> of_omap_clockdomain_setup);
> 
> >
> >>>>
> >>>
> >>> I unfortunately don't have a good answer here, because I'm not that
> >>> familiar with how we handle clockdomains for power management purposes.
> >>>
> >>> As I understand it, each clock domain is essentially a clock gate
> >>> controlling multiple clock signals, so it's possible to describe that
> >>> with the common clock bindings, with a domain's clocks all coming from a
> >>> "domain-gate-clock" node (or something like that). That would make the
> >>> wiring of clocks to a domain explicit and in line with the rest of the
> >>> common clock bindings. But perhaps I've simplified things a bit too
> >>> far.
> >>
> >> You got it basically right, but maybe oversimplified it a bit. The
> >> root/parent clocks can still cross clockdomain boundaries, so mapping
> >> everything under a simple clockdomain gate would not work. Basically
> >> each clock has a mapping on the SoC for both its parent clock signal and
> >> the clockdomain association, kind of having two parents at the same
> >> time. In OMAP case, most of the clockdomains support hardware autoidle
> >> type functionality, which puts the domain to idle once all the clocks on
> >> it are disabled.
> >
> > I always thought that OMAP clock domains were poorly named. Seems to me
> > that they had more to do with the IP/module programming than clocks per
> > se.  Again, I'm not sure that putting clkdm data into this binding is
> > correct.
> >
> > Is it because you want a call to clk_enable to program the clock domain
> > in the .enable callback? I always thought that this was better left to a
> > pm_runtime_get callback...
> 
> My guess is that some clocks require the clockdomain itself to be forced 
> on before they are enabled, some of the DPLLs do this for example. I am 
> just trying not to cause any regressions with this set, thus attempting 
> to keep most of the implementation specifics intact.
> 
> -Tero
> 
> >
> > Regards,
> > Mike
> >
> >>
> >> -Tero
> >>
> >>> I'm not sure how easy it would be to use that information for power
> >>> management. I don't know what the kernel logic for clock domain power
> >>> management needs to know about consumers of the clocks and how it would
> >>> need to poke those consumers.
> >>
> >>>
> >>> Cheers,
> >>> Mark.
> >>>
