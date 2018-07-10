From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCHv2 1/9] drm: Add support for extracting sync signal
 drive edge from videomode
Date: Tue, 10 Jul 2018 15:55:55 +0200
Message-ID: <20180710135555.GB13242@ulmo>
References: <20180618132242.8673-1-tomi.valkeinen@ti.com>
 <20180618132242.8673-2-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0100840888=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180618132242.8673-2-tomi.valkeinen@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============0100840888==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:22:34PM +0300, Tomi Valkeinen wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> The sync in some panels needs to be driven by different edge of the pixel
> clock compared to data. This is reflected by the
> DISPLAY_FLAGS_SYNC_(POS|NEG)EDGE in videmode flags.
> Add similar similar definitions for bus_flags and convert the sync drive
> edge via drm_bus_flags_from_videomode().
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/gpu/drm/drm_modes.c | 15 +++++++++++----
>  include/drm/drm_connector.h |  4 ++++
>  2 files changed, 15 insertions(+), 4 deletions(-)

Also applied this as a dependency for patch 7/9. How do you want to deal
with the remaining patches?

Thierry

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEuucACgkQ3SOs138+
s6FK8g//aDQHoGzsWvxgjrlbDKZQMVTuqZbxaIM3Iy84V5F1RhhFR2p1uNIkfiYq
Py2K75WdjBViv6rOelfNMnsnglmTJrb9XEEtu+APtlA/BRAN9911uBjm+JitjPAK
0aYajOCUXjaD3SN+Cx1n2d5xCE0FOEtjWu6qa/6FMM0b5mLDDy5BHsub47bQR3qQ
ZtQx8OP4xF0uEvLUtdDrtmTJRF9KyjzzoHtY8ZK7FKISIHno0Go7ojsYthviC6ul
m+LpscGxGZGfVkv2YD2NDhubPfK5ARE4x7tViVbeQUkk/J9OmK4rZtuE66i/6pnP
qTBE864vcTDUKiZGcjw7lFb/8i+vriibRexErMYeZKDL4R6MXlqNNHoMZVfXg0BA
q+ze3t7uE1S5oMIfau5H2SSAlJV9rukEE/YMlLrxGPLwbgcLVjqs7Ka5NJsTrWTw
yQswuXHFefbwcww31c5RhGwsQ0gLFErYTfdsZ93+lwcP4Lm09/eI+5ayEsZ3yBgW
n0XaiHaYsSaj7fX+fGEJ2raYTT8OasjKPzdY5gaT+J81qdXKPC9GYtStJEl/qDpO
593PJyYEuyeG0OY1E+Jgh3K7Apwn3N9s8OJOPmON981K8UefABas4nVmSZrD8RpX
UED8vfh5pyrlkZcs6tooocmgLyWY/TKBO9RKeE+wZSMomSWM650=
=KYlW
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============0100840888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0100840888==--
