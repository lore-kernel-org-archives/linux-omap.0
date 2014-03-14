From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 12:19:16 +0200
Message-ID: <5322D7A4.4090602@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <20140313174623.GD25870@e106331-lin.cambridge.arm.com> <5321F77E.9000302@ti.com> <20140314091002.GG25870@e106331-lin.cambridge.arm.com> <5322CF02.4060705@ti.com> <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="RpldU5RKA2MKLTrwUffJPcL0wQEX04Swq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48744 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbaCNKT1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 06:19:27 -0400
In-Reply-To: <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--RpldU5RKA2MKLTrwUffJPcL0wQEX04Swq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 12:14, Mark Rutland wrote:

> I can't see anything obviously wrong in platform_device_del. Do you hav=
e
> a backtrace?

Yes, below.

I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact same th=
ing
I do, so maybe I've got something wrong with the omapdss driver.

 Tomi

[   62.987335] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000018
[   62.995910] pgd =3D eb6b8000
[   62.998779] [00000018] *pgd=3Daa127831, *pte=3D00000000, *ppte=3D00000=
000
[   63.005462] Internal error: Oops: 17 [#1] SMP ARM
[   63.005462] Modules linked in: omapdss(-) [last unloaded: encoder_tfp4=
10]
[   63.011779] CPU: 1 PID: 1021 Comm: rmmod Not tainted 3.14.0-rc2-00057-=
gacd3401a1fea-dirty #69
[   63.025909] task: eb17a040 ti: ea14e000 task.ti: ea14e000
[   63.032287] PC is at release_resource+0x1c/0x84
[   63.032287] LR is at _raw_write_lock+0x50/0x58
[   63.041748] pc : [<c004adc8>]    lr : [<c05bbd5c>]    psr: 60000113
[   63.041748] sp : ea14fde0  ip : ea14fdb8  fp : ea14fdf4
[   63.053833] r10: 00000000  r9 : ea14e000  r8 : c000f704
[   63.053833] r7 : 00000081  r6 : bf0004fc  r5 : eb714400  r4 : eb6a9600=

[   63.061798] r3 : 00000000  r2 : 00000001  r1 : 00000011  r0 : c08cec3c=

[   63.071746] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
[   63.071746] Control: 10c53c7d  Table: ab6b804a  DAC: 00000015
[   63.081787] Process rmmod (pid: 1021, stack limit =3D 0xea14e248)
[   63.091735] Stack: (0xea14fde0 to 0xea150000)
[   63.093109] fde0: 00000001 eb714400 ea14fe0c ea14fdf8 c03953dc c004adb=
8 eb714400 00000000
[   63.101806] fe00: ea14fe24 ea14fe10 c0395808 c0395374 eb17a040 eb71440=
0 ea14fe3c ea14fe28
[   63.114715] fe20: bf000530 c0395800 eb714410 00000000 ea14fe64 ea14fe4=
0 c038fa5c bf000508
[   63.121795] fe40: eb214b80 eb6a9d30 ea14fe7c eb204410 bf032d98 eb20444=
4 ea14fe7c ea14fe68
[   63.123352] fe60: bf022574 c038fa2c bf02254c eb204410 ea14fe8c ea14fe8=
0 c0395080 bf022558
[   63.140136] fe80: ea14fea4 ea14fe90 c0393494 c039506c eb204410 bf032d9=
8 ea14fec4 ea14fea8
[   63.149200] fea0: c0393efc c0393428 00000000 bf032d98 bf034438 bf0342b=
8 ea14fedc ea14fec8
[   63.154327] fec0: c0393244 c0393e4c eb6fa300 bf032d98 ea14fef4 ea14fee=
0 c0394570 c03931ec
[   63.166442] fee0: bf022800 00000005 ea14ff04 ea14fef8 c03951d0 c039454=
c ea14ff14 ea14ff08
[   63.175048] ff00: bf0010e8 c03951c8 ea14ff34 ea14ff18 bf022534 bf0010e=
0 bf0224f4 00000000
[   63.183685] ff20: bf0342d0 00000880 ea14ffa4 ea14ff38 c00b7f50 bf02250=
0 c000f564 00000000
[   63.183685] ff40: bf0342d0 00000880 ea14ff3c 70616d6f 00737364 00088ec=
9 ea14ff84 ea14ff68
[   63.200927] ff60: c008fff0 c008fdd8 0001cec8 70616d6f 00737364 0000008=
1 ea14ff94 ea14ff88
[   63.209533] ff80: c00900dc 0008ff08 00000000 0001cec8 70616d6f 0073736=
4 00000000 ea14ffa8
[   63.218170] ffa0: c000f540 c00b7e0c 0001cec8 70616d6f bea28b10 0000088=
0 bea28b10 00000880
[   63.226776] ffc0: 0001cec8 70616d6f 00737364 00000081 000acc00 0000004=
2 00088ec9 00000000
[   63.234619] ffe0: bea28b08 bea28af8 0001cda4 b6ed3390 60000110 bea28b1=
0 00000000 00000000
[   63.234619] Backtrace:=20
[   63.246612] [<c004adac>] (release_resource) from [<c03953dc>] (platfor=
m_device_del+0x74/0xa4)
[   63.246612]  r5:eb714400 r4:00000001
[   63.246612] [<c0395368>] (platform_device_del) from [<c0395808>] (plat=
form_device_unregister+0x14/0x20)
[   63.267150]  r5:00000000 r4:eb714400
[   63.273223] [<c03957f4>] (platform_device_unregister) from [<bf000530>=
] (dss_uninit_submodule_dev+0x34/0x40 [omapdss])
[   63.281799]  r4:eb714400 r3:eb17a040
[   63.281799] [<bf0004fc>] (dss_uninit_submodule_dev [omapdss]) from [<c=
038fa5c>] (device_for_each_child+0x3c/0x7c)
[   63.291839]  r4:00000000 r3:eb714410
[   63.303070] [<c038fa20>] (device_for_each_child) from [<bf022574>] (om=
ap_dsshw_remove+0x28/0x70 [omapdss])
[   63.312255]  r6:eb204444 r5:bf032d98 r4:eb204410
[   63.318237] [<bf02254c>] (omap_dsshw_remove [omapdss]) from [<c0395080=
>] (platform_drv_remove+0x20/0x24)
[   63.321807]  r4:eb204410 r3:bf02254c
[   63.331848] [<c0395060>] (platform_drv_remove) from [<c0393494>] (__de=
vice_release_driver+0x78/0xd0)
[   63.341644] [<c039341c>] (__device_release_driver) from [<c0393efc>] (=
driver_detach+0xbc/0xc0)
[   63.350708]  r5:bf032d98 r4:eb204410
[   63.352874] [<c0393e40>] (driver_detach) from [<c0393244>] (bus_remove=
_driver+0x64/0xcc)
[   63.352874]  r6:bf0342b8 r5:bf034438 r4:bf032d98 r3:00000000
[   63.369018] [<c03931e0>] (bus_remove_driver) from [<c0394570>] (driver=
_unregister+0x30/0x50)
[   63.372894]  r4:bf032d98 r3:eb6fa300
[   63.381713] [<c0394540>] (driver_unregister) from [<c03951d0>] (platfo=
rm_driver_unregister+0x14/0x18)
[   63.391418]  r4:00000005 r3:bf022800
[   63.391845] [<c03951bc>] (platform_driver_unregister) from [<bf0010e8>=
] (dss_uninit_platform_driver+0x14/0x1c [omapdss])
[   63.401794] [<bf0010d4>] (dss_uninit_platform_driver [omapdss]) from [=
<bf022534>] (omap_dss_exit+0x40/0x58 [omapdss])
[   63.406951] [<bf0224f4>] (omap_dss_exit [omapdss]) from [<c00b7f50>] (=
SyS_delete_module+0x150/0x1e0)
[   63.421844]  r6:00000880 r5:bf0342d0 r4:00000000 r3:bf0224f4
[   63.431793] [<c00b7e00>] (SyS_delete_module) from [<c000f540>] (ret_fa=
st_syscall+0x0/0x48)
[   63.431793]  r6:00737364 r5:70616d6f r4:0001cec8
[   63.447448] Code: e1a04000 e59f0068 eb15c3d1 e5943010 (e5932018)=20
[   63.453918] ---[ end trace 9bdaba0cecbfc6c4 ]---



--RpldU5RKA2MKLTrwUffJPcL0wQEX04Swq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTItekAAoJEPo9qoy8lh71InsP/jKIBoGFvdHPODW7QTDNCFOp
iBVbXHLldm7GJzWkyyxNervk7pSsNsmsdWnGjFZnW194BGjkgF52m93dUn3ab3Xi
qI+MtbnLr+5tg1Ngqk+0LsLeDAzpTCNJm2qyNtwh5U+Uf5+VYvoIv0bWDgkR0dpG
WCvsyzCQNcGKAwppFrIMnBNKcS8DaZwnVTuyJx2iZxcC0mf+/7gdLYQcs/NZPTH1
0mC335EKtYWHzhUkleO8+l8SYILDiW2friMRTRsSaca6FUcQilH3GncWI8OvZeNH
+DuL7xsKA5gkXd+AV+nLxhSk7pPCVWyfDllxRXyOhp2JoGDrlP+oHP/W0fl6uFhc
1iO9LaJ9pZQabI/uyDdYP+uIT1rmudoP11py66PtyruwhM/fxImIL9QQoQT0QGJP
1uctXtv93NUIqhwb5Ix3HSlAlPP8G+4euuGz7x3OTXKgqHYrKpcE9Cz2ckv821mb
c6bJkpU2z/2nV8Tc3BibTwRuOcSkYhFGxf76U40tEdoB9+pIQQgUdvLM8iEl3Ipe
Ci1vVtblWgw3dQ//kAeZ5Eb4LVixJDNcQWXZx7OqEnSyLss2tMzbxlVz/WgbXt0O
ih36nygM/wond/6LRO2nfa0rpGe041HiAAODXpv6YiU35IG99omB+ugBN3FOqd5f
MEqVBZOJu5FGZtpUuxGw
=mSuG
-----END PGP SIGNATURE-----

--RpldU5RKA2MKLTrwUffJPcL0wQEX04Swq--
