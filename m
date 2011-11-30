From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 11/15] omap3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
Date: Wed, 30 Nov 2011 12:11:12 +0200
Message-ID: <1322647872.21753.18.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-12-git-send-email-t-kristo@ti.com>
	 <CAORVsuVMaEZBSPpQ8-jCju7hfCMBFkQ9r2z_ArT-b4dN0pqbcg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34693 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab1K3KLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 05:11:16 -0500
In-Reply-To: <CAORVsuVMaEZBSPpQ8-jCju7hfCMBFkQ9r2z_ArT-b4dN0pqbcg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

On Wed, 2011-11-30 at 10:52 +0100, Jean Pihet wrote:
> Hi Tero,
> 
> On Fri, Nov 25, 2011 at 4:49 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > This patch fixes the usecount tracking for omap3+, previously the
> > usecount numbers were rather bogus and were not really useful for
> > any purpose. Now usecount numbers track the number of really active
> > clients on each domain. This patch also adds support for usecount
> > tracking on powerdomain and voltagedomain levels.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/clkt_iclk.c         |   11 +++++++++
> >  arch/arm/mach-omap2/clockdomain.c       |   38 +++++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/clockdomain.h       |    3 ++
> >  arch/arm/mach-omap2/powerdomain.c       |   12 +++++++++
> >  arch/arm/mach-omap2/powerdomain.h       |    5 ++++
> >  arch/arm/mach-omap2/voltage.c           |   30 ++++++++++++++++++++++++
> >  arch/arm/mach-omap2/voltage.h           |    7 +++++
> >  arch/arm/plat-omap/clock.c              |    2 +
> >  arch/arm/plat-omap/include/plat/clock.h |    1 +
> >  9 files changed, 107 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
> > index 3d43fba..8e61776 100644
> > --- a/arch/arm/mach-omap2/clkt_iclk.c
> > +++ b/arch/arm/mach-omap2/clkt_iclk.c
> > @@ -21,6 +21,7 @@
> >  #include "clock2xxx.h"
> >  #include "cm2xxx_3xxx.h"
> >  #include "cm-regbits-24xx.h"
> > +#include "clockdomain.h"
> >
> >  /* Private functions */
> >
> > @@ -34,6 +35,11 @@ void omap2_clkt_iclk_allow_idle(struct clk *clk)
> >        v = __raw_readl((__force void __iomem *)r);
> >        v |= (1 << clk->enable_bit);
> >        __raw_writel(v, (__force void __iomem *)r);
> > +
> > +       if (clk->usecount && clk->clkdm)
> > +               clkdm_usecount_dec(clk->clkdm);
> Is the test on clk->usecount needed? Is that a problem when usecount reaches 0?

Yea, this check is needed because we don't really know whether the clock
is active or not when allow_idle is called. If it is active, we want to
decrease the clkdm usecount as this clock has increased the usecount on
that domain when it was enabled, otherwise not.

> 
> > +
> > +       clk->autoidle = 1;
> >  }
> >
> >  /* XXX */
> > @@ -46,6 +52,11 @@ void omap2_clkt_iclk_deny_idle(struct clk *clk)
> >        v = __raw_readl((__force void __iomem *)r);
> >        v &= ~(1 << clk->enable_bit);
> >        __raw_writel(v, (__force void __iomem *)r);
> > +
> > +       if (clk->usecount && clk->clkdm)
> > +               clkdm_usecount_inc(clk->clkdm);
> Same here.

Same deal, but other way around.

-Tero

> 
> > +
> > +       clk->autoidle = 0;
> >  }
> >
> >  /* Public data */
> ...
> 
> Regards,
> Jean


