From: Steve Sakoman <sakoman@gmail.com>
Subject: Oops on shutdown?
Date: Thu, 20 Aug 2009 08:34:12 -0700
Message-ID: <5e088bd90908200834o5b816127offa6b592a99526ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:22990 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZHTPeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 11:34:12 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1781635qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 20 Aug 2009 08:34:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've been doing a bit of testing on 2.6.31-rc5 on Overo with good
results overall.

The only major issue I see at the moment is an oops on shutdown/restart.

Is anyone else seeing this?

Rebooting... Internal error: Oops - undefined instruction: 0 [#1]
Modules linked in: ipv6 udf libertas_sdio libertas lib80211 sg sr_mod
cdrom uvcvideo videodev v4l1_compat ads7846
CPU: 0    Not tainted  (2.6.31-rc5-omap1 #1)
PC is at 0xcf8ab014
LR is at usb_hcd_platform_shutdown+0x20/0x28
pc : [<cf8ab014>]    lr : [<c031ac00>]    psr: a0000013
sp : cb307e60  ip : 00000001  fp : 00000001
r10: 00000000  r9 : cb306000  r8 : c00eefc4
r7 : 0000006c  r6 : fee1dead  r5 : c0635258  r4 : c05bcae8
r3 : cf8aae88  r2 : cf802c20  r1 : c05bcdc0  r0 : cf8a4b60
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8a31c019  DAC: 00000015
Process reboot (pid: 10985, stack limit = 0xcb3062f0)
Stack: (0xcb307e60 to 0xcb308000)
7e60: c0635258 c02dcbc8 c00eefc4 c02d874c 00000000 00000000 28121969 c0121840
7e80: 400d8000 c012188c 01234567 c01219a0 00000000 cf8652c0 cb2eff40 400d8000
7ea0: ca31c000 00000200 cfbd5680 c01684ac 000000b2 00000000 00000000 cf8bc168
7ec0: cb307f10 000000d8 00000000 00000360 ca31d000 000000d0 c0639124 ffffffff
7ee0: 400d8000 cf8652c0 ca14dca0 c03a6110 00000200 400d8000 cf8652c0 c00f457c
7f00: ca14dca0 ca14dd40 00000000 ca990848 cf67b418 00200200 00100100 cf401398
7f20: cf67b418 00200200 00100100 cf67b418 cf80a620 c0189480 cf67b418 cf67b418
7f40: c05cacd4 c0189be0 ca990848 00000021 00000000 caba28a0 00000000 c017b630
7f60: 00000000 00000000 00000003 caba28a0 00000000 caba28a0 00000000 cb0bbe40
7f80: 00000006 c01784d4 00000003 cb0bbe40 caba28a0 00000000 00000001 00000004
7fa0: 00000058 c00eee40 00000000 00000001 fee1dead 28121969 01234567 0000006c
7fc0: 00000000 00000001 00000004 00000058 00000001 00000001 00000000 00000001
7fe0: 400e0880 bedd1cb0 00009210 400e0898 60000010 fee1dead 00000000 00000000
Code: cf8a3000 00000158 cf8ab158 0000004e (ffffffff)
---[ end trace 59776612ba8fbf0c ]---
Segmentation fault
