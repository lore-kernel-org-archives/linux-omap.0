From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Mon, 16 Jan 2017 22:15:40 +0100
Message-ID: <20170116211540.GA19736@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9120700038024804075=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201701150100.54214@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: alsa-devel@alsa-project.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, broonie@kernel.org, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, lars@metafoo.de, abcloriens@gmail.com, jarkko.nikula@bitmer.com, helen.koike@collabora.co.uk, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============9120700038024804075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So regression seems to be between v4.9 and v4.10. Any ideas?
>=20
> Interesting... seems there are no sound relevant changes after v4.9.
>=20
> Looks like there are only three commits after v4.9 for sound/soc which=20
> are built for Nokia N900:

I'm at ce38207f161513ee3d2bd3860489f07ebe65bc78, which is already
broken, and first broken commit by Linus.

> e411b0b5eb9b65257a050eac333d181d6e00e2c6

Can't revert that easily.

> e7aa450fe17890e59db7d3c2d8eff5b6b41fc531

This can be reverted. Lets try. Did not help.

> 63c3194b82530bd71fd49db84eb7ab656b8d404a

Commit older than this one fails, IIRC.

> Maybe something not related to sound/soc could broke it?

Its definitely caused by something merged here:

commit ce38207f161513ee3d2bd3860489f07ebe65bc78
Merge: a9042de 995c6a7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 14 11:14:28 2016 -0800

So it should be easy to find out..

Best regards,
								Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh9N/wACgkQMOfwapXb+vJAUACfbq/nc6K36X+P02au3HEWCRlg
KvEAoMMueNr3a3PBwkjmbAxlGUb9TZlZ
=tfq4
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


--===============9120700038024804075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9120700038024804075==--
