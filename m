From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] clk: ti: Add support for dm814x ADPLL
Date: Wed, 17 Feb 2016 09:39:49 -0800
Message-ID: <20160217173949.GB21202@atomide.com>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-3-git-send-email-tony@atomide.com>
 <20160217011930.2278.38316@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160217011930.2278.38316@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [160216 17:32]:
> Quoting Tony Lindgren (2016-02-12 13:20:09)
> > 
> > - Split the device tree binding into a separate patch as requested
> >   by Mike for his conditional ack of the binding
> 
> Just to make life fun for you, the clk tree is once more merging DT
> bindings descriptions and headers. You don't need to merge the patches,
> it doesn't matter to me, but just as a heads up for the future.

OK :)

> > --- /dev/null
> > +++ b/drivers/clk/ti/Kconfig
> > @@ -0,0 +1,6 @@
> > +config COMMON_CLK_TI_ADPLL
> > +       tristate "Clock driver for dm814x ADPLL"
> > +       depends on ARCH_OMAP2PLUS
> > +       default y if SOC_TI81XX
> 
> Can we add COMPILE_TEST here?

Good idea, will add.

> > +static int ti_adpll_init_inputs(struct ti_adpll_data *d)
> > +{
> > +       const char *error = "need at least %i inputs";
> > +       struct clk *clock;
> > +       int nr_inputs;
> > +
> > +       nr_inputs = of_clk_get_parent_count(d->np);
> > +       if (nr_inputs < d->c->nr_max_inputs) {
> > +               dev_err(d->dev, error, nr_inputs);
> > +               return -EINVAL;
> > +       }
> > +       of_clk_parent_fill(d->np, d->parent_names, nr_inputs);
> > +
> > +       clock = devm_clk_get(d->dev, d->parent_names[0]);
> > +       if (IS_ERR(clock)) {
> > +               dev_err(d->dev, "could not get clkinp\n");
> > +               return PTR_ERR(clock);
> > +       }
> > +       d->parent_clocks[TI_ADPLL_CLKINP] = clock;
> > +
> > +       clock = devm_clk_get(d->dev, d->parent_names[1]);
> > +       if (IS_ERR(clock)) {
> > +               dev_err(d->dev, "could not get clkinpulow clock\n");
> > +               return PTR_ERR(clock);
> > +       }
> > +       d->parent_clocks[TI_ADPLL_CLKINPULOW] = clock;
> 
> Are the clock parents known at compile-time? Can we just put that data
> in C instead of whatever is going on here?

No they can be board specific depending how the inputs for
clkin, clkinpulow and clkinphif are wired.

> ...
> > +int __init dm814x_adpll_enable_init_clocks(void)
> > +{
> > +       int i, err;
> > +
> > +       if (!timer_clocks_initialized)
> > +               return -ENODEV;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(init_clocks); i++) {
> > +               struct clk *clock;
> > +
> > +               clock = clk_get(NULL, init_clocks[i]);
> > +               if (WARN(IS_ERR(clock), "could not find init clock %s\n",
> > +                        init_clocks[i]))
> > +                       continue;
> > +               err = clk_prepare_enable(clock);
> > +               if (WARN(err, "could not enable init clock %s\n",
> > +                        init_clocks[i]))
> > +                       continue;
> 
> We have a shiny new series that provides a standard way to do this:
> 
> http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>

OK nice, so tagging the MPU and DDR clocks with CLK_IS_CRITICAL or
"clock-critical" should allow removing this code. I think in this
case I still need to set CLK_IS_CRITICAL as the clock is output 1
of the dts defined clock and does not have a separate dts node.

I can update when those patches hit Linux next, or I can do a
follow-up patch later on if we want to avoid the dependency
here. Which do you prefer?

Regards,

Tony
