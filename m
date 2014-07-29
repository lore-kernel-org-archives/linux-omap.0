From: Michael Welling <mwelling@emacinc.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Tue, 29 Jul 2014 10:20:29 -0500
Message-ID: <20140729152029.GA20542@sysresccd>
References: <20140725200400.GB18127@sysresccd>
 <Pine.LNX.4.44L0.1407281059060.1183-100000@iolanthe.rowland.org>
 <20140728152948.GA28880@sysresccd>
 <20140728155718.GF7667@saruman.home>
 <20140728175739.GA29212@sysresccd>
 <20140728181024.GI7667@saruman.home>
 <53D7625B.3070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51118 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaG2PUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 11:20:36 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so8874836iec.9
        for <linux-omap@vger.kernel.org>; Tue, 29 Jul 2014 08:20:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53D7625B.3070301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com, chris.ruehl@gtsys.com.hk, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Jul 29, 2014 at 11:59:07AM +0300, Roger Quadros wrote:
> Hi Michael,
> 
> On 07/28/2014 09:10 PM, Felipe Balbi wrote:
> > On Mon, Jul 28, 2014 at 12:57:39PM -0500, Michael Welling wrote:
> >> On Mon, Jul 28, 2014 at 10:57:18AM -0500, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Mon, Jul 28, 2014 at 10:29:49AM -0500, Michael Welling wrote:
> >>>> On Mon, Jul 28, 2014 at 11:02:47AM -0400, Alan Stern wrote:
> >>>>> On Fri, 25 Jul 2014, Michael Welling wrote:
> >>>>>
> >>>>>> The plot thickens....
> >>>>>>
> >>>>>> So if I run the above command before anything is plugged into the ports
> >>>>>> the HUB disconnects.
> >>>>>>
> >>>>>> root@som3517:~# echo on > /sys/bus/usb/devices/1-1/power/control
> >>>>>> [   63.068839] usb 1-1: USB disconnect, device number 2
> >>>>>>
> >>>>>> Here is the output of the usbmon output when running the above command:
> >>>>>> root@som3517:/sys/kernel/debug/usb/usbmon# cat 1t
> >>>>>> de382e40 3788886573 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de382e40 3788890604 C Ci:001:00 0 4 = 07050000
> >>>>>> de382e40 3788892965 S Ci:001:00 s a3 00 0000 0002 0004 4 <
> >>>>>> de382e40 3788893093 C Ci:001:00 0 4 = 00010000
> >>>>>> de382e40 3788894834 S Ci:001:00 s a3 00 0000 0003 0004 4 <
> >>>>>> de382e40 3788894958 C Ci:001:00 0 4 = 00010000
> >>>>>> de7d92c0 3788896519 S Ii:001:01 -115 4 <
> >>>>>> de382e40 3788898778 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de382e40 3788900188 C Ci:001:00 0 4 = 07050000
> >>>>>> de382e40 3788902705 S Co:001:00 s 23 01 0002 0001 0000 0
> >>>>>> de382e40 3788905793 C Co:001:00 0 0
> >>>>>> de382e40 3788940998 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de7d92c0 3788942065 C Ii:001:01 0 1 = 02
> >>>>>> de7d92c0 3788943013 S Ii:001:01 -115 4 <
> >>>>>> de382e40 3788943145 C Ci:001:00 0 4 = 03050400
> >>>>>> de382e40 3788961031 S Co:001:00 s 23 01 0012 0001 0000 0
> >>>>>> de382e40 3788961175 C Co:001:00 0 0
> >>>>>> de382e40 3788961304 S Ci:002:00 s 80 00 0000 0000 0002 2 <
> >>>>>> de382e40 3788965395 C Ci:002:00 -71 0
> >>>>>> de249040 3788966954 S Co:001:00 s 23 03 0004 0001 0000 0
> >>>>>> de249040 3788968362 C Co:001:00 0 0
> >>>>>> de249040 3789021103 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de7d92c0 3789022194 C Ii:001:01 0 1 = 02
> >>>>>> de7d92c0 3789022226 S Ii:001:01 -115 4 <
> >>>>>> de249040 3789023423 C Ci:001:00 0 4 = 01051200
> >>>>>> de249040 3789025010 S Co:001:00 s 23 03 0004 0001 0000 0
> >>>>>> de249040 3789026815 C Co:001:00 0 0
> >>>>>> de249040 3789230980 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de249040 3789231111 C Ci:001:00 0 4 = 00010300
> >>>>>> de249040 3789232280 S Co:001:00 s 23 01 0014 0001 0000 0
> >>>>>> de249040 3789232404 C Co:001:00 0 0
> >>>>>> de249040 3789233056 S Co:001:00 s 23 01 0001 0001 0000 0
> >>>>>> de249040 3789235345 C Co:001:00 0 0
> >>>>>> de249040 3789236820 S Co:001:00 s 23 01 0001 0001 0000 0
> >>>>>> de249040 3789237201 C Co:001:00 0 0
> >>>>>> de249040 3789238180 S Co:001:00 s 23 01 0001 0001 0000 0
> >>>>>> de249040 3789238510 C Co:001:00 0 0
> >>>>>> de249040 3789240602 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de249040 3789241661 C Ci:001:00 0 4 = 00010300
> >>>>>> de249040 3789242264 S Co:001:00 s 23 01 0010 0001 0000 0
> >>>>>> de249040 3789243921 C Co:001:00 0 0
> >>>>>> de249040 3789246540 S Co:001:00 s 23 01 0011 0001 0000 0
> >>>>>> de249040 3789246930 C Co:001:00 0 0
> >>>>>> de2490c0 3789283096 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de2490c0 3789286255 C Ci:001:00 0 4 = 00010000
> >>>>>> de2490c0 3789330975 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de2490c0 3789332606 C Ci:001:00 0 4 = 00010000
> >>>>>> de2490c0 3789371015 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de2490c0 3789371146 C Ci:001:00 0 4 = 00010000
> >>>>>> de2490c0 3789410975 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de2490c0 3789411097 C Ci:001:00 0 4 = 00010000
> >>>>>> de2490c0 3789450972 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> >>>>>> de2490c0 3789451081 C Ci:001:00 0 4 = 00010000
> >>>>>> de7d92c0 3789452462 C Ii:001:01 -2 0
> >>>>>>
> >>>>>> Not sure what any of it means.
> >>>>>
> >>>>> Basically it means what you said above: the hub disconnected.  I can't 
> >>>>> tell why.  You'll have to ask someone who's familiar with the hardware 
> >>>>> on that board.
> >>>>
> >>>> Sadly, there is no one more familar with this specific hardware than myself.
> >>>>
> >>>> I can however ellaborate the hardware setup of the USB subsystem in
> >>>> case there is someone out there that has used a similar setup.
> >>>>
> >>>> The board uses the AM3517 SoC from TI. The SoC's USB host port (HSUSB1) is
> >>>> connected to a USB3320 PHY. The PHY is connected to a USB2512 switch to
> >>>> provide two downstream USB ports.
> >>>>
> >>>> The very same hardware worked with the 2.6.37 kernel that I am trying to
> >>>> move away from.

