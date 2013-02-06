From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Wed, 6 Feb 2013 11:06:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302061056460.1893-100000@iolanthe.rowland.org>
References: <20130206135126.GA6773@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41236 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755116Ab3BFQG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 11:06:57 -0500
In-Reply-To: <20130206135126.GA6773@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Wed, 6 Feb 2013, Felipe Balbi wrote:

> Hi,
> 
> On Wed, Feb 06, 2013 at 05:27:52PM +0530, Vivek Gautam wrote:
> > Hi Tony,
> > 
> > 
> > On Fri, Oct 5, 2012 at 9:57 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Tony Lindgren <tony@atomide.com> [121004 18:41]:
> > >> >
> > >> > > Also on the EHCI port, I've seen issues where unplugging
> > >> > > the cable hangs kernel with an infinite loop. But that happens
> > >> > > only occasionally, sorry does not seem to happen right
> > >> > > now so no output to paste here. Or maybe this issue
> > >> > > has already been fixed?
> > >
> > > Looks like the system eventually recovers from the EHCI issue
> > > after about fivew minutes or so of spamming the logs. It seems
> > > the ehci-omap errors are:
> > >
> > > [62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
> > > [62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> > > [62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule
> > >
> > > More data below.
> > >
> > 
> > Is this issue fixed ?
> > Actually we too are getting very similar issue with samsung exynos5250 hardware.
> > With latest 'usb-next' kernel and supporting arch patches, when i use
> > following test scenerio:
> > Connect a USB 2.0 external hub to USB 2.0 port, and connect mice or
> > keyboard enumeration and
> > functionality is fine but once disconnecting the HID we get to see the
> > error log:
> > hid-generic 0003:04B3:3025.0002: can't reset device,
> > s5p-ehci-1.3/input0, status -71
> > 
> > When i tried to enable CONFIG_USB_DEBUG, get the following log:
> 
> looks like it's not OMAP-specific. Alan any tips ?

It could be a problem with the hub the keyboard is plugged into.  Or 
something going on with the hub driver.  I'll try doing the same thing 
on my system.

> (keeping logs below)
...
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 1
> > usb 1-1.3: unlink qh8-0e01/c193f140 start 2 [1/2 us]
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 1
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 2
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 3
> > hub 1-1:1.0: state 7 ports 7 chg 0000 evt 0008
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 4
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 5
> > hub 1-1:1.0: port 3, status 0100, change 0001, 12 Mb/s
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 6
> > usb 1-1.3: USB disconnect, device number 5
> > usb 1-1.3: unregistering device
> > usb 1-1.3: unregistering interface 1-1.3:1.0
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 7
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 8
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 9
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 10
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 11
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 12
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 13
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 14
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 15
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 16
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 17
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 18
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 19
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 20
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 21
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 22
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 23
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 24
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 25
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 26
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 27
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 28
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 29
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 30
> > s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 31
> > s5p-ehci s5p-ehci: devpath 1.3 ep0out 3strikes
> > usb 1-1: clear tt buffer port 3, a5 ep0 t00080248
> > hid-generic 0003:04B3:3025.0002: can't reset device,
> > s5p-ehci-1.3/input0, status -71

Note that most of these are debug messages, so they wouldn't normally 
appear.  (BTW: timestamps would be nice -- CONFIG_PRINTK_TIME.)

> > Similar log as you get on ehci-omap ;-)
> > Sorry i might have missed some information to put here.
> > 
> > Your help will be very much useful.
> > Thanks in advance :-)
> > 
> > > ...
> > > [62927.200012] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > > [62927.215606] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
> > > [62927.220092] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
> > > [62927.225738] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes

A certain amount of this is normal when an HID device is unplugged.  It 
should stop after 250 ms, however, when the hub notifies the host that 
a cable has been unplugged.  (Unless the hub driver is busy doing 
something else at the time...)

> > > ...
> > >
> > > After waiting for several minutes, it stops, and dmesg shows:
> > >
> > > # dmesg | grep -i omap

This grep will drop the important information.

Alan Stern

