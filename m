From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCHv12 07/49] clk: divider: add support for low level ops
Date: Sat, 4 Jan 2014 17:48:05 +0100
Message-ID: <20140104164805.GG20094@book.gsilab.sittig.org>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
 <1387557274-22583-7-git-send-email-t-kristo@ti.com>
 <20131222175235.GC8064@book.gsilab.sittig.org>
 <52C6800F.3090303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49382 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbaADQsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jan 2014 11:48:15 -0500
Content-Disposition: inline
In-Reply-To: <52C6800F.3090303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 03, 2014 at 11:17 +0200, Tero Kristo wrote:
> 
> On 12/22/2013 07:52 PM, Gerhard Sittig wrote:
> >[ dropped devicetree, we're clock specific here ]
> >
> >On Fri, Dec 20, 2013 at 18:34 +0200, Tero Kristo wrote:
> >>
> >>Divider clock can now be registered to use low level register access ops.
> >>Preferred initialization method is via clock description.
> >>
> >>Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>---
> >>  drivers/clk/clk-divider.c    |   22 +++++++++++++++++++---
> >>  include/linux/clk-provider.h |    4 ++++
> >>  2 files changed, 23 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> >>index 8cfed5c..887e2d8 100644
> >>--- a/drivers/clk/clk-divider.c
> >>+++ b/drivers/clk/clk-divider.c
> >>@@ -108,7 +108,12 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >>  	struct clk_divider *divider = to_clk_divider(hw);
> >>  	unsigned int div, val;
> >>
> >>-	val = clk_readl(divider->reg) >> divider->shift;
> >>+	if (divider->ll_ops)
> >>+		val = divider->ll_ops->clk_readl(divider->reg);
> >>+	else
> >>+		val = clk_readl(divider->reg);
> >
> >Should this not better always use an ll_ops structure, which
> >either is individual to the clock item, or is "global" for a
> >platform, yet can get re-registered at runtime (see the comment
> >on 06/49)?  And why are you referencing clk_readl() instead of
> >clk_readl_default() which you specifically have introduced in the
> >previous patch?  Adding a copy of the routine and using both the
> >copy and the original doesn't look right.
> 
> In some cases, the clock data is defined statically during compile
> time and here, ll_ops can be (and for OMAP cases at least is) NULL.
> I had kind of a global ll_ops definition in some of the earlier
> versions of this series, but it was frowned upon by some of the
> maintainers thus I dropped it.

Well, admittedly v11 was the first version that I have
seen/noticed.  But the static declaration you talk about and the
ll_ops potentially being NULL was discussed there.  My response
was about replacing the above clk_readl() call with some ll_ops
dereference while the ll_ops to use gets determined before, as
'divider' need not have one.

Consider something like this
- have default routines which do readl() and writel(), and have a
  default ll_ops struct which references the default routines
- have a default ll_ops struct _pointer_ that by default
  references the default readl/writel struct, yet can get changed
  to something else for a whole platform or architecture
- never use routines directly upon hardware access, but instead
  always dereference an ll_ops struct that gets determined so:
  - start with the clock item's ll_ops reference
  - use the global ll_ops pointer if the above is NULL
  - use the pointer to the default ll_ops struct if still NULL
    (this protects against NULL platform specs, which should not
    happen yet are possible, and the test is cheap)

In pseudo code, this would then be

  init:
    default_struct = { default_read, default_write, NULL, };
    default_ops = &default_struct;

  setup:
    /* allow platforms to optionally change default_ops */
    /* allow clk items to have individual clk->ll_ops */

  use:
    ops = divider->ll_ops;
    if (!ops)
      ops = default_ops;
    if (!ops)
      ops = &default_struct;
    val = ops->clk_readl(ops, ...);

This way
- you always end up with an ll_ops reference which leads to
  routines (and potential additional data that can be specific to
  a clock item, like regmap data), for both "dynamically"
  registered clock items as well as "static" declarations
- one initialization step can apply different accessors for a
  whole platform, while the default behaviour equals the current
  implementation
- individual clock items can specify their accessor routine and
  data, or may go with the builtin or the preset defaults

The biggest change in cost here is the indirect routine call in
contrast to the static inline of the current implementation,
while this additional cost of calling a real wrapper routine
can't get avoided in the first place.  Comparing pointers and
falling back in the absence of individual overrides should not
outweight the above additional cost of calling the routine.  The
always identical logic to determine which routine to call can get
implemented in a static inline and then won't clutter the actual
clock handling logic.

If regmap access is rather popular a method, and requires only
little additional information, it might receive more explicit
support such that users need not hand-roll the same logic over
and over again, yet not too much waste occurs to non-regmap
items.  But available information suggests that currently there
is only one user for regmap style access to clock related
hardware (Steven's).  This could change in the future.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
