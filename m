From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 09/19] ARM: OMAP4: PM: add errata support
Date: Wed, 30 May 2012 11:32:39 +0300
Message-ID: <1338366759.8834.124.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-10-git-send-email-t-kristo@ti.com>
	 <CAOMWX4dmt2jUOpkgFC=o5oez3CfUVzF_0NTkm23qrNQDDpmo9w@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab2E3Icp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 04:32:45 -0400
In-Reply-To: <CAOMWX4dmt2jUOpkgFC=o5oez3CfUVzF_0NTkm23qrNQDDpmo9w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-05-29 at 15:10 -0500, Menon, Nishanth wrote:
> On Mon, May 14, 2012 at 5:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > Added similar PM errata flag support as omap3 has. A few errata flags
> > will be added in subsequent patches.
> 
> Considering that we might have erratas for future SoCs as well,
> should'nt we just
> set up a common errata flag for all SoCs and since we have i123 numbers, would
> it help being able to reuse errata flags cross SoC generations (if we need to)?

Not sure... how quickly do we run out of bits that way? :) Also, at
least pm34xx / pm44xx erratas don't have anything in common. We can
probably re-use pm44xx erratas for omap5 though.

One annoyance is that, the OMAP4 erratas are going to have a number of
ROM code erratas on them, which don't really have any public i123
numbers available. >.<

-Tero

> 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm.h     |    7 +++++++
> >  arch/arm/mach-omap2/pm44xx.c |    1 +
> >  2 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index ce1e27f..e53ee3c 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -130,6 +130,13 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
> >  static inline void enable_omap3630_toggle_l2_on_restore(void) { }
> >  #endif         /* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
> >
> > +#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
> > +extern u16 pm44xx_errata;
> > +#define IS_PM44XX_ERRATUM(id)          (pm44xx_errata & (id))
> > +#else
> > +#define IS_PM44XX_ERRATUM(id)          0
> > +#endif
> > +
> >  #ifdef CONFIG_OMAP_SMARTREFLEX
> >  extern int omap_devinit_smartreflex(void);
> >  extern void omap_enable_smartreflex_on_init(void);
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> > index 8f0ec56..8238097 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -35,6 +35,7 @@ struct power_state {
> >  };
> >
> >  static LIST_HEAD(pwrst_list);
> > +u16 pm44xx_errata;
> >
> >  #ifdef CONFIG_SUSPEND
> >  static int omap4_pm_suspend(void)
> > --
> > 1.7.4.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> Regards,
> Nishanth Menon


