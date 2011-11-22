From: Andrew Pushkin <andrei.pushkin@promwad.com>
Subject: USB video capture shuts up - 2
Date: Tue, 22 Nov 2011 12:58:43 +0300
Message-ID: <CANc=jjpCPj070PPO1UpNgvFvVcJ6d-nHqyczvTM9krZMnFGpTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56079 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab1KVKEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 05:04:44 -0500
Received: by qadc14 with SMTP id c14so1088295qad.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 02:04:44 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: simon@santesteban.eu, gadiyar@ti.com, =?UTF-8?B?0JjQstCw0L0g0JrRg9GC0LXQvdGM?= <ivan.kuten@promwad.com>

Hello. I need to use USB Web camera with TI AM3505 and TI AM3517 . I
use kernel 2.6.37 from arago. I test it, its work but sometimes I have
problems, that other users see in other TI CPU:
http://thread.gmane.org/gmane.linux.ports.arm.omap/35912/focus=36095
Sometimes camera do not work after 10-15 min of working. This is dmesg
(when this bug is reproduced) (I do not disconnect web camera but
linux think so(?)):
[   53.696228] ehci-omap ehci-omap.0: remove, state 1
[   53.696258] usb usb1: USB disconnect, address 1
[   53.696350] usb 1-1: USB disconnect, address 2
[   53.696350] usb 1-1.4: USB disconnect, address 3
[   53.773498] ehci-omap ehci-omap.0: force halt; handshake fa064814
0000c000 00000000 -> -110
[   54.113677] ehci-omap ehci-omap.0: USB bus 1 deregistered
[   54.524505] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   54.524658] ehci-omap.0 supply hsusb0 not found, using dummy regulator
[   55.532257] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[   55.532318] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 1
[   55.540313] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[   55.555725] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[   55.555877] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   55.555877] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   55.555908] usb usb1: Product: OMAP-EHCI Host Controller
[   55.555908] usb usb1: Manufacturer: Linux 2.6.37-svn1014 ehci_hcd
[   55.555938] usb usb1: SerialNumber: ehci-omap.0
And camera and other USB devices do not work until reboot.
I test it with various web cameras, with and without USB hub with
external power. This bug is exists.

-- 
Andrew Pushkin
