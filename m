From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Tue, 29 Jul 2014 00:51:45 -0700
Message-ID: <20140729075144.GG29045@atomide.com>
References: <20140725200400.GB18127@sysresccd>
 <Pine.LNX.4.44L0.1407281059060.1183-100000@iolanthe.rowland.org>
 <20140728152948.GA28880@sysresccd>
 <20140728155718.GF7667@saruman.home>
 <20140728175739.GA29212@sysresccd>
 <20140728181024.GI7667@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15041 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbaG2HxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 03:53:13 -0400
Content-Disposition: inline
In-Reply-To: <20140728181024.GI7667@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Michael Welling <mwelling@emacinc.com>, Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com, chris.ruehl@gtsys.com.hk, Roger Quadros <rogerq@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [140728 11:13]:
> On Mon, Jul 28, 2014 at 12:57:39PM -0500, Michael Welling wrote:
> > On Mon, Jul 28, 2014 at 10:57:18AM -0500, Felipe Balbi wrote:
> > > > > 
> > > > > Basically it means what you said above: the hub disconnected.  I can't 
> > > > > tell why.  You'll have to ask someone who's familiar with the hardware 
> > > > > on that board.
> > > > 
> > > > Sadly, there is no one more familar with this specific hardware than myself.
> > > > 
> > > > I can however ellaborate the hardware setup of the USB subsystem in
> > > > case there is someone out there that has used a similar setup.
> > > > 
> > > > The board uses the AM3517 SoC from TI. The SoC's USB host port (HSUSB1) is
> > > > connected to a USB3320 PHY. The PHY is connected to a USB2512 switch to
> > > > provide two downstream USB ports.
> > > > 
> > > > The very same hardware worked with the 2.6.37 kernel that I am trying to
> > > > move away from.
> > > > 
> > > > Today I am going to try using 3.10 and 3.14 kernels see if they exhibit
> > > > the same behavior.
> > > 
> > 
> > It should be noted that the 3.10 kernel did not even detect the external
> > HUB and the 3.14 kernel exhibits the same failure as 3.16.
> > 
> > > Do you have off-while-idle enabled ? This could be, as Alan suggested, a
> > > problem with remote wakeup. EHCI on TI parts is kinda awkward, if you
> > > will, and getting remote wakeup with PM working, is generally a
> > > challenge.
> > 
> > How would one determine if off-while-idle is enabled? Is this a flag in an
> > entry in the devicetree?
> 
> there is a pm_debug file on debugfs which you can use. Set autosuspend
> delay to UART (it's set to -1 by default, IIRC), then leave the board
> idle for a couple minutes, then read /sys/kernel/debug/pm_debug and see
> if the OFF() counters are increasing.
> 
> Adding linux-omap to Cc. Also Tony, who has a simple script to enable
> pm_runtime on UART.

I doubt that you have off-while-idle enabled as you need to manually
enable the timeouts for UARTs for it to trigger :) I would check the
related power and clock lines with a scope to see if there are glitches
on them.

In any case, would be nice to have this EHCI stuff be sorted out for
good in the mainline kernel as we do have things working pretty well
for other things.

Regards,

Tony
