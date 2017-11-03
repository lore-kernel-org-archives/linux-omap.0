From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/27] clk: ti: clkctrl: add support for retrying failed
 init
Date: Fri, 3 Nov 2017 10:04:20 -0700
Message-ID: <20171103170420.GW11011@codeaurora.org>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509368685-29112-6-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 10/30, Tero Kristo wrote:
> @@ -508,7 +515,11 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>  		reg_data++;
>  	}
>  
> -	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
> +	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
> +	if (ret == -EPROBE_DEFER)
> +		ti_clk_retry_init(node, (void *)provider,

You need the cast? The type of ti_clk_retry_init's second
parameter should probably be a void pointer instead.

> +				  (ti_of_clk_init_cb_t)_clkctrl_add_provider);
> +
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
