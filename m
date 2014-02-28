From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy
 clocks
Date: Fri, 28 Feb 2014 09:28:37 -0800
Message-ID: <20140228172836.GB15399@atomide.com>
References: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
 <1393411089-9550-2-git-send-email-florian.vaussard@epfl.ch>
 <20140226204003.4353.17772@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31138 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaB1R2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 12:28:53 -0500
Content-Disposition: inline
In-Reply-To: <20140226204003.4353.17772@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [140226 12:43]:
> Quoting Florian Vaussard (2014-02-26 02:38:08)
> > When arch/arm/mach-omap2/gpmc.c calls clk_get(..., "fck"), it will
> > get a dummy clock and try to use it. As the rate is configured to zero,
> > this will result in several divisions by zero, and misconfigured
> > timings, with devices on the bus being lost in the La La Land.
> > 
> > It is better to remove gpmc_fck from the dummy clocks, so that gpmc.c
> > can fail gracefully.
> > 
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> Looks good to me.

Can that be upgraded to an ack then?

Regards,

Tony
 
> > ---
> >  drivers/clk/ti/clk-44xx.c | 1 -
> >  drivers/clk/ti/clk-54xx.c | 1 -
> >  drivers/clk/ti/clk-7xx.c  | 1 -
> >  3 files changed, 3 deletions(-)
> > 
> > diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
> > index ae00218..02517a8 100644
> > --- a/drivers/clk/ti/clk-44xx.c
> > +++ b/drivers/clk/ti/clk-44xx.c
> > @@ -222,7 +222,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
> >         DT_CLK(NULL, "auxclk5_src_ck", "auxclk5_src_ck"),
> >         DT_CLK(NULL, "auxclk5_ck", "auxclk5_ck"),
> >         DT_CLK(NULL, "auxclkreq5_ck", "auxclkreq5_ck"),
> > -       DT_CLK("50000000.gpmc", "fck", "dummy_ck"),
> >         DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
> > diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
> > index 0ef9f58..08f3d1b 100644
> > --- a/drivers/clk/ti/clk-54xx.c
> > +++ b/drivers/clk/ti/clk-54xx.c
> > @@ -182,7 +182,6 @@ static struct ti_dt_clk omap54xx_clks[] = {
> >         DT_CLK(NULL, "auxclk3_src_ck", "auxclk3_src_ck"),
> >         DT_CLK(NULL, "auxclk3_ck", "auxclk3_ck"),
> >         DT_CLK(NULL, "auxclkreq3_ck", "auxclkreq3_ck"),
> > -       DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
> >         DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
> > diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> > index 9977653..f7e4073 100644
> > --- a/drivers/clk/ti/clk-7xx.c
> > +++ b/drivers/clk/ti/clk-7xx.c
> > @@ -262,7 +262,6 @@ static struct ti_dt_clk dra7xx_clks[] = {
> >         DT_CLK(NULL, "vip1_gclk_mux", "vip1_gclk_mux"),
> >         DT_CLK(NULL, "vip2_gclk_mux", "vip2_gclk_mux"),
> >         DT_CLK(NULL, "vip3_gclk_mux", "vip3_gclk_mux"),
> > -       DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
> >         DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
> >         DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
> > -- 
> > 1.8.1.2
> > 
