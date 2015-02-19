From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk instances
Date: Thu, 19 Feb 2015 13:32:33 -0800
Message-ID: <20150219213233.421.11915@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org>
 <54D3EB29.4090007@codeaurora.org>
 <20150206004210.GB8670@n2100.arm.linux.org.uk>
 <54D41A60.8040702@codeaurora.org>
 <20150206133920.GC8670@n2100.arm.linux.org.uk>
 <54D5164A.30503@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D5164A.30503@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Stephen Boyd (2015-02-06 11:30:18)
> On 02/06/15 05:39, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 05:35:28PM -0800, Stephen Boyd wrote:
> >
> >> From what I can tell this code is
> >> now broken because we made all clk getting functions (there's quite a
> >> few...) return unique pointers every time they're called. It seems that
> >> the driver wants to know if extclk and clk are the same so it can do
> >> something differently in kirkwood_set_rate(). Do we need some sort of
> >> clk_equal(struct clk *a, struct clk *b) function for drivers like this?
> > Well, the clocks in question are the SoC internal clock (which is more or
> > less fixed, but has a programmable divider) and an externally supplied
> > clock, and the IP has a multiplexer on its input which allows us to select
> > between those two sources.
> >
> > If it were possible to bind both to the same clock, it wouldn't be a
> > useful configuration - nothing would be gained from doing so in terms of
> > available rates.
> >
> > What the comparison is there for is to catch the case with legacy lookups
> > where a clkdev lookup entry with a NULL connection ID results in matching
> > any connection ID passed to clk_get().  If the patch changes this, then
> > we will have a regression - and this is something which needs fixing
> > _before_ we do this "return unique clocks".
> >
> 
> Ok. It seems that we might need a clk_equal() or similar API after all.
> My understanding is that this driver is calling clk_get() twice with
> NULL for the con_id and then "extclk" in attempts to get the SoC
> internal clock and the externally supplied clock. If we're using legacy
> lookups then both clk_get() calls may map to the same clk_lookup entry
> and before Tomeu's patch that returns unique clocks the driver could
> detect this case and know that there isn't an external clock. Looking at
> arch/arm/mach-dove/common.c it seems that there is only one lookup per
> device and it has a wildcard NULL for con_id so both clk_get() calls
> here are going to find the same lookup and get a unique struct clk pointer.
> 
> Why don't we make the legacy lookup more specific and actually indicate
> "internal" for the con_id? Then the external clock would fail to be
> found, but we can detect that case and figure out that it's not due to
> probe defer, but instead due to the fact that there really isn't any
> mapping. It looks like the code is already prepared for this anyway.
> 
> ----8<----
> 
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] ARM: dove: Remove wildcard from mvebu-audio device clk lookup
> 
> This i2s driver is using the wildcard nature of clkdev lookups to
> figure out if there's an external clock or not. It does this by
> calling clk_get() twice with NULL for the con_id first and then
> "external" for the con_id the second time around and then
> compares the two pointers. With DT the wildcard feature of
> clk_get() is gone and so the driver has to handle an error from
> the second clk_get() call as meaning "no external clock
> specified". Let's use that logic even with clk lookups to
> simplify the code and remove the struct clk pointer comparisons
> which may not work in the future when clk_get() returns unique
> pointers.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Russell et al,

I'm happy to take this patch through the clock tree (where the problem
shows up) with an ack.

Regards,
Mike

> ---
>  arch/arm/mach-dove/common.c       |  4 ++--
>  sound/soc/kirkwood/kirkwood-i2s.c | 13 ++++---------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 0d1a89298ece..f290fc944cc1 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -124,8 +124,8 @@ static void __init dove_clk_init(void)
>         orion_clkdev_add(NULL, "sdhci-dove.1", sdio1);
>         orion_clkdev_add(NULL, "orion_nand", nand);
>         orion_clkdev_add(NULL, "cafe1000-ccic.0", camera);
> -       orion_clkdev_add(NULL, "mvebu-audio.0", i2s0);
> -       orion_clkdev_add(NULL, "mvebu-audio.1", i2s1);
> +       orion_clkdev_add("internal", "mvebu-audio.0", i2s0);
> +       orion_clkdev_add("internal", "mvebu-audio.1", i2s1);
>         orion_clkdev_add(NULL, "mv_crypto", crypto);
>         orion_clkdev_add(NULL, "dove-ac97", ac97);
>         orion_clkdev_add(NULL, "dove-pdma", pdma);
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index def7d8260c4e..0bfeb712a997 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -564,7 +564,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>  
> -       priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
> +       priv->clk = devm_clk_get(&pdev->dev, "internal");
>         if (IS_ERR(priv->clk)) {
>                 dev_err(&pdev->dev, "no clock\n");
>                 return PTR_ERR(priv->clk);
> @@ -579,14 +579,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>                 if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
>                         return -EPROBE_DEFER;
>         } else {
> -               if (priv->extclk == priv->clk) {
> -                       devm_clk_put(&pdev->dev, priv->extclk);
> -                       priv->extclk = ERR_PTR(-EINVAL);
> -               } else {
> -                       dev_info(&pdev->dev, "found external clock\n");
> -                       clk_prepare_enable(priv->extclk);
> -                       soc_dai = kirkwood_i2s_dai_extclk;
> -               }
> +               dev_info(&pdev->dev, "found external clock\n");
> +               clk_prepare_enable(priv->extclk);
> +               soc_dai = kirkwood_i2s_dai_extclk;
>         }
>  
>         /* Some sensible defaults - this reflects the powerup values */
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
