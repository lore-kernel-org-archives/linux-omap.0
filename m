From: Tony Lindgren <tony@atomide.com>
Subject: Re: ideas about idle loop and power management
Date: Tue, 23 Sep 2014 13:37:23 -0700
Message-ID: <20140923203722.GB3122@atomide.com>
References: <CAJ2oMhKRSo76NEppiR6oqJXeuwrN=Um2azKCNGgP3PbuH_T3PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20709 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbaIWUhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2014 16:37:41 -0400
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKRSo76NEppiR6oqJXeuwrN=Um2azKCNGgP3PbuH_T3PA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [140923 12:24]:
> Hello,
> 
> I have a system which is required to have 2 modes operation:
> 1. idle - in which devices in Soc and on board should be off.
> 2. active mode

Hmm we do this already with the mainline kernel since v3.16-rc6
for device tree based systems too. Some devices will still block
deeper idle states idle like EHCI. I suggest you give v3.17-rc6
a try on a beagleboard xm (rev c preferrably)using omap2plus_defconfig.
Or omap 37xx evm. Or on n900. Or overo, but that's still pending
a .dts fix.
 
> Moving from idle to active on interrupt, and moving from active to
> idle when there is inactivity.
> After reading and re-reading about PM various mechanism, I got to
> conculsion that the best and easiest way to achive this on omap
> (omap3530) will be as following:
> 1. use cpuidle
> 2. find the exact place in cpuidle mechanism where we enter idle loop,
> and where we exit idle loop.
> 3. on entering idle loop: turn off various devices on board, and
> devices power domain

The devices are autoidle where possible with runtime PM. And then
the hardware enters deeper idle states when drivers are not
blocking.

> 4. on exit idle loop: power again the devices.
> 
> I think that working such way on low machine registers will be easiest
> and best instead of trying to do it using PM mechanism, which is quite
> difficult to understand and do and also, I'm not sure even possible
> using the existing mechanism.

Hmm but that's already working with the mainline tree :)
 
> I would appreciate your feedback.

Sounds like you just need to give it a try. I'm using the following
test script. You may need to also blank the LCD.

Regards,

Tony

#!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d 2>/dev/null)
for uart in $uarts; do
        echo enabled > $uart/wakeup 2>&1
        echo auto > $uart/control 2>&1
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

