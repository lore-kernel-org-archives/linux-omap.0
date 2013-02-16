From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 14:47:45 +0530
Message-ID: <511F4EB9.2020408@ti.com>
References: <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com> <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com> <20130215163031.GA5724@atomide.com> <20130215164235.GA20840@arwen.pp.htv.fi> <511F20B1.8010502@ti.com> <20130216085528.GA19639@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3BPJQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Feb 2013 04:16:34 -0500
In-Reply-To: <20130216085528.GA19639@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>, rafael.j.wysocki@intel.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

+ Rafael,

On Saturday 16 February 2013 02:25 PM, Felipe Balbi wrote:
> Hi,
>
> On Sat, Feb 16, 2013 at 11:31:21AM +0530, Santosh Shilimkar wrote:
>>>> The main goal is to avoid duplicating data both in hwmod and DT.
>>>> That's pretty much solved as we can have the driver probe populate
>>>> the common data for hwmod from DT as Santosh has already demonstrated.
>>>>
>>>> Then we also want the driver specific idle and reset code to be done
>>>> in the drivers rather than in hwmod and glue it together with hwmod
>>>> using runtime PM. The biggest issue there is how do we reset and idle
>>>> some piece of hardware for PM purposes when there's no driver loaded.
>>>
>>> right, this will be a tough nut to crack.
>>>
>>> I guess the only way would be reset all IPs early in the boot process,
>>> before even creating the platform-devices. Can we do that ? I mean, from
>>> omap_device_build_from_dt() we have access to address space of all
>>> devices, through ti,hwmods we can figure out which hwmods are linked to
>>> that particular device, so whenever you build a device, you could just
>>> call _reset().
>>>
>> Thats what we do today and it works perfectly. As per Tony's suggestion,
>> we need to move the non-probed devices reset and idle setup to late_init
>> which is also doable.
>>
>> In that case when probed driver calls runtime_get(), we reset that
>> device and setup the idle settings. And remainder of the devices
>> are managed in late_init().
>
> what's the point in moving it to late_initcall() ? It makes no
> difference, if no driver binds to that device it will stay in reset
> anyway. Maybe what we're missing is properly idling (not exactly) all
> devices before driver probe kicks in.
>
I think it is largely reducing the early init dependencies and also
reducing the role of platform code who today takes care of every
device idle and reset initialization. That way late_init() will
only have to care about the devices which are not probed by
drivers.

Tony, Is that right ?


>>> The only problem is that now omap_device_build_from_dt() is called after
>>> we notify that a new device/driver pair has been registered with the
>>> platform_bus, right ? So we would still need a way to call _reset() for
>>> those which are on DTS but don't have a driver bound to them...
>>>
>> The only special requirement for reset remains(which today handled by
>> hwmod function calls) is for devices which needs specific reset
>> sequence. And this one can be handled through a runtime_reset()
>> kind of hook.
>>
>> Does that sound reasonable ?
>
> Depends on Rafael. If he says no to the ->runtime_reset() I suggested
> earlier, another aproach needs to be found. In any case,
> ->runtime_reset() is only for devices which actually have a driver, so
> it matters little.
>
I agree. Looping Rafael to hear from him.

To add a bit of context,
On OMAP we do have few IP blocks which needs a special reset sequence
during init as well as working state of the driver. Some of this
was worked around such cases by populating function pointers from
platform data which drivers can use. This obviously doesn't scale
and won't work with DT based builds. We have been thinking of
having a runtime_reset() generic callback which drivers can use.

Whats you take on it ?

> The difficult part is handling special reset requirements for devices
> without drivers as there'd be no ->runtime_reset() to call.
>
I don't think that requirement exists so if we address the driver
requirement, we are good. Even otherwise also, it can be managed
from platform code.

Regards,
Sasntosh
