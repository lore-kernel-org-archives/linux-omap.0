From: Nishanth Menon <nm@ti.com>
Subject: Re: PM branch updated to v2.6.35, SRF dropped
Date: Thu, 5 Aug 2010 18:11:27 -0500
Message-ID: <4C5B451F.9050405@ti.com>
References: <8739uu9em0.fsf@deeprootsystems.com> <4C59F6D1.8050804@ti.com> <8739usr8wh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39025 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0HEXL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 19:11:28 -0400
In-Reply-To: <8739usr8wh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 08/05/2010 05:29 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Kevin Hilman had written, on 08/04/2010 05:50 PM, the following:
>> [...]
>>
>>> I've only tested the new PM branch on a couple boards to avoid any
>>> further delay getting this version out, update, so hopefully others will
>>> help test.
>>>
>>> I've tested RET on idle & suspend, OFF in idle & suspend on:
>>>
>>> 3430/omap3evm: works
>>>
>>> 3630/Zoom3: works
>>> - Known problem: console hangs on UART wakeup when  wakeups are enabled using
>>>   echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>>>   but I haven't debugged this further.
>> Just sharing results from SDP testing omap3_pm_defconfig + earlyprintk:
>> SDP3430 (with denx.com u-boot, nor boot): does not boot to shell
>> full Bootlog: http://pastebin.mozilla.org/761964
> 
> Does the same setup boot fine on l-o for-next, or l-o master? 
yep

l-o master (omap3_defconfig):
Log: http://pastebin.mozilla.org/762620


l-o for-next  (omap3_defconfig):
build fails with:
drivers/usb/musb/omap2430.c: In function 'musb_platform_init': 

drivers/usb/musb/omap2430.c:198: error: 'AE5_2430_USB0HS_STP' undeclared 
(first use in this function)
drivers/usb/musb/omap2430.c:198: error: (Each undeclared identifier is 
reported only once
drivers/usb/musb/omap2430.c:198: error: for each function it appears in.)

so disabled CONFIG_ARCH_OMAP2430 and CONFIG_MACH_OMAP_2430SDP in .config 
for quick bootup.

Log: http://pastebin.mozilla.org/762637

Ref:
  remotes/origin/master                 8428498 Linux-omap rebuilt: arm 
changes merged to mainline, final omap changes for 2.6.36
remotes/origin/for-next               d21872b Merge branch 
'v2.6.35-omap-mailbox-for-next' of git://gitorious.org/~doyu/lk/mainline 
into omap-for-linus

> 
>> SDP3630 (with TI u-boot, xloader, mmc boot): ret works, uart wakeup
>> fails for off mode (I am guessing this is similar to Kevin's results)
>> full Bootlog: http://pastebin.mozilla.org/761966
> 
>> OMAP4 Blaze (with TI u-boot, xloader, mmc boot): does not boot, hell
>> lot of crashes - note, need to explicitly enable MACH_OMAP4430_SDP in
>> .config
>> full Bootlog: http://pastebin.mozilla.org/761968
> 
> yeah, I don't expect PM branch to work on OMAP4 until we get the OMAP4 hwmod
> core upstream.
:(

-- 
Regards,
Nishanth Menon
