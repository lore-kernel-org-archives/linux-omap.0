From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5] omap2plus: voltage: Trivial linking fix for 'EINVAL'
 undeclared
Date: Tue, 04 Jan 2011 12:56:50 -0600
Message-ID: <4D236D72.7080406@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-6-git-send-email-santosh.shilimkar@ti.com> <4D236BA0.8010002@ti.com> <bd04d3678881a910a0639746ed04043d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54199 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127Ab1ADS4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:56:53 -0500
Received: by mail-gw0-f44.google.com with SMTP id 17so6199637gwj.3
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:56:53 -0800 (PST)
In-Reply-To: <bd04d3678881a910a0639746ed04043d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Santosh Shilimkar had written, on 01/04/2011 12:51 PM, the following:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Wednesday, January 05, 2011 12:19 AM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Thara Gopinath; Kevin Hilman
>> Subject: Re: [PATCH 5/5] omap2plus: voltage: Trivial linking fix for
>> 'EINVAL' undeclared
>>
>> Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
>> following:
>>> CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
>>> In file included from arch/arm/plat-
>> omap/include/plat/omap_hwmod.h:38,
>>>                  from arch/arm/mach-
>> omap2/omap_hwmod_common_data.c:20:
>>> arch/arm/plat-omap/include/plat/voltage.h: In function
>> 'omap_voltage_late_init':
>>> arch/arm/plat-omap/include/plat/voltage.h:145: error: 'EINVAL'
>> undeclared (first use in this function)
>>> arch/arm/plat-omap/include/plat/voltage.h:145: error: (Each
>> undeclared identifier is reported only once
>>> arch/arm/plat-omap/include/plat/voltage.h:145: error: for each
>> function it appears in.)
>>> make[1]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error
>> 1
>>> make: *** [arch/arm/mach-omap2] Error 2
>>>
>>> The error is reported when omap2plus_defconfig built with
>> CONFIG_PM disabled
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Thara Gopinath <thara@ti.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>> ---
>>>  arch/arm/plat-omap/include/plat/voltage.h |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h
>> b/arch/arm/plat-omap/include/plat/voltage.h
>>> index c095351..2b776f0 100644
>>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>>> @@ -14,6 +14,8 @@
>>>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>>
>>> +#include <linux/err.h>
>>> +
>> Not sure if this is better OR including the err.h in c files is
>> better,
>> since the c file is the location where the error code is actually
>> used..
>>
>> but no strong feelings about either personally.
>>
> The error is because of 'EINVAL' usage in header file. How
> Will this error get fixed by including err.h is C file ?
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -16,6 +16,7 @@
   * data and their integration with other OMAP modules and Linux.
   */

+#include <linux/err.h>
  #include <plat/omap_hwmod.h>

  #include "omap_hwmod_common_data.h"

no?

Basically, this points that omap_hwmod_common_data.c does not use the 
error return values, which probably gets hidden by including err.h in 
the header itself.. in this particular case, maynot be important, and 
probably apis which should have return values checked should be marked 
so.. anyways, just my 2 cents - no hard opinions about either as far as 
I am concerned.

-- 
Regards,
Nishanth Menon
