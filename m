From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Wed, 18 Sep 2013 18:00:10 +0200
Message-ID: <201309181800.10486@pali>
References: <201302171616.50152@pali> <20130907230252.GA10700@blackmetal.musicnaut.iki.fi> <20130918131644.GA2953@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1859771.ydYO4886rX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130918131644.GA2953@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1859771.ydYO4886rX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 September 2013 15:16:44 Pavel Machek wrote:
> On Sun 2013-09-08 02:02:52, Aaro Koskinen wrote:
> > Hi,
> >=20
> > On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=C3=A1r wrote:
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-omap2/board-rx51-camera.c
> >=20
> > [...]
> >=20
> > > Ping, can you review this patch v2?
> >=20
> > I don't think Tony will accept any new board stuff for
> > RX-51/N900. See for example:
> > http://marc.info/?l=3Dlinux-kernel&m=3D137629626213187&w=3D2
> >=20
> > There should be initial Nokia N900 DTS file in 3.12-rc1, and
> > we should continue converting this board fully to DT.
>=20
> That's not reasonable. N900 is pretty far away from working
> with device tree. Yes, I was able to get some bits merged,
> but that should not be excuse to halt other N900 development.
> 									Pavel

Right. So Tony, will you accept future patches for board files?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1859771.ydYO4886rX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI5zgoACgkQi/DJPQPkQ1Lq9ACeLMmRTKno+B3H7GgIdfBp7mck
nuoAoMe62pNUEO9GUu3bMCb3MnmDvn9q
=t9qH
-----END PGP SIGNATURE-----

--nextPart1859771.ydYO4886rX--
