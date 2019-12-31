From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP2+: Introduce check for OP-TEE in
 omap_secure_init()
Date: Tue, 31 Dec 2019 09:15:42 -0500
Message-ID: <d7d6f381-be00-3072-0510-a18b736987e7@ti.com>
References: <20191230185004.32279-1-afd@ti.com>
 <20191230185004.32279-3-afd@ti.com>
 <b4773b91-9893-830d-7b1b-b63eb4077cf7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4773b91-9893-830d-7b1b-b63eb4077cf7@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/31/19 1:32 AM, Lokesh Vutla wrote:
> 
> 
> On 31/12/19 12:20 AM, Andrew F. Davis wrote:
>> This check and associated flag can be used to signal the presence
>> of OP-TEE on the platform. This can be used to determine which
>> SMC calls to make to perform secure operations.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-secure.c | 14 ++++++++++++++
>>  arch/arm/mach-omap2/omap-secure.h |  3 +++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
>> index e936732cdc4f..39d8070aede6 100644
>> --- a/arch/arm/mach-omap2/omap-secure.c
>> +++ b/arch/arm/mach-omap2/omap-secure.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/memblock.h>
>> +#include <linux/of.h>
>>  
>>  #include <asm/cacheflush.h>
>>  #include <asm/memblock.h>
>> @@ -20,6 +21,18 @@
>>  
>>  static phys_addr_t omap_secure_memblock_base;
>>  
>> +bool optee_available;
>> +
>> +static void __init omap_optee_init_check(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_node_by_path("/firmware/optee");
>> +	if (np && of_device_is_available(np))
> 
> This doesn't guarantee that optee driver is probed successfully or firmware
> installed correctly. Isn't there a better way to detect? Doesn't tee core layer
> exposes anything?


We don't actually need the kernel-side OP-TEE driver at all here, we are
making raw SMCCC calls which get handled by OP-TEE using platform
specific code then emulates the function previously handled by ROM[0]
and execution is returned. No driver involved for these types of calls.

U-Boot will not add this node to the DT unless OP-TEE is installed
correctly, but you are right that is no perfect guarantee. OP-TEE's
kernel driver does do a handshake to verify it is working but this is
not exposed outside of that driver and happens *way* too late for our
uses here. Plus as above, we don't need the OP-TEE driver at all and we
should boot the same without it even enabled.

So my opinion is that if DT says OP-TEE is installed, but it is not,
then that is a misconfiguration and we usually just have to trust DT for
most things. If DT is wrong here then the only thing that happens is
this call safely fails, a message is printed informing the user of the
problem, and kernel keeps booting (although probably not stable given we
need these calls for important system configuration).

Andrew

[0]
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-ti/sm_platform_handler_a9.c
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-ti/sm_platform_handler_a15.c


> 
> Thanks and regards,
> Lokesh
> 
>> +		optee_available = true;
>> +	of_node_put(np);
>> +}
>> +
>>  /**
>>   * omap_sec_dispatcher: Routine to dispatch low power secure
>>   * service routines
>> @@ -166,4 +179,5 @@ u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag)
>>  
>>  void __init omap_secure_init(void)
>>  {
>> +	omap_optee_init_check();
>>  }
>> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
>> index 9aeeb236a224..78a1c4f04bbe 100644
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
>>  
>>  #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
>>
