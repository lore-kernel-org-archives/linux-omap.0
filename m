From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP2PLUS: cpufreq: Add SMP support to cater OMAP4430
Date: Wed, 11 May 2011 12:40:49 +0530
Message-ID: <4DCA3679.8030603@ti.com>
References: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com> <1300102729-17276-3-git-send-email-santosh.shilimkar@ti.com> <BANLkTinSPpmepfJNC=2SSPF5KzsHcKXGEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50196 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492Ab1EKPwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 11:52:05 -0400
Received: by mail-gw0-f52.google.com with SMTP id 15so264690gwj.25
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 08:52:02 -0700 (PDT)
In-Reply-To: <BANLkTinSPpmepfJNC=2SSPF5KzsHcKXGEw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, Vishwanath BS <vishwanath.bs@ti.com>, "Herman, Saquib" <saquib@ti.com>, "Revanna, Amarnath" <amarnath@ti.com>

On 5/11/2011 6:11 AM, Menon, Nishanth wrote:
> On Mon, Mar 14, 2011 at 06:38, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On OMAP SMP configuartion, both processors share the voltage
>> and clock. So both CPUs needs to be scaled together and hence
>> needs software co-ordination.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> cc: Vishwanath BS<vishwanath.bs@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap2plus-cpufreq.c |   73 ++++++++++++++++++++++++++-----
>>   1 files changed, 62 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>
> [...]
>>         rate = clk_get_rate(mpu_clk) / 1000;
>> @@ -74,9 +76,13 @@ static int omap_target(struct cpufreq_policy *policy,
> [...]
>
>> -       cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>> +#ifdef CONFIG_SMP
>> +       /*
>> +        * Note that loops_per_jiffy is not updated on SMP systems in
>> +        * cpufreq driver. So, update the per-CPU loops_per_jiffy value
>> +        * on frequency transition. We need to update all dependent CPUs.
>> +        */
>> +       for_each_cpu(i, policy->cpus)
>> +               per_cpu(cpu_data, i).loops_per_jiffy =
>> +                       cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
>> +                                       freqs.old, freqs.new);
> We have an issue here - arch/arm/lib/delay.S uses the generic
> loops_per_jiffy which is not updated when smp (OMAP4) is active, as a
> result loops_per_jiffy contains the value which was updated. with a
> trace added as follows:

[...]

>
> Question: what would be the best solution for this? is a solution
> isolated to OMAP good enough?
>
We have debated on the global lpj update topic enough. The assumption
of all the CPU's in ARM SMP system are running at same speed in not

I propose this idea based on the fact that on OMAP we scale
all the CPU's in SMP clusture together. But that is not seems
to be true for all ARM SMP archs.

So there is a patch series which makes udelay() independent
of lpj and make use a timer.

Here is the link for the same.
http://eeek.borgchat.net/lists/arm-kernel/msg120702.html

Regards
Santosh
