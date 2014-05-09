From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove suspend_set_ops from common pm late
 init
Date: Fri, 9 May 2014 15:17:04 -0500
Message-ID: <536D37C0.1000704@ti.com>
References: <1399661580-54599-1-git-send-email-d-gerlach@ti.com> <536D26C6.1060903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59876 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553AbaEIUR0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 16:17:26 -0400
In-Reply-To: <536D26C6.1060903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On 05/09/2014 02:04 PM, Nishanth Menon wrote:
> On 05/09/2014 01:53 PM, Dave Gerlach wrote:
>> In omap2_common_pm_late_init suspend_set_ops was called to set common
>> suspend handling functions for all omap platforms. This created two
>> problems. First, these suspend ops were being set for all platforms,
>> regardless of whether or not suspend support has been integrated so in
>> the case of AM33XX, suspend to mem was presented as available but
>> failed every time. Second, some platforms will need to define a
>> completely separate set of suspend ops, such as AM33XX, due to
>> differences from previous omap platforms so there is no need to
>> always set the common omap ops.
>>
>> This patch moves the suspend_set_ops call from omap2_common_pm_late_init
>> into a separate function that then gets called in the omap*_pm_init
>> functions for each platform.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>   arch/arm/mach-omap2/common.h | 8 ++++++++
>>   arch/arm/mach-omap2/pm.c     | 8 ++++----
>>   arch/arm/mach-omap2/pm24xx.c | 1 +
>>   arch/arm/mach-omap2/pm34xx.c | 1 +
>>   arch/arm/mach-omap2/pm44xx.c | 1 +
>>   5 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
>> index d88aff7..091e1c7 100644
>> --- a/arch/arm/mach-omap2/common.h
>> +++ b/arch/arm/mach-omap2/common.h
>> @@ -162,6 +162,14 @@ static inline void omap44xx_restart(enum reboot_mode mode, const char *cmd)
>>   }
>>   #endif
>>
>> +#ifdef CONFIG_SUSPEND
>> +void omap_common_suspend_init(void);
>> +#else
>> +static inline void omap_common_suspend_init(void)
>> +{
>> +}
>> +#endif
>> +
> push this off to this pm.h?

I could, I had just put it in the same spot as 
omap2_common_pm_late_init. I agree it makes sense to move it though.

>
>>   /* This gets called from mach-omap2/io.c, do not call this */
>>   void __init omap2_set_globals_tap(u32 class, void __iomem *tap);
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index e1b4141..c9b36fb 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -243,6 +243,10 @@ static const struct platform_suspend_ops omap_pm_ops = {
>>   	.valid		= suspend_valid_only_mem,
>>   };
>>
>> +void __init omap_common_suspend_init(void)
> provide kernel doc please? and do we need __init?

Added and no.

>
>> +{
>> +	suspend_set_ops(&omap_pm_ops);
>> +}
>>   #endif /* CONFIG_SUSPEND */
>>
>>   static void __init omap3_init_voltages(void)
>> @@ -310,9 +314,5 @@ int __init omap2_common_pm_late_init(void)
>>   	/* cpufreq dummy device instantiation */
>>   	omap_init_cpufreq();
>>
>> -#ifdef CONFIG_SUSPEND
>> -	suspend_set_ops(&omap_pm_ops);
>> -#endif
>> -
>>   	return 0;
>>   }
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
>> index 8c07594..8cd2408 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -231,6 +231,7 @@ static void __init prcm_setup_regs(void)
>>
>>   #ifdef CONFIG_SUSPEND
>>   	omap_pm_suspend = omap2_enter_full_retention;
>> +	omap_common_suspend_init();
>>   #endif
>>
>>   	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 87099bb..32b2597 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -707,6 +707,7 @@ int __init omap3_pm_init(void)
>>
>>   #ifdef CONFIG_SUSPEND
>>   	omap_pm_suspend = omap3_pm_suspend;
>> +	omap_common_suspend_init();
>>   #endif
>>
>>   	arm_pm_idle = omap3_pm_idle;
>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
>> index eefb30c..58d7cd7 100644
>> --- a/arch/arm/mach-omap2/pm44xx.c
>> +++ b/arch/arm/mach-omap2/pm44xx.c
>> @@ -253,6 +253,7 @@ int __init omap4_pm_init(void)
>>
>>   #ifdef CONFIG_SUSPEND
>>   	omap_pm_suspend = omap4_pm_suspend;
>> +	omap_common_suspend_init();
>
> do we need to expose omap_pm_suspend anymore with this since the
> original purpose was to make pm.c know about the suspend function?
> How about:
> omap_common_suspend_init(omap4_pm_suspend);
> should do the job, right? and with that, you dont need the #ifdef
> CONFIG_SUSPEND either in each of the pmxxx.c files since you already
> deal with it in header.

Yes, I like this idea myself.

Thanks for the comments,
Dave

>
>>   #endif
>>
>>   	/* Overwrite the default cpu_do_idle() */
>>
>
>

