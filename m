From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/27] clk: ti: add support for clkctrl aliases
Date: Fri, 3 Nov 2017 08:27:03 -0700
Message-ID: <20171103152703.GU11011@codeaurora.org>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509368685-29112-4-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 10/30, Tero Kristo wrote:
> +		}
> +
> +		if (num_args && clkctrl_nodes_missing)
> +			continue;
> +
> +		node = of_find_node_by_name(NULL, buf);
> +		if (num_args)
> +			node = of_find_node_by_name(node, "clk");
>  		clkspec.np = node;
> +		clkspec.args_count = num_args;
> +		for (i = 0; i < num_args; i++) {
> +			ret = kstrtoint(tags[i], i ? 10 : 16, clkspec.args + i);

Is this some sort of DT checker?

> +			if (ret) {
> +				pr_warn("Bad tag in %s at %d: %s\n",
> +					c->node_name, i, tags[i]);
> +				return;
> +			}
> +		}
>  		clk = of_clk_get_from_provider(&clkspec);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
