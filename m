From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v4] clk: ti: Add support for dm814x ADPLL
Date: Tue, 22 Dec 2015 22:30:14 +0200
Message-ID: <5679B2D6.4050102@ti.com>
References: <1450798030-23680-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450798030-23680-1-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 12/22/2015 05:27 PM, Tony Lindgren wrote:
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
>
> If no more comments, Tero can you please apply into an immutable
> branch against v4.4-rc1 that I can merge in too?
>
> Changes since v3:
>
> - We want to create the clkdev entry for all clocks, not just outputs
> - ti_adpll_wait_lock loops did not do the right thing
> - We want to use CLK_GET_RATE_NOCACHE in ti_adpll_init_dco

I have just one comment below still, once that is addressed:

Conditionally-acked-by: Tero Kristo <t-kristo@ti.com>

Stephen / Michael, can you pick this up for next merge? I don't have 
anything else coming for the window this time, and I am probably going 
to be on vacation just nicely to not be able to push anything anyway.

<snip>

> +
> +/* Warn if clkout or clkoutx2 try to set unavailable parent */
> +static int ti_adpll_clkout_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct ti_adpll_clkout_data *co = to_clkout(hw);
> +	struct ti_adpll_data *d = co->adpll;
> +
> +	if (ti_adpll_clock_is_bypass(d) != index)
> +		return -EAGAIN;
> +

I think this part is still somewhat weird. You are not doing anything 
useful in this function, so do you need to implement it at all? Just 
returning -EINVAL always might work also. EAGAIN is wrong return value 
anyway as it can pretty much never succeed.

-Tero

> +	return 0;
> +}
> +

<snip>

