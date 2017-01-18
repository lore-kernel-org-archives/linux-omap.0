From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Wed, 18 Jan 2017 21:44:59 +0100
Message-ID: <20170118204459.GA5622@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170116211540.GA19736@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2665983654667026390=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170116211540.GA19736@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, broonie@kernel.org, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, lars@metafoo.de, abcloriens@gmail.com, jarkko.nikula@bitmer.com, helen.koike@collabora.co.uk, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============2665983654667026390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So regression seems to be between v4.9 and v4.10. Any ideas?
> >=20
> > Interesting... seems there are no sound relevant changes after v4.9.
> >=20
> > Looks like there are only three commits after v4.9 for sound/soc which=
=20
> > are built for Nokia N900:
=2E..
> Its definitely caused by something merged here:
>=20
> commit ce38207f161513ee3d2bd3860489f07ebe65bc78
> Merge: a9042de 995c6a7
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Dec 14 11:14:28 2016 -0800
>=20
> So it should be easy to find out..

Doing git bisect now. Hmmm.

pavel@amd:/data/l/linux-n900$ git bisect bad
1a653aa44725668590b36bbe2d7fe4736a69f055 is the first bad commit
commit 1a653aa44725668590b36bbe2d7fe4736a69f055
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Wed Nov 30 06:22:55 2016 +0000

    ASoC: core: replace aux_comp_list to component_dev_list

    Now, Card has component_dev_list, we can replace aux_comp_list
        to component_dev_list with new auxiliary flags

    Signed-off-by: Kuninori Morimoto
    <kuninori.morimoto.gx@renesas.com>
        Signed-off-by: Mark Brown <broonie@kernel.org>

:040000 040000 a571fa05e5ce8e00b73bbc3f1e30e26775d619e8
e9336929cacf2d7bc94da99acfc10c9a7f513b8b M	include
:040000 040000 87976e9406d452e791870cc12e27cb67ba04fd12
60d36f685642621c0e3ebb61ba7a14186d8b3eb0 M	sound
pavel@amd:/data/l/linux-n900$

I'll try reverting this patch on top of 4.10-rc, next. Any other ideas?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh/08sACgkQMOfwapXb+vLzlACfWMQo2Aio2Co5C8wb2G8XFAIY
YbkAn2mdZVLaCxfptoTU3ZFr6eFm1W7z
=3oyu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


--===============2665983654667026390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2665983654667026390==--
