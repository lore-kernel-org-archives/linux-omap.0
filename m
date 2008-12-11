From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Fri, 12 Dec 2008 00:52:10 +0200
Message-ID: <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
	 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
	 <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:61973 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125AbYLKWwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 17:52:11 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1092676rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 14:52:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Dec 11, 2008 at 11:07 PM, Paul Walmsley <paul@booyaka.com> wrote:
> Gravyzdas, can you send us a commit ID that results in successful device
> enumeration (after reverting
> http://marc.info/?l=linux-omap&m=122453174024860&w=2 ?)  Sounds like it
> was working for you in late October with that revert.

There is no need to - EHCI works (almost) fine on pandora with current HEAD.

> Sadly my ehci port still goes into auto suspend.  I've attached the
> output of dmesg.  Can you take a look and see at what point my ehci
> messages diverge from what you see?

I'm also getting suspend/resume related problems if I plug a hub
without any devices connected (29sec), and then a device (52sec):

[   22.324002] Freeing init memory: 136K
[   22.455317] mmc0: new SD card at address 8001
[   22.480738] mmcblk0: mmc0:8001 SD512 483 MiB (ro)
[   22.485743]  mmcblk0: p1 p2 p3 < p5 >
[   23.457061] hub 1-0:1.0: hub_suspend
[   23.457122] usb usb1: bus auto-suspend
[   23.457122] ehci-omap ehci-omap.0: suspend root hub
[   23.457457] hub 2-0:1.0: hub_suspend
[   23.457488] usb usb2: bus auto-suspend
[   29.576384] usb usb1: usb resume
[   29.576415] ehci-omap ehci-omap.0: resume root hub
[   29.620879] hub 1-0:1.0: hub_resume
[   29.620940] ehci-omap ehci-omap.0: GetStatus port 2 status 001803
POWER sig=j CSC CONNECT
[   29.620970] hub 1-0:1.0: port 2: status 0501 change 0001
[   29.730345] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
[   29.730376] hub 1-0:1.0: port 2, status 0501, change 0000, 480 Mb/s
[   29.792845] ehci-omap ehci-omap.0: port 2 high speed
[   29.792876] ehci-omap ehci-omap.0: GetStatus port 2 status 001005
POWER sig=se0 PE CONNECT
[   29.855315] usb 1-2: new high speed USB device using ehci-omap and address 2
[   29.917723] ehci-omap ehci-omap.0: port 2 high speed
[   29.917723] ehci-omap ehci-omap.0: GetStatus port 2 status 001005
POWER sig=se0 PE CONNECT
[   30.012968] usb 1-2: default language 0x0409
[   30.013761] usb 1-2: uevent
[   30.022152] usb 1-2: usb_probe_device
[   30.022183] usb 1-2: configuration #1 chosen from 1 choice
[   30.028102] usb 1-2: adding 1-2:1.0 (config #1, interface 0)
[   30.028316] usb 1-2:1.0: uevent
[   30.034084] hub 1-2:1.0: usb_probe_interface
[   30.034114] hub 1-2:1.0: usb_probe_interface - got id
[   30.034114] hub 1-2:1.0: USB hub found
[   30.038355] hub 1-2:1.0: 4 ports detected
[   30.042384] hub 1-2:1.0: standalone hub
[   30.042414] hub 1-2:1.0: ganged power switching
[   30.042414] hub 1-2:1.0: global over-current protection
[   30.042445] hub 1-2:1.0: Single TT
[   30.042445] hub 1-2:1.0: TT requires at most 32 FS bit times (2664 ns)
[   30.042475] hub 1-2:1.0: Port indicators are supported
[   30.042475] hub 1-2:1.0: power on to power good time: 100ms
[   30.043089] hub 1-2:1.0: local power source is good
[   30.043089] hub 1-2:1.0: no over-current condition exists
[   30.043120] hub 1-2:1.0: enabling power on all ports
[   30.062010] drivers/usb/core/inode.c: creating file '002'
[   30.070952] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[   30.077788] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   30.085021] usb 1-2: Product: USB2.0 Hub
[   30.145781] usb 1-2: link qh256-0001/ffa00100 start 255 [1/0 us]
[   30.145842] hub 1-2:1.0: state 7 ports 4 chg 0000 evt 0000
[   32.457060] hub 1-2:1.0: hub_suspend
[   32.457091] usb 1-2: unlink qh256-0001/ffa00100 start 255 [1/0 us]
[   32.457518] usb 1-2: usb auto-suspend
[   34.480192] hub 1-0:1.0: hub_suspend
[   34.480223] usb usb1: bus auto-suspend
[   34.480254] ehci-omap ehci-omap.0: suspend root hub
[   52.507176] ehci-omap ehci-omap.0: port 2 remote wakeup
[   52.507237] usb usb1: usb resume
[   52.507237] ehci-omap ehci-omap.0: resume root hub
[   52.558339] hub 1-0:1.0: hub_resume
[   52.558400] ehci-omap ehci-omap.0: GetStatus port 2 status 001005
POWER sig=se0 PE CONNECT
[   52.558431] hub 1-0:1.0: port 2: status 0503 change 0004
[   52.558461] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
[   52.558522] ehci-omap ehci-omap.0: GetStatus port 2 status 001809
POWER sig=j PEC CONNECT
[   52.558553] usb 1-2: usb wakeup-resume
[   52.558583] usb 1-2: finish reset-resume
[   52.620868] ehci-omap ehci-omap.0: port 2 full speed --> companion
[   52.620898] ehci-omap ehci-omap.0: GetStatus port 2 status 003801
POWER OWNER sig=j CONNECT
[   52.620929] hub 1-0:1.0: port 2 not reset yet, waiting 50ms
[   52.683429] ehci-omap ehci-omap.0: GetStatus port 2 status 003002
POWER OWNER sig=se0 CSC
[   52.683459] hub 1-0:1.0: logical disconnect on port 2
[   52.683490] usb 1-2: gone after usb resume? status -19
[   52.683490] usb 1-2: can't resume, status -19
[   52.683520] hub 1-0:1.0: logical disconnect on port 2
[   52.683551] hub 1-0:1.0: resume on port 2, status -19
[   52.683551] hub 1-0:1.0: port 2, status 0501, change 0006, 480 Mb/s
[   52.683581] usb 1-2: USB disconnect, address 2
[   52.688037] usb 1-2: unregistering device
[   52.688068] usb 1-2: usb_disable_device nuking all URBs
[   52.688068] usb 1-2: unregistering interface 1-2:1.0
[   52.696641] usb 1-2:1.0: uevent
[   52.720508] usb 1-2: uevent
[   52.878711] hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms
status 0x100
[   52.878741] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004
[   55.456891] hub 1-0:1.0: hub_suspend
[   55.456921] usb usb1: bus auto-suspend
[   55.456952] ehci-omap ehci-omap.0: suspend root hub

After that kernel no longer reacts to any replugs (both device-hub and
hub-board).

But if I first plug some device to my ext hub, and then hub to
pandora, everything goes fine (on fresh boot, not after "suspend root
hub" problem above):
[   22.323209] Freeing init memory: 136K
[   22.454890] mmc0: new SD card at address 8001
[   22.480616] mmcblk0: mmc0:8001 SD512 483 MiB (ro)
[   22.485651]  mmcblk0: p1 p2 p3 < p5 >
[   23.456938] hub 1-0:1.0: hub_suspend
[   23.456999] usb usb1: bus auto-suspend
[   23.456999] ehci-omap ehci-omap.0: suspend root hub
[   23.457183] hub 2-0:1.0: hub_suspend
[   23.457213] usb usb2: bus auto-suspend
[   37.455616] usb usb1: usb resume
[   37.455647] ehci-omap ehci-omap.0: resume root hub
[   37.503489] hub 1-0:1.0: hub_resume
[   37.503580] ehci-omap ehci-omap.0: GetStatus port 2 status 001803
POWER sig=j CSC CONNECT
[   37.503611] hub 1-0:1.0: port 2: status 0501 change 0001
[   37.613023] hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
[   37.613054] hub 1-0:1.0: port 2, status 0501, change 0000, 480 Mb/s
[   37.675523] ehci-omap ehci-omap.0: port 2 high speed
[   37.675554] ehci-omap ehci-omap.0: GetStatus port 2 status 001005
POWER sig=se0 PE CONNECT
[   37.737993] usb 1-2: new high speed USB device using ehci-omap and address 2
[   37.800372] ehci-omap ehci-omap.0: port 2 high speed
[   37.800372] ehci-omap ehci-omap.0: GetStatus port 2 status 001005
POWER sig=se0 PE CONNECT
[   37.895586] usb 1-2: default language 0x0409
[   37.896379] usb 1-2: uevent
[   37.904862] usb 1-2: usb_probe_device
[   37.904862] usb 1-2: configuration #1 chosen from 1 choice
[   37.910844] usb 1-2: adding 1-2:1.0 (config #1, interface 0)
[   37.911058] usb 1-2:1.0: uevent
[   37.916856] hub 1-2:1.0: usb_probe_interface
[   37.916856] hub 1-2:1.0: usb_probe_interface - got id
[   37.916887] hub 1-2:1.0: USB hub found
[   37.921219] hub 1-2:1.0: 4 ports detected
[   37.925247] hub 1-2:1.0: standalone hub
[   37.925278] hub 1-2:1.0: ganged power switching
[   37.925278] hub 1-2:1.0: global over-current protection
[   37.925278] hub 1-2:1.0: Single TT
[   37.925308] hub 1-2:1.0: TT requires at most 32 FS bit times (2664 ns)
[   37.925308] hub 1-2:1.0: Port indicators are supported
[   37.925371] hub 1-2:1.0: power on to power good time: 100ms
[   37.925951] hub 1-2:1.0: local power source is good
[   37.925951] hub 1-2:1.0: no over-current condition exists
[   37.925981] hub 1-2:1.0: enabling power on all ports
[   37.944902] drivers/usb/core/inode.c: creating file '002'
[   37.953812] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[   37.960649] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   37.967880] usb 1-2: Product: USB2.0 Hub
[   38.028458] hub 1-2:1.0: port 4: status 0301 change 0001
[   38.128525] usb 1-2: link qh256-0001/ffa00100 start 255 [1/0 us]
[   38.128586] hub 1-2:1.0: state 7 ports 4 chg 0010 evt 0000
[   38.128983] hub 1-2:1.0: port 4, status 0301, change 0000, 1.5 Mb/s
[   38.214829] usb 1-2.4: new low speed USB device using ehci-omap and address 3
[   38.353499] usb 1-2.4: skipped 1 descriptor after interface
[   38.353530] usb 1-2.4: skipped 1 descriptor after interface
[   38.355086] usb 1-2.4: default language 0x0409
[   38.365371] usb 1-2.4: uevent
[   38.373671] usb 1-2.4: usb_probe_device
[   38.373671] usb 1-2.4: configuration #1 chosen from 1 choice
[   38.380873] usb 1-2.4: adding 1-2.4:1.0 (config #1, interface 0)
[   38.381057] usb 1-2.4:1.0: uevent
[   38.386489] usbhid 1-2.4:1.0: usb_probe_interface
[   38.386519] usbhid 1-2.4:1.0: usb_probe_interface - got id
[   38.412214] input: Logitech HID compliant keyboard as /class/input/input1
[   38.448925] usb 1-2.4: link qh8-0601/ffa00200 start 7 [1/2 us]
[   38.480204] generic-usb 0003:046D:C30E.0001: input: USB HID v1.10
Keyboard [Logitech HID compliant keyboard] on usb-ehci-omap.0-2.4/inp0
[   38.516274] usb 1-2.4: adding 1-2.4:1.1 (config #1, interface 1)
[   38.516487] usb 1-2.4:1.1: uevent
[   38.523108] usbhid 1-2.4:1.1: usb_probe_interface
[   38.523139] usbhid 1-2.4:1.1: usb_probe_interface - got id
[   38.557554] input: Logitech HID compliant keyboard as /class/input/input2
[   38.589750] usb 1-2.4: link qh8-3008/ffa00280 start 7 [1/2 us]
[   38.620848] generic-usb 0003:046D:C30E.0002: input: USB HID v1.10
Device [Logitech HID compliant keyboard] on usb-ehci-omap.0-2.4/input1
[   38.666289] drivers/usb/core/inode.c: creating file '003'
[   38.675230] usb 1-2.4: New USB device found, idVendor=046d, idProduct=c30e
[   38.682219] usb 1-2.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   38.689665] usb 1-2.4: Product: HID compliant keyboard
[   38.694852] usb 1-2.4: Manufacturer: Logitech
[   38.699277] hub 1-2:1.0: state 7 ports 4 chg 0000 evt 0010

Curiously at this point I can plug/unplug to my ext hub any additional
devices as much as I want, as long as I keep the first device plugged.
If I unplug all devices from ext hub, I get suspend and kernel no
longer reacts to any replugs.
