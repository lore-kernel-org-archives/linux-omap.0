From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 11:29:29 +0100
Message-ID: <2300247.VhtcKLq8UC@saturn>
References: <201601091616.04193@pali> <20160119203314.GE19432@atomide.com> <20160121084007.GN7192@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2797680.kLfJyEMsdb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121084007.GN7192@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org


--nextPart2797680.kLfJyEMsdb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thu 21 January 2016 09:40:07 Pali Roh=E1r wrote:
> On Tuesday 19 January 2016 12:33:15 Tony Lindgren wrote:
> > Hi,
> >=20
> > * Pali Roh=E1r <pali.rohar@gmail.com> [160109 07:16]:
> > > Hello,
> > >=20
> > > when I boot 4.4.0-rc7+ kernel compiled with g_nokia into zImage o=
n Nokia
> > > N900 into userspace then usb gadget (g_nokia) does not work. Note=
book,
> > > connected on other side does not see any usb device... Connecting=
 and
> > > disconnecting cable does not change anything, still not work.
> > >=20
> > > But if I run this command
> > > $ echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/mo=
de
> > >=20
> > >=20
> > > then gadget starts working. Other side see usb device and can use=
 it.
> > > Also connecting and disconnecting usb cable working fine. After
> > > connecting it again, usb device OK.
> >=20
> > N900 had the PHY interrupt wired to the bq chip instead of twl4030,=
 right?

which interrupt? I'll try to answer based on assumptions: 1707 PHY conn=
ects to=20
bq24150 charger via CHRG_DET signal.
I guess you're talking about the VBUS detection which is done in twl403=
0 VBUS-
pin R8.

>=20
> I do not know now. I tried to find it in N900 schemantics, but do not=

> see it.
>=20
> CCing Joerg, do you know?
>=20
> > You can fix this issue similar to phy-twl4030-usb.c. In function
> > twl4030_phy_power_on() we call schedule_delayed_work() that checks
> > the state of the ID pin on boot up.
>=20
> I looked at that code, but do not see what and how can be fixed :-(
>=20
> > I think that's only needed for the i2c based PHY's with MUSB, with
> > the others the USB driver has a better idea of the current state.
> >=20
> > Regards,
> >=20
> > Tony


N900 PHY (1707) is connected to musb core via ULPI=20
(https://www.mentor.com/products/ip/usb/usb20otg/phy_interfaces), it ha=
s no=20
I2C interface and no other IRQ than what's implemented in (normally pow=
ered-
down?) ULPI already.
I guess the problem in this case is along the USB VBUS and ID pin A/B O=
TG=20
detection: the USB jack's ID pin is _not_ connected to the PHY in N900 =
but=20
rather is connected to TWL4030 aka GAIA ID pin R11 which afaik is part =
of the=20
otherwise unused (except VBUS detection?) PHY in TWL4030.=20
It seems to me the actually used PHY 1707 does not support ID, neither =
does it=20
support a dedicated IRQ line for VBUS.

Generally musb-core and buses should be suspended/off by default, for e=
nergy=20
conservation reasons (seemingly ~40mA on Vbatt!), and only get enabled =
when=20
twl4030 detects +5V on VBUS (also before my hostmode botch tries to tal=
k to=20
the musb core debug registers which needs to happen before VBUS gets ap=
plied)

cheers
jOERG
=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart2797680.kLfJyEMsdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlagsxEACgkQ7Xtwhpk1UgwRpgCdHZoIoATnYAd/NOS4hdrSvtLi
JuoAn0Hrmc8YfxqKGnJXMAqlguRr9oR9
=8Z0+
-----END PGP SIGNATURE-----

--nextPart2797680.kLfJyEMsdb--
