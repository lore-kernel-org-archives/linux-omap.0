From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 02/21] OMAP4: Use WARN_ON() instead of BUG_ON()
 with graceful exit
Date: Thu, 31 Mar 2011 14:05:04 +0530
Message-ID: <4D943CB8.70002@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com> <1301304157-2466-3-git-send-email-santosh.shilimkar@ti.com> <20110328205323.GD30616@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53362 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab1CaIfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 04:35:33 -0400
Received: by yxe1 with SMTP id 1so1817314yxe.25
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 01:35:31 -0700 (PDT)
In-Reply-To: <20110328205323.GD30616@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On 3/29/2011 2:23 AM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110328 02:20]:
>> OMAP L2X0 and GIC initialisation code uses BUG_ON() for the
>> ioremap() failure scenarios.
>>
>> Use WARN_ON() instead and allow graceful function exits.
>>
>> This was suggsted by Kevin Hilman<khilman@ti.com>  during
>> OMAP4 PM code review.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap4-common.c |    9 ++++++---
>>   1 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>> index 559d227..8f9b97d 100644
>> --- a/arch/arm/mach-omap2/omap4-common.c
>> +++ b/arch/arm/mach-omap2/omap4-common.c
>> @@ -36,11 +36,13 @@ void __init gic_init_irq(void)
>>
>>   	/* Static mapping, never released */
>>   	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
>> -	BUG_ON(!gic_dist_base_addr);
>> +	if (WARN_ON(!gic_dist_base_addr))
>> +		return;
>>
>>   	/* Static mapping, never released */
>>   	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>> -	BUG_ON(!gic_cpu_base);
>> +	if (WARN_ON(!gic_cpu_base))
>> +		return;
>>
>>   	omap_wakeupgen_init();
>>
>> @@ -68,7 +70,8 @@ static int __init omap_l2_cache_init(void)
>>
>>   	/* Static mapping, never released */
>>   	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>> -	BUG_ON(!l2cache_base);
>> +	if (WARN_ON(!l2cache_base))
>> +		return -ENODEV;
>>
>>   	/*
>>   	 * 16-way associativity, parity disabled
>
> Hmm to me it seems that if any of these we don't want to
> continue.
>
L2 cache is no problem and kernel can boot without L2 cache
support. I agree with you on interrupt controller init though.

Will drop the interrupt related checks from this patch.

Kevin, Are you ok with it ?

Regards
Santosh



