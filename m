From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
Date: Fri, 9 Nov 2012 20:53:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211092036170.20703@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com> <1352417516-15213-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com> <20121109011738.17381.88199@nucleus> <alpine.DEB.2.00.1211091900250.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211091906340.20703@utopia.booyaka.com> <20121109194023.17381.62227@nucleus> <alpine.DEB.2.00.1211091951080.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2KIUxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 15:53:34 -0500
In-Reply-To: <alpine.DEB.2.00.1211091951080.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 9 Nov 2012, Paul Walmsley wrote:

> On Fri, 9 Nov 2012, Mike Turquette wrote:
> 
> > But I'm OK with the below patch in the short term.  I just have one
> > question: did you observe any PM regressions by skipping the clkdm
> > programming?
> 
> It's still under test here but 3530ES3 Beagle passed the PM tests with it, 
> with no obvious warnings.

OK I'm satisfied with this general fix.  Will have to break it up into 
pieces and move it earlier in the patch stack to ensure that PM doesn't 
break in the middle of the series, but the idea seems reasonably sound for 
short-term use.  A clock should only be disabled during the 
disable-unused-clocks phase if its usecount is zero and it's enabled in 
the hardware.  As far as I can tell, this can only happen when the clock 
is enabled by the bootloader/ROM code/PPA, and never touched by the kernel 
before the disable-unused-clocks phase.  The only regression cases that 
come to mind at the moment are:

1. CONFIG_PM=n and a clockdomain only contains unused clocks; or

2. CONFIG_PM=y and a clockdomain only contains unused clocks and that same 
clockdomain does not support hardware-supervised autoidle or force-idle

In those cases, I'd assume the clockdomain would effectively get stuck on.  
#1 we don't really care about since CONFIG_PM=n anyway.  #2 is more of a 
concern but it should disappear completely once hwmods are present for all 
of the IP blocks on the device.  (The presence of the hwmods will ensure 
that every clock that matters from an idle-management perspective is 
enabled at least once when the IP block is reset.)  For this reason, it's 
important to note that when the hwmod reset code is moved to run late in 
the boot process, it will have to run before the unused clocks are 
disabled.

One nice side-effect of this bug is that it highlighted that we're still 
missing OMAP3 hwmods for the camera subsystem, and that the reset code for 
the SAD2D module needs to be moved out of 
arch/arm/mach-omap2/pm34xx.c:omap3_d2d_idle() and into something that can 
be called from the hwmod reset code.


- Paul

