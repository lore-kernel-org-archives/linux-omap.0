From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date: Thu, 29 Nov 2018 23:20:25 -0800
Message-ID: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130071534.0a6cd455@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Quoting Andreas Kemnade (2018-11-29 22:15:34)
> Hi Stephen,
> =

> On Thu, 29 Nov 2018 16:25:05 -0800
> Stephen Boyd <sboyd@kernel.org> wrote:
> =

> > Quoting Andreas Kemnade (2018-11-10 12:31:14)
> > > Code might use autoidle api with clocks not being omap2 clocks,
> > > so check if clock type is not basic
> > > =

> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > New in v2
> > > ---
> > >  drivers/clk/ti/autoidle.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > > index 161f67850393..5bdae5552d38 100644
> > > --- a/drivers/clk/ti/autoidle.c
> > > +++ b/drivers/clk/ti/autoidle.c
> > > @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> > >  int omap2_clk_deny_idle(struct clk *clk)
> > >  {
> > >         struct clk_hw_omap *c;
> > > +       struct clk_hw *hw =3D __clk_get_hw(clk);
> > >  =

> > > -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > > +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)  =

> > =

> > Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> > Maybe add some flag in clk_hw_omap() instead?
> > =

> hmm, Tero suggested that.
> But to check flags in clk_hw_omap I first need to know that there is a
> clk_hw_omap behind clk_hw. And for that I either need to check flags in
> clk_hw or do more changes in the omap_hwmod code.

Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
other users are marking clks with this but there is no reason to do so.
I'll go make another pass over the tree and nuke those ones from orbit.
