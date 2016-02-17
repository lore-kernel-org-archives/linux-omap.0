From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 2/2] clk: ti: Add support for dm814x ADPLL
Date: Wed, 17 Feb 2016 12:52:57 -0800
Message-ID: <20160217205257.2278.11639@quark.deferred.io>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-3-git-send-email-tony@atomide.com>
 <20160217011930.2278.38316@quark.deferred.io>
 <20160217173949.GB21202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160217173949.GB21202@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Delio Brignoli <dbrignoli@audioscience.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Rosenberger <ilu@linutronix.de>, Brian Hutchinson <b.hutchman@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-02-17 09:39:49)
> * Michael Turquette <mturquette@baylibre.com> [160216 17:32]:
> > Quoting Tony Lindgren (2016-02-12 13:20:09)
> > > 
> > > - Split the device tree binding into a separate patch as requested
> > >   by Mike for his conditional ack of the binding
> > 
> > Just to make life fun for you, the clk tree is once more merging DT
> > bindings descriptions and headers. You don't need to merge the patches,
> > it doesn't matter to me, but just as a heads up for the future.
> 
> OK :)
> 
> > > --- /dev/null
> > > +++ b/drivers/clk/ti/Kconfig
> > > @@ -0,0 +1,6 @@
> > > +config COMMON_CLK_TI_ADPLL
> > > +       tristate "Clock driver for dm814x ADPLL"
> > > +       depends on ARCH_OMAP2PLUS
> > > +       default y if SOC_TI81XX
> > 
> > Can we add COMPILE_TEST here?
> 
> Good idea, will add.
> 
> > > +static int ti_adpll_init_inputs(struct ti_adpll_data *d)
> > > +{
> > > +       const char *error = "need at least %i inputs";
> > > +       struct clk *clock;
> > > +       int nr_inputs;
> > > +
> > > +       nr_inputs = of_clk_get_parent_count(d->np);
> > > +       if (nr_inputs < d->c->nr_max_inputs) {
> > > +               dev_err(d->dev, error, nr_inputs);
> > > +               return -EINVAL;
> > > +       }
> > > +       of_clk_parent_fill(d->np, d->parent_names, nr_inputs);
> > > +
> > > +       clock = devm_clk_get(d->dev, d->parent_names[0]);
> > > +       if (IS_ERR(clock)) {
> > > +               dev_err(d->dev, "could not get clkinp\n");
> > > +               return PTR_ERR(clock);
> > > +       }
> > > +       d->parent_clocks[TI_ADPLL_CLKINP] = clock;
> > > +
> > > +       clock = devm_clk_get(d->dev, d->parent_names[1]);
> > > +       if (IS_ERR(clock)) {
> > > +               dev_err(d->dev, "could not get clkinpulow clock\n");
> > > +               return PTR_ERR(clock);
> > > +       }
> > > +       d->parent_clocks[TI_ADPLL_CLKINPULOW] = clock;
> > 
> > Are the clock parents known at compile-time? Can we just put that data
> > in C instead of whatever is going on here?
> 
> No they can be board specific depending how the inputs for
> clkin, clkinpulow and clkinphif are wired.
> 
> > ...
> > > +int __init dm814x_adpll_enable_init_clocks(void)
> > > +{
> > > +       int i, err;
> > > +
> > > +       if (!timer_clocks_initialized)
> > > +               return -ENODEV;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(init_clocks); i++) {
> > > +               struct clk *clock;
> > > +
> > > +               clock = clk_get(NULL, init_clocks[i]);
> > > +               if (WARN(IS_ERR(clock), "could not find init clock %s\n",
> > > +                        init_clocks[i]))
> > > +                       continue;
> > > +               err = clk_prepare_enable(clock);
> > > +               if (WARN(err, "could not enable init clock %s\n",
> > > +                        init_clocks[i]))
> > > +                       continue;
> > 
> > We have a shiny new series that provides a standard way to do this:
> > 
> > http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>
> 
> OK nice, so tagging the MPU and DDR clocks with CLK_IS_CRITICAL or
> "clock-critical" should allow removing this code. I think in this
> case I still need to set CLK_IS_CRITICAL as the clock is output 1
> of the dts defined clock and does not have a separate dts node.

In fact I hate clock-critical as a DT property and it's only there to
support legacy DT bindings that store all clk data in DT and have zero
clk data in C. So please use the CLK_IS_CRITICAL or CLK_ENABLE_HAND_OFF
flags in C.

Do you think you will ever have a driver that wants to gate these
clocks? Probably not for MPU/DDR, but the HAND_OFF flag is a better fit
if you do. It's the same as CRITICAL but transfers the prepare/enable
reference counting to the consumer driver after that driver calls
clk_get() and clk_prepare_enable() on the HAND_OFF clk.

> 
> I can update when those patches hit Linux next, or I can do a
> follow-up patch later on if we want to avoid the dependency
> here. Which do you prefer?

Well, testing is always welcome :-)

If you rebase onto those patches then I'll add your patches to that
series for testing and merge it that way.

Regards,
Mike

> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
