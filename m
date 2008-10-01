From: "Nathan Monson" <nmonson@gmail.com>
Subject: USB serial devices not working on linux-omap musb.
Date: Tue, 30 Sep 2008 21:35:49 -0700
Message-ID: <e5e6ade50809302135q172a83b7pb87e9309499b5821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:6151 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYJAEfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 00:35:51 -0400
Received: by el-out-1112.google.com with SMTP id z25so68750ele.1
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 21:35:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to use a USB serial device on a Beagleboard/OMAP-3530 via
the musb port.

The device is correctly enumerated and can send data, but no data is
received.  Other types of USB devices seem to be working great.

I've tested with two devices:  A PL2303 USB to serial cable, and an
Atmel SAM-BA device (basic CDC serial).  Both devices work on the
Ubuntu/Intrepid x86 2.6.27 kernel on my PC.

Additionally, when unplugging the PL2303 I receive an Oops attached below.

Let me know what I can do to help.

I'm using the latest linux-omap git plus these four patches:
Crash on detach:  http://marc.info/?l=linux-usb&m=122112415222422&w=2
Iso/cam fix #1:   http://marc.info/?l=linux-usb&m=122085130310484&w=2
Iso/cam fix #2:   http://marc.info/?l=linux-usb&m=122085145310628&w=2
'Fix something':
http://git.mansr.com/?p=linux-omap;a=commitdiff;h=1e5bc41773bb981b3a89bd762becf98c72be5e4c

Here is the Oops:

usb 1-1.3: usb_disable_device nuking all URBs
Unable to handle kernel NULL pointer dereference at virtual address 00000014
pgd = c0004000
[00000014] *pgd=00000000
Internal error: Oops: 17 [#1]
Modules linked in: pl2303 usbserial ipv6 uvcvideo compat_ioctl32
videodev v4l1_compat zd1211rw
CPU: 0    Not tainted  (2.6.27-rc7-omap1-05004-g81d2c7d-dirty #8)
PC is at musb_h_disable+0x70/0x118
LR is at usb_hcd_disable_endpoint+0x24/0x28
pc : [<c0233618>]    lr : [<c021395c>]    psr: 20000093
sp : c78d1e48  ip : c78d1e70  fp : c78d1e6c
r10: c7baa060  r9 : c7baa0ec  r8 : a0000013
r7 : c78add80  r6 : c70c8e5c  r5 : 00000000  r4 : c70c8e50
r3 : 00000000  r2 : 00000083  r1 : c70c8e50  r0 : c7852120
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 87114018  DAC: 00000017
Process khubd (pid: 104, stack limit = 0xc78d02e8)
Stack: (0xc78d1e48 to 0xc78d2000)
1e40:                   00000000 c70c8e50 c7baa000 c7baa000 c7baa0ec c7baa060
1e60: c78d1e7c c78d1e70 c021395c c02335b4 c78d1e94 c78d1e80 c021665c c0213944
1e80: 00000004 c7baa07c c78d1ec4 c78d1e98 c02166f0 c0216608 c0401fc0 c78d1ea8
1ea0: c03367a0 0000001f c7baa07c c7baa000 c78daa4c c7baa10c c78d1ef4 c78d1ec8
1ec0: c0211740 c021668c c78d1ee4 c7baa000 00000064 c044344c c78d0000 00000003
1ee0: c7be9000 00000100 c78d1fd4 c78d1ef8 c0212bd4 c0211684 00000064 00000064
1f00: 00000100 00000000 000003e8 c0193b74 c004ed18 00000003 c78daa4c c7852014
1f20: c7be9044 c7bdb6ac c7bdb620 c7bdb600 c78da800 c7be9048 c7be904c c78da90c
1f40: c7be9008 00000100 c78da800 00000000 00000000 c7bdb6ac 00000000 c7bdb620
1f60: c78da800 c7be909c 00000001 00000000 00000002 000000e0 c7852000 c7817404
1f80: c7be9002 c78da808 00000000 c7822100 c0069dc4 c78d1f94 c78d1f94 00000100
1fa0: 01000001 c78d0000 c78d1fd4 c78d0000 00000000 c02124f8 c045657c 00000000
1fc0: 00000000 00000000 c78d1ff4 c78d1fd8 c00698dc c0212504 00000000 00000000
1fe0: 00000000 00000000 00000000 c78d1ff8 c00587e0 c0069890 007fef00 2376ef8a
Backtrace:
[<c02335a8>] (musb_h_disable+0x0/0x118) from [<c021395c>]
(usb_hcd_disable_endpoint+0x24/0x28)
 r8:c7baa060 r7:c7baa0ec r6:c7baa000 r5:c7baa000 r4:c70c8e50
[<c0213938>] (usb_hcd_disable_endpoint+0x0/0x28) from [<c021665c>]
(usb_disable_endpoint+0x60/0x84)
[<c02165fc>] (usb_disable_endpoint+0x0/0x84) from [<c02166f0>]
(usb_disable_device+0x70/0x198)
 r5:c7baa07c r4:00000004
[<c0216680>] (usb_disable_device+0x0/0x198) from [<c0211740>]
(usb_disconnect+0xc8/0x150)
 r8:c7baa10c r7:c78daa4c r6:c7baa000 r5:c7baa07c r4:0000001f
[<c0211678>] (usb_disconnect+0x0/0x150) from [<c0212bd4>]
(hub_thread+0x6dc/0x12b0)
[<c02124f8>] (hub_thread+0x0/0x12b0) from [<c00698dc>] (kthread+0x58/0x8c)
[<c0069884>] (kthread+0x0/0x8c) from [<c00587e0>] (do_exit+0x0/0x774)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000
Code: 0a00001d e3a05000 e1a03005 e284600c (e5b32014)
---[ end trace 32560ec91a581d5d ]---

- Nathan
