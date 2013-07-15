From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Mon, 15 Jul 2013 10:24:17 +0200
Message-ID: <51E3B1B1.3060202@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com> <51DFDFD4.3040900@denx.de> <51E3AFF4.7060607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:34901 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3GOIY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 04:24:58 -0400
In-Reply-To: <51E3AFF4.7060607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On 07/15/2013 10:16 AM, Roger Quadros wrote:
>>> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
>>> as I don't have an external USB-ethernet adapter.
>>
>> Too bad. This difference in boards makes the tests a bit less
>> meaningful. Is there really no USB-ethernet adapter somewhere in your
>> department (perhaps a non-SMSC95xx might serve as well?)? I might
>> send/order you one if necessary. ;)
> 
> Thanks for the offer :). I'll just get one for myself by today/tomorrow.
> The one available here uses this driver "drivers/net/usb/asix.c"

Great.

>>
>>> The above commit doesn't work well for beagle-xm,
>>
>> Why is this? What does happen? Does U-Boot not boot up to the prompt?
>> Please send me a log.
> 
> The last time it had failed I remember seeing a lot of IO pad configuration errors.
> But I'm no longer able to reproduce that problem. Maybe it was just a messed up
> build. In case I observe it again I'll let you know.

It might be related to a problem with the gd (global-data) pointer being
overwritten in den SPL. This is still not finally resolved the upcoming
release:

http://patchwork.ozlabs.org/patch/251293/

>>
>>> so my u-boot is on tag v2013.04
>>> and you don't need that additional patch.
>>>
>>> Can you please retest on it? Thanks.
>>
>> Done, please see below.
>>
>>> You will need to set "usbethaddr" before starting USB else SMSC will not work.
>>> e.g.
>>> 	setenv usbethaddr A6:66:4D:B0:69:04
>>
>> I don't have a beagle-xm, only my beable. And my U-Boot network setup is
>> already working, thanks.
> 
> Right. you won't need that for beagle. It was only for beagle-xm or panda with on board
> usb-ethernet.

I'm using the (external) USB-ethernet adapter on the beagle in U-Boot as
well. To tftp the kernel/dtb.

Thanks,
Stefan
