From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
Date: Wed, 12 Mar 2014 17:07:06 -0500
Message-ID: <5320DA8A.3080904@ti.com>
References: <1394660600-3771-1-git-send-email-nm@ti.com> <5320D8AD.5000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbaCLWHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 18:07:34 -0400
In-Reply-To: <5320D8AD.5000308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 03/12/2014 04:59 PM, Santosh Shilimkar wrote:
> On Thursday 13 March 2014 05:43 AM, Nishanth Menon wrote:
>> Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
>> CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
>> failure complaining about the following:
>> arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
>> :(.text+0x8a70): undefined reference to `pm44xx_errata'
>>
> Not entirely accurate since CPU hotplug doesn't depend on CONFIG_PM

Just reporting the build error here.
> 
>> Fixes: c962184 (ARM: OMAP4: PM: add errata support)
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Patch based on: v3.14-rc6
>> Reported originally with a randconfig defconfig: http://slexy.org/view/s21U7eF4k1
>>
> But without the PM sleep code, hotplug won't work either.
yep - agreed,
> SO I think its ok assumption in this particular case

Can I take that as an Ack here? or would you suggest any improvements?

> 
>>  arch/arm/mach-omap2/pm.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 7bdd22a..d4d0fce 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -103,7 +103,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
>>  
>>  #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
>>  
>> -#if defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
>>  extern u16 pm44xx_errata;
>>  #define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
>>  #else
>>
> 


-- 
Regards,
Nishanth Menon
