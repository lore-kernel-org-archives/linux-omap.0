From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2] clk: ti: dra7: fix parent for gmac_clkctrl
Date: Tue, 21 Jan 2020 09:34:00 +0200
Message-ID: <df59b0b4-abc0-bab1-78d4-35518c295e06@ti.com>
References: <20191221110004.9951-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56108 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUHeI (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 02:34:08 -0500
In-Reply-To: <20191221110004.9951-1-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org

On 21/12/2019 13:00, Grygorii Strashko wrote:
> The parent clk for gmac clk ctrl has to be gmac_main_clk (125MHz) instead
> of dpll_gmac_ck (1GHz). This is caused incorrect CPSW MDIO operation.
> Hence, fix it.
> 
> Fixes: dffa9051d546 ('clk: ti: dra7: add new clkctrl data')
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Queued up for 5.6, thanks.

-Tero

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
>   	{ 0 },
>   };
>   
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
