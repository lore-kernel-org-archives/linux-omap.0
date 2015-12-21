From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] clk: ti: Add support for dm814x ADPLL
Date: Mon, 21 Dec 2015 15:55:12 -0800
Message-ID: <20151221235512.GE2793@atomide.com>
References: <1450213344-31369-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450213344-31369-1-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151215 13:02]:
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
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes from v2 to v3 are listed below, hopefully I addressed everybody's
> comments,please check and let me know if I missed something.

Everybody OK with this version as no more comments?

I found a few issues that are worth merging while testing:

- We want to create the clkdev entry for all clocks, not just outputs
- ti_adpll_wait_lock loops did not do the right thing
- We want to use CLK_GET_RATE_NOCACHE in ti_adpll_init_dco

Diff against v3 below for reference, will also send out v4 separately.

Regards,

Tony

8< ---------------------
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -228,9 +228,6 @@ static int ti_adpll_setup_clock(struct ti_adpll_data *d, struct clk *clock,
 	d->clocks[index].clk = clock;
 	d->clocks[index].unregister = unregister;
 
-	if (output_index < 0)
-		return 0;
-
 	/* Separate con_id in format "pll040dcoclkldo" to fit MAX_CON_ID */
 	postfix = strrchr(name, '.');
 	if (strlen(postfix) > 1) {
@@ -246,6 +243,9 @@ static int ti_adpll_setup_clock(struct ti_adpll_data *d, struct clk *clock,
 		dev_warn(d->dev, "no con_id for clock %s\n", name);
 	}
 
+	if (output_index < 0)
+		return 0;
+
 	d->outputs.clks[output_index] = clock;
 	d->outputs.clk_num++;
 
@@ -418,7 +418,7 @@ static int ti_adpll_wait_lock(struct ti_adpll_data *d)
 		if (ti_adpll_is_locked(d))
 			return 0;
 		usleep_range(200, 300);
-	} while (retries-- <= 0);
+	} while (retries--);
 
 	dev_err(d->dev, "pll failed to lock\n");
 	return -ETIMEDOUT;
@@ -527,6 +527,7 @@ static int ti_adpll_init_dco(struct ti_adpll_data *d)
 	init.parent_names = d->parent_names;
 	init.num_parents = d->c->nr_max_inputs;
 	init.ops = &ti_adpll_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	d->dco.hw.init = &init;
 
 	if (d->c->is_type_s)
