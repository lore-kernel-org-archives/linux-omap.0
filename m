From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] clk: ti: dra7-atl-clock: Fix of_node reference counting
Date: Fri, 11 Mar 2016 14:19:27 -0600
Message-ID: <56E3284F.3070801@ti.com>
References: <1457705612-7684-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1457705612-7684-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 03/11/2016 08:13 AM, Peter Ujfalusi wrote:
> of_find_node_by_name() will call of_node_put() on the node so we need to
> get it first to avoid warnings.
> The cfg_node needs to be put after we have finished processing the
> properties.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/clk/ti/clk-dra7-atl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index 2e14dfb588f4..c77333230bdf 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -265,6 +265,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
>  
>  		/* Get configuration for the ATL instances */
>  		snprintf(prop, sizeof(prop), "atl%u", i);
> +		of_node_get(node);
>  		cfg_node = of_find_node_by_name(node, prop);
>  		if (cfg_node) {
>  			ret = of_property_read_u32(cfg_node, "bws",
> @@ -278,6 +279,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
>  				atl_write(cinfo, DRA7_ATL_AWSMUX_REG(i),
>  					  cdesc->aws);
>  			}
> +			of_node_put(cfg_node);
>  		}
>  
>  		cdesc->probed = true;
> 

Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
