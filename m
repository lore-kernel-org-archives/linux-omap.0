From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH] OMAP: Fix race condition with autodeps
Date: Wed, 16 Sep 2009 15:16:51 +0300
Message-ID: <1253103411.6744.1.camel@ubuntu>
References: <1253098386-30263-1-git-send-email-kalle.jokiniemi@digia.com>
	 <93e6a6040909160507j64eaa9efo38f69fea016d3933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:15521 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbZIPMQt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Sep 2009 08:16:49 -0400
In-Reply-To: <93e6a6040909160507j64eaa9efo38f69fea016d3933@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tommi Rantala <tt.rantala@gmail.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ville.syrjala@nokia.com" <ville.syrjala@nokia.com>

On Wed, 2009-09-16 at 15:07 +0300, Tommi Rantala wrote:
> 2009/9/16 Kalle Jokiniemi <kalle.jokiniemi@digia.com>:
> > There is a possible race condition in clockdomain
> > code handling hw supported idle transitions.
> >
> > When multiple autodeps dependencies are being added
> > or removed, a transition of still remaining dependent
> > powerdomain can result in false readings of the
> > state counter. This is especially fatal for off mode
> > state counter, as it could result in a driver not
> > noticing a context loss.
> >
> > Fixed by disabling hw supported state transitions
> > when autodeps are being changed.
> >
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> > ---
> >  arch/arm/mach-omap2/clockdomain.c |   74 ++++++++++++++++++++++---------------
> >  1 files changed, 44 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> > index 4ef7b4f..1a8c386 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -137,6 +137,36 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
> >        }
> >  }
> >
> > +/*
> > + * _omap2_clkdm_set_hwsup - set high the hwsup idle transition bit
> > + * @clkdm: struct clockdomain *
> > + * @enable: int 0 to disable, 1 to enable
> > + *
> > + * Internal helper for actually switching the bit that controls hwsup
> > + * idle transitions for clkdm.
> > + */
> 
> "static" missing here.

Oops, good catch. I'll repost.

- Kalle

> 
> > +void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
> > +{
> > +       u32 v;
> > +
> > +       if (cpu_is_omap24xx()) {
> > +               if (enable)
> > +                       v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
> > +               else
> > +                       v = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
> > +       } else if (cpu_is_omap34xx()) {
> > +               if (enable)
> > +                       v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
> > +               else
> > +                       v = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
> > +       } else {
> > +               BUG();
> > +       }
> > +
> > +       cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
> > +                           v << __ffs(clkdm->clktrctrl_mask),
> > +                           clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
> > +}
> >
> >  static struct clockdomain *_clkdm_lookup(const char *name)
> >  {
> [...]
> 
> Regards,
> Tommi Rantala

