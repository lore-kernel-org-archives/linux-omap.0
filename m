From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Fri, 12 Jul 2013 12:15:27 +0300
Message-ID: <51DFC92F.1050701@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48125 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757211Ab3GLJP4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 05:15:56 -0400
In-Reply-To: <51DEF0DE.4050607@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

Stefan,

On 07/11/2013 08:52 PM, Stefan Roese wrote:
> On 07/11/2013 05:34 PM, Stefan Roese wrote:
>> On 07/11/2013 04:35 PM, Roger Quadros wrote:
>>>> BTW: I noticed a git ID (8e1cacd) in your kernel that I can't identify.
>>>> Do you have any patches locally applied to the kernel.org version that
>>>> might be helpful with this USB issue I'm seeing?
>>>
>>> Yes I had tested it on a more recent kernel with some local patches applied
>>> that I've recently sent for review.
>>>
>>> But to cross check with your setup I've retested it with commit d2b4a646 
>>> with the 2 below patches on top
>>>
>>> https://lkml.org/lkml/2013/6/20/327
>>> https://lkml.org/lkml/2013/6/20/339
>>
>> Thanks. I have exactly those 2 patches applies as well. But on a
>> different git commit. And with some local (unrelated) patches as well.
>> I'll revert to exactly your version tomorrow and test again.
> 
> Okay. I changed to exactly this version: d2b4a646 with those 2 patches
> on top.
> 
>>> I've tried it again with the ELDK 5.3 root but still can't get it to fail.
>>>
>>> I think we should match our u-boot as well. Could you please let me know
>>> your u-boot commit and uEnv.txt?
>>
>> Good idea. I'm currently using a "dirty" local version. I'll try to
>> switch to an officially available version tomorrow. And send you the
>> version/git id.
> 
> I updated my U-Boot to the following version: Based on mainline git
> commit ID 225fd8c. Only this patch added:
> 
> http://patchwork.ozlabs.org/patch/256702/
> 
> This is needed for USB to work in U-Boot. Otherwise my external USB
> SMSC95xx will not be detected in U-Boot.

I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
as I don't have an external USB-ethernet adapter.
The above commit doesn't work well for beagle-xm, so my u-boot is on tag v2013.04
and you don't need that additional patch.

Can you please retest on it? Thanks.

You will need to set "usbethaddr" before starting USB else SMSC will not work.
e.g.
	setenv usbethaddr A6:66:4D:B0:69:04

Also could you please increase the Linux console message verbosity to debug (8), so that
all kernel messages are visible in the log? If it spits out something more than what you
sent last time then do send it to me.

Let's first sort out the beagle-xm problem, then we can see about old beagle.

cheers,
-roger
