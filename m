From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Wed, 20 May 2015 14:50:00 +0300
Message-ID: <555C74E8.5010105@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com> <555C744C.6070901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51620 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbbETLua (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 07:50:30 -0400
In-Reply-To: <555C744C.6070901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>

On 05/20/2015 02:47 PM, Tero Kristo wrote:
> On 05/06/2015 01:08 PM, Tomi Valkeinen wrote:
>> DESHDCP clock is needed on DRA7 based SoCs to enable the DSS IP. That
>> clock is an odd one, as it is not supposed to be any kind of core clock
>> for DSS, and we don't even support HDCP, but the clock is still needed
>> even for the HWMOD framework to be able to reset the DSS IP.
>>
>> As there's no support for multiple core clocks in the HWMOD framework,
>> we don't have any obvious place to enable this clock when DSS IP is
>> being enabled.
>>
>> Furthermore, the HDMI on OMAP5 DSS is the same as on DRA7, and OMAP5
>> does not have any such clock configuration bit. This suggests that on
>> OMAP5 the DESHDCP clock is always enabled, and for DRA7 we have the
>> possibility to gate it.
>>
>> So, as we don't have any clean way to enable and disable the clock
>> based on the need, this patch enables the clock at boot time, making it
>> work similarly to OMAP5.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/clk/ti/clk-7xx.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 2dd956b9affa..63b8323df918 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -312,7 +312,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
>>   int __init dra7xx_dt_clk_init(void)
>>   {
>>       int rc;
>> -    struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
>> +    struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
>>
>>       ti_dt_clocks_register(dra7xx_clks);
>>
>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
>>       if (rc)
>>           pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
>>
>> +    hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
>> +    rc = clk_prepare_enable(hdcp_ck);
>> +    if (rc)
>> +        pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>> +
>>       return rc;
>>   }
>>
>
> You should rather use the assigned-clock properties in DT to accomplish
> this, the manual clock tweaks under the drivers/clk/ti/clk-* files
> should be converted to DT setup also.

Now that I sent this, I realize we only have support to set_parent / 
set_rate through the assigned-clock props, no enable. Any plans to 
extend this support Mike/Stephen?

-Tero

>
> -Tero
>

