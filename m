From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-core][PATCH v3 02/21] OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
Date: Thu, 31 Mar 2011 07:04:10 -0700
Message-ID: <87wrjfmlnp.fsf@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-3-git-send-email-santosh.shilimkar@ti.com>
	<20110328205323.GD30616@atomide.com> <4D943CB8.70002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51233 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757473Ab1CaOES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 10:04:18 -0400
Received: by mail-iw0-f173.google.com with SMTP id 42so2963979iwl.32
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 07:04:17 -0700 (PDT)
In-Reply-To: <4D943CB8.70002@ti.com> (Santosh Shilimkar's message of "Thu, 31
	Mar 2011 14:05:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 3/29/2011 2:23 AM, Tony Lindgren wrote:
>> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110328 02:20]:
>>> OMAP L2X0 and GIC initialisation code uses BUG_ON() for the
>>> ioremap() failure scenarios.
>>>
>>> Use WARN_ON() instead and allow graceful function exits.
>>>
>>> This was suggsted by Kevin Hilman<khilman@ti.com>  during
>>> OMAP4 PM code review.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/omap4-common.c |    9 ++++++---
>>>   1 files changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>>> index 559d227..8f9b97d 100644
>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>> @@ -36,11 +36,13 @@ void __init gic_init_irq(void)
>>>
>>>   	/* Static mapping, never released */
>>>   	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
>>> -	BUG_ON(!gic_dist_base_addr);
>>> +	if (WARN_ON(!gic_dist_base_addr))
>>> +		return;
>>>
>>>   	/* Static mapping, never released */
>>>   	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>>> -	BUG_ON(!gic_cpu_base);
>>> +	if (WARN_ON(!gic_cpu_base))
>>> +		return;
>>>
>>>   	omap_wakeupgen_init();
>>>
>>> @@ -68,7 +70,8 @@ static int __init omap_l2_cache_init(void)
>>>
>>>   	/* Static mapping, never released */
>>>   	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>>> -	BUG_ON(!l2cache_base);
>>> +	if (WARN_ON(!l2cache_base))
>>> +		return -ENODEV;
>>>
>>>   	/*
>>>   	 * 16-way associativity, parity disabled
>>
>> Hmm to me it seems that if any of these we don't want to
>> continue.
>>
> L2 cache is no problem and kernel can boot without L2 cache
> support. I agree with you on interrupt controller init though.
>
> Will drop the interrupt related checks from this patch.
>
> Kevin, Are you ok with it ?

In general, BUG should only be used when the kernel really can not
possibly continue[1].  I suppose inability to map the GIC falls into
that category.

Kevin


[1] from asm-generic/bug.h:

/*
 * Don't use BUG() or BUG_ON() unless there's really no way out; one
 * example might be detecting data structure corruption in the middle
 * of an operation that can't be backed out of.  If the (sub)system
 * can somehow continue operating, perhaps with reduced functionality,
 * it's probably not BUG-worthy.
 *
 * If you're tempted to BUG(), think again:  is completely giving up
 * really the *only* solution?  There are usually better options, where
 * users don't need to reboot ASAP and can mostly shut down cleanly.
 */