It should be noted that the USB hardware work on the 3.2 kernel as well.

> >>>>
> >>>> Today I am going to try using 3.10 and 3.14 kernels see if they exhibit
> >>>> the same behavior.
> >>>
> >>
> >> It should be noted that the 3.10 kernel did not even detect the external
> >> HUB and the 3.14 kernel exhibits the same failure as 3.16.
> >>
> >>> Do you have off-while-idle enabled ? This could be, as Alan suggested, a
> >>> problem with remote wakeup. EHCI on TI parts is kinda awkward, if you
> >>> will, and getting remote wakeup with PM working, is generally a
> >>> challenge.
> >>
> >> How would one determine if off-while-idle is enabled? Is this a flag in an
> >> entry in the devicetree?
> > 
> > there is a pm_debug file on debugfs which you can use. Set autosuspend
> > delay to UART (it's set to -1 by default, IIRC), then leave the board
> > idle for a couple minutes, then read /sys/kernel/debug/pm_debug and see
> > if the OFF() counters are increasing.
> > 
> > Adding linux-omap to Cc. Also Tony, who has a simple script to enable
> > pm_runtime on UART.
> > 
> 
> The EHCI-omap driver when in use should prevent the USBHOST module from idling and this should in turn prevent the CORE from idling. So remote wakeup should work. It works fine in my setup with omap3beagle board OMAP3430/3530 ES3.1.
> I'm using a recent u-boot v2014.07-rc4.
> 
> It seems you are using an older silicon which needs single_ulpi_bypass flag set in platform data.
> Did your below patch fix the issue for you?
> https://lkml.org/lkml/2014/7/28/745

Sadly, this did not fix the issue that I am having.

The problem seems to be the interaction between the PHY and the HUB on
the hardware. The USB host works fine until the last device is removed
from the HUB as long a device is plugged in during boot.

The HUB can be forced to stay on if a device is installed during boot.
But if you boot without a device plugged in the hardware never detects
thereafter.

> 
> cheers,
> -roger
