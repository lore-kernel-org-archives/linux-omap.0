From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH] clk: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 11:35:46 +0200
Message-ID: <8acfb923-f584-49e8-3c76-d514b9dcc457@st.com>
References: <20170718214339.7774-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?Q?Emilio_L=c3=b3pez?= <emilio@elopez.com.ar>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.o
List-Id: linux-omap@vger.kernel.org



On 07/18/2017 11:42 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio López" <emilio@elopez.com.ar>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>   drivers/clk/berlin/bg2.c             |  3 +--
>   drivers/clk/berlin/bg2q.c            |  7 +++----
>   drivers/clk/clk-asm9260.c            |  4 ++--
>   drivers/clk/clk-conf.c               | 16 ++++++++--------
>   drivers/clk/clk-moxart.c             | 12 ++++++------
>   drivers/clk/clk-qoriq.c              |  7 +++----
>   drivers/clk/clk-stm32f4.c            |  4 ++--
>   drivers/clk/clk-xgene.c              | 15 ++++++---------
>   drivers/clk/clk.c                    |  4 ++--
>   drivers/clk/clkdev.c                 |  4 ++--
>   drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>   drivers/clk/mediatek/clk-mtk.c       |  2 +-
>   drivers/clk/mediatek/reset.c         |  2 +-
>   drivers/clk/renesas/clk-mstp.c       |  2 +-
>   drivers/clk/renesas/clk-rcar-gen2.c  |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun5i.c     |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun6i-a31.c |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun8i-a23.c |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun8i-a33.c |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun8i-h3.c  |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun8i-r.c   |  3 +--
>   drivers/clk/sunxi-ng/ccu-sun8i-v3s.c |  3 +--
>   drivers/clk/sunxi/clk-sunxi.c        | 17 +++++++----------
>   drivers/clk/tegra/clk-emc.c          | 12 +++++-------
>   drivers/clk/ti/clockdomain.c         |  4 ++--
>   25 files changed, 61 insertions(+), 80 deletions(-)

For clk/clk-stm32f4.c

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Regards
Alex

