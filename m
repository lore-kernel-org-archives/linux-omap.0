From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 31 Jan 2015 12:34:40 +0100
Message-ID: <201501311234.41001@pali>
References: <20131206213613.GA19648@earth.universe> <201501171829.18354@pali> <20150117174125.GV18552@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2100872.GgtUhBjKoU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:46783 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbAaLeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 06:34:44 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so31031311wgg.4
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 03:34:43 -0800 (PST)
In-Reply-To: <20150117174125.GV18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

--nextPart2100872.GgtUhBjKoU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 17 January 2015 18:41:26 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 09:32]:
> > On Saturday 17 January 2015 18:04:11 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 01:21]:
> > > > Hello, after playing with aes and non-aes version of
> > > > bootloaders I found out that code which configure L3
> > > > firewall must be in signed X-Loader part. So probably we
> > > > cannot change configuration at runtime...
> > > >=20
> > > > Tony,
> > > > any idea how to dump L3_PM_ADDR_MATCH_* registers from
> > > > userspace or from kernel? Now I have configured one N900
> > > > with original Nokia X-Loader (where loading omap aes
> > > > driver cause kernel crash) and one N900 with aes
> > > > X-Loader (where loading omap aes driver is working).
> > >=20
> > > Hmm maybe give the omapconf too a try? It's at:
> > >=20
> > > https://github.com/omapconf/omapconf
> > >=20
> > > That uses /dev/mem from userspace, then you can just
> > > ioremap them in the kernel code if you need to do
> > > something during runtime. Probably best to access them
> > > with a syscon mapping from the aes driver.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > https://github.com/omapconf/omapconf/wiki
> >=20
> > Legacy TI OMAP platforms (OMAP[1-2-3]) are not supported.
>=20
> Oh OK. Well at least you can look at the code if you want to
> do it from the user space :)
>=20
> Regards,
>=20
> Tony

I played with devmem2.c program, but trying to read any of those register c=
aused probably L3 violation=20
error...

registers:
L3_PM_ERROR_LOG
L3_PM_CONTROL
L3_PM_REQ_INFO_PERMISSION_i
L3_PM_READ_PERMISSION_i
L3_PM_WRITE_PERMISSION_i
L3_PM_ADDR_MATCH_k

protection mechanisms:
PM_RT
PM_GPMC
PM_OCM_RAM
PM_OCM_ROM
PM_IVA2.2

Here is example output for address 0x68010028 (PM_RT L3_PM_CONTROL):

$ devmem2 0x68010028 w
/dev/mem opened.
Memory mapped at address 0xb6f87000.
Bus error

dmesg output:
[  172.923553] Unhandled fault: external abort on non-linefetch (0x1018) at=
 0xb6f87028
[  172.930664] In-band Error seen by MPU  at address 0
[  172.937408] ------------[ cut here ]------------
[  172.944061] WARNING: CPU: 0 PID: 612 at drivers/bus/omap_l3_smx.c:166 om=
ap3_l3_app_irq+0xd4/0x118()
[  172.957733] Modules linked in: wl1251_spi wl1251 crc7 mac80211 cfg80211 =
isp1704_charger=20
lis3lv02d_i2c lis3lv02d input_polldev bq2415x_charger si4713 bq27x00_batter=
y v4l2_common videodev=20
media leds_lp5523 omap_ssi hsi leds_lp55xx_common tsl2563 rtc_twl rx51_batt=
ery twl4030_vibra=20
ff_memless tsc2005 twl4030_wdt omap_wdt
[  172.987762] CPU: 0 PID: 612 Comm: devmem2 Tainted: G        W      3.19.=
0-rc5+ #297
[  172.995483] Hardware name: Nokia RX-51 board
[  173.002960] [<c0012678>] (unwind_backtrace) from [<c0010d44>] (show_stac=
k+0x10/0x14)
[  173.010589] [<c0010d44>] (show_stack) from [<c0032194>] (warn_slowpath_c=
ommon+0x84/0xac)
[  173.018280] [<c0032194>] (warn_slowpath_common) from [<c00321d4>] (warn_=
slowpath_null+0x18/0x1c)
[  173.026123] [<c00321d4>] (warn_slowpath_null) from [<c01f30e0>] (omap3_l=
3_app_irq+0xd4/0x118)
[  173.034057] [<c01f30e0>] (omap3_l3_app_irq) from [<c0061fd0>] (handle_ir=
q_event_percpu+0xcc/0x294)
[  173.049987] [<c0061fd0>] (handle_irq_event_percpu) from [<c00621fc>] (ha=
ndle_irq_event+0x64/0x8c)
[  173.058441] [<c00621fc>] (handle_irq_event) from [<c0064b9c>] (handle_le=
vel_irq+0xcc/0x130)
[  173.066925] [<c0064b9c>] (handle_level_irq) from [<c0061850>] (generic_h=
andle_irq+0x20/0x30)
[  173.075592] [<c0061850>] (generic_handle_irq) from [<c0061a38>] (__handl=
e_domain_irq+0x80/0xa4)
[  173.084411] [<c0061a38>] (__handle_domain_irq) from [<c0008520>] (omap_i=
ntc_handle_irq+0x78/0xa4)
[  173.093383] [<c0008520>] (omap_intc_handle_irq) from [<c0409380>] (__irq=
_svc+0x40/0x74)
[  173.102508] Exception stack(0xc6f2ff58 to 0xc6f2ffa0)
[  173.111755] ff40:                                                       =
00000000 00000001
[  173.121154] ff60: 60000010 00000001 c6f2ffb0 00000000 ffffffff 10c5387d =
00000000 c6f2e000
[  173.130554] ff80: 00000000 bea65b44 00000000 c6f2ffa0 c000dc20 c00104a0 =
20000113 ffffffff
[  173.140136] [<c0409380>] (__irq_svc) from [<c00104a0>] (do_work_pending+=
0x34/0xb4)
[  173.149902] [<c00104a0>] (do_work_pending) from [<c000dc20>] (work_pendi=
ng+0xc/0x20)
[  173.159759] ---[ end trace 124b6fccc1bf5a71 ]---

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2100872.GgtUhBjKoU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMvdAACgkQi/DJPQPkQ1KwZwCgy473v1iSorwTwzxWsmzuQzja
T7gAnjJV3j0fSZLZou20yazufbxhjRV8
=5m9o
-----END PGP SIGNATURE-----

--nextPart2100872.GgtUhBjKoU--
