From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: USB Ethernet gadget doesn't work with DM3730
Date: Thu, 14 Jul 2011 13:34:54 +0200
Message-ID: <CAFqH_51nn9GoBAKXg-1gLr66OZvXgLSzh2XQGUNKC0NR4jg0KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38579 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab1GNLez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 07:34:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi all,

Playing with USB ethernet gadget on IGEP boards with mainline kernel
(Linux 3.0.0-rc7) I observed one strange behavior. The ethernet gadget
works with one board with OMAP3530 but it doesn't with another one
with DM3730. The log looks like this:

root@igep00x0:~# modprobe g_ether

[   51.420257] g_ether gadget: using random host ethernet address
[   51.427886] usb0: MAC da:93:4b:2d:55:e9
[   51.431915] usb0: HOST MAC 42:47:83:70:46:b6
[   51.436706] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   51.443725] g_ether gadget: g_ether ready
[   51.447906] musb-hdrc musb-hdrc: MUSB HDRC host driver
[   51.455871] musb-hdrc musb-hdrc: new USB bus registered, assigned
bus number 1
[   51.464141] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   51.471313] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   51.478912] usb usb1: Product: MUSB HDRC host driver
[   51.484161] usb usb1: Manufacturer: Linux 3.0.0-rc7-00027-g8d86e5f musb-hcd
[   51.491485] usb usb1: SerialNumber: musb-hdrc
[   51.498321] hub 1-0:1.0: USB hub found
[   51.502410] hub 1-0:1.0: 1 port detected

root@igep00x0:~# ifconfig usb0 192.168.7.2

usb0      Link encap:Ethernet  HWaddr DA:93:4B:2D:55:E9
          inet addr:192.168.7.2  Bcast:192.168.7.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@igep00x0:~# ping 192.168.7.1
PING 192.168.7.1 (192.168.7.1): 56 data bytes

With DM3730 I can't ping the other side (the same configuration with
OMAP3530 works without problems). Any clue on this ?

Cheers,
   Enric
