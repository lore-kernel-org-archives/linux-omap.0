From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: Introduce check for OP-TEE in
 omap_secure_init()
Date: Tue, 17 Dec 2019 20:00:59 -0500
Message-ID: <f2efedb7-8050-2c16-02d0-a534c00a497e@ti.com>
References: <20191217234745.4434-1-afd@ti.com>
 <20191217234745.4434-3-afd@ti.com> <20191218005316.GG35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191218005316.GG35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/17/19 7:53 PM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [191217 23:48]:
>> --- a/arch/arm/mach-omap2/omap-secure.c
>> +++ b/arch/arm/mach-omap2/omap-secure.c
>> @@ -20,6 +21,18 @@
>>  
>>  static phys_addr_t omap_secure_memblock_base;
>>  
>> +bool optee_available;
> 
> The above can be static bool optee_available?
> 
>> --- a/arch/arm/mach-omap2/omap-secure.h
>> +++ b/arch/arm/mach-omap2/omap-secure.h
>> @@ -10,6 +10,8 @@
>>  #ifndef OMAP_ARCH_OMAP_SECURE_H
>>  #define OMAP_ARCH_OMAP_SECURE_H
>>  
>> +#include <linux/types.h>
>> +
>>  /* Monitor error code */
>>  #define  API_HAL_RET_VALUE_NS2S_CONVERSION_ERROR	0xFFFFFFFE
>>  #define  API_HAL_RET_VALUE_SERVICE_UNKNWON		0xFFFFFFFF
>> @@ -72,6 +74,7 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
>>  extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
>>  extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
>>  
>> +extern bool optee_available;
>>  void omap_secure_init(void);
> 
> And then this change should not be needed, right?
> 


I have a staged change I'm about to post that makes use of this flag
from outside of omap-secure.c, otherwise I would have left it internal
to that file.

I could also have moved the flag in the patch that uses it, but it
seemed like an unnecessary change given I know it will be needed here soon.

Andrew


> Otherwise series looks OK to me, thanks for updating it.
> 
> Regards,
> 
> Tony
> 
