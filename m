From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dra7: fix kernel boot with arg
 'clocksource=gp_timer'
Date: Fri, 15 Apr 2016 17:30:15 -0700
Message-ID: <20160416003015.GI26353@codeaurora.org>
References: <1449767025-2438-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449767025-2438-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: t-kristo@ti.com, Michael Turquette <mturquette@baylibre.com>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 12/10, Grygorii Strashko wrote:
> The OMAP Platform code provides possibility to select GP Timer as
> default clocksource instead of counter_32K by using bootcmd parameter
> 'clocksource', but the system will crash during early boot when this
> option is used on dra7 or omap5 platforms, because it will hit BUG()
> statement:
> 
>  omap2_gptimer_clocksource_init
>   ->BUG_ON(res);
> 
> This happens because clk_dev alias "sys_clkin_ck" is not registered.
> Hence, fix it by adding missing "sys_clkin_ck" clk_dev aliases
> definitions for omap5 and dra7.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
