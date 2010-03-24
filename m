From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: n900 doesn't boot with mainline
Date: Wed, 24 Mar 2010 12:48:25 +0200
Message-ID: <20100324104825.GA29419@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16613 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab0CXKtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 06:49:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Tony,

I'm using 2.6.34-rc2 and I get:

[    4.874694] Unhandled fault: alignment exception (0x801) at=20
0xfa070009
[    4.881683] Internal error: : 801 [#1]
[    4.885681] last sysfs file:=20
[    4.888824] Modules linked in:
[    4.892089] CPU: 0    Not tainted  (2.6.34-rc2-00011-g4f78620 #470)
[    4.898681] PC is at omap_i2c_unidle+0x44/0x138
[    4.903472] LR is at trace_hardirqs_on_caller+0x158/0x18c
[    4.909149] pc : [<c01d9258>]    lr : [<c0076eb4>]    psr: 20000013
[    4.909149] sp : cfc2bf00  ip : 00000009  fp : 00000000
[    4.921203] r10: c0394560  r9 : 00000000  r8 : c0394b88
[    4.926696] r7 : 00000000  r6 : c0394558  r5 : cfcbdc00  r4 :=20
cfcbdc00
[    4.933532] r3 : 00000009  r2 : fa070000  r1 : 00000000  r0 :=20
00000000
[    4.940368] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM =20
Segment kernel
[    4.948028] Control: 10c5387f  Table: 80004019  DAC: 00000017
[    4.954071] Process swapper (pid: 1, stack limit =3D 0xcfc2a2e8)
[    4.960205] Stack: (0xcfc2bf00 to 0xcfc2c000)
[    4.964813] bf00: c0394ba4 c0281f10 00000000 c00ffd94 cfc8c508=20
00000000 c0394560 c0394560
[    4.973358] bf20: c0394560 c051c898 00000000 00000000 00000000=20
c0186d74 c0394560 c0185e20
[    4.981903] bf40: c0394560 c051c898 c051c898 00000000 00000000=20
c0185f14 c0394560 c0394594
[    4.990478] bf60: c051c898 c0185f8c 00000000 c0185f2c c051c898=20
c0185674 cfc16a5c cfc8dd94
[    4.999023] bf80: c051c898 cfcbc8c0 c0518280 c0184fe4 c03467a1=20
00000093 cfc28d40 c051c898
[    5.007598] bfa0: 00000000 c001ce54 00000000 c0186300 c00232b8=20
00000000 c001ce54 c002b2cc
[    5.016143] bfc0: 00000031 00000000 00000000 00000192 00000000=20
c00232b8 00000000 00000000
[    5.024719] bfe0: 00000000 c000860c 00000000 c0008688 00000000=20
c002c2a4 00000000 00202000
[    5.033294] [<c01d9258>] (omap_i2c_unidle+0x44/0x138) from=20
[<c0281f10>] (omap_i2c_probe+0x150/0x338)
[    5.042877] [<c0281f10>] (omap_i2c_probe+0x150/0x338) from=20
[<c0186d74>] (platform_drv_probe+0x18/0x1c)
[    5.052581] [<c0186d74>] (platform_drv_probe+0x18/0x1c) from=20
[<c0185e20>] (really_probe+0x90/0x13c)
[    5.062042] [<c0185e20>] (really_probe+0x90/0x13c) from [<c0185f14>]=
=20
(driver_probe_device+0x48/0x60)
[    5.071594] [<c0185f14>] (driver_probe_device+0x48/0x60) from=20
[<c0185f8c>] (__driver_attach+0x60/0x84)
[    5.081329] [<c0185f8c>] (__driver_attach+0x60/0x84) from=20
[<c0185674>] (bus_for_each_dev+0x44/0x74)
[    5.090789] [<c0185674>] (bus_for_each_dev+0x44/0x74) from=20
[<c0184fe4>] (bus_add_driver+0x9c/0x190)
[    5.100250] [<c0184fe4>] (bus_add_driver+0x9c/0x190) from=20
[<c0186300>] (driver_register+0xa8/0xdc)
[    5.109649] [<c0186300>] (driver_register+0xa8/0xdc) from=20
[<c002b2cc>] (do_one_initcall+0x5c/0x1b8)
[    5.119110] [<c002b2cc>] (do_one_initcall+0x5c/0x1b8) from=20
[<c000860c>] (do_initcalls+0x14/0x30)
[    5.128295] [<c000860c>] (do_initcalls+0x14/0x30) from [<c0008688>]=20
(kernel_init+0x3c/0xcc)
[    5.137054] [<c0008688>] (kernel_init+0x3c/0xcc) from [<c002c2a4>]=20
(kernel_thread_exit+0x0/0x8)
[    5.146148] Code: e5942004 e3a0c009 e1a0331c e3a01000 (e18210b3)=20
[    5.152618] ---[ end trace 1b75b31a2719ed1c ]---
[    5.157531] Kernel panic - not syncing: Attempt=EF=BF=BDl to kill in=
it!

do you have a patch for that already ?

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
