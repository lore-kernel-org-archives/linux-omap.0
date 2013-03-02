From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/15] ARM: OMAP4+: CPUidle: Add OMAP5 idle driver support
Date: Sat, 2 Mar 2013 12:17:37 +0530
Message-ID: <5131A089.9090103@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-15-git-send-email-santosh.shilimkar@ti.com> <20130302002541.GB24537@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49122 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3CBGqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Mar 2013 01:46:11 -0500
In-Reply-To: <20130302002541.GB24537@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Saturday 02 March 2013 05:55 AM, Nishanth Menon wrote:
> On 17:41-20130301, Santosh Shilimkar wrote:
>> The OMAP5 idle driver can re-use OMAP4 CPUidle driver implementation thanks
>> to compatible MPUSS design.
>>
>> Though unlike OMAP4, on OMAP5 devices, MPUSS CSWR (Close Switch Retention)
>> power states can be achieved with respective power states on CPU0 and CPU1
>> power domain. This mode was broken on OMAP4 devices because of hardware
>> limitation. Also there is no CPU low power entry order requirement like
>> master CPU etc for CSWR C-state, which is icing on the cake. Code makes
>> use of voting scheme for cluster low power state to support MPUSS CSWR
>> C-state.
>>
>> Supported OMAP5 CPUidle C-states:
>>         C1 - CPU0 ON(WFI) + CPU1 ON(WFI) + MPUSS ON
>>         C2 - CPU0 CSWR + CPU1 CSWR + MPUSS CSWR
>>         C3 - CPU0 OFF + CPU1 Force OFF + MPUSS OSWR
>  think you meant CPU1 OFF?
Yes.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/Kconfig                        |    1 +
>>  arch/arm/mach-omap2/Makefile                       |    4 +-
>>  .../{cpuidle44xx.c => cpuidle_omap4plus.c}         |  103 +++++++++++++++++++-
>>  arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    7 +-
>>  arch/arm/mach-omap2/pm_omap4plus.c                 |    2 +-
>>  5 files changed, 110 insertions(+), 7 deletions(-)
>>  rename arch/arm/mach-omap2/{cpuidle44xx.c => cpuidle_omap4plus.c} (70%)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 41b581f..2df91dc 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -82,6 +82,7 @@ config SOC_OMAP5
>>  	select CPU_V7
>>  	select HAVE_SMP
>>  	select COMMON_CLK
>> +	select ARCH_NEEDS_CPU_IDLE_COUPLED
>>  
>>  comment "OMAP Core Type"
>>  	depends on ARCH_OMAP2
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index 7c3c6b6..f6ff88f 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -97,8 +97,10 @@ endif
>>  endif
>>  
>>  ifeq ($(CONFIG_CPU_IDLE),y)
>> +omap4plus-common-idle			= cpuidle_omap4plus.o
>>  obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
>> -obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
>> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap4plus-common-idle)
>> +obj-$(CONFIG_SOC_OMAP5)			+= $(omap4plus-common-idle)
> nit pick: simpler to use cpuidle_omap4plus.o or do we expect more objs -
> like moving the idle_data to DTS or so?
No I haven't that on that path. Easy from maintenance point of view. common
object and a label. Thats all.

>>  endif
>>  
>>  # PRCM
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle_omap4plus.c
>> similarity index 70%
>> rename from arch/arm/mach-omap2/cpuidle44xx.c
>> rename to arch/arm/mach-omap2/cpuidle_omap4plus.c
>> index 23286c1..8681fa6 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle_omap4plus.c
>> @@ -29,6 +29,7 @@ struct idle_statedata {
>>  	u32 cpu_state;
>>  	u32 mpu_logic_state;
>>  	u32 mpu_state;
>> +	u32 mpu_state_vote;
>>  };
>>  
>>  static struct idle_statedata omap4_idle_data[] = {
>> @@ -49,17 +50,36 @@ static struct idle_statedata omap4_idle_data[] = {
>>  	},
>>  };
>>  
>> +static struct idle_statedata omap5_idle_data[] = {
>> +	{
>> +		.cpu_state = PWRDM_POWER_ON,
>> +		.mpu_state = PWRDM_POWER_ON,
>> +		.mpu_logic_state = PWRDM_POWER_RET,
>> +	},
>> +	{
>> +		.cpu_state = PWRDM_POWER_RET,
> CSWR I assume -> Documenting it helps? or we should introdce
> cpu_logic_state to be explicit?
Its is documented just below the table(desc). No need to add useless
cpu_logic_state variable. This is part of the big C-state table.


>
[..]
>>  /*
>>   * For each cpu, setup the broadcast timer because local timers
>>   * stops for the states above C1.
>> @@ -209,6 +262,43 @@ static struct cpuidle_driver omap4_idle_driver = {
>>  	.safe_state_index = 0,
>>  };
>>  
>> +static struct cpuidle_driver omap5_idle_driver = {
>> +	.name				= "omap5_idle",
>> +	.owner				= THIS_MODULE,
>> +	.en_core_tk_irqen		= 1,
>> +	.states = {
>> +		{
>> +			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
> we could move these to .desc
That will be too much ... also above just for refence and understanding
otherwise, CPU state is per CPU so we can't say CPU0 =x, and CPU1 = y in
CPU0 C-state. I like the way .desc is today and would want to keep it that
way.

>> +			.exit_latency = 2 + 2,
>> +			.target_residency = 5,
> the obvious question on how these latencies were arrived at..
Based on the internal measurements done only considering MPUSS
C-state latencies.


>> @@ -243,8 +333,13 @@ int __init omap4_idle_init(void)
>>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>  		dev->coupled_cpus = *cpu_online_mask;
>>  #endif
>> -		state_ptr = &omap4_idle_data[0];
>> -		cpuidle_register_driver(&omap4_idle_driver);
>> +		if (cpu_is_omap44xx()) {
>> +			state_ptr = &omap4_idle_data[0];
>> +			cpuidle_register_driver(&omap4_idle_driver);
>> +		} else if (soc_is_omap54xx()) {
>> +			state_ptr = &omap5_idle_data[0];
>> +			cpuidle_register_driver(&omap5_idle_driver);
>> +		}
> we'd be doing cpuidle_register_driver twice since it is within the
> for_each_cpu loop - we dont want to do that.
Yep. I will move that out of the loop though second registration is just
a nop.
>>  
>>  		if (cpuidle_register_device(dev)) {
>>  			pr_err("%s: CPUidle register failed\n", __func__);
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index 5d32444..0ccb76e 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -87,7 +87,7 @@ extern void omap5_cpu_resume(void);
>>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>>  static struct powerdomain *mpuss_pd;
>>  static void __iomem *sar_base;
>> -static u32 cpu_context_offset;
>> +static u32 cpu_context_offset, cpu_cswr_supported;
>>  
>>  static int default_finish_suspend(unsigned long cpu_state)
>>  {
>> @@ -265,6 +265,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>>  		save_state = 1;
>>  		break;
>>  	case PWRDM_POWER_RET:
>> +		if (cpu_cswr_supported) {
>> +			save_state = 0;
>> +			break;
>> +		}
> ok, I guess this is the best we can do under the current circumstance
> where PWRDM_POWER_RET means either CSWR or OSWR!
The switch is for CPUx power states and hence there is no question of
OSWR. CPUx OSWR = CPUx OFF hence CPUx OSWR isn't supported. This has been
known from OMAP4 days. CPU RET isn't supported on OMAP4 and hence
that variable is added.

Regards,
Santosh
