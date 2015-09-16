From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: clk-7xx: Remove hardwired ABE clock
 configuration
Date: Wed, 16 Sep 2015 09:42:33 +0300
Message-ID: <55F90F59.60102@ti.com>
References: <1440401702-32420-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68AC1.1040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <55F68AC1.1040807@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/14/2015 11:52 AM, Peter Ujfalusi wrote:
> Hi Tero,
>
> On 08/24/2015 10:35 AM, Peter Ujfalusi wrote:
>> The ABE related clocks should be configured via DT and not have it wired
>> inside of the kernel.
>
> can you take a look at this patch? It will not cause any regression since we
> do not have audio support mainline and the pending series does not need this
> part anymore.

This patch looks okay to me. So, you are saying this doesn't depend on 
anything? Isn't this causing any boot-time issues with the ABE DPLL left 
dangling with boot setup, potentially blocking PM? I am just wondering 
if we should group this patch with the rest of the audio support patches 
for dra7.

-Tero

>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Tero,
>>
>> the ABE PLL configuration can, and will be done for dra7xx in DT with the
>> assigned-clocks/rate/parent feature so no need to have this anymore.
>>
>> Regards,
>> Peter
>>
>>   drivers/clk/ti/clk-7xx.c | 18 +-----------------
>>   1 file changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 9b5b289e6334..a911d7de3377 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -18,7 +18,6 @@
>>
>>   #include "clock.h"
>>
>> -#define DRA7_DPLL_ABE_DEFFREQ				180633600
>>   #define DRA7_DPLL_GMAC_DEFFREQ				1000000000
>>   #define DRA7_DPLL_USB_DEFFREQ				960000000
>>
>> @@ -313,27 +312,12 @@ static struct ti_dt_clk dra7xx_clks[] = {
>>   int __init dra7xx_dt_clk_init(void)
>>   {
>>   	int rc;
>> -	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
>> +	struct clk *dpll_ck, *hdcp_ck;
>>
>>   	ti_dt_clocks_register(dra7xx_clks);
>>
>>   	omap2_clk_disable_autoidle_all();
>>
>> -	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
>> -	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
>> -	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
>> -
>> -	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
>> -	if (!rc)
>> -		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
>> -	if (rc)
>> -		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> -
>> -	dpll_ck = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
>> -	rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ * 2);
>> -	if (rc)
>> -		pr_err("%s: failed to configure ABE DPLL m2x2!\n", __func__);
>> -
>>   	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
>>   	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
>>   	if (rc)
>>
>
>

