From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 07/43] CLK: TI: add autoidle support
Date: Mon, 4 Nov 2013 12:00:34 +0200
Message-ID: <52777042.40703@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-8-git-send-email-t-kristo@ti.com> <52727FDA.7060009@ti.com> <527371F5.9080702@ti.com> <5273FDF1.6090405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab3KDKBG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Nov 2013 05:01:06 -0500
In-Reply-To: <5273FDF1.6090405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 09:16 PM, Nishanth Menon wrote:
> On 11/01/2013 04:18 AM, Tero Kristo wrote:
>> On 10/31/2013 06:05 PM, Nishanth Menon wrote:
>>> On 10/25/2013 10:57 AM, Tero Kristo wrote:
>
> [...]
>>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
>>>> new file mode 100644
>>>> index 0000000..efa2a3e
>>>> --- /dev/null
>>>> +++ b/drivers/clk/ti/autoidle.c
> [...]
>>>> +}
>>>> +
>>>> +static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
>>>> +{
>>>> +	u32 val;
>>>> +
>>>> +	regmap_read(clk->regmap, clk->reg, &val);
>>>> +
>>>> +	if (clk->flags & AUTOIDLE_LOW)
>>>> +		val |= (1 << clk->shift);
>>>> +	else
>>>> +		val &= ~(1 << clk->shift);
>>>> +
>>>> +	regmap_write(clk->regmap, clk->reg, val);
>>> regmap_update_bits ?
>>
>> Same.
>>
>>>
>>> and ofcourse error handling for regmap ops..
>>
>> What do you propose to do in error case? Panic, WARN() or just printk?
>
> return error to caller and percolate back up the call stack.

Ok can do that.

> one other thing I missed, will be nice to introduce a common bindings
> for autoidle which tends to be reused in other drivers..

You mean documentation or? Autoidle from this patch is only used by two 
clock drivers (divider + fixed-factor.) DPLLs use completely different 
setup. Converting the interface clocks to use the same might be rather 
nasty thing to do.

-Tero
