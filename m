From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv12 06/49] clk: add support for low level register ops
Date: Fri, 3 Jan 2014 11:13:55 +0200
Message-ID: <52C67F53.6000402@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com> <1387557274-22583-6-git-send-email-t-kristo@ti.com> <20131222173926.GB8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45387 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaACJOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jan 2014 04:14:32 -0500
In-Reply-To: <20131222173926.GB8064@book.gsilab.sittig.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>

On 12/22/2013 07:39 PM, Gerhard Sittig wrote:
> [ added agust@ for mpc5xxx, dropped devicetree ]
>
> On Fri, Dec 20, 2013 at 18:34 +0200, Tero Kristo wrote:
>>
>> Low level register ops are needed for providing SoC or IP block specific
>> access routines to clock registers. Subsequent patches add support for
>> the low level ops for the individual clock drivers.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/clk.c            |   28 ++++++++++++++++++++++++++++
>>   include/linux/clk-provider.h |   17 +++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 29281f6..8bcd1e0 100644
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
>> +static u32 clk_readl_default(void __iomem *reg)
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
>> +static void clk_writel_default(u32 val, void __iomem *reg)
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
>
> Mike, Anatolij, this is a HEADS UP for the clock and mpc5xxx
> maintainers:  This patch will break the recently introduced CCF
> support for MPC512x (currently sitting in -next, to get merged
> for 3.14), and requires some adjustment.
>
> Either the clk_{read,write}l_default() routines' bodies need to
> depend on the architecture, or the clk_ll_ops_default structure
> needs to get preset differently depending on the architecture.
>
> For least intrusive changes in future use, adding a routine which
> allows to register a different ll_ops structure could be most
> appropriate.  That would allow to pre-set the ll_ops structure
> with the readl()/writel() implementation (current state of
> mainline code, working for the ARM architecture and maybe other
> little endian peripherals), and allows to register the
> ioread32be()/iowrite32be() routines for PowerPC, or whatever
> other platforms or architectures will require.
>
> Expecting each individual clock item registration to specify a
> differing set of ll_ops if readl()/writel() are not appropriate
> would look weird to me.
>
>
> Further I'd suggest to split this register access aspect out of
> the TI clock series, and to prepare it already for regmap style
> access to the hardware registers.  See the next comment below.

This sounds like a good idea to me, seeing it is blocking lots of other 
things.

>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index a4f14ae..671dff4 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -198,6 +198,23 @@ struct clk_hw {
>>   	const struct clk_init_data *init;
>>   };
>>
>> +/**
>> + * struct clk_ll_ops - low-level register access ops for a clock
>> + * @clk_readl: pointer to register read function
>> + * @clk_writel: pointer to register write function
>> + *
>> + * Low-level register access ops are generally used by the basic clock types
>> + * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
>> + * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
>> + * used by other hardware-specific clock drivers if needed.
>> + */
>> +struct clk_ll_ops {
>> +	u32	(*clk_readl)(void __iomem *reg);
>> +	void	(*clk_writel)(u32 val, void __iomem *reg);
>> +};
>> +
>> +extern struct clk_ll_ops clk_ll_ops_default;
>> +
>
> I'd suggest to add a "strct clk_ll_ops" pointer to the routines'
> list of arguments, and to add some "user data" pointer to the
> struct.
>
> This would provide more than the "reg" pointer to the routine,
> e.g. to determine an offset within a register set, and/or to hold
> a regmap handle.
>
> Not adding this extension now would lead to our queueing several
> patches which will result in potential conflicts, or requiring
> more cycles than necessary to achieve a working state for
> currently pending changes.

Yea I think this sounds like a good idea.

>
>
> There is another issue with this series:  It introduces
> "alternative" _default() routines (which are verbatim copies of
> the static inlines from the header), then adjusts the basic clock
> types (div, gate, mux), but does not remove the then obsolete
> static inlines from the header.
>
> Tero, can you please verify whether the clk_readl() and
> clk_writel() routines from <linux/clock-provider.h> become
> obsolete with your patch, or whether any unchanged users remain?

Just did a quick grep and it seems you are right, the routines become 
obsolete and could be removed (or alternatively just rename the 
clk_readl/writel_default to clk_readl/writel.)

>
>
> Are other parts of v12 still stuck?  I only saw 15 of 49 patches.

Rest of v12 was identical copy of v11, so I didn't repost them.

-Tero

