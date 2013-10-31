From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 01/43] clk: Add support for regmap register read/write
Date: Thu, 31 Oct 2013 16:40:21 +0200
Message-ID: <52726BD5.3080704@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-2-git-send-email-t-kristo@ti.com> <52726342.6030406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44335 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab3JaOkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 10:40:52 -0400
In-Reply-To: <52726342.6030406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/31/2013 04:03 PM, Nishanth Menon wrote:
> On 10/25/2013 10:56 AM, Tero Kristo wrote:
> [...]
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 7e59253..63ff78c 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>
> [...]
>> -static inline u32 clk_readl(u32 __iomem *reg)
>> +static inline u32 clk_readl(u32 __iomem *reg, struct regmap *regmap)
>>   {
>> -	return readl(reg);
>> +	u32 val;
>> +
>> +	if (regmap)
>> +		regmap_read(regmap, (u32)reg, &val);
>> +	else
>> +		val = readl(reg);
>> +	return val;
>>   }
>>
>> -static inline void clk_writel(u32 val, u32 __iomem *reg)
>> +static inline void clk_writel(u32 val, u32 __iomem *reg, struct regmap *regmap)
>>   {
>> -	writel(val, reg);
>> +	if (regmap)
>> +		regmap_write(regmap, (u32)reg, val);
>> +	else
>> +		writel(val, reg);
>>   }
>>
>>   #endif /* CONFIG_COMMON_CLK */
>>
>
> Might it not be better to introduce regmap variants?
> static inline void clk_regmap_writel(u32 val, u32 reg, struct regmap
> *regmap)
> and corresponding readl? that allows cleaner readability for clk
> drivers that use regmap and those that dont.

Well, doing that will introduce a lot of redundant code, as the checks 
for the presence of regmap must be copied all over the place. With this 
patch, all the generic clock drivers support internally both regmap or 
non-regmap register accesses.

> regmap can also return error value that could also be handled as a result.

True, however if the regmap fails for the clock code, not sure what we 
can do but panic. If this code is expanded, it is probably better to not 
inline it anymore.

-Tero

