From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/27] clk: ti: add support for clkctrl aliases
Date: Mon, 6 Nov 2017 14:07:15 -0800
Message-ID: <20171106220715.GA22441@codeaurora.org>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-4-git-send-email-t-kristo@ti.com>
 <20171103152703.GU11011@codeaurora.org>
 <b8090db5-48e7-07a2-223c-ead8662d36cb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8090db5-48e7-07a2-223c-ead8662d36cb@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 11/06, Tero Kristo wrote:
> On 03/11/17 17:27, Stephen Boyd wrote:
> >On 10/30, Tero Kristo wrote:
> >>+		}
> >>+
> >>+		if (num_args && clkctrl_nodes_missing)
> >>+			continue;
> >>+
> >>+		node = of_find_node_by_name(NULL, buf);
> >>+		if (num_args)
> >>+			node = of_find_node_by_name(node, "clk");
> >>  		clkspec.np = node;
> >>+		clkspec.args_count = num_args;
> >>+		for (i = 0; i < num_args; i++) {
> >>+			ret = kstrtoint(tags[i], i ? 10 : 16, clkspec.args + i);
> >
> >Is this some sort of DT checker?
> 
> Not really, it just parses a string of format:
> 
> <clkctrl_provider>:<hex-offset>:<bit-offset>.
> 
> ... so that it can find a matching clock. Needed temporarily for
> omap_hwmod backwards compatibility. This piece can be removed once
> hwmod is gone.
> 
> I can add some comment along these lines to the code if you want.
> 

No need. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
