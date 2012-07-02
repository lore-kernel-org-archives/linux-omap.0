From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] ARM: OMAP: Remove nodes dynamically at runtime
Date: Sun, 01 Jul 2012 22:49:35 -0500
Message-ID: <4FF11A4F.9020906@gmail.com>
References: <4FE372CA.7020008@ti.com> <4FE3B328.8060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4FE3B328.8060805-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

That's certainly not ideal since you can distinguish which device you
are on. Does omap have a custom register for this because determining
secure vs. non-secure mode is a common problem without a standard way to
determine it.

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

I would wonder if of_node_get/put calls are all properly implemented.
They don't really matter until OF_DYNAMIC is enabled, but it would
affect all ARM DT platforms once we enable multi-platform support.

Option C - have the bootloader set nodes status property to disabled.

Option D - same as C, but do it in the kernel with prom_add_property.

Rob

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
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
