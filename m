From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Wed, 30 Apr 2014 10:40:53 -0500
Message-ID: <CAGo_u6rj5c77+9ZkepePf+sOwXTc89GsND3KJhEYmcrVOvujzA@mail.gmail.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
	<1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
	<alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
	<alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
	<53172BA9.2050901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58242 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895AbaD3Pkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 11:40:55 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so1892059wev.33
        for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2014 08:40:53 -0700 (PDT)
In-Reply-To: <53172BA9.2050901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tomi,


On Wed, Mar 5, 2014 at 7:50 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

[...]
>
> From f5a78303411e9192899a6a681acac37f09f4cc3b Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Wed, 15 Jan 2014 11:45:07 +0200
> Subject: [PATCH] ARM: OMAP2+: fix dpll round_rate() to actually round
>
> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> the name and the description so hints. Instead it only tries to find an
> exact rate match, or if that fails, return ~0 as an error.
>
> What this basically means is that the user of the clock needs to know
> what rates the dpll can support, which obviously isn't right.
>
> This patch adds a simple method of rounding: during the iteration, the
> code keeps track of the closest rate match. If no exact match is found,
> the closest is returned.
>
> However, as it is unclear whether current drivers rely on the current
> behavior, the rounding functionality not enabled by default, but by
> setting DPLL_USE_ROUNDED_RATE for the DPLL.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/clkt_dpll.c | 23 ++++++++++++++++++-----
>  drivers/clk/ti/dpll.c           |  3 +++
>  include/linux/clk/ti.h          |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
> index 2649ce445845..fed7538e1eed 100644
> --- a/arch/arm/mach-omap2/clkt_dpll.c
> +++ b/arch/arm/mach-omap2/clkt_dpll.c
> @@ -298,6 +298,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>         struct dpll_data *dd;
>         unsigned long ref_rate;
>         const char *clk_name;
> +       unsigned long diff, closest_diff = ~0;
> +       bool use_rounding = clk->flags & DPLL_USE_ROUNDED_RATE;
>
>         if (!clk || !clk->dpll_data)
>                 return ~0;
> @@ -345,20 +347,31 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>                 pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
>                          clk_name, m, n, new_rate);
>
> -               if (target_rate == new_rate) {
> +               diff = max(target_rate, new_rate) - min(target_rate, new_rate);
> +
> +               if ((use_rounding && diff < closest_diff) ||
> +                       (!use_rounding && diff == 0)) {
> +                       closest_diff = diff;
> +
>                         dd->last_rounded_m = m;
>                         dd->last_rounded_n = n;
> -                       dd->last_rounded_rate = target_rate;
> -                       break;
> +                       dd->last_rounded_rate = new_rate;
> +
> +                       if (diff == 0)
> +                               break;
>                 }
>         }
>
> -       if (target_rate != new_rate) {
> +       if (closest_diff == ~0) {
>                 pr_debug("clock: %s: cannot round to rate %lu\n",
>                          clk_name, target_rate);
>                 return ~0;
>         }
>
> -       return target_rate;
> +       if (closest_diff > 0)
> +               pr_debug("clock: %s: rounded rate %lu to %lu\n",
> +                        clk_name, target_rate, dd->last_rounded_rate);
> +
> +       return dd->last_rounded_rate;
>  }
>

> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 7e498a44f97d..c5858c46b58c 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -265,6 +265,9 @@ static void __init of_ti_dpll_setup(struct device_node *node,
>         if (dpll_mode)
>                 dd->modes = dpll_mode;
>
> +       if (of_property_read_bool(node, "ti,round-rate"))
> +               clk_hw->flags |= DPLL_USE_ROUNDED_RATE;

binding is missing here -> Further, I'd suggest this be two patches:
a) introducing ti,round-rate (ti/dpll.c, clk/ti.h)
b) use it in clkt_dpll.c

> +
>         ti_clk_register_dpll(&clk_hw->hw, node);
>         return;
>
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index 092b64168d7f..c9ed8b6b8513 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -155,6 +155,7 @@ struct clk_hw_omap {
>  #define INVERT_ENABLE          (1 << 4)        /* 0 enables, 1 disables */
>  #define CLOCK_CLKOUTX2         (1 << 5)
>  #define MEMMAP_ADDRESSING      (1 << 6)
> +#define DPLL_USE_ROUNDED_RATE  (1 << 7)        /* dpll's round_rate() returns rounded rate */
>
>  /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
>  #define DPLL_LOW_POWER_STOP    0x1
> --
> 1.8.3.2
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
