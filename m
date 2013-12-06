From: Sebastian Reichel <sre@debian.org>
Subject: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Fri, 6 Dec 2013 22:36:14 +0100
Message-ID: <20131206213613.GA19648@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44847 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758016Ab3LFVgo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 16:36:44 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Nokia N900 DT boot breaks for me using 3.13-rc3. You can see the
relevant kernel output below. Disabling the AES module in the
omap3-n900.dts with status =3D "disabled" fixed the boot for me.

-- Sebastian

[    2.082427] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa0c5048
[    2.090484] Internal error: : 1028 [#1] SMP ARM
[    2.095245] Modules linked in:
[    2.098480] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.13.0-=
rc2+ #446
[    2.106353] task: ce057b40 ti: ce058000 task.ti: ce058000
[    2.112030] PC is at omap_aes_dma_stop+0x24/0x3c
[    2.116882] LR is at omap_aes_probe+0x1cc/0x584
[    2.121643] pc : [<c039cd54>]    lr : [<c039d3ac>]    psr: 60000113
[    2.121643] sp : ce059e20  ip : ce0b4ee0  fp : 00000000
[    2.133728] r10: c0573ae8  r9 : c0749508  r8 : 00000000
[    2.139221] r7 : ce0b4e00  r6 : 00000000  r5 : ce0b4e10  r4 : ce274890
[    2.146057] r3 : fa0c5048  r2 : 00000048  r1 : 0000002c  r0 : ce274890
[    2.152923] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[    2.160614] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    2.166687] Process swapper/0 (pid: 1, stack limit =3D 0xce058248)
[    2.173004] Stack: (0xce059e20 to 0xce05a000)
[    2.177612] 9e20: c0749508 0000a1ff 00000000 c016cd8c c06b5a06 ce2a45f0 =
ce2a4570 ce0b5fb0
[    2.186218] 9e40: 00000000 480c5000 480c504f c0abe4e4 00000200 00000000 =
00000000 00000000
[    2.194824] 9e60: ce0b4e10 ce0b4e10 c082da3c c082da3c c02b8c70 c077c610 =
c0749508 00000000
[    2.203430] 9e80: 00000000 c02b9e7c c02b9e64 ce0b4e10 00000000 c02b8b20 =
ce0b4e10 ce0b4e44
[    2.212036] 9ea0: c082da3c c02b8cd8 00000000 ce059eb8 c082da3c c02b7408 =
ce079edc ce0b1a34
[    2.220642] 9ec0: c082da3c c082da3c ce2a0280 00000000 c08158d8 c02b8358 =
c0663405 c0663405
[    2.229248] 9ee0: 00000073 c082da3c c079e4e8 c07ab3bc c0844340 c02b9334 =
00000000 00000006
[    2.237823] 9f00: c079e4e8 c0008920 c067f6bf c0ac7c6b 00000000 c0712e28 =
00000000 00000000
[    2.246429] 9f20: c0712e38 ce059f38 00000093 c0ac7c82 00000000 c0058994 =
00000000 c07130e8
[    2.255035] 9f40: c07127b8 00000093 00000006 00000006 00000001 00000006 =
00000006 c079e4e8
[    2.263610] 9f60: c07ab3bc c0844340 00000093 c0749508 c079e4f4 c0749c64 =
00000006 00000006
[    2.272247] 9f80: c0749508 00000000 00000000 c0517e2c 00000000 00000000 =
00000000 00000000
[    2.280853] 9fa0: 00000000 c0517e34 00000000 c000dfb8 00000000 00000000 =
00000000 00000000
[    2.289459] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    2.298065] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
ffffffff ffffffff
[    2.306671] [<c039cd54>] (omap_aes_dma_stop+0x24/0x3c) from [<c039d3ac>]=
 (omap_aes_probe+0x1cc/0x584)
