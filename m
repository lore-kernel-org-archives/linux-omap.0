From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Fri, 09 Mar 2012 13:14:01 +0200
Message-ID: <1331291641.1927.38.camel@deskari>
References: <87r4x27gh0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-15TNUkcIT0mEuM/mogrv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53921 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752073Ab2CILOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 06:14:06 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so1894381lag.2
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 03:14:04 -0800 (PST)
In-Reply-To: <87r4x27gh0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>


--=-15TNUkcIT0mEuM/mogrv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 16:42 -0800, Kevin Hilman wrote:
> Hi Tomi,
>=20
> A while ago you were asking about why DSS pwrdm counts were so high on
> OMAP3, and why DSS was transitioning even though it was completely
> unused. Paul and I just spent some a little time debugging this, and
> narrowed it down to autodeps. (sorry it took so long, it finally
> bothered me enough to actually look into it.)
>=20
> The patch below fixes the problem at least when DSS is not loaded (DSS
> just stays in retention), but I didn't try this with any active DSS
> usage, or loading/unloding the DSS drivers.
>=20
> Could you give the patch below a try on OMAP3 along with some active DSS
> usage as well as unloading the modules after using.  Could you also
> verify that suspend/resume continues to work for DSS?

I didn't get very far with the patch =3D(. Tested on omap3 overo, with
-rc6 based dss tree.

