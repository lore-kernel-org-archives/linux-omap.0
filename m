From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] clk: ti: dra7-atl-clock: fix child-node lookups
Date: Mon, 13 Nov 2017 22:15:13 +0200
Message-ID: <a35e8131-a726-0897-5f85-84ddd10d0b7e@ti.com>
References: <20171111162929.11722-1-johan@kernel.org>
 <20171111162929.11722-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171111162929.11722-2-johan@kernel.org>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/11/2017 06:29 PM, Johan Hovold wrote:
> Fix child node-lookup during probe, which ended up searching the whole
> device tree depth-first starting at parent rather than just matching on
> its children.
> 
> Note that the original premature free of the parent node has already
> been fixed separately, but that fix was apparently never backported to
> stable.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
> Fixes: 660e15519399 ("clk: ti: dra7-atl-clock: Fix of_node reference counting")
> Cc: stable <stable@vger.kernel.org>     # 3.16: 660e15519399
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/clk/ti/clk-dra7-atl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index 13eb04f72389..148815470431 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -274,8 +274,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
>  
>  		/* Get configuration for the ATL instances */
>  		snprintf(prop, sizeof(prop), "atl%u", i);
> -		of_node_get(node);
> -		cfg_node = of_find_node_by_name(node, prop);
> +		cfg_node = of_get_child_by_name(node, prop);
>  		if (cfg_node) {
>  			ret = of_property_read_u32(cfg_node, "bws",
>  						   &cdesc->bws);
> 


-- 
Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
