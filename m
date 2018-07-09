From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Tue, 10 Jul 2018 00:02:11 +0200
Message-ID: <20180709220211.GA7760@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709214910.tes6u4ivxomd3aja@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do you have vibrations on d4 working?
> > I believe I have required drivers enabled, but no luck:
> >=20
> > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > bind  uevent  unbind
> > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > bind  uevent  unbind
>=20
> Have you checked probe deferrals?

Not really. Is there easier way to do that than adding printks in the
probe function? (I can go through dmesg tommorow).

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltD22MACgkQMOfwapXb+vIGtACcDpWKMT4p4owpY2vRFRB482Fe
4doAn0TPYEnpjkZSpN/FjfaIzcY9YOzQ
=FGF2
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
