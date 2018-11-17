From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 0/6] omapdrm: DSI command mode panel support
Date: Sat, 17 Nov 2018 22:00:54 +0100
Message-ID: <20181117210054.GA22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0709162100=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181115230645.15748-1-sebastian.reichel@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0709162100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's time for a new revision of the DSI command mode panel
> patchset. The patches have been rebased to 4.20-rc1 + fixes
> from Laurent and Tony. I dropped the patches for OMAP3 support
> (it needs a workaround for a hardware bug) and for automatic
> display rotation. They should get their own series, once this
> patchset has landed.

Thanks for doing this!

Tested-by: Pavel Machek <pavel@ucw.cz>

Tested console and X on Droid 4, after hacking in some kind of
backlight support. Works as expected :-).

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwgYYACgkQMOfwapXb+vI/9gCfXI/qWwcefzut74d572WGWUhM
1ZwAn1OieVrDvMYPyuWuuXFSbBVp7Dgu
=fr35
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--===============0709162100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0709162100==--
