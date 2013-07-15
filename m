From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Mon, 15 Jul 2013 11:16:52 +0300
Message-ID: <51E3AFF4.7060607@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com> <51DFDFD4.3040900@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3GOIRW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 04:17:22 -0400
In-Reply-To: <51DFDFD4.3040900@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On 07/12/2013 01:52 PM, Stefan Roese wrote:
> Roger,
> 
> On 07/12/2013 11:15 AM, Roger Quadros wrote:
>>>> Good idea. I'm currently using a "dirty" local version. I'll try to
>>>> switch to an officially available version tomorrow. And send you the
>>>> version/git id.
>>>
>>> I updated my U-Boot to the following version: Based on mainline git
>>> commit ID 225fd8c. Only this patch added:
>>>
>>> http://patchwork.ozlabs.org/patch/256702/
>>>
>>> This is needed for USB to work in U-Boot. Otherwise my external USB
>>> SMSC95xx will not be detected in U-Boot.
>>
>> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
>> as I don't have an external USB-ethernet adapter.
> 
> Too bad. This difference in boards makes the tests a bit less
> meaningful. Is there really no USB-ethernet adapter somewhere in your
> department (perhaps a non-SMSC95xx might serve as well?)? I might
> send/order you one if necessary. ;)

Thanks for the offer :). I'll just get one for myself by today/tomorrow.
The one available here uses this driver "drivers/net/usb/asix.c"

> 
>> The above commit doesn't work well for beagle-xm,
> 
> Why is this? What does happen? Does U-Boot not boot up to the prompt?
> Please send me a log.

The last time it had failed I remember seeing a lot of IO pad configuration errors.
But I'm no longer able to reproduce that problem. Maybe it was just a messed up
build. In case I observe it again I'll let you know.

> 
>> so my u-boot is on tag v2013.04
>> and you don't need that additional patch.
>>
>> Can you please retest on it? Thanks.
> 
> Done, please see below.
> 
>> You will need to set "usbethaddr" before starting USB else SMSC will not work.
>> e.g.
>> 	setenv usbethaddr A6:66:4D:B0:69:04
> 
> I don't have a beagle-xm, only my beable. And my U-Boot network setup is
> already working, thanks.

Right. you won't need that for beagle. It was only for beagle-xm or panda with on board
usb-ethernet.

> 
>> Also could you please increase the Linux console message verbosity to debug (8), so that
>> all kernel messages are visible in the log? If it spits out something more than what you
>> sent last time then do send it to me.
> 
> I added "ignore_loglevel" to the cmdline. But I cannot see anything
> interesting that has not been there before with "debug" as well.

OK.

cheers,
-roger
