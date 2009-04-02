From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29... for real this time
Date: Thu, 02 Apr 2009 09:06:37 -0700
Message-ID: <49D4E28D.50601@deeprootsystems.com>
References: <87k56dp5zc.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com> 	<87ljqllzz9.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC5F069A@dbde02.ent.ti.com> 	<87bprgjjp4.fsf@deeprootsystems.com> <4d34a0a70904012058h62914304k3318720685b9513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:33921 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762636AbZDBQGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 12:06:46 -0400
Received: by wf-out-1314.google.com with SMTP id 29so710151wff.4
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2009 09:06:44 -0700 (PDT)
In-Reply-To: <4d34a0a70904012058h62914304k3318720685b9513@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Yes, this locking problem requires Rajendra's patchset which needs to be 
updated for the PM branch.

Kevin

Kim Kyuwon wrote:
> Hi Kevin, Sanjeev,
> 
> I'm having the same problem.
> 
> when clk_set_rate() is invoked in omap_cpu_init() as shown below:
> 
> 	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> 
> It acquires the clocks mutex by the next statement.
> 
> 	mutex_lock(&clocks_mutex);
> 
> But after invoking arch_clock->clk_set_rate() in the middle of
> clk_set_rate(), clock_set_rate() is invoked again. So deadlock occurs
> due to mutex_lock() in clock_set_rate().
> 
> I think setting the default governor can not help this deadlock.
> 
> Regards,
> Kyuwon
> 
> On Thu, Apr 2, 2009 at 3:46 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Premi, Sanjeev" <premi@ti.com> writes:
>>
>> [...]
>>
>>>> Sounds to me like CPUfreq is changing frequencies during bootup.  Did
>>>> you select ondemand as the default CPUfreq governor?
>>> [sp] Yes. This is what I feel too. Only I was not clear why the process
>>> gets stuck at WFI. Haven't been able to debug further. So far...
>>>
>>>> If so, can you try with performance as the default governor.
>>> [sp] It was performance governor only.
>>>
>>>> If you're already using performance, then u-boot is setting a slower
>>>> speed and CPUfreq may decide to change it during boot.
>>> [sp] That is the case.
>>>
>> Can you try setting the default governor to userspace so that no DVFS
>> changes will happen during boot?
>>
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> 

