From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 15:03:09 +0530
Message-ID: <4F3E1ED5.6090305@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com> <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk> <20120217091433.GL15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49192 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752385Ab2BQJdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 04:33:32 -0500
Received: by pbbrp2 with SMTP id rp2so3147293pbb.10
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 01:33:30 -0800 (PST)
In-Reply-To: <20120217091433.GL15338@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

[]...
>>>>> 3. Load the gpio-twl4030 module
>>>>
>>>> I was expecting this to now detect the card, but I instead got
>>>> this error which seems to tell gpio-twl4030 has problems
>>>> when built/used as a module, outside of the mmc issues.
>>>
>>> Looks like I was mislead with the errors and though the twl4030
>>> gpio probe was bailing out with errors, which its not.
>>> It does seem to go ahead, does a mmc late init which registers
>>> the mmc omap_device and hence does a platform_device_add, but the
>>> device never seem to get probed. mmc driver is built in and
>>> registered.
>>>
>>>>
>>>> # insmod gpio-twl4030.ko
>>>> [   16.217864] twl4030_gpio twl4030_gpio: can't dispatch IRQs from modules
>>>> [   16.242004] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
>>>>
>>>>
>>>>> 4. Remove the gpio-twl4030 module
>>>>> 5. Re-load the gpio-twl4030.ko module
>>>>>
>>>>> and report back what you get.  Thanks.
>>>
>>
>> (4) and (5) are the key bits of what I was asking you to do.
>
> Okay, so that was a total waste of time and effort, because you didn't do
> what I asked.

Sorry, I did'nt repond back because I wanted to get this resolved
completely before I did.

(3) did not probe the inserted mmc device because the driver was
doing a platform_driver_probe() and not a platform_driver_register().

Once I fixed that and removed the __init from probe, I then hit a
failure with gpio_to_irq() call in the mmc driver probe.

This was beacuse the twl gpio driver does not register irqs as said by 
this error at driver load...
 >>>> [   16.217864] twl4030_gpio twl4030_gpio: can't dispatch IRQs from 
modules
... apparently because there is no way to unregister a irq once the
module is unloaded.

That makes sdmmc pretty much unusable if twl gpio is built as a module.

>
> Tony: I think there's a bug here - if the gpio-twl4030 module is inserted,
> removed and re-inserted, I think we'll end up creating the devices for MMC
> twice with the same name, resulting in sysfs complaining very loudly.

I still went ahead and tried (4) becasue I knew I would hit the above
issue. However I end up with a rmmod complaining 'resource temporarily
unavailable' because I see there are 3 gpio_requests, which I found
were from the .setup callback in the board file (I am using beagle).
The beagle board file does not seem to however register a .teardown
hook provided by twl4030 gpio platform_data structure to do a gpio_free.
So I am now trying to get the teardown function clean stuff up including
unregister the mmc device, which should also fix the problem with
multiple mmc device register that you reported with insmod/rmmod/insmod
  sequence.

I will post patches on top of Tony's series to fix all these issues.


