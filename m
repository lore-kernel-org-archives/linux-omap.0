From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 15:56:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com> <4CFE9059.1080202@nokia.com> <AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-129514236-1291762597=:13430"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58155 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0LGW4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 17:56:38 -0500
In-Reply-To: <AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-129514236-1291762597=:13430
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 7 Dec 2010, Chikkature Rajashekar, Madhusudhan wrote:

> On Tue, Dec 7, 2010 at 1:51 PM, Adrian Hunter <adrian.hunter@nokia.com> w=
rote:
> >
> > It is at least because omap_pm_get_dev_context_loss_count() is not
> > implemented. =A0Tero Kristo was looking at that recently.
> >
>=20
> Yes. I agree that is the problem. In the .32 kernel I had hooked it to
> "get_last_off_on_transaction_id" which helped.
> But that functionality does not exist anymore. So something equivalent
> to tell the driver when the OFF was hit will make it work.

OK, let's see if we can get that fixed in at least some trivial=20
way for 2.6.38.  While working on this, I applied this trivial patch:

diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm=
-noop.c
index e129ce8..781aa5f 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -30,6 +30,8 @@ struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
 struct omap_opp *l3_opps;
=20
+static int dummy_context_loss_counter;
+
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
@@ -303,7 +305,7 @@ int omap_pm_get_dev_context_loss_count(struct device *d=
ev)
 =09 * off counter.
 =09 */
=20
-=09return 0;
+=09return dummy_context_loss_counter++;
 }
=20
=20

=2E.. which causes drivers to believe that device context has been lost=20
after each call to omap_pm_get_dev_context_loss_count().  Brutal, but=20
effective for chasing out context save/restore bugs.  This patch causes an=
=20
abort in the MMC driver with the current linux-omap master:

[    1.960693] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa09c014
[    1.968872] Internal error: : 1028 [#1] SMP
[    1.973266] last sysfs file:=20
[    1.976379] Modules linked in:
[    1.979583] CPU: 0    Not tainted  (2.6.37-rc4-09012-gfea0fb8 #65)
[    1.986083] PC is at omap_hsmmc_context_restore+0x58/0x2ec
[    1.991851] LR is at omap_hsmmc_context_restore+0x4c/0x2ec
[    1.997619] pc : [<c0345590>]    lr : [<c0345584>]    psr: 20000013
[    1.997619] sp : cf82deb0  ip : cf82c000  fp : cf890408
[    2.009643] r10: cf826160  r9 : 00000053  r8 : 00000001
[    2.015136] r7 : cfad2000  r6 : cfad23c0  r5 : 00000000  r4 : ffff6b1f
[    2.021972] r3 : 0000000e  r2 : fa09c000  r1 : fa09c014  r0 : ffff6b22
[    2.028808] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[    2.036499] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    2.042510] Process swapper (pid: 1, stack limit =3D 0xcf82c2f8)
[    2.048645] Stack: (0xcf82deb0 to 0xcf82e000)
[    2.053192] dea0:                                     cfad23c0 00000000 =
cfad2000 cfad23c0
[    2.061798] dec0: 00000000 c0345844 cfad2000 00000000 cfad2000 c0338040 =
00000000 00000001
[    2.070373] dee0: cfad2000 c002c728 00000000 00000003 cf886c08 cfad0a60 =
c05fdbc0 cf890408
[    2.078948] df00: cf890408 c05fdbc0 cfaef1a0 c05f06b8 00000000 00000000 =
00000000 c02a0368
[    2.087524] df20: cf890408 c029f388 cf890408 cf89043c c05fdbc0 c029f4b0 =
00000000 c029f448
[    2.096130] df40: c05fdbc0 c029eb3c cf826eb8 cf8b5890 cf8001e0 00000080 =
c05fdbc0 c029e468
[    2.104705] df60: c04f3804 00000468 00000000 c05fdbac c061bd54 c05fdbc0 =
c061bd4c c002c400
[    2.113281] df80: 00000000 c029f7a8 c05fdbac c061bd54 c05aa190 c061bd4c =
c002c400 c02a0770
[    2.121856] dfa0: c00335dc c061bd54 c05aa190 c0050574 00000000 00000000 =
c0503d6c 00000192
[    2.130462] dfc0: c061bd54 c00335dc c061bd54 c05aa190 c061bd4c 00000000 =
00000000 c00084ec
[    2.139038] dfe0: 00000000 c00083a0 c005bcf0 00000013 00000000 c005bcf0 =
1177ed0a 0073ef00
[    2.147644] [<c0345590>] (omap_hsmmc_context_restore+0x58/0x2ec) from [<=
c0345844>] (omap_hsmmc_enable_fclk+0x20/0x28)
[    2.158782] [<c0345844>] (omap_hsmmc_enable_fclk+0x20/0x28) from [<c0338=
040>] (mmc_host_enable+0x6c/0x90)
[    2.168823] [<c0338040>] (mmc_host_enable+0x6c/0x90) from [<c002c728>] (=
omap_hsmmc_probe+0x314/0x96c)
[    2.178497] [<c002c728>] (omap_hsmmc_probe+0x314/0x96c) from [<c02a0368>=
] (platform_drv_probe+0x18/0x1c)
[    2.188476] [<c02a0368>] (platform_drv_probe+0x18/0x1c) from [<c029f388>=
] (driver_probe_device+0xc8/0x188)
[    2.198608] [<c029f388>] (driver_probe_device+0xc8/0x188) from [<c029f4b=
0>] (__driver_attach+0x68/0x8c)
[    2.208465] [<c029f4b0>] (__driver_attach+0x68/0x8c) from [<c029eb3c>] (=
bus_for_each_dev+0x44/0x74)
[    2.217956] [<c029eb3c>] (bus_for_each_dev+0x44/0x74) from [<c029e468>] =
(bus_add_driver+0x104/0x294)
[    2.227569] [<c029e468>] (bus_add_driver+0x104/0x294) from [<c029f7a8>] =
(driver_register+0xa8/0x130)
[    2.237152] [<c029f7a8>] (driver_register+0xa8/0x130) from [<c02a0770>] =
(platform_driver_probe+0x18/0x8c)
[    2.247192] [<c02a0770>] (platform_driver_probe+0x18/0x8c) from [<c00505=
74>] (do_one_initcall+0xc8/0x1a0)
[    2.257263] [<c0050574>] (do_one_initcall+0xc8/0x1a0) from [<c00084ec>] =
(kernel_init+0x14c/0x214)
[    2.266571] [<c00084ec>] (kernel_init+0x14c/0x214) from [<c005bcf0>] (ke=
rnel_thread_exit+0x0/0x8)
[    2.275878] Code: ebf53fa3 e5962048 e2821014 e0800004 (e5913000)=20
[    2.282409] ---[ end trace a0fb0e5d1754cad1 ]---
[    2.287353] Kernel panic - not syncing: Attempted to kill init!

Looks like 0xfa09c014 is the MMC SYSSTATUS register... maybe there's=20
something wrong with the clock control.


- Paul
--155748971-129514236-1291762597=:13430--
