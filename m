From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Subject: strange usb errors
Date: Fri, 20 Mar 2009 19:09:34 +0100
Message-ID: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55430 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371AbZCTSJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 14:09:37 -0400
Received: by bwz17 with SMTP id 17so992904bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 11:09:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Hi,

I have a few weird USB related errors.

Hardware: beagleboard rev C2.
OS: 2.6.28 (angstrom, r15 version)

If I connect my pvrusb2 controller directly to the usb host port the
device works as expected.

However if I connect the device through a (powered) usb hub, the
device does not work.
dmesg says:

usb 1-2.2: new high speed USB device using ehci-omap and address 5
usb 1-2.2: configuration #1 chosen from 1 choice
usb 1-2.2: firmware: requesting v4l-pvrusb2-29xxx-01.fw
pvrusb2: Device microcontroller firmware (re)loaded; it should now
reset and reconnect.

but it does not reconnect.
I would not expect a usb hub to have such an effect. Note that the hub
is working and that devices like an ethernet dongle and a bluetooth
dongle work like a charm with the hub.

I also saw a fw load problem with the hardware (same system).
At that point dmesg said:

usb 1-2.2: new high speed USB device using ehci-omap and address 4
usb 1-2.2: configuration #1 chosen from 1 choice
Linux video capture interface: v2.00
usbcore: registered new interface driver pvrusb2
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner
pvrusb2: Debug mask is 31 (0x1f)
usb 1-2.2: firmware: requesting v4l-pvrusb2-29xxx-01.fw
pvrusb2: ***WARNING*** Device fx2 controller firmware seems to be missing.
pvrusb2: Did you install the pvrusb2 firmware files in their proper location?
pvrusb2: request_firmware unable to locate fx2 controller file
v4l-pvrusb2-29xxx-01.fw
pvrusb2: Failure uploading firmware1
pvrusb2: Device initialization was not successful.
pvrusb2: Giving up since device microcontroller firmware appears to be missing.

If I then unplug and replug I get the first message (about reset and reconnect).


The other problem I have is with my wireless zd1211 based wifi dongle.
If I connect it I get:

usb 1-2.2: new high speed USB device using ehci-omap and address 6
usb 1-2.2: configuration #1 chosen from 1 choice
usb 1-2.2: reset high speed USB device using ehci-omap and address 6
phy0: Selected rate control algorithm 'pid'
zd1211rw 1-2.2:1.0: phy0
usb 1-2.2: firmware: requesting zd1211/zd1211_ub
usb 1-2.2: firmware: requesting zd1211/zd1211_uphr
usb 1-2.2: Could not load firmware file zd1211/zd1211_uphr. Error number -2
zd1211rw 1-2.2:1.0: couldn't load firmware. Error number -2

Whether the dongle is directly connected or through a hub does not
make a dfifference

However the firmware is there and the very same firmware works under
opensuse and used to work under 2.6.27

Anyone an idea ?

Frans
