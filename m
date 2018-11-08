From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] clk: ti: add a usecount for autoidle
Date: Thu, 8 Nov 2018 12:36:35 +0200
Message-ID: <23cbfc19-20d9-99f0-c086-e782cc36de34@ti.com>
References: <20181004203817.22101-1-andreas@kemnade.info>
 <20181004203817.22101-2-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004203817.22101-2-andreas@kemnade.info>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On 04/10/2018 23:38, Andreas Kemnade wrote:
> We have the scenario that first autoidle is disabled for all clocks,
> then it is disabled for selected ones and then enabled for all. So
> we should have some counting here, also according to the
> comment in  _setup_iclk_autoidle()
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++--------
>   include/linux/clk/ti.h    |  1 +
>   2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 7bb9afbe4058..bb6cff168e73 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -37,6 +37,14 @@ struct clk_ti_autoidle {
>   static LIST_HEAD(autoidle_clks);
>   static LIST_HEAD(clk_hw_omap_clocks);
>   
> +/*
> + * we have some non-atomic read/write
> + * operations behind it, so lets
> + * take one mutex for handling autoidle
> + * of all clocks
> + */
> +static DEFINE_MUTEX(autoidle_mutex);

Why mutex? This prevents calling the autoidle APIs from atomic context. 
Did you check the mutex debug kernel configs with this?

This may cause problems with the runtime PM entries to the code at least.


> +
>   /**
>    * omap2_clk_deny_idle - disable autoidle on an OMAP clock
>    * @clk: struct clk * to disable autoidle for
> @@ -48,8 +56,13 @@ int omap2_clk_deny_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->deny_idle)
> -		c->ops->deny_idle(c);
> +	if (c->ops && c->ops->deny_idle) {
> +		mutex_lock(&autoidle_mutex);
> +		c->autoidle_count--;
> +		if (c->autoidle_count == -1)

I think you should swap the arithmetics here, all the other usecounters 
use positive values, here you enter deep to the negative side when 
autoidle is denied by multiple users, which might be confusing.

-Tero

> +			c->ops->deny_idle(c);
> +		mutex_unlock(&autoidle_mutex);
> +	}
>   	return 0;
>   }
>   
> @@ -64,8 +77,13 @@ int omap2_clk_allow_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->allow_idle)
> -		c->ops->allow_idle(c);
> +	if (c->ops && c->ops->allow_idle) {
> +		mutex_lock(&autoidle_mutex);
> +		c->autoidle_count++;
> +		if (c->autoidle_count == 0)
> +			c->ops->allow_idle(c);
> +		mutex_unlock(&autoidle_mutex);
> +	}
>   	return 0;
>   }
>   
> @@ -201,8 +219,7 @@ int omap2_clk_enable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->allow_idle)
> -			c->ops->allow_idle(c);
> +		omap2_clk_allow_idle(c->hw.clk);
>   
>   	_clk_generic_allow_autoidle_all();
>   
> @@ -223,8 +240,7 @@ int omap2_clk_disable_autoidle_all(void)
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
