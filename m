From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 07:47:11 -0700
Message-ID: <4E04A36F.103@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <4E04A0AB.40608@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57271 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753973Ab1FXOrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 10:47:17 -0400
Received: by mail-gy0-f173.google.com with SMTP id 10so1677632gyg.18
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:47:16 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 6/24/2011 7:40 AM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: Shilimkar, Santosh
>> Sent: Friday, June 24, 2011 8:05 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix
>> loops_per_jiffy calculation
>>
>> On 6/24/2011 7:23 PM, Sanjeev Premi wrote:
>>> Currently, loops_per_jiffy is being calculated twice for
>>> non-SMP processors.
>>>    - Before calling cpufreq_notify_transition()
>>>    - From within cpufreq_notify_transition()
>>>
>>> Double adjustment leads to incorrect value being assigned to
>>> loops_per_jiffy. This manifests as incorrect BogoMIPS in
>>> "cat /proc/cpuinfo".
>>>
>>> The value of loops_per_jiffy needs to be calculated only
>>> when CONFIG_SMP is true. It is the core change included
>>> in this patch.
>>>
>>> The patch also leverages the definition of for_each_cpu()
>>> with and without CONFIG_SMP to consolidate the mechanism
>>> to call cpufreq_notify_transition().
>>>
>>> Signed-off-by: Sanjeev Premi<premi@ti.com>
>>
>> NAK. This patch again doesn't make sense considering your issue.
>> Also jiffies should not be undated before changing the freq.
>> If the set_rate failed for some reason then you will have wrong
>> jiffies value.
>>
>> I understand your issue now. The code for global lpj updation
>> should have been checking smp_on_up() instead of is_smp().
>> That one line change is enough. I will post a patch on
>> the same once I reach to office.
>
> [sp] Suggest reading the patch before NAKing.
>       The patch is updating the loops_per_jiffy value "AFTER"
>       the frequency change has happenned and "BEFORE" post
>       change notification is sent.
>
Sure. Let me respond to you with the patch instead of making
more noise on the list.

Regard
Santosh
