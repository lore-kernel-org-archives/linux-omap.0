From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: SDP broken (l-o-2.6.31-rc6)
Date: Thu, 20 Aug 2009 22:25:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F969AE49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbZHTQzT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 12:55:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7KGtDWq015826
	for <linux-omap@vger.kernel.org>; Thu, 20 Aug 2009 11:55:20 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7KGtCTt021918
	for <linux-omap@vger.kernel.org>; Thu, 20 Aug 2009 22:25:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


I am seeing a crash on bootup on SDP on the latest head of linux omap (=
7a8d53a06009b)

Anyone seen this before??

---
6>JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
<6>msgmni has been set to 243
<6>alg: No test for stdrng (krng)
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<4>Platform driver 'omapfb' needs updating - please use dev_pm_ops
<4>Platform driver 'sdp2430_lcd' needs updating - please use dev_pm_ops
<6>omapfb: configured for panel sdp2430
<6>omapfb: DISPC version 3.0 initialized
<4>------------[ cut here ]------------
<4>WARNING: at kernel/mutex.c:207 __mutex_lock_slowpath+0xb0/0x234()
<d>Modules linked in:
[<c00325e4>] (unwind_backtrace+0x0/0xdc) from [<c00508e0>] (warn_slowpa=
th_common+0x48/0x60)
[<c00508e0>] (warn_slowpath_common+0x48/0x60) from [<c03728b4>] (__mute=
x_lock_slowpath+0xb0/0x234)
[<c03728b4>] (__mutex_lock_slowpath+0xb0/0x234) from [<c0372a44>] (mute=
x_lock+0xc/0x20)
[<c0372a44>] (mutex_lock+0xc/0x20) from [<c01b96c4>] (set_fb_fix+0x30/0=
xbc)
[<c01b96c4>] (set_fb_fix+0x30/0xbc) from [<c01bab1c>] (omapfb_do_probe+=
0x428/0x86c)
[<c01bab1c>] (omapfb_do_probe+0x428/0x86c) from [<c01bcde0>] (sdp2430_p=
anel_probe+0xc/0x18)
[<c01bcde0>] (sdp2430_panel_probe+0xc/0x18) from [<c01e0454>] (platform=
_drv_probe+0x18/0x1c)
[<c01e0454>] (platform_drv_probe+0x18/0x1c) from [<c01df624>] (driver_p=
robe_device+0xa0/0x14c)
[<c01df624>] (driver_probe_device+0xa0/0x14c) from [<c01df730>] (__driv=
er_attach+0x60/0x84)
[<c01df730>] (__driver_attach+0x60/0x84) from [<c01deee8>] (bus_for_eac=
h_dev+0x44/0x74)
[<c01deee8>] (bus_for_each_dev+0x44/0x74) from [<c01de7fc>] (bus_add_dr=
iver+0xf4/0x278)
[<c01de7fc>] (bus_add_driver+0xf4/0x278) from [<c01dfa00>] (driver_regi=
ster+0xa8/0x130)
[<c01dfa00>] (driver_register+0xa8/0x130) from [<c002d29c>] (do_one_ini=
tcall+0x54/0x194)
[<c002d29c>] (do_one_initcall+0x54/0x194) from [<c0008574>] (kernel_ini=
t+0x8c/0x108)
[<c0008574>] (kernel_init+0x8c/0x108) from [<c002e77c>] (kernel_thread_=
exit+0x0/0x8)
<4>---[ end trace da227214a82491b7 ]---
<1>Unable to handle kernel NULL pointer dereference at virtual address =
00000000
<1>pgd =3D c0004000
<1>[00000000] *pgd=3D00000000
Internal error: Oops: 805 [#1]
<d>Modules linked in:
CPU: 0    Tainted: G        W   (2.6.31-rc5-omap1-05899-gf622368 #33)
PC is at __mutex_lock_slowpath+0xe0/0x234
LR is at __mutex_lock_slowpath+0xcc/0x234
pc : [<c03728e4>]    lr : [<c03728d0>]    psr: 40000093
sp : c7825e58  ip : 11111111  fp : c7980624
r10: c7980600  r9 : c7980600  r8 : c78b9824
r7 : c7820000  r6 : 60000013  r5 : c78b9820  r4 : c78b9820
r3 : 00000000  r2 : c7824000  r1 : c7825e58  r0 : c78b9820
=46lags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xc78242f0)
Stack: (0xc7825e58 to 0xc7826000)
5e40:                                                       c78b9824 00=
000000
5e60: 11111111 c7825e58 c78b9820 c7980600 00000000 c78b9820 c78b9800 c0=
372a44
5e80: c7980600 c01b96c4 c05387b8 00000000 c78b9800 c78b9a68 00000000 c0=
1bab1c
5ea0: c79c9030 c00fa894 c7825ed0 c7980600 c79bcfc0 c7980600 00000000 69=
825ed0
5ec0: 7265746e 006c616e 00000000 00000000 c785aa80 c04c4dc0 c04c4dc0 c0=
4e0484
5ee0: c785dd20 c04e44b0 00000000 00000000 00000000 c01bcde0 c04c4dc0 c0=
1e0454
5f00: c04c4dc0 c01df624 c04c4dc0 c04c4df4 c04e0484 c785dd20 c04e44b0 c0=
1df730
5f20: 00000000 c01df6d0 c04e0484 c01deee8 c78045b8 c785d210 c00250b8 00=
000060
5f40: c04e0484 c01de7fc c0425ee9 c0425ee9 00000001 c00250b8 00000000 c0=
4e0484
5f60: c0018d60 00000000 00000000 c01dfa00 c00250b8 00000000 00000000 c0=
018d60
5f80: 00000000 c002d29c c7825fb4 c042bcd3 00008124 0000024e c04d0200 c7=
84a680
5fa0: c04d0210 0000015f c050f108 c00f4ae8 c042bcd3 c78498a0 c7825fc6 c0=
07c190
5fc0: 00000000 35339ae0 00000031 00000000 00000000 00000192 c00250b8 00=
000000
5fe0: 00000000 00000000 00000000 c0008574 00000000 c002e77c aaaa5555 aa=
aa5555
[<c03728e4>] (__mutex_lock_slowpath+0xe0/0x234) from [<c0372a44>] (mute=
x_lock+0xc/0x20)
[<c0372a44>] (mutex_lock+0xc/0x20) from [<c01b96c4>] (set_fb_fix+0x30/0=
xbc)
[<c01b96c4>] (set_fb_fix+0x30/0xbc) from [<c01bab1c>] (omapfb_do_probe+=
0x428/0x86c)
[<c01bab1c>] (omapfb_do_probe+0x428/0x86c) from [<c01bcde0>] (sdp2430_p=
anel_probe+0xc/0x18)
[<c01bcde0>] (sdp2430_panel_probe+0xc/0x18) from [<c01e0454>] (platform=
_drv_probe+0x18/0x1c)
[<c01e0454>] (platform_drv_probe+0x18/0x1c) from [<c01df624>] (driver_p=
robe_device+0xa0/0x14c)
[<c01df624>] (driver_probe_device+0xa0/0x14c) from [<c01df730>] (__driv=
er_attach+0x60/0x84)
[<c01df730>] (__driver_attach+0x60/0x84) from [<c01deee8>] (bus_for_eac=
h_dev+0x44/0x74)
[<c01deee8>] (bus_for_each_dev+0x44/0x74) from [<c01de7fc>] (bus_add_dr=
iver+0xf4/0x278)
[<c01de7fc>] (bus_add_driver+0xf4/0x278) from [<c01dfa00>] (driver_regi=
ster+0xa8/0x130)
[<c01dfa00>] (driver_register+0xa8/0x130) from [<c002d29c>] (do_one_ini=
tcall+0x54/0x194)
[<c002d29c>] (do_one_initcall+0x54/0x194) from [<c0008574>] (kernel_ini=
t+0x8c/0x108)
[<c0008574>] (kernel_init+0x8c/0x108) from [<c002e77c>] (kernel_thread_=
exit+0x0/0x8)
Code: e2858004 e585d008 e58d8000 e58d3004 (e583d000)
<4>---[ end trace da227214a82491b8 ]---
<0>Kernel panic - not syncing: Attempted to kill init!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
