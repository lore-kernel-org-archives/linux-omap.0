From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/6] arm: omap4: create pmu device via hwmod
Date: Fri, 18 May 2012 16:09:04 -0500
Message-ID: <4FB6BA70.6000608@ti.com>
References: <1336599343-10905-1-git-send-email-jon-hunter@ti.com> <4FAB90E9.30408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39854 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967427Ab2ERVJN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 17:09:13 -0400
In-Reply-To: <4FAB90E9.30408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Benoit,

On 05/10/2012 04:56 AM, Cousson, Benoit wrote:
> Hi Jon & Ming,
> 
> On 5/9/2012 11:35 PM, Jon Hunter wrote:
>> From: Ming Lei<ming.lei@canonical.com>
>>
>> The following modules is required to be enabled before configuring
>> cross trigger interface for enabling pmu irq:
>>
>>          l3_instr, l3_main_3, debugss
>>
>> so build the arm-pmu device via the three hwmods.
>>
>> Cc: Ming Lei<ming.lei@canonical.com>
>> Cc: Will Deacon<will.deacon@arm.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>>
>> Signed-off-by: Ming Lei<ming.lei@canonical.com>
>> Signed-off-by: Will Deacon<will.deacon@arm.com>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>> ---
>>   arch/arm/mach-omap2/devices.c |   61
>> ++++++++++++++++++++++++++++++++++++++---
>>   1 files changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c
>> b/arch/arm/mach-omap2/devices.c
>> index 58682d1..d75b7d3 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -423,14 +423,67 @@ static struct platform_device omap_pmu_device = {
>>       .num_resources    = 1,
>>   };
>>
>> -static void omap_init_pmu(void)
>> +static struct arm_pmu_platdata omap4_pmu_data;
>> +static struct omap_device_pm_latency omap_pmu_latency[] = {
>> +    [0] = {
>> +        .deactivate_func = omap_device_idle_hwmods,
>> +        .activate_func   = omap_device_enable_hwmods,
>> +        .flags         = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>> +    },
>> +};
> 
> You can get rid of that, and use a NULL value during
> omap_device_build_ss. It will use the default value automatically.

I have removed this now for V2.

>> +static struct platform_device* __init omap4_init_pmu(void)
>>   {
>> -    if (cpu_is_omap24xx())
>> +    int id = -1;
>> +    const char *hw;
>> +    struct platform_device *pd;
>> +    struct omap_hwmod* oh[3];
>> +    char *dev_name = "arm-pmu";
>> +
>> +    hw = "l3_main_3";
>> +    oh[0] = omap_hwmod_lookup(hw);
>> +    if (!oh[0]) {
>> +        pr_err("Could not look up %s hwmod\n", hw);
>> +        return NULL;
>> +    }
>> +    hw = "l3_instr";
>> +    oh[1] = omap_hwmod_lookup(hw);
>> +    if (!oh[1]) {
>> +        pr_err("Could not look up %s hwmod\n", hw);
>> +        return NULL;
>> +    }
>> +    hw = "debugss";
>> +    oh[2] = omap_hwmod_lookup(hw);
>> +    if (!oh[2]) {
>> +        pr_err("Could not look up %s hwmod\n", hw);
>> +        return NULL;
>> +    }
>> +
>> +    pd = omap_device_build_ss(dev_name, id, oh, 3,&omap4_pmu_data,
>> +                sizeof(omap4_pmu_data),
>> +                omap_pmu_latency,
>> +                ARRAY_SIZE(omap_pmu_latency), 0);
>> +    WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
>> +                dev_name);
>> +    return pd;
>> +}
>> +static void __init omap_init_pmu(void)
>> +{
>> +    if (cpu_is_omap24xx()) {
>>           omap_pmu_device.resource =&omap2_pmu_resource;
> 
> Ideally, OMAP2 and 3 should use the hwmod device creation as well.

Do you know for OMAP2/3 what hwmods are needed for PMU support? Is it
just the MPU?

I see two options here for OMAP2/3 ...

1. Add the appropriate PMU interrupts to the MPU HWMOD and use the MPU
HWMOD to build the pmu device.
2. Create a new PMU HWMOD for OMAP2/3.

Please note that for 4460, I can get PMU to work without needing the EMU
PD if I use the PMU interrupts and not CTI. So this really simplifies
matters for 4460 (and 4470). For 4460 I have created the PMU device by
just using the MPU HWMOD and adding the PMU interrupts to the MPU HWMOD.

Cheers
Jon
