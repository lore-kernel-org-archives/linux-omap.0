From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv12 07/49] clk: divider: add support for low level ops
Date: Fri, 3 Jan 2014 11:17:03 +0200
Message-ID: <52C6800F.3090303@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com> <1387557274-22583-7-git-send-email-t-kristo@ti.com> <20131222175235.GC8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbaACJRc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Jan 2014 04:17:32 -0500
In-Reply-To: <20131222175235.GC8064@book.gsilab.sittig.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On 12/22/2013 07:52 PM, Gerhard Sittig wrote:
> [ dropped devicetree, we're clock specific here ]
>
> On Fri, Dec 20, 2013 at 18:34 +0200, Tero Kristo wrote:
>>
>> Divider clock can now be registered to use low level register access ops.
>> Preferred initialization method is via clock description.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/clk-divider.c    |   22 +++++++++++++++++++---
>>   include/linux/clk-provider.h |    4 ++++
>>   2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index 8cfed5c..887e2d8 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -108,7 +108,12 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>>   	struct clk_divider *divider = to_clk_divider(hw);
>>   	unsigned int div, val;
>>
>> -	val = clk_readl(divider->reg) >> divider->shift;
>> +	if (divider->ll_ops)
>> +		val = divider->ll_ops->clk_readl(divider->reg);
>> +	else
>> +		val = clk_readl(divider->reg);
>
> Should this not better always use an ll_ops structure, which
> either is individual to the clock item, or is "global" for a
> platform, yet can get re-registered at runtime (see the comment
> on 06/49)?  And why are you referencing clk_readl() instead of
> clk_readl_default() which you specifically have introduced in the
> previous patch?  Adding a copy of the routine and using both the
> copy and the original doesn't look right.

In some cases, the clock data is defined statically during compile time 
and here, ll_ops can be (and for OMAP cases at least is) NULL. I had 
kind of a global ll_ops definition in some of the earlier versions of 
this series, but it was frowned upon by some of the maintainers thus I 
dropped it.

-Tero

