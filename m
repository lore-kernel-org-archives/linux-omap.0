From: Mike Turquette <mturquette@linaro.org>
Subject: Re: RE: [RFC PATCH 2/2] ARM: OMAP4: clock: use omap4_clks_register API
Date: Mon, 22 Oct 2012 14:17:33 -0700
Message-ID: <20121022211733.21731.98489@nucleus>
References: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
 <1350578297-22572-3-git-send-email-grygorii.strashko@ti.com>,
 <20121018175312.21731.22864@nucleus>
 <902E09E6452B0E43903E4F2D568737AB2CA620@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53881 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab2JVVRr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 17:17:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2231926pad.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 14:17:46 -0700 (PDT)
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB2CA620@DNCE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Quoting Strashko, Grygorii (2012-10-19 03:34:19)
> Hi Mike,
> 
> > In addition to removing CK_443X/CK_446X you could also get rid of struct
> > omap_clk completely (arch/arm/plat-omap/include/plat/clkdev_omap.h) and
> > the CLK macro by changing the clk array to be of type struct clk_lookup
> > and using the CLKDEV_INIT macro.
> Yes. It may be done. As I understand, this approach is applicable for you, if so i can continue working on it. right?
> 
> > I wonder if splitting the tables would make initdata any easier.  It
> OMAP5,4,2 - there are no so much differences between SOcs, so it looks good and simple.
> OMAP3 - it is a little bit more complex.
> > would be nice to get more functional changes out of this series
> > alongside the data reorganization.
> Could you provide more details, pls?
> 

