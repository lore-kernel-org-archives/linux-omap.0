From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP2+: PM: Warn users of sleep_while_idle if !CONFIG_CPU_IDLE
Date: Thu, 03 Mar 2011 15:02:15 +0530
Message-ID: <4D6F601F.60002@ti.com>
References: <1297857860-3713-1-git-send-email-rnayak@ti.com> <87sjv6h5h2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42492 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757949Ab1CCJfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 04:35:54 -0500
Received: by gyd5 with SMTP id 5so678108gyd.25
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 01:35:53 -0800 (PST)
In-Reply-To: <87sjv6h5h2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 02 March 2011 03:24 AM, Kevin Hilman wrote:
> Rajendra Nayak<rnayak@ti.com>  writes:
>
>> This should help users who do a
>> 'echo 1>  /debug/pm_debug/sleep_while_idle' with a
>> config which has !CONFIG_CPU_IDLE and wonder
>> why OMAP is'nt sleeping in idle.
>
> This isn't quite right, as 'sleep_while_idle' is actually a flag for
> whether or not to call omap_sram_idle() at all.

Hi Kevin,

I know this is used in 'omap3_pm_idle' as well
to decide whether or not to call omap_sram_idle() but
I was'nt quite sure what omap3_pm_idle is expected to do
in the first place.
We end up calling omap_sram_idle here without really
programming any target state. Do we really need this to
happen, instead can't we just rely on ARM generic code
to do a WFI in case we don't have cpuidle support enabled?

regards,
Rajendra

>
> Even without CPUidle, WFI will still be attempted.
>
> Kevin
>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/pm-debug.c |    9 +++++++++
>>   1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>> index 125f565..1e722a0 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -569,6 +569,10 @@ static int option_get(void *data, u64 *val)
>>
>>   	*val = *option;
>>
>> +#ifndef CONFIG_CPU_IDLE
>> +	if (option ==&sleep_while_idle)
>> +		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
>> +#endif
>>   	return 0;
>>   }
>>
>> @@ -581,6 +585,11 @@ static int option_set(void *data, u64 val)
>>
>>   	*option = val;
>>
>> +#ifndef CONFIG_CPU_IDLE
>> +	if (option ==&sleep_while_idle)
>> +		pr_warn("CONFIG_CPU_IDLE is not enabled\n");
>> +#endif
>> +
>>   	if (option ==&enable_off_mode) {
>>   		if (val)
>>   			omap_pm_enable_off_mode();

