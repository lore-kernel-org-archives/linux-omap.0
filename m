From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Fri, 18 Dec 2015 07:36:06 -0800
Message-ID: <20151218153606.GJ23396@atomide.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450447141-29936-7-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151218 05:57]:
> Previously, hwmod core has been used for controlling the hwmod level
> clocks. This has certain drawbacks, like being unable to share the
> clocks for multiple users, missing usecounting and generally being
> totally incompatible with common clock framework.
> 
> Add support for new clock type under the TI clock driver, which will
> be used to convert all the existing hwmod clocks to. This helps to
> get rid of the clock related hwmod data from kernel and instead
> parsing this from DT.

Good to see this happening, few comments on what I've noticed so
far that should be considered.

We should be able to do a generic "ti,mux-div-gate" clock and use
it for the clkctrl too I think. See the suggested binding elsewhere
in this thread. That would also work for the clkout register at least.
Maybe the "ti,mux-div-gate" clock needs a separate clkctrl type
compatible to know it needs to sleep to wait for the status bit.

Also, we already know these clkctrl register do have multiple clocks,
like the GPIO debounce and dividers for debugss clock. And we want
to get rid of the overlapping reg entries.

> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
> +{
> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> +	u32 val;
> +	int timeout = 0;
> +	int ret;
> +
> +	if (!clk->enable_bit)
> +		return 0;
> +
> +	if (clk->clkdm) {
> +		ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
> +		if (ret) {
> +			WARN(1,
> +			     "%s: could not enable %s's clockdomain %s: %d\n",
> +			     __func__, clk_hw_get_name(hw),
> +			     clk->clkdm_name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
> +
> +	val &= ~OMAP4_MODULEMODE_MASK;
> +	val |= clk->enable_bit;
> +
> +	ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
> +
> +	/* Wait until module is enabled */
> +	while (!_omap4_is_ready(val)) {
> +		udelay(1);
> +		timeout++;
> +		if (timeout > OMAP4_MAX_MODULE_READY_TIME) {
> +			pr_err("%s: failed to enable\n", clk_hw_get_name(hw));
> +			return -EBUSY;
> +		}
> +		val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
> +	}
> +
> +	return 0;
> +}

Clocks that need to wait to lock need to be set up with clk_prepare
instead of clk_enable as pointed out by TGLX recently. Also see the
"[PATCH] clk: ti: Fix FAPLL udelay in clk_enable with clk_prepare".

Not sure what all needs to be fixed in the hwmod code for that to
happen and PM to work, but that probably needs to be done first.

Regards,

Tony
