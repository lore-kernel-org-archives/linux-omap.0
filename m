From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 5/9] ARM: OMAP2+: AM33XX: Add assembly code for PM operations
Date: Thu, 8 Aug 2013 08:16:41 -0700
Message-ID: <CA+Bv8XY9kziMftrEAnJkenzg6yS+DUYeVy+NQaPTKygJDWNnWw@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-6-git-send-email-d-gerlach@ti.com>
	<5203B03B.4030306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:64973 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965745Ab3HHPQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 11:16:43 -0400
Received: by mail-qa0-f52.google.com with SMTP id bq6so352542qab.18
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 08:16:43 -0700 (PDT)
In-Reply-To: <5203B03B.4030306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, Aug 8, 2013 at 7:50 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> In preparation for suspend-resume support for AM33XX, add
>> the assembly file with the code which is copied to internal
>> memory (OCMC RAM) during bootup and runs from there.
>>
>> As part of the low power entry (DeepSleep0 mode in AM33XX TRM),
>> the code running from OCMC RAM does the following
>> 1. Stores the EMIF configuration
>> 2. Puts external memory in self-refresh
>> 3. Disables EMIF clock
>> 4. Executes WFI after writing to MPU_CLKCTRL register.
>>
>> If no interrupts have come, WFI execution on MPU gets registered
>> as an interrupt with the WKUP-M3. WKUP-M3 takes care of disabling
>> some clocks which MPU should not (L3, L4, OCMC RAM etc) and takes
>> care of clockdomain and powerdomain transitions as part of the
>> DeepSleep0 mode entry.
>>
>> In case a late interrupt comes in, WFI ends up as a NOP and MPU
>> continues execution from internal memory. The 'abort path' code
>> undoes whatever was done as part of the low power entry and indicates
>> a suspend failure by passing a non-zero value to the cpu_resume routine.
>>
>> The 'resume path' code is similar to the 'abort path' with the key
>> difference of MMU being enabled in the 'abort path' but being
>> disabled in the 'resume path' due to MPU getting powered off.
>>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> ---
>>  arch/arm/mach-omap2/sleep33xx.S |  350 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 350 insertions(+)
>>  create mode 100644 arch/arm/mach-omap2/sleep33xx.S
>>
>> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
>> new file mode 100644
>> index 0000000..834c7d4
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/sleep33xx.S
>> @@ -0,0 +1,350 @@
>> +/*
>> + * Low level suspend code for AM33XX SoCs
>> + *
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <linux/ti_emif.h>
>> +#include <asm/memory.h>
>> +#include <asm/assembler.h>
>> +
>> +#include "cm33xx.h"
>> +#include "pm33xx.h"
>> +#include "prm33xx.h"
>> +
>> +     .text
>> +     .align 3
>> +
>> +/*
>> + * This routine is executed from internal RAM and expects some
>> + * parameters to be passed in r0 _strictly_ in following order:
>> + * 1) emif_addr_virt - ioremapped EMIF address
>> + * 2) mem_type - 2 -> DDR2, 3-> DDR3
>> + * 3) dram_sync_word - uncached word in SDRAM
>> + *
>> + * The code loads these values taking r0 value as reference to
>> + * the array in registers starting from r0, i.e emif_addr_virt
>> + * goes to r1, mem_type goes to r2 and and so on. These are
>> + * then saved into memory locations before proceeding with the
>> + * sleep sequence and hence registers r0, r1 etc can still be
>> + * used in the rest of the sleep code.
>> + */
>> +
>> +ENTRY(am33xx_do_wfi)
>> +     stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
>> +
>> +     ldm     r0, {r1-r3}             @ gather values passed
>> +
>> +     /* Save the values passed */
>> +     str     r1, emif_addr_virt
>> +     str     r2, mem_type
>> +     str     r3, dram_sync_word
>
> None of this parameter are going to change for every suspend entry and
> exit so saving them once and accessing them should be fine. Just
> create a structure with above, save them in init from C code and
> then access that structure where you need to.

