From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCHv3 5/9] ARM: OMAP2+: AM33XX: Add assembly code for PM operations
Date: Thu, 8 Aug 2013 09:03:44 -0700
Message-ID: <CA+Bv8XYrsVoNNw5AQWEKVcAKNs2H+qhKjvM9jNdTu8zrhF14ZQ@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-6-git-send-email-d-gerlach@ti.com>
	<5203B03B.4030306@ti.com>
	<CA+Bv8XY9kziMftrEAnJkenzg6yS+DUYeVy+NQaPTKygJDWNnWw@mail.gmail.com>
	<5203B7BA.9020206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:54377 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934137Ab3HHQDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 12:03:54 -0400
Received: by mail-qe0-f52.google.com with SMTP id cz11so1789178qeb.39
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 09:03:54 -0700 (PDT)
In-Reply-To: <5203B7BA.9020206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, Aug 8, 2013 at 8:22 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Thursday 08 August 2013 11:16 AM, Russ Dill wrote:
>> On Thu, Aug 8, 2013 at 7:50 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>> On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
>>>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>>
>>>> In preparation for suspend-resume support for AM33XX, add
>>>> the assembly file with the code which is copied to internal
>>>> memory (OCMC RAM) during bootup and runs from there.
>>>>
>>>> As part of the low power entry (DeepSleep0 mode in AM33XX TRM),
>>>> the code running from OCMC RAM does the following
>>>> 1. Stores the EMIF configuration
>>>> 2. Puts external memory in self-refresh
>>>> 3. Disables EMIF clock
>>>> 4. Executes WFI after writing to MPU_CLKCTRL register.
>>>>
>>>> If no interrupts have come, WFI execution on MPU gets registered
>>>> as an interrupt with the WKUP-M3. WKUP-M3 takes care of disabling
>>>> some clocks which MPU should not (L3, L4, OCMC RAM etc) and takes
>>>> care of clockdomain and powerdomain transitions as part of the
>>>> DeepSleep0 mode entry.
>>>>
>>>> In case a late interrupt comes in, WFI ends up as a NOP and MPU
>>>> continues execution from internal memory. The 'abort path' code
>>>> undoes whatever was done as part of the low power entry and indicates
>>>> a suspend failure by passing a non-zero value to the cpu_resume routine.
>>>>
>>>> The 'resume path' code is similar to the 'abort path' with the key
>>>> difference of MMU being enabled in the 'abort path' but being
>>>> disabled in the 'resume path' due to MPU getting powered off.
>>>>
>>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Kevin Hilman <khilman@linaro.org>
>>>> ---
>>>>  arch/arm/mach-omap2/sleep33xx.S |  350 +++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 350 insertions(+)
>>>>  create mode 100644 arch/arm/mach-omap2/sleep33xx.S
>>>>
>>>> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
>>>> new file mode 100644
>>>> index 0000000..834c7d4
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-omap2/sleep33xx.S
>>>> @@ -0,0 +1,350 @@
>>>> +/*
>>>> + * Low level suspend code for AM33XX SoCs
>>>> + *
>>>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>>>> + * Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation version 2.
>>>> + *
>>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>>> + * kind, whether express or implied; without even the implied warranty
>>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/linkage.h>
>>>> +#include <linux/ti_emif.h>
>>>> +#include <asm/memory.h>
>>>> +#include <asm/assembler.h>
>>>> +
>>>> +#include "cm33xx.h"
>>>> +#include "pm33xx.h"
>>>> +#include "prm33xx.h"
>>>> +
>>>> +     .text
>>>> +     .align 3
>>>> +
>>>> +/*
>>>> + * This routine is executed from internal RAM and expects some
>>>> + * parameters to be passed in r0 _strictly_ in following order:
>>>> + * 1) emif_addr_virt - ioremapped EMIF address
>>>> + * 2) mem_type - 2 -> DDR2, 3-> DDR3
>>>> + * 3) dram_sync_word - uncached word in SDRAM
>>>> + *
>>>> + * The code loads these values taking r0 value as reference to
>>>> + * the array in registers starting from r0, i.e emif_addr_virt
>>>> + * goes to r1, mem_type goes to r2 and and so on. These are
>>>> + * then saved into memory locations before proceeding with the
>>>> + * sleep sequence and hence registers r0, r1 etc can still be
>>>> + * used in the rest of the sleep code.
>>>> + */
>>>> +
>>>> +ENTRY(am33xx_do_wfi)
>>>> +     stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
>>>> +
>>>> +     ldm     r0, {r1-r3}             @ gather values passed
>>>> +
>>>> +     /* Save the values passed */
>>>> +     str     r1, emif_addr_virt
>>>> +     str     r2, mem_type
>>>> +     str     r3, dram_sync_word
>>>
>>> None of this parameter are going to change for every suspend entry and
>>> exit so saving them once and accessing them should be fine. Just
>>> create a structure with above, save them in init from C code and
>>> then access that structure where you need to.
>>
>> It isn't possible to do so since the structure would be in SDRAM and
>> at resume time, we don't have access to SDRAM. Additionally, I'd like
>> to expand the mem_type parameter to a bit field in the future to allow
>> this code path to be shared with CPU idle.
>>
> You can copy the structure in SRAM. So how does memtype need
> changes for CPUIDLE ?

You'd have to reserve the address and have a symbol exported for it,
then after pushing everything to SRAM, you'd have to calculate the
pushed address of the reserved space, then do a memcpy. It'd be a bit
convoluted. Passing the address to the struct into tho wfi function is
really easy and a pretty common thing to do.

For cpuidle, i'd probably change it to a flags field instead of just
memtype. For instance ddr2 would be (1 << 0), and ddr3 would (1 << 1).
Other flags could then be added, such as whether or not to notify the
M3 at WFI time.

> I have several comments on this patch so I assume you are
> going to address them then.
>
> Regards,
> Santosh
>
>