loading nfs/work/linux/drivers/video/omap2/dss/omapdss.ko def_disp=3Dlcd43
[   20.772460] cm: Module associated with clock dss1_alwon_fck didn't enabl=
e in 100000 tries
[   20.784210] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa050040
[   20.792297] Internal error: : 1028 [#1] SMP
[   20.796722] Modules linked in: omapdss(+)
[   20.800994] CPU: 0    Not tainted  (3.3.0-rc6-00050-g53306db-dirty #113)
[   20.808288] PC is at omap_dsshw_probe+0xb0/0x22c [omapdss]
[   20.814086] LR is at trace_hardirqs_on_caller+0xec/0x198
[   20.819702] pc : [<bf001464>]    lr : [<c0089c7c>]    psr: 60000013
[   20.819702] sp : ce89bd60  ip : 60000093  fp : 00005b8e
[   20.831787] r10: bf03d000  r9 : c0bdc558  r8 : bf029884
[   20.837310] r7 : 00000000  r6 : 00000000  r5 : cf094008  r4 : bf02a0e8
[   20.844177] r3 : fa050000  r2 : 00000000  r1 : 00000001  r0 : 00000000
[   20.851074] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 user
[   20.858581] Control: 10c5387d  Table: 8e8b4019  DAC: 00000015
[   20.864624] Process insmod (pid: 673, stack limit =3D 0xce89a2f8)
[   20.870880] Stack: (0xce89bd60 to 0xce89c000)
[   20.875488] bd60: cf094008 c0c13d98 cf09403c c027f08c c027f074 c027de74 =
cf094008 bf029884
[   20.884094] bd80: cf09403c 00000000 bf0297c4 c027e010 bf029884 c027df7c =
00000000 c027c928
[   20.892730] bda0: cf0196a8 cf082510 bf029884 c06b1260 cea54f40 c027d860 =
bf01fc50 c022da38
[   20.901336] bdc0: cf019600 bf029884 bf02a0c4 c0688154 00000000 bf0297c4 =
bf03d000 c027e4d4
[   20.909973] bde0: c065ca18 bf02a0c4 c0688154 00000000 bf0297c4 bf0002a0 =
cf0c3900 00000000
[   20.918609] be00: c0c13d98 c065ca20 c0c13d98 c065ca54 00000000 bf0297c4 =
c0bdc558 bf03d000
[   20.927215] be20: 00005b8e c027f08c c027f074 c027de74 c065ca20 bf0297c4 =
c065ca54 00000000
[   20.935852] be40: 00000001 c027e010 bf0297c4 c027df7c 00000000 c027c928 =
cf0196a8 cf082210
[   20.944458] be60: bf0297c4 c06b1260 cf3f91c0 c027d860 bf01f5a4 c022da38 =
cf019600 bf0297c4
[   20.953094] be80: ce89a000 c06c9800 00000000 00000001 bf03d000 c027e4d4 =
00000000 ce89a000
[   20.961700] bea0: c06c9800 00000000 00000001 bf03d074 bf029f5c c0008648 =
c069e1d4 bf029f5c
[   20.970336] bec0: 00000001 bf03d000 00000001 c069e1d0 00000000 c006325c =
00000000 cf004400
[   20.978973] bee0: ce8c5640 bf029f5c bf029fa4 00000001 ce825940 00000001 =
c0bdc558 bf029f5c
[   20.987579] bf00: 00005b8e c0092af0 bf029f68 cf37d8e0 c078db40 c00907b8 =
00000000 bf0263ec
[   20.996215] bf20: bf03b311 bf029f68 d08ca000 0019725a d09e9aec d09e987e =
d0a5b6cc 0002b968
[   21.004821] bf40: 00035448 00000000 00000000 0000003c 0000003d 00000024 =
00000028 00000016
[   21.013458] bf60: 00000000 bf01d7b8 00000041 00000000 00000000 00000000 =
00000000 c05b198c
[   21.022064] bf80: be83ee84 0019725a 00000003 be83ee84 00000080 c0013068 =
ce89a000 00000000
[   21.030700] bfa0: 00000000 c0012ea0 0019725a 00000003 b6cf4008 0019725a =
000a7008 be83ee84
[   21.039306] bfc0: 0019725a 00000003 be83ee84 00000080 000a47f8 00000000 =
b6fd0000 00000000
[   21.047943] bfe0: be83ebc8 be83ebb8 00019dfc b6f60020 60000010 b6cf4008 =
8f4fe821 8f4fec21
[   21.056701] [<bf001464>] (omap_dsshw_probe+0xb0/0x22c [omapdss]) from [<=
c027f08c>] (platform_drv_
probe+0x18/0x1c)
[   21.067535] [<c027f08c>] (platform_drv_probe+0x18/0x1c) from [<c027de74>=
] (driver_probe_device+0x
90/0x198)
[   21.077728] [<c027de74>] (driver_probe_device+0x90/0x198) from [<c027e01=
0>] (__driver_attach+0x94
/0x98)
[   21.087646] [<c027e010>] (__driver_attach+0x94/0x98) from [<c027c928>] (=
bus_for_each_dev+0x50/0x7
c)
[   21.097167] [<c027c928>] (bus_for_each_dev+0x50/0x7c) from [<c027d860>] =
(bus_add_driver+0x184/0x2
48)
[   21.106811] [<c027d860>] (bus_add_driver+0x184/0x248) from [<c027e4d4>] =
(driver_register+0x78/0x1
30)
[   21.116516] [<c027e4d4>] (driver_register+0x78/0x130) from [<bf0002a0>] =
(omap_dss_probe+0x34/0x32
c [omapdss])
[   21.127075] [<bf0002a0>] (omap_dss_probe+0x34/0x32c [omapdss]) from [<c0=
27f08c>] (platform_drv_pr
obe+0x18/0x1c)
[   21.137725] [<c027f08c>] (platform_drv_probe+0x18/0x1c) from [<c027de74>=
] (driver_probe_device+0x
90/0x198)
[   21.147888] [<c027de74>] (driver_probe_device+0x90/0x198) from [<c027e01=
0>] (__driver_attach+0x94
/0x98)
[   21.157806] [<c027e010>] (__driver_attach+0x94/0x98) from [<c027c928>] (=
bus_for_each_dev+0x50/0x7
c)
[   21.167358] [<c027c928>] (bus_for_each_dev+0x50/0x7c) from [<c027d860>] =
(bus_add_driver+0x184/0x2
48)
[   21.176971] [<c027d860>] (bus_add_driver+0x184/0x248) from [<c027e4d4>] =
(driver_register+0x78/0x1
30)
[   21.186706] [<c027e4d4>] (driver_register+0x78/0x130) from [<bf03d074>] =
(omap_dss_init+0x74/0x9c=20
[omapdss])
[   21.197082] [<bf03d074>] (omap_dss_init+0x74/0x9c [omapdss]) from [<c000=
8648>] (do_one_initcall+0
x34/0x178)
[   21.207397] [<c0008648>] (do_one_initcall+0x34/0x178) from [<c0092af0>] =
(sys_init_module+0xdc0/0x
1b80)
[   21.217224] [<c0092af0>] (sys_init_module+0xdc0/0x1b80) from [<c0012ea0>=
] (ret_fast_syscall+0x0/0
x3c)
[   21.226928] Code: 1a00001b e5943004 e584602c e5846030 (e5932040)=20
[   21.233398] ------------[ cut here ]------------
[   21.238281] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:161 omap3_l3_a=
pp_irq+0xd0/0x128()
[   21.247070] In-band Error seen by MPU  at address 0
[   21.252197] Modules linked in: omapdss(+)
[   21.256500] [<c001a1f8>] (unwind_backtrace+0x0/0xf0) from [<c003e688>] (=
warn_slowpath_common+0x4c
/0x64)
[   21.266387] [<c003e688>] (warn_slowpath_common+0x4c/0x64) from [<c003e73=
4>] (warn_slowpath_fmt+0x
30/0x40)
[   21.276489] [<c003e734>] (warn_slowpath_fmt+0x30/0x40) from [<c0030c30>]=
 (omap3_l3_app_irq+0xd0/0
x128)
[   21.286315] [<c0030c30>] (omap3_l3_app_irq+0xd0/0x128) from [<c0097d90>]=
 (handle_irq_event_percpu
+0x58/0x244)
[   21.296783] [<c0097d90>] (handle_irq_event_percpu+0x58/0x244) from [<c00=
97fb8>] (handle_irq_event
+0x3c/0x5c)
[   21.307128] [<c0097fb8>] (handle_irq_event+0x3c/0x5c) from [<c009a618>] =
(handle_level_irq+0xac/0x
fc)
[   21.316802] [<c009a618>] (handle_level_irq+0xac/0xfc) from [<c00975e8>] =
(generic_handle_irq+0x30/
0x48)
[   21.326690] [<c00975e8>] (generic_handle_irq+0x30/0x48) from [<c0013db8>=
] (handle_IRQ+0x4c/0xac)
[   21.335937] [<c0013db8>] (handle_IRQ+0x4c/0xac) from [<c0008598>] (omap3=
_intc_handle_irq+0x44/0x4
c)
[   21.345489] [<c0008598>] (omap3_intc_handle_irq+0x44/0x4c) from [<c04349=
a4>] (__irq_svc+0x44/0x60
)
[   21.354919] Exception stack(0xce89bbb8 to 0xce89bc00)
[   21.360260] bba0:                                                       =
c04346d0 cf37d480
[   21.368896] bbc0: 00000000 00000080 c065ace4 ce89a000 00000001 ce89bc4a =
00000001 00000000
[   21.377502] bbe0: bf001466 bf001468 00000000 ce89bc00 c04346d0 c04346d4 =
60000113 ffffffff
[   21.386138] [<c04349a4>] (__irq_svc+0x44/0x60) from [<c04346d4>] (_raw_s=
pin_unlock_irq+0x28/0x2c)
[   21.395507] [<c04346d4>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c0016cd=
0>] (die+0xe0/0x330)
[   21.404388] [<c0016cd0>] (die+0xe0/0x330) from [<c00083b4>] (do_DataAbor=
t+0x8c/0x9c)
[   21.412567] [<c00083b4>] (do_DataAbort+0x8c/0x9c) from [<c0434924>] (__d=
abt_svc+0x44/0x80)
[   21.421264] Exception stack(0xce89bd18 to 0xce89bd60)
[   21.426605] bd00:                                                       =
00000000 00000001
[   21.435211] bd20: 00000000 fa050000 bf02a0e8 cf094008 00000000 00000000 =
bf029884 c0bdc558
[   21.443847] bd40: bf03d000 00005b8e 60000093 ce89bd60 c0089c7c bf001464 =
60000013 ffffffff
[   21.452575] [<c0434924>] (__dabt_svc+0x44/0x80) from [<bf001464>] (omap_=
dsshw_probe+0xb0/0x22c [o
mapdss])
[   21.462799] [<bf001464>] (omap_dsshw_probe+0xb0/0x22c [omapdss]) from [<=
c027f08c>] (platform_drv_
probe+0x18/0x1c)
[   21.473632] [<c027f08c>] (platform_drv_probe+0x18/0x1c) from [<c027de74>=
] (driver_probe_device+0x
90/0x198)
[   21.483825] [<c027de74>] (driver_probe_device+0x90/0x198) from [<c027e01=
0>] (__driver_attach+0x94
/0x98)
[   21.493743] [<c027e010>] (__driver_attach+0x94/0x98) from [<c027c928>] (=
bus_for_each_dev+0x50/0x7
c)
[   21.503265] [<c027c928>] (bus_for_each_dev+0x50/0x7c) from [<c027d860>] =
(bus_add_driver+0x184/0x2
48)
[   21.512908] [<c027d860>] (bus_add_driver+0x184/0x248) from [<c027e4d4>] =
(driver_register+0x78/0x1
30)
[   21.522613] [<c027e4d4>] (driver_register+0x78/0x130) from [<bf0002a0>] =
(omap_dss_probe+0x34/0x32
c [omapdss])
[   21.533172] [<bf0002a0>] (omap_dss_probe+0x34/0x32c [omapdss]) from [<c0=
27f08c>] (platform_drv_pr
obe+0x18/0x1c)
[   21.543823] [<c027f08c>] (platform_drv_probe+0x18/0x1c) from [<c027de74>=
] (driver_probe_device+0x
90/0x198)
[   21.553985] [<c027de74>] (driver_probe_device+0x90/0x198) from [<c027e01=
0>] (__driver_attach+0x94
/0x98)
[   21.563903] [<c027e010>] (__driver_attach+0x94/0x98) from [<c027c928>] (=
bus_for_each_dev+0x50/0x7
c)
[   21.573455] [<c027c928>] (bus_for_each_dev+0x50/0x7c) from [<c027d860>] =
(bus_add_driver+0x184/0x2
48)
[   21.583068] [<c027d860>] (bus_add_driver+0x184/0x248) from [<c027e4d4>] =
(driver_register+0x78/0x1
30)
[   21.592803] [<c027e4d4>] (driver_register+0x78/0x130) from [<bf03d074>] =
(omap_dss_init+0x74/0x9c=20
[omapdss])
[   21.603179] [<bf03d074>] (omap_dss_init+0x74/0x9c [omapdss]) from [<c000=
8648>] (do_one_initcall+0
x34/0x178)
[   21.613464] [<c0008648>] (do_one_initcall+0x34/0x178) from [<c0092af0>] =
(sys_init_module+0xdc0/0x
1b80)
[   21.623291] [<c0092af0>] (sys_init_module+0xdc0/0x1b80) from [<c0012ea0>=
] (ret_fast_syscall+0x0/0
x3c)
[   21.632995] ---[ end trace 4a796654c8f7b234 ]---
[   21.638000] ---[ end trace 4a796654c8f7b235 ]---
Segmentation fault


--=-15TNUkcIT0mEuM/mogrv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWeX5AAoJEPo9qoy8lh71yD8QAIbvzRtbFkpjUXikO050xvpb
S/RREnl81JHXAh7XIaqf5g2/bl2ChTNtK7EOwWJKeI1WMI3A0G5/oosK2WY9voes
6mqa1RMnoDjzCqIGEicUoMcJSbEmuOER9f37il3sfeh9cooQS5pxrgmDy6svul1d
lk7bxshwTPP0ZXOPj8SgYnfIT6xgboIdhy/1OBZTa6Og3iLO3tYnFyxlR93UioZU
iVYk+/rkzKkHdgcTCv5EraA0ZZWWxC32j/61MMUgcjfHMeKI+eS6pfWh8Hk2+0V7
Ly0A8SXvJaYGXNEVCgxZMiKWepA6S60AmPCv7a7ne1Ebm4fcnfYvGrGpptLpr4F/
MKvNCKOer6fgIjOyWeJ/8gay2Se4g3guQuLngJVXoPNSfOJHP21kMZZHt8eZUHvE
5CeEM1SGQSqgLkB5fy1l+qyOgkg7cwrbQx1OegkZ5vH1grFRpY2K4OTrzUn0mCJK
75C9cDoqqSXcjs46cDk6wxLm1GvKSEpyRyifxm8dJV/Uvv2HG7hakEuyOMXEkIyo
xYoJFdEKRnBkOSPB8CyYHets6otte71sUwf0Ati60ECYerSAqtCZbA0YnXOXhpgm
wEtUfpQ7WKH/OFUfpJ1eozybPnMAxBjljpd8MnSMRXfvcwhNwYu4psq8fWE014QF
BdOKHmyEL+crwQPvsGAL
=Ry7d
-----END PGP SIGNATURE-----

--=-15TNUkcIT0mEuM/mogrv--

