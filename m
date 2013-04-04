From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 15/18] ARM: OMAP4+: CPUidle: Consolidate idle driver
 for OMAP5 support
Date: Thu, 4 Apr 2013 19:34:47 +0530
Message-ID: <515D887F.8070901@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-16-git-send-email-santosh.shilimkar@ti.com> <87ip43s4l8.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48537 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760655Ab3DDOCw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 10:02:52 -0400
In-Reply-To: <87ip43s4l8.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:40 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> The OMAP5 idle driver can re-use most of OMAP4 CPUidle driver
>> implementation. Also the next derivative SOCs are going to re-use
>> the MPUSS so, same driver with minor updates can be re-used.
>>
>> Prepare the code so that its easier to add CPUidle support for
>> OMAP5 devices.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/cpuidle44xx.c |   31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index b8a22f0..ac6d526 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -1,7 +1,7 @@
>>  /*
>> - * OMAP4 CPU idle Routines
>> + * OMAP4PLUS CPU idle Routines
> 
> nit: s/PLUS/+/ 
> 
> in a few other places in this patch also.
> 
yes. Will update that.

>> @@ -24,13 +24,13 @@
>>  #include "clockdomain.h"
>>  
>>  /* Machine specific information */
>> -struct omap4_idle_statedata {
>> +struct idle_statedata {
>>  	u32 cpu_state;
>>  	u32 mpu_logic_state;
>>  	u32 mpu_state;
>>  };
>>  
>> -static struct omap4_idle_statedata omap4_idle_data[] = {
>> +static struct idle_statedata omap4_idle_data[] = {
>>  	{
>>  		.cpu_state = PWRDM_POWER_ON,
>>  		.mpu_state = PWRDM_POWER_ON,
>> @@ -53,11 +53,12 @@ static struct clockdomain *cpu_clkdm[NR_CPUS];
>>  
>>  static atomic_t abort_barrier;
>>  static bool cpu_done[NR_CPUS];
>> +static struct idle_statedata *state_ptr = &omap4_idle_data[0];
> 
> The assignment at init time (from the next patch) should be done here
> for 44xx, and the next patch can just add OMAP5 support.
> 
You don't need that to be differentiated at init at this
patch since only OMAP4 is supported and static assignment takes care
of it. Next patch ofcouse we need to differentiate and hence added
the checks there.

Regards,
Santosh



