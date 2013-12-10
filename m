From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: debugfs pinctrl crash on beagle-xm
Date: Tue, 10 Dec 2013 12:41:41 +0200
Message-ID: <52A6EFE5.2040706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="I6I2aO49ax0rhGM1Pnad7vSLmUtxruaM1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab3LJKlo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Dec 2013 05:41:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--I6I2aO49ax0rhGM1Pnad7vSLmUtxruaM1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On beagle-xm, v3.13-rc3, I see the following crash if I use the pinctrl
debugfs:

# cat /debug/pinctrl/48002030.pinmux/pins
[   16.464233] Unhandled fault: external abort on non-linefetch (0x1028)
at 0xfa002268
[   16.472351] Internal error: : 1028 [#1] SMP ARM
[   16.477142] Modules linked in:
[   16.480377] CPU: 0 PID: 878 Comm: cat Not tainted
3.13.0-rc3-00001-g851bf0abf7d6 #80
[   16.488555] task: dd2ba080 ti: dd1b6000 task.ti: dd1b6000
[   16.494262] PC is at pcs_readw+0xc/0x20
[   16.498321] LR is at pcs_pin_dbg_show+0x34/0x54
[   16.503112] pc : [<c0321e64>]    lr : [<c0322dc8>]    psr: a0000013
[   16.503112] sp : dd1b7e98  ip : dd1b7ea8  fp : dd1b7ea4
[   16.515197] r10: c075b67c  r9 : 0000011c  r8 : c05dabf4
[   16.520721] r7 : dd34dd8c  r6 : dd34dd80  r5 : 0000011c  r4 : dd3c28c0=

[   16.527618] r3 : c0321e58  r2 : fa002030  r1 : dd3c28c0  r0 : fa002268=

[   16.534515] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment user
[   16.542022] Control: 10c5387d  Table: 9d52c019  DAC: 00000015
[   16.548095] Process cat (pid: 878, stack limit =3D 0xdd1b6248)
[   16.554077] Stack: (0xdd1b7e98 to 0xdd1b8000)
[   16.558654] 7e80:
   dd1b7ebc dd1b7ea8
[   16.567291] 7ea0: c0322dc8 c0321e64 0000011d dd3c28c0 dd1b7ef4
dd1b7ec0 c031d860 c0322da0
[   16.575927] 7ec0: 00020000 dd34ddb8 dd1b6000 dd1b7f08 00000001
becaabd0 00000001 dd09e140
[   16.584564] 7ee0: 00000000 dd3c28c0 dd1b7f44 dd1b7ef8 c0144c98
c031d7b8 dd3c28f0 becaabd0
[   16.593200] 7f00: 00001000 dd1b7f78 00000000 00000000 dd55b000
dd09e140 dd55b000 dd09e140
[   16.601837] 7f20: 00001000 becaabd0 dd1b7f78 00000000 dd1b6000
00001000 dd1b7f74 dd1b7f48
[   16.610443] 7f40: c0122484 c0144adc 00000001 00000000 00000000
00000000 dd09e140 becaabd0
[   16.619079] 7f60: 00000000 00001000 dd1b7fa4 dd1b7f78 c01226a0
c01223f8 00000000 00000000
[   16.627716] 7f80: 000aea08 00000003 becaabd0 00000003 c000f6e4
00000000 00000000 dd1b7fa8
[   16.636352] 7fa0: c000f520 c0122668 000aea08 00000003 00000003
becaabd0 00001000 00000000
[   16.644989] 7fc0: 000aea08 00000003 becaabd0 00000003 00000001
00000001 00000000 00000003
[   16.653625] 7fe0: 00000000 becaabac 00010318 b6ec0ebc 60000010
00000003 fefffded aa599656
[   16.662231] Backtrace:
[   16.664855] [<c0321e58>] (pcs_readw+0x0/0x20) from [<c0322dc8>]
(pcs_pin_dbg_show+0x34/0x54)
[   16.673767] [<c0322d94>] (pcs_pin_dbg_show+0x0/0x54) from
[<c031d860>] (pinctrl_pins_show+0xb4/0x
f4)
[   16.683380]  r5:dd3c28c0 r4:0000011d
[   16.687194] [<c031d7ac>] (pinctrl_pins_show+0x0/0xf4) from
[<c0144c98>] (seq_read+0x1c8/0x4a0)
[   16.696289] [<c0144ad0>] (seq_read+0x0/0x4a0) from [<c0122484>]
(vfs_read+0x98/0x138)
[   16.704559] [<c01223ec>] (vfs_read+0x0/0x138) from [<c01226a0>]
(SyS_read+0x44/0x78)
[   16.712738] [<c012265c>] (SyS_read+0x0/0x78) from [<c000f520>]
(ret_fast_syscall+0x0/0x48)
[   16.721466] Code: e89da800 e1a0c00d e92dd800 e24cb004 (e1d020b0)
[   16.727905] ---[ end trace 81665b2138543736 ]---
[   16.732788] BUG: sleeping function called from invalid context at
kernel/locking/rwsem.c:20
[   16.741607] in_atomic(): 0, irqs_disabled(): 128, pid: 878, name: cat
[   16.748382] INFO: lockdep is turned off.
[   16.752532] irq event stamp: 3448
[   16.756011] hardirqs last  enabled at (3447): [<c05897bc>]
mutex_lock_nested+0x2e4/0x3c4
[   16.764587] hardirqs last disabled at (3448): [<c058b9d4>]
__dabt_svc+0x34/0x80
[   16.772308] softirqs last  enabled at (2974): [<c0048644>]
__do_softirq+0x1b4/0x314
[   16.780395] softirqs last disabled at (2961): [<c0048b90>]
irq_exit+0xb0/0x108
[   16.788024] CPU: 0 PID: 878 Comm: cat Tainted: G      D
3.13.0-rc3-00001-g851bf0abf7d6 #80
[   16.797180] Backtrace:
[   16.799804] [<c0013350>] (dump_backtrace+0x0/0x10c) from [<c00134ec>]
(show_stack+0x18/0x1c)
[   16.808685]  r6:0000000b r5:c08ef480 r4:00000000 r3:00000000
[   16.814697] [<c00134d4>] (show_stack+0x0/0x1c) from [<c0584660>]
(dump_stack+0x8c/0xc0)
[   16.823181] [<c05845d4>] (dump_stack+0x0/0xc0) from [<c006f208>]
(__might_sleep+0xe4/0x11c)
[   16.831970]  r4:dd1b6000 r3:dd2ba080
[   16.835784] [<c006f124>] (__might_sleep+0x0/0x11c) from [<c0589e94>]
(down_read+0x28/0x60)
[   16.844512]  r5:c00b6020 r4:dd376694
[   16.848297] [<c0589e6c>] (down_read+0x0/0x60) from [<c00b6020>]
(acct_collect+0x44/0x198)
[   16.856933]  r5:dd1b6000 r4:dd470140
[   16.860717] [<c00b5fdc>] (acct_collect+0x0/0x198) from [<c0045b54>]
(do_exit+0x144/0x968)
[   16.869354]  r7:c08474fc r6:dd2ba080 r5:dd1b6000 r4:0000000b
[   16.875366] [<c0045a10>] (do_exit+0x0/0x968) from [<c00138f0>]
(die+0x400/0x458)
[   16.883178]  r7:c08474fc
[   16.885864] [<c00134f0>] (die+0x0/0x458) from [<c001396c>]
(arm_notify_die+0x24/0x5c)
[   16.894134] [<c0013948>] (arm_notify_die+0x0/0x5c) from [<c0008460>]
(do_DataAbort+0x90/0xa0)
[   16.903137] [<c00083d0>] (do_DataAbort+0x0/0xa0) from [<c058b9e4>]
(__dabt_svc+0x44/0x80)
[   16.911743] Exception stack(0xdd1b7e50 to 0xdd1b7e98)
[   16.917083] 7e40:                                     fa002268
dd3c28c0 fa002030 c0321e58
[   16.925720] 7e60: dd3c28c0 0000011c dd34dd80 dd34dd8c c05dabf4
0000011c c075b67c dd1b7ea4
[   16.934356] 7e80: dd1b7ea8 dd1b7e98 c0322dc8 c0321e64 a0000013 fffffff=
f
[   16.941314]  r8:c05dabf4 r7:dd1b7e84 r6:ffffffff r5:a0000013 r4:c0321e=
64
[   16.948455] [<c0321e58>] (pcs_readw+0x0/0x20) from [<c0322dc8>]
(pcs_pin_dbg_show+0x34/0x54)
[   16.957366] [<c0322d94>] (pcs_pin_dbg_show+0x0/0x54) from
[<c031d860>] (pinctrl_pins_show+0xb4/0x
f4)
[   16.967010]  r5:dd3c28c0 r4:0000011d
[   16.970794] [<c031d7ac>] (pinctrl_pins_show+0x0/0xf4) from
[<c0144c98>] (seq_read+0x1c8/0x4a0)
[   16.979888] [<c0144ad0>] (seq_read+0x0/0x4a0) from [<c0122484>]
(vfs_read+0x98/0x138)
[   16.988159] [<c01223ec>] (vfs_read+0x0/0x138) from [<c01226a0>]
(SyS_read+0x44/0x78)
[   16.996337] [<c012265c>] (SyS_read+0x0/0x78) from [<c000f520>]
(ret_fast_syscall+0x0/0x48)
[   17.005096] In-band Error seen by MPU  at address 0
[   17.010223] ------------[ cut here ]------------
[   17.015106] WARNING: CPU: 0 PID: 878 at drivers/bus/omap_l3_smx.c:162
omap3_l3_app_irq+0xd4/0x12c
()
[   17.024658] Modules linked in:
[   17.027893] CPU: 0 PID: 878 Comm: cat Tainted: G      D
3.13.0-rc3-00001-g851bf0abf7d6 #80
[   17.037048] Backtrace:
[   17.039672] [<c0013350>] (dump_backtrace+0x0/0x10c) from [<c00134ec>]
(show_stack+0x18/0x1c)
[   17.048553]  r6:c031a794 r5:00000009 r4:00000000 r3:00000000
[   17.054595] [<c00134d4>] (show_stack+0x0/0x1c) from [<c0584660>]
(dump_stack+0x8c/0xc0)
[   17.063049] [<c05845d4>] (dump_stack+0x0/0xc0) from [<c0043b3c>]
(warn_slowpath_common+0x74/0x98)
[   17.072387]  r4:00000000 r3:dd2ba080
[   17.076202] [<c0043ac8>] (warn_slowpath_common+0x0/0x98) from
[<c0043b84>] (warn_slowpath_null+0x
24/0x2c)
[   17.086303]  r8:00000000 r7:f8001400 r6:00000000 r5:00000000 r4:04001a=
00
[   17.093414] [<c0043b60>] (warn_slowpath_null+0x0/0x2c) from
[<c031a794>] (omap3_l3_app_irq+0xd4/0
x12c)
[   17.103240] [<c031a6c0>] (omap3_l3_app_irq+0x0/0x12c) from
[<c0093580>] (handle_irq_event_percpu+
0x60/0x28c)
[   17.113616]  r7:00000000 r6:0000001a r5:dd005594 r4:dd0cd580
[   17.119628] [<c0093520>] (handle_irq_event_percpu+0x0/0x28c) from
[<c00937f0>] (handle_irq_event+
0x44/0x64)
[   17.129913] [<c00937ac>] (handle_irq_event+0x0/0x64) from
[<c00964b8>] (handle_level_irq+0xb4/0x1
14)
[   17.139556]  r6:dd1b6000 r5:dd005594 r4:dd005540 r3:00020000
[   17.145568] [<c0096404>] (handle_level_irq+0x0/0x114) from
[<c0092ee4>] (generic_handle_irq+0x28/
0x38)
[   17.155364]  r5:c0837278 r4:0000001a
[   17.159179] [<c0092ebc>] (generic_handle_irq+0x0/0x38) from
[<c000fe4c>] (handle_IRQ+0x54/0xb8)
[   17.168365]  r4:c08437f0 r3:00000174
[   17.172149] [<c000fdf8>] (handle_IRQ+0x0/0xb8) from [<c00085f4>]
(omap3_intc_handle_irq+0x68/0x7c
)
[   17.181610]  r8:dd1b6000 r7:0000001a r6:c08ec290 r5:dd1b7c50 r4:fa2000=
00
r3:00000060
[   17.189941] [<c000858c>] (omap3_intc_handle_irq+0x0/0x7c) from
[<c058ba64>] (__irq_svc+0x44/0x5c)
[   17.199279] Exception stack(0xdd1b7c50 to 0xdd1b7c98)
[   17.204620] 7c40:                                     c058b384
dd2ba080 dd1b7c98 00000000
[   17.213256] 7c60: dd5297c4 dd1b6000 0000000b 0000088c dd1b6000
c08eb904 dd1b6000 dd1b7cac
[   17.221893] 7c80: dd1b7c88 dd1b7c98 c008a108 c058b38c 60000113 fffffff=
f
[   17.228851]  r7:dd1b7c84 r6:ffffffff r5:60000113 r4:c058b38c
[   17.234893] [<c058b358>] (_raw_spin_unlock_irq+0x0/0x4c) from
[<c00b6154>] (acct_collect+0x178/0x
198)
[   17.244598]  r4:dd470140 r3:dd2ba080
[   17.248413] [<c00b5fdc>] (acct_collect+0x0/0x198) from [<c0045b54>]
(do_exit+0x144/0x968)
[   17.257019]  r7:c08474fc r6:dd2ba080 r5:dd1b6000 r4:0000000b
[   17.263061] [<c0045a10>] (do_exit+0x0/0x968) from [<c00138f0>]
(die+0x400/0x458)
[   17.270843]  r7:c08474fc
[   17.273529] [<c00134f0>] (die+0x0/0x458) from [<c001396c>]
(arm_notify_die+0x24/0x5c)
[   17.281799] [<c0013948>] (arm_notify_die+0x0/0x5c) from [<c0008460>]
(do_DataAbort+0x90/0xa0)
[   17.290802] [<c00083d0>] (do_DataAbort+0x0/0xa0) from [<c058b9e4>]
(__dabt_svc+0x44/0x80)
[   17.299438] Exception stack(0xdd1b7e50 to 0xdd1b7e98)
[   17.304748] 7e40:                                     fa002268
dd3c28c0 fa002030 c0321e58
[   17.313385] 7e60: dd3c28c0 0000011c dd34dd80 dd34dd8c c05dabf4
0000011c c075b67c dd1b7ea4
[   17.322021] 7e80: dd1b7ea8 dd1b7e98 c0322dc8 c0321e64 a0000013 fffffff=
f
[   17.329010]  r8:c05dabf4 r7:dd1b7e84 r6:ffffffff r5:a0000013 r4:c0321e=
64
[   17.336120] [<c0321e58>] (pcs_readw+0x0/0x20) from [<c0322dc8>]
(pcs_pin_dbg_show+0x34/0x54)
[   17.345031] [<c0322d94>] (pcs_pin_dbg_show+0x0/0x54) from
[<c031d860>] (pinctrl_pins_show+0xb4/0x
f4)
[   17.354675]  r5:dd3c28c0 r4:0000011d
[   17.358459] [<c031d7ac>] (pinctrl_pins_show+0x0/0xf4) from
[<c0144c98>] (seq_read+0x1c8/0x4a0)
[   17.367553] [<c0144ad0>] (seq_read+0x0/0x4a0) from [<c0122484>]
(vfs_read+0x98/0x138)
[   17.375823] [<c01223ec>] (vfs_read+0x0/0x138) from [<c01226a0>]
(SyS_read+0x44/0x78)
[   17.384002] [<c012265c>] (SyS_read+0x0/0x78) from [<c000f520>]
(ret_fast_syscall+0x0/0x48)
[   17.392730] ---[ end trace 81665b2138543737 ]---


--I6I2aO49ax0rhGM1Pnad7vSLmUtxruaM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpu/lAAoJEPo9qoy8lh718DAP/31P3oXbPFZhpchZYVGBCTV1
Z/Lta1RP6ravKQLR9+4GJW5Ld9G3KKCaoT3lVxy2e0DHByX7I1T/y7hdFwtdfa+0
PegmnO1rBFo8OUBxwHR0Vx6g5pEUH88gg2QYv+JSh/Nmej7HkqXlt1V35yRnw0WR
/o6et5anwQtwGmPMk3qDFmZI8zp0q8jngLSAp6lv1/R4WB4zxlu48IeT17sfHVhh
c+Nr2k0vOinTZdrZlg8QrfTGBtyiz9V6KGizAUly6Qn6H/0wczuVeuZkpybf71ZM
DhK8Qb+Q2jUgSJaPbL3yOwDoXDU5SV0rQ0beEWhyyj7x8uzEMji50J1nGUF744jd
V1mslNMzRY8Zv4uBbC8OtnXUScMy7hpf+XLcT9ursQxVE7ucbOu71kjGFSjYQjoZ
75xPGGfGkSRvL9gCUc82kM9W45D1Z0DM20+FxDdFVkwqESntE9Lz3SB3Py4lCKDl
3hqgyGRdJ3JCSNGj3gUNkzKfX93pylurcVxBK8CwU4tZGcuE7nte41jl3vvM/Rfl
qOETmtv0TNjZwS5MrAen3TH+1iG5E3yGicRN2hZvulHXgUXx6pH1susMN994cwFS
bGrUAO9EbA5xeOqeORVIYxPzSQgDzB3pnTZ3ihG3ncIxcVIIvkzSl7Q0OYKuYPs3
oUIOSO75P0Lfput5gJJM
=bwYr
-----END PGP SIGNATURE-----

--I6I2aO49ax0rhGM1Pnad7vSLmUtxruaM1--
