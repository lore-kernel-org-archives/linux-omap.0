From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 28 Nov 2014 22:41:12 +0100
Message-ID: <201411282241.12095@pali>
References: <20141027200008.GR2560@atomide.com> <201411271232.47231@pali> <20141128202719.GU2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1537603.RdaZp2mVaQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:55464 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaK1VlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 16:41:15 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so9678282wgh.30
        for <linux-omap@vger.kernel.org>; Fri, 28 Nov 2014 13:41:14 -0800 (PST)
In-Reply-To: <20141128202719.GU2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart1537603.RdaZp2mVaQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 28 November 2014 21:27:19 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141127 03:34]:
> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > > Thinking about this probably the best long term solution
> > > is to pass optional board_revision in the kernel cmdline
> > > that can be parsed early and copied to system_rev
> > > variable.
> >=20
> > Not possible. Our bootloader is closed & proprietary. I
> > tried to replace it with u-boot I was not able to do that.
> > So we will use that Nokia closed bootloader forever and it
> > can provide data only in ATAG structure.
>=20
> I'm using just mainline u-boot flashed as kernel for nolo that
> then loads the kernel.
>=20

Yes, this working. I wrote & tested more those n900 uboot parts.

> For passing the board revision using the pass through u-boot
> is probably the best long term solution. U-boot can read the
> ATAGs from nolo and modify the .dtb for the revision
> information.
>=20

Yes, this is possible. Current uboot rx51 code already parse
ATAGs from previous bootloader, so is also able to modify dtb.

> Are you saying there are some issues with that?
>=20

uboot (in mode when is loaded from NOLO) has those issues:

1) uboot cannot read n900 onenand mtd (uboot onenand driver not
working, do not know why)
2) missing support for battery charging (can totally discharge
battery)
3) missing support for panel panel (so sometimes screen is
totally black until kernel is booted and loaded own drivers)
4) limit for storing both uboot and kernel into MTD is limited by
2MB (size of kernel nand partition)

Basically you can use uboot if you accept all above issues.

But there are people (Pavel CCed) who prefer to work without
uboot when testing kernel. So it is not good idea to lock new
kernel versions to depends on new uboot version.

> > > Or if you can think of some other way to get it, we can
> > > set system_rev in pdata-quirks.c.
> > >=20
> > > Or maybe add some code to copy the ATAGs somewhere where
> > > they are out of the way and don't conflict with the device
> > > tree data? Then we can query ATAG_REVISION from
> > > pdata-quirks.c and set system_rev.
> >=20
> > If we are able to read ATAG from pdata-quirks, then we can
> > parse it there and fix problems... But I do not know if
> > address of ATAG structure is available there...
>=20
> Are there other ATAGs needed beyond the ATAG_REVISION?
>=20
> Regards,
>=20
> Tony

Sorry for longer email. I will provide some more info about it.
=46irst I will describe that informations are passed from NOLO
to kernel. Note that all those informations are passed also from
uboot to kernel (uboot just reuse non static data from NOLO).
Then I will describe that we need in userspace.

Here are all ATAGs from NOLO:

0000 - 0005:54410001 ATAG CORE flags=3D00000000 pagesize=3D00001000 rootdev=
=3D00000000
0020 - 0004:54410002 ATAG MEM size=3D10000000 start=3D80000000
0036 - 0003:54410007 ATAG REVISION revision=3D00002204
0048 - 0181:414f4d50 OMAP table (724 bytes)
       0000 - 0004:4f07 UART: enabled uarts (bitmask) 00000000
       0008 - 0024:4f05 LCD:          panel=3Dacx565akm controller=3Dintern=
al nreset_gpio=3D005a=20
data_lines=3D0018
       0048 - 0014:4f06 GPIO SWITCH:  cam_focus    : gpio=3D0044 flags=3D01=
 type=3D02 keycode=3D00000000
       0072 - 0014:4f06 GPIO SWITCH:  cam_launch   : gpio=3D0045 flags=3D01=
 type=3D02 keycode=3D00000000
       0096 - 0014:4f06 GPIO SWITCH:  cam_shutter  : gpio=3D006e flags=3D01=
 type=3D00 keycode=3D00000000
       0120 - 0014:4f06 GPIO SWITCH:  cmt_apeslpx  : gpio=3D0046 flags=3D02=
 type=3D02 keycode=3D00000000
       0144 - 0014:4f06 GPIO SWITCH:  cmt_bsi      : gpio=3D009d flags=3D02=
 type=3D02 keycode=3D00000000
       0168 - 0014:4f06 GPIO SWITCH:  cmt_en       : gpio=3D004a flags=3D02=
 type=3D02 keycode=3D00000000
       0192 - 0014:4f06 GPIO SWITCH:  cmt_rst      : gpio=3D004b flags=3D06=
 type=3D02 keycode=3D00000000
       0216 - 0014:4f06 GPIO SWITCH:  cmt_rst_rq   : gpio=3D0049 flags=3D06=
 type=3D02 keycode=3D00000000
       0240 - 0014:4f06 GPIO SWITCH:  cmt_wddis    : gpio=3D000d flags=3D02=
 type=3D02 keycode=3D00000000
       0264 - 0014:4f06 GPIO SWITCH:  headphone    : gpio=3D00b1 flags=3D01=
 type=3D01 keycode=3D00000000
       0288 - 0014:4f06 GPIO SWITCH:  kb_lock      : gpio=3D0071 flags=3D01=
 type=3D00 keycode=3D00000000
       0312 - 0014:4f06 GPIO SWITCH:  proximity    : gpio=3D0059 flags=3D00=
 type=3D00 keycode=3D00000000
       0336 - 0014:4f06 GPIO SWITCH:  sleep_ind    : gpio=3D00a2 flags=3D02=
 type=3D02 keycode=3D00000000
       0360 - 0014:4f06 GPIO SWITCH:  slide        : gpio=3D0047 flags=3D00=
 type=3D00 keycode=3D00000000
       0384 - 0008:4e02 WLAN CX3110X: chip_type=3D25 power_gpio=3D0057 irq_=
