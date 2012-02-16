From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
	for v3.4 merge window
Date: Thu, 16 Feb 2012 13:51:51 +0000
Message-ID: <20120216135151.GK15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com> <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48251 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2BPNwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 08:52:03 -0500
Content-Disposition: inline
In-Reply-To: <4F3D0186.2010500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 06:45:50PM +0530, Rajendra Nayak wrote:
> On Thursday 16 February 2012 06:04 PM, Rajendra Nayak wrote:
>>> Can you test something with these patches?
>>>
>>> 1. Build the gpio-twl4030.c as a module, but with HSMMC support built in
>>> 2. Boot on the 4430SDP
>>
>> twl4030 gpio is used for card detect on OMAP3, so I tried this
>> on my Beagle instead of 4430SDP.
>> The kernel boots up but does not detect/enumerate the mmc card.
>>
>>> 3. Load the gpio-twl4030 module
>>
>> I was expecting this to now detect the card, but I instead got
>> this error which seems to tell gpio-twl4030 has problems
>> when built/used as a module, outside of the mmc issues.
>
> Looks like I was mislead with the errors and though the twl4030
> gpio probe was bailing out with errors, which its not.
> It does seem to go ahead, does a mmc late init which registers
> the mmc omap_device and hence does a platform_device_add, but the
> device never seem to get probed. mmc driver is built in and
> registered.
>
>>
>> # insmod gpio-twl4030.ko
>> [   16.217864] twl4030_gpio twl4030_gpio: can't dispatch IRQs from modules
>> [   16.242004] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
>>
>>
>>> 4. Remove the gpio-twl4030 module
>>> 5. Re-load the gpio-twl4030.ko module
>>>
>>> and report back what you get.  Thanks.
>

(4) and (5) are the key bits of what I was asking you to do.
