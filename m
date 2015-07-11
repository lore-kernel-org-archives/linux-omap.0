From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: linux 4.2-rc1 broken Nokia N900
Date: Sat, 11 Jul 2015 14:05:05 +0200
Message-ID: <201507111405.06048@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1977529.VStSnXzURa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1977529.VStSnXzURa
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

now I tested 4.2-rc1 release on Nokia N900 and couple of drivers are
broken and cause kernel oops...

Basically wifi, touchscreen and rtc drivers not working...

Here are some relevant snippets form dmesg:

[   13.933959] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa09802c
[   13.940490] pgd =3D cfb38000
[   13.946594] [fa09802c] *pgd=3D48011452(bad)
[   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
[   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt omap_wdt
[   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1+ #363
[   13.971801] Hardware name: Nokia RX-51 board
[   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
[   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
[   13.991485] LR is at spi_set_cs+0x5c/0x60
[   13.997985] pc : [<c02bd3ac>]    lr : [<c02baecc>]    psr: 20000013
[   13.997985] sp : cb1f3dd0  ip : 00000001  fp : 00000004
[   14.011260] r10: cfce5be8  r9 : 00000fff  r8 : c0654f98
[   14.017913] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
[   14.024505] r3 : 200103dc  r2 : fa098000  r1 : 00000001  r0 : cf09bc00
[   14.031036] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 user
[   14.037689] Control: 10c5387d  Table: 8fb38019  DAC: 00000015
[   14.044403] Process modprobe (pid: 183, stack limit =3D 0xcb1f2210)
[   14.051300] Stack: (0xcb1f3dd0 to 0xcb1f4000)
[   14.058105] 3dc0:                                     cf09bc00 c02bafa4 =
cf09bc00 cf09bc00
[   14.065277] 3de0: bf013444 bf01254c cf0e2230 cf0e2230 00000001 c0654f98 =
00000fff 00000fff
[   14.072570] 3e00: 00000008 00000002 00000118 00001f40 00000031 cf09bc00 =
ffffffed bf013444
[   14.080078] 3e20: 00000031 c0654f98 cb1f2000 00000000 00000000 c02bb5c0 =
cf09bc00 00000000
[   14.087738] 3e40: bf013454 c027a2f4 00000000 cf09bc00 bf013454 bf013454 =
00000000 c027a594
[   14.095367] 3e60: 00000000 cf09bc00 cf09bc34 c027a60c bf013454 cb1f3e80 =
c027a5ac c0278ec8
[   14.102935] 3e80: cf972c4c cf09d630 bf013454 bf013454 cbb55300 c06848d8 =
00000000 c0279c84
[   14.110473] 3ea0: bf01327c bf01327d 00000000 bf013454 cb889180 00000000 =
c0654f98 c027b0c8
[   14.117980] 3ec0: 00000000 bf015000 cb889180 c00095b0 0040003e cfe6a080 =
0040003f 00000000
[   14.125457] 3ee0: 00080000 cfcf9000 cb1f2000 60000013 0040003e cbf1bbc0 =
00000000 00000001
[   14.132843] 3f00: bf0134cc cb1f2000 bf0134c0 cb1f3f58 00000000 c04352d0 =
cf801f00 000000d0
[   14.140136] 3f20: bf0134c0 bf0134c0 0000416c cb889040 00000080 c000ebe4 =
cb1f2000 c0089f68
[   14.147308] 3f40: bf0134c0 cbf1bc00 001a9193 0000416c 001f8d20 c008ab30 =
d0b10000 0000416c
[   14.154571] 3f60: d0b1267c d0b1252b d0b13514 000016c0 00001ad0 00000000 =
00000000 00000000
[   14.161865] 3f80: 0000001f 00000020 00000017 00000014 00000012 00000000 =
00201208 00000000
[   14.169097] 3fa0: 00000000 c000ea60 00201208 00000000 001f8d20 0000416c =
001a9193 00000000
[   14.176177] 3fc0: 00201208 00000000 00000000 00000080 00208c20 001a9193 =
bee09e98 00000000
[   14.183197] 3fe0: b6f742b4 bee09ae4 000153f0 000093e4 60000010 001f8d20 =
72757463 69665f65
[   14.190277] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (spi_set=
_cs+0x5c/0x60)
[   14.197479] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup+0xd4/=
0x10c)
[   14.204833] [<c02bafa4>] (spi_setup) from [<bf01254c>] (tsc2005_probe+0x=
104/0x484 [tsc2005])
[   14.212249] [<bf01254c>] (tsc2005_probe [tsc2005]) from [<c02bb5c0>] (sp=
i_drv_probe+0x50/0x6c)
[   14.219818] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really_probe=
+0xd4/0x230)
[   14.227478] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_probe_=
device+0x30/0x48)
[   14.235290] [<c027a594>] (driver_probe_device) from [<c027a60c>] (__driv=
er_attach+0x60/0x84)
[   14.243286] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_for_ea=
ch_dev+0x50/0x84)
[   14.251281] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus_add_d=
river+0xcc/0x1e0)
[   14.259246] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (driver_regi=
ster+0x9c/0xe0)
[   14.267272] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_one_ini=
tcall+0x100/0x1b0)
[   14.275421] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_init_mo=
dule+0x58/0x1bc)
[   14.283477] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_init_mo=
dule+0x54/0x64)
[   14.291412] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_fast_s=
yscall+0x0/0x3c)
[   14.299407] Code: e5823018 e5902188 e5922000 e582302c (e592302c)=20
[   14.307403] ---[ end trace d21553dcaefcb5ac ]---


