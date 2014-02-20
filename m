From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] clk: ti: am335x: remove unecessary cpu0 clk node
Date: Thu, 20 Feb 2014 18:43:44 +0200
Message-ID: <530630C0.6050401@ti.com>
References: <1391019557-22313-1-git-send-email-nm@ti.com> <1391019557-22313-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391019557-22313-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/29/2014 08:19 PM, Nishanth Menon wrote:
> cpu0 clock node has no functionality, since cpufreq-cpu0 is already
> capable of picking up the clock from dts.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/clk/ti/clk-33xx.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
> index 776ee45..028b337 100644
> --- a/drivers/clk/ti/clk-33xx.c
> +++ b/drivers/clk/ti/clk-33xx.c
> @@ -34,7 +34,6 @@ static struct ti_dt_clk am33xx_clks[] = {
>   	DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
>   	DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
>   	DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
> -	DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
>   	DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
>   	DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
>   	DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
>
