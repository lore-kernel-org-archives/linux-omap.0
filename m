From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 11/35] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
Date: Thu, 26 Mar 2015 10:30:14 -0700
Message-ID: <20150326173013.GH31346@atomide.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-12-git-send-email-t-kristo@ti.com>
 <5512D069.4080906@ti.com>
 <20150325231659.GD31346@atomide.com>
 <5513B426.1070205@ti.com>
 <5513E59F.3020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40051 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbbCZRee (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 13:34:34 -0400
Content-Disposition: inline
In-Reply-To: <5513E59F.3020204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150326 03:55]:
> On 03/26/2015 09:24 AM, Tero Kristo wrote:
> >On 03/26/2015 01:17 AM, Tony Lindgren wrote:
> >>* Tero Kristo <t-kristo@ti.com> [150325 08:12]:
> >>>
> >>>Splits the clock provider init out of the PRM driver and moves it to
> >>>clock driver. This is needed so that once the PRCM drivers are
> >>>separated,
> >>>they can logically just access the clock driver not needing to go
> >>>through
> >>>common PRM code. This would be wrong in the case of control module for
> >>>example.
> >>...
> >>
> >>>--- a/arch/arm/mach-omap2/clock.c
> >>>+++ b/arch/arm/mach-omap2/clock.c
> >>...
> >>>-u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
> >>>+u32 omap2_clk_memmap_readl(void __iomem *reg)
> >>>  {
> >>>-    u32 val;
> >>>+    struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> >>>
> >>>-    if (clk->flags & MEMMAP_ADDRESSING) {
> >>>-        struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> >>>-        val = readl_relaxed(clk_memmaps[r->index] + r->offset);
> >>>-    } else {
> >>>-        val = readl_relaxed(reg);
> >>>-    }
> >>>+    return readl_relaxed(clk_memmaps[r->index] + r->offset);
> >>>+}
> >>
> >>The cast from void __iomem *reg to struct clk_omap_reg *r looks still
> >>nasty.. Why don't you add the IO address into struct clk_omap_reg:
> >>
> >>struct clk_omap_reg {
> >>    u16 offset;
> >>    u16 index;
> >>    struct regmap *regmap;
> >>    void __iomem *addr;
> >>};
> >>...
> >>
> >>Then populate it during init and then have the clock code use it
> >>directly if available? Then it seems you would not need the
> >>static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS] at all?
> >
> >Doing a change like this should probably be planned, but it is a larger
> >modification. Currently none of the low-level clock APIs support this,
> >but instead expect a direct iomem pointer against which they can do
> >arithmetic operations. The major problem is the companion clocks, which
> >just XOR some bits in the registers to get ICLK / IDLEST register offset
> >from FCLK.
> >
> >So, for now, clock code just uses the void __iomem pointer as a storage
> >class for struct clk_omap_reg, on which arithmetic operations can be done.

Well how about keep the check if (clk->flags & MEMMAP_ADDRESSING) at
least? Maybe WARN_ON(!(clk->flags & MEMMAP_ADDRESSING))?

Otherwise this could be a nightmare to debug if anything goes wrong.
 
> I did this change as a trial, and this is the diff required to get it
> working:
> 
>  arch/arm/mach-omap2/clkt_iclk.c |   20 ++++++++---------
>  arch/arm/mach-omap2/clock.c     |   47
> +++++++++++++++++----------------------
>  arch/arm/mach-omap2/clock.h     |    8 +++----
>  arch/arm/mach-omap2/clock2430.c |    5 +++--
>  arch/arm/mach-omap2/clock34xx.c |   36 ++++++++++++++----------------
>  arch/arm/mach-omap2/clock3517.c |   20 ++++++++---------
>  arch/arm/mach-omap2/cm.h        |    4 +++-
>  arch/arm/mach-omap2/cm2xxx.c    |    9 +++-----
>  arch/arm/mach-omap2/cm3xxx.c    |   10 +++------
>  drivers/clk/ti/clk.c            |   10 +++++----
>  drivers/clk/ti/divider.c        |   24 ++++++++++++++------
>  drivers/clk/ti/dpll.c           |   11 ++++-----
>  drivers/clk/ti/gate.c           |   21 +++++++++++------
>  drivers/clk/ti/interface.c      |    9 ++++----
>  drivers/clk/ti/mux.c            |   22 ++++++++++++------
>  include/linux/clk/ti.h          |    5 +++--
>  16 files changed, 137 insertions(+), 124 deletions(-)
> 
> I think we should probably keep this out of this set now and do this while
> moving the OMAP core clock support code under clock driver... just to keep
> it more easily manageable.

OK fine with me to do that as a follow-up patch.

Regards,

Tony
