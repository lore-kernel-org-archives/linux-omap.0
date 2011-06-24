From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 18:31:19 +0530
Message-ID: <4E048A9F.2020900@ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>	<1308911742-27394-3-git-send-email-premi@ti.com>	<20110624104331.GK9449@n2100.arm.linux.org.uk>	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com> <20110624105144.GL9449@n2100.arm.linux.org.uk> <4E0486FD.2080604@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:44346 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1FXNBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 09:01:22 -0400
Received: by mail-yi0-f48.google.com with SMTP id 24so1475850yic.7
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 06:01:21 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 6/24/2011 6:22 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: Shilimkar, Santosh
>> Sent: Friday, June 24, 2011 6:16 PM
>> To: Russell King - ARM Linux
>> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix
>> loops_per_jiffy calculation
>>
>> Sanjeev,
>>
>> On 6/24/2011 4:21 PM, Russell King - ARM Linux wrote:
>>> On Fri, Jun 24, 2011 at 04:18:31PM +0530, Premi, Sanjeev wrote:
>>>>> -----Original Message-----
>>>>> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>>>>> Sent: Friday, June 24, 2011 4:14 PM
>>>>> To: Premi, Sanjeev
>>>>> Cc: linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>>>>> Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix
>>>>> loops_per_jiffy calculation
>>>>>
>>>>> On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
>>>>>> Currently, loops_per_jiffy is being calculated before calling
>>>>>> cpufreq_notify_transition().
>>>>>>
>>>>>> However, generic cpufreq driver adjusts the jiffies as well.
>>>>>> Double adjustment leads to incorrect value being assigned to
>>>>>> loops_per_jiffy.
>>>>>
>>>>> Are you sure the generic cpufreq driver adjusts the per-cpu
>>>>> loops_per_jiffy
>>>>> values?  I don't believe it does.
>>>>
>>>> Russell,
>>>>
>>>> I am quoting the function from drivers/cpufreq/cpufreq.h
>>>> Follow the arrows:
>>>
>>> Let's go to war with quotes then, because clearly you
>> haven't read the code
>>> properly:
>>>
>>> | #ifndef CONFIG_SMP
>>> ^^^^^^^^^^^^^^^^^^^^^
>>> | static unsigned long l_p_j_ref;
>>> | static unsigned int  l_p_j_ref_freq;
>>> |
>>> | static void adjust_jiffies(unsigned long val, struct
>> cpufreq_freqs *ci)
>>> | {
>>> | 	... code to adjust jiffies ...
>>> | }
>>> | #else
>>> | static inline void adjust_jiffies(unsigned long val,
>> struct cpufreq_freqs *ci)
>>> | {
>>> |         return;
>>> | }
>>> | #endif
>>>
>>> Notice how if CONFIG_SMP is set, adjust_jiffies becomes a
>> no-op.  So if
>>> CONFIG_SMP=y, loops_per_jiffy will _not_ be scaled by core code.
>>>
>> As Russell rightly pointed out, you need to take care of
>> UP/SMP and UP
>> OVER SMP.
>>
>> The generic code updates in only in case of UP build. I thought, the
>> comment is the code was well explaining that part.
>
> [sp] I did read the code but took long to understand most of it.
>       Hence patch 1 of this series.
>
>       I already accepted that I didn't notice definition of adjust_jiffies.
>       ...call it perils of leaving job half-done across a good-night-sleep!
>
>       As is, the calculations of UP are incorrect... which I was fixing.
>       Anyway, I have an updated patch - currently testing with CONFIG_SMP
>       enabled. Will be posting soon.
>
I can imagine what you are gonna post based on Russell comment, but will
wait for your patch before commenting.

Regards
Santosh
