From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 11:31:21 +0530
Message-ID: <511F20B1.8010502@ti.com>
References: <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com> <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com> <20130215163031.GA5724@atomide.com> <20130215164235.GA20840@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3BPGAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 01:00:16 -0500
In-Reply-To: <20130215164235.GA20840@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 15 February 2013 10:12 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Feb 15, 2013 at 08:30:32AM -0800, Tony Lindgren wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 05:34]:
>>> On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
>>>> On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
>>>>> Whats your view on use of arch_ioremap_caller() hook ? This can allow
>>>>> us to avoid the dual ioremap() issue discussed here if the hook
>>>>> maintains the list of mapped ios.
>>>>>
>>>>> I was even thinking of having such intelligence within the core
>>>>> ioremap code but thought that might be too invasive.
>>>>
>>>> Why do you even need it?  There's no problem with ioremapping the same
>>>> space multiple times (you end up with multiple mappings but that
>>>> shouldn't be a problem, except for the additional space used.)
>>>>
>>> It just waste of iospace and Tony insisted to have just single ioremap()
>>> hence all this discussion
>>
>> The main goal is to avoid duplicating data both in hwmod and DT.
>> That's pretty much solved as we can have the driver probe populate
>> the common data for hwmod from DT as Santosh has already demonstrated.
>>
>> Then we also want the driver specific idle and reset code to be done
>> in the drivers rather than in hwmod and glue it together with hwmod
>> using runtime PM. The biggest issue there is how do we reset and idle
>> some piece of hardware for PM purposes when there's no driver loaded.
>
> right, this will be a tough nut to crack.
>
> I guess the only way would be reset all IPs early in the boot process,
> before even creating the platform-devices. Can we do that ? I mean, from
> omap_device_build_from_dt() we have access to address space of all
> devices, through ti,hwmods we can figure out which hwmods are linked to
> that particular device, so whenever you build a device, you could just
> call _reset().
>
Thats what we do today and it works perfectly. As per Tony's suggestion,
we need to move the non-probed devices reset and idle setup to late_init
which is also doable.

In that case when probed driver calls runtime_get(), we reset that
device and setup the idle settings. And remainder of the devices
are managed in late_init().

> The only problem is that now omap_device_build_from_dt() is called after
> we notify that a new device/driver pair has been registered with the
> platform_bus, right ? So we would still need a way to call _reset() for
> those which are on DTS but don't have a driver bound to them...
>
The only special requirement for reset remains(which today handled by
hwmod function calls) is for devices which needs specific reset
sequence. And this one can be handled through a runtime_reset()
kind of hook.

Does that sound reasonable ?

Regards,
Santosh
