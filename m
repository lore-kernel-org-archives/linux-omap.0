From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: RT tests on OMAP3
Date: Mon, 31 Aug 2009 23:16:53 -0400
Message-ID: <f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
References: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:64948 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZIADQw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 23:16:52 -0400
In-Reply-To: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rt-users <linux-rt-users@vger.kernel.org>, Linux OMAP Users <linux-omap@vger.kernel.org>

On Mon, Aug 31, 2009 at 4:50 PM, Cliff Brake<cliff.brake@gmail.com> wro=
te:
> Hello,
>
> I'm trying to run 2.6.31-rc8-rt9-omap1 on a OMAP3 cpu. =A0So far, it
> seems fairly unstable:
>
> http://www.bec-systems.com/omap-rt-tests/
>
> 2.6.31-rc8-rt9 boots and runs well on a PXA270.
>
> The following mail also references udev failures:
> http://lkml.org/lkml/2009/8/11/250

A few more observations:

Applying

http://cgit.openembedded.org/cgit.cgi/openembedded/diff/recipes/linux/l=
inux-omap-2.6.29/0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-=
the.patch?id=3D1f0d91e152f16fbd40bb2fb3c44a30d774d4dede

Seems to fix or mask the udev problems.  But, with preempt-rt, and
EHCI enabled, I still get messages continually scrolling:

<7>ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 27
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 28
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 29
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 30
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 31
ehci-omap ehci-omap.0: devpath 2.1 ep2in 3strikes
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 1
ehci-oeteehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 27
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 28
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 29
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 30
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 31
ehci-omap ehci-omap.0: devpath 2.1 ep2in 3strikes
ehci-omap ehci-omap.0: detected XactErr -omap.0: detected XactErr len
0/2048 retry 8
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 9
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 10
ehci-omap ehci-omap.0: detected XactErr len 0/2048 retry 11

The same hardware works fine without the RT patch.

I got the following message early in the boot sequence:

Starting udevusb%d: Error reading RX_CTL register: ffffffb9
usb%d: Failed to write RX_CTL mode to 0x0000: ffffffb9
asix: probe of 2-2.1:1.0 failed with error -71
hub 2-2:1.0: hub_port_status failed (err =3D -71)
hub 2-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
usb 2-2: USB disconnect, address 2
usb 2-2.1: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address
00000014
usb 2-2: new high speed USB device using ehci-omap and address 4
pgd =3D cf050000
[00000014] *pgd=3D8f040031, *pte=3D00000000, *ppte=3D00000000
Internal error: Oops: 0 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc8-rt9-omap1 #12)
PC is at 0x14
LR is at block_nodename+0x24/0x2c
pc : [<00000014>]    lr : [<c01d3c4c>]    psr: 20000033
sp : cfaafe98  ip : 00000007  fp : 00000000
r10: c054dd28  r9 : cf024620  r8 : cf80cb60
r7 : cf983658  r6 : cf983650  r5 : cfaafebc  r4 : cf983650
r3 : 00000015  r2 : cf983600  r1 : cfaafebc  r0 : cf983600
=46lags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 10c5387d  Table: 8f050019  DAC: 00000015
Process udevadm (pid: 606, stack limit =3D 0xcfaae2f0)
Stack: (0xcfaafe98 to 0xcfab0000)
fe80:                                                       00000000
c0234ed0
fea0: cf983658 cf983650 cf8c6000 cf8c6000 cf983658 c0234fc4 cf983650
00000000
fec0: c01dfc10 00000000 00000003 c01dfc78 00000000 cfaafee0 c03d6aac
00000000
fee0: c048d034 c0497048 00000000 cfaafef8 cf8bbec4 00000000 00000000
cf983650
ff00: 00000003 cf95b160 cf983658 c054dd68 cf95b178 cfaaff80 0001eb30
c0235128
ff20: cf08c6e0 00000000 cf95b178 00000003 cfb64758 c02346ac cfb64758
c0113908
ff40: cf08c6e0 0001df0c cfaaff80 0001df0c 00000003 cfaae000 00026df0
c00c9070
ff60: cf564d00 00000020 00000000 00000000 cf08c6e0 0001df0c 00000003
c00c91d4
ff80: 00000000 00000000 00000000 00000000 0002cf58 00000003 bef8b178
00000004
ffa0: c0033084 c0032f00 0002cf58 00000003 00000003 0001df0c 00000003
00000000
ffc0: 0002cf58 00000003 bef8b178 00000004 00026df4 00027008 00026df0
0001eb30
ffe0: 0001df0c bef8b168 0001a888 400d8bfc 40000010 00000003 41ffcf00
00fbcf00
Code: bad PC value.
usb 2-2: udev 4, busnum 2, minor =3D 131
usb 2-2: New USB device found, idVendor=3D2001, idProduct=3Df103
usb 2-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
usb 2-2: uevent

It makes sense that enabling EHCI may trigger some more udev activity.

Cliff
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
