From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/7] Implement generic ASoC HDMI codec and use it in
 tda998x
Date: Wed, 13 Apr 2016 08:02:19 +0100
Message-ID: <20160413070219.GN14664@sirena.org.uk>
References: <cover.1459431292.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1836060557=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1459431292.git.jsarha@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1836060557==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Content-Disposition: inline


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 04:35:57PM +0300, Jyri Sarha wrote:
> Couple of minor changes since v8 to ALSA/ASoC side patches. The series
> is based on top of drm-next. However, it does not look like there is
> enough attention to the DRM side so that the tda998x patches would get
> in any time soon. So I am happy to rebase the first ALSA-side patches
> on top of Mark Brown's for-next tree, for instance, if they would have
> a change to go in on their own. The first two IEC958 helper patches
> should apply as such.

None of the ASoC specific patches here have had any review from other
HDMI users?

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDe76AAoJECTWi3JdVIfQPmkH/2/oOmnlDUI14ubV5N1ZZXf4
M877A3pLYCM5KZJa2WRjqx8rEx/1Spj+KAjl8Ey8uRmB7Xx+U6xQlZ0gbULzCSau
lNJ4mS+JmMAv/74Q1xn8BHsdMS1OcBIYiSksoL32FoVdICKGoQ4M0VfmNsAAbn4v
rbA4s8d7zxUk9Uyon4yWrJc+Me1jX6WHUaLgoaDLgkNLcIz2sqGid2bebnpzP4lO
69zlipQ8LaD6zbmyMb7CEp+H4u8ZD+InHpDSeI4MfE4WDCzRsiwiIEv54buMnD8q
zYj6Rc1RUgrSL/hp7ZbjSRyQ+VnuQhwrdp99S5gCdy8L3mtas4Jv7+KCy2XzOrw=
=OYk6
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--

--===============1836060557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1836060557==--