gpio=3D002a spi_cs_gpio=3Dffffffff
       0396 - 001c:4f0b PARTITION:    bootloader       : size=3D00020000 of=
fset=3D00000000 mask=3D00000003
       0428 - 001c:4f0b PARTITION:    config           : size=3D00060000 of=
fset=3D00020000 mask=3D00000000
       0460 - 001c:4f0b PARTITION:    log              : size=3D00040000 of=
fset=3D00080000 mask=3D00000000
       0492 - 001c:4f0b PARTITION:    kernel           : size=3D00200000 of=
fset=3D000c0000 mask=3D00000000
       0524 - 001c:4f0b PARTITION:    initfs           : size=3D00200000 of=
fset=3D002c0000 mask=3D00000000
       0556 - 001c:4f0b PARTITION:    rootfs           : size=3D0fb40000 of=
fset=3D004c0000 mask=3D00000000
       0588 - 000c:4f80 BOOTREASON:   pwr_key    =20
       0604 - 0018:4f82 VERSION:      product      =3D RX-51      =20
       0632 - 0018:4f82 VERSION:      hw-build     =3D 2204       =20
       0660 - 0018:4f82 VERSION:      nolo         =3D 1.4.14     =20
       0688 - 0018:4f82 VERSION:      boot-mode    =3D normal     =20

ATAG structure is parsed from file /proc/atags via program
dumpatag: http://www.mesa.nl/~marcel/

I do not know what ATAG CORE is.

ATAG MEM is generated by NOLO and also uboot at runtime. But we
have hardcoded memory values in n900 DT file. Maybe we should use
those generated by uboot bootloader (or reuse uboot code for
generating) instead using hardcoded one?

ATAG REVISION is that which is magically generated by NOLO and
which we want to reuse. Better would be understand how and why it
NOLO generate (maybe there is something secret register which can
tell it?). But I was not able to find out it.

OMAP table is one big ATAG structure which contains lot of other
values. Basically all values (except uart, bootreason and
version) are static and on all n900 devices are same.

Partitions are generated by NOLO from CAL (/dev/mtd1) data, but I
think nobody ever changed them (but it is possible!).

Uart is enabled when serial console is enabled via NOLO.

Bootreason contains omap3 bootreason value from special register
(plus magic from NOLO) which is cleared automatically by NOLO (so
no way to read it from kernel).

Version contains some key-value data. Product is always RX-51,
hw-build is same as ATAG REVISION, nolo is nolo version and value
for boot-mode is ether normal or update.


What we need in userspace:

In file /proc/cpuinfo:
Hardware        : Nokia RX-51 board
Revision        : <hw_revision_number>

And in any file and any format (does not matter if text, binary,
whatever...) we need value from bootreason, boot-mode (and maybe
nolo version).

Current maemo applications are using files /proc/bootreason (for
bootreason) and /proc/component_version (for all version) which
are specific for Nokia 2.6.28 kernel. All those applications
(which reading ether bootreason or bootmode proc files) are
either shell scripts or open source, so editing them is possible.
I will start fixing them once there will be *stable* ABI for
those data.

With non DT (legacy) boot all above atags are present in binary
file /proc/atags.

But because DT boot does not provide /proc/atags file I need some
interface how to read above needed strings.

So I would like to know what is possible and how?

Does kernel provide some interface for telling userspace
applications something like bootreason (e.g power key, software
reset, rtc alarm, charger connected, ...)?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1537603.RdaZp2mVaQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR46/gACgkQi/DJPQPkQ1LWBACglYvUlyNMx3ikNbX63lJZrC6S
6YoAniwfwm/uvzn0P3lR7q/Mu+X0hQp6
=mk1Z
-----END PGP SIGNATURE-----

--nextPart1537603.RdaZp2mVaQ--
