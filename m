From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Fri, 6 Feb 2015 13:39:20 +0000
Message-ID: <20150206133920.GC8670@n2100.arm.linux.org.uk>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com>
 <54D3CD6A.1010209@codeaurora.org>
 <54D3EB29.4090007@codeaurora.org>
 <20150206004210.GB8670@n2100.arm.linux.org.uk>
 <54D41A60.8040702@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:52500 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbBFNjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2015 08:39:44 -0500
Content-Disposition: inline
In-Reply-To: <54D41A60.8040702@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 05, 2015 at 05:35:28PM -0800, Stephen Boyd wrote:
> On 02/05/15 16:42, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 02:14:01PM -0800, Stephen Boyd wrote:
> >> Actually we can bury the __clk_create_clk() inside
> >> __of_clk_get_from_provider(). We should also move __clk_get() into there
> >> because right now we have a hole where whoever calls
> >> of_clk_get_from_provider() never calls __clk_get() on the clk, leading
> >> to possible badness. v2 coming soon.
> > There's some other issues here too...
> >
> > sound/soc/kirkwood/kirkwood-i2s.c:
> >
> >         priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
> > ...
> >         priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> >         if (IS_ERR(priv->extclk)) {
> > ...
> > 	} else {
> >                 if (priv->extclk == priv->clk) {
> >                         devm_clk_put(&pdev->dev, priv->extclk);
> >                         priv->extclk = ERR_PTR(-EINVAL);
> >                 } else {
> >                         dev_info(&pdev->dev, "found external clock\n");
> >                         clk_prepare_enable(priv->extclk);
> >                         soc_dai = kirkwood_i2s_dai_extclk;
> >                 }
> >
> > It should be fine provided your "trick" is only done for DT clocks,
> > but not for legacy - with legacy, a NULL in the clkdev tables will
> > match both these requests, hence the need to compare the clk_get()
> > return value to tell whether we get the same clock.
> >
> 
> Are we still talking about of_clk_get_from_provider()? Or are we talking
> about comparing struct clk pointers?

Comparing struct clk pointers, and the implications of the patch changing
the clk_get() et.al. to be unique struct clk pointers.

> From what I can tell this code is
> now broken because we made all clk getting functions (there's quite a
> few...) return unique pointers every time they're called. It seems that
> the driver wants to know if extclk and clk are the same so it can do
> something differently in kirkwood_set_rate(). Do we need some sort of
> clk_equal(struct clk *a, struct clk *b) function for drivers like this?

Well, the clocks in question are the SoC internal clock (which is more or
less fixed, but has a programmable divider) and an externally supplied
clock, and the IP has a multiplexer on its input which allows us to select
between those two sources.

If it were possible to bind both to the same clock, it wouldn't be a
useful configuration - nothing would be gained from doing so in terms of
available rates.

What the comparison is there for is to catch the case with legacy lookups
where a clkdev lookup entry with a NULL connection ID results in matching
any connection ID passed to clk_get().  If the patch changes this, then
we will have a regression - and this is something which needs fixing
_before_ we do this "return unique clocks".

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
