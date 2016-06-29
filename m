From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCHv2 04/28] ARM: OMAP2+: hwmod: use new ti_clk_get
 API to search for clock handles
Date: Wed, 29 Jun 2016 00:01:50 -0700
Message-ID: <20160629070149.GI28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-5-git-send-email-t-kristo@ti.com>
 <20160628065712.GC28140@atomide.com>
 <577367CB.6090703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <577367CB.6090703@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160628 23:19]:
> On 28/06/16 09:57, Tony Lindgren wrote:
> > Hi,
> > 
> > * Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> > > The new API avoids the need to add clock aliases for most of the clocks,
> > > should use of it is preferred. Many of the existing clock aliases are
> > > only created because of hwmod data.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > ---
> > >   arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> > > index 83cb527..0ea869c 100644
> > > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > > @@ -786,7 +786,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
> > >   	if (!oh->main_clk)
> > >   		return 0;
> > > 
> > > -	oh->_clk = clk_get(NULL, oh->main_clk);
> > > +	oh->_clk = ti_clk_get(oh->main_clk);
> > >   	if (IS_ERR(oh->_clk)) {
> > >   		pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
> > >   			oh->name, oh->main_clk);
> > 
> > After thinking about this for a while I think code outside TI specific
> > clock implementation should use just clk_get(). Otherwise we create more
> > dependencies to move code to live under drivers subdirectory.
> > 
> > Can't we have clk_get() call a SoC specific helper function if clock
> > is not found?
> 
> That is for Mike / Stephen to answer. Implementing something like this
> sounds trivial, I could just hook up the ti_clk_get being called here.
> However, any attempted changes to the clkdev implementation have been shot
> down so far, thus I did this.

Probably best to send a minimal patch for that for review. We want to
have the clock framework consumers using the standard interface.

> The problem is still the clocks which are just referred via a name only, not
> via a DT node.

OK

Regards,

Tony