[    2.316406] [<c039d3ac>] (omap_aes_probe+0x1cc/0x584) from [<c02b9e7c>] =
(platform_drv_probe+0x18/0x48)
[    2.326232] [<c02b9e7c>] (platform_drv_probe+0x18/0x48) from [<c02b8b20>=
] (driver_probe_device+0xb0/0x200)
[    2.336425] [<c02b8b20>] (driver_probe_device+0xb0/0x200) from [<c02b8cd=
8>] (__driver_attach+0x68/0x8c)
[    2.346343] [<c02b8cd8>] (__driver_attach+0x68/0x8c) from [<c02b7408>] (=
bus_for_each_dev+0x50/0x88)
[    2.355865] [<c02b7408>] (bus_for_each_dev+0x50/0x88) from [<c02b8358>] =
(bus_add_driver+0xcc/0x1c8)
[    2.365356] [<c02b8358>] (bus_add_driver+0xcc/0x1c8) from [<c02b9334>] (=
driver_register+0x9c/0xe0)
[    2.374816] [<c02b9334>] (driver_register+0x9c/0xe0) from [<c0008920>] (=
do_one_initcall+0x98/0x140)
[    2.384368] [<c0008920>] (do_one_initcall+0x98/0x140) from [<c0749c64>] =
(kernel_init_freeable+0x16c/0x23c)
[    2.394592] [<c0749c64>] (kernel_init_freeable+0x16c/0x23c) from [<c0517=
e34>] (kernel_init+0x8/0x100)
[    2.404296] [<c0517e34>] (kernel_init+0x8/0x100) from [<c000dfb8>] (ret_=
=66rom_fork+0x14/0x3c)
[    2.413177] Code: e1811002 e5932020 e590300c e0833002 (e593c000)=20
[    2.419586] ---[ end trace 12268ed9c6cdcae7 ]---
[    2.424468] In-band Error seen by MPU  at address 0
[    2.429626] ------------[ cut here ]------------
[    2.434509] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:162 omap=
3_l3_app_irq+0xdc/0x124()
[    2.443817] Modules linked in:
[    2.447052] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D W    3.13.0-=
rc2+ #446
[    2.454956] [<c00158b4>] (unwind_backtrace+0x0/0xe0) from [<c0011b24>] (=
show_stack+0x10/0x14)
[    2.463958] [<c0011b24>] (show_stack+0x10/0x14) from [<c051c30c>] (dump_=
stack+0x68/0x84)
[    2.472473] [<c051c30c>] (dump_stack+0x68/0x84) from [<c003db64>] (warn_=
slowpath_common+0x64/0x88)
[    2.481933] [<c003db64>] (warn_slowpath_common+0x64/0x88) from [<c003dba=
0>] (warn_slowpath_null+0x18/0x1c)
[    2.492095] [<c003dba0>] (warn_slowpath_null+0x18/0x1c) from [<c023d2c0>=
] (omap3_l3_app_irq+0xdc/0x124)
[    2.502014] [<c023d2c0>] (omap3_l3_app_irq+0xdc/0x124) from [<c007c718>]=
 (handle_irq_event_percpu+0x60/0x218)
[    2.512420] [<c007c718>] (handle_irq_event_percpu+0x60/0x218) from [<c00=
7c914>] (handle_irq_event+0x44/0x64)
[    2.522796] [<c007c914>] (handle_irq_event+0x44/0x64) from [<c007f4e0>] =
(handle_level_irq+0xd4/0xfc)
[    2.532409] [<c007f4e0>] (handle_level_irq+0xd4/0xfc) from [<c007c14c>] =
(generic_handle_irq+0x20/0x30)
[    2.542236] [<c007c14c>] (generic_handle_irq+0x20/0x30) from [<c000ee3c>=
] (handle_IRQ+0x64/0x8c)
[    2.551513] [<c000ee3c>] (handle_IRQ+0x64/0x8c) from [<c00085dc>] (omap3=
_intc_handle_irq+0x60/0x74)
[    2.561035] [<c00085dc>] (omap3_intc_handle_irq+0x60/0x74) from [<c00126=
40>] (__irq_svc+0x40/0x50)
[    2.570404] Exception stack(0xce059c28 to 0xce059c70)
[    2.575714] 9c20:                   00000000 00000005 c07bc608 00000504 =
ce05bbc0 ce058000
[    2.584289] 9c40: 00000000 00000001 0000000b 00000000 00000000 c0660359 =
00000000 ce059c70
[    2.592895] 9c60: c009a964 c009aa6c 40000113 ffffffff
[    2.598236] [<c0012640>] (__irq_svc+0x40/0x50) from [<c009aa6c>] (acct_c=
ollect+0x1b4/0x1b8)
[    2.607025] [<c009aa6c>] (acct_collect+0x1b4/0x1b8) from [<c003fce4>] (d=
o_exit+0x1fc/0x954)
[    2.615844] [<c003fce4>] (do_exit+0x1fc/0x954) from [<c0011ebc>] (die+0x=
394/0x410)
[    2.623809] [<c0011ebc>] (die+0x394/0x410) from [<c000845c>] (do_DataAbo=
rt+0x84/0x98)
[    2.632049] [<c000845c>] (do_DataAbort+0x84/0x98) from [<c00125d8>] (__d=
abt_svc+0x38/0x60)
[    2.640747] Exception stack(0xce059dd8 to 0xce059e20)
[    2.646087] 9dc0:                                                       =
ce274890 0000002c
[    2.654663] 9de0: 00000048 fa0c5048 ce274890 ce0b4e10 00000000 ce0b4e00 =
00000000 c0749508
[    2.663299] 9e00: c0573ae8 00000000 ce0b4ee0 ce059e20 c039d3ac c039cd54 =
60000113 ffffffff
[    2.671874] [<c00125d8>] (__dabt_svc+0x38/0x60) from [<c039cd54>] (omap_=
aes_dma_stop+0x24/0x3c)
[    2.681060] [<c039cd54>] (omap_aes_dma_stop+0x24/0x3c) from [<c039d3ac>]=
 (omap_aes_probe+0x1cc/0x584)
