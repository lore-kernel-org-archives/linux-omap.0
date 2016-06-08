From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 8 Jun 2016 12:19:52 +0200
Message-ID: <201606081219.52718@pali>
References: <201601091616.04193@pali> <20160608095321.GH22406@atomide.com> <87h9d49exz.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2329848.HyLNZrtp1J";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h9d49exz.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart2329848.HyLNZrtp1J
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 June 2016 12:02:00 Felipe Balbi wrote:
> Hi,
>=20
> Tony Lindgren <tony@atomide.com> writes:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160607 05:53]:
> >> > Tony, what do you think about that patch?
> >>=20
> >> Tony, PING
> >=20
> > Yeah I don't know, AFAIK we don't have a generic way to
> > force MUSB to change mode without ID pin. If you have figured
> > something generic for that which does not actually tinker with
> > the PHY registers directly, that should be the generic
> > musb_set_mode() that we've been wondering about for years.
>=20
> #define MUSB_TEST_FORCE_HOST	0x80
>=20
> Can someone confirm on MUSB's docs (and actual running system) that
> this does what's supposed to do?

Maybe this can help you:

https://garage.maemo.org/plugins/ggit/browse.php/?p=3Dkernel-power;a=3Dblob=
;f=3Dkernel-power-2.6.28/debian/patches/usbhostmode.diff

Patch for 2.6.28 omap1 kernel which adds usb host mode support for Nokia
N900. Look for MUSB_TESTMODE, MUSB_TEST_FORCE_HOST is called together
with MUSB_TEST_FORCE_FS or MUSB_TEST_FORCE_HS (line 355).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2329848.HyLNZrtp1J
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldX8UgACgkQi/DJPQPkQ1LJfQCfcds/8c4RcEKr6XMisF84K4dn
SzgAn0XB8WMzjmDjlUFG03uzilJlj51F
=VSXP
-----END PGP SIGNATURE-----

--nextPart2329848.HyLNZrtp1J--
