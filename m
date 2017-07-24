From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: add soundcard
Date: Mon, 24 Jul 2017 21:19:54 +0200
Message-ID: <20170724191954.GC32425@amd>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-4-sebastian.reichel@collabora.co.uk>
 <20170710122602.srdzonm3s6gcqhnf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6879533132275166700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170710122602.srdzonm3s6gcqhnf@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============6879533132275166700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-10 13:26:02, Mark Brown wrote:
> On Fri, Jul 07, 2017 at 06:42:29PM +0200, Sebastian Reichel wrote:
>=20
> > +	soundcard {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "Droid 4 Audio";
>=20
> New systems should be using the of-graph card which is more flexible and
> extensible than simple-card.

Well, if simple-card does what is needed here, and dts looks
reasonable, is there reason for anything more complex?

Anyway, congratulations for getting the sound to work!

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2SFoACgkQMOfwapXb+vIQvQCdGrQmZGK4DmTCF4ww/qkVwiJU
2kkAoIaxX98+vWU9C/gLE1FX5YWndFg0
=f1xv
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--

--===============6879533132275166700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6879533132275166700==--
