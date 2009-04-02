From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: PM branch rebased to 2.6.29... for real this time
Date: Thu, 2 Apr 2009 12:58:55 +0900
Message-ID: <4d34a0a70904012058h62914304k3318720685b9513@mail.gmail.com>
References: <87k56dp5zc.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com>
	<87ljqllzz9.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC5F069A@dbde02.ent.ti.com>
	<87bprgjjp4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:28910 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbZDBD7L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 23:59:11 -0400
Received: by rv-out-0506.google.com with SMTP id f9so391235rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2009 20:59:10 -0700 (PDT)
In-Reply-To: <87bprgjjp4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Kevin, Sanjeev,

I'm having the same problem.

when clk_set_rate() is invoked in omap_cpu_init() as shown below:

	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);

It acquires the clocks mutex by the next statement.

	mutex_lock(&clocks_mutex);

But after invoking arch_clock->clk_set_rate() in the middle of
clk_set_rate(), clock_set_rate() is invoked again. So deadlock occurs
due to mutex_lock() in clock_set_rate().

I think setting the default governor can not help this deadlock.

Regards,
Kyuwon

On Thu, Apr 2, 2009 at 3:46 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Premi, Sanjeev" <premi@ti.com> writes:
>
> [...]
>
>>> Sounds to me like CPUfreq is changing frequencies during bootup.  Did
>>> you select ondemand as the default CPUfreq governor?
>>
>> [sp] Yes. This is what I feel too. Only I was not clear why the process
>> gets stuck at WFI. Haven't been able to debug further. So far...
>>
>>> If so, can you try with performance as the default governor.
>>
>> [sp] It was performance governor only.
>>
>>> If you're already using performance, then u-boot is setting a slower
>>> speed and CPUfreq may decide to change it during boot.
>>
>> [sp] That is the case.
>>
>
> Can you try setting the default governor to userspace so that no DVFS
> changes will happen during boot?
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Kyuwon
