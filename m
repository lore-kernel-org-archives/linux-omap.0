From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clk: ti: dra7xx: Reset the mcasp3_ahclkx_mux clock value
Date: Wed, 6 Sep 2017 18:59:46 +0530
Message-ID: <46878cd0-9f7c-dc34-e230-8c4a11bcb096@ti.com>
References: <1504694199-32227-1-git-send-email-j-keerthy@ti.com>
 <26063901-be4f-dbe3-514b-e9a1a8ab3b10@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26063901-be4f-dbe3-514b-e9a1a8ab3b10@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 06 September 2017 05:12 PM, Tero Kristo wrote:
> On 06/09/17 13:36, Keerthy wrote:
>> Reset the mcasp3_ahclkx_mux to abe_24m_fclk. This is needed
>> in case of kexec where the reset values might be wiped off.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Why not do this in DT with the assigned-clock-xyz properties available?

Works for me. I will send a v2 with your suggested-by.

Thanks,
Keerthy

> 
> -Tero
> 
>> ---
>>   drivers/clk/ti/clk-7xx.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 9fd6043..2c3a36c 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -312,7 +312,7 @@
>>   int __init dra7xx_dt_clk_init(void)
>>   {
>>       int rc;
>> -    struct clk *dpll_ck, *hdcp_ck;
>> +    struct clk *dpll_ck, *hdcp_ck, *mcasp3_ahclkx_ck, *abe_ck;
>>         ti_dt_clocks_register(dra7xx_clks);
>>   @@ -338,5 +338,12 @@ int __init dra7xx_dt_clk_init(void)
>>       if (rc)
>>           pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>>   +    mcasp3_ahclkx_ck = clk_get_sys(NULL, "mcasp3_ahclkx_mux");
>> +    abe_ck = clk_get_sys(NULL, "abe_24m_fclk");
>> +    rc = clk_set_parent(mcasp3_ahclkx_ck, abe_ck);
>> +    if (rc)
>> +        pr_err("%s: failed to set parent for mcasp3_ahclkx_mux\n",
>> +               __func__);
>> +
>>       return rc;
>>   }
>>
> 
