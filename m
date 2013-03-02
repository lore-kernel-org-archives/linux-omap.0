From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/15] ARM: OMAP5: PM: Add CPU power off mode support
Date: Sat, 2 Mar 2013 11:44:49 +0530
Message-ID: <513198D9.6050300@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com> <1362139864-9233-9-git-send-email-santosh.shilimkar@ti.com> <20130301213601.GA23458@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab3CBGNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Mar 2013 01:13:22 -0500
In-Reply-To: <20130301213601.GA23458@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Saturday 02 March 2013 03:06 AM, Nishanth Menon wrote:
> On 17:40-20130301, Santosh Shilimkar wrote:
>> Add power management code to handle the CPU off mode. Separate
>> suspend finisher is used for OMAP5(Cortex-A15) because it doesn't
>> use SCU power status register and external PL310 L2 cache which makes
>> code flow bit different.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   31 +++++++----
>>  arch/arm/mach-omap2/omap-secure.h         |    1 +
>>  arch/arm/mach-omap2/omap4-sar-layout.h    |    2 +
>>  arch/arm/mach-omap2/sleep_omap4plus.S     |   80 +++++++++++++++++++++++++++++
>>  4 files changed, 104 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index 9fda96b..275f9a4 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -76,10 +76,12 @@ struct cpu_pm_ops {
>>  	int (*finish_suspend)(unsigned long cpu_state);
>>  	void (*resume)(void);
>>  	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
>> +	void (*hotplug_restart)(void);
>>  };
>>  
>>  extern int omap4_finish_suspend(unsigned long cpu_state);
>>  extern void omap4_cpu_resume(void);
>> +extern int omap5_finish_suspend(unsigned long cpu_state);
>>  
>>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>>  static struct powerdomain *mpuss_pd;
>> @@ -102,6 +104,7 @@ struct cpu_pm_ops omap_pm_ops = {
>>  	.finish_suspend		= default_finish_suspend,
>>  	.resume			= dummy_cpu_resume,
>>  	.scu_prepare		= dummy_scu_prepare,
>> +	.hotplug_restart	= dummy_cpu_resume,
>>  };
>>  
>>  /*
>> @@ -334,7 +337,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>>  int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>>  {
>>  	unsigned int cpu_state = 0;
>> -	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
>>  
>>  	if (omap_rev() == OMAP4430_REV_ES1_0)
>>  		return -ENXIO;
>> @@ -344,7 +346,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>>  
>>  	clear_cpu_prev_pwrst(cpu);
>>  	set_cpu_next_pwrst(cpu, power_state);
>> -	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
>> +	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.hotplug_restart));
>>  	omap_pm_ops.scu_prepare(cpu, power_state);
>>  
>>  	/*
>> @@ -379,6 +381,7 @@ static void enable_mercury_retention_mode(void)
>>  int __init omap4_mpuss_init(void)
>>  {
>>  	struct omap4_cpu_pm_info *pm_info;
>> +	u32 cpu_wakeup_addr = 0;
>>  
>>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
>>  		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
>> @@ -388,9 +391,13 @@ int __init omap4_mpuss_init(void)
>>  	sar_base = omap4_get_sar_ram_base();
>>  
>>  	/* Initilaise per CPU PM information */
>> +	if (cpu_is_omap44xx())
>> +		cpu_wakeup_addr = CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
>> +	else if (soc_is_omap54xx())
>> +		cpu_wakeup_addr = OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
>>  	pm_info = &per_cpu(omap4_pm_info, 0x0);
>>  	pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
>> -	pm_info->wkup_sar_addr = sar_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
>> +	pm_info->wkup_sar_addr = sar_base + cpu_wakeup_addr;
>>  	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET0;
>>  	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
>>  	if (!pm_info->pwrdm) {
>> @@ -405,14 +412,14 @@ int __init omap4_mpuss_init(void)
>>  	/* Initialise CPU0 power domain state to ON */
>>  	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
>>  
>> +	if (cpu_is_omap44xx())
>> +		cpu_wakeup_addr = CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
>> +	else if (soc_is_omap54xx())
>> +		cpu_wakeup_addr = OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
>>  	pm_info = &per_cpu(omap4_pm_info, 0x1);
>>  	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
>> -	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
>> +	pm_info->wkup_sar_addr = sar_base + cpu_wakeup_addr;
>>  	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
>> -	if (cpu_is_omap446x())
>> -		pm_info->secondary_startup = omap_secondary_startup_4460;
>> -	else
>> -		pm_info->secondary_startup = omap_secondary_startup;
>>  
>>  	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
>>  	if (!pm_info->pwrdm) {
>> @@ -445,15 +452,19 @@ int __init omap4_mpuss_init(void)
>>  
>>  	if (cpu_is_omap44xx()) {
>>  		omap_pm_ops.finish_suspend = omap4_finish_suspend;
>> +		omap_pm_ops.hotplug_restart = omap_secondary_startup;
> could we handle omap_pm_ops.hotplug_restart = omap_secondary_startup_4460
> here as well with the interest of keeping all function inits
> in consecutive source location?
I don't wanted to have multiple indentation and  4460 bug is just
too annoying that it is better to keep it seperate.


>> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
>> index 6822d0a..ee8215b 100644
>> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
>> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
>> @@ -31,6 +31,8 @@
>>  /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
>>  #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
>>  #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
>> +#define OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET	0xe00
>> +#define OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET	0xe04
>>  
>>  #define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
>>  #define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
>> diff --git a/arch/arm/mach-omap2/sleep_omap4plus.S b/arch/arm/mach-omap2/sleep_omap4plus.S
>> index 88ff83a..3322fc8 100644
>> --- a/arch/arm/mach-omap2/sleep_omap4plus.S
>> +++ b/arch/arm/mach-omap2/sleep_omap4plus.S
>> @@ -326,6 +326,86 @@ skip_l2en:
>>  
>>  	b	cpu_resume			@ Jump to generic resume
>>  ENDPROC(omap4_cpu_resume)
>> +
>> +/*
>> + * ================================
>> + * == OMAP5 CPU suspend finisher ==
>> + * ================================
>> + *
>> + * OMAP5 MPUSS states for the context save:
>> + * save_state =
>> + *	0 - Nothing lost and no need to save: MPUSS INA/CSWR
>> + *	1 - CPUx L1 and logic lost: CPU OFF, MPUSS INA/CSWR
>> + *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
>> + *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
>> + */
>> +ENTRY(omap5_finish_suspend)
>> +	stmfd	sp!, {r4-r12, lr}
>> +	cmp	r0, #0x0
>> +	beq	do_wfi				@ No lowpower state, jump to WFI
>> +
>> +	/*
>> +	 * Flush all data from the L1 data cache before disabling
>> +	 * SCTLR.C bit.
>> +	 */
>> +	bl	omap4_get_sar_ram_base
>> +	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
>> +	cmp	r9, #0x1			@ Check for HS device
>> +	bne	skip_secure_l1_clean_op
>> +	mov	r0, #0				@ Clean secure L1
>> +	stmfd   r13!, {r4-r12, r14}
>> +	ldr	r12, =OMAP5_MON_CACHES_CLEAN_INDEX
>> +	DO_SMC
>> +	ldmfd   r13!, {r4-r12, r14}
>> +skip_secure_l1_clean_op:
>> +	bl	v7_flush_dcache_louis
>> +
>> +	/*
>> +	 * Clear the SCTLR.C bit to prevent further data cache
>> +	 * allocation. Clearing SCTLR.C would make all the data accesses
>> +	 * strongly ordered and would not hit the cache.
>> +	 */
>> +	mrc	p15, 0, r0, c1, c0, 0
>> +	bic	r0, r0, #(1 << 2)		@ Disable the C bit
>> +	mcr	p15, 0, r0, c1, c0, 0
>> +	isb
>> +
>> +	/* Clean and Invalidate L1 data cache. */
>> +	bl	v7_flush_dcache_louis
> Curious question - once we have flushed and invalidated L1 on
> skip_secure_l1_clean_op:, we disable SCTLR.C to make all accesses SO,
> what is the need to go through clean and invalidate again? is'nt it an
> un-necessary cycle consuming NOP? What kind of data are we cleaning out
> here?
Obviously you haven't read all the old emails internally as well as
externally on this topic. Its needed.

>> +
>> +	/*
>> +	 * Take CPU out of Symmetric Multiprocessing (SMP) mode and thus
>> +	 * preventing the CPU from receiving cache, TLB, or BTB
>> +	 * maintenance operations broadcast by other CPUs in the cluster.
>> +	 */
>> +	mrc	p15, 0, r0, c1, c1, 2		@ Read NSACR data
>> +	tst	r0, #(1 << 18)
>> +	mrcne	p15, 0, r0, c1, c0, 1
>> +	bicne	r0, r0, #(1 << 6)		@ Disable SMP bit
>> +	mcrne	p15, 0, r0, c1, c0, 1
>> +	isb
>> +	dsb
>> +
> when save_state=3, as per the function comment:
>  3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
> But we dont flush L2 nonsecure OR secure at this point. results wont be
> pretty.
Subject adds CPU off support only. I have added the comments section in
this patch. I can move that for next patch.

> If we dont want to deal with "3", then should'nt we add an adequate
> handler on entry and remove the code comment claiming we support
> it?
> is'nt it better to squash in "[PATCH 11/15] ARM: OMAP5: PM: Add L2
> memory power down support" here?
Why. You don't need L2 support for CPU OFF. As I said I will move the
comment in further patch which seems to confused you. And sure, I will
remove that device OFF reference but still support mode where L2
can be destroyed. It can be done in MPU OSWR as well with a setting
to loose L2.

>> +do_wfi:
>> +	bl	omap_do_wfi
>> +
>> +	/*
>> +	 * CPU is here when it failed to enter OFF/DORMANT or
>> +	 * no low power state was attempted.
> This might need a bit more clarity IMHO. successful WFI (which is
> arguably an power state if we consider ARM internal clock gating takes
> place), will reach here as well. So would OMAP CPU INA state. The
> comment is probably valid for the defined save_states in code comments
> for CPU OFF which is un-successful.
>> +	 */
>> +	mrc	p15, 0, r0, c1, c0, 0
>> +	tst	r0, #(1 << 2)			@ Check C bit enabled?
>> +	orreq	r0, r0, #(1 << 2)		@ Enable the C bit
>> +	mcreq	p15, 0, r0, c1, c0, 0
>> +	isb
>> +	mrc	p15, 0, r0, c1, c0, 1
>> +	tst	r0, #(1 << 6)			@ Check SMP bit enabled?
>> +	orreq	r0, r0, #(1 << 6)
>> +	mcreq	p15, 0, r0, c1, c0, 1
>> +	isb
>> +	dsb
>> +	ldmfd	sp!, {r4-r12, pc}
>> +ENDPROC(omap5_finish_suspend)
>>  #endif
>>  
>>  #ifndef CONFIG_OMAP4_ERRATA_I688
> 
> I was curious at this point -> given that we added documentation that
> we will be able to go to CPU OFF here, but I did not see an resume
> handler registered. Untill I looked down in the series to see:
>
I should have mentioned abou CPU OFF in hotplug path which doesn't
need resume entry. Will update commit message accordingly. Thanks
for comments.

regards
Santosh

