From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/13] ARM: OMAP5: Add the WakeupGen IP updates.
Date: Mon, 07 May 2012 14:36:41 +0530
Message-ID: <4FA790A1.6060502@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-9-git-send-email-r.sricharan@ti.com> <20120504225511.GA5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:60414 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755668Ab2EGJGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 05:06:48 -0400
Received: by obbup19 with SMTP id up19so4078161obb.24
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 02:06:46 -0700 (PDT)
In-Reply-To: <20120504225511.GA5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

On Saturday 05 May 2012 04:25 AM, Tony Lindgren wrote:
> * R Sricharan <r.sricharan@ti.com> [120503 00:30]:
>> --- a/arch/arm/mach-omap2/omap-hotplug.c
>> +++ b/arch/arm/mach-omap2/omap-hotplug.c
>> @@ -17,8 +17,10 @@
>>  #include <linux/kernel.h>
>>  #include <linux/errno.h>
>>  #include <linux/smp.h>
>> +#include <linux/io.h>
>>  
>>  #include <asm/cacheflush.h>
>> +#include <mach/omap-wakeupgen.h>
>>  
>>  #include "common.h"
>>  
>> @@ -35,7 +37,8 @@ int platform_cpu_kill(unsigned int cpu)
>>   */
>>  void __ref platform_cpu_die(unsigned int cpu)
>>  {
>> -	unsigned int this_cpu;
>> +	unsigned int boot_cpu = 0;
>> +	void __iomem *base = omap_get_wakeupgen_base();
>>  
>>  	flush_cache_all();
>>  	dsb();
>> @@ -43,16 +46,27 @@ void __ref platform_cpu_die(unsigned int cpu)
>>  	/*
>>  	 * we're ready for shutdown now, so do it
>>  	 */
>> -	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
>> -		pr_err("Secure clear status failed\n");
>> +	if (cpu_is_omap44xx()) {
>> +		if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
>> +			pr_err("Secure clear status failed\n");
>> +	} else {
>> +		__raw_writel(0, base + OMAP_AUX_CORE_BOOT_0);
>> +	}
>> +
>>  
>>  	for (;;) {
>>  		/*
>>  		 * Enter into low power state
>>  		 */
>>  		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
>> -		this_cpu = smp_processor_id();
>> -		if (omap_read_auxcoreboot0() == this_cpu) {
>> +
>> +		if (cpu_is_omap44xx())
>> +			boot_cpu = omap_read_auxcoreboot0();
>> +		else
>> +			boot_cpu =
>> +				__raw_readl(base + OMAP_AUX_CORE_BOOT_0) >> 5;
>> +
>> +		if (boot_cpu == smp_processor_id()) {
>>  			/*
>>  			 * OK, proper wakeup, we're done
>>  			 */
> 
> These should use variables set up during init instead of cpu_is_omapxxx
> checks.
> 
Sounds good. Will fit it.

Regards
Santosh
