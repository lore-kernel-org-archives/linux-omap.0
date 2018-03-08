From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: usb: musb: error when trying to unbind musb-hdrc.0.auto
Date: Thu, 8 Mar 2018 01:06:02 +0100
Message-ID: <5d23efd8-e224-1d5d-f2d2-b8d969636286@wizzup.org>
References: <3cf2bed3-817b-537e-4842-63476b091125@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yUCYN2gt0eD7TrHQlgATmle98yqO4a4oq"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cf2bed3-817b-537e-4842-63476b091125@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yUCYN2gt0eD7TrHQlgATmle98yqO4a4oq
Content-Type: multipart/mixed; boundary="o3PAmC0vRpB2igkuY4s5WsKVlL57A0AcB";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Message-ID: <5d23efd8-e224-1d5d-f2d2-b8d969636286@wizzup.org>
Subject: Re: usb: musb: error when trying to unbind musb-hdrc.0.auto
References: <3cf2bed3-817b-537e-4842-63476b091125@wizzup.org>
In-Reply-To: <3cf2bed3-817b-537e-4842-63476b091125@wizzup.org>

--o3PAmC0vRpB2igkuY4s5WsKVlL57A0AcB
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

I suspected that the issue was similar to the one fixed in this commit:
0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 (USB: musb: fix late external
abort on suspend)

I've applied a similar fix to the musb_remove function (as well as
moving musb_platform_exit just before spin_unlock_irqrestore), and now I
can unbind successfully. I will try to send a patch for review soon.

Cheers,
Merlijn

