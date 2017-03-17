From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 5/9] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
Date: Fri, 17 Mar 2017 08:41:26 -0700
Message-ID: <20170317154126.GU20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489741781-12816-6-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> -static int _init_main_clk(struct omap_hwmod *oh)
> +static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
>  {
>  	int ret = 0;
> -	char name[MOD_CLK_MAX_NAME_LEN];
> -	struct clk *clk;
> -	static const char modck[] = "_mod_ck";
> -
> -	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
> -		pr_warn("%s: warning: cropping name for %s\n", __func__,
> -			oh->name);
> +	struct clk *clk = NULL;
> +	int i;
> +	int count;
> +	const char *name;
> +	char clk_name[strlen("clkctrl-x") + 1];
>  
> -	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
> -	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
> +	if (np) {
> +		clk = of_clk_get_by_name(np, "clkctrl");
> +		if (IS_ERR(clk)) {
> +			/* Try matching by hwmod name */
> +			count = of_property_count_strings(np, "ti,hwmods");
> +			for (i = 0; i < count; i++) {
> +				ret = of_property_read_string_index(np,
> +								    "ti,hwmods",
> +								    i, &name);
> +				if (ret)
> +					continue;
> +				if (!strcmp(name, oh->name)) {
> +					sprintf(clk_name, "clkctrl-%d", i);
> +					clk = of_clk_get_by_name(np, clk_name);
> +				}
> +			}
> +		}
> +		if (!IS_ERR(clk)) {
> +			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
> +				 __clk_get_name(clk), oh->name);
> +			oh->main_clk = __clk_get_name(clk);
> +			oh->_clk = clk;
> +			soc_ops.disable_direct_prcm(oh);
> +		}
> +	}

You should bail out and do nothing here if legacy "ti,hwmods" property is
not found. Eventually it will be the interconnect target IP wrapper module
that will manage the clock and populate the rest of the hwmod data
dynamically.

Regards,

Tony
