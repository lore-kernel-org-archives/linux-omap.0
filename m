From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 2/2] clk: ti: Add support for dm814x ADPLL
Date: Tue, 16 Feb 2016 17:19:30 -0800
Message-ID: <20160217011930.2278.38316@quark.deferred.io>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1455312009-808-3-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Quoting Tony Lindgren (2016-02-12 13:20:09)
> On dm814x we have 13 ADPLLs with 3 to 4 outputs on each. The
> ADPLLs have several dividers and muxes controlled by a shared
> control register for each PLL.
> 
> Note that for the clocks to work as device drivers for booting on
> dm814x, this patch depends on "ARM: OMAP2+: Change core_initcall
> levels to postcore_initcall".
> 
> Also note that this patch does not implement clk_set_rate for the
> PLL, that will be posted later on when available.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v4:
> 
> - Removed ti_adpll_clkout_set_parent() as requested by Tero for his
>   conditional ack
> 
> - Split the device tree binding into a separate patch as requested
>   by Mike for his conditional ack of the binding

Just to make life fun for you, the clk tree is once more merging DT
bindings descriptions and headers. You don't need to merge the patches,
it doesn't matter to me, but just as a heads up for the future.

> 
> - Updated dts patch comments about dynamically generated names as
>   suggested by Tero.
> 
> - Fixed a compiler warning for do_div
> 
> 
>  drivers/clk/Kconfig       |   1 +
>  drivers/clk/ti/Kconfig    |   6 +
>  drivers/clk/ti/Makefile   |   2 +
>  drivers/clk/ti/adpll.c    | 983 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/ti/clk-814x.c |  53 +++
>  5 files changed, 1045 insertions(+)
>  create mode 100644 drivers/clk/ti/Kconfig
>  create mode 100644 drivers/clk/ti/adpll.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index eca8e01..0b7364a 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -202,6 +202,7 @@ config COMMON_CLK_CDCE706
>  
>  source "drivers/clk/bcm/Kconfig"
>  source "drivers/clk/hisilicon/Kconfig"
> +source "drivers/clk/ti/Kconfig"
>  source "drivers/clk/qcom/Kconfig"
>  
>  endmenu
> diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
> new file mode 100644
> index 0000000..a9d5474
> --- /dev/null
> +++ b/drivers/clk/ti/Kconfig
> @@ -0,0 +1,6 @@
> +config COMMON_CLK_TI_ADPLL
> +       tristate "Clock driver for dm814x ADPLL"
> +       depends on ARCH_OMAP2PLUS
> +       default y if SOC_TI81XX

Can we add COMPILE_TEST here?

...
> +static int ti_adpll_init_inputs(struct ti_adpll_data *d)
> +{
> +       const char *error = "need at least %i inputs";
> +       struct clk *clock;
> +       int nr_inputs;
> +
> +       nr_inputs = of_clk_get_parent_count(d->np);
> +       if (nr_inputs < d->c->nr_max_inputs) {
> +               dev_err(d->dev, error, nr_inputs);
> +               return -EINVAL;
> +       }
> +       of_clk_parent_fill(d->np, d->parent_names, nr_inputs);
> +
> +       clock = devm_clk_get(d->dev, d->parent_names[0]);
> +       if (IS_ERR(clock)) {
> +               dev_err(d->dev, "could not get clkinp\n");
> +               return PTR_ERR(clock);
> +       }
> +       d->parent_clocks[TI_ADPLL_CLKINP] = clock;
> +
> +       clock = devm_clk_get(d->dev, d->parent_names[1]);
> +       if (IS_ERR(clock)) {
> +               dev_err(d->dev, "could not get clkinpulow clock\n");
> +               return PTR_ERR(clock);
> +       }
> +       d->parent_clocks[TI_ADPLL_CLKINPULOW] = clock;

Are the clock parents known at compile-time? Can we just put that data
in C instead of whatever is going on here?

...
> +int __init dm814x_adpll_enable_init_clocks(void)
> +{
> +       int i, err;
> +
> +       if (!timer_clocks_initialized)
> +               return -ENODEV;
> +
> +       for (i = 0; i < ARRAY_SIZE(init_clocks); i++) {
> +               struct clk *clock;
> +
> +               clock = clk_get(NULL, init_clocks[i]);
> +               if (WARN(IS_ERR(clock), "could not find init clock %s\n",
> +                        init_clocks[i]))
> +                       continue;
> +               err = clk_prepare_enable(clock);
> +               if (WARN(err, "could not enable init clock %s\n",
> +                        init_clocks[i]))
> +                       continue;

We have a shiny new series that provides a standard way to do this:

http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>

Regards,
Mike
