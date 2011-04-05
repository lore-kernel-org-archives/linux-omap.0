From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Tue, 05 Apr 2011 11:50:17 +0530
Message-ID: <4D9AB4A1.9050508@ti.com>
References: <1301650321-28652-1-git-send-email-santosh.shilimkar@ti.com> <1301930948.15819.52.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60578 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab1DEGmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 02:42:25 -0400
Received: by mail-yx0-f179.google.com with SMTP id 4so24064yxp.38
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 23:42:24 -0700 (PDT)
In-Reply-To: <1301930948.15819.52.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>

On 4/4/2011 8:59 PM, Catalin Marinas wrote:
> On Fri, 2011-04-01 at 10:32 +0100, Santosh Shilimkar wrote:
>> The GIC register accesses today make use of readl()/writel()
>> which prove to be very expensive when used along with mandatory
>> barriers. This mandatory barriers also introduces an un-necessary
>> and expensive l2x0_sync() operation. On Cortex-A9 MP cores, GIC
>> IO accesses from CPU are direct and doesn't go through L2X0 write
>> buffer.
>>
>> Also since a DSB does not guarantee that the device state has
>> been changed, a read back from the device is introduced wherever
>> necessary.
> ...
>> @@ -98,7 +98,8 @@ static void gic_mask_irq(struct irq_data *d)
>>          u32 mask = 1<<  (d->irq % 32);
>>
>>          spin_lock(&irq_controller_lock);
>> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>>          if (gic_arch_extn.irq_mask)
>>                  gic_arch_extn.irq_mask(d);
>>          spin_unlock(&irq_controller_lock);
>>
>
> Talking to the hardware people, a readl back would guarantee that the
> GIC state has changed but you can still get spurious interrupts because
> of the signal propagation from the GIC to the CPU. That's difficult to
> reliably sort out in software as we don't know the hardware delays, so
> we'll have to cope with spurious interrupts (unlikely though).
>
> A better sequence would be something like below (but still no
> guarantees):
>
> 	STR	[Device]
> 	LDR	[Device]
> 	DSB
> 	ISB
>
> (the ISB is needed in case some instructions already in the pipeline
> sampled the state of the interrupt signal)
>
> But I'm more in favour of not even bothering with an additional
> readl_relaxed, we simply cope with a very rare spurious interrupt. In a
> virtualised environment accesses to the GIC distributor are trapped
> making things slower.
>
Ok. Thanks for addition information.
Will drop readl_relaxed() then.

Regards
Santosh