[    2.690734] [<c039d3ac>] (omap_aes_probe+0x1cc/0x584) from [<c02b9e7c>] =
(platform_drv_probe+0x18/0x48)
[    2.700500] [<c02b9e7c>] (platform_drv_probe+0x18/0x48) from [<c02b8b20>=
] (driver_probe_device+0xb0/0x200)
[    2.710662] [<c02b8b20>] (driver_probe_device+0xb0/0x200) from [<c02b8cd=
8>] (__driver_attach+0x68/0x8c)
[    2.720581] [<c02b8cd8>] (__driver_attach+0x68/0x8c) from [<c02b7408>] (=
bus_for_each_dev+0x50/0x88)
[    2.730133] [<c02b7408>] (bus_for_each_dev+0x50/0x88) from [<c02b8358>] =
(bus_add_driver+0xcc/0x1c8)
[    2.739654] [<c02b8358>] (bus_add_driver+0xcc/0x1c8) from [<c02b9334>] (=
driver_register+0x9c/0xe0)
[    2.749084] [<c02b9334>] (driver_register+0x9c/0xe0) from [<c0008920>] (=
do_one_initcall+0x98/0x140)
[    2.758605] [<c0008920>] (do_one_initcall+0x98/0x140) from [<c0749c64>] =
(kernel_init_freeable+0x16c/0x23c)
[    2.768798] [<c0749c64>] (kernel_init_freeable+0x16c/0x23c) from [<c0517=
e34>] (kernel_init+0x8/0x100)
[    2.778472] [<c0517e34>] (kernel_init+0x8/0x100) from [<c000dfb8>] (ret_=
=66rom_fork+0x14/0x3c)
[    2.787353] ---[ end trace 12268ed9c6cdcae8 ]---
[    2.792449] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSokNNAAoJENju1/PIO/qa+wMP/A3PBB0D8SdB8e6S6F3umZwx
R9Opt1WcjWlrl/d0tXdez0o27JFrvujbFVGqWpJFwI6MZZ/bEkINyMKdBADG0iD6
B/Ob1MfOJ5MVm62oCTCrAIunSU/f3YiNCKqF4FoMpSgNwgyQz/CETLGM8s/lsMbo
T3l0RXUNhbJOxQysVrea1SGkTJ9dvPF/IsXtrmB3T+ruj5fPUsShAyn8dKQ/cR26
tr61xoYjeK9cn5w+EBKf1ZkR2DuFoTQzZcsF3qHetEESXPTqCKHjQJbL2bSjyDzs
eFEu7Huq7T3IcLSjsLVsKJEmBdS49NJgd9dUHwAVyQnonkUOdgUq5Nrcg8vdBhZ3
hrM0IxugNQ36d5XMQD2BmdMJOn4vF7Hwxj1M+tDSCurB3Mzm+sujK+mB4q2p/M/z
ijvoFkClsLjzJvjSCsWKsqe3HzEXTPSHg4Q566J3PCw7dRTSAdwmppfHQfkPWyrV
UWTNq6GTWVZIHGC9Zi5/K8GghEX9v51gmFOMOJZEIh1vZzrQ57dSnnjB9Mly20rO
wWCSVPg3qwtxtPqBANy43HVTwgQM1KfN9CqpTTRty9QbCZX3tvvIUGb4g7+wVgLy
DXVNl7QEf+8H/tOWax1O6o3O0QyR3/D7HmqVHpDcuSuQtMt1i1qpeU0G10fDjozf
u8x3ZSjIJTf9IpOcGjoR
=2YKr
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
