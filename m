From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 15:45:22 -0700
Message-ID: <4E0A5982.8040002@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39848 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750948Ab1F1Wp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 18:45:27 -0400
Received: by yxd30 with SMTP id 30so400865yxd.40
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:45:25 -0700 (PDT)
In-Reply-To: <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 6/28/2011 3:29 PM, Colin Cross wrote:
> <resending as plain text>
>
> On Fri, Jun 24, 2011 at 6:53 AM, Sanjeev Premi<premi@ti.com>  wrote:
>>

>> +#ifdef CONFIG_SMP
>> +       /* Adjust jiffies before transition */
>> +       for_each_cpu(i, policy->cpus) {
>> +               unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
>> +
>> +               per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
>> +                                                       freqs.old,
>> +                                                       freqs.new);

This isn't the right patch since it does suffer from the progressive
error. There was an updated patch on this thread from Russell which
I re-based.
> Can't this rewrite the loops_per_jiffy for the other CPU while it is
> in a udelay?  If it has already calculated the number of loops
> necessary, and the CPU frequency increases, it could end up returning
> too early from udelay.
>
> There were previous discussions about polling a fixed-frequency timer
> for udelay on SMP systems.
>
The udelay code doesn't use the per-cpu lpj variable. It uses the global
lpj. Secondly the calibration of no. of loops to be done is
precalculateed so overwrite shouldn't impact the scenario you mentioned.

Though it has an issue where, pre-calculated loops can become short/long
based on new clock change which impacts both CPU's on OMAP, when the 
other CPU is in in the middle of u-delay routine..

When CPU can scale independently, then we have bigger problem since
global lpj based udelay becomes always error prone in all scenario's.

So for the OMAP, where the whole CPU cluster is scaled together,
I don't see this as a bigger problem.

Regards
Santosh



