From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 2/6] drm/omap: populate DSI platform bus earlier
Date: Sat, 17 Nov 2018 22:02:05 +0100
Message-ID: <20181117210205.GC22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-3-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324252569=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181115230645.15748-3-sebastian.reichel@collabora.com>
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


--===============0324252569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-16 00:06:41, Sebastian Reichel wrote:
> After the changes from 4.20 the DSI encoder tries to find the
> attached panel before populating the DSI bus. If the panel is
> not found -EPROBE_DEFER is returned, so the DSI bus is never
> populated and the panel never added.
>=20
> Fix this by populating the DSI bus before searching for the
> video sink in dsi_init_output().
>=20
> Fixes: 27d624527d992 ("drm/omap: dss: Acquire next dssdev at probe time")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwgc0ACgkQMOfwapXb+vI/6ACfdWLaip+Otti0kU6I5xv7Ce/m
uUEAoJYYKSgmnPdUswr6KWLnxvBVjFX0
=BfgV
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

--===============0324252569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0324252569==--