It isn't possible to do so since the structure would be in SDRAM and
at resume time, we don't have access to SDRAM. Additionally, I'd like
to expand the mem_type parameter to a bit field in the future to allow
this code path to be shared with CPU idle.

>> +
>> +     /*
>> +      * Flush all data from the L1 data cache before disabling
>> +      * SCTLR.C bit.
>> +      */
>> +     ldr     r1, kernel_flush
>> +     blx     r1
>> +
>> +     /*
>> +      * Clear the SCTLR.C bit to prevent further data cache
>> +      * allocation. Clearing SCTLR.C would make all the data accesses
>> +      * strongly ordered and would not hit the cache.
>> +      */
>> +     mrc     p15, 0, r0, c1, c0, 0
>> +     bic     r0, r0, #(1 << 2)       @ Disable the C bit
>> +     mcr     p15, 0, r0, c1, c0, 0
>> +     isb
>> +
>> +     /*
>> +      * Invalidate L1 data cache. Even though only invalidate is
>> +      * necessary exported flush API is used here. Doing clean
>> +      * on already clean cache would be almost NOP.
>> +      */
> Comment is stale for AM33XX since below flush will clean l1 and l2
> together. We need to first flush and then invalidate. Please update it.
>> +     ldr     r1, kernel_flush
>> +     blx     r1
>> +
>> +     ldr     r0, emif_addr_virt
>> +     /* Save EMIF configuration */
>> +     ldr     r1, [r0, #EMIF_SDRAM_CONFIG]
>> +     str     r1, emif_sdcfg_val
>> +     ldr     r1, [r0, #EMIF_SDRAM_REFRESH_CONTROL]
>> +     str     r1, emif_ref_ctrl_val
>> +     ldr     r1, [r0, #EMIF_SDRAM_TIMING_1]
>> +     str     r1, emif_timing1_val
>> +     ldr     r1, [r0, #EMIF_SDRAM_TIMING_2]
>> +     str     r1, emif_timing2_val
>> +     ldr     r1, [r0, #EMIF_SDRAM_TIMING_3]
>> +     str     r1, emif_timing3_val
>> +     ldr     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     str     r1, emif_pmcr_val
>> +     ldr     r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +     str     r1, emif_pmcr_shdw_val
>> +     ldr     r1, [r0, #EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG]
>> +     str     r1, emif_zqcfg_val
>> +     ldr     r1, [r0, #EMIF_DDR_PHY_CTRL_1]
>> +     str     r1, emif_rd_lat_val
>> +
>> +     /* Put SDRAM in self-refresh */
>> +     ldr     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     orr     r1, r1, #0xa0
> No magic numbers please. here and rest of the patch. Have proper
> defines.
>
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +     str     r1, [r0, #4]
>> +
>> +     ldr     r1, dram_sync_word      @ a dummy access to DDR as per spec
>> +     ldr     r2, [r1, #0]
>> +     ldr     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     orr     r1, r1, #0x200
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +
>> +     mov     r1, #0x1000             @ Wait for system to enter SR
>> +wait_sr:
> What is sr ? I know you mean self-refresh, but sr can be smart reflex
> as well. Fix that please.
>> +     subs    r1, r1, #1
>> +     bne     wait_sr
>> +
> So how did you derive this 0x1000 number. Whats the real
> delay need ? For e.g a CPU running at 600 MHz vs running
> at 1.2 GHz, the above loop becomes 2 times faster.
>
>> +     /* Disable EMIF */
>> +     ldr     r1, virt_emif_clkctrl
>> +     ldr     r2, [r1]
>> +     bic     r2, r2, #0x03
>> +     str     r2, [r1]
>> +
>> +     ldr     r1, virt_emif_clkctrl
>> +wait_emif_disable:
>> +     ldr     r2, [r1]
>> +     ldr     r3, module_disabled_val
>> +     cmp     r2, r3
>> +     bne     wait_emif_disable
>> +
>> +     /*
>> +      * For the MPU WFI to be registered as an interrupt
>> +      * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
>> +      * to DISABLED
>> +      */
>> +     ldr     r1, virt_mpu_clkctrl
>> +     ldr     r2, [r1]
>> +     bic     r2, r2, #0x03
> Magic value
>> +     str     r2, [r1]
>> +
>> +     /*
>> +      * Execute an ISB instruction to ensure that all of the
>> +      * CP15 register changes have been committed.
>> +      */
>> +     isb
>> +
>> +     /*
>> +      * Execute a barrier instruction to ensure that all cache,
>> +      * TLB and branch predictor maintenance operations issued
>> +      * have completed.
>> +      */
>> +     dsb
>> +     dmb
>> +
>> +     /*
>> +      * Execute a WFI instruction and wait until the
>> +      * STANDBYWFI output is asserted to indicate that the
>> +      * CPU is in idle and low power state. CPU can specualatively
>> +      * prefetch the instructions so add NOPs after WFI. Thirteen
>> +      * NOPs as per Cortex-A8 pipeline.
>> +      */
>> +     wfi
>> +
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +     nop
>> +
>> +     /* We come here in case of an abort due to a late interrupt */
>> +
>> +     /* Set MPU_CLKCTRL.MODULEMODE back to ENABLE */
>> +     ldr     r1, virt_mpu_clkctrl
>> +     mov     r2, #0x02
>> +     str     r2, [r1]
>> +
>> +     /* Re-enable EMIF */
>> +     ldr     r1, virt_emif_clkctrl
>> +     mov     r2, #0x02
>> +     str     r2, [r1]
>> +wait_emif_enable:
>> +     ldr     r3, [r1]
>> +     cmp     r2, r3
>> +     bne     wait_emif_enable
>> +
>> +     /* Disable EMIF self-refresh */
>> +     ldr     r0, emif_addr_virt
>> +     ldr     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     bic     r1, r1, #LP_MODE_MASK
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +
>> +     /*
>> +      * A write to SDRAM CONFIG register triggers
>> +      * an init sequence and hence it must be done
>> +      * at the end for DDR2
>> +      */
>> +     ldr r0, emif_addr_virt
>> +     add r0, r0, #EMIF_SDRAM_CONFIG
>> +     ldr r4, emif_sdcfg_val
>> +     str r4, [r0]
>> +
>> +     /*
>> +      * Set SCTLR.C bit to allow data cache allocation
>> +      */
>> +     mrc     p15, 0, r0, c1, c0, 0
>> +     orr     r0, r0, #(1 << 2)       @ Enable the C bit
>> +     mcr     p15, 0, r0, c1, c0, 0
>> +     isb
>> +
>> +     /* Kill some time for sanity to settle in */
> Really ?
>> +     mov r0, #0x1000
>> +wait_abt:
>> +     subs   r0, r0, #1
>> +     bne wait_abt
> Why do you want to kill time ? How
> does this 0x1000 delay sanities it.
>
>> +
>> +     /* Let the suspend code know about the abort */
>> +     mov     r0, #1
>> +     ldmfd   sp!, {r4 - r11, pc}     @ restore regs and return
>> +ENDPROC(am33xx_do_wfi)
>> +
>> +     .align
>> +ENTRY(am33xx_resume_offset)
>> +     .word . - am33xx_do_wfi
>> +
>> +ENTRY(am33xx_resume_from_deep_sleep)
>> +     /* Re-enable EMIF */
>> +     ldr     r0, phys_emif_clkctrl
>> +     mov     r1, #0x02
>> +     str     r1, [r0]
>> +wait_emif_enable1:
>> +     ldr     r2, [r0]
>> +     cmp     r1, r2
>> +     bne     wait_emif_enable1
>> +
>> +     /* Config EMIF Timings */
>> +     ldr     r0, emif_phys_addr
>> +     ldr     r1, emif_rd_lat_val
>> +     str     r1, [r0, #EMIF_DDR_PHY_CTRL_1]
>> +     str     r1, [r0, #EMIF_DDR_PHY_CTRL_1_SHDW]
>> +     ldr     r1, emif_timing1_val
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_1]
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_1_SHDW]
>> +     ldr     r1, emif_timing2_val
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_2]
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_2_SHDW]
>> +     ldr     r1, emif_timing3_val
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_3]
>> +     str     r1, [r0, #EMIF_SDRAM_TIMING_3_SHDW]
>> +     ldr     r1, emif_ref_ctrl_val
>> +     str     r1, [r0, #EMIF_SDRAM_REFRESH_CONTROL]
>> +     str     r1, [r0, #EMIF_SDRAM_REFRESH_CTRL_SHDW]
>> +     ldr     r1, emif_pmcr_val
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +     ldr     r1, emif_pmcr_shdw_val
>> +     str     r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +
>> +     /*
>> +      * Output impedence calib needed only for DDR3
>> +      * but since the initial state of this will be
>> +      * disabled for DDR2 no harm in restoring the
>> +      * old configuration
>> +      */
>> +     ldr     r1, emif_zqcfg_val
>> +     str     r1, [r0, #EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG]
>> +
>> +     /* Write to SDRAM_CONFIG only for DDR2 */
>> +     ldr     r2, mem_type
>> +     cmp     r2, #MEM_TYPE_DDR2
>> +     bne     resume_to_ddr
>> +
>> +     /*
>> +      * A write to SDRAM CONFIG register triggers
>> +      * an init sequence and hence it must be done
>> +      * at the end for DDR2
>> +      */
>> +     ldr     r1, emif_sdcfg_val
>> +     str     r1, [r0, #EMIF_SDRAM_CONFIG]
>> +
>> +resume_to_ddr:
>> +     /* Back from la-la-land. Kill some time for sanity to settle in */
>> +     mov     r0, #0x1000
>> +wait_resume:
>> +     subs    r0, r0, #1
>> +     bne     wait_resume
>> +
> You are killing too much time ;-)
> without mentioning why ?
>
>> +     /* We are back. Branch to the common CPU resume routine */
>> +     mov     r0, #0
>> +     ldr     pc, resume_addr
> Why can't you resume to "cpu_resume" directly.
>
>> +ENDPROC(am33xx_resume_from_deep_sleep)
>> +
>> +
>> +/*
>> + * Local variables
>> + */
>> +     .align
>> +resume_addr:
>> +     .word   cpu_resume - PAGE_OFFSET + 0x80000000
> Do you really need above math ?
>
>> +kernel_flush:
>> +     .word   v7_flush_dcache_all
>> +ddr_start:
>> +     .word   PAGE_OFFSET
>> +emif_phys_addr:
>> +     .word   AM33XX_EMIF_BASE
>> +virt_mpu_clkctrl:
>> +     .word   AM33XX_CM_MPU_MPU_CLKCTRL
>> +virt_emif_clkctrl:
>> +     .word   AM33XX_CM_PER_EMIF_CLKCTRL
>> +phys_emif_clkctrl:
>> +     .word   (AM33XX_CM_BASE + AM33XX_CM_PER_MOD + \
>> +             AM33XX_CM_PER_EMIF_CLKCTRL_OFFSET)
>> +module_disabled_val:
>> +     .word   0x30000
>> +
>> +/* DDR related defines */
>> +dram_sync_word:
>> +     .word   0xDEADBEEF
>> +mem_type:
>> +     .word   0xDEADBEEF
>> +emif_addr_virt:
>> +     .word   0xDEADBEEF
>> +emif_rd_lat_val:
>> +     .word   0xDEADBEEF
>> +emif_timing1_val:
>> +     .word   0xDEADBEEF
>> +emif_timing2_val:
>> +     .word   0xDEADBEEF
>> +emif_timing3_val:
>> +     .word   0xDEADBEEF
>> +emif_sdcfg_val:
>> +     .word   0xDEADBEEF
>> +emif_ref_ctrl_val:
>> +     .word   0xDEADBEEF
>> +emif_zqcfg_val:
>> +     .word   0xDEADBEEF
>> +emif_pmcr_val:
>> +     .word   0xDEADBEEF
>> +emif_pmcr_shdw_val:
>> +     .word   0xDEADBEEF
>> +
> You can create a structure above above regs.
> refer 'cache-l2x0.h'  struct l2x0_regs in case
> you need an example.
>
>
> Looks like you don't care about secure devices ?
> Just confirm it.
>
> Regards,
> Santosh
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
