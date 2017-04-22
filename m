From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: fix linker error with !SOC_OMAP4
Date: Fri, 21 Apr 2017 18:56:24 -0700
Message-ID: <20170422015624.GY7065@codeaurora.org>
References: <20170419214318.1605787-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419214318.1605787-1-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Richard Watts <rrw@kynesim.co.uk>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/19, Arnd Bergmann wrote:
> When none of the OMAP4-generation SoCs are enabled, we run into a link
> error for am43xx/am43xx:
> 
> drivers/clk/ti/dpll.o: In function `of_ti_am3_dpll_x2_setup':
> dpll.c:(.init.text+0xd8): undefined reference to `clkhwops_omap4_dpllmx'
> 
> This is easily fixed by adding another #ifdef.
> 
> While looking at the code, I also spotted another problem with the
> assignment of hw_ops variable that is not used again later. I'm
> changing this to setting clk_hw->ops instead, which I guess is what
> was intended here.
> 
> Fixes: 0565fb168d63 ("clk: ti: dpll: move omap3 DPLL functionality to clock driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