What I mean to say is that this patch doesn't change any functionality.
It just reorganizes data to make things prettier.  In order to justify
getting this change upstream (and to combat accusations of "needless
churn") it would be good if this series did more than just shuffle the
data around.  Two examples I have already mentioned are getting rid of
the macros in ckdev_omap.h (and maybe getting rid of that entire file)
and also marking data as initdata.  Both are functional changes that
make the world a better place.

Regards,
Mike

> > Also have you looked at splitting the tables for OMAP2/3?
> Yes. I think, it can be done.
> 
> Best regards,
> Grygorii Strashko | GlobalLogic
> 
> ________________________________________
> From: Mike Turquette [mturquette@linaro.org]
> Sent: Thursday, October 18, 2012 8:53 PM
> To: Strashko, Grygorii; Paul Walmsley
> Cc: Hilman, Kevin; Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Strashko, Grygorii
> Subject: Re: [RFC PATCH 2/2] ARM: OMAP4: clock: use omap4_clks_register API
> 
> Quoting Grygorii Strashko (2012-10-18 09:38:17)
> > Remove OMAP443x and OMAP446x specific clocks from omap44xx_clks
> > array and add corresponding set of clocks per each SoC:
> >  - struct omap_clk omap44xx_clks[]; - common clocks set for all OMAP4
> >  - struct omap_clk omap443x_clks[]; - specific clocks set for OMAP443x
> >  - struct omap_clk omap446x_clks[]; - specific clocks set for OMAP446x
> >    and don't rely on platform specific flags any more.
> >
> > Use omap4_clks_register() API to register and init OMAP4 set of
> > clocks.
> >
> > With this change, we can now safely remove CK_443X/CK_446X etc macro
> > usage. It has not been done in this patch, but if the approach is OK,
> > then, it is possible to do the same.
> >
> 
> In addition to removing CK_443X/CK_446X you could also get rid of struct
> omap_clk completely (arch/arm/plat-omap/include/plat/clkdev_omap.h) and
> the CLK macro by changing the clk array to be of type struct clk_lookup
> and using the CLKDEV_INIT macro.
> 
> > One additional benefit seen is that the match logic can entirely be
> > skipped.
> >
> 
> I wonder if splitting the tables would make initdata any easier.  It
> would be nice to get more functional changes out of this series
> alongside the data reorganization.
> 
> Also have you looked at splitting the tables for OMAP2/3?
> 
> Regards,
> Mike
> 
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock44xx_data.c |   40 ++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> > index 6efc30c..4060c9c 100644
> > --- a/arch/arm/mach-omap2/clock44xx_data.c
> > +++ b/arch/arm/mach-omap2/clock44xx_data.c
> > @@ -3145,10 +3145,7 @@ static struct omap_clk omap44xx_clks[] = {
> >         CLK(NULL,       "aes1_fck",                     &aes1_fck,      CK_443X),
> >         CLK(NULL,       "aes2_fck",                     &aes2_fck,      CK_443X),
> >         CLK(NULL,       "aess_fck",                     &aess_fck,      CK_443X),
> > -       CLK(NULL,       "bandgap_fclk",                 &bandgap_fclk,  CK_443X),
> > -       CLK(NULL,       "bandgap_ts_fclk",              &bandgap_ts_fclk,       CK_446X),
> >         CLK(NULL,       "des3des_fck",                  &des3des_fck,   CK_443X),
> > -       CLK(NULL,       "div_ts_ck",                    &div_ts_ck,     CK_446X),
> >         CLK(NULL,       "dmic_sync_mux_ck",             &dmic_sync_mux_ck,      CK_443X),
> >         CLK(NULL,       "dmic_fck",                     &dmic_fck,      CK_443X),
> >         CLK(NULL,       "dsp_fck",                      &dsp_fck,       CK_443X),
> > @@ -3346,19 +3343,27 @@ static struct omap_clk omap44xx_clks[] = {
> >         CLK("4903c000.timer",   "timer_sys_ck", &syc_clk_div_ck,        CK_443X),
> >         CLK("4903e000.timer",   "timer_sys_ck", &syc_clk_div_ck,        CK_443X),
> >         CLK(NULL,       "cpufreq_ck",   &dpll_mpu_ck,   CK_443X),
> > +       CLK(NULL,       NULL,           NULL,                   CK_443X),
> > +};
> > +
> > +static struct omap_clk omap443x_clks[] = {
> > +       CLK(NULL,       "bandgap_fclk",         &bandgap_fclk,          CK_443X),
> > +       CLK(NULL,       NULL,           NULL,                   CK_443X),
> > +};
> > +
> > +
> > +static struct omap_clk omap446x_clks[] = {
> > +       CLK(NULL,       "div_ts_ck",            &div_ts_ck,             CK_446X),
> > +       CLK(NULL,       "bandgap_ts_fclk",      &bandgap_ts_fclk,       CK_446X),
> > +       CLK(NULL,       NULL,           NULL,           CK_446X),
> >  };
> >
> >  int __init omap4xxx_clk_init(void)
> >  {
> > -       struct omap_clk *c;
> > -       u32 cpu_clkflg;
> > -
> >         if (cpu_is_omap443x()) {
> >                 cpu_mask = RATE_IN_4430;
> > -               cpu_clkflg = CK_443X;
> >         } else if (cpu_is_omap446x() || cpu_is_omap447x()) {
> >                 cpu_mask = RATE_IN_4460 | RATE_IN_4430;
> > -               cpu_clkflg = CK_446X | CK_443X;
> >
> >                 if (cpu_is_omap447x())
> >                         pr_warn("WARNING: OMAP4470 clock data incomplete!\n");
> > @@ -3375,17 +3380,14 @@ int __init omap4xxx_clk_init(void)
> >          * omap2_clk_disable_clkdm_control();
> >          */
> >
> > -       for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
> > -                                                                         c++)
> > -               clk_preinit(c->lk.clk);
> > -
> > -       for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
> > -                                                                         c++)
> > -               if (c->cpu & cpu_clkflg) {
> > -                       clkdev_add(&c->lk);
> > -                       clk_register(c->lk.clk);
> > -                       omap2_init_clk_clkdm(c->lk.clk);
> > -               }
> > +       omap2_clks_register(omap44xx_clks);
> > +
> > +       if (cpu_is_omap443x())
> > +               omap2_clks_register(omap443x_clks);
> > +       else if (cpu_is_omap446x() || cpu_is_omap447x())
> > +               omap2_clks_register(omap446x_clks);
> > +       else
> > +               return 0;
> >
> >         /* Disable autoidle on all clocks; let the PM code enable it later */
> >         omap_clk_disable_autoidle_all();
> > --
> > 1.7.9.5
