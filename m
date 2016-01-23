From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Sat, 23 Jan 2016 13:57:32 +0100
Message-ID: <201601231357.32629@pali>
References: <201601091616.04193@pali> <3690314.8jDXSUDcRZ@saturn> <20160121192113.GM19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2281494.IVPX8zS8PD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121192113.GM19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart2281494.IVPX8zS8PD
Content-Type: multipart/mixed;
  boundary="Boundary-01=_8i3oWB0Gn3vn1S/"
Content-Transfer-Encoding: 7bit


--Boundary-01=_8i3oWB0Gn3vn1S/
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 21 January 2016 20:21:13 Tony Lindgren wrote:
> * joerg Reisenweber <joerg@openmoko.org> [160121 10:45]:
> > On Thu 21 January 2016 09:41:46 Tony Lindgren wrote:
> > > Then for supporting the USB host mode.. We should add regulator
> > > support to the USB PHY driver so if the ID pin is grounded, the
> > > PHY driver enables the VBUS regulator. That too seems to need
> > > some coordination between the drivers/phy/phy-twl4030-usb.c and
> > > 1707 driver if the ID pin interrupt is only detected in
> > > drivers/phy/phy-twl4030-usb.c.
> >=20
> > Note that, while this is probably a good thing to do, it needs to
> > be sufficiently loose coupling to allow user to 'intercept' this
> > VBOOS regulator enabling and instead allow device charging while
> > in externally powered hostmode. There's even a spec for this in
> > USB-docs-foo iirc, something along a certain resistor value on ID
> > to GND - alas I guess the twl4030 is not capable to detect such
> > sophisticated signaling, and anyway it's always desirable to allow
> > user to manually override the VBOOST and enable VBUS-charging
> > while in hostmode.
>=20
> OK, I think this is what's happening with the Motorola LapDock BTW.
> It always feeds the VBUS, well most of the time. Do you have some
> pointer to the "certain resistor value on ID to GND" spec? Is it
> maybe part of the carkit related parts of the USB spec?
>=20
> > On N900 the situation is even more complex since the 1707 doesn't
> > support genuine ID detection, neither does it support emulated ID
> > grounding. And there's no other method than a ID=3DGND message from
> > PHY to musb core to make the musb core state engine transfer into
> > proper hostmode. Thus my H-E-N hostmode botch abuses debug flags
> > to force the musb core into a "emulated" hostmode and this mode
> > doesn't support USB speed detection. Thus speed settings are
> > forced onto musb core and PHY by software, and the musb core speed
> > bits are only effective before session enabled.
> > Bottom line: you need VBUS to try and negotiate speed with the
> > attached device in hostmode, but to actually set this speed you
> > detected by software means, you need to disable and discharge VBUS
> > again, or musb core won't care about the speed you set. To be
> > utterly clear: unconditional enabling of VBUS in ID=3DGND won't
> > work.
> >=20
> > This is quite complex and it's questionable if it could get handled
> > reasonably in kernel space. *Very* N900 specific niche solution,
> > I'd not think it's suited for upstreaming.
>=20
> Yeah OK. I think we should be able to support the aux VBUS regulator
> part with mainline kernel though.
>=20
> Regards,
>=20
> Tony

Hello, attached patch for musb debugfs adds option to force both=20
hostmode with speed. It is just example, I tested only compilation.

Something like that will be needed for usb host mode on Nokia N900.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--Boundary-01=_8i3oWB0Gn3vn1S/
Content-Type: text/x-patch;
  charset="us-ascii";
  name="0001-musb-debugfs-Add-support-in-testmode-for-forcing-hos.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-musb-debugfs-Add-support-in-testmode-for-forcing-hos.patch"

=46rom fd67b58e3538c0732750ecad915cde736da099dc Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Pali=3D20Roh=3DC3=3DA1r?=3D <pali.rohar@gmail.com>
Date: Sat, 9 Jan 2016 16:57:59 +0100
Subject: [PATCH] musb: debugfs: Add support in testmode for forcing host mo=
de
 together with speed

=2D--
 drivers/usb/musb/musb_debugfs.c |   44 +++++++++++++++++++++++++----------=
