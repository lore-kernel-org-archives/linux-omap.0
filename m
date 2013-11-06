From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 01/43] clk: Add support for regmap register read/write
Date: Wed, 6 Nov 2013 12:54:53 +0200
Message-ID: <527A1FFD.1080506@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-2-git-send-email-t-kristo@ti.com> <52726342.6030406@ti.com> <52726BD5.3080704@ti.com> <20131105214320.GC17929@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47074 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab3KFKzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 05:55:22 -0500
In-Reply-To: <20131105214320.GC17929@book.gsilab.sittig.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/05/2013 11:43 PM, Gerhard Sittig wrote:
> On Thu, Oct 31, 2013 at 16:40 +0200, Tero Kristo wrote:
>>
>> On 10/31/2013 04:03 PM, Nishanth Menon wrote:
>>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>>> [...]
>>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>>> index 7e59253..63ff78c 100644
>>>> --- a/include/linux/clk-provider.h
>>>> +++ b/include/linux/clk-provider.h
>>>
>>> [...]
>>>> -static inline u32 clk_readl(u32 __iomem *reg)
>>>> +static inline u32 clk_readl(u32 __iomem *reg, struct regmap *regmap)
>>>>   {
>>>> -	return readl(reg);
>>>> +	u32 val;
>>>> +
>>>> +	if (regmap)
>>>> +		regmap_read(regmap, (u32)reg, &val);
>>>> +	else
>>>> +		val = readl(reg);
>>>> +	return val;
>>>>   }
>>>>
>>>> -static inline void clk_writel(u32 val, u32 __iomem *reg)
>>>> +static inline void clk_writel(u32 val, u32 __iomem *reg, struct regmap *regmap)
>>>>   {
>>>> -	writel(val, reg);
>>>> +	if (regmap)
>>>> +		regmap_write(regmap, (u32)reg, val);
>>>> +	else
>>>> +		writel(val, reg);
>>>>   }
>>>>
>>>>   #endif /* CONFIG_COMMON_CLK */
>>>>
>>>
>>> Might it not be better to introduce regmap variants?
>>> static inline void clk_regmap_writel(u32 val, u32 reg, struct regmap
>>> *regmap)
>>> and corresponding readl? that allows cleaner readability for clk
>>> drivers that use regmap and those that dont.
>>
>> Well, doing that will introduce a lot of redundant code, as the
>> checks for the presence of regmap must be copied all over the place.
>> With this patch, all the generic clock drivers support internally
>> both regmap or non-regmap register accesses.
>
> Please keep in mind that the "identity" of clk_readl() and
> readl() only applies in the current source code (ARM only use of
> common CCF primitives), while patches are pending (currently
> under review and receiving further improvement) which introduce
> several alternative implementations of clk_readl() depending on
> the platform.  Making all of them duplicate the "regmap vs direct
> register access" branch would be as bad.  Keeping one set of
> clk_readl() and clk_writel() routines and adding #ifdefs around
> the direct register access would be rather ugly, and I understand
> that preprocessor ifdef counts should get reduced instead of
> introduced.

So, it might be better to provide platform / or clock specific 
clk_reg_ops or something, so we can cover all the possible cases easily.

The requirement from TI SoC point of view is that:

1) need to be able to specify custom register read/write ops
2) need to be able to provide an index parameter to the read/write ops
3) need to be able to provide a register offset to the read/write ops

This could be done in following way for example:

clk_readl / clk_writel would be accessed through a single platform 
specific struct which provides function pointers to both.

The content of 'reg' provided to the clk_readl / clk_writel would be 
internally interpreted as a

struct omap_clk_reg_internal {
	u16 offset;
	u16 index;
};

... the index part would be used to select the appropriate regmap to 
use, and TI SoC:s would be using 3...4 regmaps for actually accessing 
the physical registers themselves.

-Tero

>
>
> virtually yours
> Gerhard Sittig
>

