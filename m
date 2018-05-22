From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 12/14] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Tue, 22 May 2018 13:27:10 +0530
Message-ID: <038cc2cd-ff72-c9c9-257b-1c1cc09a66a8@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-13-git-send-email-j-keerthy@ti.com>
 <20180412142714.GX5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412142714.GX5700@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 12 April 2018 07:57 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> Add the save and restore for clksrc as part of suspend and resume
>> so that it saves the counter value and restores. This is needed in
>> modes like rtc+ddr in self-refresh not doing this stalls the time.
> 
> I suspect this too should really happen with cpu_pm.

I believe going by the previous set of patches this fits better with
suspend/resume?

> 
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -442,6 +442,38 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
>>  	return ret;
>>  }
>>  
>> +static unsigned int omap2_gptimer_clksrc_load;
>> +
>> +static void omap2_gptimer_clksrc_suspend(struct clocksource *unused)
>> +{
>> +	struct omap_hwmod *oh;
>> +
>> +	omap2_gptimer_clksrc_load =
>> +		__omap_dm_timer_read_counter(&clksrc, OMAP_TIMER_NONPOSTED);
>> +
>> +	oh = omap_hwmod_lookup(clocksource_gpt.name);
>> +	if (!oh)
>> +		return;
>> +
>> +	omap_hwmod_idle(oh);
>> +}
> 
> Probably no need to look up the hwmod every time? Especially if am437x
> will start supporting deeper idle modes during runtime.

Like clockevent i will store the hwmod pointer for clocksource as well.

> 
> And probably the cpu_pm notifies should be directly in the hwmod
> code so we don't need to add more any more dependencies to hwmod
> functions to timer code. We should have this code move to drivers
> anyways at some point.
> 
> Regards,
> 
> Tony
> 
