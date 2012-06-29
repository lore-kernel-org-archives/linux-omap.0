From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC] ARM: OMAP: Remove nodes dynamically at runtime
Date: Thu, 28 Jun 2012 19:14:46 -0500
Message-ID: <4FECF376.3010001@ti.com>
References: <4FE372CA.7020008@ti.com> <4FE3B328.8060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46149 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab2F2AOn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 20:14:43 -0400
In-Reply-To: <4FE3B328.8060805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, robherring2@gmail.com, Grant Likely <grant.likely@secretlab.ca>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Rob, Grant,

Benoit suggested that I ask your opinion on the below.

Basically, I am trying to understand if there is any reason not to
enable OF_DYNAMIC. More details below on the exact scenario I am trying
to solve. OF_DYNAMIC seems to provide a good solution for me.

Thanks
Jon

On 06/21/2012 06:50 PM, Jon Hunter wrote:
> 
> On 06/21/2012 02:15 PM, Jon Hunter wrote:
>> Hi all,
>>
>> I am in the process of adding a device-tree binding for OMAP timers and
>> I have encountered a scenario where ideally it would be useful to remove
>> a device-tree node at runtime.
>>
>> The scenario is this ...
>>
>> 1. OMAP3 devices may or may not have security features enabled. Security
>>    enabled devices are known as high-secure (HS) and devices without 
>>    security are known as general purpose (GP).
>> 2. For OMAP3 devices there are 12 general purpose timers available.
>> 3. On secure devices the 12th timer is reserved for secure usage and so
>>    cannot be used by the kernel, where as for a GP device it is available.
>> 4. We can detect the OMAP device type, secure or GP, at runtime via an
>>    on-chip register.
>> 5. Today, when not using DT, we do not register the 12th timer as a linux
>>    device if the device is secure.
>>
>> When migrating the timers to DT, I need a way to prevent this 12th timer
>> from being registered as a device on a secure device. The options I have
>> considered are ...
>>
>> a. Have separate a omap3.dtsi for GP and secure devices or place the
>>    node for the 12th timer in a omap3-gp.dtsi that is only used for
>>    boards with GP devices. The downside of this is that for boards
>>    that can support GP and secure device (such as the omap3 SDP) we
>>    require a separate dtb blob.
>>
>> b. Remove the timer node dynamically at runtime using the
>>    of_node_detach() API. In this solution we define a "ti,timer-secure"
>>    property that the 12th timer on omap3 devices would have and at
>>    runtime if we are a secure omap3 device, we search the timer nodes
>>    for any nodes with this property and remove them.
>>
>> Option B, seems to be the better option but requires me to enable 
>> CONFIG_OF_DYNAMIC for all omap devices and I was not sure if there is any
>> downside to doing so. Enabling this feature does not seem to add much code
>> as far as I can tell, however, I  wanted to get some feedback before
>> proposing this. Also if there are any other options I should consider then
>> please let me know.
>>
>> For option B, the timer node would look like ...
>>
>> +               timer12: timer@48304000 {
>> +                       compatible = "ti,omap3-timer";
>> +                       ti,hwmods = "timer12";
>> +                       ti,timer-alwon;
>> +                       ti,timer-secure;
>> +               };
>>
>> I would then add the following function to the omap timer code to search
>> for any timers with the "ti,timer-secure" on a secure device and enable
>> the OF_DYNAMIC option. Right now it is only timer 12 on OMAP3 that
>> requires this, but I have made the function generic so that it could
>> handle other devices (but none exist today that I am aware of).
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 8c22a8e..5e38946 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/clocksource.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/slab.h>
>> +#include <linux/of.h>
>>  
>>  #include <asm/mach/time.h>
>>  #include <plat/dmtimer.h>
>> @@ -482,6 +483,35 @@ static int __init omap2_dm_timer_init(void)
>>  }
>>  arch_initcall(omap2_dm_timer_init);
>>  
>> +static struct of_device_id omap3_timer_match[] __initdata = {
>> +       { .compatible = "ti,omap3-timer", },
>> +       { }
>> +};
>> +
>> +/**
>> + * omap_dmtimer_init - initialisation function when device tree is used
>> + *
>> + * For secure OMAP3 devices, timers with property "ti,timer-secure" cannot
>> + * be used by the kernel as they are reserved. Therefore, to prevent the
>> + * kernel registering these devices remove them dynamically from the device
>> + * tree on boot.
>> + */
>> +void __init omap_dmtimer_init(void)
>> +{
>> +       struct device_node *np;
>> +
>> +       if (!cpu_is_omap34xx())
>> +               return;
>> +
>> +       /* If we are a secure device, remove any secure timer nodes */
>> +       if ((omap_type() == OMAP2_DEVICE_TYPE_GP)) {
> 
> Oops! Bug in the above code. Meant to be ...
> 
> 	 if (omap_type() != OMAP2_DEVICE_TYPE_GP)
>> +               for_each_matching_node(np, omap3_timer_match) {
>> +                       if (of_get_property(np, "ti,timer-secure", NULL))
>> +                               of_detach_node(np);
>> +               }
>> +       }
>> +}
> 
> Cheers
> Jon
> 

