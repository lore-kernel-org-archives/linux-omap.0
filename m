From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date: Thu, 29 Nov 2018 23:57:12 -0800
Message-ID: <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, Tero Kristo <t-kristo@ti.com>
Cc: bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2018-11-29 23:35:35)
> On 30/11/2018 09:20, Stephen Boyd wrote:
> > Quoting Andreas Kemnade (2018-11-29 22:15:34)
> >> Hi Stephen,
> >>
> >> On Thu, 29 Nov 2018 16:25:05 -0800
> >> Stephen Boyd <sboyd@kernel.org> wrote:
> >>
> >>> Quoting Andreas Kemnade (2018-11-10 12:31:14)
> >>>> Code might use autoidle api with clocks not being omap2 clocks,
> >>>> so check if clock type is not basic
> >>>>
> >>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>> ---
> >>>> New in v2
> >>>> ---
> >>>>   drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >>>>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> >>>> index 161f67850393..5bdae5552d38 100644
> >>>> --- a/drivers/clk/ti/autoidle.c
> >>>> +++ b/drivers/clk/ti/autoidle.c
> >>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >>>>   int omap2_clk_deny_idle(struct clk *clk)
> >>>>   {
> >>>>          struct clk_hw_omap *c;
> >>>> +       struct clk_hw *hw =3D __clk_get_hw(clk);
> >>>>   =

> >>>> -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> >>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
> >>>
> >>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> >>> Maybe add some flag in clk_hw_omap() instead?
> >>>
> >> hmm, Tero suggested that.
> >> But to check flags in clk_hw_omap I first need to know that there is a
> >> clk_hw_omap behind clk_hw. And for that I either need to check flags in
> >> clk_hw or do more changes in the omap_hwmod code.
> > =

> > Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
> > other users are marking clks with this but there is no reason to do so.
> > I'll go make another pass over the tree and nuke those ones from orbit.
> =

> The reason for using this flag is because OMAP uses two clock types =

> around, the basic clocks like fixed-factor-clock/fixed-clock, and then =

> all the omap derivatives, which can be cast to clk_hw_omap. If we want =

> to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining =

> basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as =

> internal datatype. Is this preferred?
> =


No that is not preferred. Can the omap2_clk_deny_idle() function be
integrated closer into the clk framework in some way that allows it to
be part of the clk_ops structure? And then have that take a clk_hw
structure instead of a struct clk? I haven't looked at this in any
detail whatsoever so I may be way off right now.
