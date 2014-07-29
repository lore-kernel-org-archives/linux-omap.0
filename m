From: Michael Welling <mwelling@emacinc.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Tue, 29 Jul 2014 14:55:44 -0500
Message-ID: <20140729195544.GA20656@sysresccd>
References: <20140725200400.GB18127@sysresccd>
 <Pine.LNX.4.44L0.1407281059060.1183-100000@iolanthe.rowland.org>
 <20140728152948.GA28880@sysresccd>
 <20140728155718.GF7667@saruman.home>
 <20140728175739.GA29212@sysresccd>
 <20140728181024.GI7667@saruman.home>
 <20140729075144.GG29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59865 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbaG2Tzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 15:55:51 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so166303iec.31
        for <linux-omap@vger.kernel.org>; Tue, 29 Jul 2014 12:55:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140729075144.GG29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com, chris.ruehl@gtsys.com.hk, Roger Quadros <rogerq@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Jul 29, 2014 at 12:51:45AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140728 11:13]:
> > On Mon, Jul 28, 2014 at 12:57:39PM -0500, Michael Welling wrote:
> > > On Mon, Jul 28, 2014 at 10:57:18AM -0500, Felipe Balbi wrote:
> > > > > > 
> > > > > > Basically it means what you said above: the hub disconnected.  I can't 
> > > > > > tell why.  You'll have to ask someone who's familiar with the hardware 
> > > > > > on that board.
> > > > > 
> > > > > Sadly, there is no one more familar with this specific hardware than myself.
> > > > > 
> > > > > I can however ellaborate the hardware setup of the USB subsystem in
> > > > > case there is someone out there that has used a similar setup.
> > > > > 
> > > > > The board uses the AM3517 SoC from TI. The SoC's USB host port (HSUSB1) is
> > > > > connected to a USB3320 PHY. The PHY is connected to a USB2512 switch to
> > > > > provide two downstream USB ports.
> > > > > 
> > > > > The very same hardware worked with the 2.6.37 kernel that I am trying to
> > > > > move away from.
> > > > > 
> > > > > Today I am going to try using 3.10 and 3.14 kernels see if they exhibit
> > > > > the same behavior.
> > > > 
> > > 
> > > It should be noted that the 3.10 kernel did not even detect the external
> > > HUB and the 3.14 kernel exhibits the same failure as 3.16.
> > > 
> > > > Do you have off-while-idle enabled ? This could be, as Alan suggested, a
> > > > problem with remote wakeup. EHCI on TI parts is kinda awkward, if you
> > > > will, and getting remote wakeup with PM working, is generally a
> > > > challenge.
> > > 
> > > How would one determine if off-while-idle is enabled? Is this a flag in an
> > > entry in the devicetree?
> > 
> > there is a pm_debug file on debugfs which you can use. Set autosuspend
> > delay to UART (it's set to -1 by default, IIRC), then leave the board
> > idle for a couple minutes, then read /sys/kernel/debug/pm_debug and see
> > if the OFF() counters are increasing.
> > 
> > Adding linux-omap to Cc. Also Tony, who has a simple script to enable
> > pm_runtime on UART.
> 
> I doubt that you have off-while-idle enabled as you need to manually
> enable the timeouts for UARTs for it to trigger :) I would check the
> related power and clock lines with a scope to see if there are glitches
> on them.
> 
> In any case, would be nice to have this EHCI stuff be sorted out for
> good in the mainline kernel as we do have things working pretty well
> for other things.

Today I enabled debugging in the core hub driver and found that
once the external HUB suspends, the root HUB suspends.

Once the root HUB suspends, it seems there is no way for the external
HUB to wake the root HUB with the hardware setup that I have.

root@som3517:~# dmesg | grep hub
[    0.617964] usbcore: registered new interface driver hub
[    2.818449] hub 1-0:1.0: USB hub found
[    2.822980] hub 1-0:1.0: 3 ports detected
[    2.827354] hub 1-0:1.0: standalone hub
[    2.831402] hub 1-0:1.0: individual port power switching
[    2.837067] hub 1-0:1.0: individual port over-current protection
[    2.843400] hub 1-0:1.0: power on to power good time: 20ms
[    2.851414] hub 1-0:1.0: local power source is good
[    2.860133] hub 1-0:1.0: enabling power on all ports
[    3.169607] hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
[    3.584251] hub 1-1:1.0: USB hub found
[    3.592571] hub 1-1:1.0: 2 ports detected
[    3.597095] hub 1-1:1.0: standalone hub
[    3.601187] hub 1-1:1.0: individual port power switching
[    3.606875] hub 1-1:1.0: individual port over-current protection
[    3.614899] hub 1-1:1.0: TT per port
[    3.618711] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.625558] hub 1-1:1.0: power on to power good time: 100ms
[    3.654652] hub 1-1:1.0: local power source is good
[    3.662134] hub 1-1:1.0: enabling power on all ports
[    3.766183] hub 1-1:1.0: state 7 ports 2 chg 0000 evt 0000
[    3.772116] hub 1-1:1.0: hub_suspend
[    3.804789] hub 1-0:1.0: hub_suspend

Here is what happens when I echo on into the power control for the HUB
afterwards:

root@som3517:/# echo on > /sys/bus/usb/devices/1-1/power/control
[ 1050.003689] hub 1-0:1.0: hub_resume
[ 1050.011306] usb usb1-port1: status 0507 change 0000
[ 1050.019975] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1050.028076] usb 1-1: usb auto-resume
[ 1050.065904] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
[ 1050.084623] usb 1-1: finish resume
[ 1050.092469] usb 1-1: retry with reset-resume
[ 1050.156167] hub 1-0:1.0: port_wait_reset: err = -16
[ 1050.161331] usb usb1-port1: not enabled, trying reset again...
[ 1050.376402] usb usb1-port1: logical disconnect
[ 1050.381354] usb 1-1: gone after usb resume? status -19
[ 1050.386941] usb 1-1: can't resume, status -19
[ 1050.391537] usb usb1-port1: logical disconnect
[ 1050.400203] usb usb1-port1: status 0100, change 0003, 12 Mb/s
[ 1050.406410] usb 1-1: USB disconnect, device number 2
[ 1050.411650] usb 1-1: unregistering device
[ 1050.604563] usb usb1-port1: debounce total 100ms stable 100ms status 0x100
[ 1050.611901] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1050.618428] hub 1-0:1.0: hub_suspend

Further research led me to find multiple errata that may be causing this
issue.

www.ti.com/lit/pdf/sprz306

Still does not explain why the same hardware works with the 2.6.37 and
3.2 kernels.

> 
> Regards,
> 
> Tony
