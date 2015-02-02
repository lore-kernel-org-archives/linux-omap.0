From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Mon, 02 Feb 2015 14:52:45 -0800
Message-ID: <54CFFFBD.60601@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFD0B1.2000003@ti.com> <20150202224139.421.84094@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150202224139.421.84094@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/02/15 14:41, Mike Turquette wrote:
> Quoting Tero Kristo (2015-02-02 11:32:01)
>> On 02/01/2015 11:24 PM, Mike Turquette wrote:
>>>
>>> AFAICT this doesn't break anything, but booting on OMAP3+ results in
>>> noisy WARNs.
>>>
>>> I think the correct fix is to replace clk_bypass and clk_ref pointers
>>> with a simple integer parent_index. In fact we already have this index.
>>> See how the pointers are populated in ti_clk_register_dpll:
>> The problem is we still need to be able to get runtime parent clock 
>> rates (the parent rate may change also), so simple index value is not 
>> sufficient. We need a handle of some sort to the bypass/ref clocks. The 
>> DPLL code generally requires knowledge of the bypass + reference clock 
>> rates to work properly, as it calculates the M/N values based on these.
> We can maybe introduce something like of_clk_get_parent_rate, as we have
> analogous stuff for getting parent names and indexes. Without
> introducing a new helper you could probably just do:
>
> 	clk_ref = clk_get_parent_by_index(dpll_clk, 0);
> 	ref_rate = clk_get_rate(clk_ref);
>
> 	clk_bypass = clk_get_parent_by_index(dpll_clk, 1);
> 	bypass_rate = clk_get_rate(clk_bypass);
>
> Currently the semantics around this call are weird. It seems like it
> would create a new struct clk pointer but it does not. So don't call
> clk_put on clk_ref and clk_bypass yet. That might change in the future
> as we iron out this brave new world that we all live in. Probably best
> to leave a FIXME in there.
>
> Stephen & Tomeu, let me know if I got any of that wrong.

The plan is to make clk_get_parent_by_index() return a clk_hw pointer
instead of a clk pointer (probably with a new
clk_get_parent_hw_by_index() API). Then drivers that are clk providers
can deal in struct clk_hw and clk consumers can deal in struct clk,
nicely splitting the API between consumers and providers on the
structures they use to interact with the framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
