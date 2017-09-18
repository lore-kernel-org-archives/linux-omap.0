From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux-next broken for 2 weeks was Re: n900 in next-20170901
Date: Tue, 19 Sep 2017 00:16:37 +0200
Message-ID: <20170918221637.GA7537@amd>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170915131817.GA19486@amd>
 <20170918020126.GA19200@js1304-P5Q-DELUXE>
 <20170918081109.GA11661@amd>
 <20170919080000.59a79ba2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170919080000.59a79ba2@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-09-19 08:00:10, Stephen Rothwell wrote:
> Hi Pavel,
>=20
> On Mon, 18 Sep 2017 10:11:09 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Unfortunately, rest of the world can reproduce the error, and it means
> > linux-next is useless for us.
> >=20
> > I'd expect you to drop the relevant tree from linux-next when the
> > error was reported. Clearly, those patches are unsuitable for 4.15, as
> > they are broken, so they should not be in linux-next.
>=20
> Andrew has asked me to drop the patches from linux-next today and I
> have done so.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnARcUACgkQMOfwapXb+vLFEwCcCmBIA/KufRYLZwLzcBwX+FR/
AJ8AnRTloSEbC5v0QsOOTOBOEsDylK/M
=EvxH
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
