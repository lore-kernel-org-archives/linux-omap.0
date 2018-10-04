From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH RFC 1/2] clk: ti: add a usecount for autoidle
Date: Thu, 4 Oct 2018 17:40:06 +0300
Message-ID: <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004055147.23048-2-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004055147.23048-2-andreas@kemnade.info>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 04/10/18 08:51, Andreas Kemnade wrote:
> We have the scenario that first autoidle is disabled for all clocks,
> then it is disabled for selected ones and then enabled for all. So
> we should have some counting here, also according to the
> comment in  _setup_iclk_autoidle()
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/clk/ti/autoidle.c | 20 ++++++++++++--------
>   include/linux/clk/ti.h    |  1 +
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 7bb9afbe4058..be2ce42e4f33 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -48,8 +48,11 @@ int omap2_clk_deny_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->deny_idle)
> -		c->ops->deny_idle(c);
> +	if (c->ops && c->ops->deny_idle) {
> +		c->autoidle_count--;
> +		if (c->autoidle_count == -1)
> +			c->ops->deny_idle(c);

This code is racy as you have no locking in place. Please fix.

Also, this should be verified that it doesn't cause any PM regressions, 
I hope you have done that?

-Tero

> +	}
>   	return 0;
>   }
>   
> @@ -64,8 +67,11 @@ int omap2_clk_allow_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->allow_idle)
> -		c->ops->allow_idle(c);
> +	if (c->ops && c->ops->allow_idle) {
> +		c->autoidle_count++;
> +		if (c->autoidle_count == 0)
> +			c->ops->allow_idle(c);
> +	}
>   	return 0;
>   }
>   
> @@ -201,8 +207,7 @@ int omap2_clk_enable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->allow_idle)
> -			c->ops->allow_idle(c);
> +		omap2_clk_allow_idle(c->hw.clk);
>   
>   	_clk_generic_allow_autoidle_all();
>   
> @@ -223,8 +228,7 @@ int omap2_clk_disable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->deny_idle)
> -			c->ops->deny_idle(c);
> +		omap2_clk_deny_idle(c->hw.clk);
>   
>   	_clk_generic_deny_autoidle_all();
>   
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index a8faa38b1ed6..c460355419c0 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -159,6 +159,7 @@ struct clk_hw_omap {
>   	const char		*clkdm_name;
>   	struct clockdomain	*clkdm;
>   	const struct clk_hw_omap_ops	*ops;
> +	int autoidle_count;
>   };
>   
>   /*
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
