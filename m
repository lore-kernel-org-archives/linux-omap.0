From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv10 01/41] clk: add support for platform specific clock I/O
 wrapper functions
Date: Sat, 14 Dec 2013 16:48:44 -0800
Message-ID: <20131215004844.26321.2882@quantum>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:53283 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3LOAss convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Dec 2013 19:48:48 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so2692812yho.30
        for <linux-omap@vger.kernel.org>; Sat, 14 Dec 2013 16:48:48 -0800 (PST)
In-Reply-To: <1385453182-24421-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Quoting Tero Kristo (2013-11-26 00:05:42)
> Current clock wrappers assume simple and direct mapped hardware register
> access. Improve this support by adding functionality for registering
> platform specific clock I/O wrappers, which can be used to support
> various features needed like endianess conversions, indexed regmap support,
> etc. Default I/O wrapper provided also which uses the existing direct
> I/O mapped behavior.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

There is a separate discussion on removing regmap for reading omap clk
registers. I guess this patch is not needed in that case?

Regards,
Mike

> ---
>  drivers/clk/clk.c            |   68 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h |   15 +++++-----
>  2 files changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2cf2ea6..c331386 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -34,6 +34,74 @@ static HLIST_HEAD(clk_root_list);
>  static HLIST_HEAD(clk_orphan_list);
>  static LIST_HEAD(clk_notifier_list);
>  
> +/**
> + * clk_readl_default - default clock register read support function
> + * @reg: register to read
> + *
> + * Default implementation for reading a clock register.
> + */
> +static u32 clk_readl_default(u32 __iomem *reg)
> +{
> +       return readl(reg);
> +}
> +
> +/**
> + * clk_writel_default - default clock register write support function
> + * @val: value to write
> + * @reg: register to write to
> + *
> + * Default implementation for writing a clock register.
> + */
> +static void clk_writel_default(u32 val, u32 __iomem *reg)
> +{
> +       writel(val, reg);
> +}
> +
> +struct clk_reg_ops clk_reg_ops_default = {
> +       .clk_readl = clk_readl_default,
> +       .clk_writel = clk_writel_default
> +};
> +
> +static struct clk_reg_ops *clk_reg_ops = &clk_reg_ops_default;
> +
> +/**
> + * clk_register_reg_ops - register access functions for clock registers
> + * @ops: register level ops
> + *
> + * Registers platform or SoC specific operations for reading / writing
> + * clock registers.
> + */
> +int clk_register_reg_ops(struct clk_reg_ops *ops)
> +{
> +       if (!ops)
> +               return -EINVAL;
> +       clk_reg_ops = ops;
> +       return 0;
> +}
> +
> +/**
> + * clk_readl - read a clock register value from hardware
> + * @reg: register to read
> + *
> + * Uses the registered clk_reg_ops to read a hardware clock register value.
> + */
> +u32 clk_readl(u32 __iomem *reg)
> +{
> +       return clk_reg_ops->clk_readl(reg);
> +}
> +
> +/**
> + * clk_writel - write a clock register value to hardware
> + * @val: value to write
> + * @reg: register to write
> + *
> + * Uses the registered clk_reg_ops to write a hardware clock register value.
> + */
> +void clk_writel(u32 val, u32 __iomem *reg)
> +{
> +       clk_reg_ops->clk_writel(val, reg);
> +}
> +
>  /***           locking             ***/
>  static void clk_prepare_lock(void)
>  {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7e59253..16e4df2 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -512,15 +512,14 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
>   * for improved portability across platforms
>   */
>  
> -static inline u32 clk_readl(u32 __iomem *reg)
> -{
> -       return readl(reg);
> -}
> +struct clk_reg_ops {
> +       u32 (*clk_readl)(u32 __iomem *reg);
> +       void (*clk_writel)(u32 val, u32 __iomem *reg);
> +};
>  
> -static inline void clk_writel(u32 val, u32 __iomem *reg)
> -{
> -       writel(val, reg);
> -}
> +u32 clk_readl(u32 __iomem *reg);
> +void clk_writel(u32 val, u32 __iomem *reg);
> +int clk_register_reg_ops(struct clk_reg_ops *ops);
>  
>  #endif /* CONFIG_COMMON_CLK */
>  #endif /* CLK_PROVIDER_H */
> -- 
> 1.7.9.5
> 
