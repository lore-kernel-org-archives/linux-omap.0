From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH] OMAP3:PM: Fix OPP scale logic
Date: Tue, 4 Aug 2009 08:11:15 -0500
Message-ID: <4A783373.8010009@ti.com>
References: <1249306912-12099-1-git-send-email-nm@ti.com> <4A77EAB6.3070208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbZHDNLX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Aug 2009 09:11:23 -0400
In-Reply-To: <4A77EAB6.3070208@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: Kevin <khilman@deeprootsystems.com>, Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Roger Quadros had written, on 08/04/2009 03:00 AM, the following:
> ext Nishanth Menon wrote:
>> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
>> index 25535a3..1ceaed8 100644
>> --- a/arch/arm/mach-omap2/resource34xx.c
>> +++ b/arch/arm/mach-omap2/resource34xx.c
>> @@ -240,13 +240,23 @@ static int program_opp_freq(int res, int target_level, int current_level)
>>  	lock_scratchpad_sem();
>>  	if (res == VDD1_OPP) {
>>  		curr_opp = &curr_vdd1_opp;
>> -		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
>> -		clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
>> +		ret = clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
>> +		if (unlikely(ret))
>> +			return ret;
> 
> if we return here we're not calling unlock_scratchpad_sem(). if you remove the 
> return statement the expected functionality will be achieved by the next if(ret) 
> statement.
yep. my bad.. thanks.. will fix and resend.
> 
> looks like you are changing the return behaviour from opp level to 0/1. You 
> should explain this in a function header comment.
This function does not have a function header comment. this information 
is already part of the patch header. Quote:"
This changes program_freq_opp return type in the process
for program_opp to handle error in a consistent
manner.
"

Will send out a rev2 based on comment 1 (unlock_scratchpad_sem).

-- 
Regards,
Nishanth Menon
