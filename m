From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Fri, 20 Sep 2013 00:30:36 +0200
Message-ID: <201309200030.36606@pali>
References: <201302171616.50152@pali> <201309181800.10486@pali> <20130918174211.GU9994@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1913957.UXcQHdPmhg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130918174211.GU9994@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1913957.UXcQHdPmhg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 September 2013 19:42:12 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 09:08]:
> > On Wednesday 18 September 2013 15:16:44 Pavel Machek wrote:
> > > On Sun 2013-09-08 02:02:52, Aaro Koskinen wrote:
> > > > Hi,
> > > >=20
> > > > On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=C3=A1r=20
wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm/mach-omap2/board-rx51-camera.c
> > > >=20
> > > > [...]
> > > >=20
> > > > > Ping, can you review this patch v2?
> > > >=20
> > > > I don't think Tony will accept any new board stuff for
> > > > RX-51/N900. See for example:
> > > > http://marc.info/?l=3Dlinux-kernel&m=3D137629626213187&w=3D2
> > > >=20
> > > > There should be initial Nokia N900 DTS file in 3.12-rc1,
> > > > and we should continue converting this board fully to
> > > > DT.
> > >=20
> > > That's not reasonable. N900 is pretty far away from
> > > working with device tree. Yes, I was able to get some
> > > bits merged, but that should not be excuse to halt other
> > > N900 development.
> > >=20
> > > 									Pavel
> >=20
> > Right. So Tony, will you accept future patches for board
> > files?
>=20
> Only fixes to board-*.c files please unless there's a _really_
> good reason to make things more complex with the platform
> data. Let's not make the DT conversion any more complex than
> it already is.
>=20
> Getting things working with DT for the devices is pretty
> trivial in most cases. And we can also still initialize the
> legacy devices using platform data the same way as earlier.
>=20
> Regards,
>=20
> Tony

So, what to this with this patch v2 (it was sent 06.03.2013)?
It adding board support for ADP1653 flash torch which is part of=20
rx51 camera code. Driver itself is already in kernel tree.
Can you comment/review this patch?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1913957.UXcQHdPmhg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI7ewwACgkQi/DJPQPkQ1KZFQCdF+ViNJED0rKazmWMma3/9njl
460Anir8BP0ic13HPOJuFmVTa4mvIv6e
=siwo
-----END PGP SIGNATURE-----

--nextPart1913957.UXcQHdPmhg--
