From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: USB Ethernet gadget seems doesn't work with current mainline
Date: Fri, 5 Nov 2010 09:39:44 +0100
Message-ID: <AANLkTimeU1+F5F+Bpfh0E3E7S6=aZ=bbK0=6zmpJcm_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52321 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab0KEIjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 04:39:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hello all,

With current mainline and stable 2.6.35.y branch I've some strange
features with USB ethernet gadget ...

  root@igep0020:~# uname -a
  Linux igep0020 2.6.37-rc1+ #1 Fri Nov 5 09:22:53 CET 2010 armv7l
unknown unknown GNU/Linux

  root@igep0020:~# ifconfig
  usb0      Link encap:Ethernet  HWaddr 5A:A9:54:25:4C:04
          inet addr:192.168.7.2  Bcast:192.168.7.255  Mask:255.255.255.0
          inet6 addr: fe80::58a9:54ff:fe25:4c04/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:28 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:4951 (4.8 KiB)

Pinging seems not work

  root@igep0020:~# ping -c5 192.168.7.1
  PING 192.168.7.1 (192.168.7.1): 56 data bytes
  --- 192.168.7.1 ping statistics ---
  5 packets transmitted, 0 packets received, 100% packet loss

Curiously if I unplug and plug the USB cable, and ping again ...

  root@igep0020:~# ping -c5 192.168.7.1
  PING 192.168.7.1 (192.168.7.1): 56 data bytes
  64 bytes from 192.168.7.1: seq=0 ttl=64 time=0.397 ms
  64 bytes from 192.168.7.1: seq=1 ttl=64 time=0.489 ms
  64 bytes from 192.168.7.1: seq=2 ttl=64 time=0.397 ms
  64 bytes from 192.168.7.1: seq=3 ttl=64 time=0.366 ms
  64 bytes from 192.168.7.1: seq=4 ttl=64 time=0.396 ms

  --- 192.168.7.1 ping statistics ---
  5 packets transmitted, 5 packets received, 0% packet loss
 round-trip min/avg/max = 0.366/0.409/0.489 ms

Works, anyone knows if the ethernet gadget is broken in current
mainline or have observed this feature ?

Thanks in advance,
   Enric
