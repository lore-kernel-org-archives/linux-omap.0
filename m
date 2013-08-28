From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] ARM: AM335x: Get rid of unused sram init function
Date: Wed, 28 Aug 2013 11:47:06 +0530
Message-ID: <521D95E2.3060309@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com> <1377598305-15539-2-git-send-email-rnayak@ti.com> <521CCE8B.4050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100Ab3H1GRe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 02:17:34 -0400
In-Reply-To: <521CCE8B.4050907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com

On Tuesday 27 August 2013 09:36 PM, Dave Gerlach wrote:
> On 08/27/2013 05:11 AM, Rajendra Nayak wrote:
>> Remove the empty am33xx_sram_init() function.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/sram.c |    7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
>> index 4bd0968..305fc2b 100644
>> --- a/arch/arm/mach-omap2/sram.c
>> +++ b/arch/arm/mach-omap2/sram.c
>> @@ -285,11 +285,6 @@ static inline int omap34xx_sram_init(void)
>>   }
>>   #endif /* CONFIG_ARCH_OMAP3 */
>>
>> -static inline int am33xx_sram_init(void)
>> -{
>> -    return 0;
>> -}
>> -
>>   int __init omap_sram_init(void)
>>   {
>>       omap_detect_sram();
>> @@ -299,8 +294,6 @@ int __init omap_sram_init(void)
>>           omap242x_sram_init();
>>       else if (cpu_is_omap2430())
>>           omap243x_sram_init();
>> -    else if (soc_is_am33xx())
>> -        am33xx_sram_init();
>>       else if (cpu_is_omap34xx())
>>           omap34xx_sram_init();
>>
>>
> 
> Suspend resume for AM33xx as of right now uses this function. This patch [1] uses this function to push the low-level suspend code to sram, it was added here to be consistent with other platforms that utilize the same type of functionality (omap34xx).

Right, but if you look at patch 2/2 in the series, that basically moves all OMAP DT only platforms from using legacy
OMAP private apis to push code/manage sram to using the generic gen_pool apis to manage sram.
Can you look at how you can use gen_pool for am33xx instead of the way omap3 does it, since we want to completely
get rid of the internal sram management apis (or atleast have them only for legacy non-DT OMAP platforms).


> 
> Regards,
> Dave
> 
> [1] http://marc.info/?l=linux-omap&m=137581164813160&w=2

