From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC] ARM: OMAP: Remove nodes dynamically at runtime
Date: Thu, 5 Jul 2012 13:21:14 -0500
Message-ID: <4FF5DB1A.5080106@ti.com>
References: <4FE372CA.7020008@ti.com> <4FE3B328.8060805@ti.com> <4FECF376.3010001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58030 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab2GESVM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 14:21:12 -0400
In-Reply-To: <4FECF376.3010001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, robherring2@gmail.com, Grant Likely <grant.likely@secretlab.ca>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Rob,

Thanks for the feedback. Some how our mail server appeared to filter out your
response!

> On 06/21/2012 06:50 PM, Jon Hunter wrote:
>> 
>> On 06/21/2012 02:15 PM, Jon Hunter wrote:
>>> Hi all,
>>>
>>> I am in the process of adding a device-tree binding for OMAP timers and
>>> I have encountered a scenario where ideally it would be useful to remove
>>> a device-tree node at runtime.
>>>
>>> The scenario is this ...
>>>
>>> 1. OMAP3 devices may or may not have security features enabled. Security
>>>    enabled devices are known as high-secure (HS) and devices without 
>>>    security are known as general purpose (GP).
>>> 2. For OMAP3 devices there are 12 general purpose timers available.
>>> 3. On secure devices the 12th timer is reserved for secure usage and so
>>>    cannot be used by the kernel, where as for a GP device it is available.
>>> 4. We can detect the OMAP device type, secure or GP, at runtime via an
>>>    on-chip register.
>>> 5. Today, when not using DT, we do not register the 12th timer as a linux
>>>    device if the device is secure.
>>>
>>> When migrating the timers to DT, I need a way to prevent this 12th timer
>>> from being registered as a device on a secure device. The options I have
>>> considered are ...
>>>
>>> a. Have separate a omap3.dtsi for GP and secure devices or place the
>>>    node for the 12th timer in a omap3-gp.dtsi that is only used for
>>>    boards with GP devices. The downside of this is that for boards
>>>    that can support GP and secure device (such as the omap3 SDP) we
>>>    require a separate dtb blob.
>
> That's certainly not ideal since you can distinguish which device you
> are on. Does omap have a custom register for this because determining
> secure vs. non-secure mode is a common problem without a standard way to
> determine it.

Yes, unfortunately the register I was referring to is a custom OMAP register. 

>>>
>>> b. Remove the timer node dynamically at runtime using the
>>>    of_node_detach() API. In this solution we define a "ti,timer-secure"
>>>    property that the 12th timer on omap3 devices would have and at
>>>    runtime if we are a secure omap3 device, we search the timer nodes
>>>    for any nodes with this property and remove them.
>>>
>>> Option B, seems to be the better option but requires me to enable 
>>> CONFIG_OF_DYNAMIC for all omap devices and I was not sure if there is any
>>> downside to doing so. Enabling this feature does not seem to add much code
>>> as far as I can tell, however, I  wanted to get some feedback before
>>> proposing this. Also if there are any other options I should consider then
>>> please let me know.
>>>
>
> I would wonder if of_node_get/put calls are all properly implemented.
> They don't really matter until OF_DYNAMIC is enabled, but it would
> affect all ARM DT platforms once we enable multi-platform support.
>
> Option C - have the bootloader set nodes status property to disabled.
> 
> Option D - same as C, but do it in the kernel with prom_add_property.

Option D, sounds good to me. I will look into this.

Thanks
Jon
