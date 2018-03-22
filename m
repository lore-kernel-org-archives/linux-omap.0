From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.16-rc5 on droid4: external abort in
 l2c310_configure+0x38/0x160
Date: Thu, 22 Mar 2018 13:19:06 +0100
Message-ID: <20180322121906.GC12518@amd>
References: <20180322120359.GA12518@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322120359.GA12518@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-03-22 13:03:59, Pavel Machek wrote:
> Hi!
>=20
> I'm trying to get something to work on Droid 4.
>=20
> So far, v4.14 from leste project works, with the right config. I tried
> v4.16-rc5 next, and am stopped in early boot by:
>=20
> If someone knows what this is let me know, but I guess it is
> config-dependend and I'll just try different one...

With different config it works, I just get storm of

^@^=EF=BF=BD=EF=BF=BDr=EF=BF=BD=C2=82=EF=BF=BD=C2=AA=EF=BF=BD=EF=BF=BDmusb-=
hdrc musb-hdrc.1.auto: VBUS Disconnect

[   39.985656] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80

^@^=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDmusb-hdrc musb-hdrc.1.auto: VBUS Disconnect

[   40.005645] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80

^@^=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDmusb-hdrc musb-hdrc.1.auto: VBUS Disconnect

[   40.035766] musb-hdrc musb-hdrc.1.auto: VBUS b_idle, devctl 80



Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqznzoACgkQMOfwapXb+vLBRACgoFMU19vKRQ6phfuyyo/ZlVja
j3gAoMHXITiGNyx5vVAknM9QWOzswTEs
=6TUp
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