> 
> diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
> index 1d99292e2039..e7331ace0337 100644
> --- a/drivers/clk/berlin/bg2.c
> +++ b/drivers/clk/berlin/bg2.c
> @@ -679,8 +679,7 @@ static void __init berlin2_clock_setup(struct device_node *np)
>   		if (!IS_ERR(hws[n]))
>   			continue;
> 
> -		pr_err("%s: Unable to register leaf clock %d\n",
> -		       np->full_name, n);
> +		pr_err("%pOF: Unable to register leaf clock %d\n", np, n);
>   		goto bg2_fail;
>   	}
> 
> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
> index 3b784b593afd..67c270b143f7 100644
> --- a/drivers/clk/berlin/bg2q.c
> +++ b/drivers/clk/berlin/bg2q.c
> @@ -304,14 +304,14 @@ static void __init berlin2q_clock_setup(struct device_node *np)
> 
>   	gbase = of_iomap(parent_np, 0);
>   	if (!gbase) {
> -		pr_err("%s: Unable to map global base\n", np->full_name);
> +		pr_err("%pOF: Unable to map global base\n", np);
>   		return;
>   	}
> 
>   	/* BG2Q CPU PLL is not part of global registers */
>   	cpupll_base = of_iomap(parent_np, 1);
>   	if (!cpupll_base) {
> -		pr_err("%s: Unable to map cpupll base\n", np->full_name);
> +		pr_err("%pOF: Unable to map cpupll base\n", np);
>   		iounmap(gbase);
>   		return;
>   	}
> @@ -376,8 +376,7 @@ static void __init berlin2q_clock_setup(struct device_node *np)
>   		if (!IS_ERR(hws[n]))
>   			continue;
> 
> -		pr_err("%s: Unable to register leaf clock %d\n",
> -		       np->full_name, n);
> +		pr_err("%pOF: Unable to register leaf clock %d\n", np, n);
>   		goto bg2q_fail;
>   	}
> 
> diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
> index ea8568536193..bf0582cbbf38 100644
> --- a/drivers/clk/clk-asm9260.c
> +++ b/drivers/clk/clk-asm9260.c
> @@ -338,8 +338,8 @@ static void __init asm9260_acc_init(struct device_node *np)
>   		if (!IS_ERR(hws[n]))
>   			continue;
> 
> -		pr_err("%s: Unable to register leaf clock %d\n",
> -				np->full_name, n);
> +		pr_err("%pOF: Unable to register leaf clock %d\n",
> +				np, n);
>   		goto fail;
>   	}
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 7ec36722f8ab..49819b546134 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -23,8 +23,8 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>   	num_parents = of_count_phandle_with_args(node, "assigned-clock-parents",
>   						 "#clock-cells");
>   	if (num_parents == -EINVAL)
> -		pr_err("clk: invalid value of clock-parents property at %s\n",
> -		       node->full_name);
> +		pr_err("clk: invalid value of clock-parents property at %pOF\n",
> +		       node);
> 
>   	for (index = 0; index < num_parents; index++) {
>   		rc = of_parse_phandle_with_args(node, "assigned-clock-parents",
> @@ -41,8 +41,8 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>   		pclk = of_clk_get_from_provider(&clkspec);
>   		if (IS_ERR(pclk)) {
>   			if (PTR_ERR(pclk) != -EPROBE_DEFER)
> -				pr_warn("clk: couldn't get parent clock %d for %s\n",
> -					index, node->full_name);
> +				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
> +					index, node);
>   			return PTR_ERR(pclk);
>   		}
> 
> @@ -57,8 +57,8 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>   		clk = of_clk_get_from_provider(&clkspec);
>   		if (IS_ERR(clk)) {
>   			if (PTR_ERR(clk) != -EPROBE_DEFER)
> -				pr_warn("clk: couldn't get assigned clock %d for %s\n",
> -					index, node->full_name);
> +				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
> +					index, node);
>   			rc = PTR_ERR(clk);
>   			goto err;
>   		}
> @@ -102,8 +102,8 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>   			clk = of_clk_get_from_provider(&clkspec);
>   			if (IS_ERR(clk)) {
>   				if (PTR_ERR(clk) != -EPROBE_DEFER)
> -					pr_warn("clk: couldn't get clock %d for %s\n",
> -						index, node->full_name);
> +					pr_warn("clk: couldn't get clock %d for %pOF\n",
> +						index, node);
>   				return PTR_ERR(clk);
>   			}
> 
> diff --git a/drivers/clk/clk-moxart.c b/drivers/clk/clk-moxart.c
> index b86dac851116..2382426346a2 100644
> --- a/drivers/clk/clk-moxart.c
> +++ b/drivers/clk/clk-moxart.c
> @@ -30,7 +30,7 @@ static void __init moxart_of_pll_clk_init(struct device_node *node)
> 
>   	base = of_iomap(node, 0);
>   	if (!base) {
> -		pr_err("%s: of_iomap failed\n", node->full_name);
> +		pr_err("%pOF: of_iomap failed\n", node);
>   		return;
>   	}
> 
> @@ -39,13 +39,13 @@ static void __init moxart_of_pll_clk_init(struct device_node *node)
> 
>   	ref_clk = of_clk_get(node, 0);
>   	if (IS_ERR(ref_clk)) {
> -		pr_err("%s: of_clk_get failed\n", node->full_name);
> +		pr_err("%pOF: of_clk_get failed\n", node);
>   		return;
>   	}
> 
>   	hw = clk_hw_register_fixed_factor(NULL, name, parent_name, 0, mul, 1);
>   	if (IS_ERR(hw)) {
> -		pr_err("%s: failed to register clock\n", node->full_name);
> +		pr_err("%pOF: failed to register clock\n", node);
>   		return;
>   	}
> 
> @@ -70,7 +70,7 @@ static void __init moxart_of_apb_clk_init(struct device_node *node)
> 
>   	base = of_iomap(node, 0);
>   	if (!base) {
> -		pr_err("%s: of_iomap failed\n", node->full_name);
> +		pr_err("%pOF: of_iomap failed\n", node);
>   		return;
>   	}
> 
> @@ -83,13 +83,13 @@ static void __init moxart_of_apb_clk_init(struct device_node *node)
> 
>   	pll_clk = of_clk_get(node, 0);
>   	if (IS_ERR(pll_clk)) {
> -		pr_err("%s: of_clk_get failed\n", node->full_name);
> +		pr_err("%pOF: of_clk_get failed\n", node);
>   		return;
>   	}
> 
>   	hw = clk_hw_register_fixed_factor(NULL, name, parent_name, 0, 1, div);
>   	if (IS_ERR(hw)) {
> -		pr_err("%s: failed to register clock\n", node->full_name);
> +		pr_err("%pOF: failed to register clock\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index f3931e38fac0..4b7a6e3ba479 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -1348,8 +1348,7 @@ static void __init clockgen_init(struct device_node *np)
>   	}
> 
>   	if (i == ARRAY_SIZE(chipinfo)) {
> -		pr_err("%s: unknown clockgen node %s\n", __func__,
> -		       np->full_name);
> +		pr_err("%s: unknown clockgen node %pOF\n", __func__, np);
>   		goto err;
>   	}
>   	clockgen.info = chipinfo[i];
> @@ -1362,8 +1361,8 @@ static void __init clockgen_init(struct device_node *np)
>   		if (guts) {
>   			clockgen.guts = of_iomap(guts, 0);
>   			if (!clockgen.guts) {
> -				pr_err("%s: Couldn't map %s regs\n", __func__,
> -				       guts->full_name);
> +				pr_err("%s: Couldn't map %pOF regs\n", __func__,
> +				       guts);
>   			}
>   		}
> 
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 68e2a4e499f1..96c6b6bc8f0e 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -1541,8 +1541,8 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>   		    base + gd->offset, gd->bit_idx, 0, &stm32f4_clk_lock);
> 
>   		if (IS_ERR(clks[idx])) {
> -			pr_err("%s: Unable to register leaf clock %s\n",
> -			       np->full_name, gd->name);
> +			pr_err("%pOF: Unable to register leaf clock %s\n",
> +			       np, gd->name);
>   			goto fail;
>   		}
>   	}
> diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
> index bc37030e38ba..4c75821a3933 100644
> --- a/drivers/clk/clk-xgene.c
> +++ b/drivers/clk/clk-xgene.c
> @@ -192,7 +192,7 @@ static void xgene_pllclk_init(struct device_node *np, enum xgene_pll_type pll_ty
> 
>   	reg = of_iomap(np, 0);
>   	if (reg == NULL) {
> -		pr_err("Unable to map CSR register for %s\n", np->full_name);
> +		pr_err("Unable to map CSR register for %pOF\n", np);
>   		return;
>   	}
>   	of_property_read_string(np, "clock-output-names", &clk_name);
> @@ -409,12 +409,12 @@ static void xgene_pmdclk_init(struct device_node *np)
>   	/* Parse the DTS register for resource */
>   	rc = of_address_to_resource(np, 0, &res);
>   	if (rc != 0) {
> -		pr_err("no DTS register for %s\n", np->full_name);
> +		pr_err("no DTS register for %pOF\n", np);
>   		return;
>   	}
>   	csr_reg = of_iomap(np, 0);
>   	if (!csr_reg) {
> -		pr_err("Unable to map resource for %s\n", np->full_name);
> +		pr_err("Unable to map resource for %pOF\n", np);
>   		return;
>   	}
>   	of_property_read_string(np, "clock-output-names", &clk_name);
> @@ -703,16 +703,14 @@ static void __init xgene_devclk_init(struct device_node *np)
>   		rc = of_address_to_resource(np, i, &res);
>   		if (rc != 0) {
>   			if (i == 0) {
> -				pr_err("no DTS register for %s\n",
> -					np->full_name);
> +				pr_err("no DTS register for %pOF\n", np);
>   				return;
>   			}
>   			break;
>   		}
>   		map_res = of_iomap(np, i);
>   		if (map_res == NULL) {
> -			pr_err("Unable to map resource %d for %s\n",
> -				i, np->full_name);
> +			pr_err("Unable to map resource %d for %pOF\n", i, np);
>   			goto err;
>   		}
>   		if (strcmp(res.name, "div-reg") == 0)
> @@ -747,8 +745,7 @@ static void __init xgene_devclk_init(struct device_node *np)
>   	pr_debug("Add %s clock\n", clk_name);
>   	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
>   	if (rc != 0)
> -		pr_err("%s: could register provider clk %s\n", __func__,
> -			np->full_name);
> +		pr_err("%s: could register provider clk %pOF\n", __func__, np);
> 
>   	return;
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fc58c52a26b4..c8d83acda006 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3132,7 +3132,7 @@ int of_clk_add_provider(struct device_node *np,
>   	mutex_lock(&of_clk_mutex);
>   	list_add(&cp->link, &of_clk_providers);
>   	mutex_unlock(&of_clk_mutex);
> -	pr_debug("Added clock from %s\n", np->full_name);
> +	pr_debug("Added clock from %pOF\n", np);
> 
>   	ret = of_clk_set_defaults(np, true);
>   	if (ret < 0)
> @@ -3167,7 +3167,7 @@ int of_clk_add_hw_provider(struct device_node *np,
>   	mutex_lock(&of_clk_mutex);
>   	list_add(&cp->link, &of_clk_providers);
>   	mutex_unlock(&of_clk_mutex);
> -	pr_debug("Added clk_hw provider from %s\n", np->full_name);
> +	pr_debug("Added clk_hw provider from %pOF\n", np);
> 
>   	ret = of_clk_set_defaults(np, true);
>   	if (ret < 0)
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index bb8a77a5985f..6b2f29df3f70 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -77,8 +77,8 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
>   			break;
>   		} else if (name && index >= 0) {
>   			if (PTR_ERR(clk) != -EPROBE_DEFER)
> -				pr_err("ERROR: could not get clock %s:%s(%i)\n",
> -					np->full_name, name ? name : "", index);
> +				pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> +					np, name ? name : "", index);
>   			return clk;
>   		}
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> index edd8e6918050..8ed8c5963c7b 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -98,7 +98,7 @@ int __init mtk_clk_register_cpumuxes(struct device_node *node,
> 
>   	regmap = syscon_node_to_regmap(node);
>   	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
> +		pr_err("Cannot find regmap for %pOF: %ld\n", node,
>   		       PTR_ERR(regmap));
>   		return PTR_ERR(regmap);
>   	}
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 0541df78141c..9c0ae4278a94 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -114,7 +114,7 @@ int mtk_clk_register_gates(struct device_node *node,
> 
>   	regmap = syscon_node_to_regmap(node);
>   	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
> +		pr_err("Cannot find regmap for %pOF: %ld\n", node,
>   				PTR_ERR(regmap));
>   		return PTR_ERR(regmap);
>   	}
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 309049d41f1b..d3551d5efef2 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -72,7 +72,7 @@ void mtk_register_reset_controller(struct device_node *np,
> 
>   	regmap = syscon_node_to_regmap(np);
>   	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %s: %ld\n", np->full_name,
> +		pr_err("Cannot find regmap for %pOF: %ld\n", np,
>   				PTR_ERR(regmap));
>   		return;
>   	}
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index f1617dd044cb..500a9e4e03c4 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -335,7 +335,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>   	u32 ncells;
> 
>   	if (of_property_read_u32(np, "#power-domain-cells", &ncells)) {
> -		pr_warn("%s lacks #power-domain-cells\n", np->full_name);
> +		pr_warn("%pOF lacks #power-domain-cells\n", np);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
> index 51a2479ed5d7..0b2e56d0d94b 100644
> --- a/drivers/clk/renesas/clk-rcar-gen2.c
> +++ b/drivers/clk/renesas/clk-rcar-gen2.c
> @@ -407,8 +407,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
> 
>   	if (rcar_rst_read_mode_pins(&cpg_mode)) {
>   		/* Backward-compatibility with old DT */
> -		pr_warn("%s: failed to obtain mode pins from RST\n",
> -			np->full_name);
> +		pr_warn("%pOF: failed to obtain mode pins from RST\n", np);
>   		cpg_mode = rcar_gen2_read_mode_pins();
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/ccu-sun5i.c
> index 5372bf8be5e6..194d7bfffa53 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun5i.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
> @@ -976,8 +976,7 @@ static void __init sun5i_ccu_init(struct device_node *node,
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> index 4d6078fca9ac..8af434815fba 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> @@ -1217,8 +1217,7 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> index 8a753ed0426d..d93b452f0df9 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> @@ -716,8 +716,7 @@ static void __init sun8i_a23_ccu_setup(struct device_node *node)
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> index 10b38dc46f75..13eb5b23c5e7 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> @@ -777,8 +777,7 @@ static void __init sun8i_a33_ccu_setup(struct device_node *node)
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index 62e4f0d2b2fc..d1ab0d713fa6 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -1118,8 +1118,7 @@ static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> index e54816ec1dbe..71feb7b24e8a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> @@ -290,8 +290,7 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> index a34a78d7fb28..621b1cd996db 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> @@ -575,8 +575,7 @@ static void __init sun8i_v3s_ccu_setup(struct device_node *node)
> 
>   	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>   	if (IS_ERR(reg)) {
> -		pr_err("%s: Could not map the clock registers\n",
> -		       of_node_full_name(node));
> +		pr_err("%pOF: Could not map the clock registers\n", node);
>   		return;
>   	}
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index f2c9274b8bd5..aa4add580516 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -666,15 +666,14 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
> 
>   	reg = of_iomap(node, 0);
>   	if (!reg) {
> -		pr_err("Could not map registers for mux-clk: %s\n",
> -		       of_node_full_name(node));
> +		pr_err("Could not map registers for mux-clk: %pOF\n", node);
>   		return NULL;
>   	}
> 
>   	i = of_clk_parent_fill(node, parents, SUNXI_MAX_PARENTS);
>   	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
> -		pr_err("%s: could not read clock-output-names from \"%s\"\n",
> -		       __func__, of_node_full_name(node));
> +		pr_err("%s: could not read clock-output-names from \"%pOF\"\n",
> +		       __func__, node);
>   		goto out_unmap;
>   	}
> 
> @@ -797,16 +796,15 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
> 
>   	reg = of_iomap(node, 0);
>   	if (!reg) {
> -		pr_err("Could not map registers for mux-clk: %s\n",
> -		       of_node_full_name(node));
> +		pr_err("Could not map registers for mux-clk: %pOF\n", node);
>   		return;
>   	}
> 
>   	clk_parent = of_clk_get_parent_name(node, 0);
> 
>   	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
> -		pr_err("%s: could not read clock-output-names from \"%s\"\n",
> -		       __func__, of_node_full_name(node));
> +		pr_err("%s: could not read clock-output-names from \"%pOF\"\n",
> +		       __func__, node);
>   		goto out_unmap;
>   	}
> 
> @@ -1010,8 +1008,7 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
> 
>   	reg = of_iomap(node, 0);
>   	if (!reg) {
> -		pr_err("Could not map registers for divs-clk: %s\n",
> -		       of_node_full_name(node));
> +		pr_err("Could not map registers for divs-clk: %pOF\n", node);
>   		return NULL;
>   	}
> 
> diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
> index 74e7544f861b..11a5066e5c27 100644
> --- a/drivers/clk/tegra/clk-emc.c
> +++ b/drivers/clk/tegra/clk-emc.c
> @@ -378,7 +378,7 @@ static int load_one_timing_from_dt(struct tegra_clk_emc *tegra,
> 
>   	err = of_property_read_u32(node, "clock-frequency", &tmp);
>   	if (err) {
> -		pr_err("timing %s: failed to read rate\n", node->full_name);
> +		pr_err("timing %pOF: failed to read rate\n", node);
>   		return err;
>   	}
> 
> @@ -386,8 +386,7 @@ static int load_one_timing_from_dt(struct tegra_clk_emc *tegra,
> 
>   	err = of_property_read_u32(node, "nvidia,parent-clock-frequency", &tmp);
>   	if (err) {
> -		pr_err("timing %s: failed to read parent rate\n",
> -		       node->full_name);
> +		pr_err("timing %pOF: failed to read parent rate\n", node);
>   		return err;
>   	}
> 
> @@ -395,8 +394,7 @@ static int load_one_timing_from_dt(struct tegra_clk_emc *tegra,
> 
>   	timing->parent = of_clk_get_by_name(node, "emc-parent");
>   	if (IS_ERR(timing->parent)) {
> -		pr_err("timing %s: failed to get parent clock\n",
> -		       node->full_name);
> +		pr_err("timing %pOF: failed to get parent clock\n", node);
>   		return PTR_ERR(timing->parent);
>   	}
> 
> @@ -409,8 +407,8 @@ static int load_one_timing_from_dt(struct tegra_clk_emc *tegra,
>   		}
>   	}
>   	if (timing->parent_index == 0xff) {
> -		pr_err("timing %s: %s is not a valid parent\n",
> -		       node->full_name, __clk_get_name(timing->parent));
> +		pr_err("timing %pOF: %s is not a valid parent\n",
> +		       node, __clk_get_name(timing->parent));
>   		clk_put(timing->parent);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> index fbedc6a9fed0..07a805125e98 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -138,8 +138,8 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
>   	for (i = 0; i < num_clks; i++) {
>   		clk = of_clk_get(node, i);
>   		if (IS_ERR(clk)) {
> -			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
> -			       __func__, node->full_name, i, PTR_ERR(clk));
> +			pr_err("%s: Failed get %pOF' clock nr %d (%ld)\n",
> +			       __func__, node, i, PTR_ERR(clk));
>   			continue;
>   		}
>   		clk_hw = __clk_get_hw(clk);
> --
> 2.11.0
> 
