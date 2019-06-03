From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Mon, 3 Jun 2019 10:29:45 +0200
Message-ID: <20190603082945.GA29122@amd>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0490525170=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190527112122.GJ5447@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel@collabora.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0490525170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Here is another round of the DSI command mode panel patchset
> > > integrating the feedback from PATCHv5. The patches are based
> > > on v5.2-rc1 tag. It does not contain the patches required for
> > > OMAP3 support (it needs a workaround for a hardware bug) and
> > > for automatic display rotation. They should get their own series,
> > > once after everything has been moved to DRM panel API. I think
> > > DRM panel conversion should happen _after_ this series, since
> > > otherwise there is a high risk of bricking DSI support completely.
> > > I already started a WIP branch for converting DSI to the DRM panel
> > > API on top of this patchset.
> >=20
> > Looks good to me. For some reason I can't boot 5.2-rc2 (on x15) so I ha=
ven't
> > been able to test yet. I'll pick the series up in any case, and I'll te=
st it
> > when I get the kernel booting.
>=20
> Great good to have these merged finally :)
>=20
> Hmm I wonder if some x15 models are affected by the SoC variant
> changes queued in my fixes branch?

I still don't see the patches in next-20190603 . Are they expected to
be there, or should I use different tree?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz02nkACgkQMOfwapXb+vJNjwCgxBzU0XaaaAImhYPAPGMUURue
jMUAoJpDkOfXt+oO5pGBCMG6SHJyy49H
=nupB
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============0490525170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0490525170==--
