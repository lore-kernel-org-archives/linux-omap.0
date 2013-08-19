From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 02/31] CLK: TI: Add DPLL clock support
Date: Mon, 19 Aug 2013 17:24:50 +0100
Message-ID: <20130819162450.GS3719@e106331-lin.cambridge.arm.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-3-git-send-email-t-kristo@ti.com>
 <20130813105042.GJ27165@e106331-lin.cambridge.arm.com>
 <52121EF5.9040706@ti.com>
 <20130819141803.GO3719@e106331-lin.cambridge.arm.com>
 <52123531.4060608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52123531.4060608@ti.com>
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
Cc: "nm@ti.com" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 19, 2013 at 04:09:37PM +0100, Tero Kristo wrote:
> On 08/19/2013 05:18 PM, Mark Rutland wrote:
> > On Mon, Aug 19, 2013 at 02:34:45PM +0100, Tero Kristo wrote:
> >> On 08/13/2013 01:50 PM, Mark Rutland wrote:
> >>> Hi,
> >>>
> >>> On Fri, Aug 02, 2013 at 05:25:21PM +0100, Tero Kristo wrote:
> >>>> The OMAP clock driver now supports DPLL clock type. This patch also
> >>>> adds support for DT DPLL nodes.
> >>>>
> >>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>>> ---
> >>>>    .../devicetree/bindings/clock/ti/dpll.txt          |   70 +++
> >>>>    arch/arm/mach-omap2/clock.h                        |  144 +-----
> >>>>    arch/arm/mach-omap2/clock3xxx.h                    |    2 -
> >>>>    drivers/clk/Makefile                               |    1 +
> >>>>    drivers/clk/ti/Makefile                            |    3 +
> >>>>    drivers/clk/ti/dpll.c                              |  488 ++++++++++++++++++++
> >>>>    include/linux/clk/ti.h                             |  164 +++++++
> >>>>    7 files changed, 727 insertions(+), 145 deletions(-)
> >>>>    create mode 100644 Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>>    create mode 100644 drivers/clk/ti/Makefile
> >>>>    create mode 100644 drivers/clk/ti/dpll.c
> >>>>    create mode 100644 include/linux/clk/ti.h
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>> new file mode 100644
> >>>> index 0000000..dcd6e63
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> >>>> @@ -0,0 +1,70 @@
> >>>> +Binding for Texas Instruments DPLL clock.
> >>>> +
> >>>> +This binding uses the common clock binding[1].  It assumes a
> >>>> +register-mapped DPLL with usually two selectable input clocks
> >>>> +(reference clock and bypass clock), with digital phase locked
> >>>> +loop logic for multiplying the input clock to a desired output
> >>>> +clock. This clock also typically supports different operation
> >>>> +modes (locked, low power stop etc.) This binding has several
> >>>> +sub-types, which effectively result in slightly different setup
> >>>> +for the actual DPLL clock.
> >>>> +
> >>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible : shall be one of:
> >>>> +               "ti,omap4-dpll-x2-clock",
> >>>> +               "ti,omap3-dpll-clock",
> >>>> +               "ti,omap3-dpll-core-clock",
> >>>> +               "ti,omap3-dpll-per-clock",
> >>>> +               "ti,omap3-dpll-per-j-type-clock",
> >>>> +               "ti,omap4-dpll-clock",
> >>>> +               "ti,omap4-dpll-core-clock",
> >>>> +               "ti,omap4-dpll-m4xen-clock",
> >>>> +               "ti,omap4-dpll-j-type-clock",
> >>>> +               "ti,omap4-dpll-no-gate-clock",
> >>>> +               "ti,omap4-dpll-no-gate-j-type-clock",
> >>>> +
> >>>> +- #clock-cells : from common clock binding; shall be set to 0.
> >>>> +- clocks : link phandles of parent clocks (clk-ref and clk-bypass)
> >>>
> >>> It might be a good idea to use clock-names to clarify which clocks are
> >>> present (I notice your examples contain only one clock input).
> >>
> >> All DPLLs have both bypass and reference clocks, but these can be the
> >> same. Is it better to just list both always (and hence drop
> >> clock-names), or provide clock-names always?
> >
> > If they're separate inputs, it's worth listing both (even if they're fed
> > by the same provider). If it's possible one input might not be wired up,
> > use clock-names.
> 
> Ref and bypass clocks are used currently by all DPLLs (also the APLL) so 
> I guess I just enforce both to be specified.

Ok. It's always possible to add clock-names later if a platform doesn't
wire an input. We lose the possibility of future compatibility, but
backwards compatibility is easy enough to maintain.

> >>>> +- ti,clkdm-name : clockdomain name for the DPLL
> >>>
> >>> Could you elaborate on what this is for? What constitutes a valid name?
> >>>
> >>> I'm not sure a string is the best way to define the linkage of several
> >>> elements to a domain...
> >>
> >> Well, I am not sure if we can do this any better at this point, we don't
> >> have DT nodes for clockdomain at the moment (I am not sure if we will
> >> have those either as there are only a handful of those per SoC) but I'll
> >> add some more documentation for this.
> >
> > I'll have to see the documentation, but I'd be very wary of putting that
> > in as-is. Does having the clock domain string link this up to domains in
> > platform data?
> >
> > I'm not sure how well we'll be able to maintain support for that in
> > future if it requires other platform code to use now, and we're not sure
> > how the domains themselves will be represented in dt.
> 
> Hmm so, should I add a stub representation for the clockdomains to the 
> DT then for now or how should this be handled? The stubs could then be 
> mapped to the actual clock domains based on their node names.
> 

I unfortunately don't have a good answer here, because I'm not that
familiar with how we handle clockdomains for power management purposes.

As I understand it, each clock domain is essentially a clock gate
controlling multiple clock signals, so it's possible to describe that
with the common clock bindings, with a domain's clocks all coming from a
"domain-gate-clock" node (or something like that). That would make the
wiring of clocks to a domain explicit and in line with the rest of the
common clock bindings. But perhaps I've simplified things a bit too
far.

I'm not sure how easy it would be to use that information for power
management. I don't know what the kernel logic for clock domain power
management needs to know about consumers of the clocks and how it would
need to poke those consumers.

Cheers,
Mark.
