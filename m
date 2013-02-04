From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Mon, 4 Feb 2013 12:46:16 -0600
Message-ID: <511001F8.20306@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-3-git-send-email-jon-hunter@ti.com> <20130201215154.GV22517@atomide.com> <510C6A3D.70401@ti.com> <20130202181147.GC577@atomide.com> <510FCE40.5040202@ti.com> <20130204174501.GO22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53346 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab3BDSqU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 13:46:20 -0500
In-Reply-To: <20130204174501.GO22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/04/2013 11:45 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130204 07:09]:
>>
>> On 02/02/2013 12:11 PM, Tony Lindgren wrote:
>>> * Jon Hunter <jon-hunter@ti.com> [130201 17:25]:
>>>>
>>>> On 02/01/2013 03:51 PM, Tony Lindgren wrote:
>>>>>
>>>>> How about let's fix this properly to start with so we don't add
>>>>> more blockers moving this code to drivers/bus?
>>>>>
>>>>> Looks like gpmc_mem_init() gets called from gpmc_probe() so
>>>>> we can pass that information in pdev.
>>>>
>>>> I wondered if you would suggest that ;-)
>>>
>>> :)
>>>  
>>>> I definitely can and it is probably best. Things like this become
>>>> painful when we move to device-tree. We really need a generic way for
>>>> passing stuff like this to drivers for omap. Our options are auxdata or
>>>> bus notifiers. I am wondering whether we can plug pdata in the
>>>> omap_device bus notifier for device-tree. Let me know if you have any
>>>> thoughts.
>>>
>>> Hmm but in this case can't you just do it based on the compatible
>>> flag? For legacy systems we also need to pass it in pdata.
>>
>> This is a boot-time configuration. So really you need to read the
>> control status register at boot and then determine the mapping. We could
>> store the address of the control status read in the pdata, but I think
>> that is a bit of a hack.
> 
> Ah right. Well once we have Haojian's generic pinconf patches merged for
> pinctrl-single, we can set up the CONTROL_STATUS register as a
> pinctrl-single,bits register and query the SYSBOOT_3 pin value directly
> from the driver.
> 
> AFAIK SYSBOOT_n values reflect the boot time values of the actual SYSBOOT
> pins, so using generic pinconf there makes sense. But this of course should
> be checked.

Not sure I am a fan of that idea. It is possible the pins could be
re-used as GPIOs after reset. Given that the state at reset is latched
in a register, it is best just to read the register directly.

>>> Regarding omap_device, we should find a way to keep the dependencies
>>> between drivers and the bus code down to minimum. So ideally things
>>> like this would be only done using just the compatible flag. But the
>>> pdata we cannot remove quite yet.
>>
>> Agree. However, there are several drivers today (gpio, dmtimer, mmc,
>> serial, dss, etc), that make use of a function pointer to
>> omap_pm_get_dev_context_loss_count() to determine when the peripheral's
>> state has been lost. When booting with DT this function pointer is not
>> populated and so with DT we currently have no way to determine this. I
>> see this as a blocker to migrating completely to DT. Ideally we would
>> find a way for RPM to handle this and remove the function pointer.
>> However, right now we still need a generic way to pass this type of
>> platform data to drivers.
> 
> Yeah pinconf generic won't help us with the legacy boot.

Right. I view all this sort of thing as system-level device information
that some drivers may need. It does not seem that we have a good way to
handle that at the moment. Any ideas?

Jon
