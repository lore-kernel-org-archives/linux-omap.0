From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] clk: ti: dra7: fix parent for gmac_clkctrl
Date: Fri, 17 Jan 2020 16:49:08 +0200
Message-ID: <b448c468-5216-f599-7add-cefaf4f557db@ti.com>
References: <20191221110004.9951-1-grygorii.strashko@ti.com>
 <e1782af7-098e-4550-8c9c-9f90187df8f3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46918 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOtT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2020 09:49:19 -0500
In-Reply-To: <e1782af7-098e-4550-8c9c-9f90187df8f3@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org



On 17/01/2020 16:05, Tero Kristo wrote:
> On 21/12/2019 13:00, Grygorii Strashko wrote:
>> The parent clk for gmac clk ctrl has to be gmac_main_clk (125MHz) instead
>> of dpll_gmac_ck (1GHz). This is caused incorrect CPSW MDIO operation.
>> Hence, fix it.
>>
>> Fixes: dffa9051d546 ('clk: ti: dra7: add new clkctrl data')
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/clk/ti/clk-7xx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 9dd6185a4b4e..66e4b2b9ec60 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -405,7 +405,7 @@ static const struct omap_clkctrl_bit_data dra7_gmac_bit_data[] __initconst = {
>>   };
>>   static const struct omap_clkctrl_reg_data dra7_gmac_clkctrl_regs[] __initconst = {
>> -    { DRA7_GMAC_GMAC_CLKCTRL, dra7_gmac_bit_data, CLKF_SW_SUP, "dpll_gmac_ck" },
>> +    { DRA7_GMAC_GMAC_CLKCTRL, dra7_gmac_bit_data, CLKF_SW_SUP, "gmac_main_clk" },
> 
> I think the gmac clk path is still somehow wrong after this change. This only fixes it partially imo.
> 
> Looking at TRM, gmac_main_clk is fed from dpll_gmac_x2_h12, 

No, it seems not.
DPLL_GMAC.CLKOUT_M2 -> GMAC_250M_CLK -> 1/2 -> GMAC_MAIN_CLK

http://www.ti.com/lit/ug/sprui30f/sprui30f.pdf
3.6.3.12.1 DPLL_GMAC Overview
Figure 3-41. CM_CORE_AON Overview (b)
Figure 24-185. GMAC_SW Integration

but looking at the existing clock data, gmac_main_clk comes out from dpll_gmac_m2_ck. This potentially applies one extra divider to the path which appears wrong. Can you take a look at fixing the DTS side for this also?
> 
> -Tero
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Best regards,
grygorii
