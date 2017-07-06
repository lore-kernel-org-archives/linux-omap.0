From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 3/5] ARM: OMAP2+: pm33xx-core: Add platform code needed
 for PM
Date: Thu, 6 Jul 2017 14:02:47 -0500
Message-ID: <62c475ca-5501-bddb-4db0-3ec586f25942@ti.com>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-4-d-gerlach@ti.com> <20170704131441.GH27842@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170704131441.GH27842@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/04/2017 08:14 AM, Johan Hovold wrote:
> On Fri, May 19, 2017 at 03:04:36PM -0500, Dave Gerlach wrote:
>> Most of the PM code needed for am335x and am437x can be moved into a
>> module under drivers but some core code must remain in mach-omap2 at the
>> moment. This includes some internal clockdomain APIs and low-level ARM
>> APIs which are also not exported for use by modules.
>>
>> Implement a few functions that handle these low-level platform
>> operations can be passed to the pm33xx module through the use of
>> platform data.
>>
>> In addition to this, to be able to share data structures between C and
>> the sleep33xx and sleep43xx assembly code, we can automatically generate
>> all of the C struct member offsets and sizes as macros by making use of
>> the ARM asm-offsets file. In the same header that we define our data
>> structures in we also define all the macros in an inline function and by
>> adding a call to this in the asm_offsets file all macros are properly
>> generated and available to the assembly code without cluttering up the
>> asm-offsets file.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
> 
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index b668719b9b25..2f9649b89053 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -81,6 +81,11 @@ extern unsigned int omap3_do_wfi_sz;
>>  /* ... and its pointer from SRAM after copy */
>>  extern void (*omap3_do_wfi_sram)(void);
>>  
>> +struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void);
> 
> This one is not used outside of pm33xx-core.c so can now be static, and
> this declaration can be dropped.

Yes you are correct, seems I missed this in a refactor.

> 
>> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
>> new file mode 100644
>> index 000000000000..c84ffc4de2e9
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/pm33xx-core.c
>> @@ -0,0 +1,181 @@
>> +/*
>> + * AM33XX Arch Power Management Routines
>> + *
>> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Dave Gerlach
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
>> +#include <asm/smp_scu.h>
> 
> I get a compilation error here when compiling for am335x without
> CONFIG_HAVE_ARM_SCU due to a missing errno.h include:
> 
> In file included from /home/johan/work/omicron/src/linux/arch/arm/mach-omap2/pm33xx-core.c:17:0:
> /home/johan/work/omicron/src/linux/arch/arm/include/asm/smp_scu.h: In function 'scu_power_mode':
> /home/johan/work/omicron/src/linux/arch/arm/include/asm/smp_scu.h:36:10: error: 'EINVAL' undeclared (first use in this function)
>   return -EINVAL;
>           ^
> /home/johan/work/omicron/src/linux/arch/arm/include/asm/smp_scu.h:36:10: note: each undeclared identifier is reported only once for each function it appears in
> 
> This is arguably a bug in the header, which I'm submitting a fix for,
> but you should include errno.h above anyway as you use its definitions
> below as well.
> 

Yes ok, good catch.

>> +#include <asm/suspend.h>
>> +#include <linux/platform_data/pm33xx.h>
> 
> <snip>
> 
>> diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
>> new file mode 100644
>> index 000000000000..c191ab681093
>> --- /dev/null
>> +++ b/include/linux/platform_data/pm33xx.h
>> @@ -0,0 +1,69 @@
>> +/*
>> + * TI pm33xx platform data
>> + *
>> + * Copyright (C) 2016-2017 Texas Instruments, Inc.
>> + *	Dave Gerlach <d-gerlach@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _LINUX_PLATFORM_DATA_PM33XX_H
>> +#define _LINUX_PLATFORM_DATA_PM33XX_H
>> +
> 
> And here you should add a linux/types.h include to make this header
> self-contained. Right now you are depending on the scu header to pull in
> the types for pm33xx-core.c above.
> 

Ok will do. Thanks for the comments.

Regards,
Dave

>> +#include <linux/kbuild.h>
>> +
>> +#ifndef __ASSEMBLER__
>> +struct am33xx_pm_sram_addr {
>> +	void (*do_wfi)(void);
>> +	unsigned long *do_wfi_sz;
>> +	unsigned long *resume_offset;
>> +	unsigned long *emif_sram_table;
>> +	unsigned long *ro_sram_data;
>> +};
>> +
>> +struct am33xx_pm_platform_data {
>> +	int	(*init)(void);
>> +	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long));
>> +	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
>> +};
>> +
>> +struct am33xx_pm_sram_data {
>> +	u32 wfi_flags;
>> +	u32 l2_aux_ctrl_val;
>> +	u32 l2_prefetch_ctrl_val;
>> +};
>> +
>> +struct am33xx_pm_ro_sram_data {
>> +	u32 amx3_pm_sram_data_virt;
>> +	u32 amx3_pm_sram_data_phys;
>> +};
> 
> Johan
> 
