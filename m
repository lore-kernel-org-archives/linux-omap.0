From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 05 Feb 2015 17:35:28 -0800
Message-ID: <54D41A60.8040702@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org> <54D3EB29.4090007@codeaurora.org> <20150206004210.GB8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150206004210.GB8670@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/05/15 16:42, Russell King - ARM Linux wrote:
> On Thu, Feb 05, 2015 at 02:14:01PM -0800, Stephen Boyd wrote:
>> Actually we can bury the __clk_create_clk() inside
>> __of_clk_get_from_provider(). We should also move __clk_get() into there
>> because right now we have a hole where whoever calls
>> of_clk_get_from_provider() never calls __clk_get() on the clk, leading
>> to possible badness. v2 coming soon.
> There's some other issues here too...
>
> sound/soc/kirkwood/kirkwood-i2s.c:
>
>         priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
> ...
>         priv->extclk = devm_clk_get(&pdev->dev, "extclk");
>         if (IS_ERR(priv->extclk)) {
> ...
> 	} else {
>                 if (priv->extclk == priv->clk) {
>                         devm_clk_put(&pdev->dev, priv->extclk);
>                         priv->extclk = ERR_PTR(-EINVAL);
>                 } else {
>                         dev_info(&pdev->dev, "found external clock\n");
>                         clk_prepare_enable(priv->extclk);
>                         soc_dai = kirkwood_i2s_dai_extclk;
>                 }
>
> It should be fine provided your "trick" is only done for DT clocks,
> but not for legacy - with legacy, a NULL in the clkdev tables will
> match both these requests, hence the need to compare the clk_get()
> return value to tell whether we get the same clock.
>

Are we still talking about of_clk_get_from_provider()? Or are we talking
about comparing struct clk pointers? From what I can tell this code is
now broken because we made all clk getting functions (there's quite a
few...) return unique pointers every time they're called. It seems that
the driver wants to know if extclk and clk are the same so it can do
something differently in kirkwood_set_rate(). Do we need some sort of
clk_equal(struct clk *a, struct clk *b) function for drivers like this?

Also, even on DT this could fail if the DT author made internal and
extclk map to the same clock provider and cell.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
