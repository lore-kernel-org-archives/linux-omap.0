From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv6 4/4] drm/omap: add support for manually updated displays
Date: Wed, 22 May 2019 20:21:52 +0200
Message-ID: <20190522182152.GA10003@amd>
References: <20190403195413.djfrgzuj7povdksi@earth.universe>
 <20190403201326.3127-1-sebastian.reichel@collabora.com>
 <20190403201326.3127-5-sebastian.reichel@collabora.com>
 <20190404001109.GZ49658@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404001109.GZ49658@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-03 17:11:09, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.com> [190403 20:14]:
> > This adds the required infrastructure for manually updated displays,
> > such as DSI command mode panels. While those panels often support
> > partial updates we currently always do a full refresh.
> >=20
> > The display will be refreshed when something calls the dirty callback,
> > such as libdrm's drmModeDirtyFB(). This is currently being done at least
> > by the kernel console and Xorg (with modesetting driver) in their
> > default configuration. Weston does not implement this and the fbdev
> > backend does not work (display will not update). Weston's DRM backend
> > uses double buffering and the page flip will also trigger a display
> > refresh.
>=20
> I've tested this with Linux next and the latest lm3532
> patches and it works fine as long as we leave out the
> backlight =3D <&lcd_backlight> entry from dts like I
> replied in the lm3532 tread. So as far as I'm concerned,
> we're good to go:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

I've tested this on 5.2-rc1, and it is still neccessary, still needed,
and still not merged.

How can I help? Can the patches simply be picked up for drm tree?

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzlk0AACgkQMOfwapXb+vJXQQCfQd2JMKV5aE0IX8qcHplWoUFq
tQsAn2FpwuQw/t+w9mpUiAiZ/CP53ppT
=FNwu
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