=2D---
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugf=
s.c
index 9b22d94..62c13a2 100644
=2D-- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -147,28 +147,34 @@ static int musb_test_mode_show(struct seq_file *s, vo=
id *unused)
=20
 	test =3D musb_readb(musb->mregs, MUSB_TESTMODE);
=20
=2D	if (test & MUSB_TEST_FORCE_HOST)
+	if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS))
+		seq_printf(s, "force host full-speed\n");
+
+	else if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS))
+		seq_printf(s, "force host high-speed\n");
+
+	else if (test & MUSB_TEST_FORCE_HOST)
 		seq_printf(s, "force host\n");
=20
=2D	if (test & MUSB_TEST_FIFO_ACCESS)
+	else if (test & MUSB_TEST_FIFO_ACCESS)
 		seq_printf(s, "fifo access\n");
=20
=2D	if (test & MUSB_TEST_FORCE_FS)
+	else if (test & MUSB_TEST_FORCE_FS)
 		seq_printf(s, "force full-speed\n");
=20
=2D	if (test & MUSB_TEST_FORCE_HS)
+	else if (test & MUSB_TEST_FORCE_HS)
 		seq_printf(s, "force high-speed\n");
=20
=2D	if (test & MUSB_TEST_PACKET)
+	else if (test & MUSB_TEST_PACKET)
 		seq_printf(s, "test packet\n");
=20
=2D	if (test & MUSB_TEST_K)
+	else if (test & MUSB_TEST_K)
 		seq_printf(s, "test K\n");
=20
=2D	if (test & MUSB_TEST_J)
+	else if (test & MUSB_TEST_J)
 		seq_printf(s, "test J\n");
=20
=2D	if (test & MUSB_TEST_SE0_NAK)
+	else if (test & MUSB_TEST_SE0_NAK)
 		seq_printf(s, "test SE0 NAK\n");
=20
 	return 0;
@@ -206,30 +212,36 @@ static ssize_t musb_test_mode_write(struct file *file,
 	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
=20
=2D	if (strstarts(buf, "force host"))
+	if (strstarts(buf, "force host full-speed"))
+		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
+
+	else if (strstarts(buf, "force host high-speed"))
+		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS;
+
+	else if (strstarts(buf, "force host"))
 		test =3D MUSB_TEST_FORCE_HOST;
=20
=2D	if (strstarts(buf, "fifo access"))
+	else if (strstarts(buf, "fifo access"))
 		test =3D MUSB_TEST_FIFO_ACCESS;
=20
=2D	if (strstarts(buf, "force full-speed"))
+	else if (strstarts(buf, "force full-speed"))
 		test =3D MUSB_TEST_FORCE_FS;
=20
=2D	if (strstarts(buf, "force high-speed"))
+	else if (strstarts(buf, "force high-speed"))
 		test =3D MUSB_TEST_FORCE_HS;
=20
=2D	if (strstarts(buf, "test packet")) {
+	else if (strstarts(buf, "test packet")) {
 		test =3D MUSB_TEST_PACKET;
 		musb_load_testpacket(musb);
 	}
=20
=2D	if (strstarts(buf, "test K"))
+	else if (strstarts(buf, "test K"))
 		test =3D MUSB_TEST_K;
=20
=2D	if (strstarts(buf, "test J"))
+	else if (strstarts(buf, "test J"))
 		test =3D MUSB_TEST_J;
=20
=2D	if (strstarts(buf, "test SE0 NAK"))
+	else if (strstarts(buf, "test SE0 NAK"))
 		test =3D MUSB_TEST_SE0_NAK;
=20
 	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
=2D-=20
1.7.9.5


--Boundary-01=_8i3oWB0Gn3vn1S/--

--nextPart2281494.IVPX8zS8PD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlajeLwACgkQi/DJPQPkQ1LoYACfULTLMNg0bHtq2CC0z7FuBPXa
tPIAn3nLa2BF04MIBSRi6F+eKv99qQrV
=t5b7
-----END PGP SIGNATURE-----

--nextPart2281494.IVPX8zS8PD--
