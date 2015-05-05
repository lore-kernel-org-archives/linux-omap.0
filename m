From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PRM: Fix am437x module reset
Date: Tue, 5 May 2015 16:17:16 +0300
Message-ID: <5548C2DC.1020800@ti.com>
References: <1430508422-64913-1-git-send-email-d-gerlach@ti.com> <20150504171926.GQ24469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36179 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423303AbbEENRh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 May 2015 09:17:37 -0400
In-Reply-To: <20150504171926.GQ24469@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>

On 05/04/2015 08:19 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150501 12:28]:
>> When moving to using the OMAP4+ PRM driver on am437x, we switched
>> to using all omap4 ops for module reset management. However, reset
>> register layout on am437x is more similar to am335x than omap4 because
>> of the the need for an st_shift for the *_RST bits in certain *_RSTST
>> registers, like WKUP_PROC_LRST in the PRCM_RM_WKUP_RSTST. Without this
>> we cannot bring the Wakeup M3 IP out of reset.
>>
>> Because of this, we must use the am33xx prm ops for the hardreset
>> functionality while continuing to use all other omap4 ops. To accomplish
>> this we split out the common portion of omap44xx_prm_init and add an
>> am437x_prm_init to register the prm_ll_data struct specific to am437x.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c   |  6 +++---
>>   arch/arm/mach-omap2/prm33xx.c      | 14 +++++++-------
>>   arch/arm/mach-omap2/prm33xx.h      |  7 +++++++
>>   arch/arm/mach-omap2/prm44xx.c      | 32 +++++++++++++++++++++++++++++++-
>>   arch/arm/mach-omap2/prm44xx_54xx.h |  1 +
>>   arch/arm/mach-omap2/prm_common.c   |  2 +-
>>   6 files changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 982380b..4b13882 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -3924,9 +3924,9 @@ void __init omap_hwmod_init(void)
>>   		soc_ops.enable_module = _omap4_enable_module;
>>   		soc_ops.disable_module = _omap4_disable_module;
>>   		soc_ops.wait_target_ready = _omap4_wait_target_ready;
>> -		soc_ops.assert_hardreset = _omap4_assert_hardreset;
>> -		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
>> -		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
>> +		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
>> +		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
>> +		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
>>   		soc_ops.init_clkdm = _init_clkdm;
>>   	} else if (cpu_is_ti816x() || soc_is_am33xx()) {
>>   		soc_ops.enable_module = _omap4_enable_module;
>
> Can't the above just become then:
>
> 		...
> 	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
> 		...
> 	} else if (cpu_is_ti816x() || soc_is_am33xx() || soc_is_am43xx()) {
> 		...
> 	}
>
>> --- a/arch/arm/mach-omap2/prm44xx.c
>> +++ b/arch/arm/mach-omap2/prm44xx.c
>> @@ -24,6 +24,7 @@
>>   #include "iomap.h"
>>   #include "common.h"
>>   #include "vp.h"
>> +#include "prm33xx.h"
>>   #include "prm44xx.h"
>>   #include "prm-regbits-44xx.h"
>>   #include "prcm44xx.h"
>> @@ -705,7 +706,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
>>
>>   static const struct omap_prcm_init_data *prm_init_data;
>>
>> -int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
>> +static void omap44xx_prm_init_common(const struct omap_prcm_init_data *data)
>>   {
>>   	omap_prm_base_init();
>>
>> @@ -718,7 +719,11 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
>>   		prm_features |= PRM_HAS_VOLTAGE;
>>
>>   	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
>> +}
>>
>> +int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
>> +{
>> +	omap44xx_prm_init_common(data);
>>   	return prm_register(&omap44xx_prm_ll_data);
>>   }
>>
>> @@ -762,3 +767,28 @@ static void __exit omap44xx_prm_exit(void)
>>   	prm_unregister(&omap44xx_prm_ll_data);
>>   }
>>   __exitcall(omap44xx_prm_exit);
>> +
>> +#ifdef CONFIG_SOC_AM43XX
>> +static struct prm_ll_data am43xx_prm_ll_data = {
>> +	.read_reset_sources = &omap44xx_prm_read_reset_sources,
>> +	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
>> +	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
>> +	.late_init = &omap44xx_prm_late_init,
>> +	.assert_hardreset	= am33xx_prm_assert_hardreset,
>> +	.deassert_hardreset	= am33xx_prm_deassert_hardreset,
>> +	.is_hardreset_asserted	= am33xx_prm_is_hardreset_asserted,
>> +	.reset_system		= omap4_prminst_global_warm_sw_reset,
>> +};
>> +
>> +int __init am43xx_prm_init(const struct omap_prcm_init_data *data)
>> +{
>> +	omap44xx_prm_init_common(data);
>> +	return prm_register(&am43xx_prm_ll_data);
>> +}
>> +
>> +static void __exit am43xx_prm_exit(void)
>> +{
>> +	prm_unregister(&am43xx_prm_ll_data);
>> +}
>> +__exitcall(am43xx_prm_exit);
>
> I think you can similarly just move this to use prm33xx.c instead of
> prm44xx.c and keep the functions static that way?

Yea this code is breaking some of the cleanup work already done for PRM. 
Sorry for the new bug introduced meanwhile, seems only pruss/wkup-m3 
were affected by this issue. I will post a better approach for fixing 
this problem shortly.

-Tero
