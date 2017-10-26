From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 18:28:07 +0200
Message-ID: <20171026162807.GA20639@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026120130.dicanunwcdmjntnb@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Glad you got it working :) For backlight you can add this
> > > in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:
> > >=20
> > > add the following code at the end of dsicm_probe:
> >=20
> > You did not actually include code to paste into panel-dsi-cm, can you
> > try a again?
>=20
> I added it directly below and you quoted it. I guess you mistook it
> for a signature or something :)

Ahha. Two semicolons confused me, and I thought you were talking about
two different files. My fault. Let me try...

And.. If I catch the bus, I should be at cca 20:15 at the Hilton. We
can meet at the seats where we were hacking...?

									Pavel
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnyDRcACgkQMOfwapXb+vKPKQCdFlr45V5JcUeMhjB8p7EaDeon
0GQAoJcNgBp2tf2EjVQ1GOgPSj9VICtc
=ot4x
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
