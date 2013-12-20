From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv11 06/49] clk: add support for low level register ops
Date: Fri, 20 Dec 2013 13:17:27 +0200
Message-ID: <52B42747.8090408@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-7-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab3LTLR4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 06:17:56 -0500
In-Reply-To: <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/20/2013 01:00 PM, Paul Walmsley wrote:
> On Thu, 19 Dec 2013, Tero Kristo wrote:
>
>> Low level register ops are needed for providing SoC or IP block specific
>> access routines to clock registers. Subsequent patches add support for
>> the low level ops for the individual clock drivers.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> ...
>
>> ---
>>   drivers/clk/clk.c            |   28 ++++++++++++++++++++++++++++
>>   include/linux/clk-provider.h |   13 +++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 29281f6..23a742b 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -34,6 +34,34 @@ static HLIST_HEAD(clk_root_list);
>>   static HLIST_HEAD(clk_orphan_list);
>>   static LIST_HEAD(clk_notifier_list);
>>
>> +/**
>> + * clk_readl_default - default clock register read support function
>> + * @reg: register to read
>> + *
>> + * Default implementation for reading a clock register.
>> + */
>> +static u32 clk_readl_default(u32 __iomem *reg)
>
> Why u32 __iomem rather than void *?  Not that this will affect OMAP, but
> will this need to be changed later to support 64-bit addresses?
> __raw_writel() and __raw_readl() are defined with "void __iomem *" as
> their address argument, which will be 64 bits on arm64, correct?

Just copy pasting the current implementation from the clk-provider.h file.

However, pointer is pointer no? This is just used to refer to a 32bit 
value, the pointer itself can be either 32bit or 64bit. If the registers 
are changed to be 64 bit though.... but that will require changing most 
of the clock code as it is littered with 'u32 val;' type declarations.

Anyway, I can change this to be void __iomem.

>
>> +{
>> +	return readl(reg);
>> +}
>> +
>> +/**
>> + * clk_writel_default - default clock register write support function
>> + * @val: value to write
>> + * @reg: register to write to
>> + *
>> + * Default implementation for writing a clock register.
>> + */
>> +static void clk_writel_default(u32 val, u32 __iomem *reg)
>
> Same question as the above.
>
>> +{
>> +	writel(val, reg);
>> +}
>> +
>> +struct clk_ll_ops clk_ll_ops_default = {
>> +	.clk_readl = clk_readl_default,
>> +	.clk_writel = clk_writel_default
>> +};
>> +
>>   /***           locking             ***/
>>   static void clk_prepare_lock(void)
>>   {
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 27a9765..cc5bee0 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -199,6 +199,24 @@ struct clk_hw {
>>   	const struct clk_init_data *init;
>>   };
>>
>> +/**
>> + * struct clk_ll_ops - low-level register access ops for a clock
>> + *
>> + * @clk_readl: pointer to register read function
>
> Please remove the blank line above as mentioned before.

Yea I just copy pasted the comment sections....

>
>> + * @clk_writel: pointer to register write function
>> + *
>> + * Low-level register access ops are generally used by the basic clock types
>> + * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
>> + * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
>> + * used by other hardware-specific clock drivers if needed.
>> + */
>> +struct clk_ll_ops {
>> +	u32	(*clk_readl)(u32 __iomem *reg);
>> +	void	(*clk_writel)(u32 val, u32 __iomem *reg);
>> +};
>> +
>> +extern struct clk_ll_ops clk_ll_ops_default;
>> +
>>   /*
>>    * DOC: Basic clock implementations common to many platforms
>>    *
>> --
>> 1.7.9.5
>>
>
>
> - Paul
>

