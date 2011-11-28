From: Sebastian Reichel <sre@debian.org>
Subject: musb module broken in 3.1
Date: Mon, 28 Nov 2011 18:51:42 +0100
Message-ID: <20111128175142.GA21332@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:55766 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab1K1Rvq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 12:51:46 -0500
Received: from sre.ring0.de (unknown [93.223.94.250])
	by smtp.ring0.de (Postfix) with ESMTP id 40F4380D21
	for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 17:51:43 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have built a 3.1 mainline kernel with most stuff being configured as modu=
le.
I hit two errors in the musb kernel driver:

1. When loading g_ether without ohci_hcd being loaded it crashes as
in the first log.
2. When loading g_ether with ohci_hcd being loaded it crashes as
in the second log.

This also works with other usb gadget drivers, g_ether is just an
example.

-- Sebastian

root@pandaboard:~# modprobe g_ether
[ 4969.101165]  gadget: using random self ethernet address
[ 4969.106719]  gadget: using random host ethernet address
[ 4969.115814] usb0: MAC d2:12:be:ad:71:e2
[ 4969.119903] usb0: HOST MAC 56:f5:e8:c1:19:e0
[ 4969.125213]  gadget: Ethernet Gadget, version: Memorial Day 2008
[ 4969.132385]  gadget: g_ether ready
[ 4969.136260] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000
[ 4969.144775] pgd =3D da5d4000
[ 4969.147613] [00000000] *pgd=3D99cd2831, *pte=3D00000000, *ppte=3D00000000
[ 4969.154266] Internal error: Oops: 80000007 [#1] SMP
[ 4969.159362] Modules linked in: g_ether(+) ehci_hcd smsc95xx usbnet mii t=
wl6030_usb musb_hdrc omap2430 bnep rfcomm bluetooth rfkill crc16 nfsd nfs l=
ockd fscache auth_rpcgss nfs_acl sunrpc ipv6 rtc_twl omap_wdt leds_gpio ext=
3 jbd mbcache [last unloaded: ohci_hcd]
[ 4969.183746] CPU: 1    Not tainted  (3.1.0-1-omap #1)
[ 4969.188964] PC is at 0x0
[ 4969.191650] LR is at musb_gadget_start+0x64/0x12c [musb_hdrc]
[ 4969.197692] pc : [<00000000>]    lr : [<bf2a92b4>]    psr: 60000193
[ 4969.197692] sp : d9617ec0  ip : 00000010  fp : 00000000
[ 4969.209716] r10: 0000001c  r9 : 00000024  r8 : 00000001
[ 4969.215209] r7 : d95c5920  r6 : 60000113  r5 : da62c104  r4 : da62d0a4
[ 4969.222045] r3 : 00000000  r2 : 00000001  r1 : da62d0a4  r0 : da5696a0
[ 4969.228912] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t user
[ 4969.236480] Control: 10c5387d  Table: 9a5d404a  DAC: 00000015
[ 4969.242492] Process modprobe (pid: 875, stack limit =3D 0xd96162f8)
[ 4969.248901] Stack: (0xd9617ec0 to 0xd9618000)
[ 4969.253479] 7ec0: bf2a9250 d9525c00 00000000 bf30f0d4 d95c5920 c0218254 =
bf30f3f8 bf3129a4
[ 4969.262054] 7ee0: 00000000 c00087dc 00000000 00000001 bf30f3f8 bf30f3f8 =
bf30f440 bf30f3f8
[ 4969.270660] 7f00: bf30f440 00000001 d95c5920 00000001 00000024 c007ac5c =
bf30f404 c00d5f50
[ 4969.279235] 7f20: d9ae7c9c 00000124 c0077e30 c02f969c bf30f554 00a64f28 =
400fe000 dd3de000
[ 4969.287811] 7f40: 0000dac0 dd3e6758 dd3e65d9 dd3e8da0 d9700c00 0000663c =
0000746c 00000000
[ 4969.296386] 7f60: 00000000 00000025 00000026 0000001a 0000001e 00000011 =
00000000 c03e5744
[ 4969.304992] 7f80: 00000000 00000000 00000000 00000000 00000080 c000da68 =
d9616000 00000000
[ 4969.313568] 7fa0: 00a6b0b0 c000d8c0 00000000 00000000 400fe000 0000dac0 =
00a64f28 00000000
[ 4969.322143] 7fc0: 00000000 00000000 00000000 00000080 00000000 00a64f18 =
00a63070 00a6b0b0
[ 4969.330718] 7fe0: 00a64f28 beac396c 0000b935 402d66c4 80000010 400fe000 =
00000000 00000000
[ 4969.339385] [<bf2a92b4>] (musb_gadget_start+0x64/0x12c [musb_hdrc]) from=
 [<c0218254>] (usb_gadget_probe_driver+0xb8/0x168)
[ 4969.350982] [<c0218254>] (usb_gadget_probe_driver+0xb8/0x168) from [<c00=
087dc>] (do_one_initcall+0x90/0x160)
[ 4969.361297] [<c00087dc>] (do_one_initcall+0x90/0x160) from [<c007ac5c>] =
(sys_init_module+0x1854/0x19f8)
[ 4969.371185] [<c007ac5c>] (sys_init_module+0x1854/0x19f8) from [<c000d8c0=
>] (ret_fast_syscall+0x0/0x30)
[ 4969.380950] Code: bad PC value
[ 4969.384185] ---[ end trace 62287d71178ad298 ]---
Segmentation fault


root@pandaboard:~# modprobe g_ether
[   68.920532]  gadget: using random self ethernet address
[   68.926116]  gadget: using random host ethernet address
[   68.933197] usb0: MAC 3e:2d:6b:8c:c2:40
[   68.937225] usb0: HOST MAC d2:02:40:84:39:96
[   68.941833]  gadget: Ethernet Gadget, version: Memorial Day 2008
[   68.950927]  gadget: g_ether ready
[   68.954589] omap_device: musb-omap2430.-1: new worst case activate laten=
cy 0: 61035
[   69.158050] musb-hdrc musb-hdrc: MUSB HDRC host driver
[   69.163879] musb-hdrc musb-hdrc: new USB bus registered, assigned bus nu=
mber 3
[   69.171569] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   69.178710] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   69.186309] usb usb3: Product: MUSB HDRC host driver
[   69.191528] usb usb3: Manufacturer: Linux 3.1.0-1-omap musb-hcd
[   69.197753] usb usb3: SerialNumber: musb-hdrc
[   69.202819] hub 3-0:1.0: USB hub found
[   69.206787] hub 3-0:1.0: 1 port detected
[   69.711425]  gadget: high speed config #1: CDC Ethernet (ECM)
[   69.717498] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000
[   69.725982] pgd =3D c0004000
[   69.728820] [00000000] *pgd=3D00000000
[   69.732574] Internal error: Oops: 5 [#1] SMP
[   69.737030] Modules linked in: g_ether musb_hdrc omap2430 rfcomm bnep bl=
uetooth rfkill crc16 nfsd nfs lockd fscache auth_rpcgss nfs_acl sunrpc ipv6=
 omap_wdt rtc_twl twl6030_usb leds_gpio ext3 jbd mbcache ohci_hcd ehci_hcd
[   69.757781] CPU: 0    Not tainted  (3.1.0-1-omap #1)
[   69.763031] PC is at composite_setup+0x6b0/0xa34 [g_ether]
[   69.768768] LR is at composite_setup+0x630/0xa34 [g_ether]
[   69.774536] pc : [<bf2b7d90>]    lr : [<bf2b7d10>]    psr: 60000093
[   69.774536] sp : c0461e58  ip : d9678160  fp : bf2bb274
[   69.786560] r10: 00000000  r9 : d9dd5260  r8 : 00000000
[   69.792053] r7 : da5cf0a4  r6 : bf2bb274  r5 : d9dd52a8  r4 : da630c60
[   69.798889] r3 : d9dd52a8  r2 : c0461e14  r1 : c03c64d2  r0 : 00000047
[   69.805755] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t kernel
[   69.813507] Control: 10c5387d  Table: 9a65804a  DAC: 00000015
[   69.819549] Process swapper (pid: 0, stack limit =3D 0xc04602f8)
[   69.825653] Stack: (0xc0461e58 to 0xc0462000)
[   69.830230] 1e40:                                                       =
bf2baaf5 c046fd98
[   69.838806] 1e60: d94c1d74 00000000 00000008 da5cf0a4 c0461eec da484040 =
00000010 c08da280
[   69.847381] 1e80: c08dee00 da5ce104 da5ce340 fc0ab100 00000008 fc0ab000 =
00000000 fc0ab100
[   69.855987] 1ea0: 00000000 bf2a5e88 00000000 0900e2a0 00000001 c0460000 =
00000000 da5ce104
[   69.864562] 1ec0: 00000008 00000099 00000099 c0465f00 00000000 bf2a5180 =
da5ce104 00000008
[   69.873168] 1ee0: 00000000 da5ce104 60000093 c0461fac c0465f00 00000000 =
00000000 bf2a52a0
[   69.881744] 1f00: da61c220 0000007c fa240100 c008c0e8 60000093 00000010 =
3c72f18c 00000000
[   69.890350] 1f20: 411fc092 c0465f00 c0465f54 fa240100 c0461fac 8000406a =
411fc092 00000000
[   69.898925] 1f40: 00000000 c008c2c0 c0465f00 00000000 fa240100 c008e5c0 =
0000007c c008ba60
[   69.907501] 1f60: 0000019a c000e7c8 c000ea0c c000ea10 60000013 c000d3b8 =
00000000 00000000
[   69.916076] 1f80: c0461fc0 00000000 c0460000 c04c6b84 c02f6570 c047329c =
8000406a 411fc092
[   69.924682] 1fa0: 00000000 00000000 60000013 c0461fc0 c000ea0c c000ea10 =
60000013 ffffffff
[   69.933258] 1fc0: c000e9ec c000ebe4 c046fbb4 00000000 c08d7920 c041f790 =
c041f1bc 00000ae7
[   69.941833] 1fe0: 80000100 c044cefc 10c5387d c046ef8c c044cef8 80008040 =
00000000 00000000
[   69.950500] [<bf2b7d90>] (composite_setup+0x6b0/0xa34 [g_ether]) from [<=
bf2a5e88>] (musb_g_ep0_irq+0x7c8/0x888 [musb_hdrc])
[   69.962188] [<bf2a5e88>] (musb_g_ep0_irq+0x7c8/0x888 [musb_hdrc]) from [=
<bf2a5180>] (musb_interrupt+0x710/0x7d8 [musb_hdrc])
[   69.973968] [<bf2a5180>] (musb_interrupt+0x710/0x7d8 [musb_hdrc]) from [=
<bf2a52a0>] (generic_interrupt+0x58/0x70 [musb_hdrc])
[   69.985900] [<bf2a52a0>] (generic_interrupt+0x58/0x70 [musb_hdrc]) from =
[<c008c0e8>] (handle_irq_event_percpu+0x7c/0x214)
[   69.997406] [<c008c0e8>] (handle_irq_event_percpu+0x7c/0x214) from [<c00=
8c2c0>] (handle_irq_event+0x40/0x60)
[   70.007720] [<c008c2c0>] (handle_irq_event+0x40/0x60) from [<c008e5c0>] =
(handle_fasteoi_irq+0xc4/0x10c)
[   70.017578] [<c008e5c0>] (handle_fasteoi_irq+0xc4/0x10c) from [<c008ba60=
>] (generic_handle_irq+0x2c/0x40)
[   70.027648] [<c008ba60>] (generic_handle_irq+0x2c/0x40) from [<c000e7c8>=
] (handle_IRQ+0x78/0xb8)
[   70.036865] [<c000e7c8>] (handle_IRQ+0x78/0xb8) from [<c000d3b8>] (__irq=
_svc+0x38/0x100)
[   70.045379] [<c000d3b8>] (__irq_svc+0x38/0x100) from [<c000ea10>] (defau=
lt_idle+0x24/0x28)
[   70.054046] [<c000ea10>] (default_idle+0x24/0x28) from [<c000ebe4>] (cpu=
_idle+0x8c/0xe4)
[   70.062561] [<c000ebe4>] (cpu_idle+0x8c/0xe4) from [<c041f790>] (start_k=
ernel+0x2b8/0x310)
[   70.071228] Code: e18201a1 e1a01005 eb3b96f4 e59dc008 (e4982004)=20
[   70.077606] ---[ end trace fe6fb50eed7e07a8 ]---
[   70.082458] Kernel panic - not syncing: Fatal exception in interrupt
[   70.089141] [<c001410c>] (unwind_backtrace+0x0/0xe0) from [<c02ec168>] (=
panic+0x50/0x190)
[   70.097717] [<c02ec168>] (panic+0x50/0x190) from [<c00116d4>] (die+0x2ac=
/0x2fc)
[   70.105407] [<c00116d4>] (die+0x2ac/0x2fc) from [<c02ebef8>] (__do_kerne=
l_fault.part.3+0x54/0x74)
[   70.114746] [<c02ebef8>] (__do_kernel_fault.part.3+0x54/0x74) from [<c00=
16d14>] (do_page_fault+0x278/0x294)
[   70.124969] [<c0016d14>] (do_page_fault+0x278/0x294) from [<c0008624>] (=
do_DataAbort+0x34/0x98)
[   70.134094] [<c0008624>] (do_DataAbort+0x34/0x98) from [<c000d358>] (__d=
abt_svc+0x38/0x60)
[   70.142761] Exception stack(0xc0461e10 to 0xc0461e58)
[   70.148071] 1e00:                                     00000047 c03c64d2 =
c0461e14 d9dd52a8
[   70.156646] 1e20: da630c60 d9dd52a8 bf2bb274 da5cf0a4 00000000 d9dd5260 =
00000000 bf2bb274
[   70.165222] 1e40: d9678160 c0461e58 bf2b7d10 bf2b7d90 60000093 ffffffff
[   70.172180] [<c000d358>] (__dabt_svc+0x38/0x60) from [<bf2b7d90>] (compo=
site_setup+0x6b0/0xa34 [g_ether])
[   70.182250] [<bf2b7d90>] (composite_setup+0x6b0/0xa34 [g_ether]) from [<=
bf2a5e88>] (musb_g_ep0_irq+0x7c8/0x888 [musb_hdrc])
[   70.193939] [<bf2a5e88>] (musb_g_ep0_irq+0x7c8/0x888 [musb_hdrc]) from [=
<bf2a5180>] (musb_interrupt+0x710/0x7d8 [musb_hdrc])
[   70.205718] [<bf2a5180>] (musb_interrupt+0x710/0x7d8 [musb_hdrc]) from [=
<bf2a52a0>] (generic_interrupt+0x58/0x70 [musb_hdrc])
[   70.217590] [<bf2a52a0>] (generic_interrupt+0x58/0x70 [musb_hdrc]) from =
[<c008c0e8>] (handle_irq_event_percpu+0x7c/0x214)
[   70.229095] [<c008c0e8>] (handle_irq_event_percpu+0x7c/0x214) from [<c00=
8c2c0>] (handle_irq_event+0x40/0x60)
[   70.239410] [<c008c2c0>] (handle_irq_event+0x40/0x60) from [<c008e5c0>] =
(handle_fasteoi_irq+0xc4/0x10c)
[   70.249267] [<c008e5c0>] (handle_fasteoi_irq+0xc4/0x10c) from [<c008ba60=
>] (generic_handle_irq+0x2c/0x40)
[   70.259338] [<c008ba60>] (generic_handle_irq+0x2c/0x40) from [<c000e7c8>=
] (handle_IRQ+0x78/0xb8)
[   70.268554] [<c000e7c8>] (handle_IRQ+0x78/0xb8) from [<c000d3b8>] (__irq=
_svc+0x38/0x100)
[   70.277038] [<c000d3b8>] (__irq_svc+0x38/0x100) from [<c000ea10>] (defau=
lt_idle+0x24/0x28)
[   70.285705] [<c000ea10>] (default_idle+0x24/0x28) from [<c000ebe4>] (cpu=
_idle+0x8c/0xe4)
[   70.294219] [<c000ebe4>] (cpu_idle+0x8c/0xe4) from [<c041f790>] (start_k=
ernel+0x2b8/0x310)
[   70.302917] CPU1: stopping
[   70.305755] [<c001410c>] (unwind_backtrace+0x0/0xe0) from [<c0008578>] (=
do_IPI+0xc0/0x138)
[   70.314422] [<c0008578>] (do_IPI+0xc0/0x138) from [<c000d3b8>] (__irq_sv=
c+0x38/0x100)
[   70.322631] Exception stack(0xda469f98 to 0xda469fe0)
[   70.327941] 9f80:                                                       =
00000000 00000000
[   70.336517] 9fa0: da469fe0 00000000 da468000 c04c6b84 c02f6570 c04c6d18 =
8000406a 411fc092
[   70.345123] 9fc0: 00000000 00000000 60000113 da469fe0 c000ea0c c000ea10 =
60000113 ffffffff
[   70.353698] [<c000d3b8>] (__irq_svc+0x38/0x100) from [<c000ea10>] (defau=
lt_idle+0x24/0x28)
[   70.362365] [<c000ea10>] (default_idle+0x24/0x28) from [<c000ebe4>] (cpu=
_idle+0x8c/0xe4)
[   70.370880] [<c000ebe4>] (cpu_idle+0x8c/0xe4) from [<802e8654>] (0x802e8=
654)

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO08otAAoJENju1/PIO/qaRbEP/1YShb08WMyoKwcURFGHFIbd
YjC0Z+ovPxUA+mCpkN63jd1Z2WH4W1oqkySVmed1mz9Bq+Kh47ugOld7VCvXVpn/
KcywhoAvgb4zjDhz9/orNshRU5mIZ1i7SG4b381HBToaCc9pqMQxF6g17vms8oYy
xbdroI/ZjX/2kc0Il2saUuVElRJnpPTx2Y3VFDhfIDo4TVyXHDvSLc2Lwnq5iFRO
PotR5rcCdwF+E4TjfbMoUFSDpwxnEJ2+Z8dXRcRUEWd4+yFs7YCg9Tj3/+daUVat
HCUjdIgcmHARJls++gflbViHtBWpX0olcuFGf9IWs2ilLlZmKC0b3WHdvDmBd+HI
reWzMKysnYGve2J5qcsJu6bbwFkyI9+W7Gy33bG7GPGNySDIaQVgTnkgoVXKDBTN
POaZ/aB8s5OoQYTCRYeX4UK9CXqwLvKYxg8Q6nF/HAaquITSdJE+rGN+TxaDOTAA
wzf2hokjqp3vzSgt0O98cF1UKROULcbEHew0vjcxHGoX1j1Zb0olut1dII2RmAyh
3eGPROOXMRX6I+Ne/x4/ag6YEG4y5fGwabmrIQ8k3oEEDQeL/wpiGg0jIp6WsY4/
yUCedlG2MteaC1bKwwGVLFu93OakxNNzv5V/KujHw8yeeMqdXj0GGs62FFT3otww
9W1L2KR+aIkWXRE92iHT
=tyDR
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
