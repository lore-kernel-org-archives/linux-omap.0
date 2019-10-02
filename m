From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: ti: dra7-atl-clock: Remove ti_clk_add_alias call
Date: Wed, 2 Oct 2019 11:21:55 +0300
Message-ID: <71d281e9-e834-6fb7-b16c-57500770aa54@ti.com>
References: <20190926104556.28716-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926104556.28716-1-peter.ujfalusi@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com
Cc: sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26/09/2019 13.45, Peter Ujfalusi wrote:
> ti_clk_register() calls it already so the driver should not create
> duplicated alias.

This patch will leave 'ret' as unused in of_dra7_atl_clock_setup(), I'll
send v2 in a minute or so.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/clk/ti/clk-dra7-atl.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index a01ca9395179..c0e0ee974151 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -207,11 +207,6 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
>  	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
>  
>  	if (!IS_ERR(clk)) {
> -		ret = ti_clk_add_alias(NULL, clk, node->name);
> -		if (ret) {
> -			clk_unregister(clk);
> -			goto cleanup;
> -		}
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>  		kfree(parent_names);
>  		return;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
