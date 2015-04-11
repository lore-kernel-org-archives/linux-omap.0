From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH] ARM: omap2plus_defconfig: Switch over to using 8250
 driver
Date: Sat, 11 Apr 2015 13:27:44 -0500
Message-ID: <552967A0.9080804@ti.com>
References: <1428689893-14605-1-git-send-email-nm@ti.com> <55282737.8060407@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbbDKS2C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Apr 2015 14:28:02 -0400
In-Reply-To: <55282737.8060407@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>

On 04/10/2015 02:40 PM, Peter Hurley wrote:
> [ +Sebastian, +Tony ]
> 
> On 04/10/2015 02:18 PM, Nishanth Menon wrote:
>> 8250 driver should be relatively feature complete. It can co-exist
>> with omap-serial driver
> 
> Not really; if the omap_8250 is selected then it is probed first
> and will be the only driver claiming omap UART ports.
> 
> omap-serial would just be dead-weight.

true.. my bad..

> 
>> , so just enable 8250 OMAP layer driver and
>> route all ttyOx references to ttySx through the standard 8250 driver
>> to ensure no breakage of userspace occurs.
> 
> Not quite; the only automatic handling is for console only, not for
> userspace. Expect lots of userspace breakage.
> 


Yep - overall, looking through individual logs, in my testing, it seems
to work at least for console for all platforms - even though the
filesystems are mostly going bonkers -> older fs did not have the udev
redirection to take care of this - mostly to do with the getty hooked on
to static consoles.


There are infact two issues:
a) bootloader change for cmdline -> O2 to S2 -> in many cases we are
lesser inclined to change the bootloader, hence the fixup configuration
b) fs changes - these are sometimes more realistic to do, but is a clear
breakage risk.


Overall, keeping two equally functional drivers in the system sounds a
bunch of maintenance burden for all of us and not to mention confusion
for the future.


Btw, I am not exactly proposing this for 4.1 kernel.. instead, we should
probably discuss how to best introduce this in and throw out the older
omap_serial driver - just reuse 8250 and co-exist with the rest of the
good world folks ;)..


-- 
Regards,
Nishanth Menon
