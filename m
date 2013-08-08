From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 5/9] ARM: OMAP2+: AM33XX: Add assembly code for PM
 operations
Date: Thu, 8 Aug 2013 11:22:34 -0400
Message-ID: <5203B7BA.9020206@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-6-git-send-email-d-gerlach@ti.com>
 <5203B03B.4030306@ti.com>
 <CA+Bv8XY9kziMftrEAnJkenzg6yS+DUYeVy+NQaPTKygJDWNnWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XY9kziMftrEAnJkenzg6yS+DUYeVy+NQaPTKygJDWNnWw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 08 August 2013 11:16 AM, Russ Dill wrote:
> On Thu, Aug 8, 2013 at 7:50 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
>>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>
>>> In preparation for suspend-resume support for AM33XX, add
>>> the assembly file with the code which is copied to internal
>>> memory (OCMC RAM) during bootup and runs from there.
>>>
>>> As part of the low power entry (DeepSleep0 mode in AM33XX TRM),
>>> the code running from OCMC RAM does the following
>>> 1. Stores the EMIF configuration
>>> 2. Puts external memory in self-refresh
>>> 3. Disables EMIF clock
>>> 4. Executes WFI after writing to MPU_CLKCTRL register.
>>>
>>> If no interrupts have come, WFI execution on MPU gets registered
>>> as an interrupt with the WKUP-M3. WKUP-M3 takes care of disabling
>>> some clocks which MPU should not (L3, L4, OCMC RAM etc) and takes
>>> care of clockdomain and powerdomain transitions as part of the
>>> DeepSleep0 mode entry.
>>>
>>> In case a late interrupt comes in, WFI ends up as a NOP and MPU
>>> continues execution from internal memory. The 'abort path' code
>>> undoes whatever was done as part of the low power entry and indicates
>>> a suspend failure by passing a non-zero value to the cpu_resume routine.
>>>
>>> The 'resume path' code is similar to the 'abort path' with the key
>>> difference of MMU being enabled in the 'abort path' but being
>>> disabled in the 'resume path' due to MPU getting powered off.
>>>
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> ---
>>>  arch/arm/mach-omap2/sleep33xx.S |  350 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 350 insertions(+)
>>>  create mode 100644 arch/arm/mach-omap2/sleep33xx.S
>>>
>>> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
>>> new file mode 100644
>>> index 0000000..834c7d4
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/sleep33xx.S
>>> @@ -0,0 +1,350 @@
>>> +/*
>>> + * Low level suspend code for AM33XX SoCs
>>> + *
>>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation version 2.
>>> + *
>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>> + * kind, whether express or implied; without even the implied warranty
>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/linkage.h>
>>> +#include <linux/ti_emif.h>
>>> +#include <asm/memory.h>
>>> +#include <asm/assembler.h>
>>> +
>>> +#include "cm33xx.h"
>>> +#include "pm33xx.h"
>>> +#include "prm33xx.h"
>>> +
>>> +     .text
>>> +     .align 3
>>> +
>>> +/*
>>> + * This routine is executed from internal RAM and expects some
>>> + * parameters to be passed in r0 _strictly_ in following order:
>>> + * 1) emif_addr_virt - ioremapped EMIF address
>>> + * 2) mem_type - 2 -> DDR2, 3-> DDR3
>>> + * 3) dram_sync_word - uncached word in SDRAM
>>> + *
>>> + * The code loads these values taking r0 value as reference to
>>> + * the array in registers starting from r0, i.e emif_addr_virt
>>> + * goes to r1, mem_type goes to r2 and and so on. These are
>>> + * then saved into memory locations before proceeding with the
>>> + * sleep sequence and hence registers r0, r1 etc can still be
>>> + * used in the rest of the sleep code.
>>> + */
>>> +
>>> +ENTRY(am33xx_do_wfi)
>>> +     stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
>>> +
>>> +     ldm     r0, {r1-r3}             @ gather values passed
>>> +
>>> +     /* Save the values passed */
>>> +     str     r1, emif_addr_virt
>>> +     str     r2, mem_type
>>> +     str     r3, dram_sync_word
>>
>> None of this parameter are going to change for every suspend entry and
>> exit so saving them once and accessing them should be fine. Just
>> create a structure with above, save them in init from C code and
>> then access that structure where you need to.
> 
> It isn't possible to do so since the structure would be in SDRAM and
> at resume time, we don't have access to SDRAM. Additionally, I'd like
> to expand the mem_type parameter to a bit field in the future to allow
> this code path to be shared with CPU idle.
>
You can copy the structure in SRAM. So how does memtype need
changes for CPUIDLE ?

I have several comments on this patch so I assume you are
going to address them then.

Regards,
Santosh
