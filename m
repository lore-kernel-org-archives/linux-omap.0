From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 1/8] RFC: CLK: OMAP: Add basic infrastructure for OMAP
 clocks
Date: Fri, 22 Mar 2013 10:39:08 +0200
Message-ID: <1363941548.15426.181.camel@sokoban>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
	 <1363887347-4686-2-git-send-email-t-kristo@ti.com>
	 <20130321185051.834.97551@quantum>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932350Ab3CVIjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 04:39:15 -0400
In-Reply-To: <20130321185051.834.97551@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, 2013-03-21 at 11:50 -0700, Mike Turquette wrote:
> Quoting Tero Kristo (2013-03-21 10:35:40)
> > This patch adds basic infrastructure support for registering clocks
> > under common clock framework. This patch is done in preparation for
> > moving clock data from arch/arm/mach-omap2/ folder under /drivers/clk/omap.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> 
> Thanks for taking a crack at this Tero!  This is a great step towards
> getting rid of clk-private.h.

Hi Mike,

Thanks for the quick comments.

> 
> Regarding the long-term roadmap of the omap clock code:
> 
> In general all of the changes to the omap clock code for using the
> common struct clk have been very incremental.  We still have the old
> legacy struct clk definition, the name of that struct was changed to
> clk_hw_omap, but it is still a fairly large, monolithic structure.  Are
> there plans to break the clock types up into smaller, more focused clock
> types?  E.g. get rid of struct dpll_data and have a dedicated dpll clock
> type.

I think this sounds like a fair approach to me, currently the struct is
huge and we register almost everything under it. This RFC set only tries
to tackle with the most immediate problem, removing the dependency to
clk-private.h and moving the clock data out from mach-omap2.

> 
> The question above is not reason to block this patch since it is a
> fairly large refactoring effort, but it is something to consider.
> 
> Some comments below.
> 
> <snip>
> 
> > +struct omap_clk {
> > +       u16                             cpu;
> > +       const char                      *dev_id;
> > +       const char                      *con_id;
> > +       struct omap_init_clk            *clk;
> > +};
> > +
> > +#define CLK(dev, con, ck, cp)          \
> > +       {                               \
> > +               .cpu = cp,              \
> > +               .dev_id = dev,          \
> > +               .con_id = con,          \
> > +               .clk = ck,              \
> > +       }       
> > +
> 
> IS omap_clk and CLK really necessary today?  I thought that the move to
> separate clocks out by tables got rid of this macro/structure?

Well, it looks like we have a few clocks which actually use same clock
nodes, like dpll_mpu_ck is declared twice with different dev / con ids
here. It is possible to get rid of this in most cases and incorporate
the data from omap_clk to the omap_init_clk. Maybe for the special cases
we can just add a static clk registration in the code.

> 
> > +#define OMAP_CLK_FIXED_RATE(_name, _flags, _rate, _ignore)     \
> > +       static struct omap_init_clk _name __initdata = {        \
> > +               .name = #_name,                                 \
> > +               .clk_flags = _flags,                            \
> > +               .rate = _rate,                                  \
> > +               .clk_register = omap_clk_register_fixed_rate,   \
> > +       };
> > +
> 
> These macros are unreadable.  They were originally born out of the nasty
> clk-private.h stuff which included forward declarations of struct clk
> and all sorts of ugliness.  I know it saves you LoC to use them now but
> I really prefer to use designated initializers for the sake of
> readability.  Do you plan to convert the OMAP clock code back to how it
> was, pre-macros?

Yea, I think we should do this eventually once we also split the
different clock types to their own init structs. Then we can get rid of
these macros at the same point. However, I decided not to do this at
this step, as this simple data conversion allows us to convert also
omap2 / omap3 clocks rather easily, for which we don't have auto
generation available.

-Tero