[   14.315338] In-band Error seen by MPU  at address 0
[   14.323211] ------------[ cut here ]------------
[   14.330993] WARNING: CPU: 0 PID: 183 at drivers/bus/omap_l3_smx.c:166 om=
ap3_l3_app_irq+0xd4/0x118()
[   14.346893] Modules linked in: tsc2005(+) omap_sham twl4030_wdt omap_wdt
[   14.355316] CPU: 0 PID: 183 Comm: modprobe Tainted: G      D         4.2=
=2E0-rc1+ #363
[   14.363739] Hardware name: Nokia RX-51 board
[   14.372070] [<c0013650>] (unwind_backtrace) from [<c0011bf4>] (show_stac=
k+0x10/0x14)
[   14.380676] [<c0011bf4>] (show_stack) from [<c00334dc>] (warn_slowpath_c=
ommon+0x84/0xac)
[   14.389404] [<c00334dc>] (warn_slowpath_common) from [<c003351c>] (warn_=
slowpath_null+0x18/0x1c)
[   14.398315] [<c003351c>] (warn_slowpath_null) from [<c0203778>] (omap3_l=
3_app_irq+0xd4/0x118)
[   14.407287] [<c0203778>] (omap3_l3_app_irq) from [<c0064e5c>] (handle_ir=
q_event_percpu+0xbc/0x26c)
[   14.425262] [<c0064e5c>] (handle_irq_event_percpu) from [<c0065074>] (ha=
ndle_irq_event+0x68/0x94)
[   14.434631] [<c0065074>] (handle_irq_event) from [<c0067b38>] (handle_le=
vel_irq+0xd8/0x140)
[   14.444000] [<c0067b38>] (handle_level_irq) from [<c00646e8>] (generic_h=
andle_irq+0x20/0x30)
[   14.453247] [<c00646e8>] (generic_handle_irq) from [<c00648d4>] (__handl=
e_domain_irq+0x80/0xa4)
[   14.462493] [<c00648d4>] (__handle_domain_irq) from [<c000933c>] (omap_i=
ntc_handle_irq+0x78/0xa4)
[   14.471740] [<c000933c>] (omap_intc_handle_irq) from [<c042c200>] (__irq=
_svc+0x40/0x74)
[   14.481018] Exception stack(0xcb1f3c60 to 0xcb1f3ca8)
[   14.490203] 3c60: 00000000 00000000 cb1f3ca8 00000000 cbef7400 0000000b =
0000090c 00000001
[   14.499572] 3c80: c0654f98 00000fff cfce5be8 00000004 00001154 cb1f3ca8 =
c008c688 c008c784
[   14.508850] 3ca0: 40000113 ffffffff
[   14.517944] [<c042c200>] (__irq_svc) from [<c008c784>] (acct_collect+0x1=
78/0x1ac)
[   14.527252] [<c008c784>] (acct_collect) from [<c0035864>] (do_exit+0x1d4=
/0x3c4)
[   14.536590] [<c0035864>] (do_exit) from [<c0011a40>] (oops_end+0xc4/0xdc)
[   14.545959] [<c0011a40>] (oops_end) from [<c0009218>] (do_DataAbort+0xa0=
/0xb4)
[   14.555267] [<c0009218>] (do_DataAbort) from [<c042c198>] (__dabt_svc+0x=
38/0x60)
[   14.564483] Exception stack(0xcb1f3d88 to 0xcb1f3dd0)
[   14.573699] 3d80:                   cf09bc00 00000001 fa098000 200103dc =
00000000 00000000
[   14.583221] 3da0: 00000000 00000000 c0654f98 00000fff cfce5be8 00000004 =
00000001 cb1f3dd0
[   14.592803] 3dc0: c02baecc c02bd3ac 20000013 ffffffff
[   14.602142] [<c042c198>] (__dabt_svc) from [<c02bd3ac>] (omap2_mcspi_set=
_cs+0x44/0x4c)
[   14.611541] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (spi_set=
_cs+0x5c/0x60)
[   14.620910] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup+0xd4/=
0x10c)
[   14.630249] [<c02bafa4>] (spi_setup) from [<bf01254c>] (tsc2005_probe+0x=
104/0x484 [tsc2005])
[   14.639648] [<bf01254c>] (tsc2005_probe [tsc2005]) from [<c02bb5c0>] (sp=
i_drv_probe+0x50/0x6c)
[   14.649047] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really_probe=
+0xd4/0x230)
[   14.658386] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_probe_=
device+0x30/0x48)
[   14.667755] [<c027a594>] (driver_probe_device) from [<c027a60c>] (__driv=
er_attach+0x60/0x84)
[   14.677124] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_for_ea=
ch_dev+0x50/0x84)
[   14.686492] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus_add_d=
river+0xcc/0x1e0)
[   14.695709] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (driver_regi=
ster+0x9c/0xe0)
[   14.704833] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_one_ini=
tcall+0x100/0x1b0)
[   14.713989] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_init_mo=
dule+0x58/0x1bc)
[   14.723175] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_init_mo=
dule+0x54/0x64)
[   14.732269] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_fast_s=
yscall+0x0/0x3c)
[   14.741302] ---[ end trace d21553dcaefcb5ad ]---

