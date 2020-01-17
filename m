From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2] clk: ti: dra7: fix parent for gmac_clkctrl
Date: Fri, 17 Jan 2020 16:05:08 +0200
Message-ID: <e1782af7-098e-4550-8c9c-9f90187df8f3@ti.com>
References: <20191221110004.9951-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20191221110004.9951-1-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 21/12/2019 13:00, Grygorii Strashko wrote:
> The parent clk for gmac clk ctrl has to be gmac_main_clk (125MHz) instead
> of dpll_gmac_ck (1GHz). This is caused incorrect CPSW MDIO operation.
> Hence, fix it.
> 
> Fixes: dffa9051d546 ('clk: ti: dra7: add new clkctrl data')
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   drivers/clk/ti/clk-7xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 9dd6185a4b4e..66e4b2b9ec60 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -405,7 +405,7 @@ static const struct omap_clkctrl_bit_data dra7_gmac_bit_data[] __initconst = {
>   };
>   
>   static const struct omap_clkctrl_reg_data dra7_gmac_clkctrl_regs[] __initconst = {
> -	{ DRA7_GMAC_GMAC_CLKCTRL, dra7_gmac_bit_data, CLKF_SW_SUP, "dpll_gmac_ck" },
> +	{ DRA7_GMAC_GMAC_CLKCTRL, dra7_gmac_bit_data, CLKF_SW_SUP, "gmac_main_clk" },

I think the gmac clk path is still somehow wrong after this change. This 
only fixes it partially imo.

Looking at TRM, gmac_main_clk is fed from dpll_gmac_x2_h12, but looking 
at the existing clock data, gmac_main_clk comes out from 
dpll_gmac_m2_ck. This potentially applies one extra divider to the path 
which appears wrong. Can you take a look at fixing the DTS side for this 
also?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
