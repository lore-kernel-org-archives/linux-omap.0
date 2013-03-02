From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 07/15] ARM: OMAP5: Add init_late() hook to enable pm initialization
Date: Sat, 2 Mar 2013 11:30:12 +0530
Message-ID: <5131956C.5060602@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-8-git-send-email-santosh.shilimkar@ti.com> <20130301201235.GC22626@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43697 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab3CBF6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Mar 2013 00:58:43 -0500
In-Reply-To: <20130301201235.GC22626@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Saturday 02 March 2013 01:42 AM, Nishanth Menon wrote:
> On 17:40-20130301, Santosh Shilimkar wrote:
>> With consolidated code, now we can add the .init_late hook for
>> OMAP5 to enable power management and mux initialization.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c |    1 +
>>  arch/arm/mach-omap2/common.h        |    3 ++-
>>  arch/arm/mach-omap2/io.c            |    8 ++++++++
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 53cb380b..eac4ec5 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -179,6 +179,7 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
>>  	.init_irq	= omap_gic_of_init,
>>  	.handle_irq	= gic_handle_irq,
>>  	.init_machine	= omap_generic_init,
>> +	.init_late	= omap5_init_late,
>>  	.timer		= &omap5_timer,
>>  	.dt_compat	= omap5_boards_compat,
>>  	.restart	= omap44xx_restart,
>> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
>> index e0f9ea7..44fcf65 100644
>> --- a/arch/arm/mach-omap2/common.h
>> +++ b/arch/arm/mach-omap2/common.h
>> @@ -59,7 +59,7 @@ static inline int omap3_pm_init(void)
>>  }
>>  #endif
>>  
>> -#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5))
>>  int omap4_pm_init(void);
>>  #else
>>  static inline int omap4_pm_init(void)
>> @@ -108,6 +108,7 @@ void omap35xx_init_late(void);
>>  void omap3630_init_late(void);
>>  void am35xx_init_late(void);
>>  void ti81xx_init_late(void);
>> +void omap5_init_late(void);
>>  int omap2_common_pm_late_init(void);
>>  
>>  #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index 2c3fdd6..e6ba596 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -620,6 +620,14 @@ void __init omap5_init_early(void)
>>  	omap_cm_base_init();
>>  	omap5xxx_check_revision();
>>  }
>> +
>> +void __init omap5_init_late(void)
>> +{
>> +	omap_mux_late_init();
>> +	omap2_common_pm_late_init();
>> +	omap4_pm_init();
> as part of init sequence, we'd late_initcall *after* module_inits,
> implying probes of drivers will be called (for built-in drivers) prior
> to PM getting ready.
> 
> This basically makes key features like dvfs not available for drivers until
> late_init is complete.
> 
> We have faced tons of problems in the past with this approach, cant we
> improve this? One solution(we used in Android kernel fork) might be to
> ensure all core framework initialized before module_init either in
> arch_init or subsys_init. I am aware that machine_desc does not provide us
> that flexibility - should'nt we rather extend it for the same instead of
> having to go through the same pain all over again?
> 
I have seen those tons of internal patches as well :)
The point is, there is nothing at the moment in mainline code breaks
with this init sequence so it just fine.

You might have valid point but it is more of generic init sequence
for all PM code. Since you are aware of all the needs, I suggest
you to address that in another series so that all devices gets
addressed. Looking at current mainline supported code and the scope
of PM, I suspect there is any issue.

Regards
Santosh