[   28.602447] omap_i2c 48070000.i2c: controller timed out waiting for star=
t condition to finish
[   29.572509] omap_i2c 48072000.i2c: controller timed out
[   29.622436] i2c i2c-1: SCL is stuck low, exit recovery
[   30.215270] twl: Write failed (mod 5, reg 0x0d count 1)
[   30.642395] i2c i2c-1: SCL is stuck low, exit recovery
[   30.651153] twl: Write failed (mod 4, reg 0x03 count 1)

[   31.332427] rtc_twl: Could not write TWL register D - error -110
[   31.341033] twl_rtc: probe of 48070000.i2c:twl@48:rtc failed with error =
=2D110

[  103.212799] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa0ba02c
[  103.218536] pgd =3D c83a8000
[  103.223846] [fa0ba02c] *pgd=3D48011452(bad)
[  103.229125] Internal error: : 1028 [#2] PREEMPT ARM
[  103.234313] Modules linked in: wl1251_spi(+) wl1251 crc7 mac80211 cfg802=
11 isp1704_charger rx51_battery lis3lv02d_i2c=20
lis3lv02d input_polldev nokia_h4p bluetooth ad5820 omap_ssi hsi bq2415x_cha=
rger bq27x00_battery si4713 v4l2_common=20
leds_lp5523 leds_lp55xx_common rtc_twl tsl2563 video_bus_switch videodev me=
dia twl4030_vibra ff_memless tsc2005(+)=20
omap_sham twl4030_wdt omap_wdt
[  103.259033] CPU: 0 PID: 395 Comm: modprobe Tainted: G      D W       4.2=
=2E0-rc1+ #363
[  103.265472] Hardware name: Nokia RX-51 board
[  103.271789] task: cfbec000 ti: c912e000 task.ti: c912e000
[  103.278289] PC is at omap2_mcspi_set_cs+0x44/0x4c
[  103.284820] LR is at spi_set_cs+0x5c/0x60
[  103.291259] pc : [<c02bd3ac>]    lr : [<c02baecc>]    psr: 20000113
[  103.291259] sp : c912fdf0  ip : 000000fa  fp : 00000000
[  103.303863] r10: 00000000  r9 : 00000000  r8 : cfce6b7c
[  103.310058] r7 : 0000003d  r6 : 00000000  r5 : 00000000  r4 : 00000000
[  103.316253] r3 : 200103c3  r2 : fa0ba000  r1 : 00000001  r0 : cf0e3400
[  103.322448] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 user
[  103.328735] Control: 10c5387d  Table: 883a8019  DAC: 00000015
[  103.334991] Process modprobe (pid: 395, stack limit =3D 0xc912e210)
[  103.341491] Stack: (0xc912fdf0 to 0xc9130000)
[  103.348144] fde0:                                     cf0e3400 c02bafa4 =
cb1b1be0 cf0e3400
[  103.355163] fe00: cb1b13e0 bf2c83f4 cf0e3400 00000001 c912fe0c bf2c8380 =
cf0e3400 ffffffed
[  103.362396] fe20: bf2c887c 0000003d c0654f98 c912e000 00000000 c02bb5c0 =
cf0e3400 00000000
[  103.369903] fe40: bf2c888c c027a2f4 00000000 cf0e3400 bf2c888c bf2c888c =
00000000 c027a594
[  103.377624] fe60: 00000000 cf0e3400 cf0e3434 c027a60c bf2c888c c912fe80 =
c027a5ac c0278ec8
[  103.385314] fe80: cf972c4c cf09dc30 bf2c888c bf2c888c c3c92800 c06848d8 =
00000000 c0279c84
[  103.393249] fea0: bf2c8793 bf2c8794 00000000 bf2c888c c3f8b300 00000000 =
c0654f98 c027b0c8
[  103.401367] fec0: 00000000 bf2ca000 c3f8b300 c00095b0 0040003c cfd780e0 =
0040003d 00000000
[  103.409454] fee0: 00080000 cfcf9000 c912e000 001a9193 0040003c c3dfd300 =
00000000 00000001
[  103.417388] ff00: bf2c890c c912e000 bf2c8900 c912ff58 00000000 c04352d0 =
cf801f00 000000d0
[  103.425384] ff20: bf2c8900 bf2c8900 00002858 c3f8b140 00000080 c000ebe4 =
c912e000 c0089f68
[  103.433410] ff40: bf2c8900 c3dfd380 001a9193 00002858 001fb490 c008ab30 =
d0d97000 00002858
[  103.441284] ff60: d0d985d4 d0d98483 d0d9917c 00000b00 00000d60 00000000 =
00000000 00000000
[  103.448974] ff80: 0000001f 00000020 00000014 00000018 0000000f 00000000 =
00201968 00000000
[  103.456420] ffa0: 00000000 c000ea60 00201968 00000000 001fb490 00002858 =
001a9193 00000000
[  103.463623] ffc0: 00201968 00000000 00000000 00000080 002040d8 001a9193 =
be8c2e98 00000000
[  103.470642] ffe0: b6f46494 be8c2ae4 000153f0 000093e4 60000010 001fb490 =
00000000 00000000
[  103.477630] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (spi_set=
_cs+0x5c/0x60)
[  103.484741] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup+0xd4/=
0x10c)
[  103.491943] [<c02bafa4>] (spi_setup) from [<bf2c83f4>] (wl1251_spi_probe=
+0x74/0x224 [wl1251_spi])
[  103.499389] [<bf2c83f4>] (wl1251_spi_probe [wl1251_spi]) from [<c02bb5c0=
>] (spi_drv_probe+0x50/0x6c)
[  103.514099] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really_probe=
+0xd4/0x230)
[  103.521972] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_probe_=
device+0x30/0x48)
[  103.530029] [<c027a594>] (driver_probe_device) from [<c027a60c>] (__driv=
er_attach+0x60/0x84)
[  103.538238] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_for_ea=
ch_dev+0x50/0x84)
[  103.546417] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus_add_d=
river+0xcc/0x1e0)
[  103.554656] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (driver_regi=
ster+0x9c/0xe0)
[  103.562957] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_one_ini=
tcall+0x100/0x1b0)
[  103.571319] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_init_mo=
dule+0x58/0x1bc)
[  103.579620] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_init_mo=
dule+0x54/0x64)
[  103.587799] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_fast_s=
yscall+0x0/0x3c)
[  103.596038] Code: e5823018 e5902188 e5922000 e582302c (e592302c)=20
[  103.604248] ---[ end trace d21553dcaefcb5ae ]---

