From: Alexander Holler <holler@ahsoftware.de>
Subject: rtc-twl: catch22 in 2.6.37 and 2.6.38 when clock was never set
Date: Mon, 04 Apr 2011 16:29:04 +0200
Message-ID: <4D99D5B0.6010503@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:34979 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab1DDO3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:29:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Hello,

it just happened here that the rechargeable backup battery for the RTC 
on a TPS65950 run out off power, because of some days while the device 
wasn't powered.

Afterwards I couldn't read or set the clock with hwclock using a kernel 
2.6.37.n or 2.6.38.n.

I don't have a fix, but I think I've analyzed the problem and can offer 
a (bad) workaround.

What happens is the following:

When trying to read or set the clock with hwclock, the driver (rtc-twl) 
starts an alarm, but the irq for the alarm will never get called. The 
result is that a select in hwclock times out (for both operations, read 
or set).

Because I had this clock running before, I've got the idea to try one of 
those old OMAP-kernels (2.6.32-angstrom) using the same userland.
And with that kernel I could set the clock.
Using 2.6.37 or 2.6.38 afterwards, hwclock did function again, both read 
an set are working.

So it looks like there is a catch22 in kernels >=2.6.37 (I haven't 
tested .33-.36):

When the clock was never set, the alarm(-irq) doesn't work, so hwclock 
doesn't work, so one can't set the clock.

Regards,

Alexander Holler
