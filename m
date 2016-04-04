From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 4 Apr 2016 23:30:56 +0200
Message-ID: <20160404213056.GA25912@amd>
References: <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160330191208.GW9329@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > How idle system do I need to have? Screen is blanked and machine
> > should be mostly idle, but there's X running on another vt with Mate
> > desktop, and some python scripts... GSM modem should be online.
> 
> Well I think it's the USB only you have blocking deeper idle states.
> 
> Are you sure you rmmod:ed all the USB related modules like in my
> test script?

I tested with rmmoding two, and then modified kernel to do equivalent
operations.

Let me try again:

phy_module=phy_twl4030_usb
udc_glue=omap2430
udc_module=musb_hdrc

Ok, I did "start" with your script. After some fiddling it seems to
work, and PC detected the values:

[25379.533127] usb 1-5: USB disconnect, device number 12
[27161.884132] usb 1-5: new high-speed USB device number 13 using
ehci-pci
[27161.996037] usb 1-5: device descriptor read/64, error -32
[27162.420048] usb 4-1: new full-speed USB device number 2 using
uhci_hcd
[27162.563098] usb 4-1: not running at top speed; connect to a high
speed hub
[27162.601106] usb 4-1: New USB device found, idVendor=1d6b,
idProduct=0106
[27162.601112] usb 4-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[27162.601115] usb 4-1: Product: Multi Gadget
[27162.601118] usb 4-1: Manufacturer: foo
[27162.601121] usb 4-1: SerialNumber: 123456789
[27162.614766] cdc_ether 4-1:1.0 usb0: register 'cdc_ether' at
usb-0000:00:1d.2-1, CDC Ethernet Device, c6:8b:83:74:f2:f3
[27163.195272] cdc_ether 4-1:1.0 usb0: kevent 12 may have been dropped

Stop seemed to work, too:

root@n900:/my/tui/ofone# ./gadgets.sh stop
rm: cannot remove `configs/c.1/acm.0': No such file or directory
rm: cannot remove `configs/c.5/acm.0': No such file or directory
rmdir: failed to remove `functions/acm.0': No such file or directory
./gadgets.sh: line 74: functions/mass_storage.0/lun.0/file: No such
file or directory
rm: cannot remove `configs/c.1/mass_storage.0': No such file or
directory
rm: cannot remove `configs/c.5/mass_storage.0': No such file or
directory
rmdir: failed to remove `functions/mass_storage.0': No such file or
directory
root@n900:/my/tui/ofone# lsmod
Module                  Size  Used by
root@n900:/my/tui/ofone#

Display off, on wifi:

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
f7de7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
0000000d 48004a28 (fa004a28) cm_idlest3_core

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffde7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042

..so I believe gadget bits are still set.

> I'm booting over smc91x using u-boot.

I'm booting directly from NOLO over usb. Machine is running X, but
they are not active -- chvt. Screen is off.

Best regards,


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
