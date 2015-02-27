From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
Date: Fri, 27 Feb 2015 11:00:52 -0600
Message-ID: <54F0A2C4.1060401@ti.com>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com> <1420228817-41310-3-git-send-email-d-gerlach@ti.com> <20150102201643.GE4920@saruman> <54AB14E4.2010607@ti.com> <20150105225134.GN4081@atomide.com> <54EF7B90.3050702@ti.com> <20150226220817.GR11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150226220817.GR11056-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,
On 02/26/2015 04:08 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150226 12:05]:
>> Tony,
>> On 01/05/2015 04:51 PM, Tony Lindgren wrote:
>>> * Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150105 14:51]:
>>>> Felipe,
>>>> On 01/02/2015 02:16 PM, Felipe Balbi wrote:
>>>>> On Fri, Jan 02, 2015 at 02:00:16PM -0600, Dave Gerlach wrote:
>>>>>> Introduce a wkup_m3_ipc driver to handle communication between the MPU
>>>>>> and Cortex M3 wkup_m3 present on am335x.
>>>>>>
>>>>>> This driver is responsible for actually booting the wkup_m3_rproc and
>>>>>> also handling all IPC which is done using the IPC registers in the control
>>>>>> module, a mailbox, and a separate interrupt back from the wkup_m3. A small
>>>>>> API is exposed for executing specific power commands, which include
>>>>>> configuring for low power mode, request a transition to a low power mode,
>>>>>> and status info on a previous transition.
>>>>>>
>>>>>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>>>>>> ---
>>>>>>  drivers/soc/ti/Kconfig       |  11 ++
>>>>>>  drivers/soc/ti/Makefile      |   1 +
>>>>>>  drivers/soc/ti/wkup_m3_ipc.c | 451 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>  include/linux/wkup_m3_ipc.h  |  33 ++++
>>>>>>  4 files changed, 496 insertions(+)
>>>>>>  create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
>>>>>>  create mode 100644 include/linux/wkup_m3_ipc.h
>>>>>>
>>>>>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>>>>>> index 7266b21..61cda85 100644
>>>>>> --- a/drivers/soc/ti/Kconfig
>>>>>> +++ b/drivers/soc/ti/Kconfig
>>>>>> @@ -28,4 +28,15 @@ config KEYSTONE_NAVIGATOR_DMA
>>>>>>  
>>>>>>  	  If unsure, say N.
>>>>>>  
>>>>>> +config WKUP_M3_IPC
>>>>>> +	bool "TI AM33XX Wkup-M3 IPC Driver"
>>>>>
>>>>> tristate ?
>>>>
>>>> If we want to allow this and the rproc driver to be built as modules than we can
>>>> change this.
>>>
>>> Yes please, the PM is never needed early, and should be optional.
>>> And doing that will make it a lot easier for you to do further work
>>> on your driver ;)
>>>
>>> And it will also make it easier to add support for other SoCs as
>>> it seems the same M3 is used at least on am437x.
>>>  
>>
>> I can not build the PM code as a module at this time due to many mach-omap
>> function calls it uses which are not exported, so I need handles to all five
>> functions in this driver used in pm33xx to call from built-in PM code. Do you
>> have a preference on how these function handles get passed?
> 
> OK, you can pass the function pointers in platform_data. Care to
> list those functions? That might allow us to make other omap PM
> code into loadable modules in drivers/* :)

Sure, apart from the dependencies I create for myself in other modules that I
introduce I see:

ERROR: "omap_pm_clkdms_setup" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "clkdm_for_each" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "clkdm_lookup" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "pwrdm_lookup" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "pwrdm_post_transition" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "clkdm_sleep" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "clkdm_wakeup" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "pwrdm_read_pwrst" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "cpu_suspend" [arch/arm/mach-omap2/pm33xx.ko] undefined!
ERROR: "omap_set_pwrdm_state" [arch/arm/mach-omap2/pm33xx.ko] undefined!

So the mach-omap2 clockdomain and power domain functions along with arch arm
cpu_suspend code. I see similar dependencies in the other mach-omap2/pmxxxx.c
code also.

>  
>> I currently have added a pdata-quirks implementation that passes a function to
>> the wkup_m3_ipc driver through it's pdata which it then calls at probe to pass a
>> struct containing all used function pointers to the pm code that were previously
>> called directly. Is that what you would prefer or something else? I had also
>> looked at making the struct of function pointers in the driver global and just
>> picking it up from the pm code with an extern declaration or even putting a bus
>> notifier in the PM code and watching for the wkup_m3_ipc driver to be bound.
> 
> Yeah pdata-quirks.c is probably OK for populating the function pointers.
> We may have already some place in the PM code to pass it too.
>  

Alright, thanks for your input.

>> Thought I would see what you prefer and possibly avoid an unnecessary re-spin.
> 
> Sounds like we're getting close to getting am335x/am437x PM code working :)

Getting there!

Regards,
Dave

> 
> Regards,
> 
> Tony
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
