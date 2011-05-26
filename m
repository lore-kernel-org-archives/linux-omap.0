From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC][PATCH 9/9] OMAP4460: dpll: Support MPU frequencies > 1
 Ghz
Date: Thu, 26 May 2011 09:43:57 +0530
Message-ID: <4DDDD385.2000706@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-10-git-send-email-nm@ti.com> <20110526031634.GA23867@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60466 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709Ab1EZEOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 00:14:05 -0400
Received: by yxp4 with SMTP id 4so141865yxp.10
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 21:14:02 -0700 (PDT)
In-Reply-To: <20110526031634.GA23867@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Vishwanath BS <vishwanath.bs@ti.com>

On 5/26/2011 8:46 AM, Todd Poynor wrote:
> On Wed, May 25, 2011 at 06:56:56PM -0700, Nishanth Menon wrote:
> ...
>> @@ -427,6 +465,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
>>   	u16 freqsel = 0;
>>   	struct dpll_data *dd;
>>   	int ret;
>> +	unsigned long orig_rate = 0;
>>
>>   	if (!clk || !rate)
>>   		return -EINVAL;
>> @@ -454,6 +493,19 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
>>   		if (!ret)
>>   			new_parent = dd->clk_bypass;
>>   	} else {
>> +		/*
>> +		 * On 4460, the MPU clk for frequencies higher than 1Ghz
>> +		 * is sourced from CLKOUTX2_M3, instead of CLKOUT_M2, while
>> +		 * value of M3 is fixed to 1. Hence for frequencies higher
>> +		 * than 1 Ghz, lock the DPLL at half the rate so the
>> +		 * CLKOUTX2_M3 then matches the requested rate.
>> +		 */
>> +		if (cpu_is_omap446x()&&  !strcmp(clk->name, "dpll_mpu_ck")
>> +					&&  (rate>  1000000000)) {
>> +			orig_rate = rate;
>> +			rate = rate/2;
>> +		}
>> +
>>   		if (dd->last_rounded_rate != rate)
>>   			omap2_dpll_round_rate(clk, rate);
>>
>> @@ -468,6 +520,12 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
>>   				WARN_ON(1);
>>   		}
>>
>> +		/* Set the rate back to original for book keeping*/
>> +		if (orig_rate) {
>> +			rate = orig_rate;
>> +			dd->last_rounded_rate = dd->last_rounded_rate * 2;
>
> Not sure why dd->last_rounded_rate is being adjusted here.  Its
> value was computed based on orig_rate/2, and this adjustment will
> force the code above to call omap2_dpll_round_rate() every time
> (because the * 2 value will never equal the / 2 value).  I haven't
> seen the value reported anywhere, so it doesn't seem necessary?

Todd, I have to admit I have'nt even tested this patch myself on a 4460
(I don't even have one) and I did mention this to Nishanth when I sent
this out to him.
You are right that playing with the last_rounded_rate is not a good
idea, that was done thinking the omap3_noncore_dpll_program then uses
it and it needs the orig_rate and not the /2. But that certainly
causes the omap2_dpll_round_rate to get called every time.
I need to work some more on this patch and certainly *test* it to
work on a 4460.

>
> ...
>
>
> Todd

