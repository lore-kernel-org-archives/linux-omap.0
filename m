From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv3 08/35] clk: ti: fix ti_clk_get_reg_addr error handling
Date: Fri, 06 Mar 2015 11:18:21 -0800
Message-ID: <20150306191821.11109.2610@quantum>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37947 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbbCFTSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 14:18:41 -0500
Received: by iecrl12 with SMTP id rl12so5393331iec.5
        for <linux-omap@vger.kernel.org>; Fri, 06 Mar 2015 11:18:41 -0800 (PST)
In-Reply-To: <1424891085-10392-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2015-02-25 11:04:18)
> There is a case where NULL can be a valid return value for
> ti_clk_get_reg_addr, specifically the case where both the provider index
> and register offsets are zero. In this case, the current error checking
> against a NULL pointer will fail. Thus, change the API to return a
> ERR_PTR value in an error case, and change all the users of this API to
> check against IS_ERR instead.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Michael Turquette <mturquette@linaro.org>

Looks good to me.

Regards,
Mike

> ---
>  drivers/clk/ti/apll.c      |    5 +++--
>  drivers/clk/ti/autoidle.c  |    2 +-
>  drivers/clk/ti/clk.c       |    7 ++++---
>  drivers/clk/ti/divider.c   |    4 ++--
>  drivers/clk/ti/dpll.c      |    6 +++---
>  drivers/clk/ti/gate.c      |    4 ++--
>  drivers/clk/ti/interface.c |    2 +-
>  drivers/clk/ti/mux.c       |    4 ++--
>  8 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
> index 72d9727..49baf38 100644
> --- a/drivers/clk/ti/apll.c
> +++ b/drivers/clk/ti/apll.c
> @@ -203,7 +203,7 @@ static void __init of_dra7_apll_setup(struct device_node *node)
>         ad->control_reg = ti_clk_get_reg_addr(node, 0);
>         ad->idlest_reg = ti_clk_get_reg_addr(node, 1);
>  
> -       if (!ad->control_reg || !ad->idlest_reg)
> +       if (IS_ERR(ad->control_reg) || IS_ERR(ad->idlest_reg))
>                 goto cleanup;
>  
>         ad->idlest_mask = 0x1;
> @@ -384,7 +384,8 @@ static void __init of_omap2_apll_setup(struct device_node *node)
>         ad->autoidle_reg = ti_clk_get_reg_addr(node, 1);
>         ad->idlest_reg = ti_clk_get_reg_addr(node, 2);
>  
> -       if (!ad->control_reg || !ad->autoidle_reg || !ad->idlest_reg)
> +       if (IS_ERR(ad->control_reg) || IS_ERR(ad->autoidle_reg) ||
> +           IS_ERR(ad->idlest_reg))
>                 goto cleanup;
>  
>         clk = clk_register(NULL, &clk_hw->hw);
> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 8912ff8..e75c64c 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -119,7 +119,7 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
>         clk->name = node->name;
>         clk->reg = ti_clk_get_reg_addr(node, 0);
>  
> -       if (!clk->reg) {
> +       if (IS_ERR(clk->reg)) {
>                 kfree(clk);
>                 return -EINVAL;
>         }
> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
> index e22b956..0ebe5c5 100644
> --- a/drivers/clk/ti/clk.c
> +++ b/drivers/clk/ti/clk.c
> @@ -103,7 +103,8 @@ int __init ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
>   * @index: register index from the clock node
>   *
>   * Builds clock register address from device tree information. This
> - * is a struct of type clk_omap_reg.
> + * is a struct of type clk_omap_reg. Returns a pointer to the register
> + * address, or a pointer error value in failure.
>   */
>  void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
>  {
> @@ -121,14 +122,14 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
>  
>         if (i == CLK_MAX_MEMMAPS) {
>                 pr_err("clk-provider not found for %s!\n", node->name);
> -               return NULL;
> +               return ERR_PTR(-ENOENT);
>         }
>  
>         reg->index = i;
>  
>         if (of_property_read_u32_index(node, "reg", index, &val)) {
>                 pr_err("%s must have reg[%d]!\n", node->name, index);
> -               return NULL;
> +               return ERR_PTR(-EINVAL);
>         }
>  
>         reg->offset = val;
> diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
> index 6211893..ff5f117 100644
> --- a/drivers/clk/ti/divider.c
> +++ b/drivers/clk/ti/divider.c
> @@ -530,8 +530,8 @@ static int __init ti_clk_divider_populate(struct device_node *node,
>         u32 val;
>  
>         *reg = ti_clk_get_reg_addr(node, 0);
> -       if (!*reg)
> -               return -EINVAL;
> +       if (IS_ERR(*reg))
> +               return PTR_ERR(*reg);
>  
>         if (!of_property_read_u32(node, "ti,bit-shift", &val))
>                 *shift = val;
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 81dc469..11478a5 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -390,18 +390,18 @@ static void __init of_ti_dpll_setup(struct device_node *node,
>  #endif
>         } else {
>                 dd->idlest_reg = ti_clk_get_reg_addr(node, 1);
> -               if (!dd->idlest_reg)
> +               if (IS_ERR(dd->idlest_reg))
>                         goto cleanup;
>  
>                 dd->mult_div1_reg = ti_clk_get_reg_addr(node, 2);
>         }
>  
> -       if (!dd->control_reg || !dd->mult_div1_reg)
> +       if (IS_ERR(dd->control_reg) || IS_ERR(dd->mult_div1_reg))
>                 goto cleanup;
>  
>         if (dd->autoidle_mask) {
>                 dd->autoidle_reg = ti_clk_get_reg_addr(node, 3);
> -               if (!dd->autoidle_reg)
> +               if (IS_ERR(dd->autoidle_reg))
>                         goto cleanup;
>         }
>  
> diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
> index d493307..0c6fdfc 100644
> --- a/drivers/clk/ti/gate.c
> +++ b/drivers/clk/ti/gate.c
> @@ -225,7 +225,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
>  
>         if (ops != &omap_gate_clkdm_clk_ops) {
>                 reg = ti_clk_get_reg_addr(node, 0);
> -               if (!reg)
> +               if (IS_ERR(reg))
>                         return;
>  
>                 if (!of_property_read_u32(node, "ti,bit-shift", &val))
> @@ -264,7 +264,7 @@ _of_ti_composite_gate_clk_setup(struct device_node *node,
>                 return;
>  
>         gate->enable_reg = ti_clk_get_reg_addr(node, 0);
> -       if (!gate->enable_reg)
> +       if (IS_ERR(gate->enable_reg))
>                 goto cleanup;
>  
>         of_property_read_u32(node, "ti,bit-shift", &val);
> diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
> index 265d91f..c76230d 100644
> --- a/drivers/clk/ti/interface.c
> +++ b/drivers/clk/ti/interface.c
> @@ -111,7 +111,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
>         u32 val;
>  
>         reg = ti_clk_get_reg_addr(node, 0);
> -       if (!reg)
> +       if (IS_ERR(reg))
>                 return;
>  
>         if (!of_property_read_u32(node, "ti,bit-shift", &val))
> diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
> index 728e253..5cdeed5 100644
> --- a/drivers/clk/ti/mux.c
> +++ b/drivers/clk/ti/mux.c
> @@ -210,7 +210,7 @@ static void of_mux_clk_setup(struct device_node *node)
>  
>         reg = ti_clk_get_reg_addr(node, 0);
>  
> -       if (!reg)
> +       if (IS_ERR(reg))
>                 goto cleanup;
>  
>         of_property_read_u32(node, "ti,bit-shift", &shift);
> @@ -283,7 +283,7 @@ static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
>  
>         mux->reg = ti_clk_get_reg_addr(node, 0);
>  
> -       if (!mux->reg)
> +       if (IS_ERR(mux->reg))
>                 goto cleanup;
>  
>         if (!of_property_read_u32(node, "ti,bit-shift", &val))
> -- 
> 1.7.9.5
> 
