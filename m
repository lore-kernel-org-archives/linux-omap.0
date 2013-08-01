From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 19/33] CLK: omap: add am33xx clock init file
Date: Thu, 1 Aug 2013 18:35:30 +0300
Message-ID: <51FA8042.50603@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-20-git-send-email-t-kristo@ti.com> <51F81B68.2020708@ti.com> <51F92640.70305@ti.com> <51FA740D.80408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46775 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab3HAPf4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 11:35:56 -0400
In-Reply-To: <51FA740D.80408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/01/2013 05:43 PM, Nishanth Menon wrote:
> On 07/31/2013 09:59 AM, Tero Kristo wrote:
>> On 07/30/2013 11:00 PM, Nishanth Menon wrote:
>>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
> [...]
>
>>>> diff --git a/drivers/clk/omap/clk-33xx.c b/drivers/clk/omap/clk-33xx.c
>>>> new file mode 100644
>>>> index 0000000..3ada30e
>>>> --- /dev/null
>>>> +++ b/drivers/clk/omap/clk-33xx.c
>>> [...]
>>>> +static const char *enable_init_clks[] = {
>>>> +    "dpll_ddr_m2_ck",
>>>> +    "dpll_mpu_m2_ck",
>>>> +    "l3_gclk",
>>>> +    "l4hs_gclk",
>>>> +    "l4fw_gclk",
>>>> +    "l4ls_gclk",
>>>> +    /* Required for external peripherals like, Audio codecs */
>>>> +    "clkout2_ck",
>>>> +};
>>>
>>> should be a sort of dt property?
>>>
>>
>> Future dev maybe?
>>
>> I try to avoid adding too many new props with this set....
>
> it should be trivial to add it in, no? these are the stuff we will have
> to do for a clean omap conversion to dt :( - we can work through the
> details as we present it with Mike on RFCs.

Problem with generic props is that they potentially take longer time to 
get in, and we are quite in a hurry with this set.

And these things can be added later.

-Tero
