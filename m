From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Wed, 18 Jan 2017 22:55:49 +0100
Message-ID: <20170118215549.GA25865@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
 <20170116211540.GA19736@amd> <20170118204459.GA5622@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5747860993221808956=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170118204459.GA5622@amd>
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


--===============5747860993221808956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > So regression seems to be between v4.9 and v4.10. Any ideas?
> > >=20
> > > Interesting... seems there are no sound relevant changes after v4.9.
> > >=20
> > > Looks like there are only three commits after v4.9 for sound/soc whic=
h=20
> > > are built for Nokia N900:
> ...
> > Its definitely caused by something merged here:
> >=20
> > commit ce38207f161513ee3d2bd3860489f07ebe65bc78
> > Merge: a9042de 995c6a7
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Dec 14 11:14:28 2016 -0800
> >=20
> > So it should be easy to find out..
>=20
> Doing git bisect now. Hmmm.
>=20
> pavel@amd:/data/l/linux-n900$ git bisect bad
> 1a653aa44725668590b36bbe2d7fe4736a69f055 is the first bad commit
> commit 1a653aa44725668590b36bbe2d7fe4736a69f055
> Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Date:   Wed Nov 30 06:22:55 2016 +0000
>=20
>     ASoC: core: replace aux_comp_list to component_dev_list
>=20
>     Now, Card has component_dev_list, we can replace aux_comp_list
>         to component_dev_list with new auxiliary flags
>=20
>     Signed-off-by: Kuninori Morimoto
>     <kuninori.morimoto.gx@renesas.com>
>         Signed-off-by: Mark Brown <broonie@kernel.org>
>=20
> :040000 040000 a571fa05e5ce8e00b73bbc3f1e30e26775d619e8
> e9336929cacf2d7bc94da99acfc10c9a7f513b8b M	include
> :040000 040000 87976e9406d452e791870cc12e27cb67ba04fd12
> 60d36f685642621c0e3ebb61ba7a14186d8b3eb0 M	sound
> pavel@amd:/data/l/linux-n900$
>=20
> I'll try reverting this patch on top of 4.10-rc, next. Any other ideas?

Reverting that fixed the issue, but when I re-checked current -rc4, it
seems it has similar fix there, too. GOod.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh/5GUACgkQMOfwapXb+vIakACeO4Ufp9/2Z/YrKlUMJNxV8MOi
Q+MAoMKxBCtBUBYG6h5PgJKWHNdIs9j1
=inZ8
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


--===============5747860993221808956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5747860993221808956==--
