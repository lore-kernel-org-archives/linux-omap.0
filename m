From: Felipe Balbi <balbi@ti.com>
Subject: Re: v3.19: Nokia N900 - usb nokia gadget crash
Date: Mon, 2 Feb 2015 16:27:27 -0600
Message-ID: <20150202222727.GC30753@saruman.tx.rr.com>
References: <201501311006.11909@pali>
 <201501311025.09553@pali>
 <20150202221713.GB30753@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150202221713.GB30753@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 04:17:13PM -0600, Felipe Balbi wrote:
> On Sat, Jan 31, 2015 at 10:25:09AM +0100, Pali Roh=E1r wrote:
> > On Saturday 31 January 2015 10:06:11 Pali Roh=E1r wrote:
> > > Hello,
> > >=20
> > > when I try to modprobe g_nokia.ko gadget module on n900
> > > device, it produce tons on lines to display and then crash
> > > and reboot device. So its not working and I (without Nokia
> > > (TM) serial console I cannot debug it).
> >=20
> > When I compile g_nokia into zImage (not as external module) then=20
> > it kernel loads correctly and usb is working.
> >=20
> > Any idea why g_nokia as external kernel module cause problems,=20
> > but compiled into zImage is working??
>=20
> what I got here is a WARNING from f_phonet only, I'll look into it. Keep
> in mind I don't have N900 available, testing with beagleboneblack and
> AM437x SK.

looks like there's a bug with MUSB too which needs fixing for that. Did
you get "inconsistent lock stae" WARN ?

--=20
balbi

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz/nPAAoJEIaOsuA1yqREkQMP/3EcNhUSvnTcEOTeX+ZW0kM7
ycCOydqV3QLHB2ANNO+KDFlF0goi0ELP9c06fqwOXCb8H8vpeV2HAhu8n8CvOuRJ
F2gY7aWzphbTj7g+Ez3y+bJdvdAWciVPyfno9m0RcwK/TVEUHJPE01+4SrcwbuHz
YPrb6TWsHXGQfQMPQCKPwwX1LjxIKalPJpxrOrMMALkxQsuWeDImbNJKCpVq2Vfe
DTRzYUyOUhVodCDJKAExL/e+JGVYCd5MS6MHi3lVsOzVjJ9ueo06njb0JF9rNBC7
ONKWL7WiJTlAWnVteOm+3Bo5RCa+PVYY6w7lXx0dgOjq2cgQYuk4SbI7/dk6cxqP
0PpyDXmmQ2FMTIbiNKuL+IBX8HDihpBzwXGuA0D3AVcpa+zYGpgVL6fpid10Ul/W
CCs6kg4xLHv5bpO6EyMhdq5TqtO6ePHFBYyHwdtPJvGPRnp7+jw2+RnaSjbLz/Rm
zPfHHM4efWIf0PHjxPu0t9IQYKb5O9yCfRE0f2iDicSeD726wb30I4tVegdJe8xM
jQuVcIL1ZmjH1xVE4LzI0pW/OfEhbFaihlEI0CBvlEYSmNlqRH4OtIyGuoNZ59ZO
gCnMZgG6Q59NfBuijqSMHiTKXgS3ctIOQzNHwvsrO9EVyVB+hwt6hmIgrqtkOUo4
1RoNpR1l0nK2FCPpjAD3
=dBb5
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
