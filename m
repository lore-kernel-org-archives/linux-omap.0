From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] clk: ti: fix building without legacy omap3
Date: Fri, 21 Apr 2017 19:23:56 -0700
Message-ID: <20170422022356.GI7065@codeaurora.org>
References: <20170419174507.4055014-1-arnd@arndb.de>
 <20170419174507.4055014-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419174507.4055014-2-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/19, Arnd Bergmann wrote:
> When CONFIG_ATAGS or CONFIG_OMAP3 is disabled, we get a build error:
> 
> In file included from include/linux/clk-provider.h:15:0,
>                  from drivers/clk/ti/clk.c:19:
> drivers/clk/ti/clk.c: In function 'ti_clk_add_aliases':
> drivers/clk/ti/clk.c:438:29: error: 'simple_clk_match_table' undeclared (first use in this function); did you mean 'simple_attr_write'?
> 
> Moving the match table down fixes it.
> 
> Fixes: c17435c56bb1 ("clk: ti: add API for creating aliases automatically for simple clock types")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
