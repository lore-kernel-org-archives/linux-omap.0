From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Mon, 4 Feb 2013 13:51:03 -0600
Message-ID: <51101127.8010602@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-3-git-send-email-jon-hunter@ti.com> <20130201215154.GV22517@atomide.com> <510C6A3D.70401@ti.com> <20130202181147.GC577@atomide.com> <510FCE40.5040202@ti.com> <20130204174501.GO22517@atomide.com> <511001F8.20306@ti.com> <20130204191552.GQ22517@atomide.com> <51100D21.9050505@ti.com> <20130204194725.GR22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57254 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab3BDTvK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 14:51:10 -0500
In-Reply-To: <20130204194725.GR22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/04/2013 01:47 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130204 11:37]:
>>
>> On 02/04/2013 01:15 PM, Tony Lindgren wrote:
>>> * Jon Hunter <jon-hunter@ti.com> [130204 10:49]:
>>>> On 02/04/2013 11:45 AM, Tony Lindgren wrote:
>>>>>
>>>>> AFAIK SYSBOOT_n values reflect the boot time values of the actual SYSBOOT
>>>>> pins, so using generic pinconf there makes sense. But this of course should
>>>>> be checked.
>>>>
>>>> Not sure I am a fan of that idea. It is possible the pins could be
>>>> re-used as GPIOs after reset. Given that the state at reset is latched
>>>> in a register, it is best just to read the register directly.
>>>
>>> Yes the physical SYSBOOT pins can be reused as GPIO, but that's are already
>>> handled by the padconf and GPIO registers. This is a different register
>>> showing the boot time pin values for some pins. So it makes sense to use
>>> generic pinconf to make the pin values available to the client drivers
>>> as needed.
>>>
>>> The advantage doing it this way is that we don't need to export any omap
>>> custom functions to the drivers from the SCM driver. This way we need zero
>>> platform glue code, and can deal with it directly in the drivers in a
>>> generic way. And all we need to do is just need to map the SoC specific
>>> SYSBOOT pin register in the .dts files.
>>
>> I see what you are saying exporting the state in control_status register
>> via the pinconf. That could work.
>>
>>> It may also make sense to export DEVICETYPE this way. At least early omaps
>>> had the GP vs HS mode configured by pulls on some pins during the boot time.
>>> So those bits too may reflect actual physical pins during the boot time
>>> configured by the efuse settings?
>>
>> I *believe* that was only omap1.
> 
> Yeah but maybe the efuses just configure some pulls for selected pins for
> later omaps?
>  
>>>>>>> Regarding omap_device, we should find a way to keep the dependencies
>>>>>>> between drivers and the bus code down to minimum. So ideally things
>>>>>>> like this would be only done using just the compatible flag. But the
>>>>>>> pdata we cannot remove quite yet.
>>>>>>
>>>>>> Agree. However, there are several drivers today (gpio, dmtimer, mmc,
>>>>>> serial, dss, etc), that make use of a function pointer to
>>>>>> omap_pm_get_dev_context_loss_count() to determine when the peripheral's
>>>>>> state has been lost. When booting with DT this function pointer is not
>>>>>> populated and so with DT we currently have no way to determine this. I
>>>>>> see this as a blocker to migrating completely to DT. Ideally we would
>>>>>> find a way for RPM to handle this and remove the function pointer.
>>>>>> However, right now we still need a generic way to pass this type of
>>>>>> platform data to drivers.
>>>>>
>>>>> Yeah pinconf generic won't help us with the legacy boot.
>>>>
>>>> Right. I view all this sort of thing as system-level device information
>>>> that some drivers may need. It does not seem that we have a good way to
>>>> handle that at the moment. Any ideas?
>>>
>>> I suggest just passing it in in pdata for now for the legacy boot. Then
>>> I suggest we make what we can generic with pinconf in the long run.
>>
>> I don't see why we would want to export a function pointer to
>> omap_pm_get_dev_context_loss_count() with pinconf. Have we got our wires
>> crossed here?
> 
> Yes sorry, too many muxes here. I got this topic mixed up with the sysboot
> pin topic :)
> 
> We really need to find a Linux generic API to query this. Sounds like it
> should be part of runtime PM?

Ideally, yes. I had discussed with Kevin about adding a new state for
"logic state lost" and then if this could be passed to the RPM resume
callback then we could use this. May be I need to bring this up with Tero.

Cheers
Jon