[  103.612457] In-band Error seen by MPU  at address 0
[  103.620544] ------------[ cut here ]------------
[  103.628540] WARNING: CPU: 0 PID: 395 at drivers/bus/omap_l3_smx.c:166 om=
ap3_l3_app_irq+0xd4/0x118()
[  103.644958] Modules linked in: wl1251_spi(+) wl1251 crc7 mac80211 cfg802=
11 isp1704_charger rx51_battery lis3lv02d_i2c=20
lis3lv02d input_polldev nokia_h4p bluetooth ad5820 omap_ssi hsi bq2415x_cha=
rger bq27x00_battery si4713 v4l2_common=20
leds_lp5523 leds_lp55xx_common rtc_twl tsl2563 video_bus_switch videodev me=
dia twl4030_vibra ff_memless tsc2005(+)=20
omap_sham twl4030_wdt omap_wdt
[  103.681732] CPU: 0 PID: 395 Comm: modprobe Tainted: G      D W       4.2=
=2E0-rc1+ #363
[  103.691192] Hardware name: Nokia RX-51 board
[  103.700622] [<c0013650>] (unwind_backtrace) from [<c0011bf4>] (show_stac=
k+0x10/0x14)
[  103.710357] [<c0011bf4>] (show_stack) from [<c00334dc>] (warn_slowpath_c=
ommon+0x84/0xac)
[  103.720153] [<c00334dc>] (warn_slowpath_common) from [<c003351c>] (warn_=
slowpath_null+0x18/0x1c)
[  103.729980] [<c003351c>] (warn_slowpath_null) from [<c0203778>] (omap3_l=
3_app_irq+0xd4/0x118)
[  103.739807] [<c0203778>] (omap3_l3_app_irq) from [<c0064e5c>] (handle_ir=
q_event_percpu+0xbc/0x26c)
[  103.759063] [<c0064e5c>] (handle_irq_event_percpu) from [<c0065074>] (ha=
ndle_irq_event+0x68/0x94)
[  103.768981] [<c0065074>] (handle_irq_event) from [<c0067b38>] (handle_le=
vel_irq+0xd8/0x140)
[  103.778778] [<c0067b38>] (handle_level_irq) from [<c00646e8>] (generic_h=
andle_irq+0x20/0x30)
[  103.788452] [<c00646e8>] (generic_handle_irq) from [<c00648d4>] (__handl=
e_domain_irq+0x80/0xa4)
[  103.798187] [<c00648d4>] (__handle_domain_irq) from [<c000933c>] (omap_i=
ntc_handle_irq+0x78/0xa4)
[  103.807983] [<c000933c>] (omap_intc_handle_irq) from [<c042c200>] (__irq=
_svc+0x40/0x74)
[  103.817749] Exception stack(0xc912fc80 to 0xc912fcc8)
[  103.827423] fc80: 00000000 00000000 00000000 00000000 cbd28a00 0000000b =
0000090c 00000001
[  103.837280] fca0: cfce6b7c 00000000 00000000 00000000 00009cb4 c912fcc8 =
c008c688 c008c780
[  103.847045] fcc0: 40000113 ffffffff
[  103.856750] [<c042c200>] (__irq_svc) from [<c008c780>] (acct_collect+0x1=
74/0x1ac)
[  103.866638] [<c008c780>] (acct_collect) from [<c0035864>] (do_exit+0x1d4=
/0x3c4)
[  103.876434] [<c0035864>] (do_exit) from [<c0011a40>] (oops_end+0xc4/0xdc)
[  103.886230] [<c0011a40>] (oops_end) from [<c0009218>] (do_DataAbort+0xa0=
/0xb4)
[  103.896118] [<c0009218>] (do_DataAbort) from [<c042c198>] (__dabt_svc+0x=
38/0x60)
[  103.906066] Exception stack(0xc912fda8 to 0xc912fdf0)
[  103.915832] fda0:                   cf0e3400 00000001 fa0ba000 200103c3 =
00000000 00000000
[  103.925750] fdc0: 00000000 0000003d cfce6b7c 00000000 00000000 00000000 =
000000fa c912fdf0
[  103.935455] fde0: c02baecc c02bd3ac 20000113 ffffffff
[  103.944885] [<c042c198>] (__dabt_svc) from [<c02bd3ac>] (omap2_mcspi_set=
_cs+0x44/0x4c)
[  103.954376] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (spi_set=
_cs+0x5c/0x60)
[  103.963684] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup+0xd4/=
0x10c)
[  103.972930] [<c02bafa4>] (spi_setup) from [<bf2c83f4>] (wl1251_spi_probe=
+0x74/0x224 [wl1251_spi])
[  103.982299] [<bf2c83f4>] (wl1251_spi_probe [wl1251_spi]) from [<c02bb5c0=
>] (spi_drv_probe+0x50/0x6c)
[  104.000640] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really_probe=
+0xd4/0x230)
[  104.010070] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_probe_=
device+0x30/0x48)
[  104.019561] [<c027a594>] (driver_probe_device) from [<c027a60c>] (__driv=
er_attach+0x60/0x84)
[  104.029022] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_for_ea=
ch_dev+0x50/0x84)
[  104.038330] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus_add_d=
river+0xcc/0x1e0)
[  104.047576] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (driver_regi=
ster+0x9c/0xe0)
[  104.056793] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_one_ini=
tcall+0x100/0x1b0)
[  104.066162] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_init_mo=
dule+0x58/0x1bc)
[  104.075408] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_init_mo=
dule+0x54/0x64)
[  104.084564] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_fast_s=
yscall+0x0/0x3c)
[  104.093627] ---[ end trace d21553dcaefcb5af ]---

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1977529.VStSnXzURa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWhBnIACgkQi/DJPQPkQ1JheACfYpXYLnZNLNKVT+P0V0uMD/de
1BcAn2LIotG/rjWBdjym6kSjSQNuJrlC
=IRkU
-----END PGP SIGNATURE-----

--nextPart1977529.VStSnXzURa--
