From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 6/7] OMAP2+: clockdomain: Add 2 APIs to control clockdomain
 from hwmod framework
Date: Mon, 27 Jun 2011 11:18:47 +0200
Message-ID: <4E084AF7.8030005@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com> <1308917193-16912-7-git-send-email-b-cousson@ti.com> <20110626200715.GB2306@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757005Ab1F0JSv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 05:18:51 -0400
In-Reply-To: <20110626200715.GB2306@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Todd,

On 6/26/2011 10:07 PM, Todd Poynor wrote:
> On Fri, Jun 24, 2011 at 02:06:32PM +0200, Benoit Cousson wrote:
>> Duplicate the existing API for clockdomain enable from clock to enable
>> a clock domain from hwmod framework.
>> This will be needed when the hwmod framework will move from the current
>> clock centric approach to the module based approach.
>>
> ...
>> +static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
>> +{
>> +	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
>> +		return -EINVAL;
>> +
>> +#ifdef DEBUG
>> +	if (atomic_read(&clkdm->usecount) == 0) {
>> +		WARN_ON(1); /* underflow */
>> +		return -ERANGE;
>> +	}
>> +#endif
>> +
>> +	if (atomic_dec_return(&clkdm->usecount)>  0)
>> +		return 0;
>
> Suggest taking the error return out of the #ifdef DEBUG code (mainly
> to lessen the chance that enabling debugging features makes problems
> appear or disappear, although the WARN_ON should be a prominent clue
> in this case), and maybe just have the function always handle
> underflow.

If your final point is that we'd better remove the #ifdef, I do agree.

> ...
>> @@ -877,35 +911,93 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>>    */
>>   int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
>>   {
>> +	int ret = 0;
>> +
>>   	/*
>>   	 * XXX Rewrite this code to maintain a list of enabled
>>   	 * downstream clocks for debugging purposes?
>>   	 */
>>
>> -	if (!clkdm || !clk)
>> +	if (!clk)
>>   		return -EINVAL;
>>
>> -	if (!arch_clkdm || !arch_clkdm->clkdm_clk_disable)
>> +	ret = _clkdm_clk_hwmod_disable(clkdm);
>> +
>> +	/* All downstream clocks of this clockdomain are now disabled */
>> +	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
>> +		 clk->name);
>
> The pr_debug should be printed only if ret == 0.

That's not even enough, because the function is returning 0 even if the 
domain is already enabled.

> The comment seems true only if the clock domain's usecount went to zero.
>
> The terminology here may be a bit confusing: the function does not actually
> disable the named downstream clock in the usual sense
> (as in clk_disable(clk), or any action to individually gate that
> clock)  Similar comments for clkdm_clk_enable).

Yeah, I kept that from the original code, but in fact, I'll probably get 
rid of the pr_debug here and put it in the two helper functions.

Benoit

