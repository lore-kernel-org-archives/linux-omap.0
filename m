From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Fri, 09 Sep 2011 15:29:47 +0530
Message-ID: <4E69E393.2060003@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com> <CAORVsuUXtiitSTMB0MTJPobppqKymmYFsDpsOqALP8UV7Pm+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60105 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933223Ab1IIJ7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 05:59:55 -0400
Received: by yxk30 with SMTP id 30so471868yxk.26
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 02:59:53 -0700 (PDT)
In-Reply-To: <CAORVsuUXtiitSTMB0MTJPobppqKymmYFsDpsOqALP8UV7Pm+dQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

On Friday 09 September 2011 01:09 AM, Jean Pihet wrote:
> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
>> retention (CSWR) is not supported by hardware design.
>>
>> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>>
>> CPUx sleep code is common for hotplug, suspend and CPUilde.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/Makefile                    |    3 +-
>>   arch/arm/mach-omap2/include/mach/omap-secure.h  |    8 +
>>   arch/arm/mach-omap2/include/mach/omap4-common.h |   25 +++
>>   arch/arm/mach-omap2/omap-mpuss-lowpower.c       |  249 +++++++++++++++++++++++
>>   arch/arm/mach-omap2/omap-smp.c                  |    6 +
>>   arch/arm/mach-omap2/omap4-sar-layout.h          |    9 +
>>   arch/arm/mach-omap2/pm44xx.c                    |    6 +
>>   arch/arm/mach-omap2/sleep44xx.S                 |  213 +++++++++++++++++++
>>   8 files changed, 518 insertions(+), 1 deletions(-)
>>   create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index b032c21..b4f2eeb 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -63,7 +63,8 @@ obj-$(CONFIG_ARCH_OMAP2)              += pm24xx.o
>>   obj-$(CONFIG_ARCH_OMAP2)               += sleep24xx.o
>>   obj-$(CONFIG_ARCH_OMAP3)               += pm34xx.o sleep34xx.o \
>>                                            cpuidle34xx.o
>> -obj-$(CONFIG_ARCH_OMAP4)               += pm44xx.o sleep44xx.o
>> +obj-$(CONFIG_ARCH_OMAP4)               += pm44xx.o sleep44xx.o \
>> +                                          omap-mpuss-lowpower.o
>>   obj-$(CONFIG_PM_DEBUG)                 += pm-debug.o
>>   obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>>   obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)  += smartreflex-class3.o
>> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
>> index e2f95a0..0062d49 100644
>> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
>> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
>> @@ -35,10 +35,18 @@
>>   #define OMAP4_HAL_SAVEALL_INDEX                0x1c
>>   #define OMAP4_HAL_SAVEGIC_INDEX                0x1d
>>
>> +/* Secure Monitor mode APIs */
>> +#define OMAP4_MON_SCU_PWR_INDEX                0x108
>> +
>> +/* Secure PPA(Primary Protected Application) APIs */
>> +#define OMAP4_PPA_CPU_ACTRL_SMP_INDEX  0x25
>> +
>> +#ifndef __ASSEMBLER__
>>   extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
>>                                 u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>>   extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
>>   extern phys_addr_t omap_secure_ram_mempool_base(void);
>>   extern int omap_secure_ram_reserve_memblock(void);
>>
>> +#endif /* __ASSEMBLER__ */
>>   #endif /* OMAP_ARCH_OMAP_SECURE_H */
>> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> index 040dcf6..662f37c 100644
>> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
>> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> @@ -45,5 +45,30 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
>>   extern void omap_auxcoreboot_addr(u32 cpu_addr);
>>   extern u32 omap_read_auxcoreboot0(void);
>>   #endif
>> +
>> +#if defined(CONFIG_SMP)&&  defined(CONFIG_PM)
>> +extern int omap4_mpuss_init(void);
>> +extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
>> +extern int omap4_finish_suspend(unsigned long cpu_state);
>> +extern void omap4_cpu_resume(void);
>> +#else
>> +static inline int omap4_enter_lowpower(unsigned int cpu,
>> +                                       unsigned int power_state)
>> +{
>> +       omap_do_wfi();
>> +       return 0;
>> +}
>> +
>> +static inline int omap4_mpuss_init(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int omap4_finish_suspend(unsigned long cpu_state)
>> +{}
> The int function should return something (0?)
> Has the code been test compiled without SMP and/or PM?
>
>> +static inline void omap4_cpu_resume(void)
>> +{}
>> +#endif
>> +
>>   #endif /* __ASSEMBLER__ */
>>   #endif /* OMAP_ARCH_OMAP4_COMMON_H */
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> ...
>
>> +/**
>> + * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
>> + * The purpose of this function is to manage low power programming
>> + * of OMAP4 MPUSS subsystem
>> + * @cpu : CPU ID
>> + * @power_state: Low power state.
>> + */
>> +int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>> +{
>> +       unsigned int save_state = 0;
>> +       unsigned int wakeup_cpu;
>> +
>> +       if (omap_rev() == OMAP4430_REV_ES1_0)
>> +               return -ENXIO;
>> +
>> +       switch (power_state) {
>> +       case PWRDM_POWER_ON:
>> +       case PWRDM_POWER_INACTIVE:
>> +               save_state = 0;
>> +               break;
>> +       case PWRDM_POWER_OFF:
>> +               save_state = 1;
>> +               break;
>> +       case PWRDM_POWER_RET:
>> +       default:
>> +               /*
>> +                * CPUx CSWR is invalid hardware state. Also CPUx OSWR
>> +                * doesn't make much scense, since logic is lost and $L1
>> +                * needs to be cleaned because of coherency. This makes
>> +                * CPUx OSWR equivalent to CPUX OFF and hence not supported
>> +                */
>> +               WARN_ON(1);
>> +               return -ENXIO;
>> +       }
>> +
>> +       clear_cpu_prev_pwrst(cpu);
>> +       set_cpu_next_pwrst(cpu, power_state);
>> +       set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
>> +       scu_pwrst_prepare(cpu, power_state);
>> +
>> +       /*
>> +        * Call low level function  with targeted CPU id
>> +        * and its low power state.
>> +        */
>> +       cpu_suspend(save_state, omap4_finish_suspend);
> There is no CPU id parameter to the call although the above comment says so.
>
> ...
>
>> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> ...
>
>> +/*
>> + * =============================
>> + * == CPU suspend finisher ==
>> + * =============================
>> + *
>> + * void omap4_finish_suspend(unsigned long cpu_state)
>> + *
>> + * This function code saves the CPU context and performs the CPU
>> + * power down sequence. Calling WFI effectively changes the CPU
>> + * power domains states to the desired target power state.
>> + *
>> + * @cpu_state : contains context save state (r0)
>> + *     0 - No context lost
>> + *     1 - CPUx L1 and logic lost: MPUSS CSWR
>> + *     2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
>> + *     3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
>> + * @return: This function never returns for CPU OFF and DORMANT power states.
>> + * Post WFI, CPU transitions to DORMANT or OFF power state and on wake-up
>> + * from this follows a full CPU reset path via ROM code to CPU restore code.
> Is the ROM code jumping to the physical address of omap4_cpu_resume?
> If so please add it in the comment.
>
> ...
>
>> +/*
>> + * ============================
>> + * == CPU resume entry point ==
>> + * ============================
>> + *
>> + * void omap4_cpu_resume(void)
>> + *
>> + * ROM code jumps to this function while waking up from CPU
>> + * OFF or DORMANT state. Physical address of the function is
>> + * stored in the SAR RAM while entering to OFF or DORMANT mode.
> Which code stores the address in the SAR RAM? Please describe it here.
>
Will add that comment.

Regards
Santosh
