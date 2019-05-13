From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: Remove unused function
 ti_clk_build_component_gate
Date: Mon, 13 May 2019 10:22:24 +0300
Message-ID: <5315442d-fd29-1fbe-694d-07627cc43c25@ti.com>
References: <20190512100328.27136-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512100328.27136-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/05/2019 13:03, YueHaibing wrote:
> There is no callers in tree, so can be removed.

Looks ok to me, basically legacy code that we forgot to remove while doing:

commit 7558562a70fbd6b3fa746fa33c76c9333aa0bb32
Author: Tony Lindgren <tony@atomide.com>
Date:   Thu Dec 14 08:32:06 2017 -0800

     clk: ti: Drop legacy clk-3xxx-legacy code

Could drop the same code for mux/div also though.

-Tero

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/clk/ti/gate.c | 30 ------------------------------
>   1 file changed, 30 deletions(-)
> 
> diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
> index 504c0e9..4238955 100644
> --- a/drivers/clk/ti/gate.c
> +++ b/drivers/clk/ti/gate.c
> @@ -131,36 +131,6 @@ static struct clk *_register_gate(struct device *dev, const char *name,
>   	return clk;
>   }
>   
> -struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
> -{
> -	struct clk_hw_omap *gate;
> -	struct clk_omap_reg *reg;
> -	const struct clk_hw_omap_ops *ops = &clkhwops_wait;
> -
> -	if (!setup)
> -		return NULL;
> -
> -	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> -	if (!gate)
> -		return ERR_PTR(-ENOMEM);
> -
> -	reg = (struct clk_omap_reg *)&gate->enable_reg;
> -	reg->index = setup->module;
> -	reg->offset = setup->reg;
> -
> -	gate->enable_bit = setup->bit_shift;
> -
> -	if (setup->flags & CLKF_NO_WAIT)
> -		ops = NULL;
> -
> -	if (setup->flags & CLKF_INTERFACE)
> -		ops = &clkhwops_iclk_wait;
> -
> -	gate->ops = ops;
> -
> -	return &gate->hw;
> -}
> -
>   static void __init _of_ti_gate_clk_setup(struct device_node *node,
>   					 const struct clk_ops *ops,
>   					 const struct clk_hw_omap_ops *hw_ops)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