On 07/03/18 23:41, Merlijn Wajer wrote:
> Hi,
>=20
> I am trying to unbind the musb driver on my Nokia N900, but I get the
> following kernel oops [1].
>=20
> This is the command that I issued:
>=20
> root@n900devuan:/sys/bus/platform/drivers/musb-hdrc# echo
> musb-hdrc.0.auto > unbind
>=20
> This might be omap specific. I thought that as with the vbus issue,
> calls to pm_runtime_{get,put}_sync were required, but it seems that
> pm_runtime_disable gets called before musb_platform_exit is called.
>=20
> I've tried simply moving the call so that it is called before
> pm_runtime_disable (actually just before spin_unlock_irqrestore in
> musb_remove) but this doesn't seem to help.
>=20
> Any thoughts?
>=20
> Cheers,
> Merlijn
>=20
> [1]
>=20
> [ 7232.484985] Unhandled fault: external abort on non-linefetch (0x1028=
)
> at 0xfa0ab414
> [ 7232.485015] pgd =3D 9b0f7685
> [ 7232.485046] [fa0ab414] *pgd=3D48011452(bad)
> [ 7232.485076] Internal error: : 1028 [#1] PREEMPT ARM
> [ 7232.485076] Modules linked in: u_ether u_serial bluetooth
> ecdh_generic ipv6 omaplfb ctr
>  aes_arm_bs crypto_simd cryptd ccm pvrsrvkm cmt_speech nokia_modem
> ssi_protocol radio_plat
> form_si4713 mousedev arc4 joydev hsi_char wl1251_spi crc7 wl1251
> ir_lirc_codec mac80211 li
> rc_dev ir_rx51 rc_core smc91x gpio_keys rx51_battery pwm_omap_dmtimer
> isp1704_charger mii
> sha256_generic omap3_isp videobuf2_dma_contig v4l2_fwnode cfg80211
> videobuf2_memops si4713
>  videobuf2_v4l2 adp1653 videobuf2_core v4l2_common tsc2005 tsc200x_core=

> videodev bq27xxx_b
> attery_i2c bq27xxx_battery bq2415x_charger leds_lp5523
> leds_lp55xx_common media tsl2563 rt
> c_twl twl4030_vibra ff_memless omap_ssi lis3lv02d_i2c lis3lv02d hsi
> input_polldev ti_soc_t
> hermal vfat fat [last unloaded: libcomposite]
> [ 7232.485412] CPU: 0 PID: 2803 Comm: bash Not tainted 4.15.6+ #1
> [ 7232.485412] Hardware name: Nokia RX-51 board
> [ 7232.485473] PC is at musb_default_readl+0x4/0xc
> [ 7232.485473] LR is at omap2430_musb_exit+0x2c/0x70
> [ 7232.485504] pc : [<c05220f8>]    lr : [<c052b218>]    psr: a0020013
> [ 7232.485504] sp : cb2afe70  ip : 00000000  fp : 00000000
> [ 7232.485534] r10: 00000000  r9 : 00000051  r8 : 200f0013
> [ 7232.485534] r7 : c2a65920  r6 : ce354d10  r5 : 00000000  r4 : ce52e0=
10
> [ 7232.485565] r3 : c05220f4  r2 : 00000000  r1 : fa0ab414  r0 : fa0ab0=
00
> [ 7232.485595] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [ 7232.485595] Control: 10c5387d  Table: 8bfa4019  DAC: 00000051
> [ 7232.485626] Process bash (pid: 2803, stack limit =3D 0x5105ec71)
> [ 7232.485626] Stack: (0xcb2afe70 to 0xcb2b0000)
> [ 7232.485656] fe60:                                     ce52e010
> ffffe000 ce388a10 c0521c
> dc
> [ 7232.485687] fe80: ce388a10 ce388a10 c0a325e8 ce388a44 00000034
> c04c34d8 ce388a10 000000
> 00
> [ 7232.485717] fea0: c0a325e8 c04c2170 00000011 ce388a10 c0a325e8
> c0a2fef8 c9cde410 c04c0a
> 8c
> [ 7232.485717] fec0: 00000011 cd8f7e00 c9cde400 cb2aff88 c9cde410
> c0259554 00000000 000000
> 00
> [ 7232.485748] fee0: 00000011 cb6b1600 c0259424 00000000 cb2aff88
> 000e4408 cb2ae000 c01eda
> 74
> [ 7232.485778] ff00: 00000100 00000000 cb3b0180 c020a948 cb3b0cc0
> 0000000a cb3b0cc0 000000
> 01
> [ 7232.485809] ff20: cb3b0cc0 0000000a 00000001 c020aefc 00000001
> 00000000 cb3b0cc0 c01fd4
> f4
> [ 7232.485839] ff40: cb6b1600 00000002 cb6b1600 00000011 00000000
> cb2aff88 000e4408 c01edd30
> [ 7232.485870] ff60: cb6b1600 000e4408 00000011 cb6b1600 cb6b1600
> 000e4408 00000011 c0106fc4
> [ 7232.485900] ff80: cb2ae000 c01edee8 00000000 00000000 00000011
> 00000011 000e4408 b6eb3d60
> [ 7232.485900] ffa0: 00000004 c0106de0 00000011 000e4408 00000001
> 000e4408 00000011 00000000
> [ 7232.485931] ffc0: 00000011 000e4408 b6eb3d60 00000004 000e4408
> 00000011 00000000 00000000
> [ 7232.485961] ffe0: 00000000 bedd1eec b6e161bb b6e52b46 00000030
> 00000001 00000000 00000000
> [ 7232.485992] [<c05220f8>] (musb_default_readl) from [<c052b218>]
> (omap2430_musb_exit+0x2c/0x70)
> [ 7232.486022] [<c052b218>] (omap2430_musb_exit) from [<c0521cdc>]
> (musb_remove+0x110/0x158)
> [ 7232.486053] [<c0521cdc>] (musb_remove) from [<c04c34d8>]
> (platform_drv_remove+0x24/0x3c)
> [ 7232.486114] [<c04c34d8>] (platform_drv_remove) from [<c04c2170>]
> (device_release_driver_internal+0xd4/0x1dc)
> [ 7232.486145] [<c04c2170>] (device_release_driver_internal) from
> [<c04c0a8c>] (unbind_store+0x58/0x8c)
> [ 7232.486175] [<c04c0a8c>] (unbind_store) from [<c0259554>]
> (kernfs_fop_write+0x130/0x1a0)
> [ 7232.486206] [<c0259554>] (kernfs_fop_write) from [<c01eda74>]
> (__vfs_write+0x1c/0x11c)
> [ 7232.486236] [<c01eda74>] (__vfs_write) from [<c01edd30>]
> (vfs_write+0xb8/0x18c)
> [ 7232.486267] [<c01edd30>] (vfs_write) from [<c01edee8>]
> (SyS_write+0x3c/0x74)
> [ 7232.486297] [<c01edee8>] (SyS_write) from [<c0106de0>]
> (ret_fast_syscall+0x0/0x54)
> [ 7232.486328] Code: e0801001 e5812000 e12fff1e e0801001 (e5910000)
> [ 7232.486328] ---[ end trace 1dd18c3e3b5270ba ]---
> [ 7232.497070] In-band Error seen by MPU  at address 0
> [ 7232.497100] ------------[ cut here ]------------
> [ 7232.497161] WARNING: CPU: 0 PID: 2803 at
> drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0xcc/0x114
> [ 7232.497161] Modules linked in: u_ether u_serial bluetooth
> ecdh_generic ipv6 omaplfb ctr aes_arm_bs crypto_simd cryptd ccm pvrsrvk=
m
> cmt_speech nokia_modem ssi_protocol radio_platform_si4713 mousedev arc4=

> joydev hsi_char wl1251_spi crc7 wl1251 ir_lirc_codec mac80211 lirc_dev
> ir_rx51 rc_core smc91x gpio_keys rx51_battery pwm_omap_dmtimer
> isp1704_charger mii sha256_generic omap3_isp videobuf2_dma_contig
> v4l2_fwnode cfg80211 videobuf2_memops si4713 videobuf2_v4l2 adp1653
> videobuf2_core v4l2_common tsc2005 tsc200x_core videodev
> bq27xxx_battery_i2c bq27xxx_battery bq2415x_charger leds_lp5523
> leds_lp55xx_common media tsl2563 rtc_twl twl4030_vibra ff_memless
> omap_ssi lis3lv02d_i2c lis3lv02d hsi input_polldev ti_soc_thermal vfat
> fat [last unloaded: libcomposite]
> [ 7232.497467] CPU: 0 PID: 2803 Comm: bash Tainted: G      D
> 4.15.6+ #1
> [ 7232.497497] Hardware name: Nokia RX-51 board
> [ 7232.497528] [<c010c440>] (unwind_backtrace) from [<c010a80c>]
> (show_stack+0x10/0x14)
> [ 7232.497589] [<c010a80c>] (show_stack) from [<c0124bfc>]
> (__warn+0xe4/0x100)
> [ 7232.497619] [<c0124bfc>] (__warn) from [<c0124cd8>]
> (warn_slowpath_null+0x38/0x44)
> [ 7232.497650] [<c0124cd8>] (warn_slowpath_null) from [<c0442708>]
> (omap3_l3_app_irq+0xcc/0x114)
> [ 7232.497680] [<c0442708>] (omap3_l3_app_irq) from [<c0156798>]
> (__handle_irq_event_percpu+0x44/0x110)
> [ 7232.497711] [<c0156798>] (__handle_irq_event_percpu) from
> [<c015687c>] (handle_irq_event_percpu+0x18/0x54)
> [ 7232.497741] [<c015687c>] (handle_irq_event_percpu) from [<c0156918>]=

> (handle_irq_event+0x60/0x8c)
> [ 7232.497772] [<c0156918>] (handle_irq_event) from [<c0159b90>]
> (handle_level_irq+0x108/0x13c)
> [ 7232.497802] [<c0159b90>] (handle_level_irq) from [<c0155c0c>]
> (generic_handle_irq+0x18/0x28)
> [ 7232.497833] [<c0155c0c>] (generic_handle_irq) from [<c0156208>]
> (__handle_domain_irq+0x8c/0xa0)
> [ 7232.497894] [<c0156208>] (__handle_domain_irq) from [<c067facc>]
> (__irq_svc+0x6c/0xa8)
> [ 7232.497924] [<c067facc>] (__irq_svc) from [<c0125e00>]
> (do_exit+0x120/0x990)
> [ 7232.497955] [<c0125e00>] (do_exit) from [<c010aa44>] (die+0x234/0x26=
c)
> [ 7232.497985] [<c010aa44>] (die) from [<c0101328>] (do_DataAbort+0xa4/=
0xb8)
> [ 7232.497985] [<c0101328>] (do_DataAbort) from [<c067fa38>]
> (__dabt_svc+0x58/0x80)
> [ 7232.498016] Exception stack(0xcb2afe20 to 0xcb2afe68)
> [ 7232.498046] fe20: fa0ab000 fa0ab414 00000000 c05220f4 ce52e010
> 00000000 ce354d10 c2a65920
> [ 7232.498077] fe40: 200f0013 00000051 00000000 00000000 00000000
> cb2afe70 c052b218 c05220f8
> [ 7232.498077] fe60: a0020013 ffffffff
> [ 7232.498107] [<c067fa38>] (__dabt_svc) from [<c05220f8>]
> (musb_default_readl+0x4/0xc)
> [ 7232.498138] [<c05220f8>] (musb_default_readl) from [<c052b218>]
> (omap2430_musb_exit+0x2c/0x70)
> [ 7232.498168] [<c052b218>] (omap2430_musb_exit) from [<c0521cdc>]
> (musb_remove+0x110/0x158)
> [ 7232.498199] [<c0521cdc>] (musb_remove) from [<c04c34d8>]
> (platform_drv_remove+0x24/0x3c)
> [ 7232.498229] [<c04c34d8>] (platform_drv_remove) from [<c04c2170>]
> (device_release_driver_internal+0xd4/0x1dc)
> [ 7232.498260] [<c04c2170>] (device_release_driver_internal) from
> [<c04c0a8c>] (unbind_store+0x58/0x8c)
> [ 7232.498321] [<c04c0a8c>] (unbind_store) from [<c0259554>]
> (kernfs_fop_write+0x130/0x1a0)
> [ 7232.498321] [<c0259554>] (kernfs_fop_write) from [<c01eda74>]
> (__vfs_write+0x1c/0x11c)
> [ 7232.498352] [<c01eda74>] (__vfs_write) from [<c01edd30>]
> (vfs_write+0xb8/0x18c)
> [ 7232.498382] [<c01edd30>] (vfs_write) from [<c01edee8>]
> (SyS_write+0x3c/0x74)
> [ 7232.498413] [<c01edee8>] (SyS_write) from [<c0106de0>]
> (ret_fast_syscall+0x0/0x54)
> [ 7232.498443] ---[ end trace 1dd18c3e3b5270bb ]---
>=20



--o3PAmC0vRpB2igkuY4s5WsKVlL57A0AcB--

--yUCYN2gt0eD7TrHQlgATmle98yqO4a4oq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqB+awAKCRAGN09rynK8
WkyIAQDVYffNBCdjR+OTcXSgr1C7HmsoSZX0bh61X6mepxP9nwEA/CcKGG4XarQU
pUvQKS+N9GOXEUWhGgPvjZBikoqi8Qo=
=WIHZ
-----END PGP SIGNATURE-----

--yUCYN2gt0eD7TrHQlgATmle98yqO4a4oq--
