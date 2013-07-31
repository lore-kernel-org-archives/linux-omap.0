From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 16/33] CLK: OMAP: DPLL: do not of_iomap NULL autoidle
 register
Date: Wed, 31 Jul 2013 17:57:56 +0300
Message-ID: <51F925F4.2000308@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-17-git-send-email-t-kristo@ti.com> <51F818CB.4060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36412 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3GaO6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 10:58:24 -0400
In-Reply-To: <51F818CB.4060007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/30/2013 10:49 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>> AM33xx series SoCs do not have autoidle support, and for these the
>> autoidle register is marked as NULL. Check against a NULL pointer and
>> do not attempt to of_iomap in this case, as this just creates a bogus
>> pointer and causes a kernel crash during boot.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/omap/dpll.c |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
>> index 1d24feada..d8a958a 100644
>> --- a/drivers/clk/omap/dpll.c
>> +++ b/drivers/clk/omap/dpll.c
>> @@ -162,6 +162,7 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>       u32 max_multiplier = 2047;
>>       u32 max_divider = 128;
>>       u32 min_divider = 1;
>> +    u32 val;
>>       int i;
>>
>>       dd = kzalloc(sizeof(struct dpll_data), GFP_KERNEL);
>> @@ -210,7 +211,14 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>
>>       dd->control_reg = of_iomap(node, 0);
>>       dd->idlest_reg = of_iomap(node, 1);
>> -    dd->autoidle_reg = of_iomap(node, 2);
>> +    /*
>> +     * AM33xx DPLLs have no autoidle support, and the autoidle reg
>> +     * for these is NULL. Do not attempt to of_iomap in this case,
>> +     * as this just creates a bogus pointer and crashes the kernel.
>> +     */
>> +    of_property_read_u32_index(node, "reg", 2 * 2, &val);
>> +    if (val)
>> +        dd->autoidle_reg = of_iomap(node, 2);
> should we not do that for all the parameters?

Maybe do the check for all.

> OR:
> move this as index 3 which is optional and is not defined for am33xx?
>
>>       dd->mult_div1_reg = of_iomap(node, 3);
>
>>
>>       dd->idlest_mask = idlest_mask;
>>
> we could probably squash this in original dpll.c as a result?
>

Yea, can do that also.

