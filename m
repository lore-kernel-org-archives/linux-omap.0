From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: dra7: fix kernel boot with arg
 'clocksource=gp_timer'
Date: Wed, 13 Apr 2016 15:50:40 +0300
Message-ID: <570E40A0.1040107@ti.com>
References: <1449767025-2438-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1449767025-2438-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Michael Turquette <mturquette@baylibre.com>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 12/10/2015 07:03 PM, Grygorii Strashko wrote:
> The OMAP Platform code provides possibility to select GP Timer as
> default clocksource instead of counter_32K by using bootcmd parameter
> 'clocksource', but the system will crash during early boot when this
> option is used on dra7 or omap5 platforms, because it will hit BUG()
> statement:
>
>   omap2_gptimer_clocksource_init
>    ->BUG_ON(res);
>
> This happens because clk_dev alias "sys_clkin_ck" is not registered.
> Hence, fix it by adding missing "sys_clkin_ck" clk_dev aliases
> definitions for omap5 and dra7.
>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Seems this was lost on the mailing lists. Stephen, want to pick this up 
also? You were going to pick some other TI clock patches also for 4.7.

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/clk/ti/clk-54xx.c | 1 +
>   drivers/clk/ti/clk-7xx.c  | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
> index 59ce2fa..294bc03 100644
> --- a/drivers/clk/ti/clk-54xx.c
> +++ b/drivers/clk/ti/clk-54xx.c
> @@ -210,6 +210,7 @@ static struct ti_dt_clk omap54xx_clks[] = {
>   	DT_CLK("usbhs_omap", "usbtll_fck", "dummy_ck"),
>   	DT_CLK("omap_wdt", "ick", "dummy_ck"),
>   	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
> +	DT_CLK(NULL, "sys_clkin_ck", "sys_clkin"),
>   	DT_CLK("4ae18000.timer", "timer_sys_ck", "sys_clkin"),
>   	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin"),
>   	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin"),
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index a911d7d..87a87b5 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -289,6 +289,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
>   	DT_CLK("usbhs_omap", "usbtll_fck", "dummy_ck"),
>   	DT_CLK("omap_wdt", "ick", "dummy_ck"),
>   	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
> +	DT_CLK(NULL, "sys_clkin_ck", "timer_sys_clk_div"),
>   	DT_CLK("4ae18000.timer", "timer_sys_ck", "timer_sys_clk_div"),
>   	DT_CLK("48032000.timer", "timer_sys_ck", "timer_sys_clk_div"),
>   	DT_CLK("48034000.timer", "timer_sys_ck", "timer_sys_clk_div"),
>

