From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Tue, 03 May 2011 15:44:53 +0530
Message-ID: <4DBFD59D.50008@ti.com>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com> <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55100 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751510Ab1ECKPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 06:15:01 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so2649711gxk.38
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 03:15:00 -0700 (PDT)
In-Reply-To: <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>

On 5/3/2011 3:41 PM, Catalin Marinas wrote:
[...]

>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index e9c2ff8..80b3d3c 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -89,7 +89,8 @@ static void gic_mask_irq(struct irq_data *d)
>>          u32 mask = 1<<  (d->irq % 32);
>>
>>          spin_lock(&irq_controller_lock);
>> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>
> As I commented on the version 2 of this patch, I don't think we should
> even bother with the additional readl_relaxed() here. It's not enough to
> prevent spurious interrupts anyway.
>
I forgot to drop this one.


>> @@ -392,6 +393,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>          unsigned long map = *cpus_addr(*mask);
>>
>>          /* this always happens on GIC0 */
>> -       writel(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>> +       dsb();
>> +       writel_relaxed(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>
> I would add a comment before the dsb() on why it is needed. Maybe something like:
>
> /*
>   * Ensure that stores to Normal memory are visible to the other CPUs before
>   * issuing the IPI.
>   */
>
>
> Otherwise the patch looks fine (I'll add my ack after you fix the above).
>
Thanks. Will add above comment, drop the readl and repost with your ack.

Same will push it the patch system

Regards
Santosh


