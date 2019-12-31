From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: OMAP2+: sleep43xx: Call secure suspend/resume
 handlers
Date: Tue, 31 Dec 2019 09:17:39 -0500
Message-ID: <344674f2-6996-0f02-5507-f35190fb66b0@ti.com>
References: <20191230185004.32279-1-afd@ti.com>
 <20191230185004.32279-5-afd@ti.com>
 <a29d1e78-9736-ea93-8a53-4600f8f48cde@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a29d1e78-9736-ea93-8a53-4600f8f48cde@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/31/19 1:20 AM, Lokesh Vutla wrote:
> 
> 
> On 31/12/19 12:20 AM, Andrew F. Davis wrote:
>> During suspend CPU context may be lost in both non-secure and secure CPU
>> states. The kernel can handle saving and restoring the non-secure context
>> but must call into the secure side to allow it to save any context it may
>> lose. Add these calls here.
>>
>> Note that on systems with OP-TEE available the suspend call is issued to
>> OP-TEE using the ARM SMCCC, but the resume call is always issued to the
>> ROM. This is because on waking from suspend the ROM is restored as the
>> secure monitor. It is this resume call that instructs the ROM to restore
>> OP-TEE, all subsequent calls will be handled by OP-TEE and should use the
>> ARM SMCCC.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Acked-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-secure.h |  3 +++
>>  arch/arm/mach-omap2/pm33xx-core.c | 17 +++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
>> index 736e594365f4..ba8c486c0454 100644
>> --- a/arch/arm/mach-omap2/omap-secure.h
>> +++ b/arch/arm/mach-omap2/omap-secure.h
>> @@ -53,6 +53,9 @@
>>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
>>  
>> +#define AM43xx_PPA_SVC_PM_SUSPEND	0x71
>> +#define AM43xx_PPA_SVC_PM_RESUME	0x72
>> +
>>  /* Secure RX-51 PPA (Primary Protected Application) APIs */
>>  #define RX51_PPA_HWRNG			29
>>  #define RX51_PPA_L2_INVAL		40
>> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
>> index f11442ed3eff..4a564f676ff9 100644
>> --- a/arch/arm/mach-omap2/pm33xx-core.c
>> +++ b/arch/arm/mach-omap2/pm33xx-core.c
>> @@ -28,6 +28,7 @@
>>  #include "prm33xx.h"
>>  #include "soc.h"
>>  #include "sram.h"
>> +#include "omap-secure.h"
>>  
>>  static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
>>  static struct clockdomain *gfx_l4ls_clkdm;
>> @@ -166,6 +167,16 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
>>  {
>>  	int ret = 0;
>>  
>> +	/* Suspend secure side on HS devices */
>> +	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>> +		if (optee_available)
>> +			omap_smccc_smc(AM43xx_PPA_SVC_PM_SUSPEND, 0);
>> +		else
>> +			omap_secure_dispatcher(AM43xx_PPA_SVC_PM_SUSPEND,
>> +					       FLAG_START_CRITICAL,
>> +					       0, 0, 0, 0, 0);
>> +	}
>> +
>>  	amx3_pre_suspend_common();
>>  	scu_power_mode(scu_base, SCU_PM_POWEROFF);
>>  	ret = cpu_suspend(args, fn);
>> @@ -174,6 +185,12 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
>>  	if (!am43xx_check_off_mode_enable())
>>  		amx3_post_suspend_common();
>>  
>> +	/* Resume secure side on HS devices */
>> +	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
>> +		omap_secure_dispatcher(AM43xx_PPA_SVC_PM_RESUME,
>> +				       FLAG_START_CRITICAL,
>> +				       0, 0, 0, 0, 0);
> 
> Don't you need to check optee_available here?
> 


I address this in the second paragraph of the commit message. I can add
a comment in code also if you think anyone will find it confusing.

Andrew


> Thanks and regards,
> Lokesh
> 
>> +
>>  	return ret;
>>  }
>>  
>>
