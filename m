From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: RE: [PATCH] OMAP3630 PM: Correct VDD1/VDD2 Retention and On voltage
Date: Wed, 13 Jan 2010 09:10:21 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B114936@dbde02.ent.ti.com>
References: <87zl4j6rbx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48480 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab0AMDkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 22:40:42 -0500
In-Reply-To: <87zl4j6rbx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Yes, If you have already thought of some specific place holder please let me know

Thanks
Vijay

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, January 13, 2010 1:15 AM
> To: G.N, Vijayakumar
> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath
> Subject: Re: [PATCH] OMAP3630 PM: Correct VDD1/VDD2 Retention and On
> voltage
> 
> "G.N, Vijayakumar" <vijaykumar.gn@ti.com> writes:
> 
> > From 61474f885fe048dd1b8b6f17cfbd1690ff281c49 Mon Sep 17 00:00:00 2001
> > From: Vijaykumar GN <vijaykumar.gn@ti.com>
> > Date: Mon, 21 Dec 2009 12:43:14 +0530
> > Subject: [PATCH] OMAP3630 PM: Correct VDD1/VDD2 Retention and On
> voltage
> >
> > For OMAP3630 Retention Voltage must be set to OPP25
> > 1. vdd1 retention voltage ==> 0.83
> > 2. vdd2 retention voltage ==> 0.85
> >
> > On Voltage must be at default OPP (OPP100)
> > 1. vdd1 on voltage ==> 1.1
> > 2. vdd2 on voltage ==> 1.375
> >
> > Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
> > Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
> 
> These are SoC-specific values, not board-specific values, right?
> 
> We should have a way to do this in SoC common code instead of
> duplicating across board files.
> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/board-3630sdp.c |   19 +++++++++++++++++++
> >  arch/arm/mach-omap2/board-zoom3.c   |   19 +++++++++++++++++++
> >  2 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> omap2/board-3630sdp.c
> > index d509c08..4d464fb 100755
> > --- a/arch/arm/mach-omap2/board-3630sdp.c
> > +++ b/arch/arm/mach-omap2/board-3630sdp.c
> > @@ -25,6 +25,24 @@
> >
> >  #include "mux.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> > +#include "pm.h"
> > +
> > +/* Update with the optimal setup values to be used on 3630sdp */
> > +static struct prm_setup_vc omap3_setuptime_table = {
> > +	.clksetup = 0x14A,
> > +	.voltsetup_time1 = 0x00B3,
> > +	.voltsetup_time2 = 0x00A0,
> > +	.voltoffset = 0x118,
> > +	.voltsetup2 = 0x32,
> > +	.vdd0_on = 0x28,	/* 1.1v */
> > +	.vdd0_onlp = 0x20,	/* 1.0v */
> > +	.vdd0_ret = 0x12,	/* 0.83v */
> > +	.vdd0_off = 0x00,	/* 0.6v */
> > +	.vdd1_on = 0x2B,	/* 1.1375v */
> > +	.vdd1_onlp = 0x20,	/* 1.0v */
> > +	.vdd1_ret = 0x14,	/* 0.85v */
> > +	.vdd1_off = 0x00,	/* 0.6v */
> > +};
> >
> >  #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
> >
> > @@ -79,6 +97,7 @@ static void __init omap_sdp_init_irq(void)
> >  {
> >  	omap_board_config = sdp_config;
> >  	omap_board_config_size = ARRAY_SIZE(sdp_config);
> > +	omap3_pm_init_vc(&omap3_setuptime_table);
> >  	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
> >  			     h8mbx00u0mer0em_sdrc_params,
> >                               NULL, NULL, NULL);
> > diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-
> zoom3.c
> > index 0778077..2c1f954 100644
> > --- a/arch/arm/mach-omap2/board-zoom3.c
> > +++ b/arch/arm/mach-omap2/board-zoom3.c
> > @@ -23,6 +23,24 @@
> >
> >  #include "mux.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> > +#include "pm.h"
> > +
> > +/* Update with the optimal setup values to be used on Zoom3 */
> > +static struct prm_setup_vc omap3_setuptime_table = {
> > +	.clksetup = 0x14A,
> > +	.voltsetup_time1 = 0x00B3,
> > +	.voltsetup_time2 = 0x00A0,
> > +	.voltoffset = 0x118,
> > +	.voltsetup2 = 0x32,
> > +	.vdd0_on = 0x28,	/* 1.1v */
> > +	.vdd0_onlp = 0x20,	/* 1.0v */
> > +	.vdd0_ret = 0x12,	/* 0.83v */
> > +	.vdd0_off = 0x00,	/* 0.6v */
> > +	.vdd1_on = 0x2B,	/* 1.1375v */
> > +	.vdd1_onlp = 0x20,	/* 1.0v */
> > +	.vdd1_ret = 0x14,	/* 0.85v */
> > +	.vdd1_off = 0x00,	/* 0.6v */
> > +};
> >
> >  static void __init omap_zoom_map_io(void)
> >  {
> > @@ -37,6 +55,7 @@ static void __init omap_zoom_init_irq(void)
> >  {
> >  	omap_board_config = zoom_config;
> >  	omap_board_config_size = ARRAY_SIZE(zoom_config);
> > +	omap3_pm_init_vc(&omap3_setuptime_table);
> >  	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
> >  			     h8mbx00u0mer0em_sdrc_params,
> >  			     NULL, NULL, NULL);
> > --
> > 1.5.6.3
