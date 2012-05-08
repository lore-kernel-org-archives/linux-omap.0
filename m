From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 09/13] ARM: OMAP5: Add SMP support.
Date: Tue, 08 May 2012 18:30:19 +0530
Message-ID: <4FA918E3.5060605@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-10-git-send-email-r.sricharan@ti.com> <20120508124759.GI2263@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:59879 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753257Ab2EHNA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:00:26 -0400
Received: by obbef5 with SMTP id ef5so10443656obb.7
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 06:00:25 -0700 (PDT)
In-Reply-To: <20120508124759.GI2263@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: R Sricharan <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday 08 May 2012 06:17 PM, Will Deacon wrote:
> Hello,
> 
> On Thu, May 03, 2012 at 08:26:18AM +0100, R Sricharan wrote:
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Add OMAP5 SMP boot support using OMAP4 SMP code. The relevant code paths
>> are runtime checked using cpu id
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> ---
>>  arch/arm/mach-omap2/common.h       |    1 +
>>  arch/arm/mach-omap2/omap-headsmp.S |   21 ++++++++++++++++++
>>  arch/arm/mach-omap2/omap-smp.c     |   41 +++++++++++++++++++++++++----------
>>  3 files changed, 51 insertions(+), 12 deletions(-)
> 
> [...]
> 
>> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
>> index 151fd5b..9424bb6 100644
>> --- a/arch/arm/mach-omap2/omap-smp.c
>> +++ b/arch/arm/mach-omap2/omap-smp.c
>> @@ -33,6 +33,10 @@
>>  #include "common.h"
>>  #include "clockdomain.h"
>>  
>> +#define CPU_MASK		0xff0ffff0
>> +#define CPU_CORTEX_A9		0x410FC090
>> +#define CPU_CORTEX_A15		0x410FC0F0
>> +
>>  /* SCU base address */
>>  static void __iomem *scu_base;
>>  
>> @@ -43,6 +47,14 @@ void __iomem *omap4_get_scu_base(void)
>>  	return scu_base;
>>  }
>>  
>> +static inline unsigned int get_a15_core_count(void)
>> +{
>> +	unsigned int ncores;
>> +
>> +	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (ncores));
>> +	return ((ncores >> 24) & 3) + 1;
>> +}
> 
> This register (L2 control) only tells you how many cores you have hanging
> off the L2 cache, which isn't really viable for future multi-cluster
> configurations. You're probably better off either reading the number of CPU
> nodes out of the DT (ppc, vexpress) or returning a constant for now
> (exynos5).
> 
Thanks will for the information. I agree for the future multiple
packages, this register may not be good enough. We can hard-code
it as well for now.

Regards
Santosh

